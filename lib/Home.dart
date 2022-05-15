// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lap_project/edit_note.dart';
import 'package:lap_project/module/TagColors.dart';
import 'package:lap_project/new_note.dart';
import 'package:lap_project/sqfDB.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var numOfNotes = 1;
  SqlDb db = SqlDb();

  Future<List<Map>> _getNotes() async {
    List<Map> result = await db.readData("SELECT * FROM notes");
    return result;
  }

  NewNote newNote = new NewNote();

  noNotes() {
    return Column(children: [
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
    ]);
  }

  displayNotes(String title, String note, dynamic color, int id) {
    //this method draw the shape of on note and fill data to get nice view

    List<int> RGB = TagColors().getColorAsARGB(color);
    int A = RGB[0];
    int R = RGB[1];
    int G = RGB[2];
    int B = RGB[3];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Card(
          child: Row(
            children: [
              Container(
                color: Color.fromARGB(255, R, G, B),
                width: 5,
                height: 100,
              ),
              TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditNote(
                                title: title,
                                note: note,
                                color: color,
                                id: id,
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
          title: Text("Note App"),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 15, top: 25, right: 15),
            child: SingleChildScrollView(
              child: FutureBuilder(
                //her we get the notes from local storage 'sqfLite'
                future: _getNotes(),
                builder: ((context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print(numOfNotes);
                        //her the system check if we have no notes, the image and text about no notes will display , else system display notes
                        return numOfNotes == 0
                            ? noNotes()
                            : displayNotes(
                                snapshot.data![index]['title'].toString(),
                                snapshot.data![index]['note'].toString(),
                                snapshot.data![index]['color'].toString(),
                                snapshot.data![index]['id']);
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
              ),
            )),
        floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            onPressed: () async {
              // db.deleteDatabaseFromDvice();
              // on press the '+' button will go to new page to add new note
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewNote()));
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
