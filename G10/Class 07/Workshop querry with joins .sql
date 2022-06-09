
/*
select * from bookings
select * from facilities
select * from members
*/
--How can you produce a list of bookings on the day of 2012-09-14 which will cost the member (or guest) more than $30? 
--Remember that guests have different costs to members (the listed costs are per half-hour 'slot'), and the 
--guest user is always ID 0. Include in your output the name of the facility, the name of the member 
--formatted as a single column, and the cost. Order by descending cost, and do not use any subqueries.

select 
	m.firstname || ' ' || m.surname as member,
	f.name as facilityname,
	--sum( 
	case 
		when m.memid = 0 then b.slots * f.guestcost
	else 
		b.slots * f.membercost
	end 
	--) 
	as cost		 
from bookings b
inner join members m on b.memid = m.memid
inner join facilities f on b.facid = f.facid
where
		b.starttime >= '20120914'
	and b.starttime < '20120915'
	and (
	(m.memid = 0 and b.slots * f.guestcost > 30) or (m.memid !=0 and b.slots * f.membercost > 30)
		)
/*group by 		
	m.firstname || ' ' || m.surname,
	f.name
*/	
	
