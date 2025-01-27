import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/style/color.dart';

class CheckmarkWithInput extends StatefulWidget {
  final double height;
  final String checkMarkTitle;
  final String checkMarkContent;
  final int inputBoxCount;
  final List<TextEditingController> controllers;
  final List<String> inputTitles;

  const CheckmarkWithInput({
    this.height = 100,
    super.key,
    required this.checkMarkTitle,
    required this.checkMarkContent,
    this.inputBoxCount = 1,
    required this.controllers,
    required this.inputTitles,
  });

  @override
  State<CheckmarkWithInput> createState() => _CheckmarkWithInputState();
}

class _CheckmarkWithInputState extends State<CheckmarkWithInput> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    assert(widget.controllers.length == widget.inputBoxCount,
        'Controllers count must match inputBoxCount.');
    assert(widget.inputTitles.length == widget.inputBoxCount,
        'Input titles count must match inputBoxCount.');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.checkMarkTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ).paddingSymmetric(vertical: 8),
        Row(
          children: [
            SizedBox(
              height: 24.0,
              width: 24.0,
              child: Checkbox(
                value: isChecked,
                fillColor:
                    WidgetStateProperty.all(isChecked ? primary : Colors.white),
                // overlayColor: WidgetStateProperty.all(primary),
                side: BorderSide(color: secondary),
                onChanged: (bool? newValue) {
                  setState(() {
                    isChecked = newValue ?? false;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => setState(() => isChecked = !isChecked),
              child: Text(
                widget.checkMarkContent,
              ),
            ),
          ],
        ),
        if (isChecked) const SizedBox(height: 12),
        if (isChecked)
          for (int i = 0; i < widget.inputBoxCount; i++)
            SizedBox(
              height: widget.height,
              child: TextFormField(
                controller: widget.controllers[i],
                decoration: InputDecoration(
                  labelText: widget.inputTitles[i],
                  border: const OutlineInputBorder(),
                ),
                expands: true,
                maxLines: null,
                minLines: null,
              ).paddingSymmetric(vertical: 8),
            ),
      ],
    ).paddingSymmetric(vertical: 6);
  }
}

class DropDown extends StatefulWidget {
  final Function(String?) onChanged;

  const DropDown({
    super.key,
    required this.onChanged,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'WINDOW BLIND SETTINGS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ).paddingSymmetric(vertical: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            hint: const Text('SELECT WINDOW BLIND'),
            underline: const SizedBox(),
            items: <String>['Up', 'Down', 'Halfway'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
                widget.onChanged(selectedValue);
              });
            },
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 6);
  }
}

class PreArrivalWithInput extends StatefulWidget {
  final double height;
  final String title;
  final String subtitle;
  final TextEditingController controllers;

  const PreArrivalWithInput({
    this.height = 100,
    super.key,
    required this.title,
    required this.subtitle,
    required this.controllers,
  });

  @override
  State<PreArrivalWithInput> createState() => _PreArrivalWithInputState();
}

class _PreArrivalWithInputState extends State<PreArrivalWithInput> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ).paddingSymmetric(vertical: 8),
        Text(
          widget.subtitle,
        ),
        if (isChecked) const SizedBox(height: 12),
        SizedBox(
          height: widget.height,
          child: TextFormField(
            controller: widget.controllers,
            decoration: const InputDecoration(
              labelText: '',
              border: OutlineInputBorder(),
            ),
            expands: true,
            maxLines: null,
            minLines: null,
          ).paddingSymmetric(vertical: 8),
        ),
      ],
    ).paddingSymmetric(vertical: 6);
  }
}

class SingleInput extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? hint;
  final TextEditingController controller;
  const SingleInput({
    super.key,
    required this.title,
    required this.subtitle,
    this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ).paddingSymmetric(vertical: 8),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
            labelText: '',
            border: const OutlineInputBorder(),
            suffix: Text(subtitle),
          ),
        )
      ],
    );
  }
}

class CheckmarkWithTitle extends StatefulWidget {
  final String checkMarkTitle;
  final String checkMarkContent;
  final Function(bool isChecked) onTap;

  const CheckmarkWithTitle({
    super.key,
    required this.checkMarkTitle,
    required this.checkMarkContent,
    required this.onTap,
  });

  @override
  State<CheckmarkWithTitle> createState() => _CheckmarkWithTitleState();
}

class _CheckmarkWithTitleState extends State<CheckmarkWithTitle> {
  bool isChecked = false; // Define a local state to track the checkbox status

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.checkMarkTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ).paddingSymmetric(vertical: 8),
        Row(
          children: [
            SizedBox(
              height: 24.0,
              width: 24.0,
              child: Checkbox(
                value: isChecked,
                fillColor: WidgetStateProperty.resolveWith(
                    (states) => isChecked ? Colors.blue : Colors.white),
                side: const BorderSide(color: Colors.grey),
                onChanged: (bool? newValue) {
                  setState(() {
                    isChecked = newValue ?? false;
                    widget.onTap(isChecked);
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => setState(() => isChecked = !isChecked),
              child: Text(
                widget.checkMarkContent,
              ),
            ),
          ],
        ),
      ],
    ).paddingSymmetric(vertical: 6);
  }
}
