import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart'; // Amplify API Plugin
import 'amplifyconfiguration.dart'; // Amplify configuration file

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure async code works
  await configureAmplify(); // Set up Amplify
  runApp(MyApp());
}

Future<void> configureAmplify() async {
  try {
    final apiPlugin = AmplifyAPI(); // Add Amplify API plugin
    await Amplify.addPlugins([apiPlugin]);
    await Amplify.configure(amplifyconfig); // Configure with the generated file
    print("Amplify configured successfully");
  } catch (e) {
    print("Failed to configure Amplify: $e");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignEase',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'homepage.dart'; // Import the HomePage
// import 'package:amplify_flutter/amplify_flutter.dart'; // Import Amplify
// import 'package:amplify_api/amplify_api.dart'; // Amplify API Plugin
// import 'amplifyconfiguration.dart'; // Generated configuration

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Required for async main
//   await configureAmplify(); // Configure Amplify before app starts
//   runApp(MyApp());
// }

// Future<void> configureAmplify() async {
//   try {
//     final apiPlugin = AmplifyAPI(); // Add Amplify API plugin
//     await Amplify.addPlugin(apiPlugin); // Register the plugin
//     await Amplify.configure(amplifyconfig); // Use the generated configuration
//     print("Amplify configured successfully");
//   } catch (e) {
//     print("Failed to configure Amplify: $e");
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SignEase',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: HomePage(), // Start at HomePage
//     );
//   }
// }


// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:amplify_flutter/amplify_flutter.dart';
// // import 'models/SensorData.dart';

// // class HomePage extends StatefulWidget {
// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   List<SensorData> sensorDataList = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchSensorData();
// //   }

// //   Future<void> fetchSensorData() async {
// //     try {
// //       final response = await Amplify.API
// //           .query(
// //             request: GraphQLRequest<String>(
// //               document: '''
// //           query ListSensorData {
// //             listSensorData {
// //               items {
// //                 id
// //                 binaryState
// //                 translation
// //                 sensor_1
// //                 sensor_2
// //                 sensor_3
// //                 sensor_4
// //                 sensor_5
// //               }
// //             }
// //           }
// //           ''',
// //             ),
// //           )
// //           .response;

// //       if (response.data != null) {
// //         final data =
// //             jsonDecode(response.data!)['listSensorData']['items'] as List;
// //         setState(() {
// //           sensorDataList = data
// //               .map((item) => SensorData.fromJson(item as Map<String, dynamic>))
// //               .toList();
// //         });
// //       } else {
// //         print('No data available');
// //       }
// //     } catch (e) {
// //       print('Error fetching sensor data: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Sensor Data')),
// //       body: sensorDataList.isEmpty
// //           ? Center(child: Text('No data available'))
// //           : ListView.builder(
// //               itemCount: sensorDataList.length,
// //               itemBuilder: (context, index) {
// //                 final sensorData = sensorDataList[index];
// //                 return ListTile(
// //                   title: Text(
// //                       'Translation: ${sensorData.translation ?? 'Unknown'}'),
// //                   subtitle: Text(
// //                       'Binary State: ${sensorData.binaryState ?? 'N/A'}\n'),
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }



// // // import 'package:flutter/material.dart';
// // // import 'homepage.dart';
// // // import 'package:sign_ease_mobile/api_service.dart'; // Import your API service
// // // import 'bluetooth_list.dart';
// // // import 'package:amplify_flutter/amplify_flutter.dart'; // Import Amplify
// // // import 'package:amplify_api/amplify_api.dart'; // Amplify API Plugin
// // // import 'amplifyconfiguration.dart'; // Generated configuration

// // // void main() async {
// // //   WidgetsFlutterBinding.ensureInitialized(); // Required for async main
// // //   await configureAmplify(); // Configure Amplify before app starts
// // //   runApp(MyApp());
// // // }

// // // Future<void> configureAmplify() async {
// // //   try {
// // //     final apiPlugin = AmplifyAPI(); // Add Amplify API plugin
// // //     await Amplify.addPlugins([apiPlugin]);
// // //     await Amplify.configure(amplifyconfig); // Use the generated configuration
// // //     print("Amplify configured successfully");
// // //   } catch (e) {
// // //     print("Failed to configure Amplify: $e");
// // //   }
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'SignEase',
// // //       theme: ThemeData(primarySwatch: Colors.blue),
// // //       initialRoute: '/', // Start at HomePage
// // //       routes: {
// // //         '/': (context) => HomePage(), // HomePage route
// // //         '/bluetooth': (context) =>
// // //             BluetoothListPage(), // BluetoothListPage route
// // //       },
// // //     );
// // //   }
// // // }


// // // --=--=-=-=--==-=-=-=---=-==-=---==--=-=-

// // // import 'package:flutter/material.dart';
// // // import 'homepage.dart';
// // // import 'package:sign_ease_mobile/api_service.dart';
// // // import 'bluetooth_list.dart';

// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'SignEase',
// // //       theme: ThemeData(primarySwatch: Colors.blue),
// // //       initialRoute: '/', // Start at HomePage
// // //       routes: {
// // //         '/': (context) => HomePage(), // HomePage route
// // //         '/bluetooth': (context) =>
// // //             BluetoothListPage(), // BluetoothListPage route
// // //       },
// // //     );
// // //   }
// // // }
