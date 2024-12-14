import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:sign_ease_mobile/amplifyconfiguration.dart';
import 'package:sign_ease_mobile/models/SensorData.dart';
import 'package:sign_ease_mobile/models/ModelProvider.dart';


class BluetoothListPage extends StatefulWidget {
  @override
  _BluetoothListPageState createState() => _BluetoothListPageState();
}

class _BluetoothListPageState extends State<BluetoothListPage> {
  final flutterBlue = FlutterBluePlus();
  List<ScanResult> scanResults = [];
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? targetCharacteristic;

  String sensorValue = "N/A";
  String status = "N/A";
  List<Map<String, dynamic>> sensorDataList = [];

  @override
  void initState() {
    super.initState();
    initializeAmplify();
    startScan();
    fetchSensorData();
  }

  Future<void> initializeAmplify() async {
    try {
      final amplifyDataStore = AmplifyDataStore(modelProvider: ModelProvider.instance);
      final amplifyAuthCognito = AmplifyAuthCognito();

      await Amplify.addPlugins([amplifyDataStore, amplifyAuthCognito]);
      await Amplify.configure(amplifyconfig);
      print("Amplify configured successfully.");
    } catch (e) {
      print("Failed to configure Amplify: $e");
    }
  }

  Future<void> fetchSensorData() async {
    try {
      final queryResult = await Amplify.DataStore.query(SensorData.classType);
      setState(() {
        sensorDataList = queryResult
            .map((e) => {
                  'translation': e.translation,
                  'timestamp': e.timestamp,
                  'binaryState': e.binaryState,
                })
            .toList();
      });
    } catch (e) {
      print("Failed to fetch sensor data: $e");
    }
  }

  void startScan() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      connectedDevice = device;
    });

    discoverServices(device);
  }

  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == "abcd1234-5678-1234-5678-123456789abc") {
          setState(() {
            targetCharacteristic = characteristic;
          });

          await characteristic.setNotifyValue(true);
          characteristic.value.listen((value) {
            final reading = String.fromCharCodes(value);
            setState(() {
              sensorValue = reading;
              final parsedValue = int.tryParse(reading) ?? 0;
              status = parsedValue > 800 ? "High" : "Low";
            });
          });
        }
      }
    }
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    connectedDevice?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth and Sensor Data'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: connectedDevice == null
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: scanResults.length,
                    itemBuilder: (context, index) {
                      final result = scanResults[index];
                      return ListTile(
                        title: Text(result.device.name.isNotEmpty
                            ? result.device.name
                            : 'Unknown Device'),
                        subtitle: Text(result.device.id.toString()),
                        onTap: () {
                          connectToDevice(result.device);
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: startScan,
                  child: Text('Rescan'),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sensorDataList.length,
                    itemBuilder: (context, index) {
                      final data = sensorDataList[index];
                      return ListTile(
                        title: Text("Translation: ${data['translation']}"),
                        subtitle: Text(
                            "Timestamp: ${data['timestamp']}\nState: ${data['binaryState']}"),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    fetchSensorData();
                  },
                  child: Text("Refresh Sensor Data"),
                ),
                ElevatedButton(
                  onPressed: () {
                    connectedDevice?.disconnect();
                    setState(() {
                      connectedDevice = null;
                      sensorValue = "N/A";
                      status = "N/A";
                    });
                  },
                  child: Text("Disconnect"),
                ),
              ],
            ),
    );
  }
}

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=---=-=-=-=-=-=-=-
// -=-=-=-=-=-=-=-=-=-Works w/o aws=-=-=-=-=-=-=-
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=---=-=-=-=-=-=-=-


// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// class BluetoothListPage extends StatefulWidget {
//   @override
//   _BluetoothListPageState createState() => _BluetoothListPageState();
// }

// class _BluetoothListPageState extends State<BluetoothListPage> {
//   final flutterBlue =
//       FlutterBluePlus(); // Create an instance of FlutterBluePlus
//   List<ScanResult> scanResults = [];
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? targetCharacteristic;
//   String sensorValue = "N/A";
//   String status = "N/A";

//   @override
//   void initState() {
//     super.initState();
//     startScan();
//   }

//   void startScan() async {
//     // Start scanning
//     FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
//     FlutterBluePlus.scanResults.listen((results) {
//       setState(() {
//         scanResults = results;
//       });
//     });
//   }

//   void connectToDevice(BluetoothDevice device) async {
//     await device.connect();
//     setState(() {
//       connectedDevice = device;
//     });

//     discoverServices(device);
//   }

//   void discoverServices(BluetoothDevice device) async {
//     List<BluetoothService> services = await device.discoverServices();
//     for (BluetoothService service in services) {
//       for (BluetoothCharacteristic characteristic in service.characteristics) {
//         // Match the target characteristic
//         if (characteristic.uuid.toString() ==
//             "abcd1234-5678-1234-5678-123456789abc") {
//           setState(() {
//             targetCharacteristic = characteristic;
//           });

//           // Subscribe to notifications
//           await characteristic.setNotifyValue(true);
//           characteristic.value.listen((value) {
//             final reading = String.fromCharCodes(value);
//             setState(() {
//               sensorValue = reading;
//               final parsedValue =
//                   int.tryParse(reading) ?? 0; // Default to 0 if parsing fails
//               status = parsedValue > 800 ? "High" : "Low";
//             });
//           });
//         }
//       }
//     }
//   }

//   @override
//   void dispose() {
//     FlutterBluePlus.stopScan();
//     connectedDevice?.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Available Bluetooth Devices'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Go back to HomePage
//           },
//         ),
//       ),
//       body: connectedDevice == null
//           ? Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: scanResults.length,
//                     itemBuilder: (context, index) {
//                       final result = scanResults[index];
//                       return ListTile(
//                         title: Text(result.device.name.isNotEmpty
//                             ? result.device.name
//                             : 'Unknown Device'),
//                         subtitle: Text(result.device.id.toString()),
//                         onTap: () {
//                           connectToDevice(result.device);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: startScan,
//                   child: Text('Rescan'),
//                 ),
//               ],
//             )
//           : Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Connected to ${connectedDevice!.name}",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "Sensor Value: $sensorValue",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     "Status: $status",
//                     style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: status == "High" ? Colors.red : Colors.green),
//                   ),
//                   SizedBox(height: 40),
//                   ElevatedButton(
//                     onPressed: () {
//                       connectedDevice?.disconnect();
//                       setState(() {
//                         connectedDevice = null;
//                         sensorValue = "N/A";
//                         status = "N/A";
//                       });
//                     },
//                     child: Text("Disconnect"),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
