import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    // if (FirebaseAuth.instance.currentUser != null) {
    return await FirebaseFirestore.instance
        .collection("userProfileSingUp")
        // .orderBy("createdAt", descending: true)
        .get();
    // return null;
    // }
    // return null;
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: FutureBuilder(
        future: initData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) return const Text("Something has error");
          if (snap.data == null) {
            return const Text("Empty data");
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: snap.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                color: const Color.fromARGB(255, 243, 243, 243),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            '${snap.data!.docs[index].data()["imageLink"]}'),
                        // backgroundColor: secondaryColor,
                      ),
                      SizedBox(
                        width: 10.h,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const Text('Hellow'),
                            Text(
                              "name: ${snap.data!.docs[index].data()["name"]}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "email:${snap.data!.docs[index].data()["email"]}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "PhoneNumber:${snap.data!.docs[index].data()["phoneNumber"]}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ]),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
