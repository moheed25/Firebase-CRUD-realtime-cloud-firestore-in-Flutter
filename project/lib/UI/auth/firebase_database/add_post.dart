import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/UI/widgets/round_button.dart';
import 'package:project/Utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  // hum nay yaha par ek node ko create kiya hai firebase ka ander post ka name ka :

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Add Post'),
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
              controller: postController,
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
                color: Colors.purple,
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseRef.child(id).set({
                    'title': postController.text.toString(),
                    'id': DateTime.now().millisecondsSinceEpoch.toString()
                  }).then((value) {
                    Utils().toastMessage('Post added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                  // agr hum subchild add karna ho to :
                  // String id1  = DateTime.now().millisecondsSinceEpoch.toString() ;
                  // databaseRef.child(id1).child('Comments').set({
                  //   'title' : postController.text.toString() ,
                  //   'id' : DateTime.now().millisecondsSinceEpoch.toString()
                  // }).then((value){
                  //   Utils().toastMessage('Post added');
                  //   setState(() {
                  //     loading = false ;
                  //   });
                  // }).onError((error, stackTrace){
                  //   Utils().toastMessage(error.toString());
                  //   setState(() {
                  //     loading = false ;
                  //   });
                  // });
                })
          ],
        ),
      ),
    );
  }
}
