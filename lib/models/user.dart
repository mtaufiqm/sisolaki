
import 'package:collection/collection.dart';

class User {
  String username;
  String? pwd;
  bool is_active;
  List<String>? roles;  
  User({
    required this.username,
    this.pwd,
    required this.is_active,
    this.roles,
  });

  User copyWith({
    String? username,
    String? pwd,
    bool? is_active,
    List<String>? roles,
  }) {
    return User(
      username: username ?? this.username,
      pwd: pwd ?? this.pwd,
      is_active: is_active ?? this.is_active,
      roles: roles ?? this.roles,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'pwd': null,
      'is_active': is_active,
      'roles': roles,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      pwd: map['pwd'] != null ? map['pwd'] as String : null,
      is_active: map['is_active'] as bool,
      roles: map['roles'] != null ? List<String>.from((map['roles'] as List<dynamic>).cast<String>()) : null,
    );
  }


  factory User.fromDb(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      pwd: map['pwd'] != null ? map['pwd'] as String : null,
      is_active: map['is_active'] as bool,
      roles: null,
    );
  }

  @override
  String toString() {
    return 'User(username: $username, pwd: $pwd, is_active: $is_active, roles: $roles)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.username == username &&
      other.pwd == pwd &&
      other.is_active == is_active &&
      listEquals(other.roles, roles);
  }

  @override
  int get hashCode {
    return username.hashCode ^
      pwd.hashCode ^
      is_active.hashCode ^
      roles.hashCode;
  }

  bool isContain(String role){
    bool result = false;
    if(this.roles == null){
      return result;
    }
    for(String itemRoles in this.roles!){
      if(itemRoles == role){
        result = true;
      }
    }
    return result;
  }

  bool isContainOne(List<String> roles){
    bool result = false;
    if(this.roles == null){
      return result;
    }
    for(String itemRoles in this.roles!){
      for(String item in roles){
        if(itemRoles == item){
          result = true;
          return result;
        }
      }
    }
    return result;
  }
}
