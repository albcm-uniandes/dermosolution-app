import 'package:flutter/material.dart';
import 'package:body_part_selector/body_part_selector.dart';

class BodyPartSelectorScreen extends StatefulWidget {
  const BodyPartSelectorScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BodyPartState();
}

class _BodyPartState extends State<BodyPartSelectorScreen> {
  BodyParts _bodyParts = const BodyParts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BodyPartSelectorTurnable(
        bodyParts: _bodyParts,
        onSelectionUpdated: (p) => setState(() => _bodyParts = p),
        labelData: const RotationStageLabelData(
          front: 'FRONT',
          left: 'LEFT',
          right: 'RIGHT',
          back: 'BACK',
        ),
      )),
    );
  }
}
