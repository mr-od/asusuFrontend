import 'dart:io';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../styles/shared_colors.dart' as my_style;
// import 'package:afia_4/shared/styles/shared_colors.dart' as my_style;
// import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            color: my_style.defaultColor, fontWeight: FontWeight.bold),
      ),
    );

void goTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void goToUntil(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void goPop(context) => Navigator.pop(
      context,
    );

Widget defaultButton(
        {required Color buttonColor,
        double width = double.infinity,
        double radius = 0.0,
        required Function function,
        required String text,
        bool isUpperCase = true}) =>
    Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        width: width,
        height: 25,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: my_style.amaranth)),
        child: MaterialButton(
          onPressed: () {
            function();
          },
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
                color: my_style.lavenderBlush, fontFamily: "FiraCode"),
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  FormFieldValidator<String>? validate,
  required String label,
  required String prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14.0,
          color: my_style.lavenderBlush,
          fontWeight: FontWeight.w500,
          fontFamily: "FiraCode",
        ),
        cursorColor: my_style.lavenderBlush,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          fillColor: my_style.pureBlack,
          prefixIcon: SizedBox(
            height: 35,
            width: 35,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                prefix,
                fit: BoxFit.contain,
                height: 35,
                width: 35,
              ),
            ),
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                    color: my_style.amaranth,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: my_style.amaranth),
              borderRadius: BorderRadius.circular(15.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: my_style.lavenderBlush),
              borderRadius: BorderRadius.circular(15.0)),
          contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
          labelStyle: const TextStyle(
              fontSize: 12.0,
              color: my_style.lavenderBlush,
              fontWeight: FontWeight.w500),
        ),
      ),
    );

Widget searchFormField({
  // required TextEditingController controller,
  // required TextInputType keyboardType,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  FormFieldValidator<String>? validate,
  required String label,
  required String prefix,
  Widget? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14.0,
          color: my_style.lavenderBlush,
          fontWeight: FontWeight.w500,
          fontFamily: "FiraCode",
        ),
        cursorColor: my_style.lavenderBlush,
        // controller: controller,
        keyboardType: TextInputType.text,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          fillColor: my_style.pureBlack,
          filled: true,
          prefixIcon: SizedBox(
            height: 35,
            width: 35,
            child: Padding(
                padding: const EdgeInsets.all(5.0), child: Image.asset(prefix)),
          ),
          suffixIcon: SizedBox(
              height: 50,
              width: 50,
              child: Container(
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: my_style.lavenderBlush),
                height: 50,
                width: 50,
                child: const Icon(
                  Icons.search,
                  color: my_style.amaranth,
                ),
              )),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: my_style.amaranth),
              borderRadius: BorderRadius.circular(15.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: my_style.lavenderBlush),
              borderRadius: BorderRadius.circular(15.0)),
          contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
          labelStyle: const TextStyle(
              fontSize: 12.0,
              color: my_style.lavenderBlush,
              fontWeight: FontWeight.w500),
        ),
      ),
    );

Widget defaultTextField({
  // required TextEditingController controller,
  required TextInputType keyboardType,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextField(
      style: const TextStyle(
          fontSize: 14.0,
          color: Colors.indigoAccent,
          fontWeight: FontWeight.bold),
      cursorColor: my_style.defaultColor,
      // controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      enabled: isClickable,
      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(30.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: my_style.defaultColor),
            borderRadius: BorderRadius.circular(30.0)),
        labelStyle: const TextStyle(
            fontSize: 12.0,
            color: my_style.buttonBG,
            fontWeight: FontWeight.w500),
        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
      ),
    );

Widget defaultTextContainer({
  bool isPassword = false,
  required String text,
  required String prefixtext,

  // required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    Container(
      height: 30,
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: my_style.defaultColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$prefixtext : ',
              style: const TextStyle(
                  fontSize: 12.0,
                  color: my_style.buttonBG,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 12.0,
                    color: my_style.buttonBG,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );

Widget defaultSearchField({
  // required TextEditingController controller,
  required TextInputType keyboardType,
  ValueChanged<String>? onChange,
  VoidCallback? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextField(
      style: const TextStyle(
          fontSize: 14.0,
          color: Colors.indigoAccent,
          fontWeight: FontWeight.bold),
      cursorColor: my_style.defaultColor,
      // controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      enabled: isClickable,
      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
          size: 15,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  size: 15,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(30.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: my_style.defaultColor),
            borderRadius: BorderRadius.circular(30.0)),
        labelStyle: const TextStyle(
            fontSize: 12.0,
            color: my_style.buttonBG,
            fontWeight: FontWeight.w500),
        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
      ),
    );

Widget searchContainer({
  required VoidCallback onTap,
  required VoidCallback onPressed,
  VoidCallback? onPop,
}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        GestureDetector(
          onTap: onPop,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              // Afia4Icons.flow_cross,
              Icons.ac_unit,
              size: 20,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: my_style.pureBlack,
                border: Border.all(color: my_style.defaultColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Image.asset(
                    'assets/icons/A4logo.png',
                    height: 50,
                    width: 50,
                  ),
                ),
                // Column(
                //   children: const [
                //     Expanded(
                //       child: SizedBox(
                //         height: 0.5,
                //       ),
                //     ),
                //     Expanded(
                //       child: VerticalDivider(
                //         color: Colors.grey,
                //         // thickness: 1,
                //       ),
                //     ),
                //     Expanded(
                //       child: SizedBox(
                //         height: 0.5,
                //       ),
                //     ),
                //   ],
                // ),
                const Expanded(
                    child: SizedBox(
                  width: 200,
                  child: Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: my_style.lavenderBlush,
                        fontWeight: FontWeight.normal,
                        fontFamily: "FiraCode"),
                  ),
                )),
                ElevatedButton(
                    onPressed: onPressed,
                    child: const Center(
                      child: Icon(
                        Icons.search,
                        color: my_style.pureBlack,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget iconBox({
  required String imgPath,
  required String iconTitle,
  required Function iconFunction,
}) {
  return InkWell(
    onTap: () {
      iconFunction();
    },
    child: Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imgPath),
              fit: BoxFit.fill,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: const Offset(0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          iconTitle,
          style: const TextStyle(fontWeight: FontWeight.w300),
        )
      ],
    ),
  );
}

Widget vendorHomeTab({
  required String tabIcon,
  String? tabText,
  required Function tabfunction,
  required TextStyle style,
}) {
  return Expanded(
    child: InkWell(
      onTap: () {
        tabfunction();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: my_style.defaultColor),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
          // gradient: blueGradient,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: const Offset(0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                child: Text(
              '$tabText',
              style: style,
              // TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 20,
              //     color: Colors.white),
            )),
            Image.asset(
              tabIcon,
              height: 50,
              width: 50,
            )
          ],
        ),
      ),
    ),
  );
}

String getOS() {
  return Platform.operatingSystem;
}
