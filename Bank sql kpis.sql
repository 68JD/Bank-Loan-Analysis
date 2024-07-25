create database analytics;
use analytics;

select * from finance_1;

select * from finance_2;


# KPI-1   Year wise Loan amount stats (Total / Average)

Select Year(issue_d) as Year, sum(loan_amnt) as 'Total_amount(INR)' from finance_1
   group by Year(issue_d) order by Year(issue_d);
   
   #------OR-------#
   
Select Year(issue_d) as Year, round(avg(loan_amnt),0) as 'Average_amount(INR)' from finance_1
   group by Year(issue_d)
   order by Year(issue_d); 
   
   
# KPI-2  Grade and sub grade wise revol_bal

select grade ,sub_grade, round(avg(revol_bal),0) as Revol_bal from finance_1
inner join finance_2 on finance_1.id = finance_2.id
group by grade,sub_grade
order by grade,sub_grade;


# KPI-3 Total Payment for Verified Status Vs Total Payment for Non Verified Status

select verification_status, sum(total_pymnt) as "Total Payment" from finance_1
inner join finance_2 on finance_1.id = finance_2.id
where
verification_status like "%Verified%" or 
verification_status like "%Not Verified%"
group by verification_status;

select verification_status, round(sum(total_pymnt),0) as "Total Payment"
from finance_1
inner join finance_2 on finance_1.id = finance_2.id
where
verification_status NOT LIKE "%source_Verified%" 
group by verification_status;


Select  verification_status,round(sum(total_pymnt)) as Total_payment from finance_1
inner join finance_2 on finance_1.id = finance_2.id 
group by verification_status having Verification_status= "verified" or verification_status= "Not verified" ;


# KPI-4 State wise and last_credit_pull_d wise loan status

select addr_state as State ,loan_status as "Loan Status",count(loan_status) as Total_count, sum(last_credit_pull_d) as "Last Credit pull date" from finance_1
inner join finance_2 on finance_1.id=finance_2.id
group by State,Loan_Status
order by State;

# KPI-5 Home ownership Vs last payment date stats

select  member_id, home_ownership as "Home Ownership" , round(avg(last_pymnt_amnt),2) as "Last Payment" from  finance_1
inner join finance_2 on finance_1.id = finance_2.id 
group by member_id, home_ownership  ,last_pymnt_amnt
order by member_id,home_ownership  ,last_pymnt_amnt;


# KPI-6  Number of open accounts w.r.t issue date

select member_id, Year(issue_d) as Year , sum(open_acc) as Total_acc from finance_1
inner join finance_2 on finance_1.id = finance_2.id
group by member_id , issue_d;


# KPI-7  Purpose wise Max and Min Loan amount , Funded amount inb

select year(issue_d) as Year, 
purpose,
max(loan_amnt) as "Max Loan Amount" ,
min(loan_amnt) as "Min Loan Amount"
from finance_1
group by issue_d,purpose
order by issue_d,purpose;


# KPI-8  Average Annual income for Home ownership w.r.t emp_length

select emp_length, home_ownership , round(avg(annual_inc),2) as "Annual Income" from finance_1
group by emp_length, home_ownership
order by emp_length, home_ownership;


# KPI-9  Term wise total of payments , payments invested, received principal and  received intrests

select term , 
round(avg(total_pymnt),2) as "Total Payment" ,
round(avg(total_pymnt_inv),2) as "Total Payment Invested" ,
round(avg(total_rec_prncp),2) as "Total Received Principal" ,
round(avg(total_rec_int),2) as "Total Received Intrest"
from finance_1
inner join finance_2 on finance_1.id = finance_2.id
group by term
order by term;


# KPI-10   

SELECT YEAR(issue_d) AS Year,
       CONCAT(QUARTER(issue_d), ' QTR') AS Quarters,
       ROUND(AVG(dti), 2) AS Average_DTI
FROM finance_1
GROUP BY YEAR(issue_d), Quarters;
