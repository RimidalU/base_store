import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final imageUrlController = TextEditingController();
  final imageUrlFocusNode = FocusNode();
  final form = GlobalKey<FormState>();
  var editedProduct = ProductProvider(
    description: '',
    id: '',
    imageUrl: '',
    price: 0,
    title: '',
  );

  var initValue = {
    'description': '',
    'imageUrl': '',
    'price': '',
    'title': '',
  };

  var isInit = true;
  var isLoading = false;

  @override
  void initState() {
    imageUrlFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        editedProduct = Provider.of<ProductsProvider>(context)
            .findById(productId as String);

        initValue = {
          'description': editedProduct.description,
          'imageUrl': '',
          'price': editedProduct.price.toString(),
          'title': editedProduct.title,
        };
        imageUrlController.text = editedProduct.imageUrl;
      }
    }
    isInit = false;

    super.didChangeDependencies();
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
      if ((!imageUrlController.text.startsWith('http') &&
              !imageUrlController.text.startsWith('https')) ||
          (!imageUrlController.text.endsWith('.png') &&
              !imageUrlController.text.endsWith('.jpg') &&
              !imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> saveForm() async {
    final isValid = form.currentState!.validate();
    if (!isValid) {
      return;
    }
    form.currentState?.save();
    setState(() {
      isLoading = true;
    });
    if (editedProduct.id != '') {
      await Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(editedProduct.id, editedProduct);
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(editedProduct);
      } catch (error) {
        if (mounted) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('An error occurred!'),
              content: const Text(
                'Something went wrong.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Okay!'),
                )
              ],
            ),
          );
        }
      }
    }

    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
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
        actions: [
          IconButton(onPressed: saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: initValue['title'],
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          editedProduct = ProductProvider(
                            id: editedProduct.id.toString(),
                            title: value.toString(),
                            description: editedProduct.description,
                            price: editedProduct.price,
                            imageUrl: editedProduct.imageUrl,
                            isFavorite: editedProduct.isFavorite,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: initValue['price'],
                        decoration: const InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number.';
                          }
                          if (double.tryParse(value)! <= 0) {
                            return 'Please enter a number greater than zero.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          editedProduct = ProductProvider(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: editedProduct.description,
                            isFavorite: editedProduct.isFavorite,
                            price: double.parse(
                              value.toString(),
                            ),
                            imageUrl: editedProduct.imageUrl,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: initValue['description'],
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          if (value.length < 10) {
                            return 'Should be at least 10 characters long.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          editedProduct = ProductProvider(
                            id: editedProduct.id,
                            title: editedProduct.title,
                            description: value.toString(),
                            price: editedProduct.price,
                            imageUrl: editedProduct.imageUrl,
                            isFavorite: editedProduct.isFavorite,
                          );
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            child: imageUrlController.text.isEmpty
                                ? const Center(child: Text('Inter a Url'))
                                : FittedBox(
                                    fit: BoxFit.cover,
                                    clipBehavior: Clip.hardEdge,
                                    child:
                                        Image.network(imageUrlController.text),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: imageUrlController,
                              focusNode: imageUrlFocusNode,
                              onFieldSubmitted: (_) => saveForm(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'Please enter valid URL.';
                                }
                                if (!value.endsWith('.png') &&
                                    !value.endsWith('.jpg') &&
                                    !value.endsWith('.jpeg')) {
                                  return 'Please enter valid URL.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                editedProduct = ProductProvider(
                                  id: editedProduct.id,
                                  title: editedProduct.title,
                                  description: editedProduct.description,
                                  price: editedProduct.price,
                                  isFavorite: editedProduct.isFavorite,
                                  imageUrl: value.toString(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          onPressed: saveForm, child: const Text('Save'))
                    ],
                  )),
            ),
    );
  }
}
