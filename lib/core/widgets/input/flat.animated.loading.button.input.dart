import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/core/theme/core.theme.colors.dart';

class FlatAnimatedLoadingButton extends StatefulWidget {
  const FlatAnimatedLoadingButton({super.key, this.onPressed, this.label});

  // final void Function()? onPressed;
  final FutureOr<void> Function()? onPressed;
  final String? label;

  @override
  State<FlatAnimatedLoadingButton> createState() =>
      _FlatAnimatedLoadingButtonState();
}

class _FlatAnimatedLoadingButtonState extends State<FlatAnimatedLoadingButton> {
  _FlatAnimatedLoadingButtonState();

  double borderRadius = 8;
  double marginWidth = 200;
  double height = 56;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: marginWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
        height: height,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: TextButton(
          onPressed: () async {
            setState(() {
              borderRadius = 100;
              height = 56;
              marginWidth = 56;
              isLoading = true;
            });

            await Future.delayed(const Duration(seconds: 2));
            await widget.onPressed?.call();
            setState(() {
              isLoading = false;
              borderRadius = 8;
              marginWidth = 200;
              height = 56;
            });
          },
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.black,
                  strokeAlign: 0.5,
                )
              : Text(
                  widget.label?.toLowerCase().capitalizeFirst ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
        ));
  }
}
