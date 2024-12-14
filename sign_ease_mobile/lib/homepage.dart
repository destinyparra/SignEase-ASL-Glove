import 'package:flutter/material.dart';
import 'api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> sensorDataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await apiService.fetchSensorData();
    setState(() {
      sensorDataList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sensor Data')),
      body: sensorDataList.isEmpty
          ? Center(child: Text('No data available'))
          : ListView.builder(
              itemCount: sensorDataList.length,
              itemBuilder: (context, index) {
                final sensorData = sensorDataList[index];
                return ListTile(
                  title: Text(
                      'Translation: ${sensorData['translation'] ?? 'Unknown'}'),
                  subtitle: Text(
                      'Binary State: ${sensorData['binaryState'] ?? 'N/A'}'),
                );
              },
            ),
    );
  }
}


// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Map<String, dynamic>> sensorDataList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchSensorData();
//   }

//   Future<void> fetchSensorData() async {
//     try {
//       final response = await Amplify.API
//           .query(
//             request: GraphQLRequest<String>(
//               document: '''
//               query ListSensorData {
//                 listSensorData {
//                   items {
//                     id
//                     binaryState
//                     translation
//                   }
//                 }
//               }
//               ''',
//             ),
//           )
//           .response;

//       if (response.data != null) {
//         final data =
//             jsonDecode(response.data!)['listSensorData']['items'] as List;
//         setState(() {
//           sensorDataList = data.cast<Map<String, dynamic>>();
//         });
//         print("Fetched sensor data: $sensorDataList");
//       } else {
//         print('No data available');
//       }
//     } catch (e) {
//       print('Error fetching sensor data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sensor Data')),
//       body: sensorDataList.isEmpty
//           ? Center(child: Text('No data available'))
//           : ListView.builder(
//               itemCount: sensorDataList.length,
//               itemBuilder: (context, index) {
//                 final sensorData = sensorDataList[index];
//                 return ListTile(
//                   title: Text(
//                       'Translation: ${sensorData['translation'] ?? 'Unknown'}'),
//                   subtitle: Text(
//                       'Binary State: ${sensorData['binaryState'] ?? 'N/A'}'),
//                 );
//               },
//             ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'models/SensorData.dart'; // Your generated model class

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<SensorData> sensorDataList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchSensorData();
//   }

//   Future<void> fetchSensorData() async {
//     try {
//       final response = await Amplify.API
//           .query(
//             request: GraphQLRequest<String>(
//               document: '''
//               query ListSensorData {
//                 listSensorData {
//                   items {
//                     id
//                     binaryState
//                     translation
//                   }
//                 }
//               }
//               ''',
//             ),
//           )
//           .response;

//       if (response.data != null) {
//         final data =
//             jsonDecode(response.data!)['listSensorData']['items'] as List;
//         setState(() {
//           sensorDataList = data
//               .map((item) => SensorData.fromJson(item as Map<String, dynamic>))
//               .toList();
//         });
//       } else {
//         print('No data available in the API response.');
//       }
//     } catch (e) {
//       print('Error fetching sensor data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sensor Data')),
//       body: sensorDataList.isEmpty
//           ? Center(child: Text('No data available'))
//           : ListView.builder(
//               itemCount: sensorDataList.length,
//               itemBuilder: (context, index) {
//                 final sensorData = sensorDataList[index];
//                 return ListTile(
//                   title: Text(
//                       'Translation: ${sensorData.translation ?? 'Unknown'}'),
//                   subtitle:
//                       Text('Binary State: ${sensorData.binaryState ?? 'N/A'}'),
//                 );
//               },
//             ),
//     );
//   }
// }



// // import 'package:flutter/material.dart';
// // import 'package:sign_ease_mobile/api_service.dart';
// // import 'package:sign_ease_mobile/aws_service.dart';
// // import 'models/SensorData.dart';

// // class HomePage extends StatefulWidget {
// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   late Future<List<SensorData>> sensorDataFuture;

// //   @override
// //   void initState() {
// //     super.initState();
// //     sensorDataFuture = fetchSensorData(); // Fetch data when the page loads
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('SignEase - Sensor Data'),
// //       ),
// //       body: FutureBuilder<List<SensorData>>(
// //         future: sensorDataFuture,
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return Center(child: Text('No data available'));
// //           } else {
// //             final sensorDataList = snapshot.data!;
// //             return ListView.builder(
// //               itemCount: sensorDataList.length,
// //               itemBuilder: (context, index) {
// //                 final sensorData = sensorDataList[index];
// //                 return ListTile(
// //                   title: Text('Translation: ${sensorData.translation}'),
// //                   subtitle: Text('Binary State: ${sensorData.binaryState}'),
// //                 );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

// // this was for bluetooth

// // import 'package:flutter/material.dart';

// // class HomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('SignEase'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             Text(
// //               'Connect to device',
// //               style: TextStyle(
// //                 fontSize: 24,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //             SizedBox(height: 20),
// //             TextField(
// //               decoration: InputDecoration(
// //                 border: OutlineInputBorder(),
// //                 labelText: 'Enter some text',
// //                 hintText: 'Type here...',
// //               ),
// //               maxLines: 5,
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text('Button Pressed!')),
// //                 );
// //               },
// //               child: Text('Submit'),
// //             ),
// //             SizedBox(height: 20), // Space between the buttons
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Navigate to BluetoothListPage
// //                 Navigator.pushNamed(context, '/bluetooth');
// //               },
// //               child: Text('Go to Bluetooth Screen'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
