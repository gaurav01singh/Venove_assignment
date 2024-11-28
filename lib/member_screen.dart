// Displays a list of members with there status

import 'package:flutter/material.dart';
import 'package:location123/location_screen.dart';
import 'member.dart'; 

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
        itemCount: members.length, 
        itemBuilder: (context, index) {
          final member = members[index]; 

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
    );
  }
}
