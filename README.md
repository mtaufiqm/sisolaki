

SISOLA KI (Sistem InformaSI Online Laporan Kinrja Pegawai) App

# First, ensure Dart installed

# EDIT DATABASE CONNECTION:
- ./lib/repositories/myconnection.dart

# JWT Secret Key:
- ./lib/helper/jwt_helper.dart

# RUN APP Development
- dart pub get
- dart pub global activate dart_frog_cli
- dart_frog dev

# RUN APP Deployment
- dart pub get
- dart pub global activate dart_frog_cli
- dart_frog build
- default PORT is 80, add/change "SERVER_PORT" environment variable to change default PORT
- dart run ./build/bin/server.dart