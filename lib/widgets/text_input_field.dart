import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/controllers/controllers.dart';
import 'package:udhaarkaroapp/custom_classes/validation_helpers.dart';

//NameTextField
//PhoneTextField
//EmailTextField
//PasswordTextField


final CommonController _commonController = Get.find();

class NameTextField extends StatelessWidget {
  final String value;
  final String label;
  final Function callback;
  final TextEditingController controller;
  final InputDecoration decoration;

  const NameTextField({
    this.value,
    @required this.label,
    @required this.callback,
    this.controller,
    @required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: decoration.copyWith(
        fillColor: (!_commonController.dark.value) ? whiteColor : blackColor,
        labelText: label,
        labelStyle: TextStyle(
          color: (_commonController.dark.value) ? whiteColor : blackColor,
        ),
      ),
      initialValue: value,
      style: TextStyle(
        color: (_commonController.dark.value) ? whiteColor : blackColor,
      ),
      controller: controller,
      validator: (val) {
        return ValidationHelpers().nameValidation(val);
      },
      onChanged: (val) {
        callback(val);
      },
    );
  }
}

class PhoneTextField extends StatelessWidget {
  final String value;
  final String label;
  final TextEditingController controller;
  final Function callback;
  final bool enabled;
  final InputDecoration decoration;
  final Widget suffixIcon;

  const PhoneTextField({
    this.value,
    this.label,
    this.controller,
    @required this.callback,
    this.enabled = true,
    this.decoration,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: (decoration != null)
          ? decoration.copyWith(
              fillColor:
                  (!_commonController.dark.value) ? whiteColor : blackColor,
              labelText: label,
              labelStyle: TextStyle(
                color: (_commonController.dark.value) ? whiteColor : blackColor,
              ),
              suffixIcon: suffixIcon,
            )
          : InputDecoration(
              fillColor:
                  (!_commonController.dark.value) ? whiteColor : blackColor,
              labelText: label,
              labelStyle: TextStyle(
                color: (_commonController.dark.value) ? whiteColor : blackColor,
              ),
              suffixIcon: suffixIcon,
            ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)
      ],
      enabled: enabled,
      keyboardType: TextInputType.number,
      initialValue: value,
      style: TextStyle(
        color: (_commonController.dark.value) ? whiteColor : blackColor,
      ),
      validator: (val) {
        return ValidationHelpers().phoneValidation(val);
      },
      cursorColor: redColor,
      onChanged: (val) {
        callback(val);
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  final String value;
  final String label;
  final Function callback;
  final InputDecoration decoration;

  const EmailTextField({
    this.value,
    this.label,
    @required this.callback,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: (decoration != null)
          ? decoration.copyWith(
              fillColor:
                  (!_commonController.dark.value) ? whiteColor : blackColor,
              labelText: label,
              labelStyle: TextStyle(
                color: (_commonController.dark.value) ? whiteColor : blackColor,
              ),
            )
          : InputDecoration(
              fillColor:
                  (!_commonController.dark.value) ? whiteColor : blackColor,
              labelText: label,
              labelStyle: TextStyle(
                color: (_commonController.dark.value) ? whiteColor : blackColor,
              ),
            ),
      initialValue: value,
      style: TextStyle(
        color: (_commonController.dark.value) ? whiteColor : blackColor,
      ),
      validator: (val) {
        return ValidationHelpers().emailValidation(val);
      },
      onChanged: (val) {
        callback(val);
      },
    );
  }
}

class SearchTextField extends StatelessWidget {
  final String value;
  final String label;
  final TextEditingController controller;
  final Function callback;
  final InputDecoration decoration;

  const SearchTextField({
    this.value,
    this.label,
    this.controller,
    @required this.callback,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        decoration: (decoration != null)
            ? decoration.copyWith(
                fillColor:
                    (!_commonController.dark.value) ? whiteColor : blackColor,
                labelText: label,
                labelStyle: TextStyle(
                  color:
                      (_commonController.dark.value) ? whiteColor : blackColor,
                ),
              )
            : InputDecoration(
                fillColor:
                    (!_commonController.dark.value) ? whiteColor : blackColor,
                labelText: label,
                labelStyle: TextStyle(
                  color:
                      (_commonController.dark.value) ? whiteColor : blackColor,
                ),
              ),
        initialValue: value,
        style: TextStyle(
          color: (_commonController.dark.value) ? whiteColor : blackColor,
        ),
        onChanged: (val) {
          callback(val);
        },
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String value;
  final String label;
  final Function callback;
  final TextEditingController controller;
  final InputDecoration decoration;
  final bool canValidate;

  const PasswordTextField({
    this.value,
    this.label,
    this.controller,
    @required this.callback,
    this.decoration,
    this.canValidate = true,
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  ValueNotifier<bool> obscureNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (_, obscure, __) {
        return Obx(
          () => TextFormField(
            decoration: (widget.decoration != null)
                ? widget.decoration.copyWith(
                    fillColor: (!_commonController.dark.value)
                        ? whiteColor
                        : blackColor,
                    suffixIcon: IconButton(
                      color: (_commonController.dark.value)
                          ? whiteColor
                          : blackColor,
                      onPressed: () =>
                          obscureNotifier.value = !obscureNotifier.value,
                      icon: obscure ? lockOpenIcon : lockIcon,
                    ),
                    labelText: widget.label,
                    labelStyle: TextStyle(
                      color: (_commonController.dark.value)
                          ? whiteColor
                          : blackColor,
                    ),
                  )
                : InputDecoration(
                    fillColor: (!_commonController.dark.value)
                        ? whiteColor
                        : blackColor,
                    suffixIcon: IconButton(
                      color: (_commonController.dark.value)
                          ? whiteColor
                          : blackColor,
                      onPressed: () =>
                          obscureNotifier.value = !obscureNotifier.value,
                      icon: obscure ? lockOpenIcon : lockIcon,
                    ),
                    labelText: widget.label,
                    labelStyle: TextStyle(
                      color: (_commonController.dark.value)
                          ? whiteColor
                          : blackColor,
                    ),
                  ),
            initialValue: widget.value,
            style: TextStyle(
              color: (_commonController.dark.value) ? whiteColor : blackColor,
            ),
            validator: (val) {
              if(widget.canValidate){
                return ValidationHelpers().passwordValidation(val);
              }
              return null;
            },
            onChanged: (val) {
              widget.callback(val);
            },
            obscureText: obscure,
          ),
        );
      },
    );
  }
}

class OTPTextField extends StatelessWidget {
  final String label;
  final Function callback;
  final InputDecoration decoration;

  const OTPTextField({this.label, @required this.callback, this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: (decoration != null)
          ? decoration.copyWith(
              fillColor:
                  (!_commonController.dark.value) ? whiteColor : blackColor,
              labelText: label,
              labelStyle: TextStyle(
                color: (_commonController.dark.value) ? whiteColor : blackColor,
              ),
            )
          : InputDecoration(
              fillColor:
                  (!_commonController.dark.value) ? whiteColor : blackColor,
              labelText: label,
              labelStyle: TextStyle(
                color: (_commonController.dark.value) ? whiteColor : blackColor,
              ),
            ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6)
      ],
      validator: (val) {
        return ValidationHelpers().otpValidation(val);
      },
      style: TextStyle(
        color: (_commonController.dark.value) ? whiteColor : blackColor,
      ),
      keyboardType: TextInputType.number,
      onChanged: (val) {
        callback(val);
      },
    );
  }
}

class TransactionTextField extends StatelessWidget {
  final String value;
  final String label;
  final Function callback;
  final InputDecoration decoration;

  const TransactionTextField({
    this.value,
    this.label,
    @required this.callback,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      decoration: (decoration != null)
          ? decoration.copyWith(
              fillColor:
                  (!_commonController.dark.value) ? whiteColor : blackColor,
              labelText: label,
              labelStyle: TextStyle(
                color: (_commonController.dark.value) ? whiteColor : blackColor,
              ),
            )
          : InputDecoration(
              fillColor:
                  (!_commonController.dark.value) ? whiteColor : blackColor,
              labelText: label,
              labelStyle: TextStyle(
                color: (_commonController.dark.value) ? whiteColor : blackColor,
              ),
            ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(7)
      ],
      style: TextStyle(
        color: (_commonController.dark.value) ? whiteColor : blackColor,
      ),
      validator: (val) {
        return ValidationHelpers().transactionValidation(val);
      },
      keyboardType: TextInputType.number,
      onChanged: (val) {
        callback(val);
      },
    );
  }
}
