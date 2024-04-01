import 'package:dash_port_hand_made/screens/products/editcubit/cubit.dart';
import 'package:dash_port_hand_made/screens/products/editcubit/state.dart';
import 'package:dash_port_hand_made/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProducts extends StatefulWidget {
  const EditProducts({super.key});

  @override
  State<EditProducts> createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProductsCubit(),
      child: BlocConsumer<EditProductsCubit, EditProductsState>(
        listener: (context, state) {
          if (state is EditProductsErrorState) {
            message(context, state.error, longTime: 7);
            print(state.error);
          }
          if (state is EditProductsSuccessState) {
            message(context, 'Edit Product Success');
          }
        },
        builder: (context, state) {
          //   final List<dynamic>? arguments =
          //     ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
          // if (arguments != null) {
          //   String type = arguments[0];
          //   type =
          //       context.read<EditProductsCubit>().categoryProductController.text;
          //   String idCategory = arguments[1];
          // }
          var arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is List<String>) {
            context.read<EditProductsCubit>().categoryProductController.text =
                arguments[0];
            // context.read<EditProductsCubit>().descriptionController.text =
            // arguments[1];
            // context.read<EditProductsCubit>().priceController.text =
            // arguments[2];
            String idProducts = arguments[1];
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Product:'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12,
                  ),
                  margin: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width < 600 ? null : 400.h,

                  // width: 250.w,
                  // height: 650.h,
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: context.read<EditProductsCubit>().formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        const Text('Enter Category Products'),
                        TextFormField(
                          // initialValue: args,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            }
                            return null;
                          },
                          controller: context
                              .read<EditProductsCubit>()
                              .categoryProductController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Category Products',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text('Enter Description Products'),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            }
                            return null;
                          },
                          controller: context
                              .read<EditProductsCubit>()
                              .descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Enter description',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text('Enter Price  Products in \$'),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            }
                            return null;
                          },
                          controller:
                              context.read<EditProductsCubit>().priceController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Price',
                            contentPadding: EdgeInsets.all(10),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              context.read<EditProductsCubit>().image != null
                                  ? SizedBox(
                                      child: Image.memory(
                                        context
                                            .read<EditProductsCubit>()
                                            .image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  // ? CircleAvatar(
                                  //     radius: 64,
                                  //     backgroundColor: Colors.grey,
                                  //     backgroundImage: MemoryImage(image!),
                                  //   )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color.fromARGB(
                                            255, 160, 160, 245),
                                      ),
                                      width: 300,
                                      height: 300,
                                      child: TextButton(
                                        onPressed: () {
                                          context
                                              .read<EditProductsCubit>()
                                              .selectImage(context);
                                        },
                                        child: const Text(
                                          'Choose Your image Products',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            state is EditProductsLoadingState
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      // final List<dynamic>? arguments =
                                      //     ModalRoute.of(context)!
                                      //         .settings
                                      //         .arguments as List<dynamic>?;
                                      // // if (arguments != null) {
                                      // String type = arguments![0];
                                      // type = context
                                      //     .read<EditProductsCubit>()
                                      //     .categoryProductController
                                      //     .text;
                                      // String idProducts = arguments[1];
                                      // // }
                                      final List<dynamic>? arguments =
                                          ModalRoute.of(context)!
                                              .settings
                                              .arguments as List<dynamic>?;

                                      String idProducts = arguments![1];
                                      context
                                          .read<EditProductsCubit>()
                                          .EditData(context, idProducts);
                                    },
                                    child: const Text(
                                      'upload Edit Products',
                                    ),
                                  ),
                            SizedBox(
                              width: 20.h,
                            ),
                            ElevatedButton(
                              onPressed:
                                  context.read<EditProductsCubit>().clearForm,
                              child: const Text(
                                'Clear Form',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
