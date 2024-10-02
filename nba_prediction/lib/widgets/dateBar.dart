import 'package:flutter/material.dart';

Container dateBar(DateTime selectedDate, Function(DateTime) onDateSelected) {
  return Container(
    height: 60.0,
    child: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(7, (index) {
            DateTime date = DateTime.now().add(Duration(days: index - 3));
            String label = index == 3 ? "Today" : "${date.day}.${date.month}";
            
            return GestureDetector(
              onTap: () {
                onDateSelected(date);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Chip(
                  label: Text(label),
                  backgroundColor: date == selectedDate ? Colors.white : Colors.lightBlue,
                  labelStyle: TextStyle(
                    color: date == selectedDate ? Colors.black : Colors.white,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    ),
  );
}
