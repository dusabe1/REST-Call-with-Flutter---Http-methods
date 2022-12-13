import 'package:flutter/material.dart';
import 'package:flutter_crud_api/base_client.dart';
import 'package:flutter_crud_api/user.dart';

import 'app_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const FlutterLogo(size: 72),
              AppButton(
                operation: 'GET',
                operationColor: Colors.lightGreen,
                description: 'Fetch users',
                onPressed: () async {
                  var response =
                      await BaseClient().get('/users').catchError((err) {});
                  if (response == null) return;
                  debugPrint('successfull:');

                  var users = userFromJson(response);
                  debugPrint('Users Count : ' + users.length.toString());
                },
              ),
              AppButton(
                operation: 'POST',
                operationColor: Colors.lightBlue,
                description: 'Add users',
                onPressed: () async {
                  var user = User(
                    name: 'Dusabe JC',
                    qualifications: [
                      Qualification(
                          degree: 'Master', completionData: '01-01-2025')
                    ],
                  );

                  var response = await BaseClient()
                      .post('/users', user)
                      .catchError((err) {});
                  if (response == null) return;
                  debugPrint('successfull Post:');
                },
              ),
              AppButton(
                operation: 'PUT',
                operationColor: Colors.yellow,
                description: 'Edit users',
                onPressed: () async {
                  var id = 2;
                  var user = User(
                    name: 'Dusabe JC',
                    qualifications: [
                      Qualification(
                          degree: 'Ph.D', completionData: '01-01-2027')
                    ],
                  );

                  var response = await BaseClient()
                      .put('/users/$id', user)
                      .catchError((err) {});
                  if (response == null) return;
                  debugPrint('successfull Edit:');
                },
              ),
              AppButton(
                operation: 'DELETE',
                operationColor: Colors.red,
                description: 'Delete users',
                onPressed: () async {
                  var id = 2;
                  var response = await BaseClient().delete('/users/$id').catchError((err) {});
                  if (response == null) return;
                  debugPrint('successfull DELETE:');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
