import 'package:flutter/material.dart';
import 'package:wmp/db_helper.dart';

class AddCostumeFormWidget extends StatefulWidget {
  final String? imagePath;

  const AddCostumeFormWidget({Key? key, this.imagePath}) : super(key: key);

  @override
  _AddCostumeFormWidgetState createState() => _AddCostumeFormWidgetState();
}

class _AddCostumeFormWidgetState extends State<AddCostumeFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _costumeNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void dispose() {
    _costumeNameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _sizeController.dispose();
    _materialController.dispose();
    _colorController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveCostume() async {
    if (_formKey.currentState!.validate()) {
      final costume = {
        'name': _costumeNameController.text,
        'category': _categoryController.text,
        'price': double.tryParse(_priceController.text) ?? 0.0,
        'size': _sizeController.text,
        'material': _materialController.text,
        'color': _colorController.text,
        'stock': int.tryParse(_stockController.text) ?? 0,
        'description': _descriptionController.text,
        'imagePath': widget.imagePath ?? '',
      };

      await _dbHelper.insertCostume(costume);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Costume added!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildFormFields(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveCostume,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Add Costume",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField("Costume Name", _costumeNameController, true),
      _buildTextField("Category", _categoryController, true),
      _buildTextField("Price", _priceController, true, keyboardType: TextInputType.number),
      _buildTextField("Size", _sizeController, false),
      _buildTextField("Material", _materialController, false),
      _buildTextField("Color", _colorController, false),
      _buildTextField("Stock", _stockController, true, keyboardType: TextInputType.number),
      _buildTextField("Description", _descriptionController, false, maxLines: 4),
    ];
  }

  Widget _buildTextField(String label, TextEditingController controller, bool isRequired, {TextInputType? keyboardType, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            validator: isRequired
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter $label";
                    }
                    return null;
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
