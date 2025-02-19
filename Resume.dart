import 'package:flutter/material.dart';

void main() {
  runApp(StudentResumeApp());
}

class StudentResumeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Resume',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResumeScreen(),
    );
  }
}

class ResumeScreen extends StatelessWidget {
  final String profileImageUrl = 'https://i.postimg.cc/7hNzmmBb/1.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Resume'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      child: ClipOval(
                        child: Image.network(
                          profileImageUrl,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.person,
                                size: 60, color: Colors.grey);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Teerakarn FongKham',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildSectionTitle('Personal Information'),
            Container(
              height: 2,
              color: Colors.black,
            ),
            buildInfoRow('ชื่อ-นามสกุล', 'นายธีรกานต์ ฟองคำ'),
            buildInfoRow('ชื่อเล่น', 'เฟิร์ส'),
            buildInfoRow('เพศ', 'ชาย'),
            buildInfoRow('วัน/เดือน/ปีเกิด', '16 เมษายน 2545'),
            buildInfoRow('เกรดเฉลี่ยสะสม (GPA)', '3.04'),
            SizedBox(height: 20),
            buildSectionTitle('Contact'),
            Container(
              height: 2,
              color: Colors.black,
            ),
            buildInfoRow('Phone', '096-4549141', Icons.phone),
            buildInfoRow('Email', 'ZoFirstza12340@gmail.com', Icons.email),
            buildInfoRow(
                'Github', 'https://github.com/FirstTeerakarn', Icons.link),
            buildInfoRow(
                'Address',
                '67/2 หมู่4 ซอย2 ต.ขัวมุง อ.สารภี จ.เชียงใหม่ 50140',
                Icons.location_on),
            SizedBox(height: 20),
            buildSectionTitle('Education'),
            Container(
              height: 2,
              color: Colors.black,
            ),
            buildInfoRow(
                'ปวช. วิทยาลัยเทคนิคเชียงใหม่', 'สาขา เทคนิคคอมพิวเตอร์'),
            buildInfoRow('ปวส. วิทยาลัยเทคนิคเชียงใหม่',
                'สาขา คอมพิวเตอร์ระบบเครือข่าย'),
            buildInfoRow('ปัจจุบัน มหาวิทยาลัยเทคโนโลยีราชมงคลล้านนา',
                'คณะ วิศวกรรมคอมพิวเตอร์'),
            SizedBox(height: 20),
            buildSectionTitle('Experience'),
            Container(
              height: 2,
              color: Colors.black,
            ),
            buildInfoRow('ห.จ.ก. AIS DD Vision', '', Icons.apartment),
            buildBulletPoint('ติดตั้งอินเทอร์เน็ตสายไฟเบอร์ (AIS)'),
            buildBulletPoint('ซ่อมแซมอินเทอร์เน็ต (AIS)'),
            buildInfoRow(
                'Northern System Corporation Co.,Ltd.', '', Icons.apartment),
            buildBulletPoint(
                'ติดตั้งระบบ Smart City, Smart security, Smart Home และอุปกรณ์ IoT'),
            buildBulletPoint(
                'ติดตั้งกล้อง CCTV, ซ่อมบำรุงกล้อง CCTV, ตรวจเช็คกล้องวงจรปิด'),
            buildBulletPoint(
                'ติดตั้งระบบเครือข่าย, ซ่อมบำรุงระบบเครือข่าย, ตรวจเช็คระบบเครือข่าย'),
            SizedBox(height: 20),
            buildSectionTitle('Skills'),
            Container(
              height: 2,
              color: Colors.black,
            ),
            buildSkillBar('Coding C', 3),
            buildSkillBar('Coding Dart', 3),
            buildSkillBar('Coding Python', 3),
            buildSkillBar('Internet Of Things (IOT)', 4),
            buildSkillBar('Video Editing', 5),
            buildSkillBar('Graphics Design', 5),
            buildSkillBar('Adobe Photoshop', 5),
            buildSkillBar('Microsoft Office', 5),
            SizedBox(height: 20),
            buildSectionTitle('คุณสมบัติ'),
            Container(
              height: 2,
              color: Colors.black,
            ),
            buildInfoRow('มนุษยสัมพันธ์ดี', '', Icons.check),
            buildInfoRow('พร้อมพัฒนาตัวเองอยู่เสมอ', '', Icons.check),
            buildInfoRow('มีวุฒิภาวะ รับแรงกดดันได้', '', Icons.check),
            buildInfoRow('มีทักษะการจัดการงานและเวลาที่ดี', '', Icons.check),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget buildInfoRow(String label, [String? value, IconData? icon]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          if (icon != null) ...[
            // เช็คว่า icon ไม่เป็น null
            Icon(icon, color: Colors.blue, size: 20),
            SizedBox(width: 10),
          ],
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(value ?? ''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSkillBar(String skill, int level) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(skill),
        SizedBox(height: 5),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              Icons.circle,
              size: 10,
              color: index < level ? Colors.blue : Colors.grey[300],
            );
          }),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 18)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
