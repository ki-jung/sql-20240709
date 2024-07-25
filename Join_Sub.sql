Use practice_sql;
Drop table employee;
Drop table department;

Create Table employee (
   employee_number Int Primary Key auto_increment,
   name varchar(20),
   age int,
   department_code varchar(2)
);

Create Table department (
 department_code varchar(2) primary key,
 name varchar(30),
 tel_number varchar(15)
 );
 
 Alter Table employee
 add constraint department_code_fk
 Foreign key (department_code)
 References department(department_code);
 
 Alter table employee
 Drop constraint department_code_fk;
 
Insert into department values('A', '영업부', '123456');
Insert into department values('B', '재무부', '123457');
Insert into department values('C', '행정부', '123458');

Insert into employee (name, age, department_code)
values ('홍길동', 23, 'A');
Insert into employee (name, age, department_code)
values ('이영희', 15, 'A');
Insert into employee (name, age, department_code)
values ('고길동', 34, 'C');
Insert into employee (name, age, department_code)
values ('김둘리', 20, 'D');
Insert into employee (name, age, department_code)
values ('이도', 17, 'D');

Select * From employee;
Select * From department;

-- Alias :  쿼리문에서 사용되는 별칭 
-- 컬럼 및 테이블에서 사용가능
-- 사용하는 이름을 변경하고 싶을 때 사용
Select 
dpt.department_code '부서코드',
dpt.name '부서명',
dpt.tel_number '부서 전화번호'
From department dpt;

-- Join :  두 개 이상의 테이블을 특정 조건에 따라 조합하여 결과를 조회하고자 할 때 사용하는 명령어

-- Inner Join : 두 테이블에서 조건이 일치하는 레코드만 반환
-- Select column, ... From 기준테이블 Inner join 조합할 테이블 ON 조인 조건
Select 
	E.employee_number '사번',
	E.name '사원이름',
	E.age '나이',
	D.department_code '부서코드',
	D.name '부서명',
	D.tel_number '부서전화번호'
From employee E 
Inner Join department D 
ON E.department_code = D.department_code;

-- Left outer Join (Left join): 기준 테이블의 모든 레코드와 조합할 테이블 중 조건에 일치하는 레코드만 반환
-- 만약에 조합할 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 표현
Select 
	E.employee_number '사번',
	E.name '사원이름',
	E.age '나이',
	E.department_code '부서코드',
	D.name '부서명',
	D.tel_number '부서전화번호'
From employee E Left join department D
On E.department_code = D.department_code
Union 
Select 
	E.employee_number '사번',
	E.name '사원이름',
	E.age '나이',
	D.department_code '부서코드',
	D.name '부서명',
	D.tel_number '부서전화번호'
From employee E Right Join department D 
On E.department_code = D.department_code;

-- Right Outer Join (Right Join) : 조합할 테이블의 모든 레코드와 기준 테이블 중 조건에 일치하는 레코드만 반환
-- 만약 조합할 기준 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 반환
Select 
	E.employee_number '사번',
	E.name '사원이름',
	E.age '나이',
	D.department_code '부서코드',
	D.name '부서명',
	D.tel_number '부서전화번호'
From employee E Right Join department D 
On E.department_code = D.department_code;

-- full outer join : 기준 테이블의 모든 레코드와 조합할 테이블의 모든 레코드를 반환
-- 만약 기준 테이블 혹은 조합할 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 반환
-- MySQL 에서는 full outer join을 문법상 제공하지 않음
-- Full outer join = left outer join + right outer join

-- Cross join : 기준 테이블의 각 레코드를 조합할 테이블의 모든 레코드에 조합하여 반환
-- Cross join 결과 레코드 수 = 기준 테이블 레코드 수 * 조합할 테이블의 레코드 수
Select * 
From employee E cross join department D;
-- MySQL에서 기본 조인이 cross join 형태임
Select * 
From employee E join department D;

-- 부서코드가 A인 사원에 대해
-- 사번, 이름, 부서명을 조회하시오.
Select E.employee_number '사번', 
E.name'이름', 
D.name'부서명'
From employee E Inner join department D
On E.department_code = D.department_code
Where E.department_code = 'A';

-- 부서명이 '영업부'인 사원에 대해
-- 사번, 이름, 나이를 조회하시오.
Select E.employee_number, 
	E.name, 
	E.age
From employee E Inner join Department D 
On E.department_code = D.department_code
Where D.name = '영업부';

-- 서브쿼리 : 쿼리 내부에 존재하는 또 다른 쿼리, 쿼리 겨과를 조건이나 테이블로 사용할 수 있도록 함

-- Where 절에서 서브쿼리 : 조회 결과를 조건으로 사용하여 조건을 동적으로 지정할 수 있도록 함.
-- WHere 절에서 비교 연산등으로 사용할 때 조회하는 컬럼의 개수 및 레코드의 개수 주의
Select employee_number, name, age
from employee
Where department_code = (
	select department_code
    from department
    where name = '영업부'
    );
    
Select employee_number, name, age
from employee
Where department_code = (
	select *
    from department
);

Select employee_number, name, age
from employee
Where department_code IN (
	select *
    from department
);

select employee_number, name ,age
from employee
where department_code = (
	select department_code
	from department
	where name = '영업부'
);

-- From 절에서 서브쿼리 : 조회 결과 테이블을 다시 From 절에서 재사용

Select E.employee_number, 
	E.name, 
	E.age
From employee E Inner join (
	Select * From department
	Where name = '영업부'
)D
On E.department_code = D.department_code
Where D.name = '영업부';

-- 서브쿼리를 From 절에서 사용할 땐 반드시 별칭을 사용해야함.
Select * 
From (
	Select * From department
)
Where name = '영업부';