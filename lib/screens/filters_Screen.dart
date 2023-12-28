import 'package:delimeals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = 'filters';
  final void Function(Map<String, bool>) savefilter;
  final Map<String, bool> currentfilters;

  FilterScreen(this.currentfilters, this.savefilter);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactoseFree = false;

  @override
  void initState() {
    glutenFree = widget.currentfilters['gluten']!;
    lactoseFree = widget.currentfilters['lactose']!;
    vegan = widget.currentfilters['vegan']!;
    vegetarian = widget.currentfilters['vegetarian']!;
    super.initState();
  }

  Widget buildswitchlisttile(String title, String description,
      bool currentvalue, Function(bool) updateValue) {
    return SwitchListTile(
      value: currentvalue,
      title: Text(title),
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedfilters = {
                  'gluten': glutenFree,
                  'lactose': lactoseFree,
                  'vegan': vegan,
                  'vegetarian': vegetarian,
                };
                widget.savefilter(selectedfilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: Maindrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildswitchlisttile(
                  'Gluten-free',
                  'only Include Gluten-free meals',
                  glutenFree,
                  (newValue) {
                    setState(
                      () {
                        glutenFree = newValue;
                      },
                    );
                  },
                ),
                buildswitchlisttile(
                  'Lactose-free',
                  'only Include Lactose-free meals',
                  lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        lactoseFree = newValue;
                      },
                    );
                  },
                ),
                buildswitchlisttile(
                  'Vegetarian-free',
                  'only Include Vegetarian meals',
                  vegetarian,
                  (newValue) {
                    setState(
                      () {
                        vegetarian = newValue;
                      },
                    );
                  },
                ),
                buildswitchlisttile(
                  'Vegan-free',
                  'only Include Vegan meals',
                  vegan,
                  (newValue) {
                    setState(
                      () {
                        vegan = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
