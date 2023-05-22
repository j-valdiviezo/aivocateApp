import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  static const _numberOfQuestions = 20;
  static final _questions = List.generate(
    _numberOfQuestions,
    (index) => 'Question $index',
  );
  static final _answers = List.generate(
    _numberOfQuestions,
    (index) {
      return 'Very long answer to this wonderful question $index$index$index';
    },
  );

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<int> _filteredIndexes =
      List.generate(_numberOfQuestions, (index) => index);

  void _searchAction(BuildContext context) {
    if (!_isSearching) {
      FocusScope.of(context).unfocus();
    }

    if (_searchController.text.isEmpty) {
      setState(() {
        _isSearching = false;
        _filteredIndexes = List.generate(_numberOfQuestions, (index) => index);
      });
      return;
    }

    setState(() {
      _isSearching = !_isSearching;
    });
    if (!_isSearching || _searchController.text.isEmpty) {
      _searchController.clear();
      setState(() {
        _filteredIndexes = List.generate(_numberOfQuestions, (index) => index);
      });
      return;
    }

    _filteredIndexes = [];
    for (int i = 0; i < _numberOfQuestions; i++) {
      if (_questions[i].contains(_searchController.text) ||
          _answers[i].contains(_searchController.text)) {
        _filteredIndexes.add(i);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          key: const Key('FAQ SliverAppBar'),
          floating: true,
          pinned: true,
          snap: false,
          stretch: false,
          backgroundColor: null,
          foregroundColor: null,
          title: const Text('FAQ'),
          bottom: PreferredSize(
            key: const Key('FAQ AppBar'),
            preferredSize: const Size.fromHeight(70),
            child: SizedBox(
              width: double.infinity,
              child: TextField(
                onTap: () {
                  setState(() {
                    _isSearching = false;
                  });
                },
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  // border: const UnderlineInputBorder(),
                  // labelText: 'Search for answers',
                  prefix: const SizedBox(width: 10),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Search your questions')
                    ],
                  ),
                  suffixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: IconButton(
                      onPressed: () {
                        _searchAction(context);
                      },
                      icon: Icon(
                        _isSearching ? Icons.close : Icons.search,
                      ),
                    ),
                  ),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  _searchAction(context);
                },
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ExpansionTile(
                title: Text(
                  _questions[_filteredIndexes[index]],
                  key: Key('question${_filteredIndexes[index]}'),
                ),
                children: [
                  Text(
                    _answers[_filteredIndexes[index]],
                    key: Key('answer${_filteredIndexes[index]}'),
                  ),
                ],
              );
            },
            childCount: _filteredIndexes.length,
          ),
        )
      ],
    );
  }
}
