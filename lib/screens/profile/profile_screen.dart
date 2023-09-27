// ignore_for_file: unused_field

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/cubits/cubit_profile/profile_cubit.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';
import 'package:intl/intl.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/elevated_button_widget.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _controllerFullName;
  late TextEditingController _controllerBirthday;
  late TextEditingController _controllerGender;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerAddress;

  late File? _file;

  late String gender;

  final _formKey = GlobalKey<FormState>();

  List<String> genders = ['Male', 'Female'];

  @override
  void initState() {
    _controllerFullName = TextEditingController();
    _controllerBirthday = TextEditingController();
    _controllerGender = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerAddress = TextEditingController();

    gender = genders.last;

    _file = null;

    super.initState();
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null) {
      final file = File(result.files.single.path!);
      _file = file;
      setState(() {});
    } else {
      // User canceled the picker
      // You can show snackbar or fluttertoast
      // here like this to show warning to user
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select file'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(UserRepository()),
      child: Builder(builder: (context) {
        return BlocConsumer<ProfileCubit, ProfileState>(
          bloc: context.read<ProfileCubit>(),
          listener: (context, state) {
            if (state is ProfileUpdated) {
              EasyLoading.showToast("update_success");
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              backgroundColor: white,
              appBar: AppBar(title: Text(translate(context, 'edit_profile'))),
              body: GestureDetector(
                onTap: () => KeyboardUtil.hideKeyboard(context),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: _file == null
                              ? CircleAvatar(
                                  backgroundColor: primary,
                                  backgroundImage:
                                      AssetImage(DImages.placeholder),
                                  onBackgroundImageError:
                                      (exception, stackTrace) =>
                                          AssetImage(DImages.placeholder),
                                  radius: dimensWidth() * 15,
                                )
                              : CircleAvatar(
                                  backgroundColor: primary,
                                  backgroundImage: FileImage(_file!),
                                  onBackgroundImageError:
                                      (exception, stackTrace) =>
                                          AssetImage(DImages.placeholder),
                                  radius: dimensWidth() * 15,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: dimensWidth() * 13,
                          child: InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () async => getFile(),
                            child: Container(
                              padding: EdgeInsets.all(dimensWidth() * 1.5),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.1),
                                    spreadRadius: dimensWidth() * .4,
                                    blurRadius: dimensWidth() * .4,
                                  ),
                                ],
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.pen,
                                color: primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: dimensWidth() * 2),
                      child: Text(
                        "Tran Huynh Tan Phat",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: dimensWidth() * .5),
                      child: Text(
                        "0389052819",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensHeight(),
                                horizontal: dimensWidth() * 3),
                            child: TextFieldWidget(
                                label: translate(context, 'full_name'),
                                hint: translate(context, 'ex_full_name'),
                                controller: _controllerFullName,
                                validate: (value) => value!.isEmpty
                                    ? translate(
                                        context, 'please_enter_full_name')
                                    : null),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensHeight(),
                                horizontal: dimensWidth() * 3),
                            child: TextFieldWidget(
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    initialEntryMode: DatePickerEntryMode
                                        .calendarOnly,
                                    initialDatePickerMode: DatePickerMode.day,
                                    context: context,
                                    initialDate:
                                        _controllerBirthday.text.isNotEmpty
                                            ? DateFormat('dd/MM/yyyy')
                                                .parse(_controllerBirthday.text)
                                            : DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  _controllerBirthday.text =
                                      // ignore: use_build_context_synchronously
                                      formatDayMonthYear(context, date);
                                }
                              },
                              readOnly: true,
                              label: translate(context, 'birthday'),
                              // hint: translate(context, 'ex_full_name'),
                              controller: _controllerBirthday,
                              validate: (value) => value!.isEmpty
                                  ? translate(context, 'please_choose_birthday')
                                  : null,
                              suffixIcon: const IconButton(
                                  onPressed: null,
                                  icon: FaIcon(FontAwesomeIcons.calendar)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensHeight(),
                                horizontal: dimensWidth() * 3),
                            child: MenuAnchor(
                              style: MenuStyle(
                                elevation: const MaterialStatePropertyAll(10),
                                // shadowColor: MaterialStatePropertyAll(black26),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        dimensWidth() * 3),
                                  ),
                                ),
                                backgroundColor:
                                    const MaterialStatePropertyAll(white),
                                surfaceTintColor:
                                    const MaterialStatePropertyAll(white),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.only(
                                        right: dimensWidth() * 25,
                                        left: dimensWidth() * 2,
                                        top: dimensHeight(),
                                        bottom: dimensHeight())),
                              ),
                              builder: (BuildContext context,
                                  MenuController controller, Widget? child) {
                                return TextFieldWidget(
                                  onTap: () {
                                    if (controller.isOpen) {
                                      controller.close();
                                    } else {
                                      controller.open();
                                    }
                                  },
                                  readOnly: true,
                                  label: translate(context, 'gender'),
                                  // hint: translate(context, 'ex_full_name'),
                                  controller: _controllerGender,
                                  validate: (value) => value!.isEmpty
                                      ? translate(
                                          context, 'please_choose_gender')
                                      : null,
                                  suffixIcon: const IconButton(
                                      onPressed: null,
                                      icon: FaIcon(FontAwesomeIcons.caretDown)),
                                );
                              },
                              menuChildren: genders
                                  .map(
                                    (e) => MenuItemButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(white)),
                                      onPressed: () => setState(() {
                                        _controllerGender.text =
                                            translate(context, e.toLowerCase());
                                        gender = e;
                                      }),
                                      child: Text(
                                        translate(context, e.toLowerCase()),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensHeight(),
                                horizontal: dimensWidth() * 3),
                            child: TextFieldWidget(
                                label: translate(context, 'email'),
                                hint: translate(context, 'ex_email'),
                                controller: _controllerEmail,
                                validate: (value) =>
                                    Validate().validateEmail(context, value)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensHeight(),
                                horizontal: dimensWidth() * 3),
                            child: TextFieldWidget(
                              label: translate(context, 'address'),
                              // hint: translate(context, 'ex_email'),
                              controller: _controllerAddress,
                              validate: (value) => null,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensHeight(),
                                horizontal: dimensWidth() * 3),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButtonWidget(
                                text: translate(context, 'update_information'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    String avatar = _file == null
                                        ? 'healthline/avatar/oxgzmmewx1udo3un2udo'
                                        : _file!.path;
                                    context.read<ProfileCubit>().updateUser(
                                        _controllerFullName.text,
                                        _controllerEmail.text,
                                        gender,
                                        _controllerBirthday.text,
                                        _controllerAddress.text,
                                        avatar);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
