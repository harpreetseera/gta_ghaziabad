import 'package:flutter/material.dart';
import 'package:insta_feed_app/model/feed_data.dart';

class PlaceDescriptionPage extends StatelessWidget {
  const PlaceDescriptionPage({super.key, required this.feedItem});
  final FeedItem feedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(feedItem.placeName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(feedItem.placeDescription),
        ),
      ),
    );
  }
}
