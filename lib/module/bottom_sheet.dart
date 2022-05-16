import 'package:flutter/material.dart';
import 'package:lap_project/Home.dart';
import 'package:lap_project/main.dart';
import 'package:lap_project/module/TagColors.dart';
import 'package:lap_project/new_note.dart';
import 'package:lap_project/sqfDB.dart';

class CustomBottomSheet extends StatefulWidget {
  final isNew, id, title, note, color;
  //  VoidCallback onChose;
  ValueChanged<String> onChose = (value) {};

  CustomBottomSheet(
      {Key? key,
      this.isNew,
      this.id,
      this.color,
      this.title,
      this.note,
      required this.onChose})
      : super(key: key);

  @override
  State<CustomBottomSheet> createState() => CustomBottomSheetState();
}

class CustomBottomSheetState extends State<CustomBottomSheet> {
  List selectedColor =
      List.generate(TagColors().colors.length, (index) => false);

  var isNew, id, title, note;

  var color;
  @override
  void initState() {
    isNew = widget.isNew;
    id = widget.id;
    title = widget.title;
    note = widget.note;
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  getColor() {
    return this.color;
  }

  Color _getThemeColor(String color) {
    List<int> ARGB = TagColors().getColorAsARGB(color);
    int A = ARGB[0];
    int R = ARGB[1];
    int G = ARGB[2];
    int B = ARGB[3];
    return Color.fromARGB(A, R, G, B);
  }

  void _setColorAsSelected(index) {
    // setState(() {
    for (int i = 0; i < selectedColor.length; i++) {
      (i == index) ? selectedColor[i] = true : selectedColor[i] = false;
    }
    // });
  }

  _deleteNoteAndGoBack() {
    SqlDb().deleteData("DELETE FROM notes WHERE id='$id';");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (route) => false);
  }

  _dublicateNoteAndGoBack() {
    SqlDb().insertData(
        "INSERT INTO 'notes' (title, note, color)VALUES ('$title' , '$note' , '$color')");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (route) => false);
  }

  buildBody() {
    var body = ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: Container(
        height: 250,
        color: _getThemeColor(color),
        child: Column(
          children: [
            Container(
              height: 60,
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("Share with your frinds"),
                      )
                    ],
                  )),
            ),
            Container(
              height: 60,
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    (this.isNew)
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                            (route) => false)
                        : _deleteNoteAndGoBack();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("Delete"),
                      )
                    ],
                  )),
            ),
            Container(
              height: 60,
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    _dublicateNoteAndGoBack();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.copy),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text("Duplicate"),
                      )
                    ],
                  )),
            ),
            Row(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: TagColors().colors.length,
                        itemBuilder: (context, index) {
                          if (color == TagColors().getColorFromList(index)) {
                            _setColorAsSelected(index);
                          }
                          return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _setColorAsSelected(index);
                                  });
                                  color = TagColors().getColorFromList(index);
                                  widget.onChose(color);
                                },
                                child: FloatingActionButton(
                                  elevation: 10,
                                  mini: true,
                                  onPressed: () {
                                    setState(() {
                                      _setColorAsSelected(index);
                                    });
                                    color = TagColors().getColorFromList(index);
                                    widget.onChose(color);
                                  },
                                  child: selectedColor[index]
                                      ? Icon(Icons.done)
                                      : Text(""),
                                  backgroundColor:
                                      TagColors().colors.elementAt(index),
                                ),
                              )));
                        },
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );

    return body;
  }
}
