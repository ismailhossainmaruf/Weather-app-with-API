import 'package:flutter/material.dart';

class DetailsPagee extends StatefulWidget {
  const DetailsPagee({Key? key}) : super(key: key);

  @override
  State<DetailsPagee> createState() => _DetailsPageeState();
}

class _DetailsPageeState extends State<DetailsPagee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff27293F),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: Text("Details"),
        // leading: IconButton(
        //   onPressed: (){},
        //   icon: Icon(Icons.settings_suggest),
        // ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notification_add),
          ),
        ],
      ),
    );
  }
}
