
import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    Key? key,
    required this.index,
    required this.storyImage,
  }):super(key:key);

  final String storyImage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
        Border.all(width: 2, style: BorderStyle.solid),
        gradient: index != 0
            ? LinearGradient(
          colors: [Colors.orange, Colors.pinkAccent],
        )
            : null,
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(storyImage),
        child: index == 0
            ? Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 16,
            ),
          ),
        )
            : SizedBox.shrink(),
      ),
    );
  }
}
