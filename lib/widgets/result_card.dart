import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultCard extends StatelessWidget {
  final String title;
  final String value;
  final String formula;
  final Color color;
  final Color? backgroundColor;

  const ResultCard({
    required this.title,
    required this.value,
    required this.formula,
    required this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              formula,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerTypeCard extends StatelessWidget {
  final Map<String, bool> customerTypes;
  final Function(String, bool?) onCustomerTypeChanged;

  const CustomerTypeCard({
    required this.customerTypes,
    required this.onCustomerTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'العميل',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: customerTypes.entries.map((entry) {
                return Container(
                  margin: EdgeInsets.only(bottom: 2.0),
                  decoration: BoxDecoration(
                    color: entry.value ? Color(0xFF3C467B).withOpacity(0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: CheckboxListTile(
                    title: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 14,
                        color: entry.value ? Color(0xFF3C467B) : Colors.black,
                        fontWeight: entry.value ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    value: entry.value,
                    onChanged: (bool? value) {
                      onCustomerTypeChanged(entry.key, value);
                    },
                    activeColor: Color(0xFF3C467B),
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    tileColor: Colors.transparent,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}