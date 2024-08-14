import 'package:flutter/material.dart';
import 'package:home/bs.dart'; // Import the page that shows bus details

class ResultPage extends StatelessWidget {
  final String startLocation;
  final String endLocation;

  ResultPage({required this.startLocation, required this.endLocation});

  void _navigateToBusDetail(BuildContext context, String busNumber, String arrivalTime) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusDetailPage(
          busNumber: busNumber,
          arrivalTime: arrivalTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> buses = _getBusesForRoute(startLocation, endLocation);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Information'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.cyan[50], // Example background color
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From: $startLocation',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'To: $endLocation',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: buses.map((bus) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(bus['number']!),
                        subtitle: Text('Arrival Time: ${bus['arrivalTime']}'),
                        trailing: Icon(Icons.directions_bus, color: Colors.cyan),
                        onTap: () {
                          _navigateToBusDetail(context, bus['number']!, bus['arrivalTime']!);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, String>> _getBusesForRoute(String start, String end) {
    // Example data; replace with actual logic for different routes
    if (start == 'swarget' && end == 'solapur') {
      return [
        {'number': 'Bus 101', 'arrivalTime': '10:30 AM'},
        {'number': 'Bus 201', 'arrivalTime': '11:00 AM'},
      ];
    } else if (start == 'vallabhnagar' && end == 'karmala') {
      return [
        {'number': 'Bus 303', 'arrivalTime': '12:00 PM'},
        {'number': 'Bus 305', 'arrivalTime': '12:30 PM'},
      ];
    } else if (start == 'solapur' && end == 'swarget') {
      return [
        {'number': 'Bus 303', 'arrivalTime': '12:00 PM'},
        {'number': 'Bus 305', 'arrivalTime': '12:30 PM'},
      ];
    } else if (start == 'karmala' && end == 'vallabhnagar') {
      return [
        {'number': 'Bus 303', 'arrivalTime': '12:00 PM'},
        {'number': 'Bus 305', 'arrivalTime': '12:30 PM'},
      ];
    } else if (start == 'Barshi' && end == 'swarget') {
      return [
        {'number': 'Bus 303', 'arrivalTime': '12:00 PM'},
        {'number': 'Bus 305', 'arrivalTime': '12:30 PM'},
      ];
    } else if (start == 'krudwadi' && end == 'vallabhnagar') {
      return [
        {'number': 'Bus 303', 'arrivalTime': '12:00 PM'},
        {'number': 'Bus 305', 'arrivalTime': '12:30 PM'},
      ];
    } else if (start == 'vallabhnagar' && end == 'krudwadi') {
      return [
        {'number': 'Bus 303', 'arrivalTime': '12:00 PM'},
        {'number': 'Bus 305', 'arrivalTime': '12:30 PM'},
      ];
    } else if (start == 'krudwadi' && end == 'swarget') {
      return [
        {'number': 'Bus 303', 'arrivalTime': '12:00 PM'},
        {'number': 'Bus 305', 'arrivalTime': '12:30 PM'},
      ];
    } else {
      // Default case for unknown routes
      return [
        {'number': 'No Buses', 'arrivalTime': 'N/A'},
      ];
    }
  }
}
