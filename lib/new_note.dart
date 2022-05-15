import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lap_project/Home.dart';
import 'package:lap_project/main.dart';
import 'package:lap_project/module/TagColors.dart';
import 'package:lap_project/module/bottom_sheet.dart';
import 'package:lap_project/sqfDB.dart';

class NewNote extends StatefulWidget {
  final title;
  final note;
  final color;
  final id;
  NewNote({
    Key? key,
    this.title,
    this.note,
    this.color,
    this.id,
  }) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  var now = DateTime.now();
//creating a text field controllers to get data from the fields and make sure that the user enter title at least
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  SqlDb db = SqlDb();
  String color = "FF0000FF";

  String _getDataToSaveInDatabase() {
    return "INSERT INTO 'notes' (title, note, color)VALUES ('${title.text}' , '${note.text}' , '$color') ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              //this method build in with flutter to show bottom sheet and control it
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return CustomBottomSheet(
                      isNew: true,
                      title: title.text,
                      note: note.text,
                      color: color,
                      //this parameter is a function used to translate data bettwen  the tow classes
                      onChose: (String newColor) {
                        setState(() {
                          color = newColor;
                        });
                      },
                    );
                  });
            },
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () async {
              //use on press over save icon to send date to database and , go to main screen
              int result = await db.insertData(_getDataToSaveInDatabase());
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false);
            },
          )
        ],
        title: Text(" New Note"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                //DataFormat is a class from outsource package to get my date and time format to display
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
                //put maxLines to null to remove lemetation about write description
                maxLines: null,
                //change keyboard type to make in integrated with his purpose;
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
