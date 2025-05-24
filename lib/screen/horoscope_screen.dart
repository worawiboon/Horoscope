import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/horoscope_controller.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HoroscopeScreen extends StatelessWidget {
  final HoroscopeController _controller = Get.put(HoroscopeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      appBar: AppBar(
        title: Text('ดูดวงประจำวัน'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ส่วนเลือกราศี
              _buildZodiacSelector(),
              SizedBox(height: 30),
              // ส่วนแสดงผล
              Obx(() => _controller.isLoading.value
                  ? CircularProgressIndicator(color: Colors.amber)
                  : _buildHoroscopeResult()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZodiacSelector() {
    return Column(
      children: [
        Text(
          'เลือกราศีของคุณ',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: _controller.zodiacSigns.map((sign) {
            return Obx(() => ChoiceChip(
                  label: Text(sign),
                  selected: _controller.selectedZodiac.value == sign,
                  onSelected: (selected) {
                    _controller.selectedZodiac.value = sign;
                    _controller.fetchHoroscope();
                  },
                  backgroundColor: Colors.deepPurple[700],
                  selectedColor: Colors.amber[600],
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  labelStyle: TextStyle(
                    color: _controller.selectedZodiac.value == sign
                        ? Colors.deepPurple[900]
                        : Colors.white,
                    fontWeight: _controller.selectedZodiac.value == sign
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: _controller.selectedZodiac.value == sign
                          ? Colors.amber[700]!
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ));
          }).toList(),
        ),
      ],
    );
  }

  String generateLuckyNumber() {
    final random = Random();
    return '${random.nextInt(9) + 1}'; // สุ่มเลข 1-9
  }

  String generateLuckyColor() {
    final random = Random();
    final List<String> colors = [
      'แดง',
      'ชมพู',
      'ส้ม',
      'เหลือง',
      'เขียว',
      'ฟ้า',
      'น้ำเงิน',
      'ม่วง',
      'ขาว',
      'ดำ',
      'ทอง',
      'เงิน'
    ];
    return colors[random.nextInt(colors.length)];
  }

  Widget _buildLuckyNumber() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Text(
        _controller.horoscopeData.value.luckyNumber,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.amber,
        ),
      ),
    );
  }

  Widget _buildHoroscopeResult() {
    if (_controller.selectedZodiac.isEmpty) {
      return Text(
        'กรุณาเลือกราศี',
        style: TextStyle(color: Colors.white70, fontSize: 16),
      );
    }

    return Obx(() => AnimatedOpacity(
          opacity:
              _controller.horoscopeData.value.prediction.isNotEmpty ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Card(
            elevation: 8.0,
            color: Colors.deepPurple[800]?.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.purple[700]!, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _controller.horoscopeData.value.zodiacSign,
                        style: TextStyle(
                          color: Colors.amber[400],
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'วันที่ ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                  Divider(color: Colors.purple[400], thickness: 1, height: 30),
                  SizedBox(height: 10),
                  Text(
                    'คำทำนายดวงชะตา:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _controller.horoscopeData.value.prediction,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 16,
                        height: 1.4),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLuckyItem(FontAwesomeIcons.gem, 'เลขนำโชค',
                          generateLuckyNumber()),
                      _buildLuckyItem(FontAwesomeIcons.palette, 'สีนำโชค',
                          generateLuckyColor()),
                    ],
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.refresh, color: Colors.deepPurple[900]),
                      label: Text('ดูดวงใหม่',
                          style: TextStyle(
                              color: Colors.deepPurple[900],
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[600],
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 5.0,
                      ),
                      onPressed: _controller.fetchHoroscope,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildLuckyItem(IconData icon, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.amber[300], size: 18),
            SizedBox(width: 8),
            Text(title,
                style: TextStyle(color: Colors.grey[300], fontSize: 14)),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.deepPurple[900]?.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.purple[700]!, width: 1),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.amber[300],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
