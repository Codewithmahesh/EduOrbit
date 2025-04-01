import 'package:edu_orbit/bottomNavScreen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _backgroundOpacity;
  late Animation<double> _transcriptOpacity;
  late Animation<double> _formOpacity;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _backgroundOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.4, curve: Curves.easeIn),
      ),
    );

    _transcriptOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    _formOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        _animationController.forward();
      });
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                height: screenHeight,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.01, // Adjust padding dynamically
                ),
                child: Stack(
                  children: [
                    // Background Image (Responsive)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Opacity(
                        opacity: _backgroundOpacity.value,
                        child: Container(
                          height: 396,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Group_4.png'),
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Logo (Responsive)
                    Positioned(
                      top: screenHeight * 0.2, // Adjusted for different heights
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: screenWidth * 0.6, // Scale width dynamically
                            height: screenHeight * 0.08,
                          ),
                        ),
                      ),
                    ),

                    // Transcript Image (Responsive)
                    Positioned(
                      top: screenHeight * 0.35, // Position dynamically
                      left: 0,
                      right: 0,
                      child: Opacity(
                        opacity: _transcriptOpacity.value,
                        child: Container(
                          height: screenHeight * 0.3, // Scale image size
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/transcript_1.png'),
                              fit: BoxFit.contain,
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Login Form (Responsive)
                    Positioned(
                      top: screenHeight * 0.6,
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      child: Opacity(
                        opacity: _formOpacity.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontSize: screenWidth * 0.08,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 27, 27, 27),
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "Good to see you",
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 27, 27, 27),
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            SizedBox(
                              width: double.infinity,
                              height:
                                  screenHeight * 0.07, // Adjust button height
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 223, 101, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.045),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
