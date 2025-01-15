import 'package:flutter/material.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final startDayOfWeek = DateTime(now.year, now.month, 1).weekday;

    final double boxSize = MediaQuery.of(context).size.width / 9;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: daysInMonth + startDayOfWeek - 1,
          itemBuilder: (context, index) {
            if (index < startDayOfWeek - 1) {
              return const SizedBox.shrink();
            }
            final day = index - startDayOfWeek + 2;
            return Container(
              width: boxSize,
              height: boxSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$day',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4F4F4F),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
