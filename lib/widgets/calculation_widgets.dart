import 'package:flutter/material.dart';
import 'result_card.dart';

class CalculationTypeCard extends StatelessWidget {
  final String calculationType;
  final List<String> calculationTypes;
  final Function(String?) onCalculationTypeChanged;

  const CalculationTypeCard({
    required this.calculationType,
    required this.calculationTypes,
    required this.onCalculationTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFF3C467B), width: 2.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'نوع الحساب',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: calculationTypes.map((type) {
                return RadioListTile<String>(
                  title: Text(
                    type,
                    style: TextStyle(fontSize: 14),
                  ),
                  value: type,
                  groupValue: calculationType,
                  onChanged: onCalculationTypeChanged,
                  activeColor: Color(0xFF3C467B),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final Function() onClear;
  final Function() onCalculate;
  final String calculateButtonText;

  const ActionButtons({
    required this.onClear,
    required this.onCalculate,
    required this.calculateButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: OutlinedButton(
            onPressed: onClear,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'مسح',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              side: BorderSide(color: Colors.red),
              backgroundColor: Colors.red,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 8,
          child: ElevatedButton(
            onPressed: onCalculate,
            child: Text(
              calculateButtonText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
              backgroundColor: Color(0xFF3C467B),
            ),
          ),
        ),
      ],
    );
  }
}