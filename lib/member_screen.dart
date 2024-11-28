import 'package:flutter/material.dart';
import 'package:location123/location_screen.dart';
import 'member.dart';

class MemberScreen extends StatefulWidget {
  final List<Member> members;

  const MemberScreen({super.key, required this.members});

  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  List<Member> filteredMembers = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredMembers = widget.members; // Initially, show all members
  }

  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredMembers = widget.members
          .where((member) =>
              member.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Members"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: _updateSearchQuery,
              decoration: InputDecoration(
                labelText: "Search Members",
                hintText: "Enter member name",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          // Member List
          Expanded(
            child: ListView.builder(
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                final member = filteredMembers[index];

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(member.imageUrl),
                    ),
                    title: Text(member.name),
                    subtitle: Text(member.status),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationScreen(member: member),
                        ),
                      );
                    },
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
