// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

import '../providers/product.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null.toString(),
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
  );
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final productID = ModalRoute.of(context)!.settings.arguments as String;
      _editedProduct =
          Provider.of<Products>(context, listen: false).findById(productID);
      _initValues = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),

        // 'imageUrl': _editedProduct.imageUrl,
        'imageUrl': '',
      };
      _imageUrlController.text = _editedProduct.imageUrl;
    }
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocus.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionNode.dispose();
    _imageUrlFocus.dispose();
    _imageUrlController.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState?.save();
    _form.currentState?.validate();

    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'title ',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                  onSaved: (titlevalue) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavorite: _editedProduct.isFavorite,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price,
                      title: titlevalue.toString(),
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: '0.00',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'enter the value';
                    }
                    if (double.parse(value) <= 0) {
                      return 'please enter value greater then zero';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavorite: _editedProduct.isFavorite,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      price: double.parse(value!),
                      title: _editedProduct.title,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  decoration: const InputDecoration(
                    labelText: 'Description ',
                    hintText: 'describe',
                  ),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionNode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please provide a value';
                    }
                    if (value.length < 10) {
                      return 'Character at least greater then 10';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      id: _editedProduct.description,
                      isFavorite: _editedProduct.isFavorite,
                      description: value.toString(),
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price,
                      title: _editedProduct.title,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Enter Url')
                          : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(_imageUrlController.text),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter Url',
                          hintText: 'URL',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        focusNode: _imageUrlFocus,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter the url';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavorite: _editedProduct.isFavorite,
                            description: _editedProduct.description,
                            imageUrl: value.toString(),
                            price: _editedProduct.price,
                            title: _editedProduct.title,
                          );
                        },
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
