import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({super.key});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    return await FirebaseFirestore.instance
        .collection("Category")
        .orderBy("createdAt", descending: true)
        .get();
    // return null;
  }

  Future<void> deleteCategory(String categoryId) async {
    FirebaseFirestore.instance
        .collection('Category')
        .doc(categoryId)
        .delete()
        .then((_) => print("Product has been deleted"))
        .catchError((error) => print("Failed to delete product: $error"));
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
        title: const Text('AllCategory'),
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

          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // mainAxisSpacing: 0.5,
                // crossAxisSpacing: 0.1,
                // crossAxisCount: 2,
                // childAspectRatio: 3
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                childAspectRatio: MediaQuery.of(context).size.width > 600
                    ? 0.6 // إذا كان العرض أكبر من 600
                    : MediaQuery.of(context).size.width >= 500 &&
                            MediaQuery.of(context).size.width <= 600
                        ? 0.9 // إذا كان العرض بين 500 و 600
                        : 0.5, // إذا كان العرض أقل من 600
//من ال 600 لل 640 عم يضربٍ
                // childAspectRatio:
                // MediaQuery.of(context).size.width > 600 ? 1 / 1 : 0.59,
              ),
              itemCount: snap.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150.h,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 45, 36, 213),
                                  blurRadius: 8.0,
                                  spreadRadius: 1.5,
                                  blurStyle: BlurStyle.outer)
                            ],
                            color: const Color.fromARGB(255, 198, 242, 244),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // width: 400,
                          // height: double.infinity,
                          // color: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 120.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            15), // حدد نصف قطر الحدود هنا
                                      ),
                                      child: ClipRRect(
                                        // استخدم ClipRRect لتطبيق borderRadius على الصورة أيضًا
                                        borderRadius: BorderRadius.circular(
                                            15), // تطابق هذا مع BoxDecoration
                                        child: Image.network(
                                          '${snap.data!.docs[index]["imageLink"]}',
                                          fit: BoxFit
                                              .cover, // يمكنك تعديل هذا لتحقيق النمط الذي تفضله لعرض الصورة
                                        ),
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   radius: 70,
                                    //   backgroundImage: NetworkImage(
                                    //       '${snap.data!.docs[index]["imageLink"]}'),
                                    // ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${snap.data!.docs[index]["Type Category"]}",
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .titleMedium,
                                    ),

                                    // Text(
                                    //   "Price: ${snap.data!.docs[index].data()["price"]}\$",
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .titleMedium,
                                    // ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          deleteCategory(snap.data!.docs[index]
                                              .data()["id"]);
                                          print(snap.data!.docs[index]
                                              .data()["id"]);
                                        });

                                        // String price =
                                        //     '${snap.data!.docs[index].data()["price"]}';
                                        // String title =
                                        //     '${snap.data!.docs[index].data()["title"]}';
                                        // String Descreption =
                                        //     '${snap.data!.docs[index].data()["description"]}';

                                        // Navigator.pushNamed(context, '/addProd',
                                        //     arguments: [
                                        //       title,
                                        //       Descreption,
                                        //       price,
                                        //     ]);
                                      },
                                      color: const Color.fromARGB(
                                          255, 39, 36, 213),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        String type =
                                            '${snap.data!.docs[index].data()["Type Category"]}';
                                        String idCategory =
                                            '${snap.data!.docs[index].data()["id"]}';
                                        Navigator.pushNamed(
                                            context, '/EditCategory',
                                            arguments: [type, idCategory]);
                                        // String title =
                                        //     '${snap.data!.docs[index].data()["title"]}';
                                        // String Descreption =
                                        //     '${snap.data!.docs[index].data()["description"]}';

                                        // Navigator.pushNamed(context, '/addProd',
                                        //     arguments: [
                                        //       title,
                                        //       Descreption,
                                        //       price,
                                        //     ]);
                                      },
                                      color: const Color.fromARGB(
                                          255, 39, 36, 213),
                                      child: const Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
