import 'package:flutter/material.dart';
import 'package:wmp/db_helper.dart';


class SearchBarWidget extends StatefulWidget {
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

    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _showSuggestions() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _hideSuggestions() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final double availableHeightBelow = MediaQuery.of(context).size.height - position.dy - renderBox.size.height;
    final double popupHeight = 200;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: renderBox.size.width,
          left: position.dx,
          top: availableHeightBelow >= popupHeight
              ? position.dy + renderBox.size.height + 5
              : position.dy - popupHeight - 5,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: const Offset(0, 0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: popupHeight),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredSuggestions[index]),
                      onTap: () {
                        _searchController.text = _filteredSuggestions[index];
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
        decoration: InputDecoration(
          hintText: "Search Your Costume Here",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.grey[200],
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
