import 'package:flutter/material.dart';
import './swappable.dart';

class ListViewContainer extends StatelessWidget {
  ListViewContainer({
    @required this.itemsList,
    @required this.onDragStart,
    @required this.onDragEnd,
    @required this.onDragAccept,
  });

  final List itemsList;
  final Function onDragStart;
  final Function onDragEnd;
  final Function onDragAccept;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          for (int i = 0; i < itemsList.length; i++)
            SizedBox(
              // With hardcoded height.
              height: 50,
              child: Swappable(
                itemData: itemsList[i],
                onDragStart: onDragStart,
                onDragEnd: onDragEnd,
                onDragAccept: onDragAccept,
              ),
            )
        ],
      );
    });
  }
}
