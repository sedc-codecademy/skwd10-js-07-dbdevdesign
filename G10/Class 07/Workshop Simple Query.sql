
-- The same query with using subquery and more simplier code
select * from
(
	select 
		m.firstname || ' ' || m.surname as member,
		f.name as facility,
		case 
			when m.memid = 0 then b.slots * f.guestcost
			else b.slots * f.membercost
		end as cost
	from members m
	inner join bookings b on m.memid = b.memid
	inner join facilities f on b.facid = f.facid
	where 
		b.starttime >= '20120914' 
		and b.starttime < '20120915'
) as bookings
where cost > 30
order by cost desc

