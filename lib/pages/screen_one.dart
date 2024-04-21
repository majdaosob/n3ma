import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:n3ma/pages/welcome/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  int _currentPage = 0;
  final _pageController = PageController();

  List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      title: "Welcome to N3ma!",
      description:
          "Easily manage your food inventory, minimize waste, and make a positive impact in your community.",
      image: 'lib/assets/one_image.png',
    ),
    OnboardingItem(
      title: "Effortless Food Management",
      description:
          "N3ma simplifies the process of organizing your food storage. Keep track of expiry dates, categorize items, and receive timely reminders to use ingredients before they expire.",
      image: "lib/assets/two_image.png",
    ),
    OnboardingItem(
      title: "Make a Difference, One Meal at a Time",
      description:
          "With N3ma, you can easily donate excess food to local charities and food banks. Help combat hunger in your community by sharing what you don't need.",
      image: "lib/assets/three_image.png",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomeScreen()));
                    },
                    child: Text(
                      "Skip",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(150,195,93,1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // Image.asset('lib/assets/one_image.png'),
                Expanded(
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: onboardingItems.length,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        final item = onboardingItems[index];
                        return Column(
                          children: [
                            Expanded(child: Image.asset(item.image)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              item.title,
                              style: GoogleFonts.montserrat(
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              item.description,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      }),
                ),
                Row(
                  children: List.generate(onboardingItems.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 10,
                        width: _currentPage == index ? 30 : 10,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Color.fromRGBO(150,195,93,1)
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(150,195,93,1),
          onPressed: () {
            if (_currentPage < onboardingItems.length - 1) {
              _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WelcomeScreen()));
            }
          },
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ));
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}
