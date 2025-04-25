import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:school_app/app/appConstants.dart';
import 'package:school_app/app/route_extensions.dart';
import 'package:school_app/app/size_extensions.dart';
import 'package:school_app/providers/home_provider.dart';
import 'package:school_app/screens/downloadedAssetsScreen.dart';
import 'package:school_app/widgets/CustomDrawer.dart';

class DownloadedSubjects extends StatefulWidget {
  const DownloadedSubjects({super.key});

  @override
  State<DownloadedSubjects> createState() => _DownloadedSubjectsState();

}



class _DownloadedSubjectsState extends State<DownloadedSubjects> {

@override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    loadMedia();


  }

  void loadMedia (){
    final homeProvider = context.read<HomeProvider>();
    homeProvider.loadMedia();
    homeProvider.getAllSubjects();


  }
  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      endDrawer: MyCustomDrawer(),
      appBar: AppBar(title: Text(Appconsts.schoolName)),
      body: Column(
        children: [
          Center(
            child: Text(
              "Downloaded Subjects",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            ),
          ),
          SizedBox(height: 30,),
          Expanded(
            child: 
             homeProvider.subjects.isEmpty ? Column(
                            children: [
                              SizedBox(height: context.h * 0.05),
                              Image.asset(
                                "assets/empty.png",
                                height: 120,
                                width: context.w * 0.6,
                              ),
                              const SizedBox(height: 10),
                              Text("No Subjects Found " , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)
                             ]) :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GridView.builder(
                itemCount: homeProvider.subjects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // Width / Height ratio
                ),
                itemBuilder: (context, index) {
                  String subject =  homeProvider.subjects[index];
                  return CourseContainers(
                    subjectName: subject,
                    onTap: () {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseContainers extends StatelessWidget {
  final VoidCallback onTap;
  final String subjectName;
  const CourseContainers({super.key, required this.onTap, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: context.w * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: context.h*0.12,
              child: ClipRRect(
              
                borderRadius: BorderRadius.circular(
                  8,
                ),
                child: Image.asset(
                  
                  "assets/blacboardpng.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(subjectName,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 13),),
            ),
            Divider(thickness: 0.5,)
          ],
        ),
      ),
    );
  }
}
