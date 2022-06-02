

--1	Produce a list of the total number of slots booked per facility in the month of September 2012.
--	Produce an output table consisting of facility id and slots, sorted by the number of slots.
select 
	facid, sum(slots) as "Total Slots"
from bookings
where
		starttime >= '2012-09-01'
	and starttime < '2012-10-01'
group by facid
order by sum(slots);

--2	Produce a list of the total number of slots booked per facility per month in the year of 2012. 
--	Produce an output table consisting of facility id and slots, sorted by the id and month.
select 
	facid, extract(month from starttime) as month, sum(slots) as "Total Slots"
from bookings
where
		starttime >= '2012-01-01'
	and starttime < '2013-01-01'
group by facid, extract(month from starttime)
order by facid, month;



--How can you output a list of all members, including the individual who recommended them (if any)? 
--Ensure that results are ordered by (surname, firstname).

select 
	m1.firstname || ' ' || m1.surname as Member,
	m2.firstname || ' ' || m2.surname as RecommendedBy
from members m1
left join members m2 on m2.memid = m1.recommendedby

--How can you produce a list of all members who have used a tennis court? 
--Include in your output the name of the court, and the name of the member formatted as a single column. 
--Ensure no duplicate data, and order by the member name followed by the facility name.

select distinct
		m.firstname || ' ' || m.surname as Member
	,	f.name as facility_name
from members m
inner join bookings b on m.memid = b.memid
inner join facilities f on b.facid = f.facid
where
	f.name like 'Tennis Court%'
order by 
	member, facility_name



