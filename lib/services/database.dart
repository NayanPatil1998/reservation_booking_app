import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reservationapp/models/ReservationModel.dart';

class DataBaseService {
  final String uid;

  DataBaseService({this.uid});

  final CollectionReference taskCollection =
      Firestore.instance.collection('reservations');

  Future updateUserData(String id,
      String name, String mobileNumber, String dob, String emailId) async {
    return await taskCollection.document(id).setData({
      'name': name,
      'emailId': emailId,
      'mNumber': mobileNumber,
      'dob': dob
    });
  }
  Future addUserData(
      String name, String mobileNumber, String dob, String emailId) async {
    return await taskCollection.document().setData({
      'name': name,
      'emailId': emailId,
      'mNumber': mobileNumber,
      'dob': dob
    });
  }

  Future removeData(String id) async{
    return await taskCollection.document(id).delete();
  }


  List<ReservationModel> _reservationList(QuerySnapshot snapshot) {
    print(snapshot.documents);
    return snapshot.documents.map((doc) {
      print(doc);
      return ReservationModel(
        keyId: doc.documentID,
        name: doc.data['name'] ?? '',
        emailId: doc.data['emailId'] ?? '',
        dob: doc.data['dob'] ?? '',
        mNumber: doc.data['mNumber'] ?? '',
      );
    }).toList();
  }

  ReservationModel _taskDataFromSnapshot(DocumentSnapshot snapshot){
    return ReservationModel(
      keyId: snapshot.documentID,
      name: snapshot.data['name'],
      emailId: snapshot.data['emailId'],
      mNumber: snapshot.data['mNumber'],
      dob: snapshot.data['dob'],

    );
  }

  Stream<List<ReservationModel>> get tasks {
    return taskCollection.snapshots().map(_reservationList);
  }

  Stream<DocumentSnapshot> get resData {
    return taskCollection.document(uid).snapshots();
  }
   Stream<ReservationModel> getDocumentById(String id) {
    return taskCollection.document(id).snapshots().map(_taskDataFromSnapshot);
  }
}
