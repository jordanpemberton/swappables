import 'package:flutter/material.dart';
import './swappable.dart';

class GridViewContainer extends StatelessWidget {
  GridViewContainer({
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
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(8.0),
      physics: NeverScrollableScrollPhysics(),
      children: [
        for (int i = 0; i < itemsList.length; i++)
          Swappable(
            itemData: itemsList[i],
            onDragStart: onDragStart,
            onDragEnd: onDragEnd,
            onDragAccept: onDragAccept,
          ),
      ],
    );
  }
}
