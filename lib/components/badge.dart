// ignore_for_file: prefer_const_constructors_in_immutables, deprecated_member_use

import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  Badge({
    Key? key,
    required this.value,
    required this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color ?? Theme.of(context).accentColor,
            ),
            constraints: const BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
