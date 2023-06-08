import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataDisplayScreen extends StatefulWidget {
  @override
  _DataDisplayScreenState createState() => _DataDisplayScreenState();
}

class _DataDisplayScreenState extends State<DataDisplayScreen> {
  List<dynamic> apiData = []; // Store the API data

  void fetchDataFromAPI() async {
    // Make the API call to fetch data
    String apiUrl =
        'http://dev.amintek.com/api/bajeti/rental/v1/listing'; // Replace with your actual API URL
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        apiData = data['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('B-R listings'),
      ),
      body: ListView.builder(
        itemCount: apiData.length,
        itemBuilder: (context, index) {
          var item = apiData[index];
          return ListTile(
              title: Text(item['label']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['description'],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(item['rate_label']),
                ],
              ));
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DataDisplayScreen(),
  ));
}
