import 'package:flutter/material.dart';

import '../../const/app_color_constants.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColorsConstants.whiteTextColor),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.logout_outlined,
                    color: Color.fromARGB(255, 188, 15, 15)),
                Text(
                  'Logout',
                  style: TextStyle(color: Color.fromARGB(255, 158, 12, 12)),
                )
              ],
            ),
          ),
        ));
  }
}
