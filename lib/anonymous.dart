import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _complaints = [];
  final _supabase = Supabase.instance.client;

  late TabController _tabController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchComplaints(); // load data initially
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchComplaints() async {
    setState(() => _loading = true);
    try {
      // Add debug print before query
      debugPrint('Attempting to fetch complaints from eduorbit table...');
      
      final response = await _supabase
          .from('eduorbit')
          .select()
          .order('created_at', ascending: false)
          .execute();
      
      // Add debug print after query
      debugPrint('Query completed. Data received: ${response.data?.length ?? 0} items');
      debugPrint('Data: ${response.data}');

      setState(() {
        _complaints.clear();
        if (response.data != null && response.data!.isNotEmpty) {
          final data = response.data!;
          for (var complaint in data) {
            debugPrint('Processing complaint: $complaint');
            _complaints.add({
              'id': complaint['id']?.toString() ?? 'No ID',
              'description': complaint['complaints']?.toString() ?? 'No description',
              'time': _formatTimestamp(complaint['created_at']),
            });
          }
          debugPrint('Complaints list updated. Size: ${_complaints.length}');
        } else {
          debugPrint('No complaints found in database');
        }
      });
    } catch (e) {
      debugPrint('Error fetching complaints: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load complaints: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null) return 'Unknown';
    try {
      final date = DateTime.parse(timestamp);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return timestamp;
    }
  }

  Future<void> submitComplaint() async {
    final description = _controller.text.trim();
    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a complaint')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      debugPrint('Attempting to insert complaint: $description');
      
      await _supabase.from('eduorbit').insert({
        'complaints': description,
        'created_at': DateTime.now().toIso8601String(),
      });
      
      debugPrint('Insert completed successfully');

      _controller.clear();
      debugPrint('Refreshing complaints list...');
      await fetchComplaints();
      _tabController.animateTo(1);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complaint submitted successfully')),
        );
      }
    } catch (e) {
      debugPrint('Insert failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit complaint: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaints"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Submit"),
            Tab(text: "View Complaints"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Submit Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Enter your complaint',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loading ? null : submitComplaint,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),

          // View Complaints Tab
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _complaints.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "No complaints yet.",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: fetchComplaints,
                          child: const Text("Refresh"),
                        ),
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: fetchComplaints,
                      child: ListView.builder(
                        itemCount: _complaints.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final item = _complaints[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                item['description'] ?? '',
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text("Submitted: ${item['time'] ?? ''}"),
                              trailing: Text("ID: ${item['id']}"),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}