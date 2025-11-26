import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF3C467B),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // شعار التطبيق
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: Colors.yellow, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'lib/images/bank_nasser.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // قسم كيفية استخدام البرنامج
            _buildSection(
              title: 'كيفية استخدام البرنامج',
              icon: Icons.help,
              children: [
                _buildStepItem(
                  step: 1,
                  title: 'اختر نوع العميل',
                  description: 'لا يشترط تحديد نوع العميل في حاله القسط الشهري او المبلغ من القسط \n'
                      'في حاله اقصي مبلغ او تسديد قرض قديم يشترط اختيار نوع العميل و يمكنك اختيار أكثر من نوع إذا كان لديه أكثر من مصدر دخل \n'
                      'لا يمكنك تحديد (صاحب معاش + موظف)',
                ),
                const Divider(height: 20),
                _buildStepItem(
                  step: 2,
                  title: 'اختر نوع الحساب',
                  description: 'أقصى مبلغ: لمعرفة أقصى مبلغ يمكنك الحصول عليه • \n'
                      ' القسط الشهري: لحساب القسط لمبلغ معين •\n'
                      ' المبلغ من القسط: لمعرفة المبلغ المتاح بناءً على القسط •\n'
                      ' تسديد قرض قديم: لدمج قرض قديم مع قرض جديد •',
                ),
                const Divider(height: 20),
                _buildStepItem(
                  step: 5,
                  title: 'أدخل البيانات المطلوبة',
                  description: ' أدخل تاريخ الميلاد (يوم شهر سنة) •\n'
                      ' أدخل الراتب أو المعاش •\n'
                      ' أدخل الأقساط السابقة (أدخل 0 إذا لم توجد) •\n'
                      ' سيتم تحديد أقصى عدد السنين تلقائياً عند ادخال تاريخ   •\n'
                      '  الميلاد + نوع العميل\n'
                      'ملاحظة: مسح المدخلات السابقة عند إدخال تاريخ جديد لحساب العمر و اقصي عدد لسنين بشكل صحيح ',
                ),
                const Divider(height: 20),
                _buildStepItem(
                  step: 5,
                  title: 'اضغط على احسب',
                  description: ' انقر على زر "احسب" للحصول على النتائج •\n'
                      ' ستظهر لك جميع تفاصيل القرض •\n'
                      '  استخدم زر بجانب زر"احسب" الإعادة ادخال المدخلات •\n'
                      'تاريخ الميلاد - الراتب/ المعاش - الاقساط السابقه -عدد السنين \n'
                      ' استخدم زر "حساب جديد" لاعاده ضبط جميع المدخلات •',
                ),
              ],
            ),

            const SizedBox(height: 25),

            // قسم أنواع الحسابات
            _buildSection(
              title: 'أنواع الحسابات المتاحة',
              icon: Icons.list,
              children: [
                _buildCalculationTypeItem('أقصى مبلغ', 'لمعرفة أقصى مبلغ يمكنك اقتراضه'),
                _buildCalculationTypeItem('القسط الشهري', 'لحساب القسط لمبلغ معين'),
                _buildCalculationTypeItem('المبلغ من القسط', 'لمعرفة المبلغ المتاح بناءً على القسط المراد دفعه كل شهر'),
                _buildCalculationTypeItem('تسديد قرض قديم', 'لدمج قرض قديم مع قرض جديد'),
              ],
            ),

            const SizedBox(height: 25),

            // حقوق النشر
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Developed by : Monda Atef Ayad' ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '  몬다  \n 2025',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // دالة لبناء قسم
  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // عنوان القسم
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3C467B),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(icon, color: Color(0xFF3C467B), size: 24),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }

  // دالة لبناء نوع الحساب
  Widget _buildCalculationTypeItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF3C467B),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_back,
              color: Color(0xFF3C467B),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // دالة لبناء خطوة الاستخدام (بدون boxes)
  Widget _buildStepItem({
    required int step,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF3C467B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Color(0xFF3C467B),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          step.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// دالة لفتح صفحة About من أي مكان في التطبيق
void navigateToAboutPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AboutPage()),
  );
}