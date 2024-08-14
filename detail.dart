import 'package:flutter/material.dart';
import 'package:home/result.dart'; // Import the ResultPage

class DetailPage extends StatefulWidget {
  final String title;

  DetailPage({required this.title});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? _selectedStartCity;
  String? _selectedEndCity;
  String? _selectedStartStop;
  String? _selectedEndStop;

  // City and stop options
  final Map<String, List<String>> _cityStops = {
    'Pune': ['vallabhnager', 'B', 'C'],
    'Mumbai': ['D', 'C', 'A'],
    'Solapur': ['krudwadi','C', 'A'],
  };

  void _navigateToResultPage() {
    if (_selectedStartStop == null || _selectedEndStop == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both stops')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          startLocation: _selectedStartStop!,
          endLocation: _selectedEndStop!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 4,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Share action pressed')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('More options pressed')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/bus.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Start City Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedStartCity,
                  hint: Text('Select Your city'),
                  items: _cityStops.keys.map((city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStartCity = value;
                      _selectedStartStop = null; // Reset selected stop
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Start Stop Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedStartStop,
                  hint: Text('Select Nearest stop'),
                  items: _selectedStartCity == null
                      ? []
                      : _cityStops[_selectedStartCity!]!.map((stop) {
                    return DropdownMenuItem<String>(
                      value: stop,
                      child: Text(stop),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStartStop = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                    Center(child: Icon(Icons.route_rounded, size: 60)),
                SizedBox(height: 16),

                // End City Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedEndCity,
                  hint: Text('Select Destination'),
                  items: _cityStops.keys.map((city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedEndCity = value;
                      _selectedEndStop = null; // Reset selected stop
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // End Stop Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedEndStop,
                  hint: Text('Select end stop'),
                  items: _selectedEndCity == null
                      ? []
                      : _cityStops[_selectedEndCity!]!.map((stop) {
                    return DropdownMenuItem<String>(
                      value: stop,
                      child: Text(stop),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedEndStop = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _navigateToResultPage,
                    child: Text('Get Bus Information'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
