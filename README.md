
<p align="center">
  <img src="https://github.com/kzjn10/Flutter_Web_Todo_App/blob/main/screenshots/phone_dark.png" alt="Phone Dark"/>

<img src="https://github.com/kzjn10/Flutter_Web_Todo_App/blob/main/screenshots/phone_light.png" alt="Phone Light"/>

<img src="https://github.com/kzjn10/Flutter_Web_Todo_App/blob/main/screenshots/web_dark.png" alt="Web Dark"/>

<img src="https://github.com/kzjn10/Flutter_Web_Todo_App/blob/main/screenshots/web_light.png" alt="Web Dark"/>
</p>

# Flutter version
```
[✓] Flutter (Channel stable, 2.0.1, on macOS 11.2.1 20D74 darwin-x64, locale en)

```

# What will you learn
- Clean architecture, micro frontend, MVVM
- Hive DB
- Bloc
- Custom toast
- Write unit test
    - [ ] Home screen
    - [x] Local datasource
- Simple responsive web layout
- Localization
- Dynamic theme

# Gen code

```
    flutter packages pub run build_runner build --delete-conflicting-outputs
    flutter packages pub run build_runner watch
```

# How to run Unit test

```
sh run_test.sh
```
Install `lcov` if not
```
brew install lcov
```



# Can not build

- Dynamic theme error
```
https://stackoverflow.com/questions/65657716/error-the-method-ancestorstateoftype-isnt-defined-for-the-class-buildcontex?newreg=3517ec102d544c64b3f4f443c4b77d1a
```

# License

Copyright (c) 2021 Kzjn10

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
