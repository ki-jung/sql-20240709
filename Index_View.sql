Use practice_sql;

-- 인덱스 (Index) : 테이블에서 원하는 컬럼을 빠르게 조회하기 위해 사용하는 구조

-- 인덱스 생성
-- Create Index 인덱스이름 ON 테이블명(컬럼,...)
Create Index employee_name_idx ON employee (name);
Create Index employee_name_age_idx ON employee (name, age);
Create Index employee_name_desc_idx On employee (name Desc);

-- 테이블 인덱스 추가
-- Alter Table 테이블명 Add Index 인덱스이름(컬럼명)
Alter Table sale Add index amount_idx (amount);

-- 인덱스 삭제
-- Drop Index 인덱스명 On 테이블명
Drop Index employee_name_desc_idx ON employee;

-- 테이블에서 인덱스 삭제
-- Alter table 테이블명 drop index 인덱스명
Alter table employee drop index employee_name_age_idx;

-- 뷰(view) : 물리적으로 존재하지 않는 읽기전용의 가상 테이블
-- 조회문을 미리 작성해서 재사용하는 용도, 컬럼에 대한 제한된 보기를 제공하는 용도

-- 뷰 생성
-- Create View 뷰이름 As Select ...
Create View employee_view As 
Select
	E.employee_number '사번',
    E.name '사원이름',
    D.department_code '부서코드',
    D.name '부서명',
    D.tel_number '부서전화번호'
From employee E left join department D 
On E.department_code = D.department_code
Order by 부서명;

Drop view employee_view;

Select * From employee_view;
-- View는 물리적으로 데이터가 저장되는
 것이 아니기 때문에 
-- insert, update, delete 및 index 생성이 불가능

-- View 수정
-- Alter View 뷰이름 As Select ...
Alter View employee_view As 
Select
	E.employee_number '사번',
    E.name '사원이름',
    D.name '부서명',
    D.tel_number '부서전화번호'
From employee E left join department D 
On E.department_code = D.department_code
Order by 부서명;
-- View 삭제
-- Drop view 뷰이름