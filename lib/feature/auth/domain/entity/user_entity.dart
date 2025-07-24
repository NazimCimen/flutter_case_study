import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UserEntity extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  const UserEntity({this.id, this.name, this.email, this.photoUrl});

  @override
  List<Object?> get props => [id, name, email, photoUrl];

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) => UserEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    photoUrl: photoUrl ?? this.photoUrl,
  );
}
