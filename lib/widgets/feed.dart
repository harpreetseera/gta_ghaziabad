import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_feed_app/model/feed_data.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FeedWidget extends StatelessWidget {
  final FeedData feedData;

  const FeedWidget({super.key, required this.feedData});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Expanded(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              var edgeInsets = const EdgeInsets.all(0);
              return InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PlaceDescriptionPage(
                        feedItem: feedData.feedList[index]))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 0.0,
                      margin: edgeInsets,
                      child: SizedBox(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height / 3,
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                          fit: BoxFit.cover,
                          cacheManager: DefaultCacheManager(),
                          imageUrl: feedData.feedList[index].image,
                        ),
                      ),
                    ),
                    const ActionsRow(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(feedData.feedList[index].placeName),
                    ),
                  ],
                ),
              );
            },
            itemCount: feedData.feedList.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 16,
              );
            },
          ),
        )
      ],
    );
  }
}

class PlaceDescriptionPage extends StatelessWidget {
  const PlaceDescriptionPage({super.key, required this.feedItem});
  final FeedItem feedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(feedItem.placeName),
      ),
      body: Text(feedItem.placeDescription),
    );
  }
}

class ActionsRow extends StatelessWidget {
  const ActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        geticonPadded(Icons.thumb_up_sharp),
        geticonPadded(Icons.share),
        geticonPadded(Icons.comment),
        const Spacer(),
        geticonPadded(Icons.save_sharp),
      ],
    );
  }

  Widget geticonPadded(IconData iconName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Icon(
        iconName,
        color: Colors.green[300],
      ),
    );
  }
}
