import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snapc/admin_pages/shedule_list_page.dart';
import 'package:snapc/components/list_tile_button.dart';
import 'package:snapc/components/my_app_bar.dart';

class ShcedulePage extends StatefulWidget {
  const ShcedulePage({super.key});

  @override
  State<ShcedulePage> createState() => _ShcedulePageState();
}

class _ShcedulePageState extends State<ShcedulePage> {
  // * date time now
  late DateTime _dateTime;
  late DateTime _dateTomorrow;
  late DateTime _dayAfterTomorrow;
  late String formattedDateNow;
  late String formattedDateTomorrow;
  late String formattedDateAfterTomorrow;

  @override
  void initState() {
    super.initState();
    _updateDates();
  }

  void _updateDates() {
    _dateTime = DateTime.now();
    _dateTomorrow = _dateTime.add(const Duration(days: 1));
    _dayAfterTomorrow = _dateTomorrow.add(const Duration(days: 1));
    formattedDateNow = DateFormat('EEEE, MMMM d, y').format(_dateTime);
    formattedDateTomorrow = DateFormat('EEEE, MMMM d, y').format(_dateTomorrow);
    formattedDateAfterTomorrow =
        DateFormat('EEEE, MMMM d, y').format(_dayAfterTomorrow);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(text: 'Schedule'),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              MyTileButton(
                icon: Icons.today,
                title: 'Today',
                subtitle: 'Order on today',
                onPressed: () {},
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ScheduleList(date: formattedDateNow, day: 'Today'),
                    ),
                  );
                },
                textButton: 'Check',
                colorTile: Colors.red[100],
                color: Colors.red,
                isVisible: true,
              ),
              MyTileButton(
                icon: Icons.today,
                title: 'Tomorrow',
                subtitle: 'Order on tomorrow',
                onPressed: () {},
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleList(
                        date: formattedDateTomorrow,
                        day: 'Tomorrow',
                      ),
                    ),
                  );
                },
                textButton: 'Check',
                colorTile: Colors.yellow[100],
                color: Colors.yellow,
                isVisible: true,
              ),
              MyTileButton(
                icon: Icons.today,
                title: 'Next 2 Days',
                subtitle: 'The day after tomorrow',
                onPressed: () {},
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleList(
                        date: formattedDateAfterTomorrow,
                        day: 'Day After Tomorrow',
                      ),
                    ),
                  );
                },
                textButton: 'Check',
                colorTile: Colors.green[100],
                color: Colors.green,
                isVisible: true,
              )
            ],
          ),
        ));
  }
}
