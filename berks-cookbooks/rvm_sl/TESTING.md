Testing the rvm cookbook
=====

This cookbook includes both unit tests via
[ChefSpec](https://github.com/sethvargo/chefspec) and integration tests via
[Test Kitchen](https://github.com/test-kitchen/test-kitchen). Contributions to
this cookbook will only be accepted if all tests pass successfully:

```bash
kitchen test
chef exec rspec
```

Setting up the test environment
-----

Install the latest version of
[Vagrant](http://www.vagrantup.com/downloads.html) and
[VirtualBox](https://www.virtualbox.org/wiki/Downloads)

The Chef tooling (chefspec/test kitchen/etc) is managed by the [Chef
Development Kit](http://downloads.getchef.com/chef-dk/) - Version 0.3.4

Clone the latest version of the cookbook from the repository.

```bash
git clone git@github.com:dsaenztagarro/rvm.git
cd rvm
```

Running ChefSpec
-----

ChefSpec unit tests are located in `spec`. Each recipe has a
`recipename_spec.rb` file that contains unit tests for that recipe. Your new
functionality or bug fix should have corresponding test coverage - if it's a
change, make sure it doesn't introduce a regression (existing tests should
pass). If it's a change or introduction of new functionality, add new tests as
appropriate.

To run ChefSpec for the whole cookbook:

`chef exec rspec`

To run ChefSpec for a specific recipe:

`chef exec rspec spec/user_install_spec.rb`

Running Test Kitchen
-----

Test Kitchen test suites are defined in [.kitchen.yml](https://github.com/dsaenztagarro/rvm_chef/blob/master/.kitchen.yml). Runnine `kitchen test` will cause Test Kitchen to spin up each test.
