import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location_app/const/app_color_constants.dart';

class ButtonLoginAndSignIn extends StatelessWidget {
  const ButtonLoginAndSignIn({
    super.key,
    required this.size,
    required this.onTap,
    required this.title,
    required this.isLoading,
  });

  final Size size;
  final void Function() onTap;
  final String title;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(216, 5, 5, 5).withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: AppColorsConstants.blueButtonColor),
              child: Center(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700))),
            ),
            Positioned(
              top: 0,
              right: 8,
              bottom: 0,
              child: Center(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  child: Center(
                      child: isLoading == false
                          ? const Icon(
                              Icons.arrow_forward_rounded,
                              size: 30,
                              color: Color.fromARGB(255, 0, 0, 0),
                            )
                          : CupertinoActivityIndicator(
                              color: AppColorsConstants.blueButtonColor,
                            )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
