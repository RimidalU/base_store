import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../features/features.dart';
import '../../../providers/providers.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.id,
  });

  final String title;
  final String imageUrl;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .removeProduct(id);
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ]),
      ),
    );
  }
}
