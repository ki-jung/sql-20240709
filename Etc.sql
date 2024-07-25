Use practice_sql;

-- 조건문
-- case : 특정 값을 비교하여 일치하는 작업을 수행
-- case 컬럼 
-- When 비교할 값1 Then 비교값1과 컬럼이 일치할 때 결과
-- when 비교값 2 then 비교값2와 컬럼이 일치할 때 결과
-- else 비교값1과 비교값2가 모두 컬럼과 일치하지 않을 때 결과

-- case
-- when 조건1 Then 조건1이 참일 때 결과
-- when 조건2 Then 조건2가 참일 때 결과
-- Else 조건1과 조건2가 모두 거짓일때 결과

Select date, (
	Case 
		When amount > 100000 Then '고액'
        else '저액'
	End
) '금액'
From sale;

-- If 함수 : 첫번째 매개변수로 전달한 표현식에 따라 결과를 반환하는 함수
-- If (조건, 참일때 결과, 거짓일때 결과)
Select date, If(amount > 100000, '고액', '소액')
From sale;

-- Ifnull 함수: 첫번째 매개변수의 값이 null인지에 따라 결과를 반환하는 함수
-- Ifnull(값, 값이 null일때 반환할 결과)
Select 사번, 사원이름, Ifnull(부서명, '없음')
From employee_view;

-- 문자열 함수 : 문자열 조작을 도와주는 함수들
-- length() : 문자열의 길이를 반환
Select length(name) / 3 from employee;

-- concat(문자열 ...) : 매개변수로 전달받은 문자열들을 결합
-- 매개변수 중 하나라도 null이면 null을 반환 
Select concat(사원이름,부서명)From employee_view;

-- left(문자열,길이), right(문자열,길이) : 문자열을 왼쪽, 오른쪽에서부터 추출
Select left(사원이름,2), Right(사원이름,2) 
From employee_view;

-- replace(기준문자열, 찾을문자열, 바꿀문자열) : 특정 문자열을 지정한 문자열로 변경하는 함수
Select Replace(사원이름, '길동','순자')
From employee_view;