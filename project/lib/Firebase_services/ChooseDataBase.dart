import 'package:flutter/material.dart';
import 'package:project/UI/auth/firebase_database/add_post.dart';
import 'package:project/UI/auth/firebase_database/post_screen.dart';
import 'package:project/UI/auth/firestore/fire_store_list.dart';
import 'package:project/UI/widgets/round_button.dart';

class ChooseDatebase extends StatefulWidget {
  const ChooseDatebase({super.key});

  @override
  State<ChooseDatebase> createState() => _ChooseDatebaseState();
}

class _ChooseDatebaseState extends State<ChooseDatebase> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Choose Database'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Container(
              //   height: 150,
              //   width: 150,
              //   child: Image(
              //     image: AssetImage(
              //       "assets/fire2.png",
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 250,
              ),
              RoundButton(
                  title: "RealTimeDataBase",
                  color: Colors.purple,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostScreen()));
                  }),
              SizedBox(
                height: 10,
              ),
              RoundButton(
                  title: "Firestore DataBase",
                  color: Colors.pink,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowFireStorePostScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
