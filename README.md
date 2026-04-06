# SISOLA KI


---

## Prerequisites

Ensure Dart is installed:

```bash
dart --version
```

---

## Configuration

* **Database Connection**
  `./lib/repositories/myconnection.dart`

* **JWT Secret Key**
  `./lib/helper/jwt_helper.dart`

---

## Development

```bash
dart pub get
dart pub global activate dart_frog_cli
dart_frog dev
```

---

## Deployment

```bash
dart pub get
dart pub global activate dart_frog_cli
dart_frog build
```

Run the server:

```bash
dart run ./build/bin/server.dart
```

* Default port: **80**
* To change, set environment variable: `SERVER_PORT`

---
