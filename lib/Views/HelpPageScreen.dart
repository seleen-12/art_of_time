import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPageScreen extends StatefulWidget {
  const HelpPageScreen({super.key, required this.title});

  final String title;

  @override
  State<HelpPageScreen> createState() => HelpPageScreenState();
}

class HelpPageScreenState extends State<HelpPageScreen> {
  List<bool> _isExpanded = List<bool>.filled(6, false);

  final List<String> buttonTitles = [
    "تنظيم أوقات النوم",
    "تنظيم الوقت وتحديد الأولويات",
    "تقسيم المهام اليومية",
    "الحد من المشتتات الرقمية",
    "أخذ فترات راحة منتظمة",
    "تقييم الأداء اليومي وتطويره"
  ];

  final List<String> youtubeLinks = [
    "https://youtu.be/jqlCiLrWQ6U?si=3zuEO-itfNmt5DRh",
    "https://youtu.be/tYoAaHvSfOc?si=JxwvdRb4zZGtyKm4",
    "https://youtu.be/lgyOc1XR2og?si=lDVb8YTpg6QNsWMT",
    "https://youtu.be/1D7jEHCpN3o?si=supkgdiOfieOdnWM",
    "https://youtu.be/RKbI_fsWfbw?si=1CLF02ki4s7px227",
    "https://youtu.be/KdRP7VncPac?si=xBgB0fU3I2APbaB6",
  ];

  final List<String> googleLinks = [
    "https://www.mayoclinic.org/ar/healthy-lifestyle/adult-health/in-depth/sleep/art-20048379",
    "https://www.argaam.com/ar/article/articledetail/id/1617219",
    "https://www.ch-mafaza.com/%D9%85%D9%87%D8%A7%D8%B1%D8%A7%D8%AA/%D9%86%D8%B5%D8%A7%D8%A6%D8%AD-%D9%84%D8%AA%D9%86%D8%B8%D9%8A%D9%85-%D8%A7%D9%84%D8%A3%D9%86%D8%B4%D8%B7%D8%A9-%D8%A7%D9%84%D9%8A%D9%88%D9%85%D9%8A%D8%A9-%D8%A8%D9%81%D8%B9%D8%A7%D9%84%D9%8A%D8%A9/",
    "https://www.mohajer.net/%D9%83%D9%8A%D9%81-%D8%AA%D8%AA%D8%AE%D9%84%D8%B5-%D9%85%D9%86-%D8%A7%D9%84%D9%85%D8%B4%D8%AA%D8%AA%D8%A7%D8%AA-%D8%A7%D9%84%D8%B1%D9%82%D9%85%D9%8A%D8%A9%D8%9F/",
    "https://fastercapital.com/arabpreneur/%D9%81%D8%AA%D8%B1%D8%A7%D8%AA-%D8%A7%D9%84%D8%B1%D8%A7%D8%AD%D8%A9--%D9%83%D9%8A%D9%81%D9%8A%D8%A9-%D8%A3%D8%AE%D8%B0-%D9%81%D8%AA%D8%B1%D8%A7%D8%AA-%D8%B1%D8%A7%D8%AD%D8%A9-%D9%81%D8%B9%D8%A7%D9%84%D8%A9-%D9%88%D8%A5%D8%B9%D8%A7%D8%AF%D8%A9-%D8%B4%D8%AD%D9%86-%D8%AF%D9%85%D8%A7%D8%BA%D9%83.html",
    "https://clickup.com/ar/blog/160498/goal-setting-for-performance-review-appraisal",
  ];

  Future<void> _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Widget _buildMainButton(int index) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isExpanded[index] = !_isExpanded[index];
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          child: Text(
            buttonTitles[index],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color:Colors.white),
          ),
        ),
        if (_isExpanded[index])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => _launchURL(youtubeLinks[index]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                  ),
                  child: const Text("Youtube", style: TextStyle(fontSize: 16 ,color:Colors.white)),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _launchURL(googleLinks[index]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 3,
                  ),
                  child: const Text("Google", style: TextStyle(fontSize: 16 ,color:Colors.white)),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(6, (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: _buildMainButton(index),
              )),
            ),
          ),
        ),
      ),
    );
  }
}