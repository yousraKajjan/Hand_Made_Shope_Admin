import 'package:dash_port_hand_made/screens/category/cubit/cubit.dart';
import 'package:dash_port_hand_made/screens/category/cubit/state.dart';
import 'package:dash_port_hand_made/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCtegoryState();
}

class _AddCtegoryState extends State<AddCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryCubit(),
      child: BlocConsumer<AddCategoryCubit, AddCategoryState>(
        listener: (context, state) {
          if (state is AddCategoryErrorState) {
            message(context, state.error, longTime: 7);
            print(state.error);
          }
          if (state is AddCategorySuccessState) {
            message(context, 'Add Category Success');
          }
        },
        builder: (context, state) {
          // var args = ModalRoute.of(context)?.settings.arguments;
          // String titleCategory = (args as String);
          // context.read<AddCategoryCubit>().titleCategoryController.text =
          //     (args as String);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Category:'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 230, 242, 230),
                  ),
                  margin: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width < 600 ? null : 400.h,
                  // height: 650.h,
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    key: context.read<AddCategoryCubit>().formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        const Text('Enter Title Category:'),
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
                              .read<AddCategoryCubit>()
                              .titleCategoryController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Category Type',
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
                              context.read<AddCategoryCubit>().image != null
                                  ? SizedBox(
                                      child: Image.memory(
                                        context.read<AddCategoryCubit>().image!,
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
                                              .read<AddCategoryCubit>()
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            state is AddCategoryLoadingState
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(Colors.blue),
                                    ),
                                    onPressed: () {
                                      context
                                          .read<AddCategoryCubit>()
                                          .saveData(context);
                                    },
                                    child: const Text(
                                      'upload Category',
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
                                  context.read<AddCategoryCubit>().clearForm,
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
