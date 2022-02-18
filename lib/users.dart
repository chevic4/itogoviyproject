import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
class Geo {
  final String lat;
  final String lng;

  const Geo({required this.lat, required this.lng});

  factory Geo.fromJson(Map<String, dynamic> json){
    return Geo(lat: json['lat'], lng: json['lng']);
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  const Address({required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo});

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(street: json['street'],
        suite: json['suite'],
        city: json['city'],
        zipcode: json['zipcode'],
        geo: Geo.fromJson(json['geo']));
  }

}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  const Company(
      {required this.name, required this.catchPhrase, required this.bs});

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(name: json['name'], catchPhrase: json['catchPhrase'], bs: json['bs']);
  }
}
class Users {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  const Users({required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json['id'] as int,
        name: json['name'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        address: Address.fromJson(json['address']),
        phone: json['phone'] as String,
        website: json['website'] as String,
        company: Company.fromJson(json['company'])
    );
  }
}
//----short data
class ToDos {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  ToDos(
      {required this.userId,
        required this.id,
        required this.title,
        required this.completed});

  factory ToDos.fromJson(Map<String, dynamic> json) {
    return ToDos(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        completed: json['completed']);
  }
}

