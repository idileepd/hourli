// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:hourli/models/todo.dart';
// import 'package:hourli/models/user_model.dart';

// class Database {
//   final FirebaseFirestore _firestore = Firestore.instance;

//   Future<bool> createNewUser(UserModel user) async {
//     try {
//       await _firestore.collection("users").doc(user.uid).setData({
//         "name": user.name,
//         "email": user.email,
//       });
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   Future<UserModel> getUserDetails(String uid) async {
//     try {
//       DocumentSnapshot _doc =
//           await _firestore.collection("users").doc(uid).get();

//       return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }

//   Future<void> addTodo(String content, String uid) async {
//     try {
//       await _firestore
//           .collection("users")
//           .doc(uid)
//           .collection("todos")
//           .add({
//         'dateCreated': Timestamp.now(),
//         'content': content,
//         'done': false,
//       });
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }

// Stream<List<TodoModel>> todoStream(String uid) {
//   return _firestore
//       .collection("users")
//       .doc(uid)
//       .collection("todos")
//       .orderBy("dateCreated", descending: true)
//       .snapshots()
//       .map((QuerySnapshot query) {
//     List<TodoModel> retVal = List();
//     query.documents.forEach((element) {
//       retVal.add(TodoModel.fromDocumentSnapshot(element));
//     });
//     return retVal;
//   });
// }

//   Future<void> updateTodo(bool newValue, String uid, String todoId) async {
//     try {
//       _firestore
//           .collection("users")
//           .doc(uid)
//           .collection("todos")
//           .doc(todoId)
//           .updateData({"done": newValue});
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//   }
// }
