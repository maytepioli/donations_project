import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';

Handler middleware(Handler handler) {
  return (context) async {
    if (!Firestore.initialized) {
      Firestore.initialize('donationcenterppg');
    }

    final response = await handler(context);

    return response;
  };
}
