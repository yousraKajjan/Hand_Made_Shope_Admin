import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_port_hand_made/screens/products/cubit/state.dart';
import 'package:dash_port_hand_made/screens/products/util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProductsCubit extends Cubit<AddProductsState> {
  AddProductsCubit() : super(AddProductsInitalState());
  static AddProductsCubit get(context) => BlocProvider.of(context);
  final formkey = GlobalKey<FormState>();

  Uint8List? image;
  TextEditingController categoryProductController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = storage.ref().child(childName).child('${uuid}jpg');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void selectImage(context) async {
    Uint8List img = await pickImage(ImageSource.gallery, context);

    image = img;
    emit(SelectImageState());
  }

  final uuid = const Uuid().v4();
  Future<String> saveData(context) async {
    String resp = "Some Error Occurred";
    try {
      emit(AddProductsLoadingState());
      if (formkey.currentState?.validate() ?? false) {
        String imagUrl = await uploadImageToStorage('productImage', image!);
        await FirebaseFirestore.instance.collection("products").doc(uuid).set({
          'id': uuid,
          'title': categoryProductController.text,
          'description': descriptionController.text,
          'price': priceController.text,
          'imageLink': imagUrl,
          'createdAt': Timestamp.now(),
          'isFavourite': false
        });
        clearForm();
        emit(AddProductsSuccessState());
        // Navigator.pushNamed(context, '/allProducts');
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/allProducts', // الصفحة التي ترغب في الانتقال إليها
          ModalRoute.withName(
              '/home'), // '/HomePage' هو اسم المسار للصفحة التي تريد البقاء في المكدس
        );
        print("finish write");
      } else {
        emit(AddProductsErrorState(error: 'Field Required'));

        print('non fire store');
      }

      resp = 'Success';
    } catch (err) {
      resp = err.toString();
      emit(AddProductsErrorState(error: resp));
    }
    return resp;
  }

  void clearForm() {
    priceController.clear();
    categoryProductController.clear();
    descriptionController.clear();
    image = null;
    emit(ClearFormState());
    // webImage = Uint8List(8);
  }
  //

  // void saveProfile() async {
  //   String title = titleController.text;
  //   String description = descriptionController.text;
  //   String price = priceController.text;
  //   String resp = await saveData(
  //       title: title, description: description, price: price, file: image!);
  // }
}
