import 'package:flutter/material.dart';
import 'package:lecab/Views/User/user_search.dart';

class HomeSearchButton extends StatelessWidget {
  const HomeSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UserSearch(),
            ));
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
              elevation: const MaterialStatePropertyAll(2)),
          child: const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.search_rounded,
                size: 40,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Where to?',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
