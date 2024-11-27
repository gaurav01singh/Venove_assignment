import 'package:flutter/material.dart';
import 'package:location123/location_screen.dart';
import 'member.dart'; // Your Member model file

class MemberScreen extends StatelessWidget {
  final List<Member> members;

  const MemberScreen({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Members"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: members.length, // Use the passed list's length
        itemBuilder: (context, index) {
          final member = members[index]; // Get each member from the list

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(member.imageUrl), // Profile image
              ),
              title: Text(member.name),
              subtitle: Text(member.status),
              onTap: () {
                // When a member is tapped, navigate to the LocationScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationScreen(member: member), // Pass member data to LocationScreen
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
