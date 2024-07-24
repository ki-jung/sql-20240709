-- 데이터베이스 생성
-- officetel
CREATE DATABASE officetel;
USE officetel; 

-- 이메일 인증 테이블
CREATE TABLE email_auth(
   email varchar(100)primary key check (email regexp '^[a-zA-Z0-9]*@([-.]?[a-zA-Z0-9])*\.[a-zA-Z]{2,4}$'),
   auth_number varchar(4) not null check(auth_number regexp '^[0-9]{4}$')
   );
   
-- 회원 테이블
create table user (
  id varchar(20) primary key,
  password varchar(255) not null,
  email varchar(100) not null unique,
  join_path varchar(5) not null default 'home',
  role varchar(6) not null default 'normal',
  constraint user_email_fk foreign key(email)references email_auth(email)
  );
  
  -- 게시물 테이블
  create table board (
   recipt_number int primary key auto_increment,
   title varchar(50) not null,
   status boolean not null default false,
   writer_id varchar(20) not null,
   writer_date datetime not null default now(),
   view_count int not null default 0,
   contents varchar(1000) not null,
   reply text,
   constraint writer_fk foreign key(writer_id) references user(id)
   );
   
   -- 로그인
   SELECT * FROM user WHERE id = 'qwer1234' and password = 'qwer1234';
   
   select * from user where id = :id;
   
   -- 아이디 중복확인 
   select * from user where id = 'qwer1234';
  
  -- 이메일 인증
  INSERT INTO email_auth values ('qwer1234@qwer.com', '0123');
  
  -- 이메일 인증 확인
  Select * From email_auth Where email = 'qwer1234@qwer.com' and '1234';
  
  -- 회원가입 
  Insert into user(id, password, email) values ('qwer1234', 'qwer1234', 'qwer1234@qwer.com');
  
  -- 게시물 리스트
  Select status,title, writer_id, writer_date, view_count,recipt_number
  from board
  where title like '%%'
  order by recipt_number desc
  limit 10, 10;
  
  -- 게시물 작성
  Insert into board (title, contents, writer_id)
  values ('열세번째 게시물', '안녕하세요', 'qwer1234');
  
  -- 게시물 상세보기 
  Update board Set view_count = view_count + 1
  Where  recipt_number = 1;
  
  Select 
     recipt_number,
     title,
     writer_id,
     writer_date,
     view_count,
     contents,
     reply
  FROM board
  where recipt_number = 1;
  
  -- 답글 작성
  Update board Set reply = '반갑습니다', status = true
  where recipt_number = 1;
  
  -- 게시물 수정
  Update board set title = '게시물 수정', contents = '안녕하세요'
  Where recipt_number = 1;
  
  -- 게시물 삭제
  Delete From board Where recipt_number = 1;