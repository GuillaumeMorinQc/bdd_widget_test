import 'dart:io';

import 'package:bdd_widget_test/src/feature_file.dart';
import 'package:build/build.dart';

Builder featureBuilder(BuilderOptions options) => FeatureBuilder();

class FeatureBuilder implements Builder {
  @override
  Future<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final contents = await buildStep.readAsString(inputId);
    final feature = FeatureFile(
        path: inputId.path, package: inputId.package, input: contents);

    final featureDart = inputId.changeExtension('_test.dart');
    await buildStep.writeAsString(featureDart, feature.dartContent);

    for (final step in feature.getStepFiles()) {
      await createFileRecursively(step.filename, step.dartContent);
    }
  }

  Future<void> createFileRecursively(String filename, String content) async {
    final file = await File(filename).create(recursive: true);
    final length = await file.length();
    if (length == 0) {
      await file.writeAsString(content);
    }
  }

  @override
  final buildExtensions = const {
    '.feature': ['_test.dart']
  };
}
