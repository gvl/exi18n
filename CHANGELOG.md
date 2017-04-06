# master

- Breaking changes
  - Rename `storage` option to `loader`

# 0.5.2

- Enhancements
  - Add changelog.
- Bug fix
  - Fix bug for missing translation on defuault locale when translation is empty and we want to fallback to default locale. It would return nil instead of raising error.

# 0.5.1

- Bug fixes
  - Change default value for `fallback` to false.

# 0.5.0

- Enhancements
  - Add `fallback` configuration option.
  - If `fallback` option is true when translation for key is empty it will fallback to default translation.

# 0.4.0

- Enhancements
  - Add `compile_prefix`, `compile_suffix` and `locales` configuration options.
  - Add default values for all configuration options.
  - Check if passed locale is supported if not fallback to default locale.

# 0.3.0

- Enhancements
  - Add `Cache` module that uses `GenServer` that manage ETS table and retriving translations.
  - Handle `yamler` error that cause app to crash when file is missing. Now it will raise error.

# 0.2.0

- Enhancements
  - Add `Compiler` module that handles variables interpolation into translation texts.
  - Change ETS table namespace
  - Instead of trying to create ETS table every time and rescue error, just check if exists.

# 0.1.1

- Enhancements
  - Documentation/Readme update.

# 0.1.0

- Enhancements
  - Add `default_locale`, `path` and `storage` configuration options.
  - Load translations from yaml files.
  - Raise errors on missing translation or incomplete path.
  - Store locales in ETS table.
