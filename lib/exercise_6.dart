import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Exercise6 extends StatefulWidget {
  const Exercise6({Key? key}) : super(key: key);

  @override
  State<Exercise6> createState() => _Exercise6State();
}

class _Exercise6State extends State<Exercise6> {
  final GlobalKey _refreshKey = GlobalKey<RefreshIndicatorState>();
  static const String FEED_URL = 'hnrss.org';

  RssFeed _feed = RssFeed();
  String _title = 'Exercise 4';

  static const String loadingMessage = 'Loading Feed...';
  static const String feedLoadErrorMessage = 'Error Loading Feed.';
  static const String feedOpenErrorMessage = 'Error Opening Feed.';

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if(await canLaunchUrlString(url)) {
      await launchUrlString(url);
      return;
    }
    updateTitle(feedOpenErrorMessage);
  }

  Future<RssFeed> loadFeed() async {
    try{
      final client = http.Client();
      final response = await client.get(Uri.https(FEED_URL, 'jobs'));
      return RssFeed.parse(response.body);
    } catch (e) {
      // updateTitle(feedLoadErrorMessage);
      debugPrint(e.toString());
    }
    return RssFeed();
  }

  Future<void> load() async {
    updateTitle(loadingMessage);
    loadFeed().then((result) {
      if(null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMessage);
        return;
      }
      updateFeed(result);
      updateTitle("Hacker News RSS Feed");
    });
  }

  @override
  void initState() {
    super.initState();
    // _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle('Exercise 4');
    load();
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty() ? const Center(child: CircularProgressIndicator()) : RefreshIndicator(key: _refreshKey, child: list(), onRefresh: load());
  }

  list() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget> [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(left: 5.0, right: 5.0),
            // decoration:
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Link: ${_feed.link}",
                ),
                Text(
                  "Description: ${_feed.description}",
                ),
                Text(
                  "Docs: ${_feed.docs}",
                ),
                Text(
                  "Last Build Date: ${_feed.lastBuildDate}",
                ),
              ],
            ),
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: body(),
    ));
  }
}
