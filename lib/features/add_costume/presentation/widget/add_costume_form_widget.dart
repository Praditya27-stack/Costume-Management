import 'package:flutter/material.dart';
import 'package:wmp/db_helper.dart';

class AddCostumeFormWidget extends StatefulWidget {
  final String? imagePath;
  final Map<String, dynamic>? initialData; // New parameter for initial data
  final Function(Map<String, dynamic>)? onSubmit; // Callback for form submission

  const AddCostumeFormWidget({
    Key? key,
    this.imagePath,
    this.initialData,
    this.onSubmit,
  }) : super(key: key);

  @override
  _AddCostumeFormWidgetState createState() => _AddCostumeFormWidgetState();
}

class _AddCostumeFormWidgetState extends State<AddCostumeFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _costumeNameController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;
  late TextEditingController _sizeController;
  late TextEditingController _materialController;
  late TextEditingController _colorController;
  late TextEditingController _stockController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _costumeNameController = TextEditingController(text: widget.initialData?['name'] ?? '');
    _categoryController = TextEditingController(text: widget.initialData?['category'] ?? '');
    _priceController = TextEditingController(text: widget.initialData?['price']?.toString() ?? '');
    _sizeController = TextEditingController(text: widget.initialData?['size'] ?? '');
    _materialController = TextEditingController(text: widget.initialData?['material'] ?? '');
    _colorController = TextEditingController(text: widget.initialData?['color'] ?? '');
    _stockController = TextEditingController(text: widget.initialData?['stock']?.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.initialData?['description'] ?? '');
  }

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

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final costumeData = {
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

      if (widget.onSubmit != null) {
        widget.onSubmit!(costumeData); // Trigger the callback
      } else {
        _saveCostume(costumeData); // Default save behavior
      }
    }
  }

  Future<void> _saveCostume(Map<String, dynamic> costume) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.insertCostume(costume);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Costume added!')),
    );

    Navigator.pop(context);
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
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.onSubmit != null ? "Save Changes" : "Add Costume",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
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

  Widget _buildTextField(String label, TextEditingController controller, bool isRequired,
      {TextInputType? keyboardType, int maxLines = 1}) {
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
