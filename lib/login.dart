// login.dart (modified version of your code)
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

    // Animation controller with longer duration
    _animationController = AnimationController(
      vsync: this,
      duration:
          Duration(milliseconds: 1200), // Longer duration for other animations
    );

    // Significantly delay background fade-in to allow logo to finish moving
    _backgroundOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.4, curve: Curves.easeIn), // Start sooner
      ),
    );

    // Delay other animations accordingly
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

    // Start animation after a longer delay to ensure hero animation is well underway
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Delay the start of background/content animations
      // This gives the logo time to move up before other content appears
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    // Background image (Group_4.png)
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

                    // Logo (carried over from splash screen)
                    Positioned(
                      top:
                          130, // Using your updated position from the pasted code
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 263,
                            height: 79,
                          ),
                        ),
                      ),
                    ),

                    // Transcript image
                    Positioned(
                      top: 280,
                      left: 0,
                      right: 0,
                      child: Opacity(
                        opacity: _transcriptOpacity.value,
                        child: Container(
                          height: 240,
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

                    // Login form
                    Positioned(
                      top: 470,
                      left: 20,
                      right: 20,
                      child: Opacity(
                        opacity: _formOpacity.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 27, 27, 27),
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "Good to see you",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 27, 27, 27),
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // Add forgot password functionality
                                      },
                                      child: Text(
                                        "Forgot Password?",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Add signup functionality
                                      },
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 141, 47,
                                                10)), // Matching button color
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 223,
                                          101, 1), // Added orange background
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavScreen()));
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            )
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
