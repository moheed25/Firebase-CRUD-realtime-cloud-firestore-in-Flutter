import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:project/UI/auth/login_screen.dart';
import 'package:project/UI/widgets/round_button.dart';
import 'package:project/Utils/utils.dart';

class InsertFireStoreScreen extends StatefulWidget {
  const InsertFireStoreScreen({Key? key}) : super(key: key);

  @override
  State<InsertFireStoreScreen> createState() => _InsertFireStoreScreenState();
}

class _InsertFireStoreScreenState extends State<InsertFireStoreScreen> {
  final auth = FirebaseAuth.instance;

  bool loading = false;
  // Create Collection :
// also give name of collection :
  final fireStore = FirebaseFirestore.instance.collection('users');
  final addpostfirestoreController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Post'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: addpostfirestoreController,
              decoration: InputDecoration(
                  hintText: 'What is in your mind?',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'Add',
                loading: loading,
                color: Colors.pink,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  fireStore.doc(id).set({
                    'title': addpostfirestoreController.text.toString(),
                    'id': id
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage("Post Added");
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     String id = DateTime.now().millisecondsSinceEpoch.toString();
      //     fireStore.doc(id).set({
      //       'full_name': "asdf", // John Doe
      //       'company': "adsf", // Stokes and Sons
      //       'age': 12,
      //       'id': id
      //     });
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
