import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

Future<List> getPeople() async{
  List people = [];

  CollectionReference collectionReferencePeople = database.collection('people');
  QuerySnapshot queryPeople = await collectionReferencePeople.get();

  queryPeople.docs.forEach((document){
    people.add(document.data());
  });

  return people;
}

