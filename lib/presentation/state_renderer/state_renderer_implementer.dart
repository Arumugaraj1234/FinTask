import 'package:fin_task/app/enums.dart';
import 'package:fin_task/presentation/state_renderer/state_renderer.dart';
import 'package:flutter/material.dart';

class FlowState {
  StateRendererType stateRendererType;
  String message;
  String? title;

  FlowState(this.stateRendererType, this.message, this.title);
}

extension FlowStateExtension on FlowState {
  Widget getWidget(BuildContext context,
      Function(StateRendererAction action) buttonFunction) {
    return StateRenderer(
      stateRendererType: stateRendererType,
      buttonFunction: buttonFunction,
      message: message,
      title: title,
    );
  }
}
