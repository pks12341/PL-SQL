SET SERVEROUTPUT ON
-- 커서 FOR 루프

DECLARE
        CURSOR emp_cursor IS
                    SELECT employee_id, last_name, job_id
                    FROM employees
                    WHERE department_id = &부서번호;
            
BEGIN

        FOR emp_rec IN emp_cursor LOOP
                DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT); --몇번쨰 행인지 // 이게 end loop 밑에 있으면 오류남
                DBMS_OUTPUT.PUT(', ' || emp_rec.employee_id);
                DBMS_OUTPUT.PUT(', ' || emp_rec.last_name);
                DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.job_id);
                
        END LOOP; -- LOOP가 끝나면서 커서가 종료된다는 의미도 있다..
    --DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT); --몇번쨰 행인지

END;
/

BEGIN
        FOR emp_rec IN (SELECT employee_id, last_name
                                        FROM employees
                                        WHERE department_id = &부서번호 ) LOOP
                
                DBMS_OUTPUT.PUT(', ' || emp_rec.employee_id);
                DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.last_name);
        
        END LOOP;
        
END;
/

--1) 모든 사원의 사원번호, 이름, 부서이름 출력

--방법1
--DECLARE
--               CURSOR emp_cursor IS
--               SELECT employee_id eid, last_name ename, department_name dname    
--                                     FROM employees LEFT join departments 
--                                    on employees.department_id = departments.department_id
--                                    ORDER BY employee_id asc
--    
--BEGIN
--                         FOR emp_rec IN emp_cursor LOOP           
--                DBMS_OUTPUT.PUT(', ' || emp_rec.eid);
--                DBMS_OUTPUT.PUT(', ' || emp_rec.ename);
--                DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.dname);
--               
--        END LOOP;
--
--
--END;
--/


DECLARE
               
    
BEGIN
        FOR emp_rec IN(SELECT employee_id eid, last_name ename, department_name dname    
                                     FROM employees LEFT join departments 
                                    on employees.department_id = departments.department_id
                                    ORDER BY employee_id asc) LOOP
                                    
                DBMS_OUTPUT.PUT(', ' || emp_rec.eid);
                DBMS_OUTPUT.PUT(', ' || emp_rec.ename);
                DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.dname);
               
        END LOOP;


END;
/


--2) 부서번호가 50이거나 80인 사원들의 사원이름,급여,연봉 출력
--(급여*12+(NVL(급여,0)*NVL(커미션,0)*12))


----방법1
--DECLARE
--CURSOR emp_cursor IS
--SELECT last_name lname, salary sal, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual , department_id did, employee_id eid --연봉은 별칭필요
--                FROM employees 
--                WHERE department_id IN(50,80) -- or과 쓰임 비슷
--                ORDER BY employee_id asc
--                
--BEGIN
--FOR emp_rec In emp_cursor LOOP
--   DBMS_OUTPUT.PUT('부서번호:  '||emp_rec.did);
--                    DBMS_OUTPUT.PUT(' 사번 :  '|| emp_rec.eid || ', ' );
--                    DBMS_OUTPUT.PUT('사원이름 : '|| emp_rec.lname || ', ' );
--                    DBMS_OUTPUT.PUT('급여 : ' ||emp_rec.sal || ', ' );
--                    DBMS_OUTPUT.PUT_LINE('연봉: '||emp_rec.annual);
--                    END LOOP;
--
--END;
--/




DECLARE


BEGIN
FOR emp_rec IN(  SELECT last_name lname, salary sal, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual , department_id did, employee_id eid 
                FROM employees 
                WHERE department_id IN(50,80) -- or과 쓰임 비슷
                ORDER BY employee_id asc) LOOP
                
                DBMS_OUTPUT.PUT('부서번호:  '||emp_rec.did);
                    DBMS_OUTPUT.PUT(' 사번 :  '|| emp_rec.eid || ', ' );
                    DBMS_OUTPUT.PUT('사원이름 : '|| emp_rec.lname || ', ' );
                    DBMS_OUTPUT.PUT('급여 : ' ||emp_rec.sal || ', ' );
                    DBMS_OUTPUT.PUT_LINE('연봉: '||emp_rec.annual);
                    
                      END LOOP;

END;
/

DECLARE
            CURSOR emp_cursor
                    (p_deptno NUMBER) IS
                    SELECT last_name, hire_date
                    FROM employees
                    WHERE department_id = p_deptno;
                    
        emp_info emp_cursor%ROWTYPE;

BEGIN
        OPEN emp_cursor(60);
        
        FETCH emp_cursor INTO emp_info;
        
        DBMS_OUTPUT.PUT_LINE(emp_info.last_name);
        
     
        
        CLOSE emp_cursor;

END;
/

SELECT last_name,hire_date
from employees
where department_id = 60;

-- 현재 존재하는 모든 부서의 각 소속사원을 출력하고, 없는 경우 현재 소속사원이 없다고 출력하기 커서2개 사용해야 함 루프문도 2개
-- format 
/*=======부서명 : 부서 풀 네임
1.사원번호, 사원이름, 입사일, 업무
2.사원번호, 사원이름, 입사일, 업무
.
.
커서가 가져야 하는 반복문?
SELECT department_id, department_name
from departments; --모든 부서라 했으니 where절x

--2번쨰 쿼리문
SELECT last_name, hire_date,job_id
from employees
WHERE department_id = &department_id;

하나는 일반커서,하나는 매개변수 쓰는 커서
*/
DECLARE
        CURSOR dept_cursor IS
                    SELECT department_id, department_name
                    from departments; --모든 부서라 했으니 where절x

--2번쨰 쿼리문

        CURSOR emp_cursor(p_deptno NUMBER) IS
                SELECT employee_id, last_name, hire_date, job_id
                from employees
                WHERE department_id = p_deptno;
                
        emp_rec emp_cursor%ROWTYPE;
BEGIN
       FOR dept_rec IN dept_cursor LOOP
       DBMS_OUTPUT.PUT_LINE('=========부서명' || dept_rec.department_name);
        OPEN emp_cursor(dept_rec.department_id);
                
                LOOP
                        FETCH emp_cursor INTO emp_rec;
                        EXIT WHEN emp_cursor%NOTFOUND ;
                        
                         DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT);
                         DBMS_OUTPUT.PUT(', ' || emp_rec.employee_id);
                         DBMS_OUTPUT.PUT(', ' || emp_rec.last_name);
                         DBMS_OUTPUT.PUT(', ' || emp_rec.hire_date);
                         DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.job_id);
                END LOOP;
                
                
                IF emp_cursor%ROWCOUNT = 0 THEN
                   DBMS_OUTPUT.PUT_LINE('현재 소속사원이 없습니다.');
                END IF;
                
                CLOSE emp_cursor;        
                
    END LOOP;
        
END;
/
DECLARE

CURSOR emp_cursor(p_deptno NUMBER) IS
                SELECT employee_id, last_name, hire_date, job_id
                from employees
                WHERE department_id = p_deptno;
                
                BEGIN
                
                FOR emp_rec IN emp_cursor(60) LOOP
                         DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT);
                         DBMS_OUTPUT.PUT(', ' || emp_rec.employee_id);
                         DBMS_OUTPUT.PUT(', ' || emp_rec.last_name);
                         DBMS_OUTPUT.PUT(', ' || emp_rec.hire_date);
                         DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.job_id);
                
                END LOOP;

END;
/

-- FOR UPDATE, WHERE CURRENT OF
--특정부서에속한사람들의 부서와커미션 employee_id라는 pk가존재하지않지만 update가능하다
--commission이 null인 사람들이 월급 10% 상승함
DECLARE
    CURSOR sal_info_cursor IS
        SELECT salary, commission_pct
        FROM employees
        WHERE department_id = 60
        FOR UPDATE OF salary, commission_pct NOWAIT;
BEGIN
    FOR sal_info IN sal_info_cursor LOOP
        IF sal_info.commission_pct IS NULL THEN
            UPDATE employees
            SET salary = sal_info.salary * 1.1
            WHERE CURRENT OF sal_info_cursor;  --명시적 커서에서 현재행을 참조
        ELSE
            UPDATE employees
            SET salary = sal_info.salary + sal_info.salary * sal_info.commission_pct
            WHERE CURRENT OF sal_info_cursor;
        END IF;
    END LOOP;
END;
/

SELECT salary, commission_pct
        FROM employees
        WHERE department_id = 60;
        
        
        ---예외 처리
        --1) 이미 정의되어 있고 이름도 존재하는 예외사항일 경우
        DECLARE
            v_ename employees.last_name%TYPE;
        BEGIN
            SELECT last_name
            INTO v_ename
            FROM employees
            WHERE department_id = &부서번호;
            
            DBMS_OUTPUT.PUT_LINE(v_ename);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
                DBMS_OUTPUT.PUT_LINE('해당 부서에 속한 사원이 없습니다.');
                
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('해당 부서에는 여러명의 사원이 존재합니다.');
                DBMS_OUTPUT.PUT_LINE('예외처리 끝');
        END;
        /
        
        -- 2) 이미 정의는 되어있지만 고유의 이름이 존재하지 않는 예외사항
        DECLARE
                e_emps_remaining EXCEPTION;
                PRAGMA EXCEPTION_INIT(e_emps_remaining, -02292);
                
                
        BEGIN
                DELETE FROM departments
                WHERE department_id = &부서번호;
        EXCEPTION
                WHEN e_emps_remaining THEN
                        DBMS_OUTPUT.PUT_LINE('해당 부서에 속한 사원이 존재합니다.');
        END;
        /
        
    --3) 사용자 정의 사항 예외(-10000원 등)
    
    DECLARE
        e_no_deptno EXCEPTION;
        v_ex_code NUMBER;
        v_ex_msg VARCHAR2(1000);
    BEGIN
            DELETE FROM departments
            WHERE department_id = &부서번호;
            
            IF SQL%ROWCOUNT =0 THEN
                   RAISE e_no_deptno;
                    --DBMS_OUTPUT.PUT_LINE('해당 부서번호는 존재하지 않습니다.');
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('해당 부서번호가 삭제되었습니다.');
    EXCEPTION
            WHEN e_no_deptno THEN
                    DBMS_OUTPUT.PUT_LINE('해당 부서번호는 존재하지 않습니다.');
            WHEN OTHERS THEN
                    v_ex_code := SQLCODE;
                    v_ex_msg := SQLERRM;
                    DBMS_OUTPUT.PUT_LINE(v_ex_code);
                    DBMS_OUTPUT.PUT_LINE(v_ex_msg);
    
    END;
    /
        
    CREATE TABLE test_employee
    AS
            SELECT * 
            FROM employees;
            
    -- test_employee 테이블을 사용하여 특정 사원을 삭제하는 PL/SQL 작성
    --입력처리는 치환변수 사용
    --해당 사원이 없는 경우를 확인해서 '해당 사원이 존재하지 않습니다'를 출력하세요
    
DECLARE
      e_no_emp EXCEPTION;
      v_eid employees.employee_id%TYPE := &사원번호;
      
BEGIN
    DELETE FROM test_employee
    WHERE employee_id = v_eid;
    
    
    
      IF SQL%ROWCOUNT =0 THEN
                   RAISE e_no_emp;
               
            END IF;
                     DBMS_OUTPUT.PUT(v_eid || ',');
                    DBMS_OUTPUT.PUT_LINE( '삭제되었습니다.');
            
            
        EXCEPTION
            
         WHEN e_no_emp THEN 
                DBMS_OUTPUT.PUT('입력한 : '|| v_eid || ', ');
                DBMS_OUTPUT.PUT_LINE('현재 테이블이 존재하지 않습니다');           
    
    
 END;
    /
    
    
    --PROCEDURE
    
    CREATE OR REPLACE PROCEDURE test_pro
    -- ()
    IS
    --IS 와 BEGIN 사이가 DECLARE:선언부 의 역할을 함..DECLARE를 생략함
    --지역변수, 레코드,커서,EXCEPTION 
    
    
    BEGIN
        DBMS_OUTPUT.PUT_LINE('First Procedur');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('예외처리');
    
    END;
    /
    --1)블록 내부에서 호출하는ㅂ 방식
    BEGIN
            test_pro;      
    END;
    /
    --2) execute 명령어 사용(간단한 테스트용)
    EXECUTE test_pro;
    
    --3)create로 만든건 drop으로만 삭제가능
    DROP PROCEDURE test_pro;
    
    -- IN OUT IN OUT
    
    --IN은 값을 받고 내부에서 일어나는 연산의결과를 OUT에 담아서돌려줌
    
    --IN => raise_salary 들어가 보면 p_eid가 readonly라 값을 넣으면 오류남
    
    CREATE PROCEDURE raise_salary
    
    (p_eid IN NUMBER)
    IS
    
    BEGIN
       -- p_eid := 100;
        
        UPDATE employees
        SET salary = salary*1.1
        WHERE employee_id = p_eid;
    END;
    /
    
    DECLARE
        v_id employees.employee_id%TYPE := &사원번호;
        v_num CONSTANT NUMBER := v_id;
    BEGIN
        RAISE_SALARY(v_id);
        RAISE_SALARY(v_num);
        RAISE_SALARY(v_num + 100);
        RAISE_SALARY(200);  
        
    END;
    /
    select * from employees where employee_id = 114;
    
    
    EXECUTE RAISE_SALARY(188);
    
    
    
    CREATE OR REPLACE PROCEDURE pro_plus
    
    (p_x IN NUMBER,
    p_y IN NUMBER,
    p_result OUT NUMBER)
    
    IS
            v_sum NUMBER;
    BEGIN
            DBMS_OUTPUT.PUT(p_x);
            DBMS_OUTPUT.PUT( '+' || p_y);
            DBMS_OUTPUT.PUT_LINE('='|| p_result);
            
            v_sum := p_x + p_y;
              p_result := v_sum;
    DBMS_OUTPUT.PUT_LINE(p_result);
            
    END;
    /
    
    DECLARE
        v_first NUMBER := 10;
        v_second NUMBER :=12;
        v_result NUMBER := 100;
        
    BEGIN
         DBMS_OUTPUT.PUT_LINE('before ' || v_result);
        pro_plus(v_first,v_second,v_result);
        DBMS_OUTPUT.PUT_LINE('after ' || v_result);              --result 값이 사라짐 => OUT모드의 값을 연산식 중 하나에 넣으면 null됨..  --IN은 값을 받고 내부에서 일어나는 연산의결과를 OUT에 담아서돌려줌
    END;
    /
    
    --IN OUT /in과out을 하나의 모드로 처리하고자 나옴//포맷 변경용도로 많이씀 
    --01012341234 => 010-1234-1324
    CREATE PROCEDURE format_phone
    (p_phone_no IN OUT VARCHAR2) -- 010에서 앞에 0이있어서 varchar로..매개변수일땐 크기 생략 가능
    IS
    
    BEGIN
        p_phone_no:= SUBSTR(p_phone_no, 1,3)
                                    || '-' || SUBSTR(p_phone_no, 4,4)
                                    || '-' || SUBSTR(p_phone_no, 8);
    
    
    END;
    /
    
    DECLARE 
            v_no VARCHAR2(50) := '01012341234';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('before' || v_no);
        format_phone(v_no);
        DBMS_OUTPUT.PUT_LINE('after' || v_no);
    
    END;
    /
    
    
    /*
    1.주민번호 입력하면 다음처럼 출력되도록 yedam_ju 프로시저 작성
    EXECUTE yedam_ju('9501011667777')  => 숫자로 하면안됨(2000년대생이 00이 날아감)
    EXECUTE yedam_ju('1511013689977')
    
    ->950101-1******

    추가) 해당 주민등록번호를 기준으로 해서 실제 생년월일 출력하는 부분 추가
    //rr쓰면 안됨 1949년생을 2049년생으로 인식함 => 1,2,3,4로 성별 구별하는걸 활용해서 20,21c 구분
    9501011667777 => 1995년 10월 11일
    1511013689977 => 2015년 11월 01일

    
    */
    

    CREATE OR REPLACE PROCEDURE yedam_ju
    (p_ssn IN VARCHAR2) -- 010에서 앞에 0이있어서 varchar로..매개변수일땐 크기 생략 가능
IS
    v_result VARCHAR2(100);
 v_gender  CHAR(1);
    v_birth VARCHAR2(11 char);
    
    BEGIN
    
         -- v_result := SUBSTR(p_ssn,1,6) ||'-'|| SUBSTR(p_ssn,7,1)||'******'; 이렇게해도되고
                                      
            v_result := SUBSTR(p_ssn,1,6) ||'-'|| RPAD(SUBSTR(p_ssn,7,1),7,'*');
            DBMS_OUTPUT.PUT_LINE(v_result);
            
            --추가
             v_gender := SUBSTR(p_ssn,7,1) ;
             
             IF v_gender IN ('1', '2','5','6') THEN
                    v_birth := '19'||SUBSTR(p_ssn,1,2)||'년'
                                        ||SUBSTR(p_ssn,3,2)||'월'
                                        ||SUBSTR(p_ssn,5,2)||'일';
                                        
             ELSIF v_gender IN ('3', '4','7','8') THEN
                v_birth := '20'||SUBSTR(p_ssn,1)
                                        
             
             END IF;
             DBMS_OUTPUT.PUT_LINE(v_birth);
            
    END;
    /
    
    EXECUTE yedam_ju('0011013689977');

/*
2.
사원번호를 입력할 경우
삭제하는 TEST_PRO 프로시저를 생성하시오.

단, 해당사원이 없는 경우 "해당사원이 없습니다." 출력

예) EXECUTE TEST_PRO(176)

입력 : 사원번호, 출력 : X    => IN모드 매개변수 사용
연산 : 입력받은 사원번호 삭제  => DELETE, employees 
지역변수 필요x delete만할거라


*/
CREATE OR REPLACE PROCEDURE TEST_PRO
(p_eid IN employees.employee_id%TYPE)
IS
    e_no_emp EXCEPTION;
                PRAGMA EXCEPTION_INIT(e_no_emp, -02292);
    BEGIN
    
        DELETE
        FROM test_employee
        WHERE employee_id = p_eid;
        
        
           IF SQL%ROWCOUNT =0 THEN
              
                   -- DBMS_OUTPUT.PUT_LINE('해당 사원이 없습니다');
               RAISE e_no_emp;
            END IF;
            
             EXCEPTION
                WHEN e_no_emp THEN
                        DBMS_OUTPUT.PUT_LINE('해당 사원이 없습니다');
         
    END;
    /
EXECUTE TEST_PRO(145);
select * from test_employee where employee_id = 145;



/*
3.
다음과 같이 PL/SQL 블록을 실행할 경우 
사원번호를 입력할 경우 사원의 이름(last_name)의 첫번째 글자를 제외하고는
'*'가 출력되도록 yedam_emp 프로시저를 생성하시오.

실행) EXECUTE yedam_emp(176)
실행결과) TAYLOR -> T*****  <- 이름 크기만큼 별표(*) 출력

입력 : 사원번호 -> IN

연산 1)select,사원이름

2)해당 이름의 포맷 변경 : substr, length, RPAD 사용
2)출력

*/
CREATE OR REPLACE PROCEDURE yedam_emp2(p_eid IN employees.employee_id%TYPE)
IS
    v_ename employees.last_name%TYPE;
    v_result v_ename%TYPE;
    
BEGIN
    SELECT last_name
    INTO v_ename
    FROM employees
    WHERE employee_id = p_eid;
    
    v_result := RPAD(SUBSTR(v_ename,1,1), LENGTH(v_ename), '*');
    DBMS_OUTPUT.PUT_LINE(v_ename ||' ->'||v_result);


END;
/

EXECUTE yedam_emp2(111);









CREATE OR REPLACE PROCEDURE yedam_emp(p_eid IN NUMBER)
IS
    v_last_name employees.last_name%TYPE;
BEGIN
    -- 입력받은 사원번호에 해당하는 사원의 last_name을 조회
    SELECT last_name INTO v_last_name
    FROM employees
    WHERE employee_id = p_eid;

    -- last_name이 NULL이 아니면 출력
    IF v_last_name IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE(v_last_name || ' -> ' || SUBSTR(v_last_name, 1, 1) || RPAD('*', LENGTH(v_last_name) - 1, '*'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('해당 사원이 없습니다');
    END IF;
END yedam_emp;
/
EXECUTE yedam_emp(111);







/*

4.
직원들의 사번, 급여 증가치만 입력하면 Employees테이블에 쉽게 사원의 급여를 갱신할 수 있는 y_update 프로시저를 작성하세요. 
만약 입력한 사원이 없는 경우에는 ‘No search employee!!’라는 메시지를 출력하세요.(예외처리)
실행) EXECUTE y_update(200, 10)

입력 : 사번,급여증가치(비율)
연산 : 사원의 급여를 갱신 => 급여 증가치(비율)
            UPDATE employees
            SET salary = salary + (salary*증가치/100)  => 정수로 입력받는걸 가정했을떄, 
            실수로 가정한다면 SET salary = salary+(salary*증가치);
            WHERE employee_id = 입력받는사번;
            
            


++기존 월급->인상월급도 출력해봄
*/

CREATE OR REPLACE PROCEDURE y_update(p_eid IN employees.employee_id%TYPE,p_sal2 In employees.salary%TYPE)
IS
    v_salary employees.salary%TYPE;
    e_no_empno EXCEPTION;
    origin_sal employees.salary%TYPE;
    after_sal employees.salary%TYPE;
BEGIN
   
   SELECT salary
   INTO origin_sal
   FROM test_employee
   WHERE employee_id = p_eid;
   
     DBMS_OUTPUT.PUT_LINE('기존sal : '||origin_sal);
     
  
    UPDATE test_employee
    SET salary = salary * (1+(p_sal2/100))
    WHERE employee_id = p_eid;

    IF SQL%ROWCOUNT =0 THEN
                   RAISE e_no_empno;
                 
            END IF;
            
            
SELECT salary
   INTO after_sal
   FROM test_employee
   WHERE employee_id = p_eid;
            
DBMS_OUTPUT.PUT_LINE('new sal : '||after_sal);

 EXCEPTION
            WHEN e_no_empno THEN
                    DBMS_OUTPUT.PUT_LINE('No search employee!!..');
                    
            WHEN NO_DATA_FOUND THEN
                     DBMS_OUTPUT.PUT_LINE('No DATA!..');
END;
/
exec y_update(111,1);
select * from test_employee where employee_id = 182;


/*
5.
다음과 같이 테이블을 생성하시오.
create table yedam01
(y_id number(10),
 y_name varchar2(20));

create table yedam02
(y_id number(10),
 y_name varchar2(20));
5-1.
부서번호를 입력하면 사원들 중에서 입사년도가 2005년 이전 입사한 사원은 yedam01 테이블에 입력하고,
입사년도가 2005년(포함) 이후 입사한 사원은 yedam02 테이블에 입력하는 y_proc 프로시저를 생성하시오.
 
 입력 : 부서번호
 연산 : 해당 사원 -> 앞서 만든 테이블에 INSERT
            1) SELECT => CURSOR 
            2) IF문, 입사일(입사년도)
            2-1) 입사년도 < 2005년 yedam01테이블 insert
            입사년도 >= 2005 yedam02테이블 insert
 
5-2. => 사용자 정의 예외 필요
1. 단, 부서번호가 없을 경우 "해당부서가 없습니다" 예외처리 => cursor를 다 순환시켰을때 rowcount가 없을떄
2. 단, 해당하는 부서에 사원이 없을 경우 "해당부서에 사원이 없습니다" 예외처리 => NO_DATA_FOUND 사용


*/

CREATE OR REPLACE PROCEDURE y_proc(p_deptno IN departments.department_id%TYPE)
IS
        CURSOR emp_cursor IS
                SELECT employee_id, last_name, hire_date -- => yedam01,02,테이블의 칼럼이 id와 name이다
                FROM employees
                WHERE department_id = p_deptno;
                
                emp_rec emp_cursor%ROWTYPE; --변수를 설정한 이유 : cursor for loop사용하기 좋지않아서
               
                v_deptno departments.department_id%TYPE;
                e_no_emp EXCEPTION;
                
        BEGIN
        
        SELECT department_id
        INTO v_deptno
        FROM departments
        WHERE department_id = p_deptno;
        
        OPEN emp_cursor;
        
        LOOP
                FETCH emp_cursor INTO emp_rec;
                EXIT WHEN emp_cursor%NOTFOUND;
                
                --1)
                --IF hire_date < TO_DATE('05-01-01', 'yy-MM-dd')THEN -- to_date의 2번째 파라미터는 어떤 형식으로 처리할건지
                --2)연도 등 일부분만 비교할땐 to_char이 좋다
                IF TO_CHAR(emp_rec.hire_date, 'yyyy')<'2005' THEN
                    --2005년 이전이므로 01로 삽입
                    INSERT INTO yedam01
                    VALUES (emp_rec.employee_id, emp_rec.last_name);
                ELSE
                --02로 삽입
                    INSERT INTO yedam02
                    VALUES (emp_rec.employee_id, emp_rec.last_name); 
                
                END IF;
        END LOOP;
        
            IF emp_cursor%ROWCOUNT = 0 THEN
                    RAISE e_no_emp;
             END IF;
        
        CLOSE emp_cursor;


EXCEPTION
    WHEN e_no_emp THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서에는 사원이 없습니다.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 부서는 없습니다.');


END;
/

exec y_proc(80);

select * from yedam01;


--    
--    
--    CREATE OR REPLACE PROCEDURE y_update(p_employee_id IN NUMBER, p_salary_increase IN NUMBER)
--IS
--    v_new_salary NUMBER;
--BEGIN
--    -- 급여를 증가시킬 사원의 현재 급여 조회
--    SELECT salary + p_salary_increase
--    INTO v_new_salary
--    FROM employees
--    WHERE employee_id = p_employee_id;
--
--    -- 사원이 존재하면 급여를 갱신
--    IF SQL%FOUND THEN
--        UPDATE employees
--        SET salary = v_new_salary
--        WHERE employee_id = p_employee_id;
--
--        DBMS_OUTPUT.PUT_LINE('사원번호 ' || p_employee_id || '의 급여가 갱신되었습니다.');
--    ELSE
--        -- 해당 사원이 없는 경우 예외 처리
--        RAISE_APPLICATION_ERROR(-20001, 'No search employee!!');
--    END IF;
--END y_update;
--/
--
--    
--    
--    

begin
select department_name
from departments
WHERE department_id = 10;

END;
/