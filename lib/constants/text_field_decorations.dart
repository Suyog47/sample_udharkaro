import 'package:flutter/material.dart';
import 'constants.dart';

const inputDecor = InputDecoration(
  labelStyle: t16_Dark,
);

const inputDecor2 = InputDecoration(
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: lightBlueColor,
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: redColor,
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: redColor,
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: redColor,
      width: 2,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(12),
    ),
  ),
);
