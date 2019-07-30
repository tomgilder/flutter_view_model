library view_model;

import 'package:flutter/widgets.dart';

class ViewModelProvider<TViewModel extends ViewModel> extends StatefulWidget {
  final TViewModel Function() createViewModel;
  final Widget Function(BuildContext, TViewModel) builder;

  ViewModelProvider(
      {@required this.createViewModel, @required this.builder, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewModelState<TViewModel>();
}

abstract class ViewModel {
  State _state;
  BuildContext get context => _state.context;

  void Function(void Function()) _setState;

  @protected
  void setState(void Function() fn) => _setState(fn);

  void dispose() {}

  static TViewModel of<TViewModel extends ViewModel>(BuildContext context) {
    assert(context != null);

    Type viewModelType<T>() => T;
    final Type type = viewModelType<_ViewModelInheritedWidget<TViewModel>>();
    final widget = context.inheritFromWidgetOfExactType(type)
        as _ViewModelInheritedWidget<TViewModel>;
    assert(widget != null);
    return widget.viewModel;
  }
}

class _ViewModelState<T extends ViewModel> extends State<ViewModelProvider<T>> {
  T _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = widget.createViewModel();
    assert(_viewModel != null);

    _viewModel._setState = setState;
    _viewModel._state = this;
  }

  @override
  Widget build(BuildContext context) {
    return _ViewModelInheritedWidget<T>(
        viewModel: _viewModel, child: widget.builder(context, _viewModel));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class _ViewModelInheritedWidget<T extends ViewModel> extends InheritedWidget {
  final T viewModel;

  _ViewModelInheritedWidget({@required Widget child, @required this.viewModel})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
