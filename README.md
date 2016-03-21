# Tracker: an example of visitor tracking in a Rails application
### George Feil ghfeil@gmail.com
### [Source code](https://github.com/gfeil/tracker)

## Introduction

This sample project demonstrates how to track unique visitors to a web site over any arbitrary calendar period.

## Visitor Identification 

The approach I used for identifying visitors is through cookies. When a visitor accesses the app, a permanent cookie is set with a randomized string value.

## Managing Visitor Information in the Database

Because we want to be able to efficiently count unique visitors for any arbitrary date range, I chose to use a PostgreSQL table to store the results.

Following is the relevant table schema:

Column    | Type   | Description           
:-------: | :----: | --------------------- 
visit_key | string | visitor cookie value 
starts_on | date   | starting date for visit 
ends_on   | date   | ending date for visit

The following indexes added to the table:

* `[visit_key, ends_on]` used for recording visits.
* `[starts_on, ends_on]` used for retrieving visitors over a given period.

Each record represents a contiguous period of time that the visitor spent on the site. This helps to reduce the number of records stored over time, particularly when the same visitor accesses the site multiple times on consecutive days.

## Recording the visit

The visit is recorded using a before_action in the parent ActionController. This filter checks for the existence of the
_id_ cookie, sets it if it does not exist, and calls _Visitor.record_visit_ to store the visit.


## Querying for Unique Visitors

To determine the number of unique visitors over a period of time, the equivalent SQL is called (where _start_date_ and 
_end_date/_ are the start and end dates for the desired time period)/

```
SELECT DISTINCT COUNT(visit_key) FROM visitors WHERE (starts_on <= end_date) AND (visitors.ends_on >= start_date)
```

