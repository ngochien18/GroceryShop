import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    hintText: 'Enter email',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2.0)
    )
);