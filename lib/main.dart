import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insta_feed_app/model/feed_data.dart';
import 'package:universal_io/io.dart' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:insta_feed_app/widgets/error.dart';
import 'package:insta_feed_app/widgets/feed.dart';
import 'package:insta_feed_app/widgets/loader.dart';

void main() {
  runApp(const MyApp());
}

enum Status {
  loading,
  error,
  success,
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData get getThemeDataBasedOnPlatform {
    late MaterialColor mainColor;
    if (kIsWeb) {
      mainColor = Colors.purple;
    } else if (Platform.isAndroid) {
      mainColor = Colors.teal;
    } else if (Platform.isIOS) {
      mainColor = Colors.lightGreen;
    } else if (Platform.isMacOS) {
      mainColor = Colors.amber;
    } else if (Platform.isWindows) {
      mainColor = Colors.blueGrey;
    } else {
      mainColor = Colors.blue;
    }
    return ThemeData(primarySwatch: mainColor);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GTA Ghaziabad Demo',
      theme:

          /// Changes color based on platform
          // getThemeDataBasedOnPlatform
          ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GTA Ghaziabad'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Status? currentStatus;
  FeedData? feedData;

  Widget get getStateBasedUI {
    switch (currentStatus) {
      case Status.loading:
        return const LoaderWidget();
      case Status.error:
        return const ErrorOccuredWidget();
      case Status.success:
        return FeedWidget(feedData: feedData!);
      default:
        return const Offstage();
    }
  }

  @override
  void initState() {
    currentStatus = Status.loading;
    makeApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    double groupAligment = -1.0;
    NavigationRailLabelType labelType = NavigationRailLabelType.all;

    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar:
            //  constraints.maxWidth < 600?
            AppBar(
          elevation: 0.0,
          title: Text(widget.title),
        )
        // : null
        ,
        bottomNavigationBar:
            // constraints.maxWidth < 600?
            BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: "More"),
        ])
        // : null
        ,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // if (constraints.maxWidth > 600)
            // ...[
            //   NavigationRail(
            //     selectedIndex: selectedIndex,
            //     groupAlignment: groupAligment,
            //     onDestinationSelected: (int index) {
            //       setState(() {
            //         selectedIndex = index;
            //       });
            //     },
            //     labelType: labelType,
            //     destinations: const <NavigationRailDestination>[
            //       NavigationRailDestination(
            //         icon: Icon(Icons.favorite_border),
            //         selectedIcon: Icon(Icons.favorite),
            //         label: Text('First'),
            //       ),
            //       NavigationRailDestination(
            //         icon: Icon(Icons.bookmark_border),
            //         selectedIcon: Icon(Icons.book),
            //         label: Text('Second'),
            //       ),
            //       NavigationRailDestination(
            //         icon: Icon(Icons.star_border),
            //         selectedIcon: Icon(Icons.star),
            //         label: Text('Third'),
            //       ),
            //     ],
            //   ),
            //   const VerticalDivider(thickness: 1, width: 1),
            // ],
            Expanded(child: getStateBasedUI),
          ],
        ),
      ),
    );
  }

  void makeApiCall() async {
    const String apiAuthority = "run.mocky.io";
    const String path = "/v3/bb02b2bc-dfbf-4144-98a5-f1b1e8bf6b4b";

    try {
      final result = await http.get(
        Uri.https(
          apiAuthority,
          path,
        ),
      );
      feedData = FeedData.fromJson(json.decode(result.body));
      currentStatus = Status.success;
    } catch (e) {
      currentStatus = Status.error;
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }
}
