import 'package:flutter/material.dart';

class appBar_Widget extends StatelessWidget implements PreferredSizeWidget {
  const appBar_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        //color: Color(0xff5A8D40),
        padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 10),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Builder(
                builder: (context) => GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      size: 30,
                    )),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Container(
              height: 40,
              width: 250,
              child: TextField(
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff000000),
                ),
                decoration: InputDecoration(
                  fillColor: Color(0xffEEEAEA),
                  filled: true,
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.only(bottom: 10),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.mic,
              size: 35,
            )
          ],
        ),
      ),
      preferredSize: Size.fromHeight(70),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}
