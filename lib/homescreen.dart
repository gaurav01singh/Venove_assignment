import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location123/location_screen.dart';
import 'package:location123/mapscreen.dart';
import 'package:location123/member.dart';
import 'package:location123/member_screen.dart'; // Import the MemberScreen

class HomeScreen extends StatefulWidget {
  final List<Member> members;

  const HomeScreen({super.key, required this.members});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Method to get the current date in the desired format
  String _getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('EEE, MMM dd yyyy');

    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: const Color.fromARGB(255, 64, 39, 176),
        
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    members: widget.members,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Cameron Williamson'),
              accountEmail: Text('cameronwilliamson@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/assets/image/user.jpg'),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255,68,52,169),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Timer'),
              onTap: () {
                // Handle the timer navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Attendance'),
              onTap: () {
                // Handle the attendance navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Activity'),
              onTap: () {
                // Handle the activity navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Timesheet'),
              onTap: () {
                // Handle the timesheet navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report'),
              onTap: () {
                // Handle the report navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Jobsite'),
              onTap: () {
                // Handle the jobsite navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Team'),
              onTap: () {
                // Handle the team navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.time_to_leave),
              title: const Text('Time off'),
              onTap: () {
                // Handle the time off navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Schedules'),
              onTap: () {
                // Handle the schedules navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Request to join Organization'),
              onTap: () {
                // Handle the request to join organization navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () {
                // Handle the change password navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle the logout navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('FAQ & Help'),
              onTap: () {
                // Handle the FAQ & Help navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              onTap: () {
                // Handle the privacy policy navigation
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Version: 1.0(1)'),
              onTap: () {
                // Handle the version information
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Date and filter header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.group, color: Color.fromARGB(255,68,52,169)),
                    const SizedBox(width: 8),
                    const Text(
                      'All Members',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle filter change
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemberScreen(
                                members:
                                    widget.members), // Passing the first member
                          ),
                        );
                      },
                      child: const Text('Change',
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(_getCurrentDate()), // Display current date here
                  ],
                ),
              ],
            ),
          ),
          // Member list
          Expanded(
            child: ListView.builder(
              itemCount: widget.members.length,
              itemBuilder: (context, index) {
                final member = widget.members[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(member
                          .imageUrl), // Ensure member.imageUrl is non-null
                      radius: 20,
                    ),
                    title: Text(
                      member.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        // Display check-in time icon and time (if working)
                        if (member.status == 'NOT LOGGED-IN') ...[
                          const Text(
                            'NOT LOGGED-IN',
                            style: TextStyle(
                                color: Color.fromARGB(255, 253, 46, 46),
                                fontWeight: FontWeight.bold),
                          ),
                        ] else ...[
                          const Icon(Icons.arrow_upward,
                              color: Colors.green, size: 16),
                          const Text(' 09:30 am'), // Assuming check-in time
                          const SizedBox(width: 16),
                        ],

                        // Display check-out time only if member is not working
                        if (member.status != 'WORKING' &&
                            member.status != 'NOT LOGGED-IN') ...[
                          const Icon(Icons.arrow_downward,
                              color: Colors.red, size: 16),
                          const Text(' 06:40 pm'), // Assuming check-out time
                        ],
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Display "WORKING" if the member is working
                        if (member.status == 'WORKING')
                          const Text(
                            'WORKING',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),

                        // Location button to view member's live location
                        IconButton(
                          icon: const Icon(Icons.location_on,
                              color: Color.fromARGB(255, 64, 39, 176)),
                          onPressed: () {
                            // Navigate to LocationScreen to show live location
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationScreen(
                                    member:
                                        member), // Pass the member to LocationScreen
                              ),
                            );
                          },
                        ),

                        // Attendance button to navigate to AttendanceScreen
                        IconButton(
                          icon: const Icon(Icons.calendar_month,
                              color: Colors.blue),
                          onPressed: () {
                           
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Show Map View button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    members: widget.members,
                  ),
                ),
              );
              },
              icon: const Icon(
                Icons.map,
                color: Color.fromARGB(255, 64, 39, 176),
              ),
              label: const Text('Show Map View'),
            ),
          ),
        ],
      ),
    );
  }
}
