= CalDAV

== To Do

* Upgrade to using Cucumber and RSpec
* Generate VTIMEZONE
* Generate VFREEBUSY
** Use tzinfo
** Use when creating calendar
** Use when querying caldav
* CalendarQuery
** Make sure all searches are done with UTF-8
** support limit-recurrence-set for partial retrieval of recurring events
* Convert to VPIM
* Implement Calendar Multiget
# TODO: set Content-Type: text/calendar
# TODO: update etag to edit an object

* REPORT

* free-busy-query

== Filtering

CalendarQuery.new.event #=> All events
CalendarQuery.new.event(time1..time2)
CalendarQuery.new.event.uid("UID")
CalendarQuery.new.todo.alarm(time1..time2)
CalendarQuery.new.event.attendee(email).partstat('NEEDS-ACTION')
CalendarQuery.new.todo.completed(false).status(:cancelled => false  )

@mycal.find(query)

== Results

CalendarResult.new.limit_recurrence_set(range)
CalendarResult.new.expand_recurrence(range)
CalendarResult.new.freebusy(range)

== Running Tests

gem install mocha

== Notes

Using Darwin Calendar Server

calendar = CalDAV::Calendar.create('http://localhost/calendars/users/admin/<calendar name>', :username => 'admin', :password => 'admin')

calendar.events
