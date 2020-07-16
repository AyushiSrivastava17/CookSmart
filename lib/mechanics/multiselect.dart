import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog({Key key, this.items, this.initialSelectedValues}) : super(key: key);

  final List<MultiSelectDialogItem<V>> items;
  final Set<V> initialSelectedValues;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Set<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onSubmitTap() {
    if (_selectedValues.contains(1) && _selectedValues.length > 1){
      _showDialog("Unclear on intolerances!", "You've selected None AND other food groups to avoid, please fix this first");
    } else {
      Navigator.pop(context, _selectedValues);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //backgroundColor: Colors.blue[400],
      title: Text('Select any allergies:', style: TextStyle(color: Color(0xFFA974F4))),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          textColor: Colors.indigo[400],
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK', style: TextStyle(color: Color(0xFFA974F4))),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
  
  void _showDialog(String mainTitle, String reminder) { // for empty health conditions set
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(mainTitle, 
           style: TextStyle(
            color: Hexcolor("#a974f4"),
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat"),
            textAlign: TextAlign.center,
          ),
          content: new Text(reminder, 
           style: TextStyle(
            color: Hexcolor("#a974f4"),
            fontSize: 20,
            fontFamily: "Montserrat"),
          textAlign: TextAlign.center,
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15)
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok", 
                style: TextStyle(
                  fontSize: 17
                )
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
