# Swappable

A "Swappable" list/grid view class for Flutter, using Draggable and DragTarget Widgets, inspired by the ReorderableListView class.

* All list items are Draggable Widgets.
* Upon drag start, every other non-dragging list item becomes a DragTarget Widget.
* On drag end, all list items return to being Draggable Widgets.
* A successful accepted drag results in the two items swapping places in the list.