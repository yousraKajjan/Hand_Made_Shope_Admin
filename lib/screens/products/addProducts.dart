import 'package:dash_port_hand_made/screens/products/cubit/cubit.dart';
import 'package:dash_port_hand_made/screens/products/cubit/state.dart';
import 'package:dash_port_hand_made/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductsCubit(),
      child: BlocConsumer<AddProductsCubit, AddProductsState>(
        listener: (context, state) {
          if (state is AddProductsErrorState) {
            message(context, state.error, longTime: 7);
            print(state.error);
          }
          if (state is AddProductsSuccessState) {
            message(context, 'Add Product Success');
          }
        },
        builder: (context, state) {
          var args = ModalRoute.of(context)?.settings.arguments;
          if (args is List<String>) {
            context.read<AddProductsCubit>().categoryProductController.text =
                args[0];
            context.read<AddProductsCubit>().descriptionController.text =
                args[1];
            context.read<AddProductsCubit>().priceController.text = args[2];
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Product:'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(31, 1, 9, 228),
                  ),
                  margin: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width < 600 ? null : 400.h,
                  // height: 650.h,
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: context.read<AddProductsCubit>().formkey,
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
                              .read<AddProductsCubit>()
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
                              .read<AddProductsCubit>()
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
                              context.read<AddProductsCubit>().priceController,
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
                              context.read<AddProductsCubit>().image != null
                                  ? SizedBox(
                                      child: Image.memory(
                                        context.read<AddProductsCubit>().image!,
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
                                              .read<AddProductsCubit>()
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            state is AddProductsLoadingState
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<AddProductsCubit>()
                                          .saveData(context);
                                    },
                                    child: const Text('upload Products'),
                                  ),
                            SizedBox(
                              width: 20.h,
                            ),
                            ElevatedButton(
                              onPressed:
                                  context.read<AddProductsCubit>().clearForm,
                              child: const Text('Clear Form'),
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
