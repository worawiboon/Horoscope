import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/horoscope_model.dart';

class HoroscopeController extends GetxController {
  var selectedZodiac = ''.obs;
  var isLoading = false.obs;
  var horoscopeData = Horoscope(
    zodiacSign: '',
    date: '',
    prediction: '',
    luckyNumber: '',
    luckyColor: '',
  ).obs;

  String generateLuckyNumber() {
    final random = Random();
    return '${random.nextInt(9) + 1}'; // สุ่มเลข 1-9
  }

  final List<String> zodiacSigns = [
    'ราศีเมษ',
    'ราศีพฤษภ',
    'ราศีเมถุน',
    'ราศีกรกฎ',
    'ราศีสิงห์',
    'ราศีกันย์',
    'ราศีตุลย์',
    'ราศีพิจิก',
    'ราศีธนู',
    'ราศีมกร',
    'ราศีกุมภ์',
    'ราศีมีน'
  ];

  // ใน Controller
  Future<void> fetchHoroscope() async {
    try {
      if (selectedZodiac.isEmpty) return;
      isLoading(true);

      // แปลงชื่อราศีเป็นภาษาอังกฤษ (เช่น ราศีเมษ -> aries)
      final zodiacMap = {
        'ราศีเมษ': 'aries',
        'ราศีพฤษภ': 'taurus',
        'ราศีเมถุน': 'gemini',
        'ราศีกรกฎ': 'cancer',
        'ราศีสิงห์': 'leo',
        'ราศีกันย์': 'virgo',
        'ราศีตุลย์': 'libra',
        'ราศีพิจิก': 'scorpio',
        'ราศีธนู': 'sagittarius',
        'ราศีมกร': 'capricorn',
        'ราศีกุมภ์': 'aquarius',
        'ราศีมีน': 'pisces'
      };
      final sign = zodiacMap[selectedZodiac.value] ?? 'aries';

      // เรียกใช้ API ใหม่ (ตัวอย่างใช้ Horoscope-App-API)
      final response = await http.get(
        Uri.parse(
            'https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?sign=$sign&day=today'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        horoscopeData.value = Horoscope(
          zodiacSign: selectedZodiac.value,
          date: data['date'] ?? 'N/A',
          prediction: data['horoscope_data'] ?? 'ไม่มีคำทำนาย',
          luckyNumber: data['lucky_number'] ?? '-',
          luckyColor: data['lucky_color'] ?? '-',
        );
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('ผิดพลาด', 'ไม่สามารถโหลดดวง: $e');
    } finally {
      isLoading(false);
    }
  }
}

//   void fetchHoroscope() async {
//     isLoading(true);
//     await Future.delayed(Duration(seconds: 1)); // ลองรับการโหลด

//     // ข้อมูลตัวอย่าง (แทนการเรียก API จริง)
//     horoscopeData.value = Horoscope(
//       zodiacSign: selectedZodiac.value,
//       date: '2023-11-20',
//       prediction: 'วันนี้เป็นวันที่ดี! คุณจะพบกับโอกาสใหม่ๆ',
//       luckyNumber: '7',
//       luckyColor: 'สีทอง',
//     );
//     isLoading(false);
//   }
// }
