import 'package:flutter/material.dart';

class Input_Widget extends StatefulWidget {
  String inputName;
  TextEditingController controller;
  String? errorText;
  TextInputType inputType;
  String? hintText;
  bool isObscure;
  bool isObscureIcon;

  Input_Widget(
    this.inputName,
    this.controller,
    this.errorText,
    this.inputType,
    this.hintText,
    this.isObscure,
    this.isObscureIcon,
  );

  @override
  _Input_WidgetState createState() => _Input_WidgetState();
}

class _Input_WidgetState extends State<Input_Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 50),
            width: double.infinity,
            child: Text(
              widget.inputName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
              ),
            ),
          ),
          Container(
            width: 260,
            height: 70,
            child: TextField(
              obscureText: widget.isObscureIcon,
              controller: widget.controller,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
              ),
              decoration: InputDecoration(
                  fillColor: Color(0xffEEEAEA),
                  filled: true,
                  hintText: widget.hintText,
                  errorText: widget.errorText,
                  suffixIcon: widget.isObscure
                      ? IconButton(
                          icon: Icon(widget.isObscureIcon
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              widget.isObscureIcon = !widget.isObscureIcon;
                            });
                          },
                        )
                      : null
                  //border: InputBorder.none,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
