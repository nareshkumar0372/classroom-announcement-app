import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAnnouncementPage extends StatefulWidget {
  const AddAnnouncementPage({super.key});

  @override
  State<AddAnnouncementPage> createState() => _AddAnnouncementPageState();
}

class _AddAnnouncementPageState extends State<AddAnnouncementPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isPosting = false;

  Future<void> postAnnouncement() async {
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() {
      isPosting = true;
    });

    await FirebaseFirestore.instance.collection('announcements').add({
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'postedBy': FirebaseAuth.instance.currentUser?.email,
      'date': Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Announcement posted successfully")),
    );

    setState(() {
      isPosting = false;
    });

    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teacherEmail = FirebaseAuth.instance.currentUser?.email ?? "Teacher";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Announcement"),
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
              child: Column(
                children: [
                  const Icon(
                    Icons.campaign,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Create Announcement",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Posting as $teacherEmail",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

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
                      const Text(
                        "Announcement Details",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),

                      const SizedBox(height: 25),

                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.title),
                          labelText: "Announcement Title",
                          hintText: "Example: Exam on Monday",
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: descriptionController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.description),
                          labelText: "Description",
                          hintText: "Enter full announcement details",
                          alignLabelWithHint: true,
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: isPosting ? null : postAnnouncement,
                          icon: isPosting
                              ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : const Icon(Icons.send),
                          label: Text(
                            isPosting ? "Posting..." : "Post Announcement",
                          ),
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