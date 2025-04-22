import 'package:flutter/material.dart';
import 'package:edu_orbit/CollegeAdminApp.dart';
import 'package:edu_orbit/bottomNavScreen.dart';

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

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String _correctUser = "n";
  final String _correctUserPassword = "n";

  final String _correctAdmin = "admin";
  final String _correctAdminPassword = "admin123";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _backgroundOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.4, curve: Curves.easeIn),
      ),
    );

    _transcriptOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeIn),
      ),
    );

    _formOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final user = _userController.text.trim();
    final password = _passwordController.text.trim();

    if (user == _correctUser && password == _correctUserPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavScreen()),
      );
    } else if (user == _correctAdmin && password == _correctAdminPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminDashboard()),
      );
    } else if ((user == _correctUser && password != _correctUserPassword) ||
        (user == _correctAdmin && password != _correctAdminPassword)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid password"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid user or password"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                height: screenHeight,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Opacity(
                        opacity: _backgroundOpacity.value,
                        child: Container(
                          height: 396,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Group_4.png'),
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.2,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: screenWidth * 0.6,
                            height: screenHeight * 0.08,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenHeight * 0.35,
                      left: 0,
                      right: 0,
                      child: Opacity(
                        opacity: _transcriptOpacity.value,
                        child: Container(
                          height: screenHeight * 0.3,
                          decoration: const BoxDecoration(
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
                                color: const Color.fromARGB(255, 27, 27, 27),
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Text(
                              "Good to see you",
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                color: const Color.fromARGB(255, 27, 27, 27),
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            TextField(
                              controller: _userController,
                              decoration: InputDecoration(
                                labelText: 'User',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            TextField(
                              controller: _passwordController,
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
                              height: screenHeight * 0.07,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 223, 101, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: _handleLogin,
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                  ),
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
