import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

class Swappable extends StatelessWidget {
  Swappable({
    @required this.itemData,
    @required this.onDragStart,
    @required this.onDragEnd,
    @required this.onDragAccept,
  });

  final Map itemData;
  final Function onDragStart;
  final Function onDragEnd;
  final Function onDragAccept;

  @override
  Widget build(BuildContext context) {
    return
      // If item is marked 'drag', return a Draggable Widget,
      // else if marked 'target', return a DragTarget Widget,
      // else return empty Container Widget.
      LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return itemData['drag'] == 'drag'
            ?
            // LayoutBuilder allows the feedback size to match the child size.
            Draggable<String>(
                maxSimultaneousDrags: 1,
                data: itemData['key'],
                child: Container(
                  color: Color(itemData['color']),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      itemData['value'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Wrapping in Material Widget allows text formatting.
                feedback: Material(
                  child: Container(
                    // Height, width determined with LayoutBuilder constraints.
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    color: Color(itemData['color']),
                    // Wrapping with Align aligns Text Widget.
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        itemData['value'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                // childWhenDragging set to grey here, can be set to whatever color you prefer.
                childWhenDragging: Container(
                  color: Colors.grey,
                ),
                dragAnchor: DragAnchor.child,
                onDragStarted: () {
                  onDragStart(int.parse(itemData['key']));
                },
                onDragEnd: (DraggableDetails data) {
                  onDragEnd(data);
                },
              )
            : itemData['drag'] == 'target'
                ? DragTarget<String>(
                    builder: (BuildContext context, List<String> candidateData,
                        List rejectedData) {
                      return Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        color: Color(itemData['color']),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            itemData['value'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                    onWillAccept: (String data) {
                      return true;
                    },
                    onAccept: (String data) {
                      return onDragAccept(
                        int.parse(data),
                        int.parse(itemData['key']),
                      );
                    },
                  )
                : Container();
      },
    );
  }
}
