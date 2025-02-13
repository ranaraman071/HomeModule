import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/value_bloc/value_event.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/value_bloc/value_state.dart';
import 'package:score_bar_project/utils/database_services.dart';


class ValueBloc extends Bloc<ValueEvent, ValueState> {
  ValueBloc() : super(ValueState(value: 0.8, data: [])) {
    on<ChangeValEvent>(changeVal);
  }

  changeVal(ChangeValEvent event, Emitter<ValueState> emit) async {
    List<Map<String, dynamic>> result = await DatabaseHelper.fetchDataWithQuery(
        "SELECT td.Name, td.BID FROM td  JOIN R ON td.BID = R.BID WHERE R.score = ${event.value.toStringAsFixed(1)} LIMIT 3;");
    print("result-$result");
    print(event.value);
    emit(state.copyWith(value: event.value, data: result));
  }

  String getCommaSeparatedBIDs(List<Map<String, dynamic>> data) {
    return data.map((item) => item['BID'].toString()).join(',');
  }
}
