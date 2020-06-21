# bdd_widget_test [![Build Status](https://travis-ci.org/olexale/bdd_widget_test.svg?branch=master)](https://travis-ci.org/olexale/bdd_widget_test) [![Coverage Status](https://coveralls.io/repos/github/olexale/bdd_widget_test/badge.svg?branch=master)](https://coveralls.io/github/olexale/bdd_widget_test?branch=master)

A BDD-style widget testing library

## Why?

Isn't it cool to develop mobile apps in natural language? A language each of your team members can read and understand so that it involves everyone working on the project productively. While Dart is on its way to this goal, for tests there is a language for that! It's called Gherkin.

The aim of this library is in combining two effective and easy-to-use techniques: BDD(Gherkin) and widget testing.

## Getting Started

### Add the dependency

Add `build_runner` and `bdd_widget_test` dependcies to `dev_dependencies` section of the `pubspec.yaml` file.
```yaml
dev_dependencies:
  build_runner:
  bdd_widget_test: <put the latest version here>
  ...
```

You may get the actual version from [installation instructions](https://pub.dartlang.org/packages/bdd_widget_test#-installing-tab-) on Pub site.

### Write features

Create `*.feature` file inside `test` folder. Let's say you're testing the default Flutter counter app, the content might be:
```
Feature: Counter
    Scenario: Initial counter value is 0
        Given the app is running
        Then I see {0} text
```

Now ask `built_value` to generate Dart files for you. You may do this with the command:
```
flutter packages pub run build_runner watch --delete-conflicting-outputs
```
After that, the corresponding `dart` file will be generated for each of your `feature` files. Do not change the code inside these `dart` files as they will be recreated each time you change something in feature files.

During feature-to-dart generation additional `step` folder will be created. It will contain all steps required to run the scenario. These files will not be updated hence feel free to adapt the content according to your needs.

### Run tests

You're good to go! `bdd_widget_test` generated plain old Dart tests, so feel free to run you tests within your IDE or using the following command
```
flutter test
```

## Feature file syntax

Feature file sample:
```
// comment here

Feature: Counter

  Scenario: Initial counter value is 0
    Given the app is running
    Then I see {0} text

  Scenario: Plus button increases the counter
    Given the app is running
    When I tap on {Icons.add} icon
    Then I see {1} text
```

Each feature file must have one or more `Feature:`s. Features become test groups in Flutter tests.

Each feature group must have one or more `Scenario:`s. Scenario become widget tests.

Each scenario must have one or more lines. Each of them must start with `Given`, `When`, `Then`, or `And` keywords. Conventionally `Given` steps are used for test arrangements, `When` — for interaction, `Then` — for asserts.

## FAQ

### How to pass a parameter?

You may use curly brackets to pass the parameter into a `step`. The syntax is following:
```
  Give I see {42} number
  And I see {Icons.add} icon
```
Notice, that the value inside brackets is copied to the Dart test file without changes hence it must be a valid Dart code. In the example above first step will have an `int` value. In order to pass a valid Dart string use '42' or "42".

You may call methods in step parameters, but most probably it's not what you want.

### How to add additional imports to test files?

Most of the time you shouldn't do that, as the BDD tests simulate user's behavior and it's just not possible for users to know the implementation details. Nevertheless, sometimes it might be in hand, i.e. when you have custom domain models or components. For example, if you need to check Cupertino icons in the test, you may have:
```
import 'package:flutter/cupertino.dart';

Feature: ...
  Then I see {CupertinoIcons.back} cupertino icon
```

### How to adjust linter for auto-generated tests?

Use the same trick as above, just write linter rules you wish to ignore at the beginning of the feature file:
```
// ignore_for_file: avoid_as, prefer_is_not_empty

Feature: ...
```

## Contributing

If you find a bug or would like to request a new feature, just [open an issue](https://github.com/olexale/bdd_widget_test/issues/new). Your contributions are always welcome!

## License
`bdd_widget_test` is released under a [MIT License](https://opensource.org/licenses/MIT). See `LICENSE` for details.
