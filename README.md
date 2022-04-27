# Measure Body Temperature

Exercise requirement:

Imagine we've been working with a company who produces a wearable device to measure body temperature (to predict onset of illness). We need to store that data in the Rails backend. There is also a device-specific temperature "offset" value which, when summed with the raw reading from the device will give the actual temperature value. This offset may change over time.

Using Rails + database, please design and build a REST API interface to a) set offset and b) store temperature readings for a user and c) list historical data readings. The system should send a simple alert email if the temperature appears to be trending to exceed 37.5C. For the purpose of this exercise, assume that trending means that the last 5 readings are getting closer to the threshold.

## Overview

This application uses Rails version 6.1.5, Ruby version 2.7.2.

This application contains following endpoints:

`/list` - to get list historical data readings
`/temperature` - to store temperature readings for a user
`/offset` - to set offset

There are two models:

`Temperature` - to store temperature readings for a user
`SystemConfig` - to store configs that can be changed: offset and etc.

The application uses Mandrill for sending e-mail, in order to use the functionality Mandrill API key needs to be stored in `ENV`

## Local setup

* Install Ruby version 2.7.2: `rvm install 2.7.2`
* Bundle: `bundle install`
* Run specs: `bundle exec rspec`
* Run server: `rails server`

## Usage

### List historical data readings

To get list: `GET localhost:3000/list`
Date range can be passed with following params: `since:date` `till:date`
Example: `GET localhost:3000/list?since=2022-01-01&till=2022-05-05`

### Store temperature readings for a user

`POST localhost:3000/temperature` with following body params: `{value: <VALUE:DECIMAL>}`

### Set offset

`POST localhost:3000/offset` with following body params: `{value: <VALUE:DECIMAL>}`

or with console: `SystemConfig['offset_value'] = <VALUE:DECIMAL>`