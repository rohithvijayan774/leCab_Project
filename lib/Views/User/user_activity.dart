import 'package:flutter/material.dart';
import 'package:lecab/provider/User/user_details_provider.dart';
import 'package:lecab/widget/User/Bottom%20Bar/user_activity_bar.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserActivity extends StatelessWidget {
  DateTime? dateTime;
  UserActivity({this.dateTime, super.key});

  @override
  Widget build(BuildContext context) {
    // final userDetailsPro =
    //     Provider.of<UserDetailsProvider>(context, listen: false);
    // List<String> dropOff = [
    //   "HiLite Mall",
    //   "Railwaystation 4th Platform Road",
    //   "SM Street, Palayam, Kozhikode, Kerala",
    //   "Cyberpark Kozhikode"
    // ];
    // dateTime = DateTime.now();
    // String date = DateFormat('dd MMM').format(dateTime!);
    // String time = DateFormat('h:mm a').format(dateTime!).toLowerCase();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(
            left: 20,
            top: 20,
          ),
          child: Text(
            'Activity',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Consumer<UserDetailsProvider>(builder: (context, value, _) {
        return value.userModel.dropOffPlaceNameList.isEmpty
            ? const Center(
                child: Text('No Activity'),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return UserActivityBar(
                    bookedDate: 'value.',
                    bookedTime: 'value.',
                    dropOffLoc: value.userModel.dropOffPlaceNameList[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.grey.shade300,
                    endIndent: 25,
                    indent: 25,
                  );
                },
                itemCount: value.userModel.dropOffPlaceNameList.length);
      }),
    );
  }
}
