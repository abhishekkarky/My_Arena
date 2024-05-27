import 'package:flutter/material.dart';

class HomeState {
  final int index;
  final List<Widget> lstWidget;

  HomeState({required this.index, required this.lstWidget});

  HomeState.initialState()
      : index = 0,
        lstWidget = [
          const Center(
            child: Text('data'),
          ),
          const Center(
            child: Text('data'),
          ),
          const Center(
            child: Text('data'),
          ),
          const Center(
            child: Text('data'),
          ),
        ];

  HomeState copyWith({
    int? index,
  }) {
    return HomeState(
      index: index ?? this.index,
      lstWidget: lstWidget,
    );
  }
}
