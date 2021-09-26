import 'package:flutter/material.dart';
import '../modules/user.dart';

class Drawer_Header extends StatelessWidget {
  final User userData;

  Drawer_Header(this.userData);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: EdgeInsets.only(top: 40, left: 10, bottom: 10),
      alignment: Alignment.centerLeft,
      // color: Color(0xff5A8D40),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: (userData.isGoogle || userData.isFacebook)
                ? NetworkImage(userData.photo)
                : AssetImage(
                    "assets/images/unknown.png",
                  ) as ImageProvider,
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      userData.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      userData.email,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0xff000000),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
