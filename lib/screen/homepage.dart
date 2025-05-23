import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _controller =
      Get.put(HomeController()); // ใส่ Controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAppHeader(),
              SizedBox(height: 40),
              _buildFeatureButtons(), // เปลี่ยนไปใช้ GetX navigation
              SizedBox(height: 30),
              _buildFooterText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Column(
      children: [
        Icon(
          FontAwesomeIcons.golfBallTee,
          size: 60,
          color: Colors.amber[200],
        ),
        SizedBox(height: 10),
        Text(
          'ดวงวิเศษของฉัน',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'เปิดเผยความลับแห่งดวงชะตา...',
          style: TextStyle(
            color: Colors.purple[200],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureButtons() {
    return Column(
      children: [
        // ปุ่มดูดวงประจำวัน (ใช้ Get.toNamed)
        Center(
          child: _buildMagicButton(
            icon: FontAwesomeIcons.sun,
            label: "ดูดวงวันนี้",
            onTap: () => Get.toNamed('/horoscope'), // ใช้ GetX Navigation
          ),
        ),
        SizedBox(height: 20),
        // ปุ่มไพ่ทาโรต์
        Center(
          child: _buildMagicButton(
            icon: FontAwesomeIcons.addressCard,
            label: "ไพ่ทาโรต์",
            onTap: () => Get.toNamed('/tarot'),
          ),
        ),
      ],
    );
  }

  Widget _buildMagicButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.deepPurple[700],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.amber[100]),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    return Text(
      'ผลทำนายเพื่อความบันเทิงเท่านั้น ❤️',
      style: TextStyle(
        color: Colors.grey[400],
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
