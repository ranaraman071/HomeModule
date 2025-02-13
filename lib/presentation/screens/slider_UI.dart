import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/save_slider_bloc/saved_slider_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/save_slider_bloc/saved_slider_event.dart';
import 'package:score_bar_project/presentation/screens/thumb_class.dart';
import 'package:score_bar_project/presentation/widgets/common_text.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/value_bloc/value_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/value_bloc/value_event.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/value_bloc/value_state.dart';
import 'package:score_bar_project/presentation/screens/saved_score_srceen.dart';
import 'package:score_bar_project/presentation/themes/images.dart';
import 'package:score_bar_project/utils/navigator_services.dart';
import '../../data/providers/sliding_bar/bloc/slider_bloc.dart';
import '../../data/providers/sliding_bar/bloc/slider_event.dart';
import '../../data/providers/sliding_bar/bloc/slider_state.dart';

class SliderBlocUI extends StatefulWidget {
  const SliderBlocUI({super.key});

  @override
  State<SliderBlocUI> createState() => _SliderBlocUIState();
}

class _SliderBlocUIState extends State<SliderBlocUI> {
  @override
  void initState() {
    context.read<ValueBloc>().add(ChangeValEvent(0.8));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: BlocBuilder<SliderBloc, SliderState>(
          builder: (context, state) {
            final sliderValue = state is SliderUpdatedState ? state.value : 0.0;
            final label = state is SliderUpdatedState ? state.label : "Lacking";
            final isDragging = state is SliderUpdatedState ? state.isDragging : false;
            double screenWidth = MediaQuery.of(context).size.width;
            double sliderWidth = screenWidth * 0.9;
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: screenWidth * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: sliderWidth,
                          height: 40,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 24, right: 24, bottom: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(2, (index) {
                                    return Container(height: 30, width: 1.5, decoration: const BoxDecoration(color: Colors.black));
                                  }),
                                ),
                              ),
                              Positioned(
                                left: 23, right: 23, bottom: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(4, (index) {
                                    return Container(height: 10, width: 1.5, decoration: const BoxDecoration(color: Colors.black));
                                  }),
                                ),
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 1.5,
                                  trackShape: const RectangularSliderTrackShape(),
                                  activeTrackColor: Colors.black,
                                  inactiveTrackColor: Colors.black,
                                  thumbShape: CustomSliderThumb(displayValue: sliderValue, isDragging: isDragging),
                                  thumbColor: Colors.white,
                                  overlayColor: Colors.blue.withOpacity(0.2),
                                  showValueIndicator: ShowValueIndicator.never,
                                ),
                                child: Slider(
                                  min: 0.0,
                                  max: 5.0,
                                  value: sliderValue,
                                  divisions: 50,
                                  label: sliderValue.toStringAsFixed(1),
                                  onChangeStart: (_) {
                                    context.read<SliderBloc>().add(StartDraggingEvent());
                                  },
                                  onChangeEnd: (value) async {
                                    context.read<ValueBloc>().add(ChangeValEvent(double.parse(value.toStringAsFixed(1))));
                                    context.read<SliderBloc>().add(StopDraggingEvent());
                                  },
                                  onChanged: (value) {
                                    context.read<SliderBloc>().add(UpdateSliderEvent(value));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),
                        // Display Text depending on score
                        Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 120,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: CommonText(
                              text: label,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              fontStyle: label == "PERFECT" ? FontStyle.italic : FontStyle.normal),
                        ),
                        const SizedBox(height: 30),
                        // Buisiness name
                        SizedBox(
                          width: screenWidth * 0.82,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Image(image: AssetImage(AssetsPics.similar), height: 12),
                              const SizedBox(width: 15),
                              Expanded(child:
                                  BlocBuilder<ValueBloc, ValueState>(builder: (context, state1) {
                                    return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: state1.data.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              context.read<SavedSliderBloc>().add(UpdateSliderEventt(state1.value));
                                              NavigatorService().push(ScoreUpdatedScreen(name: state1.data[index]["Name"], scoreval: state1.value.toStringAsFixed(1),
                                                  BID: state1.data[index]["BID"]));
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              padding: const EdgeInsets.all(1.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: state1.data[index]["Name"],
                                                  style: TextStyle(fontSize: 13, color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                                                  children: <TextSpan>[
                                                    TextSpan(text: ", ${state1.value.toStringAsFixed(1)}", style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      );
                                    });
                                                                })),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
