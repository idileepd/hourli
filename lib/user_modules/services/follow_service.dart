// import 'dart:convert';

// import 'package:http/http.dart';

// makePostRequest(String token) async {
//   print("making post req");
//   // set up POST request arguments
//   String url = 'https://us-central1-hourli.cloudfunctions.net/verifyToken';
//   Map<String, String> headers = {
//     "Content-type": "application/json",
//     "Authorization": "Bearer $token"
//   };
//   // String json = '{}';

//   // make POST request
//   Response response = await post(
//     url,
//     headers: headers,
//   );
//   // check the status code for the result
//   int statusCode = response.statusCode;
//   // this API passes back the id of the new item added to the body
//   print(statusCode);
//   String body = response.body;
//   print(body);

//   // {
//   //   "title": "Hello",
//   //   "body": "body text",
//   //   "userId": 1,
//   //   "id": 101
//   // }
// }
