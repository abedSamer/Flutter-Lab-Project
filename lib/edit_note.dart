import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lap_project/Home.dart';
import 'package:lap_project/main.dart';
import 'package:lap_project/module/TagColors.dart';
import 'package:lap_project/module/bottom_sheet.dart';
import 'package:lap_project/sqfDB.dart';

class EditNote extends StatefulWidget {
  final title;
  final note;
  final color;
  final id;
  EditNote({
    Key? key,
    this.title,
    this.note,
    this.color,
    this.id,
  }) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  var color, id;
  SqlDb db = SqlDb();

  @override
  void initState() {
    title.text = widget.title;
    note.text = widget.note;
    id = widget.id;
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var _show = false;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(
              TagColors().getColorAsARGB(color)[0],
              TagColors().getColorAsARGB(color)[1],
              TagColors().getColorAsARGB(color)[2],
              TagColors().getColorAsARGB(color)[3]),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Text("data");
                    });
              },
            ),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () async {
                int result = await db.updateData(
                    "UPDATE 'notes' SET title ='${title.text}', note = '${title.text}', color = '0XFFFF00FF' WHERE id = '${this.id}'  ");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (route) => false);
              },
            )
          ],
          title: Text(" New Note"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          )),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                DateFormat("h:mm, d MMM").format(now),
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextField(
              controller: title,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: "   Type Something ....",
                  hintStyle: TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: TextField(
                controller: note,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: "   Type Something ....",
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
