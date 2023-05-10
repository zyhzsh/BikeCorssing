import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContractApprovedScreen extends StatelessWidget {
  const ContractApprovedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Great',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Your bike rental contract \n has been approved!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          Icon(Icons.check_circle_rounded,
              size: 80, color: Theme.of(context).colorScheme.primary),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColorLight,
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: Size(280, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {},
            child: const Text('Continue'),
          )
        ],
      ),
    ));
  }
}
