import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:vehicle/services/authFunctions.dart'; // Import your authentication functions
import 'package:vehicle/main.dart';
import 'dart:ui';
import 'VehicleSearchPage.dart';
import 'dart:math';
import 'package:flutter_glow/flutter_glow.dart';

class IntroPage extends StatefulWidget {
  final String userName;
  final String userEmail;

  IntroPage({required this.userName, required this.userEmail});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  static const Color grad1 = Color(0xFF03a9f4);
  static const Color grad2 = Color(0xFFf441a5);
  static const Color grad3 = Color(0xFFffeb3b);
  static const Color grad4 = Color(0xFF03a9f4);
  // Create a reference to the Firestore collection
  final CollectionReference vehiclesCollection =
  FirebaseFirestore.instance.collection('vehicles');

  // List to store the fetched vehicles
  List<Widget> vehicleList = [];

  @override
  void initState() {
    super.initState();
    // Fetch vehicles from Firestore when the widget initializes
    fetchVehicles();
  }


  void fetchVehicles() async {
    // Query the Firestore collection for vehicles
    QuerySnapshot querySnapshot = await vehiclesCollection.get();

    // Process the query snapshot to create a list of vehicle widgets
    List<Widget> vehicles = querySnapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      return Stack(
        children: [
          Container(
            height: 230,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      data['imageUrl'] ?? '',
                      width: 350,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          data['name'] ?? '',
                          style: TextStyle(fontSize: 30),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price per hour: \₹${data['pricePerHour'] ?? 0.0}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Price per day: \₹${data['pricePerDay'] ?? 0.0}',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Vehicle Type: ${data['type']}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            MouseRegion(
                              onEnter: (_) {
                                setState(() {});
                              },
                              onExit: (_) {
                                setState(() {});
                              },
                              child: GlowingOverscrollIndicator(
                                axisDirection: AxisDirection.down,
                                color: Colors.transparent, // Set the base color of the glow to transparent
                                showLeading: true,
                                showTrailing: true,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle Rent Now button press
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    ),
                                    elevation: MaterialStateProperty.all<double>(0),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Set button background color
                                    overlayColor: MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                        if (states.contains(MaterialState.hovered)) {
                                          final neonColors = [
                                            Color(0xFFFF4081), // Bright Neon Blue
                                            Color(0xFFFFD700), // Bright Neon Pink
                                            Color(0xFF00FF00), // Bright Neon Yellow
                                          ];

                                          final duration = const Duration(seconds: 2);

                                          final t = (DateTime.now().millisecondsSinceEpoch % duration.inMilliseconds) / duration.inMilliseconds;

                                          final startIndex = (t * neonColors.length).floor() % neonColors.length;
                                          final endIndex = (startIndex + 1) % neonColors.length;
                                          final fraction = (t * neonColors.length) - startIndex;

                                          final color = Color.lerp(neonColors[startIndex], neonColors[endIndex], fraction);

                                          return color ?? Colors.transparent;
                                        }
                                        return Colors.transparent;
                                      },
                                    ),
                                  ),
                                  child: Text(
                                    'Rent Now',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 0,
            child: Divider(),
          ),
        ],
      );
    }).toList();

    // Update the state with the fetched vehicle list
    setState(() {
      vehicleList = vehicles;
    });
  }

  // Function to handle log out
  void _handleLogOut(BuildContext context) async {
    await AuthServices.signoutUser(context);

    // After logging out, navigate to the home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Rental'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _handleLogOut(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.userName),
              accountEmail: Text(widget.userEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              title: Text('User Information'),
              leading: Icon(Icons.person),
              onTap: () {
                // Navigate to user information page
              },
            ),
            ListTile(
              title: Text('Vehicles Search'),
              leading: Icon(Icons.search),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VehicleSearchPage(), // Replace with your actual VehicleSearchPage widget
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Trending Vehicles'),
              leading: Icon(Icons.trending_up),
              onTap: () {
                // Navigate to trending vehicles page
              },
            ),
            ListTile(
              title: Text('Bookings'),
              leading: Icon(Icons.book),
              onTap: () {
                // Navigate to bookings page
              },
            ),
            Divider(),
            ListTile(
              title: Text('Auto Recommend'),
              leading: Icon(Icons.recommend),
              onTap: () {
                // Navigate to auto recommend page
              },
            ),
            ListTile(
              title: Text('About Us'),
              leading: Icon(Icons.info),
              onTap: () {
                // Navigate to about us page
              },
            ),
            ListTile(
              title: Text('Contact Us'),
              leading: Icon(Icons.contact_mail),
              onTap: () {
                // Navigate to contact us page
              },
            ),
            Divider(),
            ListTile( // Add the Log Out option
              title: Text('Log Out'),
              leading: Icon(Icons.logout), // You can use a logout icon here
              onTap: () {
                // Call the log out function when the user taps on Log Out
                _handleLogOut(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.grey[300]!],
          ),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFFD700), // Gold color (you can adjust the color code)
                      blurRadius: 10.0, // Adjust the blur radius for the glow effect
                      spreadRadius: 5.0, // Adjust the spread radius for the glow effect
                    ),
                  ],
                ),
                child: Text(
                  'Our Fleet',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: vehicleList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
