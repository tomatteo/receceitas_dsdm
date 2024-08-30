import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receitas/database/dao/receitadao.dart';
import 'package:receitas/model/receita.dart';

class AddReceitaPage extends StatefulWidget {
  @override
  _AddReceitaPageState createState() => _AddReceitaPageState();
}

class _AddReceitaPageState extends State<AddReceitaPage> {
  final _nomeController = TextEditingController();
  final _imageController = TextEditingController();
  final _modopreparoController = TextEditingController();
  final _ingredientesController = TextEditingController();
  File? _imageFile; // Variável para armazenar a imagem

  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageController.text =
            pickedFile.path; // Atualiza o controller com o caminho da imagem
      });
    }
  }

  void _addReceita() async {
    final nome = _nomeController.text;
    final image = _imageController.text;
    final modopreparo = _modopreparoController.text;
    final ingredientes = _ingredientesController.text;

    if (nome.isEmpty ||
        image.isEmpty ||
        modopreparo.isEmpty ||
        ingredientes.isEmpty) {
      return;
    }

    final receita = Receita(
      id: 10, // verificar com Heitor
      nome: nome,
      image: image,
      modopreparo: modopreparo,
      ingredientes: ingredientes,
    );

    await insertReceita(receita);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Receita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _imageController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Imagem',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: _pickImage,
                ),
              ),
            ),
            if (_imageFile != null)
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(_imageFile!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            TextField(
              controller: _modopreparoController,
              decoration: InputDecoration(labelText: 'Modo de Preparo'),
            ),
            TextField(
              controller: _ingredientesController,
              decoration: InputDecoration(labelText: 'Ingredientes'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addReceita,
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
