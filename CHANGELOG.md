## Next release

## [0.2.1] - 2020-05-01

* **BREAKING** Make default constructor of `ComplexCustomThemeData` to
expect iterable of nullable data. It's for making easier upgrade to Flutter 2. 
Because if you aren't migrate your project on null-safety yet,
than upgrade will broke your code, but analysator won't warn you.
So now the default behaviour is just like it use to be, and if you want
pass iterables of not nullable data use named constructor: `super.safe()`.

## [0.2.0] - 2020-03-17

* Migrated to null safety.
* Flutter 2.
* Method `CustomThemes.safeOf()` to get not-null data.

## [0.1.4+1] - 2021-02-24

* Readme: update description of setting a default theme data.
* Example: default theme for dark mode.

## [0.1.4] - 2021-01-29

* Fixed: Failed to get theme data for light mode in nested theme data.
* Add `innim_lint` analysis rules. Refactor project.
* Update `list_ext` dependency.

## [0.1.3] - 2020-11-16

* `CustomThemes.of()` supports the default values.

## [0.1.2] - 2020-11-16

* Dark mode support.

## [0.1.1+2] - 2020-05-19

* If `CustomThemes` storage is not found than `of<T>()` method returns `null`.

## [0.1.1+1] - 2020-05-11

* Add an example.
* Update README.

## [0.1.1] - 2020-04-30

* Add complex theme data and recursive theme data search.

## [0.1.0] - 2020-04-24

* Core functionality.
