import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserSearch extends StatelessWidget {
  const UserSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(Icons.arrow_downward_rounded),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), hintText: 'From'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(), hintText: 'To?'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return Text("data $index");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
