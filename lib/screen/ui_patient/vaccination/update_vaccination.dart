import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/cancle_button.dart';
import 'package:healthline/screen/widgets/save_button.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class UpdateVaccinationScreen extends StatefulWidget {
  const UpdateVaccinationScreen({super.key});

  @override
  State<UpdateVaccinationScreen> createState() =>
      _UpdateVaccinationScreenState();
}

class _UpdateVaccinationScreenState extends State<UpdateVaccinationScreen> {
  late TextEditingController _controllerDisease;
  late TextEditingController _controllerDayOfLastDose;
  int? _index;
  int? _dose;
  int _currentStep = 0;

  late List<String> listId;

  @override
  void initState() {
    _controllerDisease = TextEditingController();
    _controllerDayOfLastDose = TextEditingController();
    _dose = 1;
    listId = [];
    super.initState();
  }

  bool checkValid() {
    return _controllerDisease.text.isNotEmpty &&
            _controllerDayOfLastDose.text.isNotEmpty
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VaccineRecordCubit, VaccineRecordState>(
      listenWhen: (previous, current) => current is CreateInjectedVaccination,
      listener: (context, state) {
        if (state is CreateInjectedVaccinationLoading) {
          EasyLoading.show();
        } else if (state is CreateInjectedVaccinationLoaded) {
          EasyLoading.showToast(translate(context, 'successfully'));
          Navigator.pop(context, true);
        } else if (state is CreateInjectedVaccinationError) {
          EasyLoading.showToast(state.message);
        }
      },
      child: BlocBuilder<VaccineRecordCubit, VaccineRecordState>(
        builder: (context, state) {
          try {
            listId =
                state.injectedVaccinations.map((e) => e.vaccine!.id!).toList();
          } catch (e) {
            logPrint(e);
          }
          return GestureDetector(
            onTap: () => KeyboardUtil.hideKeyboard(context),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              backgroundColor: white,
              appBar: AppBar(
                title: Text(
                  translate(context, 'add_vaccination'),
                ),
                centerTitle: true,
                leading: cancelButton(context),
                actions: [
                  checkValid()
                      ? Padding(
                          padding: EdgeInsets.only(right: dimensWidth() * 2),
                          child: InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () => context
                                .read<VaccineRecordCubit>()
                                .createInjectedVaccination(
                                    state.vaccinations[_index!].id!,
                                    _currentStep + 1,
                                    _controllerDayOfLastDose.text),
                            child: saveButton(context),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              body: AbsorbPointer(
                absorbing: state is CreateInjectedVaccinationLoading,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: dimensHeight(),
                          horizontal: dimensWidth() * 3),
                      child: MenuAnchor(
                        onOpen: () {
                          setState(() {
                            _dose = null;
                          });
                        },
                        onClose: () {
                          if (_index != null) {
                            // if (state.diseaseAdult[_index!].vaccinations.length ==
                            //     1) {
                            int dose = state.vaccinations[_index!].maxDose!;
                            _currentStep = 0;
                            _dose = dose;
                            // }
                          }
                        },
                        style: MenuStyle(
                          elevation: const MaterialStatePropertyAll(10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(dimensWidth() * 3),
                            ),
                          ),
                          backgroundColor:
                              const MaterialStatePropertyAll(white),
                          surfaceTintColor:
                              const MaterialStatePropertyAll(white),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 2,
                              vertical: dimensHeight(),
                            ),
                          ),
                          maximumSize: MaterialStatePropertyAll(
                            Size(dimensWidth() * 40, dimensHeight() * 55),
                          ),
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
                            label: translate(context, 'vaccination'),
                            controller: _controllerDisease,
                            validate: (value) => null,
                            suffixIcon: const IconButton(
                                onPressed: null,
                                icon: FaIcon(FontAwesomeIcons.caretDown)),
                          );
                        },
                        menuChildren: state.vaccinations
                            .where((element) {
                              if (listId.contains(element.id)) {
                                return false;
                              } else {
                                if (state.age < 9) {
                                  return element.isChild == true;
                                } else {
                                  return element.isChild == false;
                                }
                              }
                            })
                            .map(
                              (e) => MenuItemButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(white)),
                                onPressed: () => setState(() {
                                  _controllerDisease.text =
                                      translate(context, e.disease.toString());
                                  setState(() {
                                    _index = state.vaccinations.indexOf(e);
                                  });
                                }),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: dimensHeight(),
                                      bottom: dimensHeight()),
                                  color: white,
                                  width: dimensWidth() * 30,
                                  child: Text(
                                    translate(context, e.disease.toString()),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    _dose != null && _dose! > 0
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: dimensWidth() * 3),
                            child: Text(
                                '${translate(context, "how_many_doses_have_you_received")} - ${_currentStep + 1}'),
                          )
                        : const SizedBox(),
                    _dose != null && _dose! > 0
                        ? Container(
                            height: dimensHeight() * 18,
                            alignment: Alignment.topCenter,
                            child: Stepper(
                              physics: const NeverScrollableScrollPhysics(),
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              steps: [
                                ...List.generate(
                                  _dose!,
                                  (index) => Step(
                                      title: const SizedBox(),
                                      label: Text(
                                          '${translate(context, 'dose')} ${index + 1}'),
                                      content: const SizedBox(),
                                      state: _currentStep >= index
                                          ? StepState.complete
                                          : StepState.indexed),
                                ),
                              ],
                              type: StepperType.horizontal,
                              currentStep: _currentStep,
                              connectorColor:
                                  const MaterialStatePropertyAll(secondary),
                              controlsBuilder: (context, details) =>
                                  const SizedBox(),
                              onStepTapped: (step) => setState(() {
                                _currentStep = step;
                              }),
                            ),
                          )
                        : const SizedBox(),
                    _dose != null && _dose! > 0
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 3,
                            ),
                            child: TextFieldWidget(
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    initialEntryMode:
                                        DatePickerEntryMode.calendarOnly,
                                    initialDatePickerMode: DatePickerMode.day,
                                    context: context,
                                    initialDate:
                                        _controllerDayOfLastDose.text.isNotEmpty
                                            ? DateFormat('dd/MM/yyyy').parse(
                                                _controllerDayOfLastDose.text)
                                            : DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  setState(() {
                                    _controllerDayOfLastDose.text =
                                        // ignore: use_build_context_synchronously
                                        formatDayMonthYear(context, date);
                                  });
                                }
                              },
                              readOnly: true,
                              label: translate(context, 'time_dose'),
                              controller: _controllerDayOfLastDose,
                              validate: (value) => value!.isEmpty
                                  ? translate(context, 'please_choose')
                                  : null,
                              suffixIcon: const IconButton(
                                  onPressed: null,
                                  icon: FaIcon(FontAwesomeIcons.calendar)),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
