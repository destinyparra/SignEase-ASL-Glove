import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';

class APIService {
  Future<List<Map<String, dynamic>>> fetchSensorData() async {
    try {
      final response = await Amplify.API
          .query(
            request: GraphQLRequest<String>(
              document: '''
            query ListSensorData {
              listSensorData {
                items {
                  id
                  binaryState
                  translation
                }
              }
            }
            ''',
            ),
          )
          .response;

      if (response.data != null) {
        final data =
            jsonDecode(response.data!)['listSensorData']['items'] as List;
        return data.cast<Map<String, dynamic>>();
      } else {
        print('No data available');
        return [];
      }
    } catch (e) {
      print('Error fetching sensor data: $e');
      return [];
    }
  }
}

final apiService = APIService();


// import 'package:amplify_flutter/amplify_flutter.dart';

// class ApiService {
//   Future<void> fetchSensorData() async {
//     try {
//       var operation = Amplify.API.query(
//         request: GraphQLRequest<String>(
//           document: '''
//           query ListSensorData {
//             listSensorData {
//               items {
//                 id
//                 translation
//                 binaryState
//                 timestamp
//               }
//             }
//           }
//           ''',
//         ),
//       );

//       var response = await operation.response;
//       if (response.data != null) {
//         print('Data: ${response.data}');
//       } else {
//         print('Errors: ${response.errors}');
//       }
//     } catch (e) {
//       print('Failed to fetch data: $e');
//     }
//   }
// }
