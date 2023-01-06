
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'blog_cell_widget.dart';
import 'blog_details_screen.dart';

class Post {
  final String title;
  final String image;
  final String author;
  final String date;

  Post({required this.title, required this.image, required this.author, required this.date});
}

class BlogWishlistHomeScreen extends StatelessWidget with WidgetsBindingObserver {
  final data = [
    Post(
      image: "images/logo.png",
      title: 'What is Abacus and how does an Abacus work?',
      author: 'IDEAL PLAY ABACUS INDIA',
      date: '25 Mar 2020',
    ),
    Post(
      image: "images/logo.png",
      title: 'Abacus Training For The Love of Math',
      author: 'IDEAL PLAY ABACUS INDIA',
      date: '24 Mar 2020',
    ),

  ];



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));
      // user returned to our app
    } else if (state == AppLifecycleState.inactive) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark));
      // user is about quit our app temporally
    }
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));


    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              'images/back.png',
              width: 14,
              height: 14,
              color: Colors.black,
              //fit: BoxFit.fill,
            ),
          ),

        ),

        title: const Text(
          'Bookmark Blogs',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF6410),
        elevation: 0,
        onPressed: () {},
        child: Image.asset(
          'images/heart_image.png',
          width: 24,
          height: 24,
          color: Colors.white,
          // fit: BoxFit.fill,
        ),
      ),

      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search here...',
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'Abacus latest blogs',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final post = data[index];
                    return PostCellWidget(
                        title: post.title,
                        image: post.image,
                        author: post.author,
                        date: post.date,
                        onClick: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PostDetailsPage(
                                title: post.title,
                                image: post.image,
                                author: post.author,
                                date: post.date,
                              ),
                            ),
                          );
                        });
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
                const SizedBox(
                  height: 20,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
