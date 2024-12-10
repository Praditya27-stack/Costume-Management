import 'package:flutter/material.dart';
import 'package:wmp/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:wmp/shared/theme/theme_notifier.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;

  const SearchBarWidget({Key? key, required this.onSearchChanged}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<String> _allSuggestions = [];
  List<String> _filteredSuggestions = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    final suggestions = await _dbHelper.fetchCostumes();
    setState(() {
      _allSuggestions = suggestions.map((e) => e['name'] as String).toList();
      _filteredSuggestions = _allSuggestions;
    });
  }

  void _filterSuggestions(String query) {
    setState(() {
      _filteredSuggestions = _allSuggestions
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });

    widget.onSearchChanged(query);

    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _showSuggestions() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
    }
  }

  void _hideSuggestions() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final double searchBarHeight = renderBox.size.height;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: renderBox.size.width,
          left: position.dx,
          top: position.dy + searchBarHeight + 8, // Add 8px margin to avoid overlap with search bar
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: const Offset(0, 0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredSuggestions[index]),
                      onTap: () {
                        _searchController.text = _filteredSuggestions[index];
                        widget.onSearchChanged(_filteredSuggestions[index]);
                        _hideSuggestions();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme from the provider
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkTheme;

    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          _filterSuggestions(value);
          if (value.isNotEmpty) {
            _showSuggestions();
          } else {
            _hideSuggestions();
          }
        },
        style: TextStyle(color: Colors.blue), // Change text color to blue
        decoration: InputDecoration(
          hintText: "Search Your Costume Here",
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blue, // Change icon color to blue
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: isDarkMode ? Colors.black : Colors.grey[200], // Set background color based on theme
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _hideSuggestions();
    super.dispose();
  }
}
