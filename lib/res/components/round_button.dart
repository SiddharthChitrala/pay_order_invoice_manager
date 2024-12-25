import 'package:flutter/material.dart';

import '../colors.dart';


class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
            height: 60,
            width: 200,
            decoration: const BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
            child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )
                  : Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                    ),
            )));
  }
}
