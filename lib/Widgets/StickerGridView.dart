import 'package:flutter/material.dart';
import 'package:healing/Common/Keys.dart';

class StickerGridView extends StatelessWidget {
  List<String> images = [
    'DP_1',
    'DP_2',
    'DP_3',
    'DP_4',
    'DP_5',
    'DP_6',
    'DP_7',
    'DP_8',
    'DP_9'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
          crossAxisCount: 3,
          children: images.map((value) {
            return ElevatedButton(
                onPressed: () =>
                    {chatState.currentState?.onSendMessage(2, content: value)},
                child: Image.asset(
                  'assets/stickers/$value.png',
                  fit: BoxFit.cover,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(),
                ));
          }).toList()),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 0.5)),
      ),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }
}
