import 'package:flutter/material.dart';

class appBar_Widget extends StatelessWidget implements PreferredSizeWidget {
  final Function filter;
  final bool pay;

  appBar_Widget(this.filter, this.pay);

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
              padding: EdgeInsets.only(left: 5),
              child: Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Container(
              height: 40,
              width: 220,
              child: pay
                  ? null
                  : TextField(
                      onChanged: (value) => filter(value),
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
            pay
                ? Container()
                : SizedBox(
                    width: 20,
                  ),
            pay
                ? IconButton(
                    icon: Icon(
                      Icons.refresh,
                      size: 30,
                    ),
                    onPressed: () => filter(context),
                  )
                : Icon(
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
