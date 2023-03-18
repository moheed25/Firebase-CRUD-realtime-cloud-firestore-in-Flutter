import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:project/UI/auth/firestore/insert_fire_store.dart';
import 'package:project/UI/auth/login_screen.dart';
import 'package:project/Utils/utils.dart';

class ShowFireStorePostScreen extends StatefulWidget {
  const ShowFireStorePostScreen({Key? key}) : super(key: key);

  @override
  State<ShowFireStorePostScreen> createState() =>
      _ShowFireStorePostScreenState();
}

class _ShowFireStorePostScreenState extends State<ShowFireStorePostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');

  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
// Serach Filter :
  final searchFilterFirestore = TextEditingController();
// Update / Edits :
  final editfirestoreController = TextEditingController();
  CollectionReference ref1 = FirebaseFirestore.instance.collection('users');

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
        centerTitle: true,
        title: Text('Firestore'),
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
      body: Column(
        children: [
          //
          // Add Filter:
//
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilterFirestore,
              decoration: InputDecoration(
                  hintText: 'Search', border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
//
//
          StreamBuilder(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Something went Wrong!");
                } else {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final title =
                          snapshot.data!.docs[index]['title'].toString();

                      return ListTile(
                        title: Text(
                            snapshot.data!.docs[index]['title'].toString()),
                        subtitle:
                            Text(snapshot.data!.docs[index]['id'].toString()),
                        //
                        trailing: PopupMenuButton(
                            color: Colors.white,
                            elevation: 4,
                            padding: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                            icon: Icon(
                              Icons.more_vert,
                            ),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: PopupMenuItem(
                                      value: 2,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          showMyDailog(
                                              title,
                                              snapshot.data!.docs[index]['id']
                                                  .toString());
                                        },
                                        leading: Icon(Icons.edit),
                                        title: Text('Edit'),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);

                                        // ref.child(snapshot.child('id').value.toString()).update(
                                        //     {
                                        //       'ttitle' : 'hello world'
                                        //     }).then((value){
                                        //
                                        // }).onError((error, stackTrace){
                                        //   Utils().toastMessage(error.toString());
                                        // });

                                        //
                                        //   // Delete :
                                        // ref1
                                        //     .doc(snapshot.data!.docs[index]['id'].toString())
                                        //     .delete();

                                        ref1
                                            .doc(snapshot
                                                .data!.docs[index]['id']
                                                .toString())
                                            .delete()
                                            .then((value) {})
                                            .onError((error, stackTrace) {
                                          Utils()
                                              .toastMessage(error.toString());
                                        });
                                      },
                                      leading: Icon(Icons.delete_outline),
                                      title: Text('Delete'),
                                    ),
                                  ),
                                ]),

                        //
                      );
                    },
                  ));
                }
              })

//

          //
          //
          // StreamBuilder(
          //     stream: fireStore,
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return CircularProgressIndicator();
          //       } else if (snapshot.hasError) {
          //         return Text("Something went Wrong!");
          //       } else {
          //         return Expanded(
          //             child: ListView.builder(
          //           itemCount: snapshot.data!.docs.length,
          //           itemBuilder: (context, index) {
          //             //

          //             //
          //             return ListTile(
          //               onTap: () {
          //                 //
          //                 ref1
          //                     .doc(snapshot.data!.docs[index]['id'].toString())
          //                     .update({'title': 'Moheed Here'}).then((value) {
          //                   Utils().toastMessage('Updated');
          //                 }).onError((error, stackTrace) {
          //                   Utils().toastMessage(error.toString());
          //                 });
          //                 //
          //                 // Delete :
          //                 ref1
          //                     .doc(snapshot.data!.docs[index]['id'].toString())
          //                     .delete();
          //               },
          //               title: Text(
          //                   snapshot.data!.docs[index]['title'].toString()),
          //               subtitle:
          //                   Text(snapshot.data!.docs[index]['id'].toString()),
          //             );
          //           },
          //         ));
          //       }
          //     })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => InsertFireStoreScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDailog(String title, String id) async {
    editfirestoreController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editfirestoreController,
              decoration: InputDecoration(hintText: 'Edit'),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref1.doc(id).update({
                    'title': editfirestoreController.text.toLowerCase()
                  }).then((value) {
                    Utils().toastMessage('Updated');
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                child: Text("Update")),
          ],
        );
      },
    );
  }
}
