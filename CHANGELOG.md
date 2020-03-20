# master

# 0.9.1

- Bug fix
  - fallback bug when key does not exist on non default language #1 (by @werkzeugh)

# 0.9.0

- Enhancements
  - Code refactor
  - Update dependencies
- Breaking changes:
  - Remove HTTP loader

# 0.8.0

- Enhancements
  - Allow passing mfa for `path` option.
  - Format code.

# 0.7.0

- Enhancements
  - Add InchCi badge and update docs.
  - Small code refactor for loaders and translation function.

# 0.6.0

- Enhancements
  - Add `HTTP` loader that will fetch translations from provided API.
  - Add `loader_options` configuration option.
  - Update README with available loaders and configuration options.
- Breaking changes
  - Rename `storage` option to `loader`.
  - Rename `compile_suffix/prefix` option to `var_suffix/prefix`.

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
