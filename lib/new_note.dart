import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lap_project/Home.dart';
import 'package:lap_project/module/TagColors.dart';
import 'package:lap_project/module/bottom_sheet.dart';
import 'package:lap_project/sqfDB.dart';

class NewNote extends StatefulWidget {
  final title;
  final note;
  final color;
  final id, isNew;
  NewNote({
    Key? key,
    this.title,
    this.note,
    this.color,
    this.id,
    required this.isNew,
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
  var id, isNew, _titleColor;
  @override
  void initState() {
    title.text = widget.title;
    note.text = widget.note;
    id = widget.id;
    color = widget.color;
    isNew = widget.isNew;
    _titleColor = Colors.indigo;
    super.initState();
  }

  _emptyTitleAlirt() {
    setState(() {
      _titleColor = Colors.red;
    });
  }

  String _getDataToSaveInDatabase() {
    return "INSERT INTO 'notes' (title, note, color)VALUES ('${title.text}' , '${note.text}' , '$color') ";
  }

  String _getDataToUpdateInDatabase() {
    return "UPDATE 'notes' SET title ='${title.text}', note = '${note.text}', color = '$color' WHERE id = '${this.id}'  ";
  }

  @override
  Widget build(BuildContext context) {
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
              //this method build in with flutter to show bottom sheet and control it
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return CustomBottomSheet(
                      isNew: isNew,
                      title: title.text,
                      note: note.text,
                      color: color,
                      id: id != null ? id : "",
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
              if (title.text != "") {
                isNew
                    ? await db.insertData(_getDataToSaveInDatabase())
                    : await db.updateData(_getDataToUpdateInDatabase());
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (route) => false);
              } else {
                _emptyTitleAlirt();
              }
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
              restorationId: "titleField",
              controller: title,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: "   Type Something ....",
                  hintStyle: TextStyle(
                      color: _titleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: TextField(
                controller: note,
                //put maxLines to null to remove Limitation about write description
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
