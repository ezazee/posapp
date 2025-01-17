import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lakasir/screens/domain/setup_screen.dart';
import 'package:lakasir/widgets/filled_button.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final bool isLastPage;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          if (isLastPage)
            Container(
              padding: const EdgeInsets.all(20),
              child: MyFilledButton(
                onPressed: () {
                  Get.to(const SetupScreen());
                },
                child: Text('get_started'.tr),
              ),
            ),
        ],
      ),
    );
  }
}
