/*/* Drop Triggers */

DROP TRIGGER TRI_TB_ADMIN_ADM_NUM;
DROP TRIGGER TRI_TB_QUESTION_QUES_REAL_Q_NUM;


/* Drop Tables */

DROP TABLE TB_ADMIN CASCADE CONSTRAINTS;
DROP TABLE TB_ANSWER CASCADE CONSTRAINTS;
DROP TABLE TB_QUESTION CASCADE CONSTRAINTS;
DROP TABLE TB_RESULT CASCADE CONSTRAINTS;
DROP TABLE TB_UPDATE_MEMORY CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_TB_ADMIN_ADM_NUM;
DROP SEQUENCE SEQ_TB_QUESTION_QUES_REAL_Q_NUM;
*/

=====================================================

/* Delete Sequences */
drop sequence SEQ_TB_ADMIN_ADM_NUM;
drop sequence SEQ_TB_QUESTION_RNUM;
drop sequence SEQ_TB_ANSWER_RNUM;
drop sequence SEQ_TB_RESULT_BIZNUM;
drop sequence SEQ_TB_UPDATE_MEMORY_NUM;

/* Delete Tables*/
delete from TB_QUESTION;
delete from TB_ANSWER;
delete from TB_RESULT;
delete from TB_UPDATE_MEMORY;

/* Create Sequences */

CREATE SEQUENCE SEQ_TB_ADMIN_ADM_NUM INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_TB_QUESTION_RNUM INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_TB_ANSWER_RNUM INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_TB_RESULT_BIZNUM INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_TB_UPDATE_MEMORY_NUM INCREMENT BY 1 START WITH 1;

/* Create Tables */

-- 관리자
CREATE TABLE TB_ADMIN
(
	-- 관리자번호
	ADM_NUM number(10) NOT NULL,
	-- 관리자ID
	ADM_ID varchar2(50 char) NOT NULL,
	-- 관리자 비밀번호
	ADM_PASSWORD varchar2(50 char) NOT NULL,
	PRIMARY KEY (ADM_NUM)
);

-- 답변
CREATE TABLE TB_ANSWER
(
	-- 답변 번호
	ANSW_REAL_NUM number(10) NOT NULL,
	-- 해당 문항 세부 답변 번호
	ANSW_Q_INSIDE_NUM number(10) NOT NULL,
	-- 다음 문항 연계 단계
	ANSW_NEXT_LEVEL number(10),
	-- 다음 문항 연계 세부 번호
	ANSW_NEXT_NUM number(10),
	-- 답변 텍스트
	ANSW_TEXT varchar2(200 char),
	-- 마지막 답변 여부
	ANSW_FINAL_YN char NOT NULL,
	-- 최종 사업 번호
	BIZ_NUM number(10),
	-- 등록일자
	ANSW_DATE timestamp NOT NULL,
	-- 수정 횟수
	ANSW_REVISE number(30) NOT NULL,
	PRIMARY KEY (ANSW_REAL_NUM)
);


-- 문항
CREATE TABLE TB_QUESTION
(
	-- 문항 실 번호
	QUES_REAL_Q_NUM number(10) NOT NULL,
	-- 문항 실 단계
	QUES_REAL_DEPTH number(10) NOT NULL,
	-- 문항 세부 단계 번호
	QUES_NUM number(10),
	-- 문항 텍스트
	QUES_TEXT varchar2(200 char) NOT NULL,
	-- 등록일자
	QUES_DATE timestamp NOT NULL,
	-- 수정 횟수
	QUES_REVISE number(30) NOT NULL,
	PRIMARY KEY (QUES_REAL_Q_NUM)
);


-- 결과
CREATE TABLE TB_RESULT
(
	-- 최종 사업 번호
	BIZ_NUM number(10) NOT NULL,
	-- 최종 사업 텍스트
	RES_BIZ_TEXT varchar2(100 char),
	-- 연결 주소 URL
	RES_LINK varchar2(500 char) NOT NULL,
	-- 결과 도출 카운트
	RES_COUNT number(10),
	-- 등록일자
	RES_DATE timestamp NOT NULL,
	-- 수정 횟수
	RES_REVISE number(30) NOT NULL,
	PRIMARY KEY (BIZ_NUM)
);

CREATE TABLE TB_UPDATE_MEMORY
(
	-- 기록 번호
	MEMO_NUM number(10) NOT NULL,
	-- 기록 팀
	MEMO_DEPT_NAME VARCHAR2(50 CHAR) DEFAULT 'MANAGER' NOT NULL,
	-- 기록자
	MEMO_ADMIN_NAME VARCHAR2(50 CHAR) NOT NULL,
	-- 기록 데이터 종류
	MEMO_DATA_KIND VARCHAR2(50 CHAR) NOT NULL
	CONSTRAINT DATA_KIND_CHECK CHECK(MEMO_DATA_KIND IN('문항', '답변', '결과')),
	-- 기록 데이터 번호
	MEMO_DATA_NUM number(10) NOT NULL,
	-- 기록 종류
	MEMO_KIND VARCHAR2(10 CHAR) NOT NULL
	CONSTRAINT KIND_CHECK CHECK(MEMO_KIND IN('작성', '수정')),
	-- 기록 변경 내용
	MEMO_UPDATE_TEXT VARCHAR2(500 CHAR) NOT NULL,
	-- 기록 일시
	MEMO_DATE timestamp DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (MEMO_NUM)
);

/* 보여주기 여부 추가 */
alter table TB_ANSWER ADD ANSW_IS_SHOWING CHAR DEFAULT 'Y' NOT NULL;
alter table TB_QUESTION ADD QUES_IS_SHOWING CHAR DEFAULT 'Y' NOT NULL;
alter table TB_RESULT ADD RES_IS_SHOWING CHAR DEFAULT 'Y' NOT NULL;

/* 최초 작성자 추가 */
alter table TB_QUESTION ADD QUES_FIRST_WRITER VARCHAR2(50 CHAR) DEFAULT 'DBA' NOT NULL;
alter table TB_ANSWER ADD ANSW_FIRST_WRITER VARCHAR2(50 CHAR) DEFAULT 'DBA' NOT NULL;
alter table TB_RESULT ADD RES_FIRST_WRITER VARCHAR2(50 CHAR) DEFAULT 'DBA' NOT NULL;

/* 관리자 팀 분류 추가*/
alter table TB_ADMIN ADD ADM_DEPT_NAME VARCHAR2(50 CHAR) DEFAULT 'DBA' NOT NULL;


/* 통계 VIEW 추가 */
create OR REPLACE view statistics_Result(count_sum, total_count) as
select sum(res_count), count(biz_num)
	from TB_RESULT 
	where res_is_showing = 'Y' and biz_num > 0
	WITH READ ONLY;

/* Create Foreign Keys */

ALTER TABLE TB_ANSWER
	ADD FOREIGN KEY (BIZ_NUM)
	REFERENCES TB_RESULT (BIZ_NUM)
;

/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_TB_ADMIN_ADM_NUM BEFORE INSERT ON TB_ADMIN
FOR EACH ROW
BEGIN
	SELECT SEQ_TB_ADMIN_ADM_NUM.nextval
	INTO :new.ADM_NUM
	FROM dual
END;

/

CREATE OR REPLACE TRIGGER TRI_TB_QUESTION_QUES_REAL_Q_NUM BEFORE INSERT ON TB_QUESTION
FOR EACH ROW
BEGIN
	SELECT SEQ_TB_QUESTION_QUES_REAL_Q_NUM.nextval
	INTO :new.QUES_REAL_Q_NUM
	FROM dual;
END;
/ 

/* Comments */

COMMENT ON TABLE TB_ADMIN IS '관리자';
COMMENT ON COLUMN TB_ADMIN.ADM_NUM IS '관리자번호';
COMMENT ON COLUMN TB_ADMIN.ADM_ID IS '관리자ID';
COMMENT ON COLUMN TB_ADMIN.ADM_PASSWORD IS '관리자 비밀번호';
COMMENT ON TABLE TB_ANSWER IS '답변';
COMMENT ON COLUMN TB_ANSWER.ANSW_REAL_NUM IS '답변 번호';
COMMENT ON COLUMN TB_ANSWER.ANSW_Q_INSIDE_NUM IS '해당 문항 세부 답변 번호';
COMMENT ON COLUMN TB_ANSWER.ANSW_NEXT_LEVEL IS '다음 문항 연계 단계';
COMMENT ON COLUMN TB_ANSWER.ANSW_NEXT_NUM IS '다음 문항 연계 세부 번호';
COMMENT ON COLUMN TB_ANSWER.ANSW_TEXT IS '답변 텍스트';
COMMENT ON COLUMN TB_ANSWER.ANSW_FINAL_YN IS '마지막 답변 여부';
COMMENT ON COLUMN TB_ANSWER.BIZ_NUM IS '최종 사업 번호';
COMMENT ON COLUMN TB_ANSWER.ANSW_DATE IS '등록일자';
COMMENT ON COLUMN TB_ANSWER.ANSW_REVISE IS '수정 횟수';
COMMENT ON TABLE TB_QUESTION IS '문항';
COMMENT ON COLUMN TB_QUESTION.QUES_REAL_Q_NUM IS '문항 실 번호';
COMMENT ON COLUMN TB_QUESTION.QUES_REAL_DEPTH IS '문항 실 단계';
COMMENT ON COLUMN TB_QUESTION.QUES_NUM IS '문항 세부 단계 번호';
COMMENT ON COLUMN TB_QUESTION.QUES_TEXT IS '문항 텍스트';
COMMENT ON COLUMN TB_QUESTION.QUES_DATE IS '등록일자';
COMMENT ON COLUMN TB_QUESTION.QUES_REVISE IS '수정 횟수';
COMMENT ON TABLE TB_RESULT IS '결과';
COMMENT ON COLUMN TB_RESULT.BIZ_NUM IS '최종 사업 번호';
COMMENT ON COLUMN TB_RESULT.RES_BIZ_TEXT IS '최종 사업 텍스트';
COMMENT ON COLUMN TB_RESULT.RES_LINK IS '연결 주소 URL';
COMMENT ON COLUMN TB_RESULT.RES_COUNT IS '결과 도출 카운트';
COMMENT ON COLUMN TB_RESULT.RES_DATE IS '등록일자';
COMMENT ON COLUMN TB_RESULT.RES_REVISE IS '수정 횟수';

/*230530 관리자 추적 테스트*/
INSERT INTO TB_ADMIN(adm_num, adm_id, adm_password, ADM_DEPT_NAME)
VALUES(SEQ_TB_ADMIN_ADM_NUM.nextval, 'platform_1', 'platform_1*', '플랫폼운영팀');

========================================================================
/*TB_QUESTION TABLE*/
INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 1, 1, '귀하의 현재 상황을 선택하여 주십시오.',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 1, 2, '귀하의 현재 직장규모를 선택하여 주십시오.',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 2, 1, '귀하는 어느 분야에서 도움을 받고 싶습니까?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 3, 1, '교육을 수강하고 싶습니까?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 3, 2, '어떻게 판매하고 싶습니까?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 3, 3, '어떤 도움을 받고 싶나요?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 4, 1, '교육 방식은 어떤 방식을 선호하십니까?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 4, 2, '어떤 방안을 알고 싶습니까?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 4, 3, '어디서 판매하고 싶습니까?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 4, 4, '어떤 방식을 선호하시나요?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 4, 5, '어떤 방식을 선호하시나요?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 5, 1, '현재 자사의 홍보광고 영상을 보유하고 있습니까?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 5, 2, '현재 제품의 부족한 부분을 알고 있습니다.',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 5, 3, '어느 수준으로 도와드릴까요?',
SYSDATE, 0, 'Y');

INSERT INTO TB_QUESTION(ques_real_q_num, ques_first_writer, ques_real_depth, ques_num, ques_text, ques_date, ques_revise, ques_is_showing)
VALUES(SEQ_TB_QUESTION_RNUM.nextval, 'DBA', 5, 4, '라이브 방송을 선호하시나요?',
SYSDATE, 0, 'Y');


/*TB_RESULT TABLE*/
/*230523 연결링크 수정*/
INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '소진공', '소상공인 인플루언서 교육', 'https://fanfandaero.kr/portal/preSprtBizPbancDetail.do?sprtBizCd=202303020602', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '디지털운영', '온라인시장 진출 교육', 'https://valuebuy.kr/education', 0, SYSDATE, 0); 

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '미디어지원', '우수제품 홍보 및 광고', 'https://fanfandaero.kr/portal/preSprtBizPbancDetail.do?sprtBizCd=202303020200', 0, SYSDATE, 0); /*SBDC에 해당 사업내용이 없음*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '미디어지원', '콘텐츠 제작지원', 'https://www.sbdc.or.kr/menu2/sosang8', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '디지털혁신', '상품개선 컨설팅', 'https://fanfandaero.kr/portal/preSprtBizPbancDetail.do?sprtBizCd=202303020300', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '디지털운영', '전담셀러 매칭지원', 'https://fanfandaero.kr/portal/preSprtBizPbancDetail.do?sprtBizCd=202303020400', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '디지털판로', '온라인쇼핑몰 입점지원', 'https://fanfandaero.kr/portal/preSprtBizPbancDetail.do?sprtBizCd=202303010400', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '디지털판로', '해외쇼핑몰 입점지원', 'https://fanfandaero.kr/portal/preSprtBizPbancDetail.do?sprtBizCd=202303010900', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '미디어운영', '라이브커머스 제작 및 운영', 'https://fanfandaero.kr/portal/preSprtBizPbancDetail.do?sprtBizCd=202303010603', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '미디어운영', '라이브스튜디오 운영', 'https://www.sbdc.or.kr/menu2/sosang12', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '미디어지원', 'TV홈쇼핑 및 T-커머스 입점지원', 'https://fanfandaero.kr/portal/preSprtBizPbancDetail.do?sprtBizCd=202303010200', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '미디어지원', '미디어커머스 입점지원', 'https://fanfandaero.kr/portal/preSprtBizPbancDetail.do?sprtBizCd=202303010100', 0, SYSDATE, 0);

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '중소기업유통센터', 'O2O 융합판매 및 기획전', 'https://www.sbdc.or.kr/menu2/sosang7', 0, SYSDATE, 0);

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '중소기업유통센터', 'O2O 플랫폼 진출 지원', 'https://www.sbdc.or.kr/menu2/sosang7', 0, SYSDATE, 0);

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '플랫폼운영', '가치삽시다 플랫폼', 'https://portal.valuebuy.kr/', 0, SYSDATE, 0);

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '미디어기획', '디지털커머스 전문기관(소담스퀘어)', 'https://www.sbdc.or.kr/menu2/sosang10', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

INSERT INTO TB_RESULT(biz_num, res_first_writer, res_biz_text, res_link, res_count, res_date, res_revise)
VALUES(SEQ_TB_RESULT_BIZNUM.nextval, '미디어기획', '스마트 플래그십 스토어(소담상회)', 'https://www.sbdc.or.kr/menu2/sosang11', 0, SYSDATE, 0); /*230523 수정(판판대로 -> SBDC)*/

/*TB_ANSWER TABLES*/
INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 1, 2, 1, '예비 창업자', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 2, 1, 2, '영업자', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 2, 2, 1, '중기업', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 2, 2, 1, '소기업', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 1, 2, 1, '소상공인', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 3, 3, 1, '온라인으로 진출하는 방법에 대해 알고싶어요.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 3, 3, 2, '온라인 채널에서 판매하는 방법에 대해 알고 싶어요.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 3, 3, 3, '온라인 기반 구축이 필요해요.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 4, 4, 1, '예', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 4, 4, 2, '아니오', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 5, 4, 3, '쇼핑몰에 입점하고 싶습니다.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 5, 4, 4, '방송하고 싶습니다.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 5, 4, 5, '온라인과 오프라인 모두 경험하고 싶습니다.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 6, 4, 0, '디지털 전환에 대한 정보를 얻고 싶어요', 'Y', 15, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 6, 4, 0, '온라인 진출을 위한 인프라를 도움받고 싶어요.', 'Y', 16, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 6, 4, 0, '오프라인에서 체험하고 온라인에서 판매하고 싶어요.', 'Y', 17, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 7, 5, 0, '실습을 통해 온라인 진출을 배우고 싶습니다.', 'Y', 1, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 7, 5, 0, 'e-러닝 교육을 통해 온라인 진출 전반의 방법을 배우고 싶습니다.', 'Y', 2, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 8, 5, 1, '저는 온라인 홍보방법에 대해 알고 싶습니다.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 8, 5, 2, '저는 제품 개선방법에 대해 알고 싶습니다.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 9, 5, 0, '국내에서 판매하고 싶습니다.', 'Y', 7, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 9, 5, 0, '해외 판로로 확장하고 싶습니다.', 'Y', 8, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 10, 5, 3, '기획부터 방송송출까지 제가 하고 싶습니다.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 10, 5, 4, '홈쇼핑에서 방송하고 싶어요.', 'N', 0, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 11, 5, 0, '집중적으로 매출을 올리는 경험을 해보고 싶어요.', 'Y', 13, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 11, 5, 0, '오프라인에서 온라인으로 확장하고 싶어요.', 'Y', 14, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 12, 6, 0, '예', 'Y', 3, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 12, 6, 0, '아니오', 'Y', 4, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 13, 6, 0, '예', 'Y', 5, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 13, 6, 0, '아니오', 'Y', 6, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 14, 6, 0, '저는 전체적인 도움이 필요해요', 'Y', 9, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 14, 6, 0, '저는 스튜디오만 있으면 되요.', 'Y', 10, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 15, 6, 0, '예', 'Y', 11, SYSDATE, 0, 'Y');

INSERT INTO TB_ANSWER(answ_real_num, answ_first_writer, answ_q_inside_num, answ_next_level, answ_next_num, answ_text, answ_final_yn, biz_num, answ_date, answ_revise, answ_is_showing)
VALUES(SEQ_TB_ANSWER_RNUM.nextval, 'DBA', 15, 6, 0, '아니오', 'Y', 12, SYSDATE, 0, 'Y');