// File: flutter/qi_bus_prokit/lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/screen/QIBusSplash.dart';
import 'package:qi_bus_prokit/store/AppStore.dart';
import 'package:qi_bus_prokit/utils/AppTheme.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';


AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QI Bus ${!isMobile ? ' ${platformName()}' : ''}',
        home: QIBusSplash(),
        theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}

// File: flutter/qi_bus_prokit/lib/model/QiBusModel.dart
class QIBusBookingModel {
  var destination;
  var duration;
  var startTime;
  var totalTime;
  var endTime;
  var seatNo;
  var passengerName;
  var ticketNo;
  var pnrNo;
  var status;
  var totalFare;
  var img;

  QIBusBookingModel(this.destination, this.duration);

  QIBusBookingModel.booking(
      this.destination, this.duration, this.startTime, this.totalTime, this.endTime, this.seatNo, this.passengerName, this.ticketNo, this.pnrNo, this.status, this.totalFare, this.img);
}

class QIBusCardModel {
  var cardType;
  var cardBg;
  var txtDigit1;
  var txtDigit2;
  var txtDigit3;
  var txtDigit4;
  var mValidDate;
  var txtHolderName;

  QIBusCardModel(
    this.cardType,
    this.cardBg,
    this.txtDigit1,
    this.txtDigit2,
    this.txtDigit3,
    this.txtDigit4,
    this.mValidDate,
    this.txtHolderName,
  );
}

class QIBusDroppingModel {
  var travelName;
  var location;
  var duration;

  QIBusDroppingModel(this.travelName, this.location, this.duration);
}

class QIBusModel {
  var travelerName;
  var startTime;
  var mStartTimeAA;
  var endTime;
  var mEndTimeAA;
  var totalDuration;
  var hold;
  var typeCoach;
  var rate;
  var price;

  QIBusModel(this.travelerName, this.startTime, this.mStartTimeAA, this.endTime, this.mEndTimeAA, this.totalDuration, this.hold, this.typeCoach, this.rate, this.price);
}

class QIBusNewOfferModel {
  var useCode;
  var img;
  var color;

  QIBusNewOfferModel(this.useCode, this.img, this.color);
}

class QIBusNewPackageModel {
  var destination;
  var duration;
  var rating;
  var newPrice;
  var booking;
  var image;

  QIBusNewPackageModel(
    this.destination,
    this.duration,
    this.rating,
    this.newPrice,
    this.booking,
    this.image,
  );
}

enum QIBusSeatType { EMPTY, BOOKED, LADIES }

class QIBusSeatModel {
  var isSelected = false;
  var type1 = QIBusSeatType;
  var flag;

  QIBusSeatModel(QIBusSeatType type, this.flag);
}


// File: flutter/qi_bus_prokit/lib/utils/flutter_rating_bar.dart
import 'package:flutter/material.dart';

/// Defines widgets which are to used as rating bar items.
class RatingWidget {
  /// Defines widget to be used as rating bar item when the item is completely rated.
  final Widget full;

  /// Defines widget to be used as rating bar item when only the half portion of item is rated.
  final Widget half;

  /// Defines widget to be used as rating bar item when the item is unrated.
  final Widget empty;

  RatingWidget({
    required this.full,
    required this.half,
    required this.empty,
  });
}

class _HalfRatingWidget extends StatelessWidget {
  final Widget child;
  final double size;
  final bool enableMask;
  final bool rtlMode;
  final Color? unratedColor;

  _HalfRatingWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.rtlMode,
    required this.unratedColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: enableMask
          ? Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: _NoRatingWidget(
                    child: child,
                    size: size,
                    unratedColor: unratedColor,
                    enableMask: enableMask,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: ClipRect(
                    clipper: _HalfClipper(
                      rtlMode: rtlMode,
                    ),
                    child: child,
                  ),
                ),
              ],
            )
          : FittedBox(
              child: child,
              fit: BoxFit.contain,
            ),
    );
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  final bool rtlMode;

  _HalfClipper({
    required this.rtlMode,
  });

  @override
  Rect getClip(Size size) => rtlMode
      ? Rect.fromLTRB(
          size.width / 2,
          0.0,
          size.width,
          size.height,
        )
      : Rect.fromLTRB(
          0.0,
          0.0,
          size.width / 2,
          size.height,
        );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class _NoRatingWidget extends StatelessWidget {
  final double size;
  final Widget child;
  final bool enableMask;
  final Color? unratedColor;

  _NoRatingWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.unratedColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: enableMask
            ? _ColorFilter(
                color: unratedColor,
                child: child,
              )
            : child,
      ),
    );
  }
}

class _ColorFilter extends StatelessWidget {
  final Widget child;
  final Color? color;

  _ColorFilter({
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        color!,
        BlendMode.srcATop,
      ),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.white,
          BlendMode.srcATop,
        ),
        child: child,
      ),
    );
  }
}

class _IndicatorClipper extends CustomClipper<Rect> {
  final double? ratingFraction;
  final bool rtlMode;

  _IndicatorClipper({
    this.ratingFraction,
    this.rtlMode = false,
  });

  @override
  Rect getClip(Size size) => rtlMode
      ? Rect.fromLTRB(
          size.width - size.width * ratingFraction!,
          0.0,
          size.width,
          size.height,
        )
      : Rect.fromLTRB(
          0.0,
          0.0,
          size.width * ratingFraction!,
          size.height,
        );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

/// A widget to display rating as assigned using [rating] property.
///
/// It's a read only version of [RatingBar].
/// Use [RatingBar], if interative version is required. i.e. if user input is required.
class RatingBarIndicator extends StatefulWidget {
  /// Defines the rating value for indicator.
  ///
  /// Default = 0.0
  final double rating;

  /// {@macro flutterRatingBar.itemCount}
  final int itemCount;

  /// {@macro flutterRatingBar.itemSize}
  final double itemSize;

  /// {@macro flutterRatingBar.itemPadding}
  final EdgeInsets itemPadding;

  /// Controls the scrolling behaviour of rating bar.
  ///
  /// Default is [NeverScrollableScrollPhysics].
  final ScrollPhysics physics;

  /// {@macro flutterRatingBar.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutterRatingBar.itemBuilder}
  final IndexedWidgetBuilder itemBuilder;

  /// {@macro flutterRatingBar.direction}
  final Axis direction;

  /// {@macro flutterRatingBar.unratedColor}
  final Color? unratedColor;

  RatingBarIndicator({
    required this.itemBuilder,
    this.rating = 0.0,
    this.itemCount = 5,
    this.itemSize = 40.0,
    this.itemPadding = const EdgeInsets.all(0.0),
    this.physics = const NeverScrollableScrollPhysics(),
    this.textDirection,
    this.direction = Axis.horizontal,
    this.unratedColor,
  });

  @override
  _RatingBarIndicatorState createState() => _RatingBarIndicatorState();
}

class _RatingBarIndicatorState extends State<RatingBarIndicator> {
  double _ratingFraction = 0.0;
  int _ratingNumber = 0;
  bool _isRTL = false;

  @override
  void initState() {
    super.initState();
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
  }

  @override
  Widget build(BuildContext context) {
    _isRTL = (widget.textDirection ?? Directionality.of(context)) == TextDirection.rtl;
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
    return SingleChildScrollView(
      scrollDirection: widget.direction,
      physics: widget.physics,
      child: widget.direction == Axis.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: _isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: _children(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              textDirection: _isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: _children(),
            ),
    );
  }

  List<Widget> _children() {
    return List.generate(
      widget.itemCount,
      (index) {
        if (widget.textDirection != null) {
          if (widget.textDirection == TextDirection.rtl && Directionality.of(context) != TextDirection.rtl) {
            return Transform(
              transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
              alignment: Alignment.center,
              transformHitTests: false,
              child: _buildItems(index),
            );
          }
        }
        return _buildItems(index);
      },
    );
  }

  Widget _buildItems(int index) => Padding(
        padding: widget.itemPadding,
        child: SizedBox(
          width: widget.itemSize,
          height: widget.itemSize,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: index + 1 < _ratingNumber
                    ? widget.itemBuilder(context, index)
                    : _ColorFilter(
                        color: widget.unratedColor ?? Colors.grey[200],
                        child: widget.itemBuilder(context, index),
                      ),
              ),
              if (index + 1 == _ratingNumber)
                _isRTL
                    ? FittedBox(
                        fit: BoxFit.contain,
                        child: ClipRect(
                          clipper: _IndicatorClipper(
                            ratingFraction: _ratingFraction,
                            rtlMode: _isRTL,
                          ),
                          child: widget.itemBuilder(context, index),
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.contain,
                        child: ClipRect(
                          clipper: _IndicatorClipper(
                            ratingFraction: _ratingFraction,
                          ),
                          child: widget.itemBuilder(context, index),
                        ),
                      ),
            ],
          ),
        ),
      );
}

/// A widget to receive rating input from users.
///
/// [RatingBar] can also be used to display rating
///
/// Prefer using [RatingBarIndicator] instead, if read only version is required.
/// As RatingBarIndicator supports any fractional rating value.
class RatingBar extends StatefulWidget {
  /// {@template flutterRatingBar.itemCount}
  /// Defines total number of rating bar items.
  ///
  /// Default = 5
  /// {@endtemplate}
  final int itemCount;

  /// Defines the initial rating to be set to the rating bar.
  final double? initialRating;

  /// Return current rating whenever rating is updated.
  final ValueChanged<double> onRatingUpdate;

  /// {@template flutterRatingBar.itemSize}
  /// Defines width and height of each rating item in the bar.
  ///
  /// Default = 40.0
  /// {@endtemplate}
  final double itemSize;

  /// Default [allowHalfRating] = false. Setting true enables half rating support.
  final bool allowHalfRating;

  /// {@template flutterRatingBar.itemPadding}
  /// The amount of space by which to inset each rating item.
  /// {@endtemplate}
  final EdgeInsets itemPadding;

  /// if set to true, will disable any gestures over the rating bar.
  ///
  /// Default = false
  final bool ignoreGestures;

  /// if set to true will disable drag to rate feature. Note: Enabling this mode will disable half rating capability.
  ///
  /// Default = false
  final bool tapOnlyMode;

  /// {@template flutterRatingBar.textDirection}
  /// The text flows from right to left if [textDirection] = TextDirection.rtl
  /// {@endtemplate}
  final TextDirection? textDirection;

  /// {@template flutterRatingBar.itemBuilder}
  /// Widget for each rating bar item.
  /// {@endtemplate}
  final IndexedWidgetBuilder? itemBuilder;

  /// Customizes the Rating Bar item with [RatingWidget].
  final RatingWidget? ratingWidget;

  /// if set to true, Rating Bar item will glow when being touched.
  ///
  /// Default = true
  final bool glow;

  /// Defines the radius of glow.
  ///
  /// Default = 2
  final double glowRadius;

  /// Defines color for glow.
  ///
  /// Default = theme's accent color
  final Color? glowColor;

  /// {@template flutterRatingBar.direction}
  /// Direction of rating bar.
  ///
  /// Default = Axis.horizontal
  /// {@endtemplate}
  final Axis direction;

  /// {@template flutterRatingBar.unratedColor}
  /// Defines color for the unrated portion.
  ///
  /// Default = Colors.grey[200]
  /// {@endtemplate}
  final Color? unratedColor;

  /// Sets minimum rating
  ///
  /// Default = 0
  final double minRating;

  /// Sets maximum rating
  ///
  /// Default = [itemCount]
  final double? maxRating;

  RatingBar({
    this.itemCount = 5,
    this.initialRating = 0.0,
    required this.onRatingUpdate,
    this.itemSize = 40.0,
    this.allowHalfRating = false,
    this.itemBuilder,
    this.itemPadding = const EdgeInsets.all(0.0),
    this.ignoreGestures = false,
    this.tapOnlyMode = false,
    this.textDirection,
    this.ratingWidget,
    this.glow = true,
    this.glowRadius = 2,
    this.direction = Axis.horizontal,
    this.glowColor,
    this.unratedColor,
    this.minRating = 0,
    this.maxRating,
  }) : assert(
          (itemBuilder == null && ratingWidget != null) || (itemBuilder != null && ratingWidget == null),
          'itemBuilder and ratingWidget can\'t be initialized at the same time.'
          'Either remove ratingWidget or itembuilder.',
        );

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double? _rating = 0.0;

  //double _ratingHistory = 0.0;
  double iconRating = 0.0;
  double? _minRating, _maxrating;
  bool _isRTL = false;
  ValueNotifier<bool> _glow = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _minRating = widget.minRating;
    _maxrating = widget.maxRating ?? widget.itemCount.toDouble();
    _rating = widget.initialRating;
  }

  @override
  void didUpdateWidget(RatingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      _rating = widget.initialRating;
    }
    _minRating = widget.minRating;
    _maxrating = widget.maxRating ?? widget.itemCount.toDouble();
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isRTL = (widget.textDirection ?? Directionality.of(context)) == TextDirection.rtl;
    iconRating = 0.0;
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        textDirection: _isRTL ? TextDirection.rtl : TextDirection.ltr,
        direction: widget.direction,
        children: List.generate(
          widget.itemCount,
          (index) => _buildRating(context, index),
        ),
      ),
    );
  }

  Widget _buildRating(BuildContext context, int index) {
    Widget ratingWidget;
    if (index >= _rating!) {
      ratingWidget = _NoRatingWidget(
        size: widget.itemSize,
        child: widget.ratingWidget?.empty ?? widget.itemBuilder!(context, index),
        enableMask: widget.ratingWidget == null,
        unratedColor: widget.unratedColor ?? Colors.grey[200],
      );
    } else if (index >= _rating! - (widget.allowHalfRating ? 0.5 : 1.0) && index < _rating! && widget.allowHalfRating) {
      if (widget.ratingWidget?.half == null) {
        ratingWidget = _HalfRatingWidget(
          size: widget.itemSize,
          child: widget.itemBuilder!(context, index),
          enableMask: widget.ratingWidget == null,
          rtlMode: _isRTL,
          unratedColor: widget.unratedColor ?? Colors.grey[200],
        );
      } else {
        ratingWidget = SizedBox(
          width: widget.itemSize,
          height: widget.itemSize,
          child: FittedBox(
            fit: BoxFit.contain,
            child: _isRTL
                ? Transform(
                    transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    alignment: Alignment.center,
                    transformHitTests: false,
                    child: widget.ratingWidget!.half,
                  )
                : widget.ratingWidget!.half,
          ),
        );
      }
      iconRating += 0.5;
    } else {
      ratingWidget = SizedBox(
        width: widget.itemSize,
        height: widget.itemSize,
        child: FittedBox(
          fit: BoxFit.contain,
          child: widget.ratingWidget?.full ?? widget.itemBuilder!(context, index),
        ),
      );
      iconRating += 1.0;
    }

    return IgnorePointer(
      ignoring: widget.ignoreGestures,
      child: GestureDetector(
        onTap: () {
          widget.onRatingUpdate(index + 1.0);
          setState(() {
            _rating = index + 1.0;
          });
        },
        onHorizontalDragStart: _isHorizontal ? (_) => _glow.value = true : null,
        onHorizontalDragEnd: _isHorizontal
            ? (_) {
                _glow.value = false;
                widget.onRatingUpdate(iconRating);
                iconRating = 0.0;
              }
            : null,
        onHorizontalDragUpdate: _isHorizontal ? (dragUpdates) => _dragOperation(dragUpdates, widget.direction) : null,
        onVerticalDragStart: _isHorizontal ? null : (_) => _glow.value = true,
        onVerticalDragEnd: _isHorizontal
            ? null
            : (_) {
                _glow.value = false;
                widget.onRatingUpdate(iconRating);
                iconRating = 0.0;
              },
        onVerticalDragUpdate: _isHorizontal ? null : (dragUpdates) => _dragOperation(dragUpdates, widget.direction),
        child: Padding(
          padding: widget.itemPadding,
          child: ValueListenableBuilder(
            valueListenable: _glow,
            builder: (context, dynamic glow, _) {
              if (glow && widget.glow) {
                Color glowColor = widget.glowColor ?? Theme.of(context).colorScheme.secondary;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withAlpha(30),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                      BoxShadow(
                        color: glowColor.withAlpha(20),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                    ],
                  ),
                  child: ratingWidget,
                );
              } else {
                return ratingWidget;
              }
            },
          ),
        ),
      ),
    );
  }

  bool get _isHorizontal => widget.direction == Axis.horizontal;

  void _dragOperation(DragUpdateDetails dragDetails, Axis direction) {
    if (!widget.tapOnlyMode) {
      RenderBox box = context.findRenderObject() as RenderBox;
      var _pos = box.globalToLocal(dragDetails.globalPosition);
      double i;
      if (direction == Axis.horizontal) {
        i = _pos.dx / (widget.itemSize + widget.itemPadding.horizontal);
      } else {
        i = _pos.dy / (widget.itemSize + widget.itemPadding.vertical);
      }
      var currentRating = widget.allowHalfRating ? i : i.round().toDouble();
      if (currentRating > widget.itemCount) {
        currentRating = widget.itemCount.toDouble();
      }
      if (currentRating < 0) {
        currentRating = 0.0;
      }
      if (_isRTL && widget.direction == Axis.horizontal) {
        currentRating = widget.itemCount - currentRating;
      }
      if (currentRating < _minRating!) {
        _rating = _minRating;
      } else if (currentRating > _maxrating!) {
        _rating = _maxrating;
      } else {
        _rating = currentRating;
      }
      setState(() {});
    }
  }
}


// File: flutter/qi_bus_prokit/lib/utils/QiBusDataGenerator.dart


import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';

import 'QiBusColors.dart';
import 'QiBusImages.dart';
import 'QiBusStrings.dart';

// ignore: non_constant_identifier_names
List<QIBusBookingModel> QIBusGetData() {
  List<QIBusBookingModel> mRecentSearchList = [];
  mRecentSearchList.add(new QIBusBookingModel(QIBus_lbl_DelhiToMubai, QIBus_lbl_date));
  mRecentSearchList.add(new QIBusBookingModel(QIBus_lbl_MumbaiToPune, QIBus_lbl_date));
  mRecentSearchList.add(new QIBusBookingModel(QIBus_lbl_AhmedabadToMumbai, QIBus_lbl_date));
  mRecentSearchList.add(new QIBusBookingModel(QIBus_lbl_JaipurToNewDelhi, QIBus_lbl_date));
  mRecentSearchList.add(new QIBusBookingModel(QIBus_lbl_MumbaiToSurat, QIBus_lbl_date));
  mRecentSearchList.add(new QIBusBookingModel(QIBus_lbl_DelhiToMubai, QIBus_lbl_date));
  mRecentSearchList.add(new QIBusBookingModel(QIBus_lbl_MumbaiToSurat, QIBus_lbl_date));
  return mRecentSearchList;
}

// ignore: non_constant_identifier_names
List<QIBusNewOfferModel> QIBusGetOffer() {
  List<QIBusNewOfferModel> mNewOfferList = [];
  mNewOfferList.add(new QIBusNewOfferModel(QIBus_lbl_offer1, qibus_ic_sale_1, qIBus_darkBlue));
  mNewOfferList.add(new QIBusNewOfferModel(QIBus_lbl_offer2, qibus_ic_sale_2, qIBus_purple));
  mNewOfferList.add(new QIBusNewOfferModel(QIBus_lbl_offer1, qibus_ic_sale_1, qIBus_darkGreen));
  mNewOfferList.add(new QIBusNewOfferModel(QIBus_lbl_offer2, qibus_ic_sale_2, qIBus_darkBlue));
  mNewOfferList.add(new QIBusNewOfferModel(QIBus_lbl_offer1, qibus_ic_sale_1, qIBus_purple));
  return mNewOfferList;
}

// ignore: non_constant_identifier_names
List<QIBusBookingModel> QIBusGetBook() {
  List<QIBusBookingModel> mBookList = [];
  mBookList.add(QIBusBookingModel.booking(QIBus_lbl_DelhiToMubai, QIBus_lbl_booking_date1, QIBus_lbl_booking_starttime1, QIBus_lbl_booking_totaltime1, QIBus_lbl_booking_endtime1,
      QIBus_lbl_booking_SeatNo1, QIBus_lbl_booking_passenger_name1, QIBus_lbl_booking_ticketno1, QIBus_lbl_booking_pnr1, QIBus_lbl_booking_totalfare1, QIBus_text_confirmed, qibus_ic_completed));
  mBookList.add(QIBusBookingModel.booking(QIBus_lbl_MumbaiToPune, QIBus_lbl_booking_date2, QIBus_lbl_booking_starttime2, QIBus_lbl_booking_totaltime1, QIBus_lbl_booking_endtime2,
      QIBus_lbl_booking_SeatNo1, QIBus_lbl_booking_passenger_name1, QIBus_lbl_booking_ticketno2, QIBus_lbl_booking_pnr21, QIBus_lbl_booking_totalfare2, QIBus_text_confirmed, qibus_ic_completed));
  return mBookList;
}

// ignore: non_constant_identifier_names
List<QIBusBookingModel> QIBusGetCancelBook() {
  List<QIBusBookingModel> mCancelList = [];
  mCancelList.add(QIBusBookingModel.booking(QIBus_lbl_MumbaiToPune, QIBus_lbl_booking_date1, QIBus_lbl_booking_starttime1, QIBus_lbl_booking_totaltime1, QIBus_lbl_booking_endtime1,
      QIBus_lbl_booking_SeatNo1, QIBus_lbl_booking_passenger_name1, QIBus_lbl_booking_ticketno1, QIBus_lbl_booking_pnr1, QIBus_lbl_booking_totalfare1, QIBus_txt_cancelled, qibus_ic_canceled));
  return mCancelList;
}

// ignore: non_constant_identifier_names
List<QIBusModel> QIBusGetBusList() {
  List<QIBusModel> mBusList = [];
  mBusList.add(QIBusModel(
      QIBus_lbl_travel_name, QIBus_lbl_booking_starttime1, QIBus_text_am, QIBus_lbl_booking_endtime1, QIBus_text_pm, QIBus_lbl_totalDuration, QIBus_lbl_hold, QIBus_lbl_type1, 3, QIBus_lbl_price1));
  mBusList.add(QIBusModel(
      QIBus_lbl_travel_name, QIBus_lbl_booking_starttime1, QIBus_text_am, QIBus_lbl_booking_endtime1, QIBus_text_pm, QIBus_lbl_totalDuration, QIBus_lbl_hold, QIBus_lbl_type1, 3, QIBus_lbl_price2));
  mBusList.add(QIBusModel(
      QIBus_lbl_travel_name, QIBus_lbl_booking_starttime1, QIBus_text_am, QIBus_lbl_booking_endtime1, QIBus_text_pm, QIBus_lbl_totalDuration, QIBus_lbl_hold, QIBus_lbl_type2, 3, QIBus_lbl_price1));
  return mBusList;
}

// ignore: non_constant_identifier_names
List<QIBusBookingModel> QIBusGetNotification() {
  List<QIBusBookingModel> mNotificationList = [];
  mNotificationList.add(QIBusBookingModel.booking(QIBus_lbl_DelhiToMubai, QIBus_lbl_booking_duration1, QIBus_lbl_booking_starttime1, QIBus_lbl_booking_totaltime1, QIBus_lbl_booking_endtime1,
      QIBus_lbl_booking_SeatNo1, QIBus_lbl_booking_passenger_name1, QIBus_lbl_booking_ticketno1, QIBus_lbl_booking_pnr1, QIBus_lbl_booking_totalfare1, QIBus_text_confirmed, qibus_ic_completed));
  mNotificationList.add(QIBusBookingModel.booking(QIBus_lbl_MumbaiToPune, QIBus_lbl_booking_duration2, QIBus_lbl_booking_starttime2, QIBus_lbl_booking_totaltime1, QIBus_lbl_booking_endtime2,
      QIBus_lbl_booking_SeatNo1, QIBus_lbl_booking_passenger_name1, QIBus_lbl_booking_ticketno2, QIBus_lbl_booking_pnr21, QIBus_lbl_booking_totalfare2, QIBus_text_confirmed, qibus_ic_completed));
  return mNotificationList;
}

// ignore: non_constant_identifier_names
List<QIBusSeatModel> QIBusSeat() {
  List<QIBusSeatModel> mNotificationList = [];
  for (int i = 0; i <= 5; i++) {
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.BOOKED, 2));
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.EMPTY, 1));
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.EMPTY, 1));
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.LADIES, 3));
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.EMPTY, 1));
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.EMPTY, 1));
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.EMPTY, 1));
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.EMPTY, 1));
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.EMPTY, 1));
    mNotificationList.add(QIBusSeatModel(QIBusSeatType.EMPTY, 1));
  }
  return mNotificationList;
}

// ignore: non_constant_identifier_names
List<QIBusCardModel> QIBusGetCards() {
  List<QIBusCardModel> mCardList = [];
  mCardList.add(QIBusCardModel(
      QIBus_lbl_card_type2, qibus_ic_card, QIBus_lbl_card_digit1, QIBus_lbl_card_digit2, QIBus_lbl_card_digit3, QIBus_lbl_card_digit4, QIBus_lbl_card_validdate1, QIBus_lbl_booking_passenger_name1));
  mCardList.add(QIBusCardModel(
      QIBus_lbl_card_type2, qibus_ic_card3, QIBus_lbl_card_digit2, QIBus_lbl_card_digit4, QIBus_lbl_card_digit1, QIBus_lbl_card_digit3, QIBus_lbl_card_validdate1, QIBus_lbl_booking_passenger_name1));
  return mCardList;
}

// ignore: non_constant_identifier_names
List<QIBusCardModel> QIBusGetPayment() {
  List<QIBusCardModel> mCardList = [];
  mCardList.add(QIBusCardModel(
      QIBus_lbl_card_type2, qibus_ic_card3, QIBus_lbl_card_digit2, QIBus_lbl_card_digit4, QIBus_lbl_card_digit1, QIBus_lbl_card_digit3, QIBus_lbl_card_validdate1, QIBus_lbl_booking_passenger_name1));
  return mCardList;
}

// ignore: non_constant_identifier_names
List<QIBusDroppingModel> QIBusGetPickUp() {
  List<QIBusDroppingModel> mPickUpList = [];
  mPickUpList.add(QIBusDroppingModel(QIBus_lbl_pickup1, QIBus_lbl_location1, QIBus_lbl_duration1));
  mPickUpList.add(QIBusDroppingModel(QIBus_lbl_pickup2, QIBus_lbl_location1, QIBus_lbl_duration1));
  return mPickUpList;
}

// ignore: non_constant_identifier_names
List<QIBusDroppingModel> QIBusGetDroppingPoint() {
  List<QIBusDroppingModel> mDroppingList = [];
  mDroppingList.add(QIBusDroppingModel(QIBus_lbl_dropping1, QIBus_lbl_location1, QIBus_lbl_duration1));
  mDroppingList.add(QIBusDroppingModel(QIBus_lbl_dropping2, QIBus_lbl_location1, QIBus_lbl_duration1));
  return mDroppingList;
}

// ignore: non_constant_identifier_names
List<QIBusNewPackageModel> QIBusGetPackage() {
  List<QIBusNewPackageModel> mPackageList = [];
  mPackageList.add(QIBusNewPackageModel(QIBus_lbl_goa, QIBus_lbl_package_duration1, QIBus_lbl_package_rate1, QIBus_lbl_package_price1, QIBus_lbl_package_booking1, qibus_ic_goa));
  mPackageList.add(QIBusNewPackageModel(QIBus_lbl_amritsar, QIBus_lbl_package_duration2, QIBus_lbl_package_rate3, QIBus_lbl_package_price2, QIBus_lbl_package_bookin2, qibus_ic_amritsar));
  mPackageList.add(QIBusNewPackageModel(QIBus_lbl_andaman, QIBus_lbl_package_duration3, QIBus_lbl_package_rate5, QIBus_lbl_package_price3, QIBus_lbl_package_booking3, qibus_ic_andamans));
  mPackageList.add(QIBusNewPackageModel(QIBus_lbl_delhi, QIBus_lbl_package_duration1, QIBus_lbl_package_rate4, QIBus_lbl_package_price4, QIBus_lbl_package_booking1, qibus_ic_delhi));
  mPackageList.add(QIBusNewPackageModel(QIBus_lbl_shimla, QIBus_lbl_package_duration1, QIBus_lbl_package_rate4, QIBus_lbl_package_price5, QIBus_lbl_package_bookin2, qibus_ic_temp));
  mPackageList.add(QIBusNewPackageModel(QIBus_lbl_udaipur, QIBus_lbl_package_duration2, QIBus_lbl_package_rate5, QIBus_lbl_package_price1, QIBus_lbl_package_booking1, qibus_ic_udaipur));
  return mPackageList;
}

// ignore: non_constant_identifier_names
List<QIBusNewPackageModel> QIBusGetPackageList() {
  List<QIBusNewPackageModel> mPackageList = [];
  mPackageList.add(QIBusNewPackageModel(QIBus_lbl_amritsar, QIBus_lbl_package_duration2, QIBus_lbl_package_rate3, QIBus_lbl_package_price2, QIBus_lbl_package_bookin2, qibus_ic_amritsar));
  mPackageList.add(QIBusNewPackageModel(QIBus_lbl_delhi, QIBus_lbl_package_duration1, QIBus_lbl_package_rate4, QIBus_lbl_package_price4, QIBus_lbl_package_booking1, qibus_ic_delhi));
  mPackageList.add(QIBusNewPackageModel(QIBus_lbl_udaipur, QIBus_lbl_package_duration2, QIBus_lbl_package_rate5, QIBus_lbl_package_price1, QIBus_lbl_package_booking1, qibus_ic_udaipur));
  return mPackageList;
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'images/flag/ic_us.png'),
    LanguageDataModel(id: 2, name: 'Hindi', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: 'images/flag/ic_hi.png'),
    LanguageDataModel(id: 3, name: 'Arabic', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: 'images/flag/ic_ar.png'),
    LanguageDataModel(id: 4, name: 'French', languageCode: 'fr', fullLanguageCode: 'fr-FR', flag: 'images/flag/ic_fr.png'),
  ];
}


// File: flutter/qi_bus_prokit/lib/utils/AppConstant.dart


const fontMedium = 'Medium';
const fontSemibold = 'Semibold';

/* font sizes*/
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;

const BaseUrl = 'https://assets.iqonic.design/old-themeforest-images/prokit';




// File: flutter/qi_bus_prokit/lib/utils/QiBusStrings.dart
const app_name = "QIBus";
const QIBus_txt_high_hill_manali = "High Hill Manali";
const QIBus_txt_4_days_3_nights = "4 Days 3 Nights";
const QIBus_txt_new_package = "New Packages";
const QIBus__500 = "<strike>\$ 500</strike>";
const QIBus_txt_03_bus_available = "4 Bus Available";
const QIBus_text_seat = "Seat";
const QIBus_lbl_bus_tpe = "Bus Type";
const QIBus_msg_share_app = "Hey check out my app at: https://play.google.com/store/apps/developer?id=TWOWORDS";
const QIBus_send_to = "Share using";
const QIBus_txtYourCode = "Your code:";
const QIBus_txtTotalEarning = "Total Earning";
const QIBus_txt_your_link = "Your Link :";
const QIBus_text_get_100_when_your_friend_complete_trip_with_us = "Get \$100 when your friend completes a trip with us";
const QIBus_hint_enter_your_contact_number = "Enter Contact Number";
const QIBus_lbl_email = "Email :";
const QIBus_lbl_apply = "Apply";
const QIBus_txt_email_id = "John@gmail.com";
const QIBus_lbl_wallet = "Refer friends, Earn wallet money";
const QIBus_lbl_your_wallet_in_balance = "Your Balance in the wallet";
const QIBus_txt_visa = "VISA";
const QIBus_title_price = "Price";
const QIBus_text_confirmed = "Confirmed";
const QIBus_text_destination = "Ahmedabad (Guj) To High Hill,Manali";
const QIBus_hint_from_city = "From City";
const QIBus_hint_to_city = "To City";
const QIBus_txt_view_all = "View all";
const QIBus_txt_new_offers = "New Offers";
const QIBus_txt_popular_package = "Popular Packages";
const QIBus_title_email_notification_settings = "Email Notification Settings";
const QIBus_txt_email_notification = "Email Notification";
const QIBus_lbl_contact_number_settings = "Contact Number Notification Settings";
const QIBus_lbl_mobile_no = "Mobile No :";
const QIBus_lbl_number_notification = "Number Notification";
const QIBus_title_language_setting = "Language Settings";
const QIBus_lbl_language = "Language :";
const QIBus_txt_english_us = "English-US";
const QIBus_lbl_first_name = "First Name :";
const QIBus_lbl_last_name = "Last Name :";
const QIBus_lbl_gender = "Gender :";
const QIBus_title_edit_your_name = "Edit Your Name";
const QIBus_title_edit_your_contact = "Edit Your Contact";
const QIBus_lbl_total_fare = "Total Fare";
const QIBus_lbl_pnr_no = "PNR No";
const QIBus_txt_busTime = "18:00";
const QIBus_txt_time = "8:00";
const QIBus_txt_date = "28-May-2019";
const QIBus_title_toolbar_cards = "Cards";
const QIBus_hint_enter_your_emailId = "Enter Your Email Id";
const QIBus_txt_samay_travel_main_office = "Samay Travel Main Office";
const QIBus_txt_near_alim_chowk_manali = "Near Alim Chowk,Manali";
const QIBus_txt_ticket_no = "Ticket No";
const QIBus_msg_email_required = "Email required";
const QIBus_msg_email_valid = "Enter Valid Email";
const QIBus_msg_first_name = "First name required";
const QIBus_msg_last_name = "Last name required";
const QIBus_msg_mobile_number = "Mobile number required";
const QIBus_msg_email_id = "Email Id required";

const QIBus_hint_email = "Enter Email ID";
const QIBus_ahmedabad_guj_high_hill_manali = "Ahmedabad(Guj)- High Hill,Manali,Gujarat India";
const QIBus_volvo_bus = "Volvo Bus";
const QIBus_txtCancelled = "Cancelled";
const QIBus_txtColon = ":";
const QIBus_search = "Search";
const QIBus_lbl_special = "SPECIAL";
const QIBus_lbl_use_code = "Use Code:";
const QIBus_lbl_notification = "Notification";
const QIBus_lbl_verification = "Enter your verification code \n we have just sent you on your mobile number";
const QIBus_txt_verify = "Verify";
const QIBus_txt_Resend = "Re-send";
const QIBus_lbl_StarRatings = "Star Ratings";

const QIBus_txt_BusType = "Bus Type";
const QIBus_lbl_Apply = "Apply";
const QIBus_text_welcome_to = "Welcome to";
const QIBus_text_qibus = "QIBUS";
const QIBus_hint_mobile = "Enter Mobile Number";
const QIBus_lbl_continue = "Continue";
const QIBus_text_sign_In_with = "Sign In With";
const QIBus_verification = "Verification";
const QIBus_lbl_refer_and_earn = "Refer & Earn";
const QIBus_lbl_edit_profile = "Edit Profile";
const QIBus_lbl_profile_settings = "Edit Profile";
const QIBus_lbl__wallet = "Wallet";
const QIBus_lbl_cards = "Cards";
const QIBus_lbl_help = "Help & Support";
const QIBus_lbl_2342340 = "2342340";
const QIBus_lbl_submit = "Submit";
const QIBus_home = "Home";
const QIBus_text_book_now = "Book Now";
const QIBus_text_contact_information = "Contact Information";
const QIBus_text_phone = "Phone :";
const QIBus_txt_passenger = "Passenger: ";
const QIBus_hint_enter_name = "Enter Name";
const QIBus_hint_enter_age = "Enter Age";
const QIBus_hint_card_number = "card Number";
const QIBus__200 = "\$200.00";
const QIBus_1 = "1";
const QIBus_text_select_month = "Month";
const QIBus_text_select_year = "Year";
const QIBus_text_card_holder_name = "card Holder Name";
const QIBus_text_valid = "Valid";
const QIBus_lbl_ac = "AC";
const QIBus_lbl_non_ac = "NON-AC";
const QIBus_lbl_sleeper = "SLEEPER";
const QIBus_lbl_seater = "SEATER";
const QIBus_lbl_normal = "Normal";
const QIBus_lbl_payment = "Payment";
const QIBus_txt_cancelled = "Cancelled";
const QIBus_text_available = "Available";
const QIBus_text_booked = "Booked";
const QIBus_text_pickup_point = "Pickup point";
const QIBus_text_dropping_points = "Dropping point";
const QIBus_text_selected = "Selected";
const QIBus_lbl_35 = "\$35";
const QIBus_smith_travels = "Smith travels";
const QIBus_text_net_banking = "Net Banking";
const QIBus_text_offers = "Offers";
const QIBus_text_credit_card = "Credit card";
const QIBus_text_debit = "Debit Cart";
const QIBus_text_Mobilewallet = "Mobile Wallet";
const QIBus_text_bus_list = "Buses";
const QIBus_hint_enter_first_name = "Enter First Name";
const QIBus_hint_enter_last_name = "Enter Last Name";
const QIBus_text_save = "Save";
const QIBus_text_ticket_book = "Pay Now";
const QIBus_text_total_amount = "Total Amount";
const QIBus_txt_copy = "Copied";
const QIBus_text_offer_code = "Offer Code";
const QIBus_text_package = "Package";
const QIBus_msg_from = "From city required";
const QIBus_msg_to = "To city required";
const QIBus_msg_name = "Name required";
const QIBus_ms_age = "Age required";
const QIBus_msg_digit = "card Number required";
const QIBus_msg_code = "Code required";
const QIBus_msg_holder_name = "Holder Name required";
const QIBus_text_hour = "Hour";
const QIBus_rs = "\$ ";
const QIBus_text_link = "www.bus.com/refer/234556F";
const QIBus_text_remove = "Item was removed from the list.";
const QIBus_text_undo = "UNDO";
const QIBus_title_add_new_card = "Add new card";
const QIBus_title_wallet = "Wallet";
const QIBus_text_trending_packages = "Trending Packages";
const QIBus_text_description = "Description";
const QIBus_text_upper = "Upper";
const QIBus_text_lower = "Lower";
const QIBus_text_ladies = "Ladies";
const QIBus_text_logout = "Logout";
const QIBus_text_100 = "0";
const QIBus_text_500 = "\$500";
const QIBus_msg_saved = "Saved";
const QIBus_text_confirmation = "Confirmation!";
const QIBus_msg_logout = "Are you sure, you want to logout?";
const QIBus_text_yes = "Yes";
const QIBus_text_no = "No";
const QIBus_text_total_seat = "Total Seat:";
const QIBus_text_cvv = "CVV";
const QIBus_text_seat_no = "Seat No";
const QIBus__5 = "/5";
const QIBus_text_5 = "5";
const QIBus_text_add_card = "Add card";
const QIBus_text_settings = "Settings";
const QIBus_text_select_bus = "Select Seat";
const QIBus_text_hold = "Hold";
const QIBus_text_ticket_price = "Ticket Price :";
const QIBus_text_tax = "Tax :";
const QIBus_text_5txt = "\$5";
const QIBus_text_total_price = "Total:";
const QIBus_text__2 = "2";
const QIBus_text_mobile = "+91 9988998899";
const QIBus_text_duration = "Duration";
const QIBus_text_payment = "Payment";
const QIBus_text_done = "Done";
const QIBus_text_payment_success = "Payment Success !";
const QIBus_text_close = "Close";
const QIBus_text_card_add = "card Added";
const QIBus_msg_success = "Thank you for booking. Enjoy your trip";
const QIBus_text_recent_search = "Recent Search";
const QIBus_text_am = "AM";
const QIBus_text_pm = "PM";
const QIBus_text_city = "Holds";
const QIBus_lbl_pickup1 = "Pickup 1";
const QIBus_lbl_location1 = "Landmark";
const QIBus_lbl_duration1 = "23:20";
const QIBus_lbl_pickup2 = "Pickup 2";
const QIBus_lbl_dropping1 = "Dropping 1";
const QIBus_lbl_dropping2 = "Dropping 2";
const QIBus_lbl_offer1 = "SUPERTRIP";
const QIBus_lbl_offer2 = "SPECIAL";
const QIBus_lbl_DelhiToMubai = "New Delhi To Mumbai";
const QIBus_lbl_MumbaiToPune = "Mumbai To Pune";
const QIBus_lbl_AhmedabadToMumbai = "Ahmedabad To Mumbai";
const QIBus_lbl_JaipurToNewDelhi = "Jaipur To New Delhi";
const QIBus_lbl_MumbaiToSurat = "Mumbai to Surat";
const QIBus_lbl_date = "28-05-2019";
const QIBus_lbl_mumbai = "Mumbai";
const QIBus_lbl_surat = "Surat";
const QIBus_lbl_delhi = "Delhi";
const QIBus_lbl_pune = "Pune";
const QIBus_lbl_booking = "Booking";
const QIBus_lbl_packages = "Packages";
const QIBus_lbl_booking_duration1 = "28";
const QIBus_lbl_booking_duration2 = "22";
const QIBus_lbl_booking_starttime1 = "1:00";
const QIBus_lbl_booking_starttime2 = "1:00";
const QIBus_lbl_booking_totaltime1 = "8";
const QIBus_lbl_booking_endtime1 = "8:00";
const QIBus_lbl_booking_endtime2 = "8:00";
const QIBus_lbl_booking_SeatNo1 = "2,8";
const QIBus_lbl_booking_totalfare1 = "250";
const QIBus_lbl_booking_totalfare2 = "250";
const QIBus_lbl_booking_pnr1 = "4325435354";
const QIBus_lbl_booking_pnr21 = "4325435354";
const QIBus_lbl_booking_ticketno1 = "KH4325435354";
const QIBus_lbl_booking_ticketno2 = "KH4325435354";
const QIBus_lbl_booking_passenger_name1 = "John Doe";
const QIBus_lbl_cardType1 = "Paypal";
const QIBus_lbl_card_digit1 = "6253";
const QIBus_lbl_card_digit2 = "5686";
const QIBus_lbl_card_digit3 = "5623";
const QIBus_lbl_card_digit4 = "9563";
const QIBus_lbl_card_validdate1 = "05/10";
const QIBus_lbl_card_type2 = "VISA";
const QIBus_lbl_travel_name = "QIBus Travels";
const QIBus_lbl_start_time1 = "06:00";
const QIBus_lbl_end_time1 = "09:00";
const QIBus_lbl_totalDuration = "8:00";
const QIBus_lbl_hold = "3";
const QIBus_lbl_rating = "Star Ratings";
const QIBus_lbl_type1 = "Seater";
const QIBus_lbl_price1 = "\$50";
const QIBus_lbl_type2 = "sleeper";
const QIBus_lbl_price2 = "\$100";
const QIBus_lbl_goa = "Goa";
const QIBus_lbl_amritsar = "Amritsar";
const QIBus_lbl_andaman = "Andaman";
const QIBus_lbl_shimla = "Shimla Manali";
const QIBus_lbl_udaipur = "Udaipur";
const QIBus_lbl_package_duration1 = "7 Days 6 Nights";
const QIBus_lbl_package_duration2 = "5 Days 4 Nights";
const QIBus_lbl_package_duration3 = "2 Days 1 Nights";
const QIBus_lbl_package_rate1 = "2";
const QIBus_lbl_package_rate3 = "3";
const QIBus_lbl_package_rate5 = "5";
const QIBus_lbl_package_rate4 = "4";
const QIBus_lbl_package_price1 = "\$ 33000";
const QIBus_lbl_package_price2 = "\$ 30000";
const QIBus_lbl_package_price3 = "\$ 10000";
const QIBus_lbl_package_price4 = "\$ 8000";
const QIBus_lbl_package_price5 = "\$ 5000";
const QIBus_lbl_package_booking1 = "8 Booking";
const QIBus_lbl_package_bookin2 = "15 Booking";
const QIBus_lbl_package_booking3 = "20 Booking";
const QIBus_lbl_booking_date1 = "27-May-2019";
const QIBus_lbl_booking_date2 = "25-July-2019";
const QIBus_lbl_may = "May";
const QIBus_text_version_1_0 = "Version : 1.0";
const QIBus_text_country = "Country Settings";
const QIBus_title_country_settings = "Country :";
const QIBus_txt_user_name = "John";
const QIBus_text_user_last_name = "Smith";
const QIBus_text_user_email = "John@gmail.com";
const QIBus_text_user_phone = "009568564";
const QIBus_text_one_way = "One way";
const QIBus_text_return = "Return";
const QIBus_text_sleeper = "sleeper";
const QIBus_text_no_booking = "10 booking";
const QIBus_title_dropping = "Pickup - Dropping Point";
const QIBus_title_passenger_detail = "Add Passenger";
const QIBus_txt_total_hour = "10 Hour";
const QIBus_text_1 = "1";
const QIBus_text_add_hold = "%s Holds";
const QIBus_text_add5 = "%d/5";
const QIBus_text_when_you_want_to_go = "When you want to go?";


// File: flutter/qi_bus_prokit/lib/utils/AppWidget.dart
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';

import '../main.dart';
import 'AppConstant.dart';

Widget text(
  String? text, {
  var fontSize = textSizeLargeMedium,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      color: textColor ?? appStore.textSecondaryColor,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? appStore.scaffoldBackground,
    boxShadow: showShadow ? defaultBoxShadow(shadowColor: shadowColorGlobal) : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

class CustomTheme extends StatelessWidget {
  final Widget? child;

  CustomTheme({required this.child});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appStore.isDarkModeOn
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSwatch(accentColor: appColorPrimary, backgroundColor: context.scaffoldBackgroundColor),
            )
          : ThemeData.light(),
      child: child!,
    );
  }
}

Widget? Function(BuildContext, String) placeholderWidgetFn() => (_, s) => placeholderWidget();

Widget placeholderWidget() => Image.asset('images/grey.jpg', fit: BoxFit.cover);


// File: flutter/qi_bus_prokit/lib/utils/QiBusSlider.dart
import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class QiBusCarouselSlider extends StatefulWidget {
  QiBusCarouselSlider(
      {required List<Widget> this.items,
      this.height,
      this.aspectRatio = 16 / 9,
      this.viewportFraction = 0.8,
      this.initialPage = 0,
      int realPage = 10000,
      this.enableInfiniteScroll = true,
      this.reverse = false,
      this.autoPlay = false,
      this.autoPlayInterval = const Duration(seconds: 4),
      this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
      this.autoPlayCurve = Curves.fastOutSlowIn,
      this.pauseAutoPlayOnTouch,
      this.enlargeCenterPage = false,
      this.onPageChanged,
      this.scrollPhysics,
      this.scrollDirection = Axis.horizontal})
      : this.realPage = enableInfiniteScroll ? realPage + initialPage : initialPage,
        this.itemCount = items.length,
        this.itemBuilder = null,
        this.pageController = PageController(
          viewportFraction: viewportFraction as double,
          initialPage: enableInfiniteScroll ? realPage + (initialPage as int) : initialPage as int,
        );

  /// The on demand item builder constructor
  QiBusCarouselSlider.builder(
      {required this.itemCount,
      required this.itemBuilder,
      this.height,
      this.aspectRatio = 16 / 9,
      this.viewportFraction = 0.8,
      this.initialPage = 0,
      int realPage = 10000,
      this.enableInfiniteScroll = true,
      this.reverse = false,
      this.autoPlay = false,
      this.autoPlayInterval = const Duration(seconds: 4),
      this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
      this.autoPlayCurve = Curves.fastOutSlowIn,
      this.pauseAutoPlayOnTouch,
      this.enlargeCenterPage = false,
      this.onPageChanged,
      this.scrollPhysics,
      this.scrollDirection = Axis.horizontal})
      : this.realPage = enableInfiniteScroll ? realPage + initialPage : initialPage,
        this.items = null,
        this.pageController = PageController(
          viewportFraction: viewportFraction as double,
          initialPage: enableInfiniteScroll ? realPage + (initialPage as int) : initialPage as int,
        );

  /// The widgets to be shown in the carousel of default constructor
  final List<Widget>? items;

  /// The widget item builder that will be used to build item on demand
  final IndexedWidgetBuilder? itemBuilder;

  /// The widgets count that should be shown at carousel
  final int itemCount;

  /// Set carousel height and overrides any existing [aspectRatio].
  final double? height;

  /// Aspect ratio is used if no height have been declared.
  ///
  /// Defaults to 16:9 aspect ratio.
  final double aspectRatio;

  /// The fraction of the viewport that each page should occupy.
  ///
  /// Defaults to 0.8, which means each page fills 80% of the carousel.
  final num viewportFraction;

  /// The initial page to show when first creating the [QiBusCarouselSlider].
  ///
  /// Defaults to 0.
  final num initialPage;

  /// The actual index of the [PageView].
  ///
  /// This value can be ignored unless you know the carousel will be scrolled
  /// backwards more then 10000 pages.
  /// Defaults to 10000 to simulate infinite backwards scrolling.
  final num realPage;

  ///Determines if carousel should loop infinitely or be limited to item length.
  ///
  ///Defaults to true, i.e. infinite loop.
  final bool enableInfiniteScroll;

  /// Reverse the order of items if set to true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// Enables auto play, sliding one page at a time.
  ///
  /// Use [autoPlayInterval] to determent the frequency of slides.
  /// Defaults to false.
  final bool autoPlay;

  /// Sets Duration to determent the frequency of slides when
  ///
  /// [autoPlay] is set to true.
  /// Defaults to 4 seconds.
  final Duration autoPlayInterval;

  /// The animation duration between two transitioning pages while in auto playback.
  ///
  /// Defaults to 800 ms.
  final Duration autoPlayAnimationDuration;

  /// Determines the animation curve physics.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve autoPlayCurve;

  /// Sets a timer on touch detected that pause the auto play with
  /// the given [Duration].
  ///
  /// Touch Detection is only active if [autoPlay] is true.
  final Duration? pauseAutoPlayOnTouch;

  /// Determines if current page should be larger then the side images,
  /// creating a feeling of depth in the carousel.
  ///
  /// Defaults to false.
  final bool enlargeCenterPage;

  /// The axis along which the page view scrolls.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// Called whenever the page in the center of the viewport changes.
  final Function(int index)? onPageChanged;

  /// How the carousel should respond to user input.
  ///
  /// For example, determines how the items continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? scrollPhysics;

  /// [pageController] is created using the properties passed to the constructor
  /// and can be used to control the [PageView] it is passed to.
  final PageController? pageController;

  /// Animates the controlled [QiBusCarouselSlider] to the next page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  Future<void> nextPage({required Duration duration, required Curve curve}) {
    return pageController!.nextPage(duration: duration, curve: curve);
  }

  /// Animates the controlled [QiBusCarouselSlider] to the previous page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  Future<void> previousPage({required Duration duration, required Curve curve}) {
    return pageController!.previousPage(duration: duration, curve: curve);
  }

  /// Changes which page is displayed in the controlled [QiBusCarouselSlider].
  ///
  /// Jumps the page position from its current value to the given value,
  /// without animation, and without checking if the new value is in range.
  void jumpToPage(int page) {
    final index = _getRealIndex(pageController!.page!.toInt(), realPage - initialPage as int, itemCount);
    return pageController!.jumpToPage(pageController!.page!.toInt() + page - index);
  }

  /// Animates the controlled [QiBusCarouselSlider] from the current page to the given page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  Future<void> animateToPage(int page, {required Duration duration, required Curve curve}) {
    final index = _getRealIndex(pageController!.page!.toInt(), realPage - initialPage as int, itemCount);
    return pageController!.animateToPage(pageController!.page!.toInt() + page - index, duration: duration, curve: curve);
  }

  @override
  _QiBusCarouselSliderState createState() => _QiBusCarouselSliderState();
}

class _QiBusCarouselSliderState extends State<QiBusCarouselSlider> with TickerProviderStateMixin {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = getTimer();
  }

  Timer? getTimer() {
    return widget.autoPlay
        ? Timer.periodic(widget.autoPlayInterval, (_) {
            widget.pageController!.nextPage(duration: widget.autoPlayAnimationDuration, curve: widget.autoPlayCurve);
          })
        : null;
  }

  void pauseOnTouch() {
    timer!.cancel();
    timer = Timer(widget.pauseAutoPlayOnTouch!, () {
      timer = getTimer();
    });
  }

  Widget getWrapper(Widget child) {
    if (widget.height != null) {
      final Widget wrapper = Container(height: widget.height, child: child);
      return widget.autoPlay && widget.pauseAutoPlayOnTouch != null ? addGestureDetection(wrapper) : wrapper;
    } else {
      final Widget wrapper = AspectRatio(aspectRatio: widget.aspectRatio, child: child);
      return widget.autoPlay && widget.pauseAutoPlayOnTouch != null ? addGestureDetection(wrapper) : wrapper;
    }
  }

  Widget addGestureDetection(Widget child) => GestureDetector(onPanDown: (_) => pauseOnTouch(), child: child);

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return getWrapper(CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
      items: widget.items!.map((i) {
        return Container(
          child: i,
        );
      }).toList(),
    ));
  }
}

/// Converts an index of a set size to the corresponding index of a collection of another size
/// as if they were circular.
///
/// Takes a [position] from collection Foo, a [base] from where Foo's index originated
/// and the [length] of a second collection Baa, for which the correlating index is sought.
///
/// For example; We have a Carousel of 10000(simulating infinity) but only 6 images.
/// We need to repeat the images to give the illusion of a never ending stream.
/// By calling _getRealIndex with position and base we get an offset.
/// This offset modulo our length, 6, will return a number between 0 and 5, which represent the image
/// to be placed in the given position.
int _getRealIndex(int position, int base, int length) {
  final int offset = position - base;
  return _remainder(offset, length);
}

/// Returns the remainder of the modulo operation [input] % [source], and adjust it for
/// negative values.
int _remainder(int input, int source) {
  if (source == 0) return 0;
  final int result = input % source;
  return result < 0 ? source + result : result;
}


// File: flutter/qi_bus_prokit/lib/utils/QiBusImages.dart


import 'AppConstant.dart';

const qibus_ic_amritsar = "$BaseUrl/images/qibus/qibus_ic_amritsar.png";
const qibus_ic_andamans = "$BaseUrl/images/qibus/qibus_ic_andamans.png";
const qibus_ic_buslogo = "$BaseUrl/images/qibus/qibus_ic_buslogo.png";
const qibus_ic_canceled = "$BaseUrl/images/qibus/qibus_ic_canceled.jpg";
const qibus_ic_card = "$BaseUrl/images/qibus/qibus_ic_card.png";
const qibus_ic_card3 = "$BaseUrl/images/qibus/qibus_ic_card3.png";
const qibus_ic_completed = "$BaseUrl/images/qibus/qibus_ic_completed.png";
const qibus_ic_delhi = "$BaseUrl/images/qibus/qibus_ic_delhi.jpg";
const qibus_ic_goa = "$BaseUrl/images/qibus/qibus_ic_goa.png";
const qibus_ic_gr_wallet = "$BaseUrl/images/qibus/qibus_ic_gr_wallet.png";
const qibus_ic_gr_mobile_otp = "$BaseUrl/images/qibus/qibus_ic_gr_mobile_otp.png";
const qibus_ic_udaipur = "$BaseUrl/images/qibus/qibus_ic_udaipur.png";
const qibus_ic_refer_and_earn = "$BaseUrl/images/qibus/qibus_ic_refer_and_earn.png";
const qibus_ic_ticket = "$BaseUrl/images/qibus/qibus_ic_ticket.png";
const qibus_ic_sleeper = "images/qibus/qibus_ic_sleeper.png";
const qibus_ic_sale_1 = "$BaseUrl/images/qibus/qibus_ic_sale_1.png";
const qibus_ic_travel = "$BaseUrl/images/qibus/qibus_ic_travel.jpg";
const qibus_ic_profile = "$BaseUrl/images/qibus/qibus_ic_profile.png";
const qibus_ic_temp = "$BaseUrl/images/qibus/qibus_ic_temp.jpeg";
const qibus_ic_sale_2 = "$BaseUrl/images/qibus/qibus_ic_sale_2.png";
const qibus_ic_map = "$BaseUrl/images/qibus/qibus_ic_map.jpg";
const qibus_ic_logo = "images/qibus/qibus_ic_logo_splash.gif";
const qibus_ic_facebook = "images/qibus/qibus_ic_facebook.png";
const qibus_ic_google = "images/qibus/qibus_ic_google.png";
const qibus_google = "images/qibus/qibus_google.svg";
const qibus_ic_booking = "images/qibus/qibus_ic_booking.png";
const qibus_ic_booking_selected = "images/qibus/qibus_ic_booking_selected.png";
const qibus_ic_home = "images/qibus/qibus_ic_home.png";
const qibus_ic_home_selected = "images/qibus/qibus_ic_home_selected.png";
const qibus_ic_more = "images/qibus/qibus_ic_more.png";
const qibus_ic_more_selected = "images/qibus/qibus_ic_more_selected.png";
const qibus_ic_package = "images/qibus/qibus_ic_package.png";
const qibus_ic_package_selected = "images/qibus/qibus_ic_package_selected.png";
const qibus_gif_bell = "images/qibus/qibus_gif_bell.gif";
const qibus_ic_card_line = "images/qibus/qibus_ic_card_line.svg";
const qibus_ic_help = "images/qibus/qibus_ic_help.svg";
const qibus_ic_logout = "images/qibus/qibus_ic_logout.svg";
const qibus_ic_refer = "images/qibus/qibus_ic_refer.svg";
const qibus_ic_setting = "images/qibus/qibus_ic_setting.svg";
const qibus_ic_user = "images/qibus/qibus_ic_user.svg";
const qibus_ic_wallet = "images/qibus/qibus_ic_wallet.svg";
const qibus_ic_home_package = "images/qibus/qibus_ic_home_package.svg";
const qibus_ic_ac = "images/qibus/qibus_ic_ac.svg";
const qibus_ic_bus = "images/qibus/qibus_ic_bus.svg";
const qibus_ic_calender = "images/qibus/qibus_ic_calender.svg";
const qibus_ic_icon = "images/qibus/qibus_ic_icon.svg";
const qibus_ic_non_ac = "images/qibus/qibus_ic_non_ac.svg";
const qibus_ic_restaurant = "images/qibus/qibus_ic_restaurant.svg";
const qibus_ic_seater = "images/qibus/qibus_ic_seater.svg";
const qibus_ic_sleeper_icon = "images/qibus/qibus_ic_sleeper_icon.svg";
const qibus_ic_wifi = "images/qibus/qibus_ic_wifi.svg";
const qibus_ic_whatsapp = "images/qibus/qibus_ic_whatsapp.svg";
const qibus_ic_fb = "images/qibus/qibus_ic_fb.svg";
const qibus_ic_google_fill = "images/qibus/qibus_ic_google_fill.svg";
const qibus_ic_twitter = "images/qibus/qibus_ic_twitter.svg";
const qibus_ic_add = "images/qibus/qibus_ic_add.png";
const qibus_ic_banking = "images/qibus/qibus_ic_banking.svg";
const qibus_ic_cards = "images/qibus/qibus_ic_card.svg";
const qibus_ic_pin = "images/qibus/qibus_ic_pin.svg";
const qibus_ic_wrap = "images/qibus/qibus_ic_wrap.png";


// File: flutter/qi_bus_prokit/lib/utils/QiBusConstant.dart
/*fonts*/
const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';
/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 34.0;

/* margin */

const spacing_control_half = 2.0;
const spacing_control = 4.0;
const spacing_standard = 8.0;
const spacing_middle = 10.0;
const spacing_standard_new = 16.0;
const spacing_large = 24.0;
const spacing_xlarge = 32.0;
const spacing_xxLarge = 40.0;

const isDarkModeOnPref = 'isDarkModeOnPref';




// File: flutter/qi_bus_prokit/lib/utils/QiBusColors.dart
import 'dart:ui';

const qIBus_colorPrimary = Color(0xFFeb4b51);
const qIBus_colorPrimaryDark = Color(0xFFeb4b51);
const qIBus_colorPrimaryRipple = Color(0xFFF57074);
const qIBus_colorAccent = Color(0xFFeb4b51);

const qIBus_blue = Color(0xFF4C92C0);
const qIBus_red = Color(0xFFe51415);
const qIBus_white = Color(0xFFFFFFFF);
const qIBus_gray = Color(0xFFE2E2E2);
const qIBus_rating = Color(0xFFFFC107);

const qIBus_view_color = Color(0xFFDADADA);
const qIBus_app_background = Color(0xFFF8F7F7);
const qIBus_color_check = Color(0xFF139B18);
const qIBus_color_link_blue = Color(0xFF1887f9);

const qIBus_textHeader = Color(0xFF464545);
const qIBus_textChild = Color(0xFF747474);
const qIBus_light_grey = Color(0xFFB8B8B8);
const qIBus_dark_gray = Color(0xFF929292);
const qIBus_icon_color = Color(0xFF747474);

const qIBus_color_facebook = Color(0xFF2F3181);
const qIBus_color_google = Color(0xFFF13B19);

const qIBus_purple = Color(0xFFB88DDD);
const qIBus_green = Color(0xFFC2DB77);
const qIBus_orange = Color(0xFFF5D270);
const qIBus_darkBlue = Color(0xFF5FACC9);
const qIBus_darkPurple = Color(0xFFB285CC);
const qIBus_darkGreen = Color(0xFFB6DD6E);
const qIBus_pink = Color(0xFFf5bebe);
const qIBus_ShadowColor = Color(0X95E9EBF0);

const colorPrimary = Color(0xFF9a79ed);

const iconColorPrimary = Color(0xFFFFFFFF);
const iconColorSecondary = Color(0xFFA8ABAD);
const appSecondaryBackgroundColor = Color(0xFF131d25);
const appTextColorPrimary = Color(0xFF212121);
const appTextColorSecondary = Color(0xFF5A5C5E);
const appShadowColor = Color(0x95E9EBF0);
const appColorPrimaryLight = Color(0xFFF9FAFF);

// Dark Theme Colors
const appBackgroundColorDark = Color(0xFF121212);
const cardBackgroundBlackDark = Color(0xFF1F1F1F);
const color_primary_black = Color(0xFF131d25);
const appColorPrimaryDarkLight = Color(0xFFF9FAFF);
const iconColorPrimaryDark = Color(0xFF212121);
const iconColorSecondaryDark = Color(0xFFA8ABAD);
const appShadowColorDark = Color(0x1A3E3942);

const appColorPrimary = Color(0xFF1157FA);
const appLayout_background = Color(0xFFf8f8f8);

const t1_colorPrimary_light = Color(0XFFFFEEEE);


// File: flutter/qi_bus_prokit/lib/utils/BubbleTabIndicator.dart
import 'package:flutter/material.dart';

class BubbleTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double indicatorRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;

  const BubbleTabIndicator({
    this.indicatorHeight = 20.0,
    this.indicatorColor = Colors.greenAccent,
    this.indicatorRadius = 100.0,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.padding = const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    this.insets = const EdgeInsets.symmetric(horizontal: 5.0),
  });

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is BubbleTabIndicator) {
      return new BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t)!,
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is BubbleTabIndicator) {
      return new BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t)!,
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _BubblePainter createBoxPainter([VoidCallback? onChanged]) {
    return new _BubblePainter(this, onChanged);
  }
}

class _BubblePainter extends BoxPainter {
  _BubblePainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  final BubbleTabIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;

  Color get indicatorColor => decoration.indicatorColor;

  double get indicatorRadius => decoration.indicatorRadius;

  EdgeInsetsGeometry get padding => decoration.padding;

  EdgeInsetsGeometry get insets => decoration.insets;

  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    Rect indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    return new Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = Offset(offset.dx, (configuration.size!.height / 2) - indicatorHeight / 2) & Size(configuration.size!.width, indicatorHeight);
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = _indicatorRectFor(rect, textDirection);
    final Paint paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(indicator, Radius.circular(indicatorRadius)), paint);
  }
}


// File: flutter/qi_bus_prokit/lib/utils/QiBusWidget.dart
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/screen/QIBusNotification.dart';



import '../main.dart';
import 'AppWidget.dart';
import 'QiBusColors.dart';
import 'QiBusConstant.dart';

Padding editTextStyle(var hintText, {var line = 1}) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextFormField(
        maxLines: line,
        style: TextStyle(
          fontSize: textSizeMedium,
          fontFamily: fontRegular,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(spacing_standard_new, 16, 4, 16),
          hintText: hintText,
          filled: true,
          fillColor: appStore.isDarkModeOn ? cardDarkColor : white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing_middle),
            borderSide: const BorderSide(color: qIBus_view_color, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing_middle),
            borderSide: const BorderSide(color: qIBus_view_color, width: 0.0),
          ),
        ),
      ));
}

Container homeEditTextStyle(var hintText, {var line = 1}) {
  return Container(
    child: TextField(
      style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular, color: qIBus_textChild),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        isDense: true,
        hintText: hintText,
        border: InputBorder.none,
      ),
    ),
  );
}

// ignore: must_be_immutable
class QIBusAppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  QIBusAppButton({required this.textContent, required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return QIBusAppButtonState();
  }
}

class QIBusAppButtonState extends State<QIBusAppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)), padding: const EdgeInsets.all(0.0), textStyle: TextStyle(color: qIBus_white)),
      onPressed: widget.onPressed,
      child: Container(
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0)), color: qIBus_colorPrimary),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.textContent,
              style: boldTextStyle(color: white, size: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TopBar extends StatefulWidget {
  var titleName;
  var icon;
  bool? isVisible = false;
  var isVisibleIcon = true;

  TopBar(var this.titleName, {var this.icon, var this.isVisible});

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(qIBus_colorPrimary);
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(color: qIBus_colorPrimary, height: 70),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width * 0.15,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    widget.isVisible!
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back, color: qIBus_white),
                                onPressed: () {
                                  finish(context);
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(spacing_standard, 0, 0, 0),
                                child: text(widget.titleName, textColor: qIBus_white, fontSize: textSizeNormal, fontFamily: fontBold),
                              ),
                            ],
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_standard, 0, 0),
                            child: text(widget.titleName, textColor: qIBus_white, fontSize: textSizeNormal, fontFamily: fontBold),
                          ),
                    widget.isVisible!
                        ? GestureDetector(
                            onTap: () {
                              QIBusNotification().launch(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                right: spacing_standard_new,
                              ),
                              child: Image(
                                image: AssetImage(widget.icon),
                                height: 25,
                                width: 25,
                                color: qIBus_white,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              QIBusNotification().launch(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: spacing_standard,
                                right: spacing_standard_new,
                              ),
                              child: Image(
                                image: AssetImage(widget.icon),
                                height: 25,
                                width: 25,
                                color: qIBus_white,
                              ),
                            ),
                          )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  color: context.cardColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget title(var title, BuildContext context) {
  return Stack(
    children: <Widget>[
      Container(color: qIBus_colorPrimary, height: 70),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width * 0.15,
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: qIBus_white,
                      ),
                      onPressed: () {
                        finish(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(spacing_standard, 0, 0, 0),
                      child: text(title, textColor: qIBus_white, fontSize: textSizeNormal, fontFamily: fontBold),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: context.cardColor),
          ),
        ],
      )
    ],
  );
}

class PinEntryTextField extends StatefulWidget {
  final String? lastPin;
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  PinEntryTextField({this.lastPin, this.fields = 4, this.onSubmit, this.fieldWidth = 40.0, this.fontSize = 16.0, this.isTextObscure = false, this.showFieldAsBox = false}) : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  late List<String?> _pin;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String?>.filled(widget.fields, null, growable: false);
    _focusNodes = List<FocusNode?>.filled(widget.fields, null, growable: false);
    _textControllers = List<TextEditingController?>.filled(widget.fields, null, growable: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin!.length; i++) {
            _pin[i] = widget.lastPin![i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController? t) => t!.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, verticalDirection: VerticalDirection.down, children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach((TextEditingController? tEditController) => tEditController!.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i]!.text = widget.lastPin![i];
      }
    }

    _focusNodes[i]!.addListener(() {
      if (_focusNodes[i]!.hasFocus) {}
    });

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: boldTextStyle(size: 18),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(focusColor: qIBus_colorPrimary, counterText: "", border: widget.showFieldAsBox ? OutlineInputBorder(borderSide: BorderSide(width: 2.0)) : null),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i]!.unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i]!.unfocus();
            if (_pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}

Divider view() {
  return Divider(
    color: qIBus_view_color,
    height: 0.5,
  );
}

class LineDashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeWidth = 2;
    var max = 35;
    var dashWidth = 5;
    var dashSpace = 5;
    double startY = 0;
    while (max >= 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      final space = (dashSpace + dashWidth);
      startY += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


// File: flutter/qi_bus_prokit/lib/utils/AppTheme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'QiBusColors.dart';


class AppThemeData {
  //
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor,
    primaryColor: appColorPrimary,
    primaryColorDark: appColorPrimary,
    hoverColor: Colors.white54,
    dividerColor: viewLineColor,
    fontFamily: GoogleFonts.openSans().fontFamily,
    appBarTheme: AppBarTheme(
      color: appLayout_background,
      iconTheme: IconThemeData(color: textPrimaryColor),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
    cardTheme: CardTheme(color: Colors.white),
    cardColor: Colors.white,
    iconTheme: IconThemeData(color: textPrimaryColor),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: whiteColor),
    textTheme: TextTheme(
      labelLarge: TextStyle(color: appColorPrimary),
      titleLarge: TextStyle(color: textPrimaryColor),
      titleSmall: TextStyle(color: textSecondaryColor),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.light(primary: appColorPrimary).copyWith(error: Colors.red),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorDark,
    highlightColor: appBackgroundColorDark,
    appBarTheme: AppBarTheme(
      color: appBackgroundColorDark,
      iconTheme: IconThemeData(color: blackColor),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    primaryColor: color_primary_black,
    dividerColor: Color(0xFFDADADA).withOpacity(0.3),
    primaryColorDark: color_primary_black,
    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
    hoverColor: Colors.black12,
    fontFamily: GoogleFonts.openSans().fontFamily,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: appBackgroundColorDark),
    primaryTextTheme: TextTheme(titleLarge: primaryTextStyle(color: Colors.white), labelSmall: primaryTextStyle(color: Colors.white)),
    cardTheme: CardTheme(color: cardBackgroundBlackDark),
    cardColor: appSecondaryBackgroundColor,
    iconTheme: IconThemeData(color: whiteColor),
    textTheme: TextTheme(
      labelLarge: TextStyle(color: color_primary_black),
      titleLarge: TextStyle(color: whiteColor),
      titleSmall: TextStyle(color: Colors.white54),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.dark(primary: appBackgroundColorDark, onPrimary: cardBackgroundBlackDark).copyWith(secondary: whiteColor).copyWith(error: Color(0xFFCF6676)),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );
}


// File: flutter/qi_bus_prokit/lib/utils/codePicker/selection_dialog.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';

import '../../../main.dart';
import '../AppConstant.dart';
import 'country_code.dart';

/// selection dialog used for selection of the country code
class SelectionDialog extends StatefulWidget {
  final List<CountryCode> elements;
  final bool? showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final WidgetBuilder? emptySearchBuilder;
  final bool? showFlag;

  /// elements passed as favorite
  final List<CountryCode> favoriteElements;

  SelectionDialog(this.elements, this.favoriteElements,
      {Key? key, this.showCountryOnly, this.emptySearchBuilder, InputDecoration searchDecoration = const InputDecoration(), this.searchStyle, this.showFlag})
      : this.searchDecoration = searchDecoration.copyWith(prefixIcon: Icon(Icons.search)),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  /// this is useful for filtering purpose
  late List<CountryCode> filteredElements;

  @override
  Widget build(BuildContext context) => CustomTheme(
        child: SimpleDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text("Select Country Code", textColor: appStore.textPrimaryColor, fontSize: 16.0, fontFamily: fontSemibold),
              SizedBox(height: 8),
              TextField(
                style: widget.searchStyle,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Search Country",
                  hintStyle: secondaryTextStyle(),
                  border: InputBorder.none,
                ),
                onChanged: _filterElements,
              )
            ],
          ),
          children: [
            Container(
                margin: EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView(
                    children: [
                  widget.favoriteElements.isEmpty
                      ? DecoratedBox(decoration: BoxDecoration())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[]
                            ..addAll(widget.favoriteElements
                                .map(
                                  (f) => SimpleDialogOption(
                                    child: _buildOption(f),
                                    onPressed: () {
                                      _selectItem(f);
                                    },
                                  ),
                                )
                                .toList())
                            ..add(Divider())),
                ]..addAll(filteredElements.isEmpty
                        ? [_buildEmptySearchWidget(context)]
                        : filteredElements.map((e) => SimpleDialogOption(
                              key: Key(e.toLongString()),
                              child: _buildOption(e),
                              onPressed: () {
                                _selectItem(e);
                              },
                            ))))),
          ],
        ),
      );

  Widget _buildOption(CountryCode e) {
    return Container(
      width: 400,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          widget.showFlag!
              ? Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: CachedNetworkImage(
                      placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                      imageUrl: e.flagUri!,
                      width: 25.0,
                    ),
                  ),
                )
              : Container(),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: text(e.toLongString(), fontSize: textSizeMedium, textColor: appStore.textPrimaryColor)),
                text(e.dialCode, fontSize: textSizeMedium, textColor: appStore.textPrimaryColor, fontFamily: fontSemibold),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder!(context);
    }

    return Center(child: Text('No Country Found'));
  }

  @override
  void initState() {
    filteredElements = widget.elements;
    super.initState();
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements = widget.elements.where((e) => e.code!.contains(s) || e.dialCode!.contains(s) || e.name!.toUpperCase().contains(s)).toList();
    });
  }

  void _selectItem(CountryCode e) {
    Navigator.pop(context, e);
  }
}


// File: flutter/qi_bus_prokit/lib/utils/codePicker/country_code_picker.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:qi_bus_prokit/utils/codePicker/selection_dialog.dart';


import '../../../main.dart';
import '../AppWidget.dart';
import 'country_code.dart';
import 'country_codes.dart';

export 'country_code.dart';

class CountryCodePicker extends StatefulWidget {
  final ValueChanged<CountryCode>? onChanged;

  //Exposed new method to get the initial information of the country
  final ValueChanged<CountryCode?>? onInit;
  final String? initialSelection;
  final List<String> favorite;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final bool showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final WidgetBuilder? emptySearchBuilder;
  final Function(CountryCode?)? builder;

  /// shows the name of the country instead of the dialcode
  final bool showOnlyCountryWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially usefull in combination with [showOnlyCountryWhenClosed],
  /// because longer countrynames are displayed in one line
  final bool alignLeft;

  /// shows the flag
  final bool showFlag;

  /// contains the country codes to load only the specified countries.
  final List<String> countryFilter;

  CountryCodePicker({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.favorite = const [],
    this.countryFilter = const [],
    this.textStyle,
    this.padding = const EdgeInsets.all(0.0),
    this.showCountryOnly = false,
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.emptySearchBuilder,
    this.showOnlyCountryWhenClosed = false,
    this.alignLeft = false,
    this.showFlag = true,
    this.builder,
  });

  @override
  State<StatefulWidget> createState() {
    List<Map> jsonList = codes;

    List<CountryCode> elements = jsonList
        .map((s) => CountryCode(
              name: s['name'],
              code: s['code'],
              dialCode: s['dial_code'],
              flagUri: 'https://iqonic.design/themeforest-images/prokit/images/flags/${s['code'].toLowerCase()}.png',
            ))
        .toList();

    if (countryFilter.length > 0) {
      elements = elements.where((c) => countryFilter.contains(c.code)).toList();
    }

    return new _CountryCodePickerState(elements);
  }
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  CountryCode? selectedItem;
  List<CountryCode> elements = [];
  List<CountryCode> favoriteElements = [];

  _CountryCodePickerState(this.elements);

  @override
  Widget build(BuildContext context) {
    Widget _widget;
    if (widget.builder != null)
      _widget = InkWell(
        onTap: _showSelectionDialog,
        child: widget.builder!(selectedItem),
      );
    else {
      _widget = TextButton(
        style: TextButton.styleFrom(
          padding: widget.padding,
        ),
        onPressed: _showSelectionDialog,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            widget.showFlag
                ? Flexible(
                    flex: widget.alignLeft ? 0 : 1,
                    fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
                    child: Padding(
                      padding: widget.alignLeft ? EdgeInsets.only(right: 8.0, left: 8.0) : EdgeInsets.only(right: 8.0),
                      child: CachedNetworkImage(
                        imageUrl: selectedItem!.flagUri!,
                        width: 25.0,
                      ),
                    ),
                  )
                : Container(),
            Flexible(
              fit: widget.alignLeft ? FlexFit.tight : FlexFit.loose,
              child: text(selectedItem!.toCountryCodeString(), textColor: appStore.textPrimaryColor, fontSize: 16.0),
            ),
          ],
        ),
      );
    }
    return _widget;
  }

  @override
  void didUpdateWidget(CountryCodePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = elements.firstWhere((e) => (e.code!.toUpperCase() == widget.initialSelection!.toUpperCase()) || (e.dialCode == widget.initialSelection.toString()), orElse: () => elements[0]);
      } else {
        selectedItem = elements[0];
      }
    }
  }

  @override
  initState() {
    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere((e) => (e.code!.toUpperCase() == widget.initialSelection!.toUpperCase()) || (e.dialCode == widget.initialSelection.toString()), orElse: () => elements[0]);
    } else {
      selectedItem = elements[0];
    }

    //Change added: get the initial entered country information
    _onInit(selectedItem);

    favoriteElements = elements.where((e) => widget.favorite.firstWhereOrNull((f) => e.code == f.toUpperCase() || e.dialCode == f.toString()) != null).toList();
    super.initState();
  }

  void _showSelectionDialog() {
    showDialog(
      context: context,
      builder: (_) => SelectionDialog(elements, favoriteElements,
          showCountryOnly: widget.showCountryOnly,
          emptySearchBuilder: widget.emptySearchBuilder,
          searchDecoration: widget.searchDecoration,
          searchStyle: widget.searchStyle,
          showFlag: widget.showFlag),
    ).then((e) {
      if (e != null) {
        setState(() {
          selectedItem = e;
        });

        _publishSelection(e);
      }
    });
  }

  void _publishSelection(CountryCode e) {
    if (widget.onChanged != null) {
      widget.onChanged!(e);
    }
  }

  void _onInit(CountryCode? initialData) {
    if (widget.onInit != null) {
      widget.onInit!(initialData);
    }
  }
}


// File: flutter/qi_bus_prokit/lib/utils/codePicker/country_code.dart
mixin ToAlias {}

@deprecated
class CElement = CountryCode with ToAlias;

/// Country element. This is the element that contains all the information
class CountryCode {
  /// the name of the country
  String? name;

  /// the flag of the country
  String? flagUri;

  /// the country code (IT,AF..)
  String? code;

  /// the dial code (+39,+93..)
  String? dialCode;

  CountryCode({this.name, this.flagUri, this.code, this.dialCode});

  @override
  String toString() => "$dialCode";

  String toLongString() => "$name ($code)";

  String toCountryCodeString() => "$code $dialCode";

  String toCountryStringOnly() => '$name';
}


// File: flutter/qi_bus_prokit/lib/utils/codePicker/country_codes.dart
List<Map> codes = [
  {"name": "افغانستان", "code": "AF", "dial_code": "+93"},
  {"name": "Åland", "code": "AX", "dial_code": "+358"},
  {"name": "Shqipëria", "code": "AL", "dial_code": "+355"},
  {"name": "الجزائر", "code": "DZ", "dial_code": "+213"},
  {"name": "American Samoa", "code": "AS", "dial_code": "+1684"},
  {"name": "Andorra", "code": "AD", "dial_code": "+376"},
  {"name": "Angola", "code": "AO", "dial_code": "+244"},
  {"name": "Anguilla", "code": "AI", "dial_code": "+1264"},
  {"name": "Antarctica", "code": "AQ", "dial_code": "+672"},
  {"name": "Antigua and Barbuda", "code": "AG", "dial_code": "+1268"},
  {"name": "Argentina", "code": "AR", "dial_code": "+54"},
  {"name": "Հայաստան", "code": "AM", "dial_code": "+374"},
  {"name": "Aruba", "code": "AW", "dial_code": "+297"},
  {"name": "Australia", "code": "AU", "dial_code": "+61"},
  {"name": "Österreich", "code": "AT", "dial_code": "+43"},
  {"name": "Azərbaycan", "code": "AZ", "dial_code": "+994"},
  {"name": "Bahamas", "code": "BS", "dial_code": "+1242"},
  {"name": "‏البحرين", "code": "BH", "dial_code": "+973"},
  {"name": "Bangladesh", "code": "BD", "dial_code": "+880"},
  {"name": "Barbados", "code": "BB", "dial_code": "+1246"},
  {"name": "Белару́сь", "code": "BY", "dial_code": "+375"},
  {"name": "België", "code": "BE", "dial_code": "+32"},
  {"name": "Belize", "code": "BZ", "dial_code": "+501"},
  {"name": "Bénin", "code": "BJ", "dial_code": "+229"},
  {"name": "Bermuda", "code": "BM", "dial_code": "+1441"},
  {"name": "ʼbrug-yul", "code": "BT", "dial_code": "+975"},
  {"name": "Bolivia", "code": "BO", "dial_code": "+591"},
  {"name": "Bosna i Hercegovina", "code": "BA", "dial_code": "+387"},
  {"name": "Botswana", "code": "BW", "dial_code": "+267"},
  {"name": "Bouvetøya", "code": "BV", "dial_code": "+47"},
  {"name": "Brasil", "code": "BR", "dial_code": "+55"},
  {"name": "British Indian Ocean Territory", "code": "IO", "dial_code": "+246"},
  {"name": "Negara Brunei Darussalam", "code": "BN", "dial_code": "+673"},
  {"name": "България", "code": "BG", "dial_code": "+359"},
  {"name": "Burkina Faso", "code": "BF", "dial_code": "+226"},
  {"name": "Burundi", "code": "BI", "dial_code": "+257"},
  {"name": "Kâmpŭchéa", "code": "KH", "dial_code": "+855"},
  {"name": "Cameroon", "code": "CM", "dial_code": "+237"},
  {"name": "Canada", "code": "CA", "dial_code": "+1"},
  {"name": "Cabo Verde", "code": "CV", "dial_code": "+238"},
  {"name": "Cayman Islands", "code": "KY", "dial_code": "+ 345"},
  {"name": "Ködörösêse tî Bêafrîka", "code": "CF", "dial_code": "+236"},
  {"name": "Tchad", "code": "TD", "dial_code": "+235"},
  {"name": "Chile", "code": "CL", "dial_code": "+56"},
  {"name": "中国", "code": "CN", "dial_code": "+86"},
  {"name": "Christmas Island", "code": "CX", "dial_code": "+61"},
  {"name": "Cocos (Keeling) Islands", "code": "CC", "dial_code": "+61"},
  {"name": "Colombia", "code": "CO", "dial_code": "+57"},
  {"name": "Komori", "code": "KM", "dial_code": "+269"},
  {"name": "République du Congo", "code": "CG", "dial_code": "+242"},
  {"name": "République démocratique du Congo", "code": "CD", "dial_code": "+243"},
  {"name": "Cook Islands", "code": "CK", "dial_code": "+682"},
  {"name": "Costa Rica", "code": "CR", "dial_code": "+506"},
  {"name": "Côte d'Ivoire", "code": "CI", "dial_code": "+225"},
  {"name": "Hrvatska", "code": "HR", "dial_code": "+385"},
  {"name": "Cuba", "code": "CU", "dial_code": "+53"},
  {"name": "Κύπρος", "code": "CY", "dial_code": "+357"},
  {"name": "Česká republika", "code": "CZ", "dial_code": "+420"},
  {"name": "Danmark", "code": "DK", "dial_code": "+45"},
  {"name": "Djibouti", "code": "DJ", "dial_code": "+253"},
  {"name": "Dominica", "code": "DM", "dial_code": "+1767"},
  {"name": "República Dominicana", "code": "DO", "dial_code": "+1"},
  {"name": "Ecuador", "code": "EC", "dial_code": "+593"},
  {"name": "مصر‎", "code": "EG", "dial_code": "+20"},
  {"name": "El Salvador", "code": "SV", "dial_code": "+503"},
  {"name": "Guinea Ecuatorial", "code": "GQ", "dial_code": "+240"},
  {"name": "ኤርትራ", "code": "ER", "dial_code": "+291"},
  {"name": "Eesti", "code": "EE", "dial_code": "+372"},
  {"name": "ኢትዮጵያ", "code": "ET", "dial_code": "+251"},
  {"name": "Falkland Islands", "code": "FK", "dial_code": "+500"},
  {"name": "Føroyar", "code": "FO", "dial_code": "+298"},
  {"name": "Fiji", "code": "FJ", "dial_code": "+679"},
  {"name": "Suomi", "code": "FI", "dial_code": "+358"},
  {"name": "France", "code": "FR", "dial_code": "+33"},
  {"name": "Guyane française", "code": "GF", "dial_code": "+594"},
  {"name": "Polynésie française", "code": "PF", "dial_code": "+689"},
  {"name": "Territoire des Terres australes et antarctiques fr", "code": "TF", "dial_code": "+262"},
  {"name": "Gabon", "code": "GA", "dial_code": "+241"},
  {"name": "Gambia", "code": "GM", "dial_code": "+220"},
  {"name": "საქართველო", "code": "GE", "dial_code": "+995"},
  {"name": "Deutschland", "code": "DE", "dial_code": "+49"},
  {"name": "Ghana", "code": "GH", "dial_code": "+233"},
  {"name": "Gibraltar", "code": "GI", "dial_code": "+350"},
  {"name": "Ελλάδα", "code": "GR", "dial_code": "+30"},
  {"name": "Kalaallit Nunaat", "code": "GL", "dial_code": "+299"},
  {"name": "Grenada", "code": "GD", "dial_code": "+1473"},
  {"name": "Guadeloupe", "code": "GP", "dial_code": "+590"},
  {"name": "Guam", "code": "GU", "dial_code": "+1671"},
  {"name": "Guatemala", "code": "GT", "dial_code": "+502"},
  {"name": "Guernsey", "code": "GG", "dial_code": "+44"},
  {"name": "Guinée", "code": "GN", "dial_code": "+224"},
  {"name": "Guiné-Bissau", "code": "GW", "dial_code": "+245"},
  {"name": "Guyana", "code": "GY", "dial_code": "+592"},
  {"name": "Haïti", "code": "HT", "dial_code": "+509"},
  {"name": "Heard Island and McDonald Islands", "code": "HM", "dial_code": "+0"},
  {"name": "Vaticano", "code": "VA", "dial_code": "+379"},
  {"name": "Honduras", "code": "HN", "dial_code": "+504"},
  {"name": "香港", "code": "HK", "dial_code": "+852"},
  {"name": "Magyarország", "code": "HU", "dial_code": "+36"},
  {"name": "Ísland", "code": "IS", "dial_code": "+354"},
  {"name": "भारत", "code": "IN", "dial_code": "+91"},
  {"name": "Indonesia", "code": "ID", "dial_code": "+62"},
  {"name": "ایران", "code": "IR", "dial_code": "+98"},
  {"name": "العراق", "code": "IQ", "dial_code": "+964"},
  {"name": "Éire", "code": "IE", "dial_code": "+353"},
  {"name": "Isle of Man", "code": "IM", "dial_code": "+44"},
  {"name": "יִשְׂרָאֵל", "code": "IL", "dial_code": "+972"},
  {"name": "Italia", "code": "IT", "dial_code": "+39"},
  {"name": "Jamaica", "code": "JM", "dial_code": "+1876"},
  {"name": "日本", "code": "JP", "dial_code": "+81"},
  {"name": "Jersey", "code": "JE", "dial_code": "+44"},
  {"name": "الأردن", "code": "JO", "dial_code": "+962"},
  {"name": "Қазақстан", "code": "KZ", "dial_code": "+7"},
  {"name": "Kenya", "code": "KE", "dial_code": "+254"},
  {"name": "Kiribati", "code": "KI", "dial_code": "+686"},
  {"name": "북한", "code": "KP", "dial_code": "+850"},
  {"name": "대한민국", "code": "KR", "dial_code": "+82"},
  {"name": "Republika e Kosovës", "code": "XK", "dial_code": "+383"},
  {"name": "الكويت", "code": "KW", "dial_code": "+965"},
  {"name": "Кыргызстан", "code": "KG", "dial_code": "+996"},
  {"name": "ສປປລາວ", "code": "LA", "dial_code": "+856"},
  {"name": "Latvija", "code": "LV", "dial_code": "+371"},
  {"name": "لبنان", "code": "LB", "dial_code": "+961"},
  {"name": "Lesotho", "code": "LS", "dial_code": "+266"},
  {"name": "Liberia", "code": "LR", "dial_code": "+231"},
  {"name": "‏ليبيا", "code": "LY", "dial_code": "+218"},
  {"name": "Liechtenstein", "code": "LI", "dial_code": "+423"},
  {"name": "Lietuva", "code": "LT", "dial_code": "+370"},
  {"name": "Luxembourg", "code": "LU", "dial_code": "+352"},
  {"name": "澳門", "code": "MO", "dial_code": "+853"},
  {"name": "Македонија", "code": "MK", "dial_code": "+389"},
  {"name": "Madagasikara", "code": "MG", "dial_code": "+261"},
  {"name": "Malawi", "code": "MW", "dial_code": "+265"},
  {"name": "Malaysia", "code": "MY", "dial_code": "+60"},
  {"name": "Maldives", "code": "MV", "dial_code": "+960"},
  {"name": "Mali", "code": "ML", "dial_code": "+223"},
  {"name": "Malta", "code": "MT", "dial_code": "+356"},
  {"name": "M̧ajeļ", "code": "MH", "dial_code": "+692"},
  {"name": "Martinique", "code": "MQ", "dial_code": "+596"},
  {"name": "موريتانيا", "code": "MR", "dial_code": "+222"},
  {"name": "Maurice", "code": "MU", "dial_code": "+230"},
  {"name": "Mayotte", "code": "YT", "dial_code": "+262"},
  {"name": "México", "code": "MX", "dial_code": "+52"},
  {"name": "Micronesia", "code": "FM", "dial_code": "+691"},
  {"name": "Moldova", "code": "MD", "dial_code": "+373"},
  {"name": "Monaco", "code": "MC", "dial_code": "+377"},
  {"name": "Монгол улс", "code": "MN", "dial_code": "+976"},
  {"name": "Црна Гора", "code": "ME", "dial_code": "+382"},
  {"name": "Montserrat", "code": "MS", "dial_code": "+1664"},
  {"name": "المغرب", "code": "MA", "dial_code": "+212"},
  {"name": "Moçambique", "code": "MZ", "dial_code": "+258"},
  {"name": "Myanma", "code": "MM", "dial_code": "+95"},
  {"name": "Namibia", "code": "NA", "dial_code": "+264"},
  {"name": "Nauru", "code": "NR", "dial_code": "+674"},
  {"name": "नपल", "code": "NP", "dial_code": "+977"},
  {"name": "Nederland", "code": "NL", "dial_code": "+31"},
  {"name": "Netherlands Antilles", "code": "AN", "dial_code": "+599"},
  {"name": "Nouvelle-Calédonie", "code": "NC", "dial_code": "+687"},
  {"name": "New Zealand", "code": "NZ", "dial_code": "+64"},
  {"name": "Nicaragua", "code": "NI", "dial_code": "+505"},
  {"name": "Niger", "code": "NE", "dial_code": "+227"},
  {"name": "Nigeria", "code": "NG", "dial_code": "+234"},
  {"name": "Niuē", "code": "NU", "dial_code": "+683"},
  {"name": "Norfolk Island", "code": "NF", "dial_code": "+672"},
  {"name": "Northern Mariana Islands", "code": "MP", "dial_code": "+1670"},
  {"name": "Norge", "code": "NO", "dial_code": "+47"},
  {"name": "عمان", "code": "OM", "dial_code": "+968"},
  {"name": "Pakistan", "code": "PK", "dial_code": "+92"},
  {"name": "Palau", "code": "PW", "dial_code": "+680"},
  {"name": "فلسطين", "code": "PS", "dial_code": "+970"},
  {"name": "Panamá", "code": "PA", "dial_code": "+507"},
  {"name": "Papua Niugini", "code": "PG", "dial_code": "+675"},
  {"name": "Paraguay", "code": "PY", "dial_code": "+595"},
  {"name": "Perú", "code": "PE", "dial_code": "+51"},
  {"name": "Pilipinas", "code": "PH", "dial_code": "+63"},
  {"name": "Pitcairn Islands", "code": "PN", "dial_code": "+64"},
  {"name": "Polska", "code": "PL", "dial_code": "+48"},
  {"name": "Portugal", "code": "PT", "dial_code": "+351"},
  {"name": "Puerto Rico", "code": "PR", "dial_code": "+1939"},
  {"name": "Puerto Rico", "code": "PR", "dial_code": "+1787"},
  {"name": "قطر", "code": "QA", "dial_code": "+974"},
  {"name": "România", "code": "RO", "dial_code": "+40"},
  {"name": "Россия", "code": "RU", "dial_code": "+7"},
  {"name": "Rwanda", "code": "RW", "dial_code": "+250"},
  {"name": "La Réunion", "code": "RE", "dial_code": "+262"},
  {"name": "Saint-Barthélemy", "code": "BL", "dial_code": "+590"},
  {"name": "Saint Helena", "code": "SH", "dial_code": "+290"},
  {"name": "Saint Kitts and Nevis", "code": "KN", "dial_code": "+1869"},
  {"name": "Saint Lucia", "code": "LC", "dial_code": "+1758"},
  {"name": "Saint-Martin", "code": "MF", "dial_code": "+590"},
  {"name": "Saint-Pierre-et-Miquelon", "code": "PM", "dial_code": "+508"},
  {"name": "Saint Vincent and the Grenadines", "code": "VC", "dial_code": "+1784"},
  {"name": "Samoa", "code": "WS", "dial_code": "+685"},
  {"name": "San Marino", "code": "SM", "dial_code": "+378"},
  {"name": "São Tomé e Príncipe", "code": "ST", "dial_code": "+239"},
  {"name": "العربية السعودية", "code": "SA", "dial_code": "+966"},
  {"name": "Sénégal", "code": "SN", "dial_code": "+221"},
  {"name": "Србија", "code": "RS", "dial_code": "+381"},
  {"name": "Seychelles", "code": "SC", "dial_code": "+248"},
  {"name": "Sierra Leone", "code": "SL", "dial_code": "+232"},
  {"name": "Singapore", "code": "SG", "dial_code": "+65"},
  {"name": "Slovensko", "code": "SK", "dial_code": "+421"},
  {"name": "Slovenija", "code": "SI", "dial_code": "+386"},
  {"name": "Solomon Islands", "code": "SB", "dial_code": "+677"},
  {"name": "Soomaaliya", "code": "SO", "dial_code": "+252"},
  {"name": "South Africa", "code": "ZA", "dial_code": "+27"},
  {"name": "South Sudan", "code": "SS", "dial_code": "+211"},
  {"name": "South Georgia", "code": "GS", "dial_code": "+500"},
  {"name": "España", "code": "ES", "dial_code": "+34"},
  {"name": "śrī laṃkāva", "code": "LK", "dial_code": "+94"},
  {"name": "السودان", "code": "SD", "dial_code": "+249"},
  {"name": "Suriname", "code": "SR", "dial_code": "+597"},
  {"name": "Svalbard og Jan Mayen", "code": "SJ", "dial_code": "+47"},
  {"name": "Swaziland", "code": "SZ", "dial_code": "+268"},
  {"name": "Sverige", "code": "SE", "dial_code": "+46"},
  {"name": "Schweiz", "code": "CH", "dial_code": "+41"},
  {"name": "سوريا", "code": "SY", "dial_code": "+963"},
  {"name": "臺灣", "code": "TW", "dial_code": "+886"},
  {"name": "Тоҷикистон", "code": "TJ", "dial_code": "+992"},
  {"name": "Tanzania", "code": "TZ", "dial_code": "+255"},
  {"name": "ประเทศไทย", "code": "TH", "dial_code": "+66"},
  {"name": "Timor-Leste", "code": "TL", "dial_code": "+670"},
  {"name": "Togo", "code": "TG", "dial_code": "+228"},
  {"name": "Tokelau", "code": "TK", "dial_code": "+690"},
  {"name": "Tonga", "code": "TO", "dial_code": "+676"},
  {"name": "Trinidad and Tobago", "code": "TT", "dial_code": "+1868"},
  {"name": "تونس", "code": "TN", "dial_code": "+216"},
  {"name": "Türkiye", "code": "TR", "dial_code": "+90"},
  {"name": "Türkmenistan", "code": "TM", "dial_code": "+993"},
  {"name": "Turks and Caicos Islands", "code": "TC", "dial_code": "+1649"},
  {"name": "Tuvalu", "code": "TV", "dial_code": "+688"},
  {"name": "Uganda", "code": "UG", "dial_code": "+256"},
  {"name": "Україна", "code": "UA", "dial_code": "+380"},
  {"name": "دولة الإمارات العربية المتحدة", "code": "AE", "dial_code": "+971"},
  {"name": "United Kingdom", "code": "GB", "dial_code": "+44"},
  {"name": "United States", "code": "US", "dial_code": "+1"},
  {"name": "Uruguay", "code": "UY", "dial_code": "+598"},
  {"name": "O‘zbekiston", "code": "UZ", "dial_code": "+998"},
  {"name": "Vanuatu", "code": "VU", "dial_code": "+678"},
  {"name": "Venezuela", "code": "VE", "dial_code": "+58"},
  {"name": "Việt Nam", "code": "VN", "dial_code": "+84"},
  {"name": "British Virgin Islands", "code": "VG", "dial_code": "+1284"},
  {"name": "United States Virgin Islands", "code": "VI", "dial_code": "+1340"},
  {"name": "Wallis et Futuna", "code": "WF", "dial_code": "+681"},
  {"name": "اليَمَن", "code": "YE", "dial_code": "+967"},
  {"name": "Zambia", "code": "ZM", "dial_code": "+260"},
  {"name": "Zimbabwe", "code": "ZW", "dial_code": "+263"}
];


// File: flutter/qi_bus_prokit/lib/store/AppStore.dart

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';


part 'AppStore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool isDarkModeOn = false;

  @observable
  bool isHover = false;

  @observable
  Color? iconColor;

  @observable
  Color? backgroundColor;

  @observable
  Color? appBarColor;

  @observable
  Color? scaffoldBackground;

  @observable
  Color? backgroundSecondaryColor;

  @observable
  Color? appColorPrimaryLightColor;

  @observable
  Color? iconSecondaryColor;

  @observable
  Color? textPrimaryColor;

  @observable
  Color? textSecondaryColor;

  @action
  Future<void> toggleDarkMode({bool? value}) async {
    isDarkModeOn = value ?? !isDarkModeOn;

    if (isDarkModeOn) {
      scaffoldBackground = appBackgroundColorDark;

      appBarColor = cardBackgroundBlackDark;
      backgroundColor = Colors.white;
      backgroundSecondaryColor = Colors.white;
      appColorPrimaryLightColor = cardBackgroundBlackDark;

      iconColor = iconColorPrimary;
      iconSecondaryColor = iconColorSecondary;

      textPrimaryColor = whiteColor;
      textSecondaryColor = Colors.white54;

      textPrimaryColorGlobal = whiteColor;
      textSecondaryColorGlobal = Colors.white54;
      shadowColorGlobal = appShadowColorDark;
    } else {
      scaffoldBackground = scaffoldLightColor;

      appBarColor = Colors.white;
      backgroundColor = Colors.black;
      backgroundSecondaryColor = appSecondaryBackgroundColor;
      appColorPrimaryLightColor = appColorPrimaryLight;

      iconColor = iconColorPrimaryDark;
      iconSecondaryColor = iconColorSecondaryDark;

      textPrimaryColor = appTextColorPrimary;
      textSecondaryColor = appTextColorSecondary;

      textPrimaryColorGlobal = appTextColorPrimary;
      textSecondaryColorGlobal = appTextColorSecondary;
      shadowColorGlobal = appShadowColor;
    }
    setStatusBarColor(scaffoldBackground!);

    setValue(isDarkModeOnPref, isDarkModeOn);
  }

  @action
  void toggleHover({bool value = false}) => isHover = value;
}


// File: flutter/qi_bus_prokit/lib/store/AppStore.g.dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on AppStoreBase, Store {
  final _$isDarkModeOnAtom = Atom(name: 'AppStoreBase.isDarkModeOn');

  @override
  bool get isDarkModeOn {
    _$isDarkModeOnAtom.reportRead();
    return super.isDarkModeOn;
  }

  @override
  set isDarkModeOn(bool value) {
    _$isDarkModeOnAtom.reportWrite(value, super.isDarkModeOn, () {
      super.isDarkModeOn = value;
    });
  }

  final _$isHoverAtom = Atom(name: 'AppStoreBase.isHover');

  @override
  bool get isHover {
    _$isHoverAtom.reportRead();
    return super.isHover;
  }

  @override
  set isHover(bool value) {
    _$isHoverAtom.reportWrite(value, super.isHover, () {
      super.isHover = value;
    });
  }

  final _$iconColorAtom = Atom(name: 'AppStoreBase.iconColor');

  @override
  Color? get iconColor {
    _$iconColorAtom.reportRead();
    return super.iconColor;
  }

  @override
  set iconColor(Color? value) {
    _$iconColorAtom.reportWrite(value, super.iconColor, () {
      super.iconColor = value;
    });
  }

  final _$backgroundColorAtom = Atom(name: 'AppStoreBase.backgroundColor');

  @override
  Color? get backgroundColor {
    _$backgroundColorAtom.reportRead();
    return super.backgroundColor;
  }

  @override
  set backgroundColor(Color? value) {
    _$backgroundColorAtom.reportWrite(value, super.backgroundColor, () {
      super.backgroundColor = value;
    });
  }

  final _$appBarColorAtom = Atom(name: 'AppStoreBase.appBarColor');

  @override
  Color? get appBarColor {
    _$appBarColorAtom.reportRead();
    return super.appBarColor;
  }

  @override
  set appBarColor(Color? value) {
    _$appBarColorAtom.reportWrite(value, super.appBarColor, () {
      super.appBarColor = value;
    });
  }

  final _$scaffoldBackgroundAtom =
      Atom(name: 'AppStoreBase.scaffoldBackground');

  @override
  Color? get scaffoldBackground {
    _$scaffoldBackgroundAtom.reportRead();
    return super.scaffoldBackground;
  }

  @override
  set scaffoldBackground(Color? value) {
    _$scaffoldBackgroundAtom.reportWrite(value, super.scaffoldBackground, () {
      super.scaffoldBackground = value;
    });
  }

  final _$backgroundSecondaryColorAtom =
      Atom(name: 'AppStoreBase.backgroundSecondaryColor');

  @override
  Color? get backgroundSecondaryColor {
    _$backgroundSecondaryColorAtom.reportRead();
    return super.backgroundSecondaryColor;
  }

  @override
  set backgroundSecondaryColor(Color? value) {
    _$backgroundSecondaryColorAtom
        .reportWrite(value, super.backgroundSecondaryColor, () {
      super.backgroundSecondaryColor = value;
    });
  }

  final _$appColorPrimaryLightColorAtom =
      Atom(name: 'AppStoreBase.appColorPrimaryLightColor');

  @override
  Color? get appColorPrimaryLightColor {
    _$appColorPrimaryLightColorAtom.reportRead();
    return super.appColorPrimaryLightColor;
  }

  @override
  set appColorPrimaryLightColor(Color? value) {
    _$appColorPrimaryLightColorAtom
        .reportWrite(value, super.appColorPrimaryLightColor, () {
      super.appColorPrimaryLightColor = value;
    });
  }

  final _$iconSecondaryColorAtom =
      Atom(name: 'AppStoreBase.iconSecondaryColor');

  @override
  Color? get iconSecondaryColor {
    _$iconSecondaryColorAtom.reportRead();
    return super.iconSecondaryColor;
  }

  @override
  set iconSecondaryColor(Color? value) {
    _$iconSecondaryColorAtom.reportWrite(value, super.iconSecondaryColor, () {
      super.iconSecondaryColor = value;
    });
  }

  final _$textPrimaryColorAtom = Atom(name: 'AppStoreBase.textPrimaryColor');

  @override
  Color? get textPrimaryColor {
    _$textPrimaryColorAtom.reportRead();
    return super.textPrimaryColor;
  }

  @override
  set textPrimaryColor(Color? value) {
    _$textPrimaryColorAtom.reportWrite(value, super.textPrimaryColor, () {
      super.textPrimaryColor = value;
    });
  }

  final _$textSecondaryColorAtom =
      Atom(name: 'AppStoreBase.textSecondaryColor');

  @override
  Color? get textSecondaryColor {
    _$textSecondaryColorAtom.reportRead();
    return super.textSecondaryColor;
  }

  @override
  set textSecondaryColor(Color? value) {
    _$textSecondaryColorAtom.reportWrite(value, super.textSecondaryColor, () {
      super.textSecondaryColor = value;
    });
  }

  final _$toggleDarkModeAsyncAction =
      AsyncAction('AppStoreBase.toggleDarkMode');

  @override
  Future<void> toggleDarkMode({bool? value}) {
    return _$toggleDarkModeAsyncAction
        .run(() => super.toggleDarkMode(value: value));
  }

  final _$AppStoreBaseActionController = ActionController(name: 'AppStoreBase');

  @override
  void toggleHover({bool value = false}) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.toggleHover');
    try {
      return super.toggleHover(value: value);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkModeOn: ${isDarkModeOn},
isHover: ${isHover},
iconColor: ${iconColor},
backgroundColor: ${backgroundColor},
appBarColor: ${appBarColor},
scaffoldBackground: ${scaffoldBackground},
backgroundSecondaryColor: ${backgroundSecondaryColor},
appColorPrimaryLightColor: ${appColorPrimaryLightColor},
iconSecondaryColor: ${iconSecondaryColor},
textPrimaryColor: ${textPrimaryColor},
textSecondaryColor: ${textSecondaryColor}
    ''';
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusHelp.dart
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';


class QIBusHelp extends StatefulWidget {
  static String tag = '/QIBusHelp';

  @override
  QIBusHelpState createState() => QIBusHelpState();
}

class QIBusHelpState extends State<QIBusHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        TopBar(
          QIBus_lbl_help,
          icon: qibus_gif_bell,
          isVisible: true,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: spacing_standard_new),
              child: Column(
                children: <Widget>[
                  editTextStyle(QIBus_hint_enter_your_contact_number),
                  16.height,
                  editTextStyle(QIBus_hint_enter_your_emailId),
                  16.height,
                  editTextStyle(QIBus_text_description, line: 3),
                  16.height,
                  QIBusAppButton(
                      textContent: QIBus_lbl_submit,
                      onPressed: () {
                        finish(context);
                      }),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusBooking.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

import '../main.dart';

class QIBusBooking extends StatefulWidget {
  @override
  QIBusBookingState createState() => QIBusBookingState();
}

class QIBusBookingState extends State<QIBusBooking> {
  int selectedPos = 1;
  late List<QIBusBookingModel> mList;
  late List<QIBusBookingModel> mList1;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mList = QIBusGetBook();
    mList1 = QIBusGetCancelBook();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: <Widget>[
        TopBar(QIBus_lbl_booking, icon: qibus_gif_bell, isVisible: false),
        Container(
          width: width,
          decoration: boxDecoration(radius: spacing_middle, bgColor: qIBus_view_color, showShadow: false),
          margin: EdgeInsets.only(right: spacing_standard_new, left: spacing_standard_new),
          child: Row(
            children: <Widget>[
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPos = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(spacing_middle), bottomLeft: Radius.circular(spacing_middle)),
                      color: selectedPos == 1
                          ? qIBus_colorPrimary
                          : appStore.isDarkModeOn
                              ? cardDarkColor
                              : Colors.transparent,
                      border: Border.all(color: selectedPos == 1 ? qIBus_colorPrimary : Colors.transparent),
                    ),
                    child: text(
                      QIBus_text_booked,
                      isCentered: true,
                      textColor: selectedPos == 1
                          ? qIBus_white
                          : appStore.isDarkModeOn
                              ? gray
                              : qIBus_textHeader,
                    ),
                  ),
                ),
                flex: 1,
              ),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPos = 2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(spacing_middle), bottomRight: Radius.circular(spacing_middle)),
                      color: selectedPos == 2
                          ? qIBus_colorPrimary
                          : appStore.isDarkModeOn
                              ? cardDarkColor
                              : Colors.transparent,
                      border: Border.all(color: selectedPos == 2 ? qIBus_colorPrimary : Colors.transparent),
                    ),
                    child: text(
                      QIBus_txt_cancelled,
                      isCentered: true,
                      textColor: selectedPos == 2
                          ? qIBus_white
                          : appStore.isDarkModeOn
                              ? gray
                              : qIBus_textHeader,
                    ),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        if (selectedPos == 1)
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: mList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Booking(mList[index], index);
                }),
          ),
        if (selectedPos == 2)
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: mList1.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CancelBooking(mList1[index], index);
                }),
          ),
      ],
    ));
  }
}

class Booking extends StatefulWidget {
  final QIBusBookingModel model;

  Booking(this.model, int index);

  @override
  BookingState createState() => new BookingState(model);
}

class BookingState extends State<Booking> {
  bool visibility = false;
  late QIBusBookingModel model;

  void _changed() {
    setState(() {
      visibility = !visibility;
    });
  }

  BookingState(QIBusBookingModel model) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
      decoration: boxDecoration(showShadow: true, bgColor: context.cardColor, radius: spacing_middle),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(spacing_middle),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                text(model.destination, fontFamily: fontMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    text(model.duration, textColor: qIBus_textChild),
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(text: model.totalFare, style: TextStyle(fontSize: textSizeMedium, color: qIBus_color_check)),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: qIBus_color_check,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: visibility,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: spacing_standard_new, bottom: spacing_standard_new),
                      color: appStore.isDarkModeOn ? cardDarkColor : qIBus_view_color,
                      child: Padding(
                        padding: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text(model.startTime),
                            Container(
                              height: 0.5,
                              width: width * 0.2,
                              color: qIBus_dark_gray,
                            ),
                            Column(
                              children: <Widget>[
                                SvgPicture.asset(
                                  qibus_ic_bus,
                                  width: 20,
                                  height: 20,
                                  color: qIBus_colorPrimary,
                                ),
                                text(model.totalTime)
                              ],
                            ),
                            Container(
                              height: 0.5,
                              width: width * 0.2,
                              color: qIBus_dark_gray,
                            ),
                            text(model.endTime),
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(spacing_middle),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ticketInfo(QIBus_text_seat_no, model.seatNo),
                                  ticketInfo(QIBus_txt_ticket_no, model.ticketNo),
                                  ticketInfo(QIBus_lbl_pnr_no, model.pnrNo),
                                  ticketInfo(QIBus_lbl_total_fare, model.status),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CachedNetworkImage(
                                placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                                imageUrl: model.img,
                                height: width * 0.25,
                                width: width * 0.25,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _changed();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.keyboard_arrow_up,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            replacement: GestureDetector(
              onTap: () {
                _changed();
              },
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: qIBus_icon_color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CancelBooking extends StatefulWidget {
  final QIBusBookingModel model;

  CancelBooking(this.model, int index);

  @override
  CancelBookingState createState() => new CancelBookingState(model);
}

class CancelBookingState extends State<CancelBooking> {
  bool visibility = false;
  late QIBusBookingModel model;

  void _changed() {
    setState(() {
      visibility = !visibility;
    });
  }

  CancelBookingState(QIBusBookingModel model) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
      decoration: boxDecoration(showShadow: true, bgColor: context.cardColor, radius: spacing_middle),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(spacing_middle),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                text(model.destination, fontFamily: fontMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    text(model.duration, textColor: qIBus_textChild),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: model.totalFare, style: TextStyle(fontSize: textSizeMedium, color: qIBus_red)),
                          WidgetSpan(child: Icon(Icons.cancel, color: qIBus_red, size: 16).paddingOnly(left: 4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: visibility,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: spacing_standard_new, bottom: spacing_standard_new),
                      color: appStore.isDarkModeOn ? cardDarkColor : qIBus_view_color,
                      child: Padding(
                        padding: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text(model.startTime),
                            Column(
                              children: <Widget>[
                                SvgPicture.asset(
                                  qibus_ic_bus,
                                  width: 20,
                                  height: 20,
                                  color: qIBus_colorPrimary,
                                ),
                                text(model.totalTime)
                              ],
                            ),
                            text(model.endTime),
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(spacing_middle),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ticketInfo(QIBus_text_seat_no, model.seatNo),
                                  ticketInfo(QIBus_txt_ticket_no, model.ticketNo),
                                  ticketInfo(QIBus_lbl_pnr_no, model.pnrNo),
                                  ticketInfo(QIBus_lbl_total_fare, model.status),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CachedNetworkImage(
                                placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                                imageUrl: model.img,
                                height: width * 0.25,
                                width: width * 0.25,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            _changed();
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.keyboard_arrow_up,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            replacement: GestureDetector(
              onTap: () {
                _changed();
              },
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: qIBus_icon_color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget ticketInfo(var label, var value) {
  return Row(
    children: <Widget>[
      Expanded(child: text(label), flex: 2),
      Expanded(child: text(value, textColor: qIBus_colorPrimary), flex: 3),
    ],
  );
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusSignIn.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';
import 'package:qi_bus_prokit/utils/codePicker/country_code_picker.dart';


import 'QIBusVerification.dart';

class QIBusSignIn extends StatefulWidget {
  static String tag = '/QIBusSignIn';

  @override
  QIBusSignInState createState() => QIBusSignInState();
}

class QIBusSignInState extends State<QIBusSignIn> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                text(QIBus_text_welcome_to, textColor: qIBus_textChild, fontFamily: fontBold, fontSize: textSizeLarge),
                text(QIBus_text_qibus, textColor: qIBus_colorPrimary, fontFamily: fontBold, fontSize: textSizeXLarge),
                CachedNetworkImage(
                  placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                  imageUrl: qibus_ic_travel,
                  height: width * 0.5,
                  width: width,
                  fit: BoxFit.contain,
                ),
                24.height,
                Container(
                    decoration: boxDecoration(showShadow: false, bgColor: context.cardColor, radius: 8, color: qIBus_colorPrimary),
                    padding: EdgeInsets.all(0),
                    child: Row(
                      children: <Widget>[
                        CountryCodePicker(onChanged: print, padding: EdgeInsets.all(0), showFlag: false),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: qIBus_colorPrimary,
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            style: TextStyle(fontSize: textSizeLargeMedium, fontFamily: fontRegular),
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: context.cardColor,
                              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              hintText: QIBus_hint_mobile,
                              hintStyle: TextStyle(color: qIBus_textChild, fontSize: textSizeMedium),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    )),
                16.height,
                QIBusAppButton(
                  textContent: QIBus_lbl_continue,
                  onPressed: () {
                    QIBusVerification().launch(context);
                  },
                ),
                28.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    text(QIBus_text_sign_In_with),
                    4.width,
                    Container(width: width * 0.4, height: 0.5, color: qIBus_view_color),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(qibus_ic_fb, height: 20, width: 20, color: qIBus_color_facebook),
                        8.width,
                        SvgPicture.asset(qibus_ic_google_fill, color: qIBus_color_google, height: 20, width: 20),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusEditProfile.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

class QIBusEditProfile extends StatefulWidget {
  static String tag = '/QIBusEditProfile';

  @override
  QIBusEditProfileState createState() => QIBusEditProfileState();
}

class QIBusEditProfileState extends State<QIBusEditProfile> {
  String? _selectedLocation = 'Male';

  final profileImg = new Container(
      alignment: FractionalOffset.center,
      child: new CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(qibus_ic_profile),
        radius: 50,
      ));

  Widget rowHeading(var label, var subLabel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: text(label, textColor: qIBus_textChild),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                isDense: true,
                hintText: subLabel,
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  Row rowHeading1(var label) {
    return Row(
      children: <Widget>[
        Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), child: text(label, fontFamily: fontMedium)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: qIBus_app_background,
        body: Column(
      children: <Widget>[
        TopBar(QIBus_lbl_edit_profile, icon: qibus_gif_bell, isVisible: true),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                profileImg,
                Container(
                    margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: spacing_standard_new),
                    decoration: boxDecoration(
                      showShadow: true,
                      bgColor: context.cardColor,
                      radius: spacing_middle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(spacing_standard, spacing_standard, spacing_standard, spacing_standard_new),
                      child: Column(
                        children: <Widget>[
                          rowHeading1(QIBus_title_edit_your_name),
                          SizedBox(height: spacing_standard),
                          rowHeading(QIBus_lbl_first_name, QIBus_txt_user_name),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 8),
                          rowHeading(QIBus_lbl_last_name, QIBus_text_user_last_name),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                            child: view(),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: text(QIBus_lbl_gender, textColor: qIBus_textChild),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _selectedLocation,
                                        items: <String>['Female', 'Male'].map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: text(value, fontSize: textSizeMedium, textColor: qIBus_textChild),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedLocation = newValue;
                                          });
                                        },
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, top: spacing_standard_new, bottom: spacing_standard_new),
                  decoration: boxDecoration(
                    showShadow: true,
                    bgColor: context.cardColor,
                    radius: spacing_middle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(spacing_standard, spacing_standard, spacing_standard, spacing_standard_new),
                    child: Column(
                      children: <Widget>[
                        rowHeading1(QIBus_title_edit_your_contact),
                        8.height,
                        rowHeading(QIBus_lbl_email, QIBus_txt_email_id),
                        view().paddingOnly(left: 16, top: 8, right: 16, bottom: 8),
                        8.height,
                        rowHeading(QIBus_text_phone, QIBus_text_user_phone),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new),
                  child: QIBusAppButton(
                    textContent: QIBus_text_save,
                    onPressed: () {
                      finish(context);
                    },
                  ),
                ),
                16.height,
              ],
            ),
          ),
        )
      ],
    ));
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusPickDrop.dart
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';
import '../main.dart';
import 'QIBusAddPassenger.dart';

class QIBusPickDrop extends StatefulWidget {
  static String tag = '/QIBusPickDrop';

  @override
  QIBusPickDropState createState() => QIBusPickDropState();
}

class QIBusPickDropState extends State<QIBusPickDrop> {
  int selectedPos = 1;
  late List<QIBusDroppingModel> mList;
  late List<QIBusDroppingModel> mList1;

  @override
  void initState() {
    super.initState();
    selectedPos = 1;
    mList = QIBusGetPickUp();
    mList1 = QIBusGetDroppingPoint();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      //   backgroundColor: qIBus_app_background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            title(QIBus_title_dropping, context),
            Container(
              width: width,
              decoration: boxDecoration(radius: spacing_middle, bgColor: qIBus_view_color, showShadow: false),
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPos = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(spacing_middle),
                            bottomLeft: Radius.circular(spacing_middle),
                          ),
                          color: selectedPos == 1
                              ? qIBus_colorPrimary
                              : appStore.isDarkModeOn
                                  ? cardDarkColor
                                  : Colors.transparent,
                          border: Border.all(color: selectedPos == 1 ? qIBus_colorPrimary : Colors.transparent),
                        ),
                        child: text(
                          QIBus_text_pickup_point,
                          isCentered: true,
                          textColor: selectedPos == 1
                              ? qIBus_white
                              : appStore.isDarkModeOn
                                  ? gray
                                  : qIBus_textHeader,
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPos = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(spacing_middle), bottomRight: Radius.circular(spacing_middle)),
                          color: selectedPos == 2
                              ? qIBus_colorPrimary
                              : appStore.isDarkModeOn
                                  ? cardDarkColor
                                  : Colors.transparent,
                          border: Border.all(color: selectedPos == 2 ? qIBus_colorPrimary : Colors.transparent),
                        ),
                        child: text(
                          QIBus_text_dropping_points,
                          isCentered: true,
                          textColor: selectedPos == 2
                              ? qIBus_white
                              : appStore.isDarkModeOn
                                  ? gray
                                  : qIBus_textHeader,
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            selectedPos == 1
                ? Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: mList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPos = 2;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
                                decoration: boxDecoration(radius: spacing_middle, showShadow: true, bgColor: context.cardColor),
                                padding: EdgeInsets.all(spacing_middle),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        text(mList[index].travelName, fontFamily: fontMedium),
                                        text(mList[index].duration, fontFamily: fontMedium),
                                      ],
                                    ),
                                    text(mList[index].location, textColor: qIBus_textChild)
                                  ],
                                ),
                              ),
                            )))
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mList1.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            QIBusAddPassenger().launch(context);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
                          decoration: boxDecoration(radius: spacing_middle, showShadow: true),
                          padding: EdgeInsets.all(spacing_middle),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  text(mList1[index].travelName, fontFamily: fontMedium),
                                  text(mList1[index].duration, fontFamily: fontMedium),
                                ],
                              ),
                              text(mList1[index].location, textColor: qIBus_textChild)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusReferEarn.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

class QIBusReferEarn extends StatefulWidget {
  static String tag = '/QIBusReferEarn';

  @override
  QIBusReferEarnState createState() => QIBusReferEarnState();
}

class QIBusReferEarnState extends State<QIBusReferEarn> {
  Widget mImg(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return CachedNetworkImage(
      placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
      imageUrl: qibus_ic_refer_and_earn,
      width: width * 0.4,
      height: width * 0.4,
    );
  }

  var mEarningLabel = text(QIBus_txtTotalEarning, fontFamily: fontMedium);
  var mEarningPriceLabel = text(QIBus__200, textColor: qIBus_colorPrimary, fontFamily: fontMedium, fontSize: textSizeNormal);

  Widget mCode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        text(QIBus_txtYourCode, textColor: qIBus_textChild),
        text(QIBus_lbl_2342340, textColor: qIBus_color_link_blue),
      ],
    );
  }

  var mGetLabel = text(QIBus_text_get_100_when_your_friend_complete_trip_with_us, fontSize: textSizeSmall, isLongText: true);

  Widget mLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        text(QIBus_txt_your_link, textColor: qIBus_textChild, fontSize: textSizeSMedium),
        text(QIBus_text_link, textColor: qIBus_color_link_blue, isLongText: true, maxLine: 2, fontSize: textSizeSMedium),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBar(QIBus_lbl_refer_and_earn, icon: qibus_gif_bell, isVisible: true),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(spacing_standard_new),
              child: Column(
                children: <Widget>[
                  mImg(context),
                  mEarningLabel,
                  mEarningPriceLabel,
                  SizedBox(
                    height: spacing_standard,
                  ),
                  mCode(),
                  mGetLabel,
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(qibus_ic_facebook, color: qIBus_color_facebook, height: 22, width: 22),
                      8.width,
                      Image.asset(qibus_ic_google, height: 22, width: 22, color: qIBus_colorPrimary),
                      8.width,
                      SvgPicture.asset(qibus_ic_twitter, height: 22, width: 22),
                      8.width,
                      SvgPicture.asset(qibus_ic_whatsapp, height: 22, width: 22),
                    ],
                  ),
                  16.height,
                  mLink()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusPayment.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';

import 'QIBusAddCard.dart';
import 'QIBusCards.dart';

class QIBusPayment extends StatefulWidget {
  static String tag = '/QIBusPayment';

  @override
  QIBusPaymentState createState() => QIBusPaymentState();
}

class QIBusPaymentState extends State<QIBusPayment> {
  late List<QIBusCardModel> mCardsList;

  @override
  void initState() {
    super.initState();
    mCardsList = QIBusGetPayment();
  }

  Widget mCards() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: mCardsList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Cards(mCardsList[index], index);
        });
  }

  Widget mOption(var icon, var lbl, {required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
        decoration: boxDecoration(radius: spacing_middle, bgColor: context.cardColor, showShadow: true),
        padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_standard_new, spacing_standard_new, spacing_standard_new),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(right: spacing_standard),
                      child: SvgPicture.asset(
                        icon,
                        color: qIBus_textHeader,
                        height: 18,
                        width: 18,
                      ),
                    ),
                  ),
                  TextSpan(text: lbl, style: TextStyle(fontFamily: fontMedium, fontSize: textSizeMedium, color: qIBus_textHeader)),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: qIBus_icon_color,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(color: qIBus_colorPrimary, height: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: qIBus_white),
                              onPressed: () {
                                finish(context);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(spacing_standard, 0, 0, 0),
                              child: text(QIBus_text_payment, textColor: qIBus_white, fontSize: textSizeNormal, fontFamily: fontBold),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            QIBusAddCard().launch(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: spacing_standard_new),
                            child: Icon(Icons.add_circle_outline, color: qIBus_white, size: 24),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: context.cardColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  mCards(),
                  mOption(qibus_ic_banking, QIBus_text_net_banking, onTap: () {}),
                  mOption(qibus_ic_cards, QIBus_text_credit_card, onTap: () {
                    QIBusAddCard().launch(context);
                  }),
                  mOption(qibus_ic_cards, QIBus_text_debit, onTap: () {
                    QIBusAddCard().launch(context);
                  }),
                  mOption(qibus_ic_wallet, QIBus_text_Mobilewallet, onTap: () {}),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusCards.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

class QIBusCards extends StatefulWidget {
  static String tag = '/QIBusCards';

  @override
  QIBusCardsState createState() => QIBusCardsState();
}

class QIBusCardsState extends State<QIBusCards> {
  late List<QIBusCardModel> mCards;

  @override
  void initState() {
    super.initState();
    mCards = QIBusGetCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBar(QIBus_lbl_cards, icon: qibus_gif_bell, isVisible: true),
          Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: mCards.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Cards(mCards[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Cards extends StatelessWidget {
  late QIBusCardModel model;

  Cards(QIBusCardModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(spacing_middle)),
            child: CachedNetworkImage(
              placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
              imageUrl: model.cardBg,
              height: width * 0.5,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spacing_standard_new),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: text(model.cardType, textColor: qIBus_white, fontSize: textSizeLargeMedium),
                ),
                SizedBox(height: width * 0.15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    text(model.txtDigit1, textColor: qIBus_white, fontSize: textSizeLargeMedium),
                    16.height,
                    text(model.txtDigit2, textColor: qIBus_white, fontSize: textSizeLargeMedium),
                    16.height,
                    text(model.txtDigit3, textColor: qIBus_white, fontSize: textSizeLargeMedium),
                    16.height,
                    text(model.txtDigit4, textColor: qIBus_white, fontSize: textSizeLargeMedium),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        text(QIBus_text_valid, textColor: qIBus_white),
                        8.width,
                        text(model.mValidDate, textColor: qIBus_white),
                      ],
                    ),
                    text(model.txtHolderName, textColor: qIBus_white, textAllCaps: true),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusSetting.dart
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

import '../main.dart';

class QIBusSetting extends StatefulWidget {
  static String tag = '/QIBusSetting';

  @override
  QIBusSettingState createState() => QIBusSettingState();
}

class QIBusSettingState extends State<QIBusSetting> {
  bool mEmailNotification = false;
  bool mContactNotification = false;
  String _selectedLocation = 'English';
  String _selectedLocation1 = 'India';
  List<String> language = <String>['English', 'Arabic', 'French'];
  List<String> country = <String>['India', 'United State', 'Canada'];

  Widget mSetting(var heading, var subLabel, var value) {
    return Container(
      decoration: boxDecoration(showShadow: true, bgColor: context.cardColor),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(spacing_standard, spacing_standard_new, spacing_standard, spacing_standard_new),
      margin: EdgeInsets.only(
        left: spacing_standard_new,
        right: spacing_standard_new,
        bottom: spacing_standard_new,
        top: spacing_standard_new,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          text(heading, fontFamily: fontMedium).paddingOnly(left: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              text(subLabel, textColor: qIBus_textChild).paddingAll(16),
              Switch(
                value: value,
                onChanged: (value) {
                  setState(
                    () {
                      value = value;
                    },
                  );
                },
                activeTrackColor: qIBus_colorPrimary,
                activeColor: qIBus_view_color,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget mSeeting1(var heading, var subLabel, List<String> a, String? value) {
    return Container(
      decoration: boxDecoration(showShadow: true),
      padding: EdgeInsets.all(spacing_standard_new),
      margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: const EdgeInsets.fromLTRB(spacing_standard, 0, spacing_standard, 0), child: text(heading, fontFamily: fontMedium)),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, spacing_standard, 16, spacing_standard),
                child: text(subLabel, textColor: qIBus_textChild),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  items: a.map(
                    (String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: text(value, fontSize: textSizeMedium, textColor: qIBus_textChild),
                      );
                    },
                  ).toList(),
                  onChanged: (newValue) {
                    setState(
                      () {
                        value = newValue;
                      },
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBar(QIBus_text_settings, icon: qibus_gif_bell, isVisible: true),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    mSetting(QIBus_title_email_notification_settings, QIBus_txt_email_notification, mEmailNotification),
                    mSetting(QIBus_lbl_contact_number_settings, QIBus_lbl_number_notification, mContactNotification),
                    Container(
                      decoration: boxDecoration(showShadow: true, bgColor: context.cardColor),
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(spacing_standard, spacing_standard_new, spacing_standard, spacing_standard_new),
                      margin: EdgeInsets.only(
                        left: spacing_standard_new,
                        right: spacing_standard_new,
                        bottom: spacing_standard_new,
                        top: spacing_standard_new,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text('Theme Setting', fontFamily: fontMedium).paddingOnly(left: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              text('Dark Mode', textColor: qIBus_textChild).paddingAll(16),
                              Switch(
                                value: appStore.isDarkModeOn,
                                activeColor: appColorPrimary,
                                onChanged: (s) {
                                  appStore.toggleDarkMode(value: s);
                                },
                              )

                            ],
                          )
                        ],
                      ),
                    ),
                    mSeeting1(QIBus_title_language_setting, QIBus_lbl_language, language, _selectedLocation),
                    mSeeting1(QIBus_text_country, QIBus_title_country_settings, country, _selectedLocation1),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusPackages.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusSlider.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';
import 'package:qi_bus_prokit/utils/flutter_rating_bar.dart';


import 'QIBusViewPackage.dart';
import 'package:nb_utils/nb_utils.dart';

class QIBusPackages extends StatefulWidget {
  static String tag = '/QIBusPackages';

  @override
  QIBusPackagesState createState() => QIBusPackagesState();
}

class QIBusPackagesState extends State<QIBusPackages> {
  var currentIndexPage = 0;

  late List<QIBusNewPackageModel> mList1;

  @override
  void initState() {
    super.initState();
    mList1 = QIBusGetPackage();
  }

  Widget mHeading(var label, var subLabel) {
    return Container(
      margin: EdgeInsets.fromLTRB(spacing_standard_new, 0, spacing_standard_new, spacing_standard_new),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          text(label, fontFamily: fontMedium),
          GestureDetector(
            onTap: () {
              QIBusViewPackage().launch(context);
            },
            child: text(subLabel, textColor: qIBus_textChild),
          )
        ],
      ),
    );
  }

  Widget mPackages(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 30;
    final Size cardSize = Size(width, width * 0.71);

    return QiBusCarouselSlider(
      viewportFraction: 0.8,
      height: cardSize.height,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      items: mList1.map((list) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: cardSize.height,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: boxDecoration(radius: spacing_middle, bgColor: context.cardColor, showShadow: true),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(spacing_middle), topLeft: Radius.circular(spacing_middle)),
                    child: CachedNetworkImage(
                      placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                      imageUrl: list.image,
                      height: width * 0.32,
                      width: width,
                      fit: BoxFit.fill,
                    ),
                  ).expand(),
                  Padding(
                    padding: EdgeInsets.all(spacing_middle),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text(list.destination, fontFamily: fontMedium),
                            text(list.newPrice, textColor: qIBus_colorPrimary),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text(list.duration, textColor: qIBus_textChild),
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  qibus_ic_home_package,
                                  color: qIBus_icon_color,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: spacing_control_half),
                                SvgPicture.asset(
                                  qibus_ic_bus,
                                  color: qIBus_icon_color,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: spacing_control_half),
                                SvgPicture.asset(
                                  qibus_ic_restaurant,
                                  color: qIBus_icon_color,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(width: spacing_control_half),
                                SvgPicture.asset(
                                  qibus_ic_wifi,
                                  color: qIBus_icon_color,
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            )
                          ],
                        ),
                        RatingBar(
                          initialRating: 5,
                          minRating: 1,
                          itemSize: 16,
                          direction: Axis.horizontal,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(Icons.star, color: qIBus_rating),
                          onRatingUpdate: (rating) {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      }).toList(),
      onPageChanged: (index) {
        setState(() {
          currentIndexPage = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: qIBus_app_background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopBar(QIBus_lbl_packages, icon: qibus_gif_bell, isVisible: false),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    mHeading(QIBus_txt_new_package, QIBus_txt_view_all),
                    mPackages(context),
                    SizedBox(height: spacing_standard_new),
                    mHeading(QIBus_txt_popular_package, QIBus_txt_view_all),
                    mPackages(context),
                    SizedBox(height: spacing_standard_new),
                    mHeading(QIBus_text_trending_packages, QIBus_txt_view_all),
                    mPackages(context),
                    SizedBox(height: spacing_standard_new),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusNotification.dart
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';


class QIBusNotification extends StatefulWidget {
  static String tag = '/QIBusNotification';

  @override
  QIBusNotificationState createState() => QIBusNotificationState();
}

class QIBusNotificationState extends State<QIBusNotification> {
  late List<QIBusBookingModel> mList;

  @override
  void initState() {
    super.initState();
    mList = QIBusGetNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //    backgroundColor: qIBus_app_background,
      body: SafeArea(
        child: Column(
          children: [
            title(QIBus_lbl_notification, context),
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: mList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Notification(mList[index], index);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Notification extends StatelessWidget {
  late QIBusBookingModel model;

  Notification(QIBusBookingModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      decoration: boxDecoration(
        showShadow: true,
        radius: spacing_middle,
      ),
      padding: EdgeInsets.all(spacing_middle),
      margin: EdgeInsets.only(bottom: spacing_standard_new, right: spacing_standard_new, left: spacing_standard_new),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: w * 0.2,
            height: w * 0.2,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: qIBus_colorPrimary, width: spacing_control_half)),
            child: Center(child: Text("28 May", style: boldTextStyle(size: 14))),
          ),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(model.destination, fontFamily: fontMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: model.totalFare, style: TextStyle(fontSize: textSizeMedium, color: qIBus_color_check)),
                        WidgetSpan(
                          child: Icon(Icons.check_circle, color: qIBus_color_check, size: 16).paddingOnly(left: spacing_standard),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusHome.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/screen/QIBusNotification.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

import 'QIBusSearhList.dart';
import 'QIBusViewOffer.dart';

class QIBusHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QIBusHomeState();
  }
}

class QIBusHomeState extends State<QIBusHome> {
  var isSelected = 0;
  late List<QIBusBookingModel> mRecentList;
  late List<QIBusNewOfferModel> mOfferList;
  var now = new DateTime.now();
  var count = 1;
  var formatter = new DateFormat('dd - MMM - yyyy');
  String? formatted;

  @override
  void initState() {
    super.initState();
    mRecentList = QIBusGetData();
    mOfferList = QIBusGetOffer();
    formatted = formatter.format(now);
  }

  Widget mToolbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        text(QIBus_home, textColor: qIBus_white, fontFamily: fontBold, fontSize: textSizeLargeMedium),
        GestureDetector(
          onTap: () {
            QIBusNotification().launch(context);
          },
          child: Image(image: AssetImage(qibus_gif_bell), height: 25, width: 25, color: qIBus_white),
        )
      ],
    );
  }

  var mTopSearch = Row(
    children: <Widget>[
      Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: qIBus_colorPrimary, border: Border.all(width: 0, color: qIBus_colorPrimary)),
            width: 20,
            height: 20,
          ),
          Container(height: 30, width: 0.5, color: qIBus_colorPrimary),
          SvgPicture.asset(qibus_ic_pin, color: qIBus_colorPrimary),
        ],
      ),
      SizedBox(width: spacing_standard_new),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            homeEditTextStyle(QIBus_hint_from_city),
            view(),
            homeEditTextStyle(QIBus_hint_to_city),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: qIBus_colorPrimary, border: Border.all(width: 0, color: qIBus_colorPrimary)),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Image.asset(
            qibus_ic_wrap,
            color: qIBus_white,
            width: 20,
            height: 20,
          ),
        ),
      )
    ],
  );

  Widget mOption(var icon, var name, var pos) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = pos;
        });
      },
      child: Column(
        children: <Widget>[
          SizedBox(height: spacing_standard),
          SvgPicture.asset(icon, color: isSelected == pos ? qIBus_colorPrimary : qIBus_icon_color, height: 18, width: 18),
          SizedBox(height: 4),
          text(name, fontSize: textSizeSmall, textColor: isSelected == pos ? qIBus_colorPrimary : qIBus_textChild)
        ],
      ),
    );
  }

  Widget mSelection(var date) {
    return Stack(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.width * 0.25,
            margin: EdgeInsets.only(left: 16, right: 16),
            decoration: boxDecoration(radius: 8, bgColor: context.cardColor, showShadow: true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      text(QIBus_text_when_you_want_to_go, textColor: qIBus_textChild),
                      SizedBox(height: spacing_standard),
                      GestureDetector(
                        onTap: () {},
                        child: RichText(
                            text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: SvgPicture.asset(
                                  qibus_ic_calender,
                                  color: qIBus_icon_color,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                            TextSpan(text: date, style: TextStyle(fontFamily: fontMedium, fontSize: textSizeMedium, color: qIBus_colorPrimary)),
                          ],
                        )),
                      )
                    ],
                  ),
                ).expand(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 6, 8, 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_drop_up,
                        color: qIBus_icon_color,
                      ).onTap(() {
                        setState(() {
                          count = count + 1;
                        });
                      }),
                      text("$count", textColor: qIBus_colorPrimary),
                      count == 1
                          ? Icon(Icons.arrow_drop_down, color: qIBus_white)
                          : Icon(
                              Icons.arrow_drop_down,
                              color: qIBus_icon_color,
                            ).onTap(() {
                              setState(() {
                                if (count == 1 || count < 1) {
                                  count = 1;
                                } else {
                                  count = count - 1;
                                }
                              });
                            }),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    QIBusSearchList().launch(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: boxDecoration(bgColor: qIBus_colorPrimary, radius: 10.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.search,
                        color: qIBus_white,
                      ),
                    ),
                  ),
                )
              ],
            ))
      ],
    );
  }

  var mRecentSearchLbl = Container(
    margin: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
    child: text(QIBus_text_recent_search, fontFamily: fontMedium),
  );

  Widget mNewOfferLbl() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          text(QIBus_txt_new_offers, fontFamily: fontMedium),
          GestureDetector(
            onTap: () {
              QIBusViewOffer().launch(context);
            },
            child: text(QIBus_txt_view_all, textColor: qIBus_textChild),
          )
        ],
      ),
    );
  }

  Widget mRecentSearch(BuildContext context) {
    return SizedBox(
//      height: width * 0.4,
      height: 155,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mRecentList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return RecentSearch(mRecentList[index], index);
          }),
    );
  }

  Widget mOffer(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mOfferList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return NewOffer(mOfferList[index], index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(qIBus_colorPrimary);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(color: qIBus_colorPrimary, height: width * 0.3),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(left: 16, right: 16), child: mToolbar()),
                  SizedBox(height: 16),
                  Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      decoration: boxDecoration(radius: 8, bgColor: context.cardColor, showShadow: false),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          mTopSearch,
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: spacing_standard_new, top: spacing_standard_new),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                mOption(qibus_ic_ac, QIBus_lbl_ac, 1),
                                mOption(qibus_ic_non_ac, QIBus_lbl_non_ac, 2),
                                mOption(qibus_ic_sleeper_icon, QIBus_lbl_sleeper, 3),
                                mOption(qibus_ic_seater, QIBus_lbl_seater, 4),
                              ],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  mSelection(formatted),
                  mRecentSearchLbl,
                  mRecentSearch(context),
                  mNewOfferLbl(),
                  mOffer(context),
                  SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

// ignore: must_be_immutable
class RecentSearch extends StatelessWidget {
  late QIBusBookingModel model;

  RecentSearch(QIBusBookingModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      decoration: boxDecoration(showShadow: true, bgColor: context.cardColor, radius: spacing_middle),
      margin: EdgeInsets.only(left: spacing_standard_new),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(spacing_middle, spacing_standard_new, spacing_standard_new, spacing_standard),
            child: RichText(
                text: TextSpan(
              children: [
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.only(right: spacing_middle),
                    child: SvgPicture.asset(qibus_ic_bus, color: qIBus_colorPrimary, height: 18, width: 18),
                  ),
                ),
                TextSpan(text: model.destination, style: TextStyle(fontSize: textSizeMedium, color: qIBus_textHeader, fontFamily: fontMedium)),
              ],
            )),
          ),
          SizedBox(
            height: spacing_control,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(spacing_middle, 0, spacing_standard_new, 14),
            child: text(model.duration, textColor: qIBus_textChild),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                padding: const EdgeInsets.all(0.0),
                textStyle: TextStyle(color: qIBus_white),
              ),
              onPressed: () {
                QIBusSearchList().launch(context);
              },
              child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0)), color: qIBus_colorPrimary),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      QIBus_text_book_now,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NewOffer extends StatelessWidget {
  late QIBusNewOfferModel model;

  NewOffer(QIBusNewOfferModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      margin: EdgeInsets.only(left: spacing_standard_new),
      decoration: boxDecoration(showShadow: true, bgColor: context.cardColor, radius: spacing_middle),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(spacing_middle), topLeft: Radius.circular(spacing_middle)),
            child: Stack(
              children: <Widget>[
                Container(
                  color: model.color,
                  child: CachedNetworkImage(
                    placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                    imageUrl: model.img,
                    height: 130,
                    fit: BoxFit.none,
                    width: width,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              text(QIBus_lbl_use_code, fontFamily: fontMedium),
              SizedBox(
                width: spacing_control_half,
              ),
              text(model.useCode, textAllCaps: true, fontFamily: fontMedium),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusSplash.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';

import 'QIBusSignIn.dart';

class QIBusSplash extends StatefulWidget {
  static String tag = '/QIBusSplash';

  @override
  QIBusSplashState createState() => QIBusSplashState();
}

class QIBusSplashState extends State<QIBusSplash> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    QIBusSignIn().launch(context);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Image(image: AssetImage(qibus_ic_logo), width: width * 0.3, height: width * 0.3).center(),
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusViewOffer.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

class QIBusViewOffer extends StatefulWidget {
  static String tag = '/QIBusViewOffer';

  @override
  QIBusViewOfferState createState() => QIBusViewOfferState();
}

class QIBusViewOfferState extends State<QIBusViewOffer> {
  late List<QIBusNewOfferModel> mOfferList;

  @override
  void initState() {
    super.initState();
    mOfferList = QIBusGetOffer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //   backgroundColor: qIBus_app_background,
        body: Column(
      children: <Widget>[
        TopBar(
          QIBus_text_offers,
          icon: qibus_gif_bell,
          isVisible: true,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: mOfferList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return NewOffer(mOfferList[index], index);
                }),
          ),
        )
      ],
    ));
  }
}

// ignore: must_be_immutable
class NewOffer extends StatelessWidget {
  late QIBusNewOfferModel model;

  NewOffer(QIBusNewOfferModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
      decoration: boxDecoration(showShadow: true, bgColor: context.cardColor, radius: spacing_middle),
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(spacing_middle),
                topLeft: Radius.circular(spacing_middle),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: model.color,
                    child: CachedNetworkImage(
                      placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                      imageUrl: model.img,
                      height: width * 0.3,
                      fit: BoxFit.none,
                      width: width,
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              text(QIBus_lbl_use_code, fontFamily: fontMedium),
              SizedBox(
                width: spacing_control_half,
              ),
              text(model.useCode, textAllCaps: true, fontFamily: fontMedium),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusMore.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

import '../main.dart';
import 'QIBusCards.dart';
import 'QIBusEditProfile.dart';
import 'QIBusHelp.dart';
import 'QIBusReferEarn.dart';
import 'QIBusSetting.dart';
import 'QIBusWallet.dart';

class QIBusMore extends StatefulWidget {
  @override
  QIBusMoreState createState() => QIBusMoreState();
}

class QIBusMoreState extends State<QIBusMore> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBar("More", icon: qibus_gif_bell, isVisible: false),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  mOption(qibus_ic_user, QIBus_lbl_edit_profile, onTap: () {
                    QIBusEditProfile().launch(context);
                  }),
                  mOption(qibus_ic_wallet, QIBus_lbl__wallet, onTap: () {
                    QIBusWallet().launch(context);
                  }),
                  mOption(qibus_ic_card_line, QIBus_lbl_cards, onTap: () {
                    QIBusCards().launch(context);
                  }),
                  mOption(qibus_ic_refer, QIBus_lbl_refer_and_earn, onTap: () {
                    QIBusReferEarn().launch(context);
                  }),
                  mOption(qibus_ic_setting, QIBus_text_settings, onTap: () {
                    QIBusSetting().launch(context);
                  }),
                  mOption(qibus_ic_help, QIBus_lbl_help, onTap: () {
                    QIBusHelp().launch(context);
                  }),
                  Container(
                    margin: EdgeInsets.only(
                      left: spacing_standard_new,
                      right: spacing_standard_new,
                      bottom: spacing_standard_new,
                    ),
                    decoration: boxDecoration(radius: spacing_middle, bgColor: context.cardColor, showShadow: true),
                    padding: EdgeInsets.fromLTRB(
                      spacing_standard_new,
                      spacing_standard_new,
                      spacing_standard_new,
                      spacing_standard_new,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: spacing_standard),
                                  child: SvgPicture.asset(
                                    qibus_ic_logout,
                                    color: appStore.isDarkModeOn ? white : qIBus_textHeader,
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: QIBus_text_logout,
                                style: TextStyle(
                                  fontSize: textSizeMedium,
                                  color: appStore.isDarkModeOn ? white : qIBus_textHeader,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right, color: appStore.isDarkModeOn ? white : qIBus_icon_color)
                      ],
                    ),
                  ).onTap(
                    () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => LogoutDialog(),
                      );
                    },
                  ),
                  16.height,
                  CachedNetworkImage(
                    placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                    imageUrl: qibus_ic_buslogo,
                    width: width * 0.2,
                  ),
                  text(QIBus_text_version_1_0, textColor: qIBus_textChild)
                ],
              ).paddingOnly(bottom: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget mOption(var icon, var lbl, {required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
        decoration: boxDecoration(radius: spacing_middle, bgColor: context.cardColor, showShadow: true),
        padding: EdgeInsets.fromLTRB(spacing_standard_new, spacing_standard_new, spacing_standard_new, spacing_standard_new),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(right: spacing_standard),
                      child: SvgPicture.asset(
                        icon,
                        color: appStore.isDarkModeOn ? white : qIBus_textHeader,
                        height: 18,
                        width: 18,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: lbl,
                    style: TextStyle(fontFamily: fontMedium, fontSize: textSizeMedium, color: appStore.isDarkModeOn ? white : qIBus_textHeader),
                  ),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_right, color: appStore.isDarkModeOn ? white : qIBus_icon_color)
          ],
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(spacing_middle)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

dialogContent(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(spacing_standard_new),
    decoration: new BoxDecoration(
      color: context.cardColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(spacing_middle),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: const Offset(0.0, 10.0)),
      ],
    ),
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        text(QIBus_text_confirmation, maxLine: 2, isLongText: true, fontFamily: fontMedium, fontSize: textSizeNormal),
        text(
          QIBus_msg_logout,
        ),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            text(QIBus_text_no, textColor: qIBus_blue).onTap(
              () {
                finish(context);
              },
            ),
            SizedBox(width: spacing_standard_new),
            text(QIBus_text_yes, textColor: qIBus_blue).onTap(
              () {
                finish(context);
              },
            )
          ],
        )
      ],
    ),
  );
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusAddCard.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

import '../main.dart';


class QIBusAddCard extends StatefulWidget {
  static String tag = '/QIBusAddCard';

  @override
  QIBusAddCardState createState() => QIBusAddCardState();
}

class QIBusAddCardState extends State<QIBusAddCard> {
  Widget mLabel(var label) {
    return text(label, fontFamily: fontMedium);
  }

  bool passwordVisible = true;
  String _selectedLocation = '4';
  String _selectedLocation1 = '2020';
  List<String> month = <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
  List<String> year = <String>['2020', '2021', '2022', '2023', '2024', '2025', '2026', '2027', '2028'];

  Widget mSelection(var heading, List<String> list, String? value) {
    return Container(
        padding: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new),
        decoration: BoxDecoration(
          border: Border.all(color: qIBus_view_color, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(spacing_middle)),
          color: appStore.isDarkModeOn ? cardDarkColor : white,
        ),
        child: Row(
          children: <Widget>[
            text(heading, textColor: qIBus_textChild),
            SizedBox(
              width: spacing_standard_new,
            ),
            DropdownButtonHideUnderline(
                child: DropdownButton<String>(
              value: value,
              items: list.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: text(value, fontSize: textSizeMedium, textColor: qIBus_textChild),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ))
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          title(QIBus_text_add_card, context),
          Expanded(
            child: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.all(spacing_standard_new),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  mLabel(QIBus_hint_card_number),
                  SizedBox(height: spacing_control),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: pinEditTextStyle("4324"),
                      ),
                      Expanded(
                        child: pinEditTextStyle("4324"),
                      ),
                      Expanded(
                        child: pinEditTextStyle("4324"),
                      ),
                      Expanded(
                        child: pinEditTextStyle("4324"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: spacing_standard_new,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      mSelection("Month", month, _selectedLocation),
                      SizedBox(
                        width: spacing_standard_new,
                      ),
                      mSelection("Year", year, _selectedLocation1),
                    ],
                  ),
                  SizedBox(
                    height: spacing_standard_new,
                  ),
                  mLabel(QIBus_text_card_holder_name),
                  SizedBox(
                    height: spacing_standard,
                  ),
                  editTextStyle(QIBus_text_card_holder_name),
                  SizedBox(
                    height: spacing_standard_new,
                  ),
                  mLabel(QIBus_text_cvv),
                  SizedBox(
                    height: spacing_control,
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: TextFormField(
                        maxLines: 1,
                        inputFormatters: [new LengthLimitingTextInputFormatter(3), FilteringTextInputFormatter.digitsOnly],
                        obscureText: true,
                        style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(spacing_standard_new, 16, 4, 16),
                          hintText: QIBus_text_cvv,
                          filled: true,
                          fillColor: appStore.isDarkModeOn ? cardDarkColor : white,
                          suffixIcon: new GestureDetector(
                            onTap: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            child: new Icon(
                              passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: qIBus_icon_color,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(spacing_middle),
                            borderSide: const BorderSide(color: qIBus_view_color, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(spacing_middle),
                            borderSide: const BorderSide(color: qIBus_view_color, width: 0.0),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: spacing_standard_new,
                  ),
                  mLabel(QIBus_text_offer_code),
                  SizedBox(
                    height: spacing_control,
                  ),
                  editTextStyle(QIBus_text_offer_code),
                  SizedBox(
                    height: spacing_standard_new,
                  ),
                  Container(
                    padding: EdgeInsets.all(spacing_standard_new),
                    decoration: boxDecoration(showShadow: true),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: text(QIBus_text_pickup_point, fontFamily: fontMedium),
                              flex: 2,
                            ),
                            Expanded(
                              child: text(QIBus_lbl_pickup1, textColor: qIBus_textChild),
                              flex: 2,
                            )
                          ],
                        ),
                        SizedBox(
                          height: spacing_standard,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: text(QIBus_text_dropping_points, fontFamily: fontMedium),
                              flex: 2,
                            ),
                            Expanded(
                              child: text(QIBus_lbl_dropping1, textColor: qIBus_textChild),
                              flex: 2,
                            )
                          ],
                        ),
                        SizedBox(
                          height: spacing_standard,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: text(QIBus_text_total_amount, fontFamily: fontMedium, textColor: qIBus_colorPrimary),
                              flex: 2,
                            ),
                            Expanded(
                              child: text(QIBus_lbl_price1, textColor: qIBus_colorPrimary),
                              flex: 2,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: spacing_standard_new),
                  QIBusAppButton(
                    textContent: QIBus_text_ticket_book,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(),
                      );
                    },
                  ),
                ],
              ),
            )),
          )
        ],
      )),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

Container pinEditTextStyle(var hintText, {var line = 1}) {
  return Container(
      margin: EdgeInsets.only(right: 8),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextFormField(
        maxLines: line,
        inputFormatters: [new LengthLimitingTextInputFormatter(4), FilteringTextInputFormatter.digitsOnly],
        style: TextStyle(
          fontSize: textSizeMedium,
          fontFamily: fontRegular,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(spacing_standard_new, 16, 4, 16),
          hintText: hintText,
          filled: true,
          fillColor: appStore.isDarkModeOn ? cardDarkColor : white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing_middle),
            borderSide: BorderSide(color: qIBus_view_color, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(spacing_middle),
            borderSide: const BorderSide(color: qIBus_view_color, width: 0.0),
          ),
        ),
      ));
}

dialogContent(BuildContext context) {
  return Container(
    decoration: new BoxDecoration(
      color: context.cardColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min, // To make the card compact
      children: <Widget>[
        SizedBox(height: spacing_large),
        Icon(
          Icons.check_circle,
          color: qIBus_color_check,
          size: 50,
        ),
        SizedBox(height: spacing_standard_new),
        text(QIBus_text_payment_success, fontFamily: fontMedium),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(QIBus_msg_success, style: secondaryTextStyle(color: qIBus_textChild, size: 16), textAlign: TextAlign.center),
        ),
        SizedBox(height: spacing_standard_new),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(spacing_standard_new), bottomRight: Radius.circular(spacing_standard_new)), color: qIBus_color_check),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: spacing_middle, bottom: spacing_middle),
          child: text(QIBus_text_close, textColor: qIBus_white, fontFamily: fontMedium, isCentered: true),
        ).onTap(
          () {
            finish(context);
          },
        )
      ],
    ),
  );
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusWallet.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';


class QIBusWallet extends StatefulWidget {
  static String tag = '/QIBusWallet';

  @override
  QIBusWalletState createState() => QIBusWalletState();
}

class QIBusWalletState extends State<QIBusWallet> {
  var mLabel1 = text(QIBus_lbl_your_wallet_in_balance);
  var mPriceLabel = RichText(
    text: TextSpan(
      children: [
        WidgetSpan(
          child: Icon(Icons.account_balance_wallet, color: qIBus_colorPrimary, size: 16).paddingSymmetric(horizontal: 4),
        ),
        TextSpan(text: QIBus__200, style: TextStyle(fontSize: textSizeLarge, color: qIBus_colorPrimary)),
      ],
    ),
  );
  var mLabel3 = text(QIBus_lbl_wallet, fontFamily: fontMedium);

  Widget mSocialIcon(var icon, BuildContext context, {var color}) {
    var w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(right: spacing_standard_new),
      child: SvgPicture.asset(icon, height: w * 0.1, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBar(QIBus_lbl__wallet, icon: qibus_gif_bell, isVisible: true),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                    imageUrl: qibus_ic_gr_wallet,
                    width: w * 0.4,
                    height: w * 0.4,
                  ),
                  16.height,
                  mLabel1,
                  8.height,
                  mPriceLabel,
                  8.height,
                  mLabel3,
                  24.height,
                  view(),
                  24.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      mSocialIcon(qibus_ic_whatsapp, context),
                      mSocialIcon(qibus_ic_fb, context),
                      mSocialIcon(qibus_ic_google_fill, context, color: qIBus_color_google),
                      mSocialIcon(qibus_ic_twitter, context),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusSearhList.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';
import 'package:qi_bus_prokit/utils/flutter_rating_bar.dart';

import '../main.dart';
import 'QIBusSelectSeat.dart';

class QIBusSearchList extends StatefulWidget {
  static String tag = '/QIBusSearchList';

  @override
  QIBusSearchListState createState() => QIBusSearchListState();
}

class QIBusSearchListState extends State<QIBusSearchList> {
  String selectedValue = 'High';
  var now = new DateTime.now();
  var todayDate = DateTime.now();
  var formatter = new DateFormat('dd - MMM - yyyy');
  String? formatted;

  late List<QIBusModel> mList;

  @override
  void initState() {
    super.initState();
    mList = QIBusGetBusList();
    formatted = formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: qIBus_app_background,
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(color: qIBus_colorPrimary, height: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: qIBus_white,
                              ),
                              onPressed: () {
                                finish(context);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(spacing_standard, 0, 0, 0),
                              child: text(QIBus_text_bus_list, textColor: qIBus_white, fontSize: textSizeNormal, fontFamily: fontBold),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => CustomDialog(),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              right: spacing_standard_new,
                            ),
                            child: Icon(Icons.filter_list, size: 25, color: qIBus_white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: context.cardColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
                    padding: EdgeInsets.all(spacing_standard_new),
                    decoration: boxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              formatted = formatter.format(todayDate.subtract(Duration(days: 1)));
                              todayDate = todayDate.subtract(Duration(days: 1));
                            });
                          },
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: qIBus_icon_color,
                          ),
                        ),
                        text(formatted, fontFamily: fontMedium),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              formatted = formatter.format(todayDate.add(Duration(days: 1)));
                              todayDate = todayDate.add(Duration(days: 1));
                            });
                          },
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: qIBus_icon_color,
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: mList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BusList(mList[index], index);
                      })
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

// ignore: must_be_immutable
class BusList extends StatelessWidget {
  late QIBusModel model;

  BusList(QIBusModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        QIBusSelectSeat().launch(context);
      },
      child: Container(
        decoration: boxDecoration(radius: spacing_middle, bgColor: context.cardColor, showShadow: true),
        margin: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new, bottom: spacing_standard_new),
        padding: EdgeInsets.all(spacing_middle),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: boxDecoration(showShadow: false, bgColor: qIBus_colorPrimary, radius: spacing_standard),
                  padding: EdgeInsets.fromLTRB(spacing_standard_new, 1, spacing_standard_new, 1),
                  child: text(model.travelerName, textColor: qIBus_white, fontSize: textSizeSMedium),
                ),
                text(model.typeCoach, textColor: qIBus_textChild),
              ],
            ),
            SizedBox(
              height: spacing_standard,
            ),
            Padding(
              padding: EdgeInsets.only(right: spacing_standard_new, left: spacing_standard_new),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      text(
                        model.startTime,
                        fontFamily: fontMedium,
                      ),
                      text(model.mStartTimeAA, textColor: qIBus_textChild),
                    ],
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          child: Opacity(
                            opacity: 0.2,
                            child: CachedNetworkImage(
                              placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                              imageUrl: qibus_ic_map,
                              fit: BoxFit.cover,
                              width: width * 0.4,
                              height: width * 0.2,
                            ),
                          )),
                      Row(
                        children: <Widget>[
                          Icon(Icons.keyboard_arrow_up),
                          Container(
                            width: width * 0.1,
                            height: 0.5,
                            color: qIBus_colorPrimary,
                          ),
                          Column(
                            children: <Widget>[
                              text(QIBus_text_duration, textColor: qIBus_textChild, fontSize: textSizeSMedium),
                              Container(
                                decoration: boxDecoration(showShadow: false, bgColor: qIBus_colorPrimary, radius: spacing_standard),
                                padding: EdgeInsets.fromLTRB(spacing_standard_new, 1, spacing_standard_new, 1),
                                child: text(model.totalDuration, textColor: qIBus_white, fontSize: textSizeSMedium),
                              ),
                              text(model.hold, textColor: qIBus_textChild, fontSize: textSizeSMedium),
                            ],
                          ),
                          Container(width: width * 0.1, height: 0.5, color: qIBus_colorPrimary),
                          Icon(Icons.keyboard_arrow_up),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      text(model.endTime, fontFamily: fontMedium),
                      text(model.mEndTimeAA, textColor: qIBus_textChild),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                    text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.star,
                          color: qIBus_rating,
                          size: 16,
                        ),
                      ),
                    ),
                    TextSpan(text: model.rate.toString(), style: TextStyle(fontSize: textSizeMedium, color: qIBus_textChild)),
                  ],
                )),
                text(model.price, textColor: qIBus_colorPrimary, fontSize: textSizeLargeMedium)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

dialogContent(BuildContext context) {
  String selectedValue = QIBus_lbl_ac;
  var _value = 0.0;

  return Container(
      decoration: new BoxDecoration(
        color: context.cardColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          GestureDetector(
            onTap: () {
              finish(context);
            },
            child: Container(alignment: Alignment.centerRight, child: Icon(Icons.close, color: qIBus_icon_color)),
          ),
          SizedBox(height: 16),
          text(
            QIBus_title_price,
            fontFamily: fontMedium,
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red[700],
              inactiveTrackColor: Colors.red[100],
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 4.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Colors.redAccent,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.red[700],
              inactiveTickMarkColor: Colors.red[100],
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.redAccent,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            child: Slider(
              value: _value,
              min: 0,
              max: 100,
              divisions: 10,
              label: '$_value',
              onChanged: (value) {},
            ),
          ),
          SizedBox(height: spacing_standard),
          view(),
          SizedBox(height: spacing_standard_new),
          text(
            QIBus_lbl_rating,
            fontFamily: fontMedium,
          ),
          SizedBox(height: spacing_standard),
          RatingBar(
            initialRating: 5,
            minRating: 1,
            direction: Axis.horizontal,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          SizedBox(height: spacing_standard_new),
          view(),
          SizedBox(height: spacing_standard_new),
          text(QIBus_lbl_bus_tpe, fontFamily: fontMedium),
          DropdownButton<String>(
            items: <String>[QIBus_lbl_ac, QIBus_lbl_non_ac, QIBus_lbl_normal].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: text(value, textColor: appStore.isDarkModeOn ? white : qIBus_textHeader, fontSize: textSizeMedium, fontFamily: fontRegular),
              );
            }).toList(),
            //hint:Text(selectedValue),
            value: selectedValue,
            onChanged: (newVal) {},
          ),
          SizedBox(height: spacing_standard_new),
          QIBusAppButton(
            textContent: QIBus_lbl_apply,
            onPressed: () {},
          ),
        ],
      ));
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusSelectSeat.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

import 'QIBusPickDrop.dart';


class QIBusSelectSeat extends StatefulWidget {
  static String tag = '/QIBusSelectSeat';

  @override
  QIBusSelectSeatState createState() => QIBusSelectSeatState();
}

class QIBusSelectSeatState extends State<QIBusSelectSeat> {
  late List<QIBusSeatModel> mlist;

  @override
  void initState() {
    super.initState();
    mlist = QIBusSeat();
  }

  Widget seat(var seatColor, var label) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(spacing_middle), topLeft: Radius.circular(spacing_middle)), color: seatColor),
          height: MediaQuery.of(context).size.width * 0.08,
          width: MediaQuery.of(context).size.width * 0.08,
        ),
        text(label, textColor: seatColor, fontSize: textSizeSMedium)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              title(QIBus_text_select_bus, context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  seat(qIBus_view_color, QIBus_text_available),
                  seat(qIBus_textChild, QIBus_text_booked),
                  seat(qIBus_colorPrimary, QIBus_text_selected),
                  seat(qIBus_pink, QIBus_text_ladies),
                ],
              ),
              SizedBox(
                height: spacing_standard_new,
              ),
              Container(
                margin: EdgeInsets.only(right: spacing_large),
                alignment: Alignment.topRight,
                child: SvgPicture.asset(qibus_ic_icon),
              ),
              SizedBox(
                height: spacing_standard_new,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(spacing_standard_new),
                          bottomRight: Radius.circular(spacing_standard_new),
                        ),
                        color: qIBus_view_color,
                      ),
                      padding: EdgeInsets.all(spacing_standard),
                      child: (Column(
                        children: <Widget>[
                          text("Hold"),
                          SizedBox(
                            height: spacing_standard_new,
                          ),
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: qIBus_colorPrimary, border: Border.all(width: 0, color: qIBus_colorPrimary)),
                            width: 20,
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            width: 0.5,
                            color: qIBus_colorPrimary,
                          ),
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: qIBus_colorPrimary, border: Border.all(width: 0, color: qIBus_colorPrimary)),
                            width: 20,
                            height: 20,
                          ),
                          Container(
                            height: 30,
                            width: 0.5,
                            color: qIBus_colorPrimary,
                          ),
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: qIBus_colorPrimary, border: Border.all(width: 0, color: qIBus_colorPrimary)),
                            width: 20,
                            height: 20,
                          ),
                          Container(height: 30, width: 0.5, color: qIBus_colorPrimary),
                          SvgPicture.asset(qibus_ic_pin, color: qIBus_colorPrimary)
                        ],
                      )),
                    ),
                    SizedBox(
                      width: spacing_large,
                    ),
                    Expanded(
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                        ),
                        itemCount: mlist.length,
                        itemBuilder: (context, index) {
                          if (index % 5 == 0 || index % 5 == 1 || index % 5 == 3 || index % 5 == 4) {
                            //for even row
                            return QIBusSeatSelection(mlist[index], index);
                          } else {
                            //for odd row
                            return Container(
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(spacing_middle),
                                  topLeft: Radius.circular(spacing_middle),
                                ),
                                color: context.cardColor,
                              ),
                              padding: EdgeInsets.all(0.0),
                              height: 35,
                              width: 35,
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(alignment: Alignment.bottomCenter, child: mBookNow(context))
        ],
      )),
    );
  }
}

class QIBusSeatSelection extends StatefulWidget {
  final QIBusSeatModel model;
  final int index;

  QIBusSeatSelection(this.model, this.index);

  @override
  QIBusSeatSelectionState createState() => new QIBusSeatSelectionState(model, index);
}

class QIBusSeatSelectionState extends State<QIBusSeatSelection> {
  bool visibility = false;
  late QIBusSeatModel model;

  Widget mSeat(var color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(spacing_middle), topLeft: Radius.circular(spacing_middle)),
        color: color,
      ),
      padding: EdgeInsets.all(0.0),
      height: 30,
      width: 30,
    );
  }

  void _changed() {
    setState(
      () {
        visibility = !visibility;
      },
    );
  }

  int? index;

  QIBusSeatSelectionState(QIBusSeatModel model, int index) {
    this.model = model;
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: visibility,
          child: GestureDetector(
            onTap: () {
              _changed();
            },
            child: Column(
              children: <Widget>[
                if (model.flag == 1 || model.flag == 3)
                  Column(
                    children: <Widget>[
                      mSeat(qIBus_colorPrimary),
                      text("L" + index.toString(), fontSize: textSizeSMedium),
                    ],
                  ),
                if (model.flag == 2)
                  Column(
                    children: <Widget>[
                      mSeat(qIBus_dark_gray),
                    ],
                  )
              ],
            ),
          ),
          replacement: GestureDetector(
            onTap: () {
              _changed();
            },
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                if (model.flag == 1) mSeat(qIBus_view_color),
                if (model.flag == 2) mSeat(qIBus_dark_gray),
                if (model.flag == 3) mSeat(qIBus_pink),
              ],
            ),
          ),
        )
      ],
    ));
  }
}

Widget mBookNow(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.23,
    decoration: boxDecoration(showShadow: true, radius: 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(spacing_large, spacing_standard, spacing_large, spacing_standard),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  text(QIBus_text_ticket_price, fontFamily: fontMedium),
                  text(QIBus_text_500, fontFamily: fontMedium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  text(QIBus_text_tax, fontFamily: fontMedium),
                  text(QIBus_text_5txt, fontFamily: fontMedium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  text(QIBus_text_total_price, fontFamily: fontMedium, textColor: qIBus_colorPrimary),
                  text("\$445", fontFamily: fontMedium, textColor: qIBus_colorPrimary),
                ],
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            QIBusPickDrop().launch(context);
          },
          child: Container(
            decoration: BoxDecoration(color: qIBus_colorPrimary),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: spacing_middle, bottom: spacing_middle),
            child: text(QIBus_text_close, textColor: qIBus_white, fontFamily: fontMedium, isCentered: true),
          ),
        ).expand()
      ],
    ),
  );
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusAddPassenger.dart
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

import 'QIBusPayment.dart';

class QIBusAddPassenger extends StatefulWidget {
  static String tag = '/QIBusAddPassenger';

  @override
  QIBusAddPassengerState createState() => QIBusAddPassengerState();
}

class QIBusAddPassengerState extends State<QIBusAddPassenger> {
  Widget mLabel(var label) {
    return Row(
      children: <Widget>[
        Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), child: text(label, fontFamily: fontMedium)),
      ],
    );
  }

  Widget mInput(var label, var subLabel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: text(label, textColor: qIBus_textChild),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                isDense: true,
                hintText: subLabel,
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  bool visibility = false;

  void changed() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? _selectedLocation = 'Female';

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          title(QIBus_title_passenger_detail, context),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: spacing_standard_new, bottom: spacing_standard_new, right: spacing_standard_new),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: boxDecoration(
                        showShadow: true,
                        bgColor: context.cardColor,
                        radius: spacing_middle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(spacing_standard, spacing_standard, spacing_standard, spacing_standard_new),
                        child: Column(
                          children: <Widget>[
                            mLabel(QIBus_text_contact_information),
                            SizedBox(height: spacing_standard),
                            mInput(QIBus_lbl_email, QIBus_hint_enter_your_emailId),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                              child: view(),
                            ),
                            SizedBox(height: 8),
                            mInput(QIBus_text_phone, QIBus_hint_mobile),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: spacing_standard_new),
                      decoration: boxDecoration(
                        showShadow: true,
                        bgColor: context.cardColor,
                        radius: spacing_middle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(spacing_standard, spacing_standard, spacing_standard, spacing_standard_new),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    mLabel(QIBus_txt_passenger),
                                    text(QIBus_text_seat + " L1", textColor: qIBus_colorPrimary),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spacing_middle),
                            editTextStyle(QIBus_hint_enter_name),
                            SizedBox(height: spacing_middle),
                            Row(
                              children: <Widget>[
                                Expanded(child: editTextStyle(QIBus_hint_enter_age)),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: spacing_standard_new, right: spacing_standard_new),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: qIBus_view_color, width: 0.5),
                                      borderRadius: BorderRadius.all(Radius.circular(spacing_middle)),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _selectedLocation,
                                        items: <String>['Female', 'Male'].map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: text(value, fontSize: textSizeLargeMedium, textColor: qIBus_textChild),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(
                                            () {
                                              _selectedLocation = newValue;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: spacing_standard_new),
                    QIBusAppButton(
                      textContent: QIBus_text_done,
                      onPressed: () {
                        QIBusPayment().launch(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusViewPackage.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/model/QiBusModel.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusDataGenerator.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';
import 'package:qi_bus_prokit/utils/flutter_rating_bar.dart';

class QIBusViewPackage extends StatefulWidget {
  static String tag = '/QIBusViewPackage';

  @override
  QIBusViewPackageState createState() => QIBusViewPackageState();
}

class QIBusViewPackageState extends State<QIBusViewPackage> {
  late List<QIBusNewPackageModel> mList1;

  @override
  void initState() {
    super.initState();
    mList1 = QIBusGetPackage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopBar(QIBus_lbl_packages, icon: qibus_gif_bell, isVisible: true),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: mList1.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ViewPackage(mList1[index], index);
                  }),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ViewPackage extends StatelessWidget {
  late QIBusNewPackageModel model;

  ViewPackage(QIBusNewPackageModel model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: boxDecoration(radius: spacing_middle, bgColor: context.cardColor, showShadow: true),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(spacing_middle),
              topLeft: Radius.circular(spacing_middle),
            ),
            child: Image.network(model.image, height: width * 0.32, width: width, fit: BoxFit.fill),
          ),
          Padding(
            padding: EdgeInsets.all(spacing_middle),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[text(model.destination, fontFamily: fontMedium), text(model.newPrice, textColor: qIBus_colorPrimary)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    text(model.duration, textColor: qIBus_textChild),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          qibus_ic_home_package,
                          color: qIBus_icon_color,
                        ),
                        SizedBox(
                          width: spacing_control_half,
                        ),
                        SvgPicture.asset(
                          qibus_ic_bus,
                          color: qIBus_icon_color,
                        ),
                        SizedBox(
                          width: spacing_control_half,
                        ),
                        SvgPicture.asset(
                          qibus_ic_restaurant,
                          color: qIBus_icon_color,
                        ),
                        SizedBox(
                          width: spacing_control_half,
                        ),
                        SvgPicture.asset(
                          qibus_ic_wifi,
                          color: qIBus_icon_color,
                        ),
                      ],
                    )
                  ],
                ),
                RatingBar(
                  initialRating: 5,
                  minRating: 1,
                  itemSize: 16,
                  direction: Axis.horizontal,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: qIBus_rating,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusDashboard.dart

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';

import '../main.dart';
import 'QIBusBooking.dart';
import 'QIBusHome.dart';
import 'QIBusMore.dart';
import 'QIBusPackages.dart';

class QIBusDashboard extends StatefulWidget {
  static String tag = '/QIBusDashboard';

  @override
  QIBusDashboardState createState() => QIBusDashboardState();
}

class QIBusDashboardState extends State<QIBusDashboard> {
  var isSelected = 0;
  final List<Widget> _children = [
    QIBusHome(),
    QIBusPackages(),
    QIBusBooking(),
    QIBusMore(),
  ];

  @override
  Widget build(BuildContext context) {
    changeStatusColor(qIBus_colorPrimary);

    return Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: context.cardColor,
            boxShadow: [
              BoxShadow(color: qIBus_ShadowColor, blurRadius: 10, spreadRadius: 2),
            ],
          ),
          padding: EdgeInsets.only(left: 16.0, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              tabItem(0, qibus_ic_home_selected, qibus_ic_home),
              tabItem(1, qibus_ic_package_selected, qibus_ic_package),
              tabItem(2, qibus_ic_booking_selected, qibus_ic_booking),
              tabItem(3, qibus_ic_more_selected, qibus_ic_more),
            ],
          ),
        ),
        body: _children[isSelected]);
  }

  Widget tabItem(var pos, var icon, var icon1) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            isSelected = pos;
            QIBusHome();
          },
        );
      },
      child: Container(
        width: 45,
        height: 45,
        alignment: Alignment.center,
        decoration: isSelected == pos
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: appStore.isDarkModeOn ? cardDarkColor : t1_colorPrimary_light,
              )
            : BoxDecoration(),
        child: Image.asset(isSelected == pos ? icon : icon1, width: 20, height: 20).paddingAll(4),
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/lib/screen/QIBusVerification.dart
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qi_bus_prokit/utils/AppWidget.dart';
import 'package:qi_bus_prokit/utils/QiBusColors.dart';
import 'package:qi_bus_prokit/utils/QiBusConstant.dart';
import 'package:qi_bus_prokit/utils/QiBusImages.dart';
import 'package:qi_bus_prokit/utils/QiBusStrings.dart';
import 'package:qi_bus_prokit/utils/QiBusWidget.dart';

import '../main.dart';
import 'QIBusDashboard.dart';

class QIBusVerification extends StatefulWidget {
  static String tag = '/QIBusVerification';

  @override
  QIBusVerificationState createState() => QIBusVerificationState();
}

class QIBusVerificationState extends State<QIBusVerification> {
  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    setStatusBarColor(qIBus_colorPrimary);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    setStatusBarColor(appStore.isDarkModeOn ? black : white);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            title(QIBus_verification, context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
                      imageUrl: qibus_ic_gr_mobile_otp,
                      fit: BoxFit.contain,
                      width: width * 0.5,
                      height: width * 0.5,
                    ),
                    text(QIBus_lbl_verification, isLongText: true, isCentered: true),
                    16.height,
                    PinEntryTextField(fields: 4, fontSize: textSizeLargeMedium),
                    16.height,
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _start == 0
                              ? Text(QIBus_txt_Resend, style: TextStyle(color: qIBus_colorPrimary, fontSize: textSizeMedium))
                              : Text("$_start Seconds", style: TextStyle(color: qIBus_colorPrimary, fontSize: textSizeMedium)),
                          Row(
                            children: <Widget>[
                              text(QIBus_txt_verify),
                              8.width,
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: qIBus_colorPrimary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_forward, color: qIBus_white),
                              ).onTap(
                                () {
                                  setState(
                                    () {
                                      QIBusDashboard().launch(context);
                                    },
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// File: flutter/qi_bus_prokit/test/widget_test.dart
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:qi_bus_prokit/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}


