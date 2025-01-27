import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotuspmc/service/style/color.dart';

class CustomDateTimePicker extends StatefulWidget {
  final String title;
  final String subtitle;
  final Function(DateTime) onDateTimeChanged;
  final DateTime initialDate;

  const CustomDateTimePicker({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onDateTimeChanged,
    required this.initialDate,
  });

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  final List<String> months = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];

  late String selectedMonth;
  late String selectedDay;
  late String selectedYear;
  late String selectedHour;
  late String selectedMinute;
  late String selectedPeriod;

  List<String> years = [];

  @override
  void initState() {
    super.initState();
    // Generate year range dynamically
    int currentYear = DateTime.now().year;
    years = List.generate(11, (i) => (currentYear - 1 + i).toString());

    // Initialize the values based on the provided initial date
    selectedMonth = months[widget.initialDate.month - 1];
    selectedDay = widget.initialDate.day.toString().padLeft(2, '0');
    selectedYear = widget.initialDate.year.toString();
    selectedHour =
        (widget.initialDate.hour % 12 == 0 ? 12 : widget.initialDate.hour % 12)
            .toString()
            .padLeft(2, '0');
    selectedMinute = widget.initialDate.minute.toString().padLeft(2, '0');
    selectedPeriod = widget.initialDate.hour >= 12 ? "PM" : "AM";
  }

  List<String> _getDaysInMonth(String month, String year) {
    int monthIndex = months.indexOf(month) + 1;
    int yearInt = int.parse(year);

    // Determine the number of days in the selected month
    int daysInMonth = DateTime(yearInt, monthIndex + 1, 0).day;

    return List.generate(
        daysInMonth, (i) => (i + 1).toString().padLeft(2, '0'));
  }

  DateTime _getSelectedDateTime() {
    int monthIndex = months.indexOf(selectedMonth) + 1;
    int day = int.parse(selectedDay);
    int year = int.parse(selectedYear);
    int hour = int.parse(selectedHour);
    if (selectedPeriod == "PM" && hour != 12) hour += 12;
    if (selectedPeriod == "AM" && hour == 12) hour = 0;
    int minute = int.parse(selectedMinute);

    return DateTime(year, monthIndex, day, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth(selectedMonth, selectedYear);

    // Adjust the selected day if it's out of bounds for the current month
    if (!days.contains(selectedDay)) {
      selectedDay = days.first;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: secondary,
            fontSize: 18,
          ),
        ).paddingOnly(bottom: 5),
        Row(
          children: [
            Expanded(
              child: _buildCupertinoPicker(
                months,
                selectedMonth,
                (val) => setState(() {
                  selectedMonth = val;
                  widget.onDateTimeChanged(_getSelectedDateTime());
                }),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCupertinoPicker(
                days,
                selectedDay,
                (val) => setState(() {
                  selectedDay = val;
                  widget.onDateTimeChanged(_getSelectedDateTime());
                }),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCupertinoPicker(
                years,
                selectedYear,
                (val) => setState(() {
                  selectedYear = val;
                  widget.onDateTimeChanged(_getSelectedDateTime());
                }),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          widget.subtitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: secondary,
            fontSize: 18,
          ),
        ).paddingOnly(bottom: 5),
        Row(
          children: [
            Expanded(
              child: _buildCupertinoPicker(
                List.generate(12, (i) => (i + 1).toString().padLeft(2, '0')),
                selectedHour,
                (val) => setState(() {
                  selectedHour = val;
                  widget.onDateTimeChanged(_getSelectedDateTime());
                }),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCupertinoPicker(
                List.generate(
                    60, (i) => i.toString().padLeft(2, '0')), // Minute selector
                selectedMinute,
                (val) => setState(() {
                  selectedMinute = val;
                  widget.onDateTimeChanged(_getSelectedDateTime());
                }),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildCupertinoPicker(
                ["AM", "PM"],
                selectedPeriod,
                (val) => setState(() {
                  selectedPeriod = val;
                  widget.onDateTimeChanged(_getSelectedDateTime());
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCupertinoPicker(
    List<String> items,
    String selectedValue,
    ValueChanged<String> onChanged,
  ) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (_) => Container(
            height: 250,
            color: Colors.white,
            child: CupertinoPicker(
              itemExtent: 32,
              scrollController: FixedExtentScrollController(
                initialItem: items.indexOf(selectedValue),
              ),
              onSelectedItemChanged: (index) {
                onChanged(items[index]);
              },
              children: items.map((item) => Center(child: Text(item))).toList(),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(selectedValue, textAlign: TextAlign.center),
      ),
    );
  }
}
