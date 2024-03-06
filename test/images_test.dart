import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_firebase_fire/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.img).existsSync(), isTrue);
  });
}
