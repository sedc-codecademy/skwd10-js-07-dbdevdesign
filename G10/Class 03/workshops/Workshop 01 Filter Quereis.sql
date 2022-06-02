
--How can you retrieve all the information from the facilities table?
select * from facilities
--How can you produce a list of facilities that charge a fee to members?
select 
distinct 
f.Name 
from bookings b
inner join facilities f on b.facid = f.facid
--How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost? 
--Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.
select 
		b.facid
	, 	f.Name as facility_name
	,	membercost
	, 	monthlymaintenance
	,	(f.monthlymaintenance /50) as monthlymaintenance_50th
--	,	*
from bookings b
inner join facilities f on b.facid = f.facid
where
	f.membercost < (f.monthlymaintenance /50)
--How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.
select 
*
from facilities
where facid in (1,5)



--5. You'd like to get the signup date of your last member. How can you retrieve this information?
select * 
from members
order by joindate desc
limit 1
--6. You'd like to get the first and last name of the last member(s) who signed up - not just the date. How can you do that?
select firstname, surname, joindate 
from members
order by joindate desc
limit 10
--7. Produce a list of the total number of slots booked per facility. For now, just produce an output table consisting of facility id and slots, sorted by facility id.
select 
		facid
	,	slots
from bookings
order by facid
--8. Find the total number of members (including guests) who have made at least one booking.
select * 
from public.members

select count(memid)
from bookings
--9. Produce a monotonically increasing numbered list of members (including guests), ordered by their date of joining. Remember that member IDs are not guaranteed to be sequential.
select 
		memid
	,  	joindate
	,	row_number () OVER (order by joindate) as rn
from members 
order by joindate

--10. How can you produce a list of the start times for bookings by members named 'David Farrell’?
select 
	m.Firstname, m.surname, b.starttime
from members m 
inner join bookings b on m.memid = b.memid
where
		firstname = 'David'
	and surname = 'Farrell'
order by b.starttime

--11. How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time.
select
		b.starttime
	,	f.name
from bookings b
inner join facilities f on b.facid = f.facid
where
	b.starttime::date = '2012-09-21'
	and f.name like 'Tennis Court%'

select
		bookings.starttime
	,	facilities.name
from bookings 
inner join facilities on bookings.facid = facilities.facid
where
	bookings.starttime::date = '2012-09-21'
	and facilities.name like 'Tennis Court%'

--12. How can you output a list of all members who have recommended another member? Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).
select 
distinct
		m2.firstname
	,	m2.surname
from members m1
inner join members m2 on m1.recommendedby= m2.memid



