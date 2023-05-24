import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/bike_model.dart';

class EventCards extends StatelessWidget {
  const EventCards({
    super.key,
    required this.storyShareTimes,
    required this.bike,
    required this.exchangeTimes,
    required this.selfMaintenanceTimes,
    required this.repairMaintenanceTimes,
  });

  final String storyShareTimes;
  final BikeModel bike;
  final String exchangeTimes;
  final String selfMaintenanceTimes;
  final String repairMaintenanceTimes;

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: currentWidth*0.02, vertical: currentHeight*0.001),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Story Sharing'),
              content: Text(
                'Past owners shared ${storyShareTimes} fond memories of ${bike.name}.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          child: Row(
            children: [Icon(Icons.image), Text(" X " + storyShareTimes)],
          ),
        ),
        InkWell(
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('History Owner'),
              content: Text(
                '${bike.name} has been used by ${exchangeTimes} people.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.transfer_within_a_station),
              Text(' X ' + exchangeTimes)
            ],
          ),
        ),
        InkWell(
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Meticulously maintained'),
              content: Text(
                '${bike.name} has been maintained and customized ${selfMaintenanceTimes} times by past users.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.auto_fix_high),
              Text(' X ' + selfMaintenanceTimes)
            ],
          ),
        ),
        InkWell(
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Customization and Repair'),
              content: Text(
                'Previous owners have repaired and customized ${bike.name} ${repairMaintenanceTimes} times.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
          child: Row(
            children: [Icon(Icons.build), Text(' X ' + repairMaintenanceTimes)],
          ),
        ),
      ]),
    );
  }
}
