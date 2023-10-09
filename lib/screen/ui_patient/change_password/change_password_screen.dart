import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/change_password/components/export.dart';
import 'package:healthline/screen/widgets/cancle_button.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 10,
          title: Text(
            translate(context, 'change_password'),
          ),
          leadingWidth: dimensWidth() * 10,
          leading: cancelButton(context),
        ),
        body: SafeArea(
          bottom: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: const [ChangePasswordForm()],
          ),
        ),
      ),
    );
  }
}
