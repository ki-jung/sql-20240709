Use senicare;

-- 로그인 
-- 최종 사용자 (아이디, 비밀번호)
-- 요양사 테이블에 입력한 아이디와 비밀번호에 해당하는 레코드가 존재하면 로그인 성공
-- 필요한 추가 데이터 X
-- 추가 조치 : 아이디로만 조회를 하고 암호화된 비밀번호 체크를 서버측에서 실행
-- Select * From nurse Where id = :id and password = :password;


-- 회원가입 
-- 최종 사용자 (이름, 아이디, 비밀번호, 비밀번호 확인, 전화번호, 인증번호)
-- 요양사 테이블에 레코드를 생성 (아이디, 암호화된 비밀번호, 전화번호, 인증번호, 가입경로, 이름)
-- 필요한 추가데이터 : 가입경로 (화면에서 가져옴), 암호화된 비밀번호 (서버가 생성)

-- 레코드 삽입시 아이디 중복 검증
Select * From nurse Where id = 'qwer1234';
-- 레코드 삽입시 전화번호 중복 검증
Select * From nurse Where tel_number = '01012345678';
-- 절차상에 인증된 전화번호만 삽입 가능
Select * From nurse Where tel_number = '01012345678' and auth_number = '0123';

Insert into nurse values('qwer1234', 'qwerasdzxc', '홍길동', '01012345678', 'HOME');



-- 아이디 중복 확인 
-- 최종 사용자 (아이디)
-- 요양사 테이블에서 입력한 아이디에 해당하는 레코드가 존재하는지 확인
-- 필요한 추가 데이터 X
Select * From nurse Where id = 'qwer1234';

-- 전화번호 인증 
-- 최종 사용자 (전화번호)
-- 서버측에서 인증번호를 생성하여 사용자가 입력한 전화번호에 전송 후 
-- 전화번호 인증 테이블에 레코드(전화번호, 인증번호)를 추가
-- 필요한 추가 데이터 : 인증번호 (서버가 생성)

-- 레코드 삽입 시 이미 사용중인 전화번호인지 검증
Select * From nurse Where tel_number = '01012345678';
-- 레코드 삽입 시 이미 인증절차를 거치고 있는 전화번호인지 확인
Select * From tel_auth Where tel_number = '01012345678';
-- 1. 이미 인증 절차가 진행중인 전화번호가 있다면 해당 전화번호 인증 레코드를 삭제 후 삽입
-- Delete From tel_auth Where tel_number = '01012345678';
-- 2. 이미 인증 절차가 진행중인 전화번호가 있다면 해당 전화번호에 대한 인증 번호를 수정하는 작업으로 대체
Update tel_auth Set auth_number = '0123' Where tel_number = '01012345678';
insert into tel_auth values ('01012345678', '0123');


-- 인증번호 확인 
-- 최종 사용자 (인증번호)
-- 전화번호 인증 테이블에서 전화번호에 해당하는 인증번호가 사용자가 입력한 인증번호와 같은지 비교
-- 필요한 추가 데이터 : 전화번호 (화면에서 가져옴)
Select * From tel_auth Where tel_number = '01012345678' and auth_number = '0123';

-- 전체 고객 수 및 전체 페이지 수 불러오기 
-- 최종 사용자 () => (전체 고객 수, 전체 페이지 수)
-- 고객 테이블에서 전체 레코드의 개수와 전체 레코드의 개수에 10을 나눈 값에 소수점 첫번째 자리에서 올림한 값을 조회
Select count(*), ceil((count(*)) ,0) From customer;

-- 전체 고객 리스트 불러오기
-- 최종 사용자 (페이지 번호) => (고객번호, 고객명, 나이, 지역, 담당자 이름)
-- 고객 테이블에서 페이지 번호에 해당하는 위치부터 10개의 고객 수를 내림차순 반환 
-- 필요한 추가 데이터 : 페이지 번호에 해당하는 시작위치 (서버)
Select C.customer_number, C.name, C.birth, C.area, N.name
From customer C Inner Join nurse N
ON C.charger = N.id
order by customer_number desc
Limit 0,10;

-- 검색 고객 리스트 불러오기
-- 최종 사용자 (이름) => (고객번호, 고객명, 나이, 지역, 담당자 이름)
-- 고객 테이블에서 이름이 포함되어 있는 페이지들을 페이지 번호에 해당하는 위치부터 10개의 고객을 내림차순 반환 
-- 필요 추가 데이터 : 페이지 번호(화면에서 가져옴), 페이지 번호에 해당하는 시작위치 (서버가 생성)
Select C.customer_number, C.name, C.birth, C.area, N.name
From customer C Inner Join nurse N
ON C.charger = N.id
Where C.name Like '%이름%'
order by customer_number desc
Limit 0,10;

-- 고객 삭제
-- 최종 사용자 (고객 정보)
-- 고객 테이블에서 지정한 고객(고객 번호에 해당하는)의 레코드를 삭제하는 작업
-- 필요 추가 데이터: 고객 번호(화면에서), 로그인 사용자 아이디 (화면에서)
Select * From customer Where customer_number = 1 and charger = 'qwer1234'; 
Delete From customer Where customer_number = 1;

-- 고객 등록 
-- 최종 사용자(고객 사진, 고객 이름, 생년월일, 담당자 ,주소)
-- 고객 테이블에 레코드(고객 사진, 고객 이름, 지역, 생년월일, 담당자, 주소)를 삽입
-- 필요 추가 데이터 : 지역 (화면에서)

-- 레코드 삽입시 담당자에 대한 참조 제약 확인
Select * From nurse Where id = 'qwer1234';

Insert Into customer(name, area, charger, profile_image, birth, address)
values('이영희','부산광역시','qwer1234',null,'590826','부산광역시 부산진구...');

-- 담당자(요양사) 검색
-- 최종 사용자(이름) => 아이디, 이름, 전화번호
-- 요양사 테이블에서 이름을 기준으로 입력한 이름이 같은 레코드를 조회
-- 필요 추가 데이터 : X
Select * From nurse Where name = '홍길동';

-- 고객 상세보기
-- 최종 사용자 (고객 정보) => (고객 사진, 고객 이름, 생년월일, 담당자 이름, 주소)
-- 고객 테이블에서 특정 고객을 조회하여 반환, 담당자 이름을 반환하기위해 영양사 테이블을 조인
-- 필요 추가 데이터 : 고객 번호 (화면에서)
Select C.profile_image, C.name, C.birth, N.id,N.name, C.address
From customer C Inner join nurse N 
ON C.charger = N.id
Where C.customer_number = 1;
-- 관리 기록 리스트
-- 최종 사용자 (고객 정보) => (날짜, 내용, 사용용품, 개수)
-- 관리 기록 테이블에서 특정 고객에 대한 관리 기록리스트를 날짜 순으로 내림차순 정렬하여 조회
-- 추가 필요 데이터 : 고객 번호(화면에서)
Select CM.manage_date, CM.comment, G.name, CM.used_goods_count
From customer_management CM LEFT JOIN goods G
ON CM.used_goods = G.goods_number
Where CM.customer_number = 1
Order by CM.manage_date DESC;

-- 관리 기록
-- 최종 사용자 (내용, 사용용품, 용품개수)
-- 관리 기록 테이블에 레코드(고객번호, 날짜, 내용, 사용용품, 용품개수)
-- 추가 필요 데이터 : 고객번호(화면에서), 날짜(서버에서 생성)

-- 레코드 삽입시 고객 관계 검증
Select * From customer Where customer_number = 1;
-- 레코드 삽입시 용품 관계 검증(사용하는 용품이 있을 경우)
Select * From goods Where goods_number = 1;
Insert into customer_management Values(1, '2024-07-26', '최초 방문', null,null);
-- 절차상 사용한 용품의 개수 감소(사용하는 용품이 있을 경우)
Update goods Set count = count - 2 Where goods_number =1 ;

-- 고객 수정
-- 최종 사용자 (고객 사진, 고객 이름, 생년월일, 담당자, 주소)
-- 고객 테이블에서 특정 고객에 대한 레코드(고객 사진, 고객 이름, 생년월일 ,담당자, 주소)
-- 필요 추가 데이터 : 고객 번호(화면에서)

-- 수정을 하려고 하는 레코드가 존재하는지 확인
Select * From customer Where customer_number = 1;
-- 레코드 수정시 담당자 관계 확인
Select * From nurse Where id = 1;

Update customer Set 
	profile_image = 'http://~~',
    name = '고길동',
    birth = '590830',
    charger = 1,
    address = '부산광역시 부산진구...'
Where customer_number = 1;
