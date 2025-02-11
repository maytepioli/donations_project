// ignore_for_file: prefer_const_constructors
import 'package:donations/donations.dart';
import 'package:test/test.dart';

void main() {
  group('Donations', () {
    test('can be instantiated', () {
      expect(Donations(type: 'someType', name: 'someName'), isNotNull);
    });
  });
}
