import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/python.dart'; // Supports Python syntax highlighting
import 'package:flutter_highlight/themes/github.dart'; // Theme for syntax highlighting

class CodeEditorScreen extends StatefulWidget {
  const CodeEditorScreen({super.key});

  @override
  State<CodeEditorScreen> createState() => _CodeEditorScreenState();
}

class _CodeEditorScreenState extends State<CodeEditorScreen> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(
      text: "print('Hello, World!')", // Default Python code
      language: python, // Set language to Python
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Code Editor")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: CodeTheme(
                data: CodeThemeData(
                    styles: githubTheme), // Apply syntax highlighting theme
                child: CodeField(
                  controller: _codeController,
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _formatCode,
              child: Text("Format Code"),
            ),
          ],
        ),
      ),
    );
  }

  void _formatCode() {
    setState(() {
      _codeController.text = _codeController.text.trim(); // Simple formatting
    });
  }
}
