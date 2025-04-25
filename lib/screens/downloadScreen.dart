import 'package:flutter/material.dart';
import 'package:school_app/app/appConstants.dart';
import 'package:school_app/app/size_extensions.dart';
import 'package:school_app/models/content_response.dart';
import 'package:school_app/services/audioPlayerServices.dart';
import 'package:school_app/widgets/CustomDrawer.dart';

class DownloadScreen extends StatefulWidget {
    final String subject;
  final List<AudioFile> audios;
  final List<PdfFile> pdfs;
  final List<VideoFile> videos;

  const DownloadScreen({super.key, required this.subject, required this.audios, required this.pdfs, required this.videos});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MyCustomDrawer(),
      appBar: AppBar(title: Text(Appconsts.schoolName)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Download Screen",style: TextStyle(fontSize: 30),)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Headers(leading: "Introduction"),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return CustomListTiles(
                    duration: 2.25,
                    index: index + 1,
                    name: "Introduction",
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Headers(leading: "Chapitre 1 : Lecture expliquee"),
              ),
              ...List.generate(
                7,
                (index) => CustomListTiles(
                  duration: 2.25,
                  index: index + 1,
                  name: "Introduction",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Headers(
                  leading: "Chapitre 2 : Les rivalites colonialies",
                ),
              ),
              ...List.generate(
                5,
                (index) => CustomListTiles(
                  duration: 2.25,
                  index: index + 1,
                  name: "Introduction",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Headers extends StatelessWidget {
  final String leading;
  const Headers({super.key, required this.leading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              leading,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.picture_as_pdf, size: 30),
            ),
          ],
        ),
        Divider(color: Colors.black, height: 10, thickness: 3),
        SizedBox(height: context.h * 0.02),
      ],
    );
  }
}

class CustomListTiles extends StatefulWidget {
  final int index;
  final String name;
  final double duration;

  CustomListTiles({
    super.key,
    required this.index,
    required this.name,
    required this.duration,
  });

  @override
  State<CustomListTiles> createState() => _CustomListTilesState();
}

class _CustomListTilesState extends State<CustomListTiles> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Audioplayerservices.showAudioPlayer(
          context,
          " https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3".trim(),
        );
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 5),
              Text(
                "${widget.index.toString()}. ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                widget.name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                widget.duration.toString(),
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.download_sharp, size: 25),
              ),
            ],
          ),
          Divider(color: Colors.black, thickness: 0.5, height: 10),
        ],
      ),
    );
  }
}
