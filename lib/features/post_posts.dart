import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/repo_class.dart';


class PostPosts extends StatefulWidget {
  const PostPosts({Key? key}) : super(key: key);

  @override
  State<PostPosts> createState() => _PostPostsState();
}

class _PostPostsState extends State<PostPosts> {

  final _formKey = GlobalKey<FormState>();
  final _myController1 = TextEditingController();
  final _myController2 = TextEditingController();
  final _myController3 = TextEditingController();

  String _title = '';
  String _body = '';
  String _userId = '';


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _myController1.dispose();
    _myController2.dispose();
    _myController3.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // return Text('There will be a posting form later');
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _myController1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.text_fields),
                  hintText: "Please enter the title of your post",
                ),
              ),
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _myController2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.text_increase),
                  hintText: "Please enter the body of your post",
                ),
              ),
              TextFormField(
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _myController3,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.numbers),
                  hintText: "Please enter userId",
                ),
              ),
              Center(
                // padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            RepoClass repoClass = RepoClass();
                            repoClass.postPosts(
                                _myController1.text,
                                _myController2.text,
                                int.parse(_myController3.text)); // for converting String to int
                            _title = _myController1.text;
                            _body = _myController2.text;
                            _userId = _myController3.text;
                            _myController1.text = '';
                            _myController2.text = '';
                            _myController3.text = '';
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      child: _title == "" ? null : const Text('The passed parameters are:'),
                    ),
                    const SizedBox(height: 20,),
                    Text(_title),
                    const SizedBox(height: 20,),
                    Text(_body),
                    const SizedBox(height: 20,),
                    Text(_userId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}