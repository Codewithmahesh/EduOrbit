// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class UpcomingEventsCard extends StatefulWidget {
  const UpcomingEventsCard({super.key});

  @override
  State<UpcomingEventsCard> createState() => _UpcomingEventsCardState();
}

class _UpcomingEventsCardState extends State<UpcomingEventsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _events = [
    {
      'title': 'Student Council Election',
      'timeRange': '9:00 AM - 6:00 PM',
    },
    {
      'title': 'Career Fair',
      'timeRange': '10:00 AM - 4:00 PM',
    },
    {
      'title': 'Tech Workshop',
      'timeRange': '2:00 PM - 5:00 PM',
    },
    {
      'title': 'Guest Lecture: AI in Healthcare',
      'timeRange': '1:00 PM - 3:00 PM',
    },
    {
      'title': 'Hackathon Kickoff',
      'timeRange': '8:00 AM - 8:00 PM',
    },
    {
      'title': 'Alumni Networking Event',
      'timeRange': '5:00 PM - 7:00 PM',
    },
    {
      'title': 'Cultural Fest',
      'timeRange': '10:00 AM - 10:00 PM',
    },
  ];

  int _currentEventIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    // Card slides from bottom (0.5) to original position (0.0)
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.8, curve: Curves.easeOutQuint),
    ));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    // Add a small delay before starting animation
    Future.delayed(Duration(milliseconds: 400), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextEvent() {
    setState(() {
      _currentEventIndex = (_currentEventIndex + 1) % _events.length;
    });
  }

  void _previousEvent() {
    setState(() {
      _currentEventIndex =
          (_currentEventIndex - 1 + _events.length) % _events.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          width: screenWidth * 0.9,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade200, width: 1),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      'Upcoming Events',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
              _buildEventCard(),
              _buildIndicators(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _events[_currentEventIndex]['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _events[_currentEventIndex]['timeRange'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              // View event details action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 0,
            ),
            child: Text(
              'View',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicators() {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _previousEvent,
            child: Container(
              width: 30,
              height: 20,
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey),
            ),
          ),
          ...List.generate(
            _events.length,
            (index) => Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentEventIndex == index
                    ? Color(0xFF4A65C0)
                    : Colors.grey.shade300,
              ),
            ),
          ),
          GestureDetector(
            onTap: _nextEvent,
            child: Container(
              width: 30,
              height: 20,
              alignment: Alignment.center,
              child:
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
