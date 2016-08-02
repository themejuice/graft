rvm CHANGELOG
=============

This file is used to list changes made in each version of the rvm cookbook.

0.1.0
-----
- Initial release of rvm_sl

0.1.1
-----
- Added `rvm_gem` resource
- Added ruby dependencies to `system_requirements` recipe

0.1.2
-----
- Fixed rubocop issues

0.1.3
-----
- Fixed documentation
- Updated defaults of user attributes
- Added defaults to user attributes of resources
- Updated installing rvm guard

0.1.4
-----
- Fixed default user property of resources

0.1.5
-----
- Refactoring from `Mixlib::ShellOut` to `login_shell`
- Removed not necessary attribute `['rvm']['user']['password']`.
                          Refactoring attributes and chefspecs.

0.1.6
-----
- Refactoring from `Mixlib::ShellOut` to execute resources
- Refactoring attributes and chefspecs.

0.1.7
-----
- Added json gem dependencies to system requirements
- DRY user environment from resources

0.1.8
-----
- Added system requirements for ruby 2.3.0

0.1.9
-----
- Fix: system requirements for ruby 2.3.0

2.0.0
-----
- Adds `.gemrc` to avoid installing documentation of gems
- Fix bats integration tests on ruby version
- Adds serverspec integration tests on `.gemrc` presence

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
