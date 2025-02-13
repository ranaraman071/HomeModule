import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/save_slider_bloc/save_slider_state.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/save_slider_bloc/saved_slider_bloc.dart';
import 'package:score_bar_project/data/providers/sliding_bar/bloc/save_slider_bloc/saved_slider_event.dart';
import 'package:score_bar_project/presentation/widgets/common_text.dart';
import 'package:score_bar_project/presentation/themes/images.dart';
import 'package:score_bar_project/presentation/screens/thumb_class.dart';
import 'package:score_bar_project/utils/navigator_services.dart';

class ScoreUpdatedScreen extends StatefulWidget {
  ScoreUpdatedScreen({super.key, required this.name, required this.scoreval, required this.BID});

  String name;
  String scoreval;
  String BID;

  @override
  State<ScoreUpdatedScreen> createState() => _ScoreUpdatedScreenState();
}

class _ScoreUpdatedScreenState extends State<ScoreUpdatedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 35),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () {NavigatorService().pop();},
                      child: Container(color: Colors.transparent, child: const Icon(Icons.arrow_back, size: 35)))),
            ),
            Expanded(
              child: BlocBuilder<SavedSliderBloc, SavedSliderState>(
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
                        top: screenWidth * 0.46,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Buisiness name
                              SizedBox(
                                width: screenWidth * 0.82,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: widget.name,
                                        style: TextStyle(fontSize: 20, color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                          TextSpan(text: ", ${widget.scoreval}",
                                              style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              const SizedBox(height: 70),
                              // SLider
                              SizedBox(
                                width: sliderWidth,
                                height: 40,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      left: 24,
                                      right: 24,
                                      bottom: 5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(2, (index) {
                                          return Container(height: 30, width: 1.5, decoration: const BoxDecoration(color: Colors.black));
                                        }),
                                      ),
                                    ),
                                    Positioned(
                                      left: 23,
                                      right: 23,
                                      bottom: 10,
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
                                          context.read<SavedSliderBloc>().add(StartDraggingEventt());
                                        },
                                        onChangeEnd: (value) async {
                                          context.read<SavedSliderBloc>().add(StopDraggingEventt());
                                        },
                                        onChanged: (value) {
                                          context.read<SavedSliderBloc>().add(UpdateSliderEventt(value));
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
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        child: GestureDetector(
                          onTap: () async {
                            context.read<SavedSliderBloc>().add(
                                UpdateScoreDataEvent(context, sliderValue.toStringAsFixed(1), widget.BID, widget.scoreval));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(color: Colors.white, border: Border.all(), borderRadius: BorderRadius.circular(30)),
                            child: const Image(image: AssetImage(AssetsPics.save), height: 35),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
