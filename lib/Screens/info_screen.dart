import 'package:flutter/material.dart';

class calculatePage extends StatelessWidget {
  const calculatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'info',
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

            const SizedBox(height: 20),

            // قسم معادلات الحساب
            _buildSection(
              title: 'معادلات الحساب',
              icon: Icons.calculate,
              children: [
                _buildStepItem(
                  step: 1,
                  title: 'النسب المسموح بها',
                  description: ' صاحب معاش/موظف : 90% من الراتب •\n'
                      'واريثة من الزوج : 90% من المعاش • \n'
                      ' واريثة من الأب/الأم : 75% من المعاش •\n'
                      'واريث من الأب/الأم : 90% من المعاش •\n'
                      '        القومسيون الطبي(مدي الحياه) --        \n'
                      'واريث من الأب/الأم : 75% من المعاش •\n'
                      '        القومسيون الطبي(كل 3 او 5 سنين) --        '
                ),
                _buildStepItem(
                  step: 2,
                  title: 'المعادلات الأساسية',
                  description: ' المسموح به = (الراتب × نسبة المسموح) - الأقساط السابقة\n'
                      ' أقصى مبلغ = (المسموح به × عدد الأشهر) ÷ نقطة \n'
                      ' القسط الشهري = إجمالي المديونية ÷ عدد الأشهر',
                ),
                _buildStepItem(
                  step: 3,
                  title: 'تسديد قرض قديم بقرض جديد',
                  description: ' المسموح النهائي = (المسموح من الراتب -الاقساط السابقه)+ القسط من القرض المراد تسديده \n'
                      ' القرض الجديد = (المسموح النهائي × عدد الأشهر) ÷ نقطة \n'
                      ' القسط الجديد = (القرض الجديد × نقطة ) ÷ عدد الأشهر',
                ),
              ],
            ),

            const SizedBox(height: 25),

            // قسم شروط القرض
            _buildSection(
              title: 'شروط القرض',
              icon: Icons.settings,
              children: [
                _buildInfoItem(Icons.timelapse, 'أقصى مدة سداد', '10 سنوات للجميع'),
                _buildInfoItem(Icons.timer_off, 'أقل مدة سداد', 'سنة واحدة'),
                _buildInfoItem(Icons.child_care, 'الحد الأدنى للعمر', '35 سنة'),
                _buildInfoItem(Icons.elderly, 'الحد الأقصى للعمر', '70 للموظفين، 60 لغيرهم'),
                _buildInfoItem(Icons.money, 'الحد الادني للقرض', '5000'),
                const SizedBox(height: 15),
                const Text(
                  'الخصومات:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF3C467B),
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                _buildFeatureItem('مصاريف اداريه 2% من مبلغ القرض'),
                _buildFeatureItem(' ضرائب 29 جنيه'),
              ],
            ),

            const SizedBox(height: 25),

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

  // دالة لبناء عنصر الميزة
  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 16,
          ),
        ],
      ),
    );
  }

  // دالة لبناء خطوة الاستخدام
  Widget _buildStepItem({
    required int step,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF3C467B),
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          CircleAvatar(
            backgroundColor: Color(0xFF3C467B),
            radius: 16,
            child: Text(
              step.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة لبناء عنصر المعلومات
  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: Color(0xFF3C467B), size: 18),
        ],
      ),
    );
  }
}

// دالة لفتح صفحة About من أي مكان في التطبيق
void navigateToAboutPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const calculatePage()),
  );
}