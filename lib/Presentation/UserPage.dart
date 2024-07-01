import 'package:buss/Presentation/Drawer/Drawer%20Pages/BookingHistoryPage.dart';
import 'package:buss/Utils/Constants.dart';
import 'package:buss/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Database Repo/Crud.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Crud crud = Crud();
  bool isPasswordVisible = false;

  Future<List<Map<String, dynamic>>> getUsers() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate delay

    var response = await crud.PostRequest(linkUserPage, {
      "user_id": sharedPref.getString('id'),
    });

    if (response['status'] == "success") {
      // Parse the 'data' list into a List<Map<String, dynamic>>
      final users = response['data']?.cast<Map<String, dynamic>>();

      if (users != null) {
        return users;
      } else {
        throw Exception('API call failed'); // Or a more specific exception type
      }
    } else {
      throw Exception('API call failed'); // Or a more specific exception type
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.separated(
              itemCount: users.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 20,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final user = users[index];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile picture with rounded corners
                      Center(
                        child: Column(
                          children: [
                            // const CircleAvatar(
                            //   radius: 70.0,
                            //   backgroundImage: AssetImage('assets/person.jpeg'),
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              user['name'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      // User information with headings

                      // ListTile(
                      //   tileColor: Colors.grey[300], // S
                      //   shape: const StadiumBorder(),
                      //   leading: const Icon(CupertinoIcons.text_insert),
                      //   title: const Text(
                      //     'Name:',
                      //     style: TextStyle(
                      //       fontSize: 16.0,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      //   subtitle: Text(user['name']),
                      // ),

                      const SizedBox(height: 10.0),

                      ListTile(
                        tileColor: Colors.grey[200], // S
                        shape: const StadiumBorder(),
                        leading: const Icon(Icons.person_2),
                        title: const Text(
                          'Username:',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(user['username']),
                      ),

                      const SizedBox(height: 10.0),

                      ListTile(
                        tileColor: Colors.grey[200], // S
                        shape: const StadiumBorder(),
                        leading: const Icon(Icons.email),
                        title: const Text(
                          'Email:',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(user['email']),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        tileColor: Colors.grey[200], // S
                        shape: const StadiumBorder(),
                        leading: const Icon(Icons.password),
                        title: const Text(
                          'Password:',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          isPasswordVisible
                              ? user['password']
                              : List.filled(user['password'].length, '•')
                                  .join(),
                          style:
                              const TextStyle(), // Customize text style as needed
                        ),
                        trailing: IconButton(
                          color: Colors.black,
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => BookingHistoryPage(
                                id: sharedPref.getString('id'),
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: const Icon(Icons.history),
                          tileColor: Colors.grey[200], // S
                          shape: const StadiumBorder(),
                          title: const Text(
                            'Booking History',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          } else {
            return const Center(
              child: Text('No user information found.'),
            );
          }
        },
      ),
    );
  }
}
