import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../utils/T2Colors.dart';

// ignore: must_be_immutable, camel_case_types
class t2AppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  t2AppButton({required this.textContent, required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return t2AppButtonState();
  }
}

// ignore: camel_case_types
class t2AppButtonState extends State<t2AppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(color: t2_white),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
          padding: EdgeInsets.all(0.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[t2_colorPrimary, t2_colorPrimaryDark]),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}

// ignore: must_be_immutable
class T2EditTextField extends StatefulWidget {
  var isPassword;
  var isEmail;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var maxLine;
  TextEditingController? mController;

  VoidCallback? onPressed;

  T2EditTextField(
      {var this.fontSize = 20.0, var this.textColor = t2_textColorSecondary, var this.isPassword = true, var this.isEmail = false, var this.isSecure = false, var this.text = "", var this.mController, var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return T2EditTextFieldState();
  }
}

class T2EditTextFieldState extends State<T2EditTextField> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return AppTextField(
        controller: widget.mController,
        // obscureText: widget.isPassword,
        textFieldType: widget.isPassword ? TextFieldType.PASSWORD : widget.isEmail ? TextFieldType.EMAIL : TextFieldType.NAME,
        cursorColor: t2_colorPrimary,
        maxLines: widget.maxLine,
        decoration: waInputDecoration(

        ),
      );
    } else {
      return AppTextField(
          controller: widget.mController,
          // obscureText: widget.isPassword,
          textFieldType: widget.isPassword ? TextFieldType.PASSWORD : TextFieldType.NAME,
          cursorColor: t2_colorPrimary,
          decoration: waInputDecoration(
            // suffixIcon: GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       widget.isPassword = !widget.isPassword;
            //     });
            //   },
            //   child: Icon(widget.isPassword ? Icons.visibility : Icons.visibility_off, color: appStore.iconColor),
            // ),
          ));
    }
  }
}

Widget ring(String description) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.0),
          border: Border.all(width: 16.0, color: t2_colorPrimary),
        ),
      ),
      SizedBox(height: 16),
      Text(description, style: boldTextStyle(color: appStore.textPrimaryColor, size: 20), maxLines: 2, textAlign: TextAlign.center)
    ],
  );
}

Widget shareIcon(String iconPath, Color tintColor) {
  return Padding(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Image.asset(iconPath, width: 28, height: 28, fit: BoxFit.fill),
  );
}


class CustomDialog extends StatelessWidget {
  final Function action;

  CustomDialog(this.action);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, action),
    );
  }
}

dialogContent(BuildContext context, Function action) {
  return Container(
    decoration: BoxDecoration(
      color: context.scaffoldBackgroundColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: Offset(0.0, 10.0)),
      ],
    ),
    width: context.width(),
    child: Column(
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        GestureDetector(
          onTap: () {
            finish(context);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Icon(Icons.close, color: appStore.iconColor),
          ),
        ),
        // Image.asset(t2_ic_dialog, color: t2_colorPrimary, width: 95, height: 95),
        SizedBox(height: 24),
        Text("Delete!", style: boldTextStyle(color: t2_colorPrimary, size: 24)),
        SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text('Are you sure you want to delete this?', style: primaryTextStyle(size: 16), textAlign: TextAlign.center).center(),
        ),
        SizedBox(height: 30),
        Container(
          width: context.width(),
          height: 50,
          decoration: BoxDecoration(
            color: t2_colorPrimary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
          ),
          alignment: Alignment.center,
          child: Text('Confirm', style: boldTextStyle(color: white, size: 20)),
        ).onTap(() {
          action();
          finish(context);
        })
      ],
    ),
  );
}

InputDecoration waInputDecoration({IconData? prefixIcon, String? hint, Color? bgColor, Color? borderColor, EdgeInsets? padding}) {
  return InputDecoration(
    contentPadding: padding ?? EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    counter: Offstage(),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: borderColor ?? t2_colorPrimary)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
    ),
    fillColor: bgColor ?? t2_colorPrimary.withOpacity(0.04),
    hintText: hint,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: t2_colorPrimary) : null,
    hintStyle: secondaryTextStyle(),
    filled: true,
  );
}