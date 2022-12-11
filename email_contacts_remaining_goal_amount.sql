SELECT * from backers
order by cf_id desc 

SELECT * from campaign

--SQL query retrieves the number of backer_counts in descending order for each “cf_id” for all the "live" campaigns.
Select cf_id, backers_count from campaign where outcome = 'live'
order by backers_count desc

--Write a SQL query that uses the backers table to confirm the results from Step 2.
select cf_id, count(*) as backers_count from backers group by cf_id order by backers_count desc

-- SQL query that creates a new table named email_contacts_remaining_goal_amount that contains the first name of each contact, the last name, the email address, and the remaining goal amount (as "Remaining Goal Amount") in descending order for each live campaign.
select c.first_name, c.last_name, c.email, (cam.goal - cam.pledged) as "Remaining Goal Amount" 
into email_contacts_remaining_goal_amount
from contacts as c
join campaign as cam
on c.contact_id = cam.contact_id
where cam.outcome = 'live'  
order by "Remaining Goal Amount" desc

select * from email_contacts_remaining_goal_amount;

--SQL query that creates a new table named email_backers_remaining_goal_amount that contains the email addresses of the backers in descending order, the first and the last name of each backer, the cf_id, the company name, the description, the end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal".
SELECT B.email, B.first_name, B.last_name, B.cf_id, cam.company_name, cam.description, cam.end_date, (cam.goal-cam.pledged) as "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM campaign as cam
LEFT JOIN backers as B
ON cam.cf_id = B.cf_id
WHERE cam.outcome = 'live'
GROUP BY B.email, B.first_name, B.last_name, B.cf_id, cam.company_name, cam.description, cam.end_date, "Left of Goal"
ORDER BY B.last_name;

SELECT * FROM email_backers_remaining_goal_amount;
