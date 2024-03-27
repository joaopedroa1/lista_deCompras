import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<Map<String, dynamic>> compras = [
    {"name": "Macarrão", "price": "2.50", "isBought": false},
    {"name": "Arroz", "price": "3.00", "isBought": false},
  ];

  void addItem(String name, String price) {
    setState(() {
      compras.add({"name": name, "price": price, "isBought": false});
    });
    nameController.clear();
    priceController.clear();
  }

  void remove(int index) {
    setState(() {
      compras.removeAt(index);
    });
  }

  void toggleBoughtStatus(int index) {
    setState(() {
      compras[index]["isBought"] = !compras[index]["isBought"];
    });
  }

  void editItem(int index, String newName, String newPrice) {
    setState(() {
      compras[index]["name"] = newName;
      compras[index]["price"] = newPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de compras', style: GoogleFonts.roboto()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Nome do item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      hintText: 'Preço',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    addItem(nameController.text, priceController.text);
                  },
                  child: Text('Adicionar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: compras.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: compras[index]["isBought"],
                    onChanged: (bool? value) {
                      if (value != null) {
                        toggleBoughtStatus(index);
                      }
                    },
                  ),
                  title: Text(
                    compras[index]['name'],
                    style: GoogleFonts.nunitoSans(),
                  ),
                  subtitle: Text('R\$ ${compras[index]['price']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Editar Produto'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller:
                                          TextEditingController(text: compras[index]['name']),
                                      decoration: InputDecoration(
                                        labelText: 'Nome',
                                      ),
                                    ),
                                    TextField(
                                      controller:
                                          TextEditingController(text: compras[index]['price']),
                                      decoration: InputDecoration(
                                        labelText: 'Preço',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      editItem(
                                        index,
                                        nameController.text,
                                        priceController.text,
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Salvar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          remove(index);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
