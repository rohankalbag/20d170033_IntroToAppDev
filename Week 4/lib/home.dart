import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/intro.dart';
import 'addtodos.dart';

class Todos {
  String useruid;
  String id;
  String reminder;
  String date;
  String time;
  Todos({this.useruid, this.id, this.reminder, this.date, this.time});
  Widget showTodo() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                this.reminder,
                style: TextStyle(color: Colors.grey[300], fontSize: 20),
              ),
              IconButton(
                  onPressed: () async {
                    FirebaseDatabase.instance
                        .reference()
                        .child("Users")
                        .child(this.useruid)
                        .child("Todos List")
                        .child(this.id)
                        .remove();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.grey[300],
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Time: " + this.time,
                  style: TextStyle(color: Colors.grey[300], fontSize: 15)),
              Text("Date: " + this.date,
                  style: TextStyle(color: Colors.grey[300], fontSize: 15))
            ],
          )
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({this.uid});
  final String uid;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todos> myTodoHolder = [];
  Future<List<Todos>> getTodos() async {
    final response = await FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(widget.uid)
        .child("Todos List")
        .once();
    List<Todos> myTodos = [];
    try {
      response.value.forEach((key, value) {
        Todos currTodo = Todos(
            useruid: widget.uid,
            id: key,
            reminder: value["reminder"],
            date: value["date"],
            time: value["time"]);
        myTodos.add(currTodo);
      });
    } catch (e) {
      return myTodos;
    }
    return myTodos;
  }

  Future reflectChanges() async {
    myTodoHolder = await getTodos();
    setState(() {});
  }

  final String title = "Home";

  @override
  void initState() {
    super.initState();
    reflectChanges();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EnterTodo(uid: widget.uid)));
          },
        ),
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                      (Route<dynamic> route) => false);
                });
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Tip: Click on refresh button to reflect the changes",
                    style: TextStyle(
                        color: Colors.grey[300], fontStyle: FontStyle.italic)),
                IconButton(
                    onPressed: reflectChanges,
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 25,
                    ))
              ],
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: myTodoHolder.length,
                itemBuilder: (BuildContext context, int index) {
                  return myTodoHolder[index].showTodo();
                })
          ],
        ),
        drawer: NavigateDrawer(uid: this.widget.uid));
  }
}

class NavigateDrawer extends StatefulWidget {
  final String uid;
  NavigateDrawer({Key key, this.uid}) : super(key: key);
  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.value['email']);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            accountName: FutureBuilder(
                future: FirebaseDatabase.instance
                    .reference()
                    .child("Users")
                    .child(widget.uid)
                    .once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.value['name']);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.home, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(uid: widget.uid)),
              );
            },
          ),
        ],
      ),
    );
  }
}
