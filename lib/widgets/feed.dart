import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_feed_app/model/feed_data.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:insta_feed_app/screen/place_description_page.dart';

class FeedWidget extends StatelessWidget {
  final FeedData feedData;

  const FeedWidget({super.key, required this.feedData});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                var edgeInsets =
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 0);
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlaceDescriptionPage(
                        feedItem: feedData.feedList[index],
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 0.0,
                        margin: edgeInsets,
                        child: SizedBox(
                          width:
                              // constraints.maxWidth > 600
                              //     ? MediaQuery.of(context).size.height / 2
                              //     :
                              double.maxFinite,
                          height: MediaQuery.of(context).size.height / 3,
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
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
                      SizedBox(
                        width:
                            //  constraints.maxWidth > 600
                            //     ? MediaQuery.of(context).size.height / 2
                            //     :
                            double.maxFinite,
                        child: const ActionsRow(),
                      ),
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
      ),
    );
  }
}

class ActionsRow extends StatelessWidget {
  const ActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        geticonPadded(Icons.thumb_up_sharp, context),
        geticonPadded(Icons.share, context),
        geticonPadded(Icons.comment, context),
        const Spacer(),
        geticonPadded(Icons.arrow_forward, context),
      ],
    );
  }

  Widget geticonPadded(IconData iconName, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Icon(
        iconName,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
