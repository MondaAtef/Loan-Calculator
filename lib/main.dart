import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Import widgets
import 'widgets/result_card.dart';
import 'widgets/input_section.dart';
import 'widgets/calculation_widgets.dart';
import 'Services/validation_service.dart';
import 'widgets/Menu_bar.dart';
import '../Screens/info_screen.dart';
import '../Screens/About_Screen.dart';

void main() {
  runApp(PerfectLoanCalculatorApp());
}

class PerfectLoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loans',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF3C467B),
        fontFamily: 'Cairo',
      ),
      home: PerfectLoanCalculatorScreen(),
    );
  }
}

class PerfectLoanCalculatorScreen extends StatefulWidget {
  @override
  _PerfectLoanCalculatorScreenState createState() =>
      _PerfectLoanCalculatorScreenState();
}

class _PerfectLoanCalculatorScreenState
    extends State<PerfectLoanCalculatorScreen> {
  TextEditingController salaryController = TextEditingController();
  TextEditingController previousInstallmentsController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  TextEditingController heirsCountController = TextEditingController();
  TextEditingController desiredLoanAmountController = TextEditingController();
  TextEditingController monthlyPaymentController = TextEditingController();
  TextEditingController oldLoanAmountController = TextEditingController();
  TextEditingController newLoanYearsController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController husbandPensionController = TextEditingController();
  TextEditingController fatherPensionController = TextEditingController();
  TextEditingController motherPensionController = TextEditingController();
  TextEditingController paymentmonthly_2Controller = TextEditingController();

  String calculationType = ' أقصى مبلغ';
  double inheritancePercentage = 0.75;
  int selectedMonths = 12;
  double point = 1.10;
  int customerAge = 0;
  String ageDetails = '';
  int maxAllowedYears = 10;
  int remainingYears = 10;

  // FIXED: متغيرات منفصلة لكل نوع حساب
  // متغيرات حساب "أقصى مبلغ"
  double maxAmount_s = 0;
  double maxAmount_maxAmount = 0;
  double maxAmount_debtAmount = 0;
  double maxAmount_bankInterest = 0;
  double maxAmount_monthlyInstallment = 0;

  // متغيرات حساب "القسط الشهري"
  double monthlyPayment_s = 0;
  double monthlyPayment_calculatedMonthlyInstallment = 0;
  double monthlyPayment_totalDebtAmount = 0;
  double monthlyPayment_totalInterest = 0;

  // متغيرات حساب "المبلغ من القسط"
  double loanFromPayment_calculatedLoanAmount = 0;
  double loanFromPayment_calculatedLoanAmount_1 = 0;
  double loanFromPayment_calculatedTotalDebt = 0;
  double loanFromPayment_calculatedTotalInterest = 0;
  double loanFromPayment_calculatedTotalDebt_2 = 0;
  double loanFromPayment_paymentmonthly_2 = 0;

  // متغيرات حساب "تسديد قرض قديم"
  double settlement_s = 0;
  double settlement_maxAmount = 0;
  double settlement_debtAmount = 0;
  double settlement_bankInterest = 0;
  double settlement_monthlyInstallment = 0;
  double settlement_newLoanRequired = 0;
  double settlement_newTotalDebt = 0;
  double settlement_newLoanMonthlyInstallment = 0;

  final ScrollController _scrollController = ScrollController();

  final Map<int, double> pointsTable = {
    1: 1.15,
    2: 1.30,
    3: 1.45,
    4: 1.60,
    5: 1.75,
    6: 2.02,
    7: 2.19,
    8: 2.36,
    9: 2.53,
    10: 2.70,
  };

  final Map<String, bool> customerTypes = {
    'صاحب معاش': false,
    'موظف': false,
    'وريثة من الزوج': false,
    'وريثة من الأب': false,
    'وريثة من الأم': false,
  };

  final List<String> calculationTypes = [
    ' أقصى مبلغ',
    ' القسط الشهري',
    ' المبلغ من القسط',
    'تسديد قرض قديم'
  ];

//----------------------------------------------------------------------
// دالة للتعامل مع اختيار القائمة
  void _handleMenuSelection(String value) {
    switch (value) {
      case 'home':
      // إغلاق الدراور إذا كان مفتوحاً
        if (Scaffold.of(context).isDrawerOpen) {
          Navigator.of(context).pop();
        }
        break;
      case 'calculate':
        _navigateTocalculatePage();
        break;
      case 'about':
        _navigateToAboutPage();
        break;
    }
  }

  void _navigateTocalculatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => calculatePage()),
    );
  }

  void _navigateToAboutPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutPage()),
    );
  }

// بناء Navigation Drawer
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF3C467B),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF3C467B),
                    size: 30,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'قسم الائتمان والقروض',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // عناصر القائمة
          _buildDrawerItem(
            icon: Icons.home,
            title: 'الرئيسية',
            onTap: () {
              Navigator.of(context).pop();
              _handleMenuSelection('home');
            },
          ),
          _buildDrawerItem(
            icon: Icons.calculate_outlined,
            title: 'الحسابات',
            onTap: () {
              Navigator.of(context).pop();
              _handleMenuSelection('calculate');
            },
          ),
          _buildDrawerItem(
            icon: Icons.info,
            title: 'عن التطبيق',
            onTap: () {
              Navigator.of(context).pop();
              _handleMenuSelection('about');
            },
          ),

          Divider(),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF3C467B)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
//-------------------------------------------------------------------
  // باقي الدوال تبقى كما هي بدون تغيير
  void _updateCustomerType(String type, bool? value) {
    setState(() {
      customerTypes[type] = value ?? false;
      _calculateRemainingYears();
    });
  }

  List<String> get _selectedCustomerTypes {
    return customerTypes.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  String _getCustomerTypeDescription() {
    List<String> selectedTypes = _selectedCustomerTypes;
    if (selectedTypes.isEmpty) {
      return 'لم يتم اختيار أي نوع عميل';
    }

    if (selectedTypes.length == 1) {
      switch (selectedTypes.first) {
        case 'صاحب معاش':
          return '90% من المعاش';
        case 'موظف':
          return '90% من الراتب';
        case 'وريثة من الزوج':
          return '90% من معاش الزوج';
        case 'وريثة من الأب':
          return '75% من معاش الأب';
        case 'وريثة من الأم':
          return '75% من معاش الأم';
        default:
          return '';
      }
    }

    List<String> descriptions = [];
    for (String type in selectedTypes) {
      switch (type) {
        case 'صاحب معاش':
          descriptions.add('من معاشك 90%');
          break;
        case 'موظف':
          descriptions.add('90% من راتبك');
          break;
        case 'وريثة من الزوج':
          descriptions.add('90% من معاش الزوج');
          break;
        case 'وريثة من الأب':
          descriptions.add('75% من معاش الأب');
          break;
        case 'وريثة من الأم':
          descriptions.add('75% من معاش الأم');
          break;
      }
    }

    return descriptions.join(' + ');
  }

  void _updateCalculationType(String? value) {
    setState(() {
      calculationType = value!;
      _updatePointAndMonths();
    });
  }

  void _updateYearsController() {
    if (calculationType == 'تسديد قرض قديم') {
      newLoanYearsController.text = remainingYears.toString();
    } else {
      yearsController.text = remainingYears.toString();
    }
    _updatePointAndMonths();
  }

  double _roundAmount(double amount) {
    if (amount >= 1000) {
      return (amount / 1000).floor() * 1000;
    } else {
      return (amount / 100).floor() * 100;
    }
  }

  double _calculateNetLoanAmount(double loanAmount) {
    if (loanAmount <= 0) return 0;

    double percentageDeduction = loanAmount * 0.02;
    double fixedDeduction = 29;
    double totalDeductions = percentageDeduction + fixedDeduction;
    double netAmount = loanAmount - totalDeductions;

    return netAmount > 0 ? netAmount : 0;
  }


  void _calculateAge() {
    String birthDateText = birthDateController.text.trim();
    if (birthDateText.isEmpty) {
      setState(() {
        customerAge = 0;
        ageDetails = '';
        remainingYears = 10;
      });
      return;
    }

    try {
      String formattedDate = birthDateText;
      if (birthDateText.length == 8 && !birthDateText.contains('/')) {
        formattedDate = '${birthDateText.substring(0,2)}/${birthDateText.substring(2,4)}/${birthDateText.substring(4,8)}';
        birthDateController.text = formattedDate;
        birthDateController.selection = TextSelection.fromPosition(
            TextPosition(offset: formattedDate.length)
        );
      }

      List<String> dateParts = formattedDate.split('/');
      if (dateParts.length != 3) {
        throw FormatException('صيغة التاريخ غير صحيحة');
      }

      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);

      // إذا كانت السنة مكونة من رقمين فقط
      if (year < 100) {
        year += 1900;
      }

      DateTime birthDate = DateTime(year, month, day);
      DateTime currentDate = DateTime.now();

      if (birthDate.isAfter(currentDate)) {
        throw FormatException('تاريخ الميلاد في المستقبل');
      }

      // حساب العمر بالسنين والشهور والأيام
      int years = currentDate.year - birthDate.year;
      int months = currentDate.month - birthDate.month;
      int days = currentDate.day - birthDate.day;

      // تعديل إذا كانت الأيام سالبة
      if (days < 0) {
        months--;
        // احصل على عدد أيام الشهر السابق
        DateTime lastMonth = DateTime(currentDate.year, currentDate.month - 1, birthDate.day);
        days = currentDate.difference(lastMonth).inDays;
      }

      // تعديل إذا كانت الشهور سالبة
      if (months < 0) {
        years--;
        months += 12;
      }

      setState(() {     //2025       -      1960
        customerAge =  currentDate.year - birthDate.year;; // نستخدم السنوات فقط للحسابات الأخرى
        ageDetails = 'العمر: $years سنة, $months شهر, $days يوم';
        _calculateRemainingYears();
      });
    } catch (e) {
      setState(() {
        customerAge = 0;
        ageDetails = 'تاريخ غير صحيح';
        remainingYears = 10;
      });
    }
  }

  void _calculateRemainingYears() {
    List<String> selectedTypes = _selectedCustomerTypes;

    if (selectedTypes.isEmpty) {
      setState(() {
        remainingYears = 10;
      });
      _updateYearsController();
      return;
    }

    int retirementAge = 70;

    if (selectedTypes.contains('موظف')) {
      retirementAge = 60;
    }
    else if (selectedTypes.contains('صاحب معاش')) {
      retirementAge = 70;
    }
    else if (selectedTypes.contains('وريثة من الزوج') ||
        selectedTypes.contains('وريثة من الأب') ||
        selectedTypes.contains('وريثة من الأم')) {
      retirementAge = 70;
    }

    // احسب السنوات المتبقية مباشرة

    int calculatedRemainingYears = retirementAge - (customerAge+1);

    if (calculatedRemainingYears < 1) {
      remainingYears = 1;
    } else if (calculatedRemainingYears > 10) {
      remainingYears = 10;
    } else {
      remainingYears = calculatedRemainingYears;
    }

    _updateYearsController();
  }
  void _scrollToResults() {
    // انتظر قليلاً حتى يتم تحديث الواجهة ثم قم بالتمرير
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    birthDateController.addListener(_calculateAge);
  }

  double _calculateAllowedAmount(double salary, double previousInstallments) {
    List<String> selectedTypes = _selectedCustomerTypes;

    if ((calculationType == ' القسط الشهري' || calculationType == ' المبلغ من القسط') &&
        selectedTypes.isEmpty) {
      double allowed = (salary * 0.90) - previousInstallments;
      return allowed > 0 ? allowed : 0;
    }

    if (selectedTypes.isEmpty) {
      return 0;
    }

    double totalAllowed = 0;

    for (String type in selectedTypes) {
      double percentage;
      double baseAmount = 0;

      switch (type) {
        case 'صاحب معاش':
          percentage = 0.90;
          baseAmount = salary;
          break;
        case 'موظف':
          percentage = 0.90;
          baseAmount = salary;
          break;
        case 'وريثة من الزوج':
          percentage = 0.90;
          baseAmount = double.tryParse(husbandPensionController.text) ?? 0;
          break;
        case 'وريثة من الأب':
          percentage = inheritancePercentage;
          baseAmount = double.tryParse(fatherPensionController.text) ?? 0;
          break;
        case 'وريثة من الأم':
          percentage = inheritancePercentage;
          baseAmount = double.tryParse(motherPensionController.text) ?? 0;
          break;
        default:
          percentage = 0.90;
          baseAmount = salary;
      }

      totalAllowed += (baseAmount * percentage);
    }

    return totalAllowed - previousInstallments;
  }

  bool _validateInputs() {
    return ValidationService.validateInputs(
      context: context,
      selectedCustomerTypes: _selectedCustomerTypes,
      calculationType: calculationType,
      salaryController: salaryController,
      husbandPensionController: husbandPensionController,
      fatherPensionController: fatherPensionController,
      motherPensionController: motherPensionController,
      yearsController: yearsController,
      desiredLoanAmountController: desiredLoanAmountController,
      monthlyPaymentController: monthlyPaymentController,
      oldLoanAmountController: oldLoanAmountController,
      newLoanYearsController: newLoanYearsController,
    );
  }

  String _formatNumber(double number) {
    if (number == number.roundToDouble()) {
      NumberFormat formatter = NumberFormat('#,###');
      return formatter.format(number);
    } else {
      NumberFormat formatter = NumberFormat('#,###.#');
      return formatter.format(number);
    }
  }

  void calculateLoan() {
    FocusScope.of(context).unfocus();
    if (!_validateInputs()) return;

    double salary = double.tryParse(salaryController.text) ?? 0;
    double previousInstallments = double.tryParse(previousInstallmentsController.text) ?? 0;
    int years = int.tryParse(yearsController.text) ?? remainingYears;

    if (years > remainingYears) {
      years = remainingYears;
      yearsController.text = years.toString();
      ValidationService.showError(context,' Maximum number of years = $years ');
    }

    if (years < 1) years = 1;
    if (years > 10) years = 10;

    selectedMonths = years * 12;
    point = pointsTable[years] ?? 1.10;

    setState(() {
      // استخدام المتغيرات الخاصة بـ "أقصى مبلغ"
      maxAmount_s = _calculateAllowedAmount(salary, previousInstallments);
      if (maxAmount_s < 0) maxAmount_s = 0;

      double rawMaxAmount = (maxAmount_s * selectedMonths) / point;
      maxAmount_maxAmount = _roundAmount(rawMaxAmount);
      maxAmount_debtAmount = maxAmount_maxAmount * point;
      maxAmount_bankInterest = maxAmount_debtAmount - maxAmount_maxAmount;
      maxAmount_monthlyInstallment = maxAmount_debtAmount / selectedMonths;
    });
    _scrollToResults();
  }

  void calculateMonthlyPayment() {
    FocusScope.of(context).unfocus();
    if (!_validateInputs()) return;

    double desiredLoanAmount = double.tryParse(desiredLoanAmountController.text) ?? 0;
    int desiredYears = int.tryParse(yearsController.text) ?? 1;

    if (desiredYears < 1) desiredYears = 1;
    if (desiredYears > 10) desiredYears = 10;

    int desiredMonths = desiredYears * 12;
    double desiredPoint = pointsTable[desiredYears] ?? 1.10;

    setState(() {
      double salary = double.tryParse(salaryController.text) ?? 0;
      double previousInstallments = double.tryParse(previousInstallmentsController.text) ?? 0;

      // استخدام المتغيرات الخاصة بـ "القسط الشهري"
      monthlyPayment_s = _calculateAllowedAmount(salary, previousInstallments);
      if (monthlyPayment_s < 0) monthlyPayment_s = 0;

      monthlyPayment_totalDebtAmount = desiredLoanAmount * desiredPoint;
      monthlyPayment_totalInterest = monthlyPayment_totalDebtAmount - desiredLoanAmount;
      monthlyPayment_calculatedMonthlyInstallment = monthlyPayment_totalDebtAmount / desiredMonths;
    });
    _scrollToResults();
  }

  void calculateLoanFromMonthlyPayment() {
    FocusScope.of(context).unfocus();
    if (!_validateInputs()) return;

    double monthlyPayment = double.tryParse(monthlyPaymentController.text) ?? 0;
    int paymentYears = int.tryParse(yearsController.text) ?? 1;

    if (paymentYears < 1) paymentYears = 1;
    if (paymentYears > 10) paymentYears = 10;

    int paymentMonths = paymentYears * 12;
    double paymentPoint = pointsTable[paymentYears] ?? 1.10;

    setState(() {
      // استخدام المتغيرات الخاصة بـ "المبلغ من القسط"
      loanFromPayment_calculatedTotalDebt = monthlyPayment * paymentMonths;
      double rawCalculatedLoanAmount = loanFromPayment_calculatedTotalDebt / paymentPoint;
      loanFromPayment_calculatedLoanAmount_1 = rawCalculatedLoanAmount;

      loanFromPayment_calculatedTotalDebt = loanFromPayment_calculatedLoanAmount_1 * paymentPoint;
      loanFromPayment_calculatedTotalInterest = loanFromPayment_calculatedTotalDebt - loanFromPayment_calculatedLoanAmount_1;

      //ملخص القرض
      loanFromPayment_calculatedLoanAmount = _roundAmount(rawCalculatedLoanAmount);
      loanFromPayment_calculatedTotalDebt_2 = loanFromPayment_calculatedLoanAmount * paymentPoint;
      loanFromPayment_paymentmonthly_2 = loanFromPayment_calculatedTotalDebt_2 / paymentMonths;
    });
    _scrollToResults();
  }

  void calculateLoanSettlement() {
    FocusScope.of(context).unfocus();
    if (!_validateInputs()) return;

    double salary = double.tryParse(salaryController.text) ?? 0;
    double previousInstallments = double.tryParse(previousInstallmentsController.text) ?? 0;
    double oldLoanBalance = double.tryParse(oldLoanAmountController.text) ?? 0;
    int newYears = int.tryParse(newLoanYearsController.text) ?? remainingYears;

    if (newYears > remainingYears) {
      newYears = remainingYears;
      newLoanYearsController.text = newYears.toString();
      ValidationService.showError(context,' تم تعديل الي اقصي عدد من سنين  = $newYears ');
    }

    if (newYears < 1) newYears = 1;
    if (newYears > 10) newYears = 10;

    int newMonths = newYears * 12;
    double newPoint = pointsTable[newYears] ?? 1.10;

    setState(() {
      double allowedFromSalary = _calculateAllowedAmount(salary, previousInstallments);
      if (allowedFromSalary < 0) allowedFromSalary = 0;

      double finalAllowedAmount = allowedFromSalary + oldLoanBalance;
      double rawNewLoanRequired = (finalAllowedAmount * newMonths) / newPoint;

      // استخدام المتغيرات الخاصة بـ "تسديد قرض قديم"
      settlement_s = finalAllowedAmount;
      settlement_maxAmount = _roundAmount(rawNewLoanRequired);
      settlement_newLoanRequired = settlement_maxAmount;
      settlement_newTotalDebt = settlement_maxAmount * newPoint;
      settlement_debtAmount = settlement_newTotalDebt;
      settlement_bankInterest = settlement_newTotalDebt - settlement_maxAmount;
      settlement_monthlyInstallment = settlement_newTotalDebt / newMonths;
      settlement_newLoanMonthlyInstallment = settlement_monthlyInstallment;
    });
    _scrollToResults();
  }

  void clearData() {
    setState(() {
      salaryController.clear();
      previousInstallmentsController.clear();
      yearsController.clear();
      heirsCountController.clear();
      desiredLoanAmountController.clear();
      monthlyPaymentController.clear();
      oldLoanAmountController.clear();
      newLoanYearsController.clear();
      birthDateController.clear();
      husbandPensionController.clear();
      fatherPensionController.clear();
      motherPensionController.clear();

      customerTypes.forEach((key, val) {
        customerTypes[key] = false;
      });

      calculationType = ' أقصى مبلغ';
      inheritancePercentage = 0.75;
      selectedMonths = 12;
      point = 1.10;
      ageDetails = '';
      remainingYears = 10;

      // FIXED: إعادة تعيين كل المتغيرات الخاصة بالحسابات
      // إعادة تعيين متغيرات "أقصى مبلغ"
      maxAmount_s = 0;
      maxAmount_maxAmount = 0;
      maxAmount_debtAmount = 0;
      maxAmount_bankInterest = 0;
      maxAmount_monthlyInstallment = 0;

      // إعادة تعيين متغيرات "القسط الشهري"
      monthlyPayment_s = 0;
      monthlyPayment_calculatedMonthlyInstallment = 0;
      monthlyPayment_totalDebtAmount = 0;
      monthlyPayment_totalInterest = 0;

      // إعادة تعيين متغيرات "المبلغ من القسط"
      loanFromPayment_calculatedLoanAmount = 0;
      loanFromPayment_calculatedLoanAmount_1 = 0;
      loanFromPayment_calculatedTotalDebt = 0;
      loanFromPayment_calculatedTotalInterest = 0;
      loanFromPayment_calculatedTotalDebt_2 = 0;
      loanFromPayment_paymentmonthly_2 = 0;

      // إعادة تعيين متغيرات "تسديد قرض قديم"
      settlement_s = 0;
      settlement_maxAmount = 0;
      settlement_debtAmount = 0;
      settlement_bankInterest = 0;
      settlement_monthlyInstallment = 0;
      settlement_newLoanRequired = 0;
      settlement_newTotalDebt = 0;
      settlement_newLoanMonthlyInstallment = 0;
    });
  }

  void clearInputs() {
    setState(() {
      salaryController.clear();
      previousInstallmentsController.clear();
      yearsController.clear();
      heirsCountController.clear();
      desiredLoanAmountController.clear();
      monthlyPaymentController.clear();
      oldLoanAmountController.clear();
      newLoanYearsController.clear();
      birthDateController.clear();
      husbandPensionController.clear();
      fatherPensionController.clear();
      motherPensionController.clear();
    });
  }

  String _getCalculationButtonText() {
    switch (calculationType) {
      case ' أقصى مبلغ':
        return 'احسب أقصى مبلغ';
      case ' القسط الشهري':
        return 'احسب القسط الشهري';
      case ' المبلغ من القسط':
        return 'احسب المبلغ المتاح';
      case 'تسديد قرض قديم':
        return 'احسب القرض الجديد';
      default:
        return 'احسب';
    }
  }

  void _updatePointAndMonths() {
    int years = 1;
    switch (calculationType) {
      case ' أقصى مبلغ':
      case ' القسط الشهري':
      case ' المبلغ من القسط':
        years = int.tryParse(yearsController.text) ?? 1;
        break;
      case 'تسديد قرض قديم':
        years = int.tryParse(newLoanYearsController.text) ?? 1;
        break;
    }

    if (years < 1) years = 1;
    if (years > 10) years = 10;

    setState(() {
      selectedMonths = years * 12;
      point = pointsTable[years] ?? 1.10;
    });
  }

  TextEditingController _getYearsControllerForCalculationType() {
    switch (calculationType) {
      case ' أقصى مبلغ':
      case ' القسط الشهري':
      case ' المبلغ من القسط':
        return yearsController;
      case 'تسديد قرض قديم':
        return newLoanYearsController;
      default:
        return yearsController;
    }
  }

  String _getSelectedCustomerTypesString() {
    List<String> selectedTypes = _selectedCustomerTypes;
    if (selectedTypes.isEmpty) {
      if (calculationType == ' القسط الشهري' || calculationType == ' المبلغ من القسط') {
        return 'حساب بدون تحديد نوع العميل';
      }
      return 'لم يتم اختيار أي نوع';
    }

    if (selectedTypes.length == 1) return selectedTypes.first;

    return selectedTypes.join(' + ');
  }

  Widget _buildMaxAmountResults() {
    return Column(
      children: [
        Text(
          'نتائج حساب أقصى مبلغ:',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                _getSelectedCustomerTypesString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ResultCard(
          title: 'المسموح به',
          value: '${_formatNumber(maxAmount_s)} ج.م',
          formula: _getCustomerTypeDescription(),
          color: Colors.blue,
        ),
        ResultCard(
          title: 'أقصى مبلغ قرض',
          value: '${_formatNumber(maxAmount_maxAmount)} ج.م',
          formula: '(المسموح به × $selectedMonths) ÷ $point',
          color: Colors.green,
        ),
        ResultCard(
          title: 'إجمالي المديونية',
          value: '${_formatNumber(maxAmount_debtAmount)} ج.م',
          formula: 'أقصى مبلغ × $point',
          color: Colors.orange,
        ),
        ResultCard(
          title: 'فوايد البنك',
          value: '${_formatNumber(maxAmount_bankInterest)} ج.م',
          formula: 'المديونية - أقصى مبلغ',
          color: Colors.red,
        ),
        ResultCard(
          title: 'القسط الشهري',
          value: '${_formatNumber(maxAmount_monthlyInstallment)} ج.م',
          formula: 'المديونية ÷ $selectedMonths',
          color: Colors.purple,
        ),
        ResultCard(
          title: 'صافي القرض بعد الخصومات',
          value: '${_formatNumber(_calculateNetLoanAmount(maxAmount_maxAmount))} ج.م',
          formula: 'أقصى مبلغ - [ (أقصى مبلغ × 2%) + 29]',
          color: Colors.deepPurple,
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue),
          ),
          child: Column(
            children: [
              Text(
                'ملخص القرض',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'يمكنك الحصول علي ${_formatNumber(maxAmount_maxAmount)}',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'ستدفع ${_formatNumber(maxAmount_monthlyInstallment)} ج.م شهرياً لمدة ${yearsController.text} سنة',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'صافي المبلغ المستلم: ${_formatNumber(_calculateNetLoanAmount(maxAmount_maxAmount))} ج.م',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        OutlinedButton(
          onPressed: clearData,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'حساب جديد',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            side: BorderSide(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyPaymentResults() {
    int desiredYears = int.tryParse(yearsController.text) ?? 1;
    double desiredLoanAmount = double.tryParse(desiredLoanAmountController.text) ?? 0;
    double point = pointsTable[desiredYears] ?? 1.10;

    return Column(
      children: [
        Text(
          'نتائج حساب القسط الشهري:',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
        SizedBox(height: 20),

        ResultCard(
          title: 'المبلغ المطلوب',
          value: '${_formatNumber(desiredLoanAmount)} ج.م',
          formula: 'المبلغ الذي تريد اقتراضه',
          color: Colors.blue,
        ),
        ResultCard(
          title: 'إجمالي المديونية',
          value: '${_formatNumber(monthlyPayment_totalDebtAmount)} ج.م',
          formula: 'المبلغ المطلوب × $point',
          color: Colors.orange,
        ),
        ResultCard(
          title: 'إجمالي الفوائد',
          value: '${_formatNumber(monthlyPayment_totalInterest)} ج.م',
          formula: 'المديونية - المبلغ المطلوب',
          color: Colors.red,
        ),
        ResultCard(
          title: 'القسط الشهري',
          value: '${_formatNumber(monthlyPayment_calculatedMonthlyInstallment)} ج.م',
          formula: 'إجمالي المديونية ÷ ${desiredYears * 12} شهر',
          color: Colors.purple,
        ),
        if (monthlyPayment_s > 0)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: monthlyPayment_s < monthlyPayment_calculatedMonthlyInstallment ? Colors.redAccent : Colors.green,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(5, 10),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'المسموح به',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: monthlyPayment_s < monthlyPayment_calculatedMonthlyInstallment ? Colors.white : Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${_formatNumber(monthlyPayment_s)} ج.م',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: monthlyPayment_s < monthlyPayment_calculatedMonthlyInstallment ? Colors.white : Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    _getCustomerTypeDescription(),
                    style: TextStyle(
                      fontSize: 12,
                      color: monthlyPayment_s < monthlyPayment_calculatedMonthlyInstallment ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ResultCard(
          title: 'صافي القرض بعد الخصومات',
          value: '${_formatNumber(_calculateNetLoanAmount(desiredLoanAmount))} ج.م',
          formula: 'المبلغ المطلوب -[ (المبلغ المطلوب × 2%) + 29 ]',
          color: Colors.deepPurple,
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green),
          ),
          child: Column(
            children: [
              Text(
                'ملخص القرض',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'سوف تدفع ${_formatNumber(monthlyPayment_calculatedMonthlyInstallment)} ج.م شهرياً لمدة $desiredYears سنة',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'صافي المبلغ المستلم: ${_formatNumber(_calculateNetLoanAmount(desiredLoanAmount))} ج.م',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        OutlinedButton(
          onPressed: clearData,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'حساب جديد',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            side: BorderSide(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildLoanFromPaymentResults() {
    int paymentYears = int.tryParse(yearsController.text) ?? 1;
    double monthlyPayment = double.tryParse(monthlyPaymentController.text) ?? 0;
    double point = pointsTable[paymentYears] ?? 1.10;

    return Column(
      children: [
        Text(
          'نتائج حساب المبلغ المتاح:',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
        SizedBox(height: 20),
        ResultCard(
          title: 'القسط الشهري المتاح',
          value: '${_formatNumber(monthlyPayment)} ج.م',
          formula: 'المبلغ الذي تستطيع دفعه شهرياً',
          color: Colors.blue,
        ),

        ResultCard(
          title: 'المبلغ المتاح للقرض',
          value: '${_formatNumber(loanFromPayment_calculatedLoanAmount_1) }   ج.م  ',
          formula: 'القسط الشهري × ${paymentYears * 12} ÷ $point',
          color: Colors.green,
        ),
        ResultCard(
          title: 'إجمالي المديونية',
          value: '${_formatNumber(loanFromPayment_calculatedTotalDebt)} ج.م',
          formula: 'القسط الشهري × ${paymentYears * 12} شهر',
          color: Colors.orange,
        ),
        ResultCard(
          title: 'إجمالي الفوائد',
          value: '${_formatNumber(loanFromPayment_calculatedTotalInterest)} ج.م',
          formula: 'المديونية - المبلغ المتاح',
          color: Colors.red,
        ),
        ResultCard(
          title: 'صافي القرض بعد الخصومات',
          value: '${_formatNumber(_calculateNetLoanAmount(loanFromPayment_calculatedLoanAmount_1))} ج.م',
          formula: 'المبلغ المتاح - [(المبلغ المتاح × 2%) + 29 ]',
          color: Colors.deepPurple,
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.purple),
          ),
          child: Column(
            children: [
              Text(
                'ملخص القرض',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'يمكنك الحصول على قرض بقيمة ${_formatNumber(loanFromPayment_calculatedLoanAmount)} ج.م',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'بدفع ${_formatNumber(loanFromPayment_paymentmonthly_2)} ج.م شهرياً لمدة $paymentYears سنة',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'صافي المبلغ المستلم: ${_formatNumber(_calculateNetLoanAmount(loanFromPayment_calculatedLoanAmount))} ج.م',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        OutlinedButton(
          onPressed: clearData,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'حساب جديد',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            side: BorderSide(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildLoanSettlementResults() {
    int newYears = int.tryParse(newLoanYearsController.text) ?? 1;
    double newPoint = pointsTable[newYears] ?? 1.10;

    return Column(
      children: [
        Text(
          'نتائج تسديد القرض القديم:',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
        SizedBox(height: 20),
        ResultCard(
          title: 'المسموح النهائي',
          value: '${_formatNumber(settlement_s)} ج.م',
          formula: "${_getCustomerTypeDescription()}\n  الاقساط السابقة + الباقي من القرض القديم -" ,
          color: Colors.blue,
        ),
        ResultCard(
          title: 'أقصى مبلغ للقرض الجديد',
          value: '${_formatNumber(settlement_maxAmount)} ج.م',
          formula: 'المسموح النهائي × ${newYears * 12} ÷ $newPoint',
          color: Colors.green,
        ),
        ResultCard(
          title: 'إجمالي المديونية الجديدة',
          value: '${_formatNumber(settlement_debtAmount)} ج.م',
          formula: 'أقصى مبلغ × $newPoint',
          color: Colors.orange,
        ),
        ResultCard(
          title: 'فوايد البنك',
          value: '${_formatNumber(settlement_bankInterest)} ج.م',
          formula: 'المديونية - أقصى مبلغ',
          color: Colors.red,
        ),
        ResultCard(
          title: 'القسط الشهري الجديد',
          value: '${_formatNumber(settlement_monthlyInstallment)} ج.م',
          formula: 'المديونية ÷ ${newYears * 12}',
          color: Colors.purple,
        ),
        ResultCard(
          title: 'صافي القرض بعد الخصومات',
          value: '${_formatNumber(_calculateNetLoanAmount(settlement_maxAmount))} ج.م',
          formula: 'أقصى مبلغ - [ (أقصى مبلغ × 2%) + 29 ]',
          color: Colors.deepPurple,
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal[50],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.teal),
          ),
          child: Column(
            children: [
              Text(
                'ملخص القرض الجديد',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'ستسدّد القرض القديم وتبدأ قرض جديد',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'قيمته: ${_formatNumber(settlement_maxAmount)} ج.م',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'القسط الشهري الجديد: ${_formatNumber(settlement_monthlyInstallment)} ج.م',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'صافي المبلغ المستلم: ${_formatNumber(_calculateNetLoanAmount(settlement_maxAmount))} ج.م',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        OutlinedButton(
          onPressed: clearData,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'حساب جديد',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            side: BorderSide(color: Colors.red),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    salaryController.dispose();
    previousInstallmentsController.dispose();
    yearsController.dispose();
    heirsCountController.dispose();
    desiredLoanAmountController.dispose();
    monthlyPaymentController.dispose();
    oldLoanAmountController.dispose();
    newLoanYearsController.dispose();
    birthDateController.dispose();
    husbandPensionController.dispose();
    fatherPensionController.dispose();
    motherPensionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> selectedCustomerTypes = _selectedCustomerTypes;

    return Scaffold(
      appBar: AppMenuBar(
        appTitle: 'حساب القروض',
        onMenuPressed: () {
          // يمكنك إضافة أي وظيفة إضافية هنا
        },
      ),
      drawer: _buildDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Use the extracted widgets
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomerTypeCard(
                      customerTypes: customerTypes,
                      onCustomerTypeChanged: _updateCustomerType,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CalculationTypeCard(
                      calculationType: calculationType,
                      calculationTypes: calculationTypes,
                      onCalculationTypeChanged: _updateCalculationType,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              BirthDateInput(
                controller: birthDateController,
                ageDetails: ageDetails,
                onCalculateAge: _calculateAge,
              ),
              SizedBox(height: 10),

              // Salary input for specific customer types
              if (calculationType == ' أقصى مبلغ' || calculationType == 'تسديد قرض قديم') ...[
                if (selectedCustomerTypes.contains('صاحب معاش') || selectedCustomerTypes.contains('موظف')) ...[
                  SalaryInput(
                    controller: salaryController,
                    title: 'الراتب / المعاش',
                  ),
                  SizedBox(height: 10),
                ],

                if (selectedCustomerTypes.contains('وريثة من الزوج')) ...[
                  SalaryInput(
                    controller: husbandPensionController,
                    title: 'معاش الزوج',
                  ),
                  SizedBox(height: 10),
                ],

                if (selectedCustomerTypes.contains('وريثة من الأب')) ...[
                  SalaryInput(
                    controller: fatherPensionController,
                    title: 'معاش الأب',
                  ),
                  SizedBox(height: 10),
                ],

                if (selectedCustomerTypes.contains('وريثة من الأم')) ...[
                  SalaryInput(
                    controller: motherPensionController,
                    title: 'معاش الأم',
                  ),
                  SizedBox(height: 10),
                ],
              ],

              // Previous installments
              if (calculationType == ' أقصى مبلغ' || calculationType == 'تسديد قرض قديم') ...[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الاقساط السابقة',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: previousInstallmentsController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'أدخل إجمالي الأقساط السابقة',
                            prefixIcon: Icon(Icons.credit_card),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],

              // Desired loan amount
              if (calculationType == ' القسط الشهري') ...[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'المبلغ المطلوب',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: desiredLoanAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'أدخل المبلغ الذي تريد اقتراضه',
                            prefixIcon: Icon(Icons.money),
                            suffixText: 'ج.م',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],

              // Monthly payment
              if (calculationType == ' المبلغ من القسط') ...[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'القسط الشهري المتاح',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: monthlyPaymentController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'أدخل المبلغ الذي تستطيع دفعه شهرياً',
                            prefixIcon: Icon(Icons.payment),
                            suffixText: 'ج.م',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],

              // Old loan amount
              if (calculationType == 'تسديد قرض قديم') ...[
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الباقي من القرض القديم',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          controller: oldLoanAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'أدخل المبلغ الباقي من القرض القديم',
                            prefixIcon: Icon(Icons.credit_score),
                            suffixText: 'ج.م',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],

              SizedBox(height: 20),

              // Years input
              if (calculationType == ' أقصى مبلغ' ||
                  calculationType == 'تسديد قرض قديم' ||
                  calculationType == ' القسط الشهري' ||
                  calculationType == ' المبلغ من القسط') ...[
                YearsInput(
                  controller: _getYearsControllerForCalculationType(),
                  point: point.toString(),
                  selectedMonths: selectedMonths,
                  remainingYears: remainingYears,
                  customerAge: customerAge,
                  onChanged: (value) {
                    _updatePointAndMonths();
                  },
                ),
              ],

              SizedBox(height: 20),

              ActionButtons(
                onClear: clearInputs,
                onCalculate: () {
                  switch (calculationType) {
                    case ' أقصى مبلغ':
                      calculateLoan();
                      break;
                    case ' القسط الشهري':
                      calculateMonthlyPayment();
                      break;
                    case ' المبلغ من القسط':
                      calculateLoanFromMonthlyPayment();
                      break;
                    case 'تسديد قرض قديم':
                      calculateLoanSettlement();
                      break;
                  }
                },
                calculateButtonText: _getCalculationButtonText(),
              ),

              SizedBox(height: 30),

              // Results sections - FIXED: استخدام المتغيرات المناسبة لكل نوع حساب
              if (calculationType == ' أقصى مبلغ' && maxAmount_s > 0) ...[
                _buildMaxAmountResults(),
              ] else if (calculationType == ' القسط الشهري' && monthlyPayment_calculatedMonthlyInstallment > 0) ...[
                _buildMonthlyPaymentResults(),
              ] else if (calculationType == ' المبلغ من القسط' && loanFromPayment_calculatedLoanAmount > 0) ...[
                _buildLoanFromPaymentResults(),
              ] else if (calculationType == 'تسديد قرض قديم' && settlement_newLoanRequired > 0)
                _buildLoanSettlementResults(),
            ],
          ),
        ),
      ),
    );
  }
}