import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class IncidentReportScreen extends StatefulWidget {
  const IncidentReportScreen({super.key});

  @override
  _IncidentReportScreenState createState() => _IncidentReportScreenState();
}

class _IncidentReportScreenState extends State<IncidentReportScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedIncidentType;
  final _descriptionController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final List<String> _incidentTypes = [
    'Điện',
    'Nước',
    'Mạng Internet',
    'Nội thất',
    'Vệ sinh',
    'Khác'
  ];

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement submission logic
      print('Incident Type: $_selectedIncidentType');
      print('Description: ${_descriptionController.text}');
      print('Image path: ${_image?.path}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gửi báo cáo sự cố thành công!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo sự cố'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedIncidentType,
                decoration: const InputDecoration(
                  labelText: 'Loại sự cố',
                  border: OutlineInputBorder(),
                ),
                items: _incidentTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedIncidentType = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Vui lòng chọn loại sự cố' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Mô tả chi tiết',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng mô tả sự cố';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildImagePicker(),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitReport,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Gửi báo cáo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Đính kèm hình ảnh (tùy chọn)',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: _image == null
                ? TextButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Chọn ảnh'),
                    onPressed: _pickImage,
                  )
                : Stack(
                    children: [
                      Image.file(_image!, fit: BoxFit.cover, width: double.infinity),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
