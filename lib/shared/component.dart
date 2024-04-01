import 'package:dash_port_hand_made/shared/responsive.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void message(BuildContext context, String msg, {int longTime = 5}) {
  ToastContext toastContext = ToastContext();
  toastContext.init(context);
  Toast.show(msg, duration: longTime);
}

Widget MyTextField({
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? hintText,
  Widget? label,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Function? onTap,
  String? Function(String?)? validator,
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      validator: validator,
      onTap: () {
        onTap;
      },
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          // gapPadding: 20.0,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
      onFieldSubmitted: (value) {
        print(value);
      },
    ),
  );
}

class TextWidget extends StatelessWidget {
  TextWidget({
    Key? key,
    required this.text,
    required this.color,
    this.textSize = 16,
    this.maxLines = 1,
    this.isTitle = false,
  }) : super(key: key);
  final String text;
  final Color color;
  final double textSize;
  bool isTitle;
  int maxLines = 1;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          fontSize: textSize,
          color: color,
          overflow: TextOverflow.ellipsis,
          fontWeight: isTitle ? FontWeight.w600 : FontWeight.w400),
    );
  }
}

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.backgroundColor,
  }) : super(key: key);

  // You can use Function instead of VoidCallback
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: 10.0 * 1.5,
          vertical: 10.0 / (Responsive.isDesktop(context) ? 1 : 2),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      icon: Icon(
        icon,
        size: 20,
      ),
      label: Text(text),
    );
  }
}

// class ProductGridWidget extends StatelessWidget {
//   const ProductGridWidget(
//       {Key? key,
//       this.crossAxisCount = 4,
//       this.childAspectRatio = 1,
//       this.isInMain = true})
//       : super(key: key);
//   final int crossAxisCount;
//   final double childAspectRatio;
//   final bool isInMain;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       //there was a null error just add those lines
//       stream: FirebaseFirestore.instance.collection('products').snapshots(),

//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.connectionState == ConnectionState.active) {
//           if (snapshot.data == null) {
//             return const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(18.0),
//                 child: Text('Your store is empty'),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return const Center(
//               child: Text(
//                 'Something went wrong',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//               ),
//             );
//           }
//         }
//         return GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: isInMain && snapshot.data!.docs.length > 6
//                 ? 4
//                 : snapshot.data!.docs.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: crossAxisCount,
//               childAspectRatio: childAspectRatio,
//               crossAxisSpacing: 10.0,
//               mainAxisSpacing: 10.0,
//             ),
//             itemBuilder: (context, index) {
//               return ProductWidget(
//                   // id: snapshot.data!.docs[index]['id'],
//                   );
//             });
//       },
//     );
//   }
// }
