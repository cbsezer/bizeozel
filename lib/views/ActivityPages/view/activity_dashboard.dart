import 'package:bizeozel/core/components/colors/colors.dart';
import 'package:bizeozel/core/components/widgets/widgets.dart';
import 'package:bizeozel/views/ActivityPages/view-model/activity_view_model.dart';
import 'package:bizeozel/views/ActivityPages/view/activity_share.dart';
import 'package:bizeozel/views/ActivityPages/view/activity_details.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AcitivityDashboard extends StatefulWidget {
  @override
  _AcitivityDashboardState createState() => _AcitivityDashboardState();
}

Post post = Post();

class _AcitivityDashboardState extends State<AcitivityDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customAppBarArea(
            context,
            customAppBarBody(context, ActivityShare(), 'location.png',
                "Don't miss BizeOzel Events!", null, 0.06, false),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: context.height * 0.18,
              left: context.height * 0.04,
            ),
            child: activitiesBody(context),
          ),
        ],
      ),
    );
  }

  Container activitiesBody(BuildContext context) {
    return Container(
      width: context.width * 0.9,
      height: context.height,
      child: FutureBuilder(
        future: post.getAllPost(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return listView(snapshot);
          } else {
            return loadingAnimation();
          }
        },
      ),
    );
  }

  ListView listView(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return postCard(context, snapshot, index);
      },
    );
  }

  InkWell postCard(BuildContext context, AsyncSnapshot snapshot, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AcitivityDetails(snapshot.data[index])));
      },
      child: Column(
        children: [
          postCardBodyArea(context, snapshot, index, 0.22,
              postCardBodyContent(context, snapshot, index)),
          context.emptySizedHeightBoxLow,
        ],
      ),
    );
  }

  Column postCardBodyContent(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    return Column(
      children: [
        Padding(
          padding: context.paddingLow,
          child: postCardHeaderRow(context, snapshot, index,
              snapshot.data[index].title, snapshot.data[index].location),
        ),
        postCardDescription(context, snapshot, index),
        postCardBottomRow(snapshot, index)
      ],
    );
  }

  Container postCardDescription(
      BuildContext context, AsyncSnapshot snapshot, int index) {
    return Container(
      alignment: Alignment.centerLeft,
      height: context.height * 0.11,
      constraints: BoxConstraints(maxWidth: context.width * 0.78),
      child: Text(
        snapshot.data[index].description.toString(),
        style: TextStyle(
            fontSize: context.height * 0.019,
            color: ColorPallette.color4.withOpacity(0.7)),
      ),
    );
  }

  Row postCardBottomRow(AsyncSnapshot snapshot, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        postCardBottomRowItem(snapshot, index, 30.0, 'thumbs-up.png',
            snapshot.data[index].likeCount),
        postCardBottomRowItem(snapshot, index, 25.0, 'comment.png',
            snapshot.data[index].commentCount),
        postCardBottomRowItem(snapshot, index, 40.0, 'pedestrian.png',
            snapshot.data[index].participantCount),
      ],
    );
  }

  Row postCardBottomRowItem(
      AsyncSnapshot snapshot, int index, iconSize, iconName, data) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/$iconName',
          height: iconSize,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          data.toString(),
          style: TextStyle(color: ColorPallette.color4),
        )
      ],
    );
  }
}
