import 'package:flutter/material.dart';
import 'package:flutter_sample_app/models/Task.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Challenge UI',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _imageHeight = 256.0;
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  ListModel listModel;
  bool showOnlyCompleted = false;

  List<Task> tasks = [
    new Task(
        name: "Catch up with Brian",
        category: "Mobile Project",
        time: "5pm",
        color: Colors.orange,
        completed: false),
    new Task(
        name: "Make new icons",
        category: "Web App",
        time: "3pm",
        color: Colors.cyan,
        completed: true),
    new Task(
        name: "Design explorations",
        category: "Company Website",
        time: "2pm",
        color: Colors.pink,
        completed: false),
    new Task(
        name: "Lunch with Mary",
        category: "Grill House",
        time: "12pm",
        color: Colors.blue,
        completed: true),
    new Task(
        name: "Teem Meeting",
        category: "Hangouts",
        time: "10am",
        color: Colors.green,
        completed: true),
  ];

  @override
  void initState() {
    super.initState();
    listModel = new ListModel(_listKey, tasks);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          _buildIamge(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildIamge() {
    return new ClipPath(
      clipper: new DialogonalClipper(),
      child: new Image.asset(
        'birds.jpeg',
        fit: BoxFit.fitHeight,
        height: _imageHeight,
        colorBlendMode: BlendMode.srcOver,
        color: new Color.fromARGB(120, 20, 10, 40),
      ),
    );
  }

  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: new Row(
        children: <Widget>[
          new Icon(Icons.menu, size: 32.0, color: Colors.white),
          new Expanded(
              child: new Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: new Text(
              'TimeLine',
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          )),
          new Icon(Icons.linear_scale, size: 32.0, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return new Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 256.0 / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            //minRadius: 28.0,
            //maxRadius: 28.0,
            backgroundImage: new AssetImage('user.png'),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  'Satya Kethu',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                new Text(
                  'Software Engineer',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTasksHeader(),
          _buildTasksList(),
        ],
      ),
    );
  }

  Widget _buildTasksList() {
    return new Expanded(
        child: new AnimatedList(
      initialItemCount: tasks.length,
      key: _listKey,
      itemBuilder: (context, index, animation) {
        return new TaskRow(
          task: listModel[index],
        );
      },
    )
        /*new ListView(
            children: tasks
                .map((tasks) => new TaskRow(
                      task: tasks,
                    ))
                .toList()
        )*/
        );
  }

  Widget _buildMyTasksHeader() {
    return new Padding(
        padding: const EdgeInsets.only(left: 64.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'My Tasks',
              style: new TextStyle(
                fontSize: 34.0,
              ),
            ),
            new Text(
              'FEBRUARY 8, 2015',
              style: new TextStyle(color: Colors.grey, fontSize: 12.0),
            )
          ],
        ));
  }

  Widget _buildFab() {
    return new Positioned(
        top: _imageHeight - 36.0,
        right: 16.0,
        child: new FloatingActionButton(
          onPressed: _changeFilterState,
          backgroundColor: Colors.pink,
          child: new Icon(Icons.filter_list),
        ));
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 60.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TaskRow extends StatefulWidget {
  final Task task;
  final double dotSize = 12.0;

  const TaskRow({Key key, this.task}) : super(key: key);

  @override
  _TaskRowState createState() => new _TaskRowState();
}

class _TaskRowState extends State<TaskRow> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding:
                new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle, color: widget.task.color),
            ),
          ),
          new Expanded(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                widget.task.name,
                style: new TextStyle(fontSize: 18.0),
              ),
              new Text(
                widget.task.category,
                style: new TextStyle(fontSize: 12.0, color: Colors.grey),
              )
            ],
          )),
          new Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: new Text(
              widget.task.time,
              style: new TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class ListModel {
  ListModel(this.listKey, items) : this.items = new List.from(items);

  final GlobalKey<AnimatedListState> listKey;
  final List<Task> items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, Task item) {
    items.insert(index, item);
    _animatedList.insertItem(index);
  }

  Task removeAt(int index) {
    final Task removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (context, animation) => new Container(),
      );
    }
    return removedItem;
  }

  int get length => items.length;

  Task operator [](int index) => items[index];

  int indexOf(Task item) => items.indexOf(item);
}
