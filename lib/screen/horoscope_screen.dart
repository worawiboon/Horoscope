import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/horoscope_controller.dart';
import 'package:http/http.dart' as http;

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
    );
  }

  Widget _buildZodiacSelector() {
    return Column(
      children: [
        Text(
          'เลือกราศีของคุณ',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _controller.zodiacSigns.map((sign) {
            return Obx(() => ChoiceChip(
                  label: Text(sign),
                  selected: _controller.selectedZodiac.value == sign,
                  onSelected: (selected) {
                    _controller.selectedZodiac.value = sign;
                    _controller.fetchHoroscope();
                  },
                  backgroundColor: Colors.deepPurple[800],
                  selectedColor: Colors.amber,
                  labelStyle: TextStyle(
                    color: _controller.selectedZodiac.value == sign
                        ? Colors.black
                        : Colors.white,
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
        style: TextStyle(color: Colors.white70),
      );
    }

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.deepPurple[800],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _controller.horoscopeData.value.zodiacSign,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'วันที่ ${DateTime.now().day}/${DateTime.now().month}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Divider(color: Colors.purple[300]),
          SizedBox(height: 10),
          Text(
            'คำทำนาย:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            _controller.horoscopeData.value.prediction,
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              _buildLuckyItem('เลขนำโชค', generateLuckyNumber()),
              SizedBox(width: 20),
              _buildLuckyItem('สีนำโชค', 'ฟ้า'),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.refresh),
              label: Text('ดูดวงใหม่'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: _controller.fetchHoroscope,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLuckyItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.purple[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.amber[200],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
