import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final imageUrlController = TextEditingController();
  final imageUrlFocusNode = FocusNode();

  @override
  void initState() {
    imageUrlFocusNode.addListener(updateImageUrl);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    imageUrlFocusNode.removeListener(updateImageUrl);
    imageUrlController.dispose();
    imageUrlFocusNode.dispose();
  }

  void updateImageUrl() {
    if (!imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit product',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              textInputAction: TextInputAction.next,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  child: imageUrlController.text.isEmpty
                      ? const Center(child: Text('Inter a Url'))
                      : FittedBox(
                          fit: BoxFit.cover,
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(imageUrlController.text),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: imageUrlController,
                    focusNode: imageUrlFocusNode,
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
