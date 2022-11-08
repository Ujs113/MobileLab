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

  Future<void> openFeed(String? url) async {
    await launchUrlString(url!);
    return;
  }

  Future<RssFeed> loadFeed() async {
    try{
      final client = http.Client();
      final response = await client.get(Uri.https(FEED_URL, 'frontpage'));

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
      debugPrint(_feed.title);
    });
  }

  @override
  void initState() {
    super.initState();
    // _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle('Exercise 6');
    load();
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty() ? const Center(child: CircularProgressIndicator()) : RefreshIndicator(key: _refreshKey, child: list(), onRefresh: load);
  }

  list() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget> [
        Expanded(
          flex: 3,
          child: ListView.builder(
            padding: EdgeInsets.all(5.0),
            itemCount: _feed.items?.length,
            itemBuilder: (BuildContext context, int index) {
              final _item = _feed.items![index];
              return Container (
                margin: EdgeInsets.only(bottom: 10.0,),
                child: ListTile(
                  title: Text(" ${_item.title}"),
                  subtitle: Text("${_item.pubDate}"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  contentPadding: EdgeInsets.all(5.0),
                  onTap: () => openFeed(_item.link)
                )
              );
            }
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
