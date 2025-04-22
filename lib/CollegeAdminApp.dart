import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _grievances = [
    {
      'id': '#GR-1001',
      'title': 'Library hours extension',
      'submittedBy': 'Anonymous',
      'date': '2023-11-15',
      'status': 'Open',
    },
    // Add other grievance data similarly
  ];

  final List<Map<String, dynamic>> _approvals = [
    {
      'id': '#AP-2001',
      'type': 'Event',
      'title': 'Tech Fest 2023',
      'submittedBy': 'CS Department',
      'date': '2023-11-15',
      'amount': '\$5,000',
      'status': 'Pending',
    },
    // Add other approval data similarly
  ];

  final List<Map<String, dynamic>> _studentWallPosts = [
    {
      'user': 'Pranjal Shahane',
      'content': 'Excited for the upcoming Tech Fest!',
      'likes': 10,
      'comments': ['Great event!', 'Can’t wait!'],
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildDashboard(context),
      const Center(child: Text('Students Page')),
      const Center(child: Text('Faculty Page')),
      const Center(child: Text('Elections Page')),
      const Center(child: Text('Grievances Page')),
      const Center(child: Text('Bookings Page')),
      const Center(child: Text('Approvals Page')),
      const Center(child: Text('Budget Page')),
      const Center(child: Text('System Settings Page')),
      const Center(child: Text('Admin Settings Page')),
    ];

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Theme.of(context).primaryColor,
                  child: const Row(
                    children: [
                      Icon(Icons.account_balance, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'College Admin',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      _buildMenuSection('Main', [
                        {
                          'icon': Icons.dashboard,
                          'title': 'Dashboard',
                          'index': 0
                        },
                        {'icon': Icons.people, 'title': 'Students', 'index': 1},
                        {'icon': Icons.school, 'title': 'Faculty', 'index': 2},
                      ]),
                      _buildMenuSection('Management', [
                        {
                          'icon': Icons.how_to_vote,
                          'title': 'Elections',
                          'index': 3
                        },
                        {
                          'icon': Icons.comment,
                          'title': 'Grievances',
                          'index': 4
                        },
                        {'icon': Icons.event, 'title': 'Bookings', 'index': 5},
                        {
                          'icon': Icons.check_circle,
                          'title': 'Approvals',
                          'index': 6
                        },
                        {
                          'icon': Icons.account_balance_wallet,
                          'title': 'Budget',
                          'index': 7
                        },
                      ]),
                      _buildMenuSection('Settings', [
                        {'icon': Icons.settings, 'title': 'System', 'index': 8},
                        {
                          'icon': Icons.admin_panel_settings,
                          'title': 'Admin',
                          'index': 9
                        },
                        {'icon': Icons.logout, 'title': 'Logout', 'index': 10},
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...items.map((item) => ListTile(
              leading: Icon(item['icon'],
                  color: _selectedIndex == item['index']
                      ? Theme.of(context).primaryColor
                      : Colors.grey[800]),
              title: Text(item['title']),
              selected: _selectedIndex == item['index'],
              onTap: () => _onItemTapped(item['index']),
              selectedTileColor: Colors.blue.withOpacity(0.1),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            )),
      ],
    );
  }

  Widget _buildDashboard(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Admin Dashboard',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        const Icon(Icons.notifications, size: 24),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF72585),
                              shape: BoxShape.circle,
                            ),
                            child: const Text('3',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/men/32.jpg'),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Admin User', style: TextStyle(fontSize: 14)),
                        Text('Super Admin',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Stats Cards
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildCard('Pending Approvals', '24', '+5 from yesterday',
                  Icons.assignment, '15 require immediate attention'),
              _buildCard(
                  'Active Elections',
                  '3',
                  'Student Council voting ongoing',
                  Icons.how_to_vote,
                  '1,245 votes cast'),
              _buildCard('Open Grievances', '18', '5 new today', Icons.comment,
                  '3 marked urgent'),
              _buildCard('Facility Bookings', '12', '3 pending approval',
                  Icons.event, 'Auditorium booked today'),
            ],
          ),
          const SizedBox(height: 30),
          // Student Wall
          _buildStudentWall(),
          const SizedBox(height: 30),
          // Recent Grievances Table
          _buildTable(
            title: 'Recent Grievances',
            headers: [
              'ID',
              'Title',
              'Submitted By',
              'Date',
              'Status',
              'Actions'
            ],
            rows: _grievances
                .map((g) => [
                      g['id'],
                      g['title'],
                      g['submittedBy'],
                      g['date'],
                      _buildStatusChip(g['status']),
                      Row(
                        children: [
                          _buildActionButton('View', Colors.blue),
                          if (g['status'] != 'Resolved')
                            _buildActionButton('Resolve', Colors.teal),
                        ],
                      ),
                    ])
                .toList(),
          ),
          const SizedBox(height: 30),
          // Pending Approvals Table
          _buildTable(
            title: 'Pending Approvals',
            headers: [
              'ID',
              'Type',
              'Title',
              'Submitted By',
              'Date',
              'Amount',
              'Status',
              'Actions'
            ],
            rows: _approvals
                .map((a) => [
                      a['id'],
                      a['type'],
                      a['title'],
                      a['submittedBy'],
                      a['date'],
                      a['amount'],
                      _buildStatusChip(a['status']),
                      Row(
                        children: [
                          _buildActionButton('View', Colors.blue),
                          if (a['status'] == 'Pending') ...[
                            _buildActionButton('Approve', Colors.teal),
                            _buildActionButton('Reject', Colors.red),
                          ],
                        ],
                      ),
                    ])
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String value, String subtitle, IconData icon,
      String footer) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Icon(icon, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(value,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const Spacer(),
            Divider(color: Colors.grey[200]),
            Text(footer,
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(
      {required String title,
      required List<String> headers,
      required List<List<dynamic>> rows}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'Search $title...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: headers
                    .map((h) => DataColumn(
                        label: Text(h.toUpperCase(),
                            style: TextStyle(color: Colors.grey[600]))))
                    .toList(),
                rows: rows
                    .map((row) => DataRow(
                        cells: row
                            .map((cell) => DataCell(
                                cell is Widget ? cell : Text(cell.toString())))
                            .toList()))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Open':
        color = Colors.grey;
        break;
      case 'Pending':
        color = const Color(0xFFF8961E);
        break;
      case 'Approved':
        color = const Color(0xFF4CC9F0);
        break;
      case 'Rejected':
        color = const Color(0xFFF72585);
        break;
      case 'Resolved':
        color = Theme.of(context).primaryColor;
        break;
      default:
        color = Colors.grey;
    }
    return Chip(
      label: Text(status,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color),
    );
  }

  Widget _buildActionButton(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size(60, 30),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 12)),
      ),
    );
  }

  Widget _buildStudentWall() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Student Wall',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'Search posts...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              maxLength: 280,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Share your thoughts...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _studentWallPosts.add({
                      'user': 'Current User',
                      'content': value,
                      'likes': 0,
                      'comments': [],
                    });
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ..._studentWallPosts.map((post) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/32.jpg'),
                          ),
                          const SizedBox(width: 10),
                          Text(post['user'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(post['content']),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            onPressed: () {
                              setState(() {
                                post['likes'] += 1;
                              });
                            },
                          ),
                          Text('${post['likes']} Likes'),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.comment),
                            onPressed: () {
                              // Placeholder for comment dialog
                            },
                          ),
                          Text('${post['comments'].length} Comments'),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
