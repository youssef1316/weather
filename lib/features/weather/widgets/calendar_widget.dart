import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget{
  final List<DateTime> availableDates;
  final DateTime selectedDate;
  final void Function(DateTime) onDateSelected;
  const CalendarWidget ({
    Key? key,
    required this.availableDates,
    required this.selectedDate,
    required this.onDateSelected
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: availableDates.length,
        itemBuilder: (context, index){
          final date = availableDates[index];
          final isSelected = date == selectedDate;
          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected? Colors.blueAccent : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                   DateFormat.E().format(date),
                   style: TextStyle(
                       color:  isSelected? Colors.white : Colors.black
                   ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat.d().format(date),
                    style: TextStyle(
                      fontSize: 18,
                      color: isSelected? Colors.white: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}