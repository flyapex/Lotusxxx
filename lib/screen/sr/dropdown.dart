import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownRoom extends StatefulWidget {
  final List<String> items;
  final Function(String) onChanged;
  const DropDownRoom({super.key, required this.items, required this.onChanged});

  @override
  State<DropDownRoom> createState() => _DropDownRoomState();
}

class _DropDownRoomState extends State<DropDownRoom> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Room Designation',
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
            items: widget.items.asMap().entries.map((entry) {
              final int index = entry.key;
              final String value = entry.value;
              return DropdownMenuItem<String>(
                value: "$value-$index",
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
              });
              // Extract original value by splitting the combined string
              widget.onChanged(newValue!.split('-').first);
            },
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 6);
  }
}
