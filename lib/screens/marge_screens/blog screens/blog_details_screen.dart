import 'package:flutter/material.dart';

class PostDetailsPage extends StatelessWidget {
  final String title;
  final String image;
  final String author;
  final String date;
  const PostDetailsPage(
      {super.key, required this.title,
      required this.image,
      required this.author,
      required this.date});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey[200],
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite_outline,
                    size: 20,
                  ),
                  color: Colors.black,
                  onPressed: () {},
                ),
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(8),
          //     child: Container(
          //       color: Colors.grey[200],
          //       child: IconButton(
          //         icon: const Icon(
          //           Icons.share_outlined,
          //           size: 20,
          //         ),
          //         color: Colors.grey,
          //         onPressed: () {},
          //       ),
          //     ),
          //   ),
          // ),

        ],
      ),

      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: ListView(
            children: [

              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 16,
              ),

              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('$author, '),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),

             /* Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: const [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.black45,
                        size: 18,
                      ),
                      Text(
                        '6.5K Views',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Colors.black45,
                        size: 18,
                      ),
                      Text(
                        '106 Likes',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: const [
                      Icon(
                        Icons.bookmark,
                        color: Colors.black45,
                        size: 18,
                      ),
                      Text(
                        '55 Saves',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),*/

              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(image),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'L',
                      style: TextStyle(color: Colors.black, fontSize: 32),),

                    TextSpan(
                      text:
                          'orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        height: 1.7,
                        wordSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
