import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'users.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Users>> fetchUsers(http.Client client) async {
  final response =
  await client.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  // Use the compute function to run parseUsers in a separate isolate.
  return compute(parseUsers, response.body);
}

// A function that converts a response body into a List<User>.
List<Users> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Users>((json) => Users.fromJson(json)).toList();
}

Future<List<ToDos>> fetchToDos(http.Client client, int userId) async {
  final response =
  await client.get(Uri.parse('https://jsonplaceholder.typicode.com/todos?userId=$userId'));

  // Use the compute function to run parseTodos in a separate isolate.
  return compute(parseToDos, response.body);
}

// A function that converts a response body into a List<ToDos>.
List<ToDos> parseToDos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ToDos>((json) => ToDos.fromJson(json)).toList();
}
//------
class UsersListPage extends StatelessWidget {
  const UsersListPage({Key? key}) : super(key: key);

  static const String routeName = '/usersList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('пользователи'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Users>>(
        future: fetchUsers(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('ошибка!'),
            );
          } else if (snapshot.hasData) {
            return UsersList(users: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  const UsersList({Key? key, required this.users}) : super(key: key);

  final List<Users> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            '${users[index].id}. ${users[index].name}',
            style: Theme.of(context).textTheme.headline5,
          ),
          subtitle: Text(users[index].email),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserDetails(user: users[index])),
            );
          },
        );
      },
    );
  }
}
//------
class UserDetails extends StatelessWidget {
  const UserDetails({Key? key, required this.user}) : super(key: key);

  final Users user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          Text('email: ${user.email}'),
          Text('web-site: ${user.website}'),
          Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(children: [
              const Text('адрес: '),
              const SizedBox(width: 5.0),
              Text('${user.address.street}'),

            ]),
          ),
          Text('${user.address.suite}, ${user.address.city}, ${user.address.zipcode}'),
          Text(
              'геопозиция: (${user.address.geo.lat}; ${user.address.geo.lng})'),
          Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                const Text('телефон: '),
                Text(user.phone,)
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, indent: 10, endIndent: 10),
          ExpansionTile(
            title: Text('место работы: ${user.company.name}'),
            children: [
              Text('деятельность: ${user.company.catchPhrase}'),
              Text('проект: ${user.company.bs}'),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'функиционал',
            style: Theme.of(context).textTheme.headline6,
          ),
          UserToDosList(userId: user.id),
        ],
      ),
    );
  }
}
class UserToDosList extends StatelessWidget {
  const UserToDosList({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ToDos>>(
      future: fetchToDos(http.Client(), userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('ошибка!'),
          );
        } else if (snapshot.hasData) {
          return ToDosList(toDoS: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class ToDosList extends StatelessWidget {
  const ToDosList({Key? key, required this.toDoS}) : super(key: key);

  final List<ToDos> toDoS;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: toDoS.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            value: toDoS[index].completed,
            onChanged: (val) {},
            title: Text('${index+1}. ${toDoS[index].title}'),
          );
        },
      ),
    );
  }
}