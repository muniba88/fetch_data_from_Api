import 'package:featchdata_from_api/models/usermodel.dart';
import 'package:featchdata_from_api/networks/api_coller.dart';
import 'package:featchdata_from_api/networks/apis.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    // Fetch data from /users endpoint
    ApiColler().get(Apis.users).then((response) {
      setState(() {
        users = List<UserModel>.from(
          response.map((item) => UserModel.fromJson(item)),
        );
      });
    }).catchError((e) {
      print("Error => $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('User List', style: TextStyle(fontWeight: FontWeight.bold))),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: users.length,
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  child: ListTile(
                    title: Text(user.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(user.email,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(user.username,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onTap: () {
                      // Show more details when user taps
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('User Details',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID: ${user.id}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Username: ${user.username}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Email: ${user.email}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Phone: ${user.phone}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Website: ${user.website}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text(
                                    'Address: ${user.address.street}, ${user.address.suite}, ${user.address.city}, ${user.address.zipcode}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                    'Geo: Lat ${user.address.geo.lat}, Lng ${user.address.geo.lng}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Text('Company: ${user.company.name}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                    'Catch Phrase: ${user.company.catchPhrase}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Business: ${user.company.bs}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
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
