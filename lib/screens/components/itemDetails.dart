import 'package:flutter/material.dart';

class itemDetails extends StatelessWidget {
  const itemDetails(
      {super.key, required this.imageUrl, required this.onUpload});
  final String? imageUrl;
  final void Function(String) onUpload;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            color: Colors.red,
            width: 200,
            height: 200,
            child: imageUrl != null
                ? Image.network(imageUrl!, fit: BoxFit.cover)
                : Container(
                    child: Center(
                      child: Text("No Image"),
                    ),
                  )),
        ElevatedButton(onPressed: () async {}, child: Text("upload"))
      ],
    );
  }
}
