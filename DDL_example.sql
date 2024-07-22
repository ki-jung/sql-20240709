-- 카타르 아시안컵 데이터

-- 참가팀(국가) (국가명, 조, 감독, 피파랭킹)
-- 선수 (이름, 나이, 포지션, 등번호, 국가)
-- 경기장 (경기장명, 수용인원, 주소)
-- 심판 (이름, 나이, 국적, 포지션)

-- 1. 카타르 아시안컵 데이터베이스 생성
-- qatar_asian_cup
CREATE DATABASE qatar_asain_cup;
use qatar_asain_cup;
-- 2. 개발자 계정 생성
-- qatar_developer / 접근위치 : 모든 곳에서 접근 가능 / 비밀번호 : qatar123
CREATE USER 'qatar_developer'@'%' IDENTIFIED BY 'qatar123';
-- 3. 테이블 생성 
-- 3.1. 참가국 : country (name[가변문자열 30], group_name[가변문자열 5], manager[가변문자열 30], ranking[정수]) 
CREATE TABLE country (
    name VARCHAR(30),
    group_name varchar(5),
    manager VARCHAR(30),
    ranking INT
);

-- 3.2. 선수 : player(name[가변문자열 30], age[정수], position[가변문자열 10], uniform_number[정수], country[가변문자열 30])
CREATE TABLE player(
    name VARCHAR(30),
    age INT,
    postion VARCHAR(10),
    uniform_number INT,
    country VARCHAR (30)
);
-- 3.3. 경기장 : stadium(name[가변문자열 50], volume[정수], address[문자열])
CREATE TABLE stadium(
    name VARCHAR(50),
    volume INT,
    address TEXT
);
-- 3.4. 심판 : referee(name[가변문자열 30], age[정수], country[가변문자열 30], position[가변문자열10])
CREATE TABLE referee (
    name VARCHAR(30),
    age INT,
    country VARCHAR(30),
    postion VARCHAR(10)
);