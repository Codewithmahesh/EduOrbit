import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content area
          Padding(
            padding: const EdgeInsets.only(left: 60),
            child: Container(
              color: Colors.deepOrange,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // College content
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Illustration of students and building
                          SizedBox(
                            height: 250,
                            child: Image.asset(
                              'assets/images2/Students talking in front of university.png',
                              errorBuilder: (context, error, stackTrace) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          // College name
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'MGM College of Engineering',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                          const Text(
                            'Powered by EduOrbit',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sidebar with circular icons
          SafeArea(
            child: Container(
              width: 60,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      children: [
                        _buildSidebarIcon(0, 'College', Icons.account_balance),
                        _buildSidebarIcon(1, 'Voting', Icons.phone_android),
                        _buildSidebarIcon(3, 'Complains', Icons.chat_bubble),
                        _buildSidebarIcon(4, 'Accounting', Icons.payment),
                        _buildSidebarIcon(
                            5, 'Facility Booking', Icons.calendar_today),
                        _buildSidebarIcon(6, 'Notes', Icons.description),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarIcon(int index, String label, IconData icon) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Tooltip(
              message: label,
              verticalOffset: 0,
              preferBelow: false,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.orange : Colors.blue.shade700,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.orange.shade700
                        : Colors.blue.shade800,
                    width: 2,
                  ),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
