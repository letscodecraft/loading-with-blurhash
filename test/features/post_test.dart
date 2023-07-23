import 'dart:convert';

import 'package:blurhash_loading/features/home/domain/post_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fixtures/fixture_reader.dart';

void main() {
  test("Shall change post  json  to dart model", () {
    final json = jsonDecode(fixture("post.json"));

    final result = PostModel.fromJson(json);
    expect(result.id, "002");
  });
}
