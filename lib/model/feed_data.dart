import 'dart:convert';

FeedData feedDataFromJson(String str) => FeedData.fromJson(json.decode(str));

String feedDataToJson(FeedData data) => json.encode(data.toJson());

class FeedData {
  FeedData({
    required this.feedList,
  });

  List<FeedItem> feedList;

  factory FeedData.fromJson(Map<String, dynamic> json) => FeedData(
        feedList: List<FeedItem>.from(
            json["feed_list"].map((x) => FeedItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "feed_list": List<dynamic>.from(feedList.map((x) => x.toJson())),
      };
}

class FeedItem {
  FeedItem({
    required this.image,
    required this.placeName,
    required this.placeDescription,
  });

  String image;
  String placeName;
  String placeDescription;

  factory FeedItem.fromJson(Map<String, dynamic> json) => FeedItem(
        image: json["image"],
        placeName: json["place_name"],
        placeDescription: json["place_description"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "place_name": placeName,
        "place_description": placeDescription
      };
}
