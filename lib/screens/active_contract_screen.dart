import 'package:flutter/cupertino.dart';

class ActiveContractScreen extends StatefulWidget {
  const ActiveContractScreen({Key? key}) : super(key: key);

  @override
  State<ActiveContractScreen> createState() => _ActiveContractScreenState();
}

class _ActiveContractScreenState extends State<ActiveContractScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        //_Tabs
        SizedBox(
          height: 100,
          width: double.infinity,
          child: Text('Active Contract'),
        ),
        //_Body
        _ContractInfo(),
      ],
    );
  }
}

class _ContractInfo extends StatelessWidget {
  const _ContractInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [],
    ));
  }
}
