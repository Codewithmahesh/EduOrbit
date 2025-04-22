import 'package:flutter/material.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  int _selectedTab = 0;
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Complaints Box'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTab = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selectedTab == 0 ? Colors.orange : Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'My Complaints',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_selectedTab == 0) ...[
              const Text(
                'Register a Complaint',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Describe your Complaint',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add submission logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ] else if (_selectedTab == 1) ...[
              const Center(
                child: Text(
                  'My Complaints (To be implemented)',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}