import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initData() async {
    return await FirebaseFirestore.instance
        .collection("products")
        .orderBy("createdAt", descending: true)
        .get();
    // return null;
  }

  Future<void> deleteProduct(String productId) async {
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
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
        title: const Text('AllProducts'),
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
                // crossAxisCount: 2,
                // mainAxisSpacing: 0.5,
                // childAspectRatio:
                //     MediaQuery.of(context).size.width > 600 ? 1 / 0.5 : 0.51,
                childAspectRatio: MediaQuery.of(context).size.width > 600
                    ? 0.7 // إذا كان العرض أكبر من 600
                    : MediaQuery.of(context).size.width >= 500 &&
                            MediaQuery.of(context).size.width <= 600
                        ? 0.51 // إذا كان العرض بين 500 و 600
                        : 0.5, // إذا كان العرض أقل من 600
//من ال 600 لل 640 عم يضربٍ
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
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
                                  color: Color.fromARGB(255, 204, 36, 213),
                                  blurRadius: 8.0,
                                  spreadRadius: 1.5,
                                  blurStyle: BlurStyle.outer)
                            ],
                            color: const Color.fromARGB(255, 249, 222, 245),
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
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      // "Title:"
                                      "${snap.data!.docs[index]["title"]}",
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .titleMedium,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      " ${snap.data!.docs[index].data()["price"]}\$",
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .titleMedium,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          deleteProduct(snap.data!.docs[index]
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
                                          255, 204, 36, 213),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        String type =
                                            '${snap.data!.docs[index].data()["title"]}';
                                        String description =
                                            '${snap.data!.docs[index].data()["description"]}';
                                        String price =
                                            '${snap.data!.docs[index].data()["price"]}';
                                        String idProducts =
                                            '${snap.data!.docs[index].data()["id"]}';
                                        Navigator.pushNamed(
                                            context, '/EditProducts',
                                            // );
                                            arguments: [
                                              type,
                                              // description,
                                              // price,
                                              idProducts
                                            ]);
                                        // setState(() {
                                        //   deleteProduct(snap.data!.docs[index]
                                        //       .data()["id"]);
                                        //   print(snap.data!.docs[index]
                                        //       .data()["id"]);
                                        // });

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
                                          255, 204, 36, 213),
                                      child: const Text(
                                        'EditProduct',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
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
