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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content to the start
            children: [
              _buildAppHeader(),
              SizedBox(height: 50), // Increased spacing
              Text(
                "เลือกเมนูของคุณ", // Added a title for the features section
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              _buildFeatureButtons(), // Changed to use GetX navigation
              Spacer(), // Pushes the footer to the bottom
              _buildFooterText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppHeader() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align header content to the start
      children: [
        Container(
          // Added a container for gradient background
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.deepPurple.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Icon(
            FontAwesomeIcons.wandMagicSparkles, // Changed icon
            size: 50, // Reduced icon size for a sleeker look
            color: Colors.amber[200],
          ),
        ),
        SizedBox(height: 15),
        Text(
          'ดวงวิเศษของฉัน',
          style: TextStyle(
            fontSize: 32, // Increased font size
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              // Added text shadow for depth
              Shadow(
                blurRadius: 10.0,
                color: Colors.black.withOpacity(0.3),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          'เปิดเผยความลับแห่งดวงชะตา...',
          style: TextStyle(
            color: Colors.purple[200],
            fontSize: 16, // Increased font size
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureButtons() {
    return Expanded(
      // Use Expanded to allow GridView to take available space
      child: GridView.count(
        crossAxisCount: 2, // Display two cards per row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildFeatureCard(
            icon: FontAwesomeIcons.sun,
            label: "ดูดวงวันนี้",
            description: "ตรวจดวงชะตาประจำวันของคุณ",
            onTap: () => Get.toNamed('/horoscope'),
          ),
          _buildFeatureCard(
            icon:
                FontAwesomeIcons.addressCard, // Used a different icon for tarot
            label: "ไพ่ทาโรต์",
            description: "ค้นหาคำตอบด้วยไพ่ทาโรต์",
            onTap: () => Get.toNamed('/tarot'),
          ),
          // Add more feature cards here if needed
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    // New widget for feature cards
    required IconData icon,
    required String label,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8.0,
        color: Colors.deepPurple[700]?.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.amber[200]),
              SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.purple[100],
                  fontSize: 12,
                ),
              ),
            ],
          ),
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
