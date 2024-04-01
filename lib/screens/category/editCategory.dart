import 'package:dash_port_hand_made/screens/category/editcubit/cubit.dart';
import 'package:dash_port_hand_made/screens/category/editcubit/state.dart';
import 'package:dash_port_hand_made/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key});

  @override
  State<EditCategory> createState() => _EditCtegoryState();
}

class _EditCtegoryState extends State<EditCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditCategoryCubit(),
      child: BlocConsumer<EditCategoryCubit, EditCategoryState>(
        listener: (context, state) {
          if (state is EditCategoryErrorState) {
            message(context, state.error, longTime: 7);
            print(state.error);
          }
          if (state is EditCategorySuccessState) {
            message(context, 'Edit Category Success');
          }
        },
        builder: (context, state) {
          final List<dynamic>? arguments =
              ModalRoute.of(context)!.settings.arguments as List<dynamic>?;
          if (arguments != null) {
            String type = arguments[0];
            type =
                context.read<EditCategoryCubit>().titleCategoryController.text;
            String idCategory = arguments[1];
          }

          // String titleCategory = (args as String);
          context.read<EditCategoryCubit>().titleCategoryController.text =
              (arguments![0] as String);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Category:'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  // width: 400,
                  // height: 600.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(31, 1, 9, 228),
                  ),
                  margin: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width < 600 ? null : 400.h,

                  // height: 650.h,
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: context.read<EditCategoryCubit>().formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        const Text('Edit Your Title Category:'),
                        TextFormField(
                          // initialValue: titleCategory,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This Field is required';
                            }
                            return null;
                          },
                          controller: context
                              .read<EditCategoryCubit>()
                              .titleCategoryController,
                          decoration: const InputDecoration(
                            hintText: 'Edit Category Type',
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
                              context.read<EditCategoryCubit>().image != null
                                  ? SizedBox(
                                      child: Image.memory(
                                        context
                                            .read<EditCategoryCubit>()
                                            .image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color.fromARGB(
                                            255, 152, 174, 245),
                                      ),
                                      width: 300,
                                      height: 300,
                                      child: TextButton(
                                        onPressed: () {
                                          context
                                              .read<EditCategoryCubit>()
                                              .selectImage(context);
                                        },
                                        child: const Text(
                                          'Choose Your image Category',
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              state is EditCategoryLoadingState
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.blue),
                                      ),
                                      onPressed: () {
                                        final List<dynamic>? arguments =
                                            ModalRoute.of(context)!
                                                .settings
                                                .arguments as List<dynamic>?;

                                        String idCategory = arguments![1];
                                        context
                                            .read<EditCategoryCubit>()
                                            .editData(context, idCategory);
                                      },
                                      child: const Text(
                                        'Edit Category',
                                      ),
                                    ),
                              SizedBox(
                                width: 20.h,
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.blue),
                                ),
                                onPressed:
                                    context.read<EditCategoryCubit>().clearForm,
                                child: const Text(
                                  'Clear Form',
                                ),
                              ),
                            ],
                          ),
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
