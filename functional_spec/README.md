# ParkingLot

Main focus(1) has been put on aspects like:
 * OOP
 * Tests
 * Flexibility of the Solution: 
   + Open Close Principle
   + Single Responsibility Principle

Slightly less focus has been put on the:
 + infrustructure 
 + persistant layer 


Two logical parts which emerge from the looking at the problem and potential implemention 
1. Command managment 
2. Parking Lot - Domain Logic 

## Command managment 
As long both parts are kept in the module parking_lot, that there is a chance to extract Command managment
to the separate namespace, engine/gem. 

There is a domain-agnostic logic, purely responsible for handling input from the STDIN or File.
Mechanism or reading, parsing input, waiting for an end of the program, Strategy which gonna chose 
based on the input specific class which gonna execute this command could work as a standalone library. 

Used Open Close Principle for chosing different types of commands depends on the input and arguments, 
allows to extend infinitely possible variations, what makes this solution - Flexible.

There is an potential for further refactorisation like: 
  inheritance from some Base class, which could encapsulate common parts, like 
  + match method 
  + access to the Parking object

  moreover match method, could be refactored as a makro method to have a final implementation 
  in each Command class, like:
```
  module Commands
    class CreateParkingLotCommand
      match :create_parking_lot
```


## Parking Lot - Domain Logic 
  Module is distributed in the dedicated classes responsible for executing a business logic

  Services: 
    which are responsible for orchestration and delegation logic to the domain classes.

  Queries:
    which in quite primitive way encapsulating way of fetching data, 
    considering scope of the task, there were decision to simplify storege ( in memory )
    instead of introducing persistent layer. 
    There is a huge potential to extract namespace Queries (from current Services) 
    and to have 2 dediated Query Objects one for each type

  Models: 
    Parking 
      contains Domain logic, as being majority of operations are being executed from its level.
      Considering test suite covering current implementation, and well defined interfaces of classes
      it would be relatively easy to swap storage to the persisante class with help of some ORM,
      and model real classes responsible for ParkingSlot, Car, Ticket, introduce some logging system.
      Considering factors which I have decided to focus on (1) to have flexible, well tested solution,
      and the time limitation, current solution has simplified version of models.

    Report
      simple formatting of the report's table

# Functional Suite

`functional_spec/` contains the Rspec/Aruba based automated testing suite that will validate the correctness of your program for the sample input and output.

Please to add specs as needed when building your solution.

We do not support Windows at this point in time. If you don't have access to an OSX or Linux machine, we recommend  setting up a Linux machine you can develop against using something like [VirtualBox](https://www.virtualbox.org/) or [Docker](https://docs.docker.com/docker-for-windows/#test-your-installation).

This needs [Ruby to be installed](https://www.ruby-lang.org/en/documentation/installation/), followed by some libraries. The steps are listed below.

## Setup

First, install [Ruby](https://www.ruby-lang.org/en/documentation/installation/). Then run the following commands under the `functional_spec` dir.

```
functional_spec $ ruby -v # confirm Ruby present
ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin17]
functional_spec $ gem install bundler # install bundler to manage dependencies
Successfully installed bundler-1.16.1
Parsing documentation for bundler-1.16.1
Done installing documentation for bundler after 2 seconds
1 gem installed
functional_spec $ bundle install # install dependencies
...
...
Bundle complete! 4 Gemfile dependencies, 23 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
functional_spec $ 

```

## Usage

You can run the full suite from `parking_lot` by doing
```
parking_lot $ bin/run_functional_specs
```

You can run the full suite directly from `parking_lot/functional_spec` by doing
```
parking_lot/functional_spec $ bundle exec rake spec:functional
```

You can run a specific test from `parking_lot/functional_spec` by providing the spec file and line number. In this example we're running the `can create a parking lot` test.
```
parking_lot/functional_spec $ PATH=$PATH:../bin bundle exec rspec spec/parking_lot_spec.rb:5
```
