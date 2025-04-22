import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _selectedIndex = 0;

  final List<IconData> _sidebarIcons = [
    Icons.home,
    Icons.check_circle_outline,
    Icons.phone_iphone,
    Icons.favorite,
    Icons.cancel,
    Icons.attach_money,
    Icons.calendar_today,
    Icons.description,
  ];

  final List<String> _sidebarLabels = [
    'Home',
    'Verify',
    'Mobile',
    'Heart',
    'Cancel',
    'Money',
    'Calendar',
    'Docs',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Overlay
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images2/bg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  // ignore: deprecated_member_use
                  Color.fromRGBO(255, 165, 0, 0.8),
                  BlendMode.softLight,
                ),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/college_logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'MGM',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Powered by EduOrbit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Sidebar
          SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 60,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: _sidebarIcons.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onItemTapped(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? Colors.blue.withOpacity(0.8)
                              : Colors.transparent,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Icon(
                          _sidebarIcons[index],
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}