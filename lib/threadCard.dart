import 'package:flutter/material.dart';

class ThreadCard extends StatelessWidget {
  final threadData;
  ThreadCard(this.threadData);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          threadData['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "${threadData['description'].toString().substring(0, 100)}...",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Image border

                      child: Image.network(
                        threadData['imageURL'],
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      avatar: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(255, 129, 70, 70),
                      label: Text(
                        threadData['celeb'],
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ThreadList extends StatelessWidget {
  final threads;
  ThreadList(this.threads);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: threads,
      ),
    );
  }
}
