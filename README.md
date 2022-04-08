# Flutter Agenda

![Pub Version](https://img.shields.io/pub/v/team_calendar?label=Team%20Calendar&logo=flutter)

Hight performance Calendar for resources & appointments, biderectional smooth scrolling, always appearing timeline & header (resource object).

# Show case

<img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/team_calendar.png" width="400" />
<img src="https://raw.githubusercontent.com/iliyass-zamouri/flutter_agenda/main/images/team_calendar.gif" height="440" />  

# Install

```
team_calendar: ^0.0.1
```


```
import 'package:team_calendar/team_calendar.dart';
```

## How to use it

```dart
 TeamCalendar(
    resources: [
      Line(
          header: Header(
            title: 'Amine',
          ),
          appointments: [
            Appointment(
                title: 'title',
                start: const Time(10, 0),
                end: const Time(12, 0),
                onTap: () {
                  print('tap');
                }),
          ]),
      Line(
          header: Header(
            title: 'Amine',
          ),
          appointments: []),
      Line(
          header: Header(
            title: 'Amine',
          ),
          appointments: []),
      Line(
          header: Header(
            title: 'Amine',
          ),
          appointments: [])
    ],
    startTime: const Time(8, 0),
    endTime: const Time(20, 0),
    timeSlot: TimeSlot.fifteen,
    timeSlotHeight: 50,
    timeSlotWidth: 40,
  )

```

# License

```
MIT License

Copyright (c) 2022 Iliyass ZAMOURI

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
