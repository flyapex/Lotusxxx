import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/service/style/color.dart';

class BigInputBox extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final Function() onSubmit;

  const BigInputBox({
    super.key,
    required this.controller,
    required this.onSubmit,
    this.title = 'SUBMIT',
    this.hint = 'Please enter additional details here.',
  });

  @override
  State<BigInputBox> createState() => _BigInputBoxState();
}

class _BigInputBoxState extends State<BigInputBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          maxLines: 7,
          decoration: InputDecoration(
            labelText: widget.hint,
            labelStyle: TextStyle(
              color: secondary.withOpacity(0.5),
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'required field*',
            //   style: TextStyle(
            //     fontSize: 10,
            //     color: secondary.withOpacity(0.8),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () {
                widget.onSubmit();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: lightBackground,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w100)),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: secondary,
                ),
              ),
            ).paddingOnly(top: 10),
          ],
        )
      ],
    );
  }
}

// now make for small height input box
class SmallInputBox extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final int maxLines;
  final Function() onSubmit;

  const SmallInputBox({
    super.key,
    required this.controller,
    required this.onSubmit,
    this.title = 'SUBMIT',
    this.maxLines = 1,
  });

  @override
  State<SmallInputBox> createState() => _SmallInputBoxState();
}

class _SmallInputBoxState extends State<SmallInputBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            labelText: widget.title,
            labelStyle: TextStyle(
              color: secondary.withOpacity(0.5),
            ),
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            widget.onSubmit();
          },
        ),
      ],
    );
  }
}
