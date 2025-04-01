import 'package:edu_orbit/homePage.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  final List<Widget> _pages = [
    MyHomePage(),
    Center(child: Text('Search Page')),
    Center(child: Text('Notifications Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    // Create animations for each nav item
    _animations = List.generate(
      4,
      (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.1 * index,
            0.1 * index + 0.6,
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );

    // Initialize with first item selected
    _animationController.value = 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      // Reset and run animation
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -1),
            ),
          ],
        ),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) => _buildNavItem(index)),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    bool isSelected = _selectedIndex == index;
    List<String> imageAssets = [
      'assets/images/image_4.png',
      'assets/images/image_7.png',
      'assets/images/image_6.png',
      'assets/images/image_5.png',
    ];

    return AnimatedBuilder(
      animation: _animations[index],
      builder: (context, child) {
        double animationValue = isSelected ? _animations[index].value : 1.0;
        
        return GestureDetector(
          onTap: () => _onItemTapped(index),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border(
                      top: BorderSide(
                        color: Colors.orange,
                        width: 3 * animationValue,
                      ),
                    )
                  : null,
            ),
            child: TweenAnimationBuilder(
              tween: Tween<double>(
                begin: isSelected ? 0.8 : 1.0,
                end: isSelected ? 1.0 : 0.8,
              ),
              curve: Curves.easeOutCubic,
              duration: Duration(milliseconds: 300),
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Image.asset(
                imageAssets[index],
                width: isSelected ? 30 : 23,
                height: isSelected ? 30 : 23,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}