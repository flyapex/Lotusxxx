import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/service/style/color.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onTap;
  const ActionButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: secondary,
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final Function onSubmit;
  final String title;
  const SubmitButton(
      {super.key, required this.onSubmit, this.title = 'SUBMIT'});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onSubmit();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: lightBackground,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w100)),
      child: Text(
        // 'SUBMIT',
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: secondary,
        ),
      ),
    ).paddingSymmetric(vertical: 10);
  }
}
