import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home/detail.dart'; // Ensure this path is correct
import 'package:home/home.dart';
import 'package:home/manudetails.dart'; // Ensure this path is correct
import 'package:home/my%20header%20drawer.dart';
 // Corrected path

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DrawerSection currentPage = DrawerSection.DashBoard;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "Schedulix",
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35)
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...Your Present District',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeader(),
              MyDrawerList(),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/images/nobackst.png', height: 300),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: _buildGridItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildGridItems() {
    List<String> items = [
      'Pune', 'Mumbai', 'Ahamadnager', 'Akola', 'Amravati',
      'Sambhajinager', 'Bhandara', 'Buldhana', 'Chandrapur', 'Dhule',
      'Gadchiruli', 'Gondia', 'Hingoli', 'Jalgaon', 'Jalna',
      'Kolhapur', 'Latur', 'Mumbai Suburban', 'Nagpur', 'Nanded',
      'Nandurbar', 'Nashik', 'Dharashiv', 'Palghar', 'Parbhani',
      'Raigad', 'Ratnagiri', 'Satara', 'Sindhuduraga', 'Solapur',
      'Thane', 'Vashim', 'Yavatmal',
    ];

    return items.where((item) => item.toLowerCase().contains(_searchQuery)).map((item) {
      return itemDashboard(item, Icons.directions_bus, Colors.cyan);
    }).toList();
  }

  Widget itemDashboard(String title, IconData iconData, Color background) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(title: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.black,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.red),
            ),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          MenuItem(1, 'Dashboard', Icons.dashboard_outlined, currentPage == DrawerSection.DashBoard),
          MenuItem(2, 'Contacts', Icons.people_alt_outlined, currentPage == DrawerSection.Contacts),
          MenuItem(3, 'Settings', Icons.settings, currentPage == DrawerSection.Setting),
          MenuItem(4, 'Rating', Icons.rate_review, currentPage == DrawerSection.Rating),
          MenuItem(5, 'Notification', Icons.notification_add_rounded, currentPage == DrawerSection.Notifications),
          MenuItem(6, 'Privacy Policy', Icons.privacy_tip_outlined, currentPage == DrawerSection.PrivacyPolicy),
          MenuItem(7, 'Feedback', Icons.feedback_outlined, currentPage == DrawerSection.Feedback),
        ],
      ),
    );
  }

  Widget MenuItem(int id, String title, IconData icon, bool isSelected) {
    return Material(
      color: isSelected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                switch (id) {
                  case 1:
                    return DashboardPage();
                  case 2:
                    return ContactsPage();
                  case 3:
                    return SettingPage(onThemeChanged: (bool value) {}); // Provide a dummy function for now
                  case 4:
                    return RatingPage();
                  case 5:
                    return NotificationsPage();
                  case 6:
                    return PrivacyPolicyPage();
                  case 7:
                    return FeedbackPage();
                  default:
                    return HomePage(); // Default to HomePage if none match
                }
              },
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(icon, size: 20, color: Colors.black),
              SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection {
  DashBoard,
  Contacts,
  Setting,
  Rating,
  Notifications,
  PrivacyPolicy,
  Feedback,
}
