import 'package:fin_task/app/app.dart';
import 'package:fin_task/services/push_notification_service/push_notification_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService().setupInteractedMessage();
  runApp(MyApp());
}
