import 'package:flutter/material.dart';

class AnnouncementDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const AnnouncementDetailPage({
    super.key,
    required this.data,
  });

  String formatDate(dynamic timestamp) {
    if (timestamp == null) {
      return "No date";
    }

    DateTime date = timestamp.toDate();
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    final title = data['title'] ?? "No Title";
    final description = data['description'] ?? "No Description";
    final postedBy = data['postedBy'] ?? "Unknown";
    final date = formatDate(data['date']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcement Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 35),
              decoration: const BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.campaign,
                    size: 65,
                    color: Colors.white,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Announcement Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Posted By: $postedBy",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Date: $date",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 35),

                      const Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 17,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}