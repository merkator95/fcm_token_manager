# Fcm Token Manager

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A Very Good Project created by Very Good CLI.

## Description
Interface between Firebase Core and Firebase Messaging which helps in managing FCM tokens and notifications permissions.

It makes the following assumptions:
1. Your app has a backend
2. Your backend allows for updating user token and deleting of a user token
3. Your backend stores FCM tokens associated with string-based user ID

### Tokens
1. onLogin: It will check when was the last time your backend was updated with an FCM token and update it if it was longer than configured token ttl
2. onLogout: It will remove token from backend on logout

### Storing user preference re: notifications and asking for permission
1. Calling getAppNotificationPreference:
- will return current permission status, unless no permission is set in which case it will
- ask user for permission (using native iOS/Android process)

2. Using setAppNotificationPreference enables user to switch off notifications without using the device native preferences
- this simply calls your backend to delete the FCM token


## Installation 💻

**❗ In order to start using Fcm Token Manager you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Install via `flutter pub add`:

```sh
dart pub add fcm_token_manager
```

---

## Continuous Integration 🤖

Fcm Token Manager comes with a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

---


[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://pub.dev/packages/very_good_cli
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
