Question 1: What is the count of each gender on each flight?

select  f.flight_id, c.gender,  count(*) gender_count
from p_customer c
join p_reservations_fact r
on c.customer_id = r.customer_id
join p_flight f
on f.flight_id = r.flight_id
group by c.gender, f.flight_id
order by f.flight_id;
--------------------------------------------------------------------------------------------------------
Question 2: What is the count of customer complaints?

select complaints_, count(complaints_) count_complaints
from p_customer_care
group by complaints_;
--------------------------------------------------------------------------------------------------------
Question 3: What is the count of customer complaints and inquiries per flight?

select f.flight_id, cc.complaints_, cc.inquiries,count(cc.complaints_) count_complaints, count(cc.inquiries) count_nquiries
from p_customer_care cc
join p_customer_care_fact cf
on cc.id = cf.customer_care_id
join p_flight f
on f.flight_id =cf.flight_id
group by f.flight_id, cc.complaints_,cc.inquiries
order by f.flight_id;
--------------------------------------------------------------------------------------------------------
Question 4: What is the highest profitable flight?

select *
from 
(select f.flight_id, sum(r.profit) flight_profit
from p_flight f
join p_reservations_fact r
on f.flight_id = r.flight_id
group by f.flight_id
order by flight_profit desc)
where rownum <= 1;
--------------------------------------------------------------------------------------------------------
Question 5: What is the average profit for each channel?

select c.name, avg(rf.profit) avg_profit
from p_reservations_fact rf
join p_channel c
on c.channel_id = rf.channel_id
group by c.name
order by avg_profit desc;
--------------------------------------------------------------------------------------------------------
Question 6: Who is the customer that delivers the most profit?

select *
from 
(select c.customer_id, c.first_name || '  ' || c.last_name name, sum(r.profit) highest_profit
from p_customer c
join p_reservations_fact r
on c.customer_id = r.customer_id 
group by c.customer_id, c.first_name || '  ' || c.last_name 
order by  highest_profit desc)
where rownum <= 1;
--------------------------------------------------------------------------------------------------------
Question 7: How many tickets are being reserved by class?

select fb.fare_basis_code, count(c.customer_id) No_TICTS
from p_fare_basis fb
join p_flight f
on f.code = fb.fare_basis_code
join p_marketing_fact m
on m.flight_id = f.flight_id
join p_customer c
on m.customer_id = c.customer_id
group by  fb.fare_basis_code ;
