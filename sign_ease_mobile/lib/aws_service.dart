import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:sign_ease_mobile/amplifyconfiguration.dart';
import 'models/SensorData.dart';

Future<void> configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAPI());
    await Amplify.configure(amplifyconfig);
    print('Amplify configured successfully');
  } catch (e) {
    print('Error configuring Amplify: $e');
  }
}

Future<List<SensorData>> fetchSensorData() async {
  try {
    final request = ModelQueries.list(SensorData.classType);
    final response = await Amplify.API.query(request: request).response;

    if (response.data != null) {
      return response.data!.items.whereType<SensorData>().toList();
    } else {
      print('Query failed: ${response.errors}');
      return [];
    }
  } catch (e) {
    print('Error fetching data: $e');
    return [];
  }
}



// import 'package:amplify_flutter/amplify_flutter.dart';

// class AwsService {
//   Future<List<Map<String, dynamic>>> fetchSensorData() async {
//     try {
//       final response = await Amplify.API
//           .query(
//             request: GraphQLRequest<String>(
//               document: '''
//           query ListSensorData {
//             listSensorData {
//               items {
//                 device_id
//                 timestamp
//                 sensor_value
//               }
//             }
//           }
//           ''',
//             ),
//           )
//           .response;

//       final data = response.data as List<Map<String, dynamic>>;
//       return data;
//     } catch (e) {
//       print('Error fetching data: $e');
//       return [];
//     }
//   }
// }
