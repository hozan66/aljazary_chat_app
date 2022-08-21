import 'package:flutter/material.dart';

import '../../constants/default_values.dart';

AppBar chatRoomAppBar({
  required String receiver,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        const BackButton(),
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/welcome_image.png'),
        ),
        const SizedBox(width: myDefaultPadding * 0.75),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                receiver,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16.0),
              ),
              const Text(
                'Active 3m ago',
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.local_phone),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.videocam),
      ),
      const SizedBox(width: myDefaultPadding / 2),
    ],
  );
}
