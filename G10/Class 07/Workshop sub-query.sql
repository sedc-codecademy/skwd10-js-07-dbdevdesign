


--How can you output a list of all members, including the individual who recommended them (if any), without using any joins? 
--Ensure that there are no duplicates in the list, and that each firstname + surname pairing is formatted as a column and ordered.

select 
	distinct mem.firstname || ' ' || mem.surname as member
	,	(select rec.firstname || ' ' || rec.surname as recomender from public.members as rec where rec.memid = mem.recommendedby)	
from public.members mem