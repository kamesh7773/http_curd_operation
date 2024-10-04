import 'package:flutter/material.dart';
import 'package:http_curd_operation/models/user_model.dart';
import 'package:http_curd_operation/services/https_methods.dart';
import 'package:http_curd_operation/widgets/showdiolog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TextEditing Controllers
  TextEditingController nameControllar = TextEditingController();
  TextEditingController emailControllar = TextEditingController();

  @override
  void dispose() {
    nameControllar.dispose();
    emailControllar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: const Text("HTTP METHOD'S"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          )
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: HttpsMethods.get(),
        builder: (context, snapshot) {
          //? Storing JSON data into the UserModel class.
          final List<Users> usersList = snapshot.data ?? [];

          // while fetching data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // if some error occured
          else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went Wrong ⚠️"),
            );
          }

          // else
          else {
            return ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                //? accessing Each User Model Data.
                var userData = usersList[index];

                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      // initlizing texteditling controllar vlaues
                      nameControllar.text = userData.name ?? "";
                      emailControllar.text = userData.email ?? "";
                      // ****************
                      // HTTP PUT METHOD
                      // ****************
                      showDialog(
                        context: context,
                        builder: (context) => MyDiologBox(
                          onTap: () async {
                            //! Creating UserModel for put() Method.
                            var user = Users(
                              avatar:
                                  "https://giftolexia.com/wp-content/uploads/2015/11/dummy-profile.png",
                              name: nameControllar.text.trim(),
                              email: emailControllar.text.trim(),
                            );

                            //! calling http put Method
                            await HttpsMethods.put(
                              userModel: user,
                              id: index + 1,
                              context: context,
                            );

                            //! setState rebuilds the whole UI, and as a result, FutureBuilder also rebuilds, ensuring the UI is updated with the latest data.
                            setState(() {});

                            // popout the Diolog box
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          btnText: "PUT",
                          nameController: nameControllar,
                          emailController: emailControllar,
                          nameControllerText: userData.name,
                          emailControllerText: userData.email,
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(userData.avatar ?? ""),
                      ),
                      title: Text(userData.name ?? ""),
                      subtitle: Text(userData.email ?? ""),
                      hoverColor: Colors.grey,
                      trailing: IconButton(
                        tooltip: "HTTP.DELETE( )",
                        onPressed: () async {
                          //! Calling the HTTP DELETE method and passing the user index that we want to delete.
                          await HttpsMethods.delete(
                              id: index + 1, context: context);

                          //! setState rebuilds the whole UI, and as a result, FutureBuilder also rebuilds, ensuring the UI is updated with the latest data.
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "HTTP POST( )",
        onPressed: () {
          // ****************
          // HTTP POST METHOD
          // ****************
          showDialog(
            context: context,
            builder: (context) => MyDiologBox(
              onTap: () async {
                //! Creaing User Model for http Post
                var user = Users(
                  avatar:
                      "https://giftolexia.com/wp-content/uploads/2015/11/dummy-profile.png",
                  name: nameControllar.text.trim(),
                  email: emailControllar.text.trim(),
                );

                await HttpsMethods.post(userModel: user, context: context);
                //! setState rebuilds the whole UI, and as a result, FutureBuilder also rebuilds, ensuring the UI is updated with the latest data.
                setState(() {});

                nameControllar.clear();
                emailControllar.clear();

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              nameController: nameControllar,
              emailController: emailControllar,
              btnText: "POST",
              nameControllerText: nameControllar.text.trim(),
              emailControllerText: emailControllar.text.trim(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
