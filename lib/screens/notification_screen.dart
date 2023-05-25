import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // int even = 2;
    // even++;
    // int odd = 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Notifications'),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 22),
        itemCount: 20,
        itemBuilder: (context, index) {
          if (index % 2 == 0) {
            return ListTile(
              leading: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    "https://plus.unsplash.com/premium_photo-1683935023655-3827e4274749?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60"),
              ),
              title: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'fareed23',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: ' liked your post',
                          style: TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              ),
              trailing: const Image(
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1661956602139-ec64991b8b16?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxMXx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60"),
              ),
            );
          } else {
            return ListTile(
              leading: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1617611413968-537a2ba4986d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bmlrZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60"),
              ),
              title: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: 'nike',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: ' liked your story',
                          style: TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              ),
              trailing: const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    "https://plus.unsplash.com/premium_photo-1683886831980-de8f169418fd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOHx8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60"),
              ),
            );
          }
        },
      ),
    );
  }
}
