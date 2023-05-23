import 'package:BikeCrossing/models/bike_model.dart';
import 'package:BikeCrossing/models/rental_contract_model.dart';
import 'package:BikeCrossing/screens/contract_approved_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../providers/profile_provider.dart';

class RentalContractScreen extends ConsumerStatefulWidget {
  const RentalContractScreen({Key? key, required this.bike}) : super(key: key);

  final BikeModel bike;

  @override
  ConsumerState<RentalContractScreen> createState() =>
      _RentalContractScreenState();
}

class _RentalContractScreenState extends ConsumerState<RentalContractScreen> {
  DateTime? _selectedDate;
  int? _rentalDays;
  int _estimatedCost = 0;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year, now.month + 1, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
    _createContractPreview();
  }

  void _createContractPreview() {
    final now = DateTime.now();
    int differenceInDays;
    Duration difference = _selectedDate!.difference(now);
    differenceInDays = difference.inDays;
    differenceInDays++;
    int estimatedCost = differenceInDays * widget.bike.rentalPointsPerDay;
    setState(() {
      _rentalDays = differenceInDays;
      _estimatedCost = estimatedCost;
    });
  }

  void _confirmContract() {
    User user = Supabase.instance.client.auth.currentUser!;
    RentalContractModel contract = RentalContractModel(
        bikeId: widget.bike.id,
        userId: user.id,
        returnDate: _selectedDate!,
        costPointPerDay: widget.bike.rentalPointsPerDay);
    ref.read(userProfileProvider.notifier).assignRentalContract(contract);
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ContractApprovedScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProfileProvider);

    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_circle_left_outlined),
                label: Text('Back')),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Rental Contract',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.bike.images[0]),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.bike.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${widget.bike.rentalPointsPerDay} Points / Day',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '*',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                    ),
                    Text(
                      'What is your expected return date?',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        onPressed: _presentDatePicker,
                        label: const Text('Choose Date'),
                        icon: const Icon(Icons.calendar_today)),
                    Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : _selectedDate!.year.toString() +
                              '-' +
                              _selectedDate!.month.toString() +
                              '-' +
                              _selectedDate!.day.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _selectedDate != null
                    ? Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: const Divider()),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Your existing points：',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '${user.remainingPoints}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Estimated cost：',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '${widget.bike.rentalPointsPerDay} * ${_rentalDays} = ${_estimatedCost} Points',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          user.remainingPoints >= _estimatedCost
                              ? ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).primaryColorLight,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    minimumSize: Size(280, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: _confirmContract,
                                  label: const Text('Confirm'),
                                  icon: const Icon(
                                      Icons.arrow_circle_right_outlined))
                              : Text('You don\'t have enough points to rent'),
                        ],
                      )
                    : SizedBox(
                        height: 1,
                      ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
