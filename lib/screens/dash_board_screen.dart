import 'package:dash_port_hand_made/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome In Your Dashboard'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: ScrollController(),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text('Dashboard'),
              const SizedBox(
                height: 20,
              ),
              // TextWidget(
              //   text: 'Latest Products',
              //   color: Colors.green,
              // ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonsWidget(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/addProd',
                              );
                            },
                            text: 'Add product',
                            icon: Icons.add,
                            backgroundColor: Colors.blue),
                        // const Spacer(),
                        ButtonsWidget(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/addCategory',
                              );
                            },
                            text: 'Add Category',
                            icon: Icons.add,
                            backgroundColor: Colors.blue),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonsWidget(
                            onPressed: () {
                              Navigator.pushNamed(context, "/allProducts");
                            },
                            text: 'View All Products',
                            icon: Icons.store,
                            backgroundColor: Colors.blue),
                        // const SizedBox(
                        //     // width: 10.h,
                        //     ),
                        // const Spacer(),
                        SizedBox(
                          height: 10.h,
                        ),
                        ButtonsWidget(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/allCategory',
                              );
                            },
                            text: 'View All Category',
                            icon: Icons.category,
                            backgroundColor: Colors.blue),
                        SizedBox(
                          height: 10.h,
                        ),
                        ButtonsWidget(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/usersPage',
                              );
                            },
                            text: 'View All Users',
                            icon: Icons.group_rounded,
                            backgroundColor: Colors.blue),
                        // const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              // const SizedBox(height: 10.0),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       child: Column(
              //         children: [
              //           Responsive(
              //             mobile: ProductGridWidget(
              //               crossAxisCount: size.width < 650 ? 2 : 4,
              //               childAspectRatio:
              //                   size.width < 650 && size.width > 350 ? 1.1 : 0.8,
              //             ),
              //             desktop: ProductGridWidget(
              //               childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
