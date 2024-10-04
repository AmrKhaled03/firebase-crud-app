import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrud/models/user/user_model.dart';

class FirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> _read(
      {required String collection}) async {
    return await _firestore.collection(collection).get();
  }

  Future<String> _create(
      {required String collection, required Map<String, dynamic> data}) async {
    assert(collection.isNotEmpty, "Collection path must not be empty");
    DocumentReference docRef =
        await _firestore.collection(collection).add(data);
    return docRef.id;
  }

  Future<void> _update(
      {required String collection,
      required Map<String, dynamic> data,
      required String id}) async {
    await _firestore.collection(collection).doc(id).update(data);
  }

  Future<void> _delete({required String collection, required String id}) async {
    assert(id.isNotEmpty, "Document ID cannot be empty");
    await _firestore.collection(collection).doc(id).delete();
  }

  Future<List<UserModel>> getUsers() async {
    try {
      QuerySnapshot response = await _read(collection: "users");
      List<QueryDocumentSnapshot<Object?>> documents = response.docs;

      List<UserModel> users = documents.map((user) {
        String docId = user.id;

        UserModel userModel =
            UserModel.fromJson(user.data() as Map<String, dynamic>, docId);

        return userModel;
      }).toList();

      return users;
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  Future<String> insertUser(
      {required String name,
      required String email,
      required String phone}) async {
    try {
      UserModel userModel = UserModel(name: name, email: email, phone: phone);
      String userId =
          await _create(collection: "users", data: userModel.toMap());
      return userId;
    } catch (e) {
      throw Exception('Error inserting user: $e');
    }
  }

  Future<void> deleteUser({required String id}) async {
    try {
      await _delete(collection: "users", id: id);
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

  Future<void> updateUser(
      {required String id,
      required String name,
      required String email,
      required String phone}) async {
    try {
      Map<String, dynamic> updatedData = {
        'name': name,
        'email': email,
        'phone': phone,
      };

      await _update(collection: "users", data: updatedData, id: id);
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }
}
