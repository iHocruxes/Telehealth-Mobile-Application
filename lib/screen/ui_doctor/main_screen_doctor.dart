import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/components/drawer_menu.dart';
import 'package:healthline/screen/ui_doctor/account_setting/account_setting_doctor_screen.dart';
import 'package:healthline/screen/ui_doctor/application_setting/application_setting_screen.dart';
import 'package:healthline/screen/ui_doctor/helps/helps_screen.dart';
import 'package:healthline/screen/ui_doctor/overview/overview_screen.dart';
import 'package:healthline/screen/ui_doctor/patient/patient_screen.dart';
import 'package:healthline/screen/ui_doctor/schedule/schedule_screen.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/shift_screen.dart';
import 'package:healthline/screen/widgets/badge_notification.dart';
import 'package:healthline/utils/translate.dart';

class MainScreenDoctor extends StatefulWidget {
  const MainScreenDoctor({super.key});

  @override
  State<MainScreenDoctor> createState() => _MainScreenDoctorState();
}

class _MainScreenDoctorState extends State<MainScreenDoctor> {
  DrawerMenus _currentPage = DrawerMenus.Overview;

  DateTime? currentBackPressTime;

  // ignore: prefer_typing_uninitialized_variables
  var _image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EasyLoading.dismiss();
    });
    context.read<DoctorProfileCubit>().fetchProfile();
    _image = null;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      EasyLoading.showToast(translate(context, 'click_again_to_exit'));

      return Future.value(false);
    }
    return Future.value(true);
  }

  void closeDrawer() {
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: MultiBlocListener(
        listeners: [
          BlocListener<SideMenuCubit, SideMenuState>(
            listener: (context, state) {
              if (state is SideMenuLoading) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else if (state is LogoutActionState) {
                EasyLoading.dismiss();
                Navigator.pushReplacementNamed(context, logInName);
              } else if (state is ErrorActionState) {
                EasyLoading.dismiss();
              }
            },
          ),
          BlocListener<ResCubit, ResState>(
            listener: (context, state) {
              if (state is LanguageChanging) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else {
                EasyLoading.dismiss();
              }
            },
          ),
          BlocListener<DoctorProfileCubit, DoctorProfileState>(
            listener: (context, state) {
              if (state is DoctorProfileUpdating) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else if (state is DoctorAvatarSuccessfully) {
                if (state.profile != null) {
                  String url = CloudinaryContext.cloudinary
                      .image(state.profile!.avatar ?? '')
                      .toString();
                  NetworkImage provider = NetworkImage(url);
                  provider.evict().then<void>((bool success) {
                    if (success) debugPrint('removed image!');
                  });
                }
              }
            },
          ),
          BlocListener<DoctorScheduleCubit, DoctorScheduleState>(
            listener: (context, state) {
              if (state is FetchScheduleLoading ||
                  state is ScheduleByDayUpdating ||
                  state is FixedScheduleUpdating) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else if (state is FetchScheduleSuccessfully) {
                EasyLoading.dismiss();
              } else if (state is FixedScheduleUpdateSuccessfully ||
                  state is ScheduleByDayUpdateSuccessfully) {
                EasyLoading.showToast(translate(context, 'successfully'));
              } else if (state is FetchScheduleError) {
                EasyLoading.showToast(translate(context, state.message));
              } else if (state is FixedScheduleUpdateError) {
                EasyLoading.showToast(translate(context, state.message));
              } else if (state is ScheduleByDayUpdateError) {
                EasyLoading.showToast(translate(context, state.message));
              }
            },
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: white,
          appBar: AppBar(
            title: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
                builder: (context, state) {
              return Text(
                translate(
                  context,
                  _currentPage == DrawerMenus.Schedule
                      ? 'schedule'
                      : _currentPage == DrawerMenus.YourShift
                          ? 'your_shift'
                          : _currentPage == DrawerMenus.Patient
                              ? 'patient'
                              : _currentPage == DrawerMenus.AccountSetting
                                  ? 'account_setting'
                                  : _currentPage == DrawerMenus.Helps
                                      ? 'helps'
                                      : state.profile != null
                                          ? state.profile?.fullName ??
                                              'undefine'
                                          : 'overview',
                ),
              );
            }),
            leading:
                BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
              builder: (context, state) {
                return badgeNotification(
                    IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const FaIcon(FontAwesomeIcons.bars),
                    ),
                    state is UpdateAvailable,
                    Theme.of(context).colorScheme.error,
                    7,
                    7);
              },
            ),
          ),
          drawer: Drawer(
            width: dimensWidth() * 40,
            backgroundColor: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
                    builder: (context, state) {
                  if (state.profile != null) {
                    String url = CloudinaryContext.cloudinary
                        .image(state.profile!.avatar ?? '')
                        .toString();
                    NetworkImage provider = NetworkImage(url);
                    if (state is DoctorAvatarSuccessfully) {
                      provider.evict().then<void>((bool success) {
                        if (success) debugPrint('removed image!');
                      });
                    }

                    _image = _image ?? provider;

                    return SizedBox(
                      width: double.maxFinite,
                      child: DrawerHeader(
                        decoration: const BoxDecoration(
                          color: secondary,
                        ),
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: _image,
                              onBackgroundImageError: (exception, stackTrace) =>
                                  setState(() {
                                _image = AssetImage(DImages.placeholder);
                              }),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              state.profile?.fullName ??
                                  translate(context, 'undefine'),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: white),
                            ),
                            Text(
                              state.profile?.email ??
                                  translate(context, 'undefine'),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: white),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    children: [
                      if (AppController.instance.authState ==
                          AuthState.AllAuthorized)
                        ListTile(
                          onTap: () {
                            EasyLoading.show();
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.pushReplacementNamed(
                                  context, mainScreenPatientName);
                            });
                          },
                          title: Text(
                            translate(context, 'use_patient_account'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: color1F1F1F),
                          ),
                          leading: FaIcon(
                            FontAwesomeIcons.solidUser,
                            size: dimensIcon() * .5,
                            color: color1F1F1F,
                          ),
                        )
                      else
                        const SizedBox(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: dimensHeight() * 2,
                            left: dimensWidth() * 2,
                            bottom: dimensHeight()),
                        child: Text(
                          translate(context, 'general'),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: color1F1F1F),
                        ),
                      ),
                      LabelDrawer(
                        active: _currentPage == DrawerMenus.Overview,
                        press: () {
                          setState(() {
                            closeDrawer();
                            _currentPage = DrawerMenus.Overview;
                          });
                        },
                        label: 'overview',
                        icon: FontAwesomeIcons.houseMedical,
                      ),
                      LabelDrawer(
                        active: _currentPage == DrawerMenus.Schedule,
                        label: 'schedule',
                        icon: FontAwesomeIcons.solidCalendarCheck,
                        press: () {
                          setState(() {
                            closeDrawer();
                            _currentPage = DrawerMenus.Schedule;
                          });
                        },
                      ),
                      LabelDrawer(
                        active: _currentPage == DrawerMenus.YourShift,
                        label: 'your_shift',
                        icon: FontAwesomeIcons.solidCalendarDays,
                        press: () {
                          setState(() {
                            closeDrawer();
                            _currentPage = DrawerMenus.YourShift;
                          });
                        },
                      ),
                      LabelDrawer(
                        active: _currentPage == DrawerMenus.Patient,
                        label: 'patient',
                        icon: FontAwesomeIcons.hospitalUser,
                        press: () {
                          setState(() {
                            closeDrawer();
                            _currentPage = DrawerMenus.Patient;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: dimensHeight() * 2,
                            left: dimensWidth() * 2,
                            bottom: dimensHeight()),
                        child: Text(
                          translate(context, 'setting'),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: color1F1F1F),
                        ),
                      ),
                      LabelDrawer(
                        active: _currentPage == DrawerMenus.AccountSetting,
                        label: 'account_setting',
                        icon: FontAwesomeIcons.userGear,
                        press: () {
                          setState(() {
                            closeDrawer();
                            _currentPage = DrawerMenus.AccountSetting;
                          });
                        },
                      ),
                      BlocBuilder<ApplicationUpdateCubit,
                          ApplicationUpdateState>(
                        builder: (context, state) {
                          return LabelDrawer(
                            active:
                                _currentPage == DrawerMenus.ApplicationSetting,
                            label: 'application_setting',
                            icon: FontAwesomeIcons.gear,
                            isShowBadge: state is UpdateAvailable,
                            press: () {
                              setState(() {
                                closeDrawer();
                                _currentPage = DrawerMenus.ApplicationSetting;
                              });
                            },
                          );
                        },
                      ),
                      // const Spacer(),
                      LabelDrawer(
                        active: _currentPage == DrawerMenus.Helps,
                        label: 'helps',
                        icon: FontAwesomeIcons.solidCircleQuestion,
                        press: () {
                          setState(() {
                            closeDrawer();
                            _currentPage = DrawerMenus.Helps;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Container(
            margin: EdgeInsets.only(right: dimensWidth() * 40),
            child: IconButton(
              onPressed: () => RestClient().runHttpInspector(),
              padding: EdgeInsets.all(dimensWidth() * 2),
              icon: const FaIcon(FontAwesomeIcons.bug),
              color: white,
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(secondary)),
            ),
          ),
          body: _currentPage == DrawerMenus.AccountSetting
              ? const SettingScreen()
              : _currentPage == DrawerMenus.Schedule
                  ? const ScheduleDoctorScreen()
                  : _currentPage == DrawerMenus.YourShift
                      ? const ShiftScreen()
                      : _currentPage == DrawerMenus.Patient
                          ? const PatientScreen()
                          : _currentPage == DrawerMenus.Helps
                              ? const HelpsScreen()
                              : _currentPage == DrawerMenus.ApplicationSetting
                                  ? const ApplicationSettingScreen()
                                  : const OverviewScreen(),
        ),
      ),
    );
  }
}
