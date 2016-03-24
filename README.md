# Tracker: an example of visitor tracking in a Rails application
### George Feil ghfeil@gmail.com
### [Source code](https://github.com/gfeil/tracker)

## Introduction

This sample project is a demonstration on how to track unique visitors to a web site over a calendar period.

## Visitor Identification 

The approach I used for identifying visitors is through cookies. When a visitor accesses the app, a permanent cookie is set with a randomized string value.

## Managing Visitor Information in the Database

The original specification called for having the ability to track unique visitors over any arbitrary date period. However, as an industry standard practice, web site owners typically are interested in tracking unique visitors over a daily, weekly, or monthly basis. For this reason, I chose to optimize this solution based on this practice.

An optimal means of maintaining a count of unique users is through use of a Set. By definition, all of the members of a set are unique. Therefore, any attempt to add an that is equivalent by identity equivalent to the current members of a set are ignored.

For persistence I chose to use Redis, which has native support for set data types. Sets contain the IDs of visitors that have visited the site over a given calendar day, week, or month. New sets are instantiated at the start of each respective time period. A set is created for each calendar day, week and month.

At the end of a given day, week, or month, the data accrued in the respective counters may be exported into a database table for maintaining historical statistics. (This has not been included in this sample project.)  

## Recording the Visit

The visit is recorded using a before_action in the parent ActionController. This filter checks for the existence of the
_id_ cookie, sets it if it does not exist, and calls _VisitCounter.record_ to store it in separate counters that track accrued visitors for the current calendar day, week, and month.


