import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                color: Colors.deepOrange,
              ),
              Positioned(
                top: 50,
                left: 20,
                child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: Icon(Icons.settings, color: Colors.white, size: 30),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/profile.png'), // replace with your asset
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('Sara Daxter',
                        style: TextStyle(color: Colors.white70, fontSize: 18)),
                    Text('#240217045519',
                        style: TextStyle(color: Colors.white54, fontSize: 14)),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                profileInfo(Icons.cake, '19'),
                profileInfo(Icons.school, 'CSE'),
                profileInfo(Icons.person, 'student'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contactDetail('Email', 'xyz@gmail.com'),
                contactDetail('Address', 'church street, sector 22'),
                contactDetail('Phone No.', '3674357754'),
                contactDetail('Admission Year', '2024 - 2027'),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Edit', style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }

  Widget profileInfo(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.deepOrange),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget contactDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
                text: '$label: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}