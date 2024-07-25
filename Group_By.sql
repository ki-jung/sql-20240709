Use practice_sql;

Create Table sale (
	sequence_number int primary key auto_increment,
    date Date,
    amount int,
    employee_number int 
);

Insert into sale (date, amount, employee_number)
values ('2024-07-01',100000, 1);
Insert into sale (date, amount, employee_number)
values ('2024-07-01',120000, 2);
Insert into sale (date, amount, employee_number)
values ('2024-07-01',60000, 1);
Insert into sale (date, amount, employee_number)
values ('2024-07-03',200000, 1);
Insert into sale (date, amount, employee_number)
values ('2024-07-03',170000, 3);
Insert into sale (date, amount, employee_number)
values ('2024-07-06',100000, 2);
Insert into sale (date, amount, employee_number)
values ('2024-07-06',160000, 3);
Insert into sale (date, amount, employee_number)
values ('2024-07-07',80000, 1);
Insert into sale (date, amount, employee_number)
values ('2024-07-08',90000, 2);
Insert into sale (date, amount, employee_number)
values ('2024-07-08',110000, 3);

Select * From sale;
-- 집계 함수 : 여러 행의 레코드를 종합하여 하나의 결과값을 반환

-- Count() : 특정 조건에 해당하는 레코드의 개수를 반환
Select Count(*) From sale;
Select count(*) From sale Where amount <= 100000;
Select Count(amount) From sale;

-- Sum : 특정 조건에 해당하는 칼럼의 값을 모두 더한 결과를 반환
Select Sum(amount) From sale;
Select SUm(amount) From sale Where employee_number =1;

-- avg : 특정 조건에 해당하는 컬럼의 값의 평균을 반환 
Select AVG(amount) From sale;
Select AVG(amount) From sale Where employee_number = 1;

-- MAX,MIN() : 특정 조건에 해당하는 컬럼 값의 최대 최소 값을 반환
Select Max(amount), min(amount) From sale;

-- 그룹화 (Group By) : 조회 결과에 대해 레코드를 하나 이상의 컬럼으로 그룹화하여 결과를 도출하는 것
-- 일반적으로 집계함수와 함께 사용됨
Select AVG(amount), employee_number
From sale
Group by employee_number;

-- 집계함수가 포함되어 있는 쿼리 혹은 그룹화가 되어있는 쿼리에서는
-- 그룹화한 컬럼과 집계함수를 제외한 컬럼은 select 절에서 사용이 불가능
Select AVG(amount), date, employee_number
From sale
Group by employee_number, date;

-- 필터링 (Having) : 그룹화된 결과에 필터 작업을 수행
-- 주의!! Where 절과 사용방법이 비슷하지만 Where 절은 조회할 때 사용, having 절은 조회 결과에 사용

-- 결과 테이블에 존재하지 않는 컬럼은 Having절에서 사용할 수 없음
Select 
	avg(amount) '평균', 
	employee_number '사번'
From sale
Where date < '2024-07-05'
Group by employee_number;
-- Having avg(amount) <= 100000;
