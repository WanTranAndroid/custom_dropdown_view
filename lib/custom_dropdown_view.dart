library custom_dropdown_view;

import 'package:flutter/material.dart';

class CustomDropdownView extends StatefulWidget {
  final Widget? defaultWidget;
  final List<Widget>? listWidgetItem;
  final Function(bool isDropdownOpened)? onTapDropdown;
  final BoxDecoration? decorationDropdown;
  final double? elevationShadow;
  final bool? isNeedCloseDropdown;

  CustomDropdownView(
      {Key? key,
      @required this.defaultWidget,
      @required this.onTapDropdown,
      this.decorationDropdown,
      this.elevationShadow,
      this.isNeedCloseDropdown,
      @required this.listWidgetItem})
      : super(key: key);

  @override
  CustomDropdownViewState createState() => CustomDropdownViewState();
}

class CustomDropdownViewState extends State<CustomDropdownView> {
  double? height, width, xPosition, yPosition;
  OverlayEntry? floatingDropdown;
  bool isDropdownOpened = false;
  LabeledGlobalKey privateKey = LabeledGlobalKey("");

  void findDropdownData() {
    RenderBox? renderBox = privateKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: (yPosition ?? 0.0) + (height ?? 0),
        child: DropdownDialog(
          decorationDropdown: widget.decorationDropdown,
          elevationShadow: widget.elevationShadow,
          listWidgetItem: widget.listWidgetItem,
        ),
      );
    });
  }

  void closeDropdown() {
    try {
      floatingDropdown?.remove();
      setState(() {
        isDropdownOpened = false;
        widget.onTapDropdown!(false);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNeedCloseDropdown == true) {
      closeDropdown();
    }
    return GestureDetector(
      key: privateKey,
      onTap: () {
        if (isDropdownOpened) {
          closeDropdown();
        } else {
          setState(() {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context)?.insert(floatingDropdown!);
            isDropdownOpened = true;
            widget.onTapDropdown!(true);
          });
        }
      },
      child: widget.defaultWidget ?? Container(),
    );
  }
}

class DropdownDialog extends StatelessWidget {
  final BoxDecoration? decorationDropdown;
  final double? elevationShadow;
  final List<Widget>? listWidgetItem;

  DropdownDialog({Key? key, this.decorationDropdown, this.elevationShadow, this.listWidgetItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Material(
          elevation: elevationShadow ?? 20,
          child: Container(
            decoration: decorationDropdown ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
            child: Column(children: listWidgetItem ?? []),
          ),
        ),
      ],
    );
  }
}
