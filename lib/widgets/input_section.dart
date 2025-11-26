import 'package:flutter/material.dart';

class BirthDateInput extends StatelessWidget {
  final TextEditingController controller;
  final String ageDetails;
  final Function() onCalculateAge;

  const BirthDateInput({
    required this.controller,
    required this.ageDetails,
    required this.onCalculateAge,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تاريخ الميلاد',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: (value) => onCalculateAge(),
              decoration: InputDecoration(
                hintText: 'ddMMYYYY',
                prefixIcon: Icon(Icons.cake),
              ),
            ),
            SizedBox(height: 8),
            if (ageDetails.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      ageDetails,
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            if (controller.text.isNotEmpty && ageDetails.isEmpty)
              Text(
                'تاريخ الميلاد غير صحيح',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SalaryInput extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  const SalaryInput({
    required this.controller,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'أدخل $title الشهري',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YearsInput extends StatelessWidget {
  final TextEditingController controller;
  final String point;
  final int selectedMonths;
  final int remainingYears;
  final int customerAge;
  final Function(String) onChanged;

  const YearsInput({
    required this.controller,
    required this.point,
    required this.selectedMonths,
    required this.remainingYears,
    required this.customerAge,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'عدد السنين',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: '1 -> $remainingYears',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 10),
            if (controller.text.isNotEmpty)
              Text(
                ' $point point --> $selectedMonths Month ',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (customerAge > 0)
              Row(
                children: [
                  Icon(Icons.timer, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text(
                    ' $remainingYears ',
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}