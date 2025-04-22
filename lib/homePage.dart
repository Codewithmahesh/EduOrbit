// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable

import 'package:edu_orbit/components/QuickLinks.dart';
import 'package:edu_orbit/components/UpcomingEventsCard.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // Animation controller
  late AnimationController _animationController;
  late Animation<Offset> _profileSlideAnimation;
  late Animation<Offset> _activityCardSlideAnimation;
  late Animation<Offset> _recentActivityCardSlideAnimation;
  late Animation<double> _profileFadeAnimation;
  late Animation<double> _activityFadeAnimation;
  late Animation<double> _recentActivityFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller with slower duration for smoother effect
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    // Profile card slides from left (-1.0) to original position (0.0)
    _profileSlideAnimation = Tween<Offset>(
      begin: Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.7, curve: Curves.easeOutQuint),
    ));

    // First activity card slides from right (1.0) to original position (0.0)
    _activityCardSlideAnimation = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.1, 0.8, curve: Curves.easeOutQuint),
    ));

    // Second activity card slides from right (1.0) to original position (0.0)
    // with slight delay after the first card
    _recentActivityCardSlideAnimation = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.3, 0.9, curve: Curves.easeOutQuint),
    ));

    // Add fade animations for more smoothness
    _profileFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _activityFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.1, 0.7, curve: Curves.easeIn),
    ));

    _recentActivityFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.3, 0.8, curve: Curves.easeIn),
    ));

    // Add a small delay before starting animation for a better user experience
    Future.delayed(Duration(milliseconds: 100), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLogoSection(),
              Container(
                height: screenHeight, // Adjust this value as needed
                child: _buildMainContent(screenWidth, screenHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              'assets/images/logo.png',
              height: 34,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 2,
            color: Color.fromARGB(255, 221, 221, 221),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Group_69.png'),
          opacity: 0.7,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Animated profile card from left with fade
                FadeTransition(
                  opacity: _profileFadeAnimation,
                  child: SlideTransition(
                    position: _profileSlideAnimation,
                    child: _buildProfileCard(screenHeight),
                  ),
                ),
                SizedBox(width: screenWidth * 0.05),
                _buildAnimatedRightColumnWidgets(screenWidth, screenHeight),
              ],
            ),
          ),
          // Add the UpcomingEventsCard below the existing content
          SizedBox(height: screenHeight * 0.03),
          UpcomingEventsCard(),
          QuickLinks(),
        ],
      ),
    );
  }

  Widget _buildAnimatedRightColumnWidgets(
      double screenWidth, double screenHeight) {
    return Column(
      children: [
        // Animated first activity card from right with fade
        FadeTransition(
          opacity: _activityFadeAnimation,
          child: SlideTransition(
            position: _activityCardSlideAnimation,
            child: _buildActivityContainer(screenWidth),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        // Animated second activity card from right with delay and fade
        FadeTransition(
          opacity: _recentActivityFadeAnimation,
          child: SlideTransition(
            position: _recentActivityCardSlideAnimation,
            child: _buildRecentActivitiesContainer(screenWidth, screenHeight),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(double screenHeight) {
    return Container(
      width: 180,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(255, 204, 85, 0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.009),
          Text(
            "Me",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenHeight * 0.009),
          _buildProfileImage(),
          SizedBox(height: screenHeight * 0.006),
          _buildProfileDetails(screenHeight),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      height: 85,
      width: 85,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/man.png'),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileText("#12567", screenHeight),
        _buildProfileText("Samiksha", screenHeight, letterSpacing: 1.3),
        _buildProfileText("CSE", screenHeight),
        _buildProfileText("4th Sem", screenHeight),
      ],
    );
  }

  Widget _buildProfileText(String text, double screenHeight,
      {double letterSpacing = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontFamily: 'Poppins',
            letterSpacing: letterSpacing,
          ),
        ),
        SizedBox(height: screenHeight * 0.006),
      ],
    );
  }

  Widget _buildActivityContainer(double screenWidth) {
    return Container(
      height: 150,
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: Color(0xFF4A65C0), // Solid blue color from the image
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Activity",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 40,
                width: 40,
                child: Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitiesContainer(
      double screenWidth, double screenHeight) {
    return Container(
      height: 150,
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: Color(0xFFF9D74C), // Solid yellow color from the image
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Leaderboard",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(Icons.star, color: Colors.white, size: 30),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
