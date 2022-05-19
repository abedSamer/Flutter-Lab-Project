// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lap_project/module/TagColors.dart';
import 'package:lap_project/new_note.dart';
import 'package:lap_project/sqfDB.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var numOfNotes = 0;
  SqlDb db = SqlDb();

  Future<List<Map>> _getNotes() async {
    List<Map> result = await db.readData("SELECT * FROM notes");
    numOfNotes = result.length;
    return result;
  }

  Widget noNotes() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height - 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/imgs/Empty1.jpeg"),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "No Notes :(",
                style: TextStyle(
                    color: Colors.purple[900],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("You have no task to do .",
                  style: TextStyle(
                    color: Colors.blueGrey[300],
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  displayNotes(String title, String note, dynamic color, int id) {
    //this method draw the shape of on note and fill data to get nice view

    List<int> RGB = TagColors().getColorAsARGB(color);
    int A = RGB[0];
    int R = RGB[1];
    int G = RGB[2];
    int B = RGB[3];

    return Card(
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: Color.fromARGB(255, R, G, B), width: 6))),
          child: Row(
            children: [
              TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewNote(
                                title: title,
                                note: note,
                                color: color,
                                id: id,
                                isNew: false,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width - 60,
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 30,
                        child: Text(
                          "$title",
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 20,
                        child: Text("$note",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Note App "),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, top: 25, right: 15),
          child: FutureBuilder(
            //her we get the notes from local storage 'sqfLite'
            future: _getNotes(),
            builder: ((context, AsyncSnapshot<List<Map>> snapshot) {
              if (snapshot.hasData && snapshot.data!.length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    //her the system check if we have no notes, the image and text about no notes will display , else system display notes

                    return Dismissible(
                        key: ObjectKey(snapshot.data![index]),
                        background: ClipPath(
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                              child: Icon(Icons.delete, color: Colors.white),
                            )),
                        // secondaryBackground: ClipPath(
                        //     clipper: ShapeBorderClipper(
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(8))),
                        //     child: Container(
                        //       alignment: Alignment.centerRight,
                        //       color: Colors.green,
                        //       child: Icon(Icons.copy, color: Colors.white),
                        //     )),
                        onDismissed: (direction) {
                          var itemTitle = snapshot.data![index]['title'];
                          var itemID = snapshot.data![index]['id'];
                          var itemColor = snapshot.data![index]['color'];
                          var itemNote = snapshot.data![index]['note'];
                          // if (direction == DismissDirection.startToEnd) {
                          SqlDb().deleteData(
                              "DELETE FROM notes WHERE id='$itemID';");
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${itemTitle} Deleted')));
                          // } else if (direction == DismissDirection.endToStart) {
                          //   setState(() {
                          //     snapshot.data!.add(snapshot.data![index]);
                          //   });
                          //   SqlDb().insertData(
                          //       "INSERT INTO 'notes' (title, note, color)VALUES ('${itemTitle}' , '${itemNote}' , '$itemColor') ");
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       content: Text('${itemTitle} Duoblecated')));
                          // }
                        },
                        child: displayNotes(
                            snapshot.data![index]['title'].toString(),
                            snapshot.data![index]['note'].toString(),
                            snapshot.data![index]['color'].toString(),
                            snapshot.data![index]['id']));
                  },
                );
              } else if (snapshot.data != null && snapshot.data!.isEmpty) {
                return noNotes();
              }
              return Center(child: CircularProgressIndicator());
            }),
          ),
        ),
        floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: () async {
              // db.deleteDatabaseFromDvice();
              // on press the '+' button will go to new page to add new note
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewNote(
                            title: "",
                            note: "",
                            color: "FF03A9F4",
                            isNew: true,
                          )));
            },
            child: Ink(
              child: Icon(
                Icons.add,
                size: 50,
              ),
              //in this section we use BoxDecoration to get LinearGradient
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(250),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Colors.blue, Colors.purple]),
              ),
            )));
  }
}
