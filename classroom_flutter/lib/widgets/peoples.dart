import 'package:flutter/material.dart';

class Peoples extends StatefulWidget {
  const Peoples({Key? key}) : super(key: key);

  @override
  _PeoplesState createState() => _PeoplesState();
}

class _PeoplesState extends State<Peoples> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("People"),
    );
  }
}
