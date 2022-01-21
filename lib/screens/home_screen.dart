import 'dart:convert';
import 'dart:developer';

import 'package:emulador/models/item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  var itens = <Item>[];

  MyHomePage() {
    itens = [];
    /*  itens.add(Item(title: "Arroz", done: true));
    itens.add(Item(title: "feijão", done: false));
    itens.add(Item(title: "Carne", done: true)); */
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controllerTask = TextEditingController();

  void addTask() {
    if (controllerTask.text.isEmpty) {
      return;
    }
    setState(() {
      widget.itens.add(
        Item(
          title: controllerTask.text,
          done: false,
        ),
      );
      controllerTask.text = "";
      save();
    });
  }

  void remove(int index) {
    setState(() {
      widget.itens.removeAt(index);
      save();
    });
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.itens = result;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.itens));
  }

  _MyHomePageState() {
    load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: controllerTask,
          style: TextStyle(
            color: Colors.black,
          ),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              labelText: "Adicionar Tarefa",
              labelStyle: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var item = widget.itens[index];
            return Dismissible(
              key: Key(item.title),
              background: Container(
                color: Colors.red.withOpacity(0.3),
              ),
              onDismissed: (direction) {
                remove(index);
              },
              child: CheckboxListTile(
                title: Text(item.title),
                value: item.done,
                onChanged: (value) {
                  setState(() {
                    item.done = value;
                    save();
                  });
                },
              ),
            );
          },
          itemCount: widget.itens.length),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
