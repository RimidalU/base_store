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
    final scaffoldMessenger = ScaffoldMessenger.of(context);

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
              Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              try {
                await Provider.of<ProductsProvider>(context, listen: false)
                    .removeProduct(id);
              } catch (error) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
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
