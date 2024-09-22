import 'package:flutter/material.dart';
import 'package:lingo_news/app_sizes.dart';
import 'package:lingo_news/core/theme/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          centerTitle: false,
          title: const Text(
            "MyNews",
            style: TextStyle(color: Colors.white),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.near_me_rounded,
                    color: Colors.white,
                  ),
                  gapW8,
                  Text(
                    "In",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const Text(
              "Top Headlines",
              style: TextStyle(color: Colors.black),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 6.0),
                    margin: const EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("News Source"),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text("10 min ago"),
                            ],
                          ),
                        ),
                        gapW16,
                        Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
