import 'package:flutter/material.dart';
import './grid_view_container.dart';
import './list_view_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swappables',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Swappable List View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map _itemsMap = {
    0: {
      'drag': 'drag',
      'color': 0xFF7766FF,
      'value': 'Item A',
    },
    1: {
      'drag': 'drag',
      'color': 0xFFEE6622,
      'value': 'Item B',
    },
    2: {
      'drag': 'drag',
      'color': 0xFF1188EE,
      'value': 'Item C',
    },
    3: {
      'drag': 'drag',
      'color': 0xFF44AA99,
      'value': 'Item D',
    },
    4: {
      'drag': 'drag',
      'color': 0xFFCC44EE,
      'value': 'Item E',
    },
    5: {
      'drag': 'drag',
      'color': 0xFFFF9900,
      'value': 'Item F',
    },
    6: {
      'drag': 'drag',
      'color': 0xFFFF3355,
      'value': 'Item G',
    },
    7: {
      'drag': 'drag',
      'color': 0xFF229955,
      'value': 'Item H',
    },
    8: {
      'drag': 'drag',
      'color': 0xFFEE1188,
      'value': 'Item I',
    },
  };

  List _itemsList = [];

  List _makeItemsList(Map itemsMap) {
    // Make an ordered List of the Items in _itemsMap
    // by mapping the item keys to a List, sorting this list,
    // then replacing each list itme with the key's matching value in itemsMap,
    // and adding a key attribute to each entry.
    // (Sorting works if all original keys are all nums or all strings)

    List itemsList = _itemsMap.keys.toList()..sort();

    for (int i = 0; i < itemsList.length; i++) {
      int key = itemsList[i];
      itemsList[i] = _itemsMap[key];
      itemsList[i]['key'] = key.toString();
    }

    return itemsList;
  }

  void _onDragStart(int key) {
    // Once Dragging initiated, set every other
    // item to be a DragTarget widget.
    setState(() {
      _itemsMap.forEach((k, v) {
        if (k != key) {
          _itemsMap[k]['drag'] = 'target';
        }
      });
    });
  }

  void _onDragEnd(DraggableDetails data) {
    // Once Dragging is ended, set every item
    // to be a Draggable widget.
    setState(() {
      _itemsMap.forEach((k, v) {
        _itemsMap[k]['drag'] = 'drag';
      });
    });
  }

  void _onDragAccept(int keyA, int keyB) {
    // If Drag is Accepted, swap the two items.
    // (Swap the values of the two keys.)
    
    setState(() {
      Map tempItem = _itemsMap[keyA];
      _itemsMap[keyA] = _itemsMap[keyB];
      _itemsMap[keyB] = tempItem;
    
      _itemsList = _makeItemsList(_itemsMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    _itemsList = _makeItemsList(_itemsMap);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      // Works with either GridView or ListView (or other):
      GridViewContainer(
      // ListViewContainer(
        itemsList: _itemsList,
        onDragStart: _onDragStart,
        onDragEnd: _onDragEnd,
        onDragAccept: _onDragAccept,
      ),
    );
  }
}
