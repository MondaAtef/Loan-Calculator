import 'package:flutter/material.dart';

class ValidationService {
  static bool validateInputs({
    required BuildContext context,
    required List<String> selectedCustomerTypes,
    required String calculationType,
    required TextEditingController salaryController,
    required TextEditingController husbandPensionController,
    required TextEditingController fatherPensionController,
    required TextEditingController motherPensionController,
    required TextEditingController yearsController,
    required TextEditingController desiredLoanAmountController,
    required TextEditingController monthlyPaymentController,
    required TextEditingController oldLoanAmountController,
    required TextEditingController newLoanYearsController,
  }) {
    List<String> selectedTypes = selectedCustomerTypes;

    if (selectedTypes.isEmpty &&
        calculationType != ' القسط الشهري' &&
        calculationType != ' المبلغ من القسط') {
      showError(context, 'الرجاء اختيار نوع العميل ');
      return false;
    }

    if (selectedTypes.contains('صاحب معاش') || selectedTypes.contains('موظف')) {
      if (salaryController.text.isEmpty) {
        showError(context, 'الرجاء إدخال الراتب/المعاش');
        return false;
      }
    }

    if (selectedTypes.contains('وريثة من الزوج') && husbandPensionController.text.isEmpty) {
      showError(context, 'الرجاء إدخال معاش الزوج');
      return false;
    }

    if (selectedTypes.contains('وريثة من الأب') && fatherPensionController.text.isEmpty) {
      showError(context, 'الرجاء إدخال معاش الأب');
      return false;
    }

    if (selectedTypes.contains('وريثة من الأم') && motherPensionController.text.isEmpty) {
      showError(context, 'الرجاء إدخال معاش الأم');
      return false;
    }

    switch (calculationType) {
      case ' أقصى مبلغ':
        if (yearsController.text.isEmpty) {
          showError(context, 'الرجاء إدخال عدد السنين');
          return false;
        }
        break;
      case ' القسط الشهري':
        if (desiredLoanAmountController.text.isEmpty ||
            yearsController.text.isEmpty) {
          showError(context, 'الرجاء إدخال المبلغ المطلوب وعدد السنين');
          return false;
        }
        break;
      case ' المبلغ من القسط':
        if (monthlyPaymentController.text.isEmpty ||
            yearsController.text.isEmpty) {
          showError(context, 'الرجاء إدخال القسط الشهري وعدد السنين');
          return false;
        }
        break;
      case 'تسديد قرض قديم':
        if (oldLoanAmountController.text.isEmpty ||
            newLoanYearsController.text.isEmpty) {
          showError(context, 'الرجاء إدخال المبلغ الباقي وعدد السنين');
          return false;
        }
        break;
    }
    return true;
  }

  // Corrected method signature - context first, then message
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
      ),
    );
  }
}