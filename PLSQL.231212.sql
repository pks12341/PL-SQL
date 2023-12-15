SET SERVEROUTPUT ON


--치환변수를 사용하면 숫자를 입력하면 해당 구구단 출력되게 하시오
--예) 2입력시
--2*1 = 2
--2*2=4
--......2*9 =18
--입력 :단 
--출력 : 단*곱하는수 = 결과( 단*곱하는수)
--곱하는 수 : 1-9사이 정수값 => 반복문으로 제어

--기본 LOOP
DECLARE
    v_num NUMBER(2,0) := &숫자;
    v_num2 NUMBER(2,0) := 1;   
    v_res NUMBER(2,0) ;
BEGIN

 DBMS_OUTPUT.PUT_LINE(v_num||'단 ================ ');
    LOOP
    v_res := v_num * v_num2;
        DBMS_OUTPUT.PUT_LINE(v_num ||'*'||v_num2 ||'='|| v_res);
        v_num2 := v_num2+1;
       
        EXIT WHEN v_num2 > 9;
      
    END LOOP;
     DBMS_OUTPUT.PUT_LINE(' ================ ');
  
END;
/

--while

DECLARE
    v_num NUMBER(2,0) := &숫자;
    v_num2 NUMBER(2,0) := 1;   
    v_res NUMBER(2,0);
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_num||'단 ================ ');
        WHILE v_num2 <= 9 LOOP
        v_res := v_num * v_num2;

        DBMS_OUTPUT.PUT_LINE(v_num ||'*'||v_num2 ||'='|| v_res);     
        v_num2 := v_num2+1;
     
    END LOOP;
     DBMS_OUTPUT.PUT_LINE(' ================ ');
 
END;
/

--for

DECLARE
    v_num NUMBER(1,0) := &단;
BEGIN
    FOR v_num2 IN 1..9 LOOP
    
        DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || (v_num * v_num2));
    END LOOP;
END;
/

/*3.구구단 2~9단까지 출력되도록 하시오 이중반복문*/

--기본
DECLARE
    v_num NUMBER := 2;
    v_num2 NUMBER:=0;
    v_res NUMBER := 0;
BEGIN
 
 LOOP
DBMS_OUTPUT.PUT_LINE(v_num ||'단');
    v_num2 := 1;
    LOOP -- 곱하는 수
     v_res := v_num * v_num2;
    DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || v_res);
        v_num2 := v_num2 + 1;
       
        
       
        EXIT WHEN v_num2 > 9;    
    END LOOP;
     
    v_num := v_num+1;
    EXIT WHEN v_num >=10;
    
END LOOP;
 
END;
/

-- for쓰는방법
DECLARE
    v_num NUMBER := 2;
    v_num2 NUMBER;
    v_res NUMBER;
    BEGIN
        FOR v_num IN 2..9 LOOP
        DBMS_OUTPUT.PUT_LINE(v_num ||'단');
        
            FOR v_num2 IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || (v_num * v_num2));
        
            END LOOP;
       
 END LOOP;
 
END;
/

--while 방법
DECLARE
    v_dan NUMBER := 2;
    v_num NUMBER := 1;
    v_msg varchar2(1000);
    BEGIN
        WHILE v_num <10 LOOP --특정단 1_9곱하는 loop
            v_dan := 2;
            WHILE v_dan < 10 LOOP --특정단 2_9까지반복하는 loop문
                v_msg := (v_dan || 'x' || v_num || '=' ||  v_dan*v_num);
                
                 DBMS_OUTPUT.PUT(RPAD(v_msg, 10,' ')); -- rpad(글자,길이)
                 v_dan := v_dan +1;
        END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
         v_num := v_num+1;
    END LOOP;
 END;
 /


/*4. 구구단 1~9단까지 출력되도록 하시오(단,홀수단 출력) MOD사용하기, MOD(가지고 있는 숫자, 나누는 수) => 나머지 */

DECLARE
    v_num NUMBER := 0;
    v_num2 NUMBER:=0;
    v_res NUMBER := 0;
BEGIN

 LOOP

    v_num2 := 1;
    DBMS_OUTPUT.PUT_LINE(v_num||'단');
    LOOP
     v_res := v_num * v_num2;
      
      IF MOD(v_num,2) = 1 THEN
       
        DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || v_res);
       
       END IF;
         v_num2 := v_num2 + 1;
       
        EXIT WHEN v_num2 > 9;    
    END LOOP;
     
    v_num := v_num+1;
    EXIT WHEN v_num >=10;
    
END LOOP;
 
END;
/
--for문방식

DECLARE
    v_num NUMBER := 2;
    v_num2 NUMBER:=0;
    v_res NUMBER := 0;
    BEGIN
        FOR v_num IN 1..9 LOOP
        IF MOD(v_num,2) <>0 THEN -- <>: ~아니다 라는뜻 !=로 해도됨
        
         DBMS_OUTPUT.PUT_LINE(v_num||' 단');
            FOR v_num2 IN 1..9 LOOP
            
                DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || (v_num * v_num2));
                END LOOP;
                 DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
    
END;
/

--for-continue 방식
DECLARE
    v_num NUMBER := 2;
    v_num2 NUMBER:=0;
    v_res NUMBER := 0;
    BEGIN
        FOR v_num IN 1..9 LOOP
            IF MOD(v_num,2) <>0 THEN             -- <>: ~아니다 라는뜻 !=로 해도됨
                continue; -- 아닌 것들을 걸러내는 방식
         END IF;
         DBMS_OUTPUT.PUT_LINE(v_num||' 단');
            FOR v_num2 IN 1..9 LOOP
            
                DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || (v_num * v_num2));
                END LOOP;
                 DBMS_OUTPUT.PUT_LINE(' ');
       
    END LOOP;
    
END;
/





-- RECORD
DECLARE
    TYPE info_rec_type IS RECORD -- 이름짓는 규칙은 없지만 rec_type을 붙이는게 좋다
            ( no NUMBER NOT NULL := 1,
              name VARCHAR2(1000) := 'No Name',
              birth DATE );
              
    user_info info_rec_type;
    
BEGIN
            DBMS_OUTPUT.PUT_LINE(user_info.no); 
            user_info.birth := sysdate;
            DBMS_OUTPUT.PUT_LINE(user_info.birth); 

END;
/


DECLARE
        emp_info_rec employees%ROWTYPE;
        
BEGIN
    SELECT  * 
    INTO emp_info_rec
    FROM employees
    WHERE employee_id = &사원번호;
            
    DBMS_OUTPUT.PUT_LINE(emp_info_rec.employee_id); 
    DBMS_OUTPUT.PUT_LINE(emp_info_rec.last_name); 
    DBMS_OUTPUT.PUT_LINE(emp_info_rec.job_id); 

    
END;
/

--사원번호,이름,부서 이름을 출력할때..ROWTYPE은 한 테이블만 가능하므로 못쓴다(부서이름)
--의미적으로 이상하지만 정상적인 이유 : 필드명은 관련없고 데이터 타입의 순서에 따름
DECLARE
    TYPE emp_rec_type IS RECORD
                ( eid employees.employee_id%TYPE, -- NUMBER
                  ename employees.last_name%TYPE, --VARCHAR2
                  deptname departments.department_name%TYPE); --VARCHAR2 
                  
        emp_rec emp_rec_type;
BEGIN
          SELECT employee_id, last_name, department_name
          INTO emp_rec -- 개별적으로 적던걸 묶었다고 생각하면 됨
          FROM employees e JOIN departments d
                                            ON (e.department_id = d.department_id)-- USING(department_id)////on 대신 using을 대신 써도됨 -> e,d 뺴야함
         WHERE employee_id = &사번;
                                            
        DBMS_OUTPUT.PUT_LINE(emp_rec.ename); 
        DBMS_OUTPUT.PUT_LINE(emp_rec.eid); 
        DBMS_OUTPUT.PUT_LINE(emp_rec.deptname); 

END;
/

--TABLE

DECLARE
-- 1 ) 정의
TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY BINARY_INTEGER;

-- 2 ) 선언
num_list num_table_type;


BEGIN
--array[0]      =>   table(0)     // [  ] 대신 () 
    num_list(-1000) := 1;
    num_list(1234) := 2;
    num_list(11111) := 3;    

    DBMS_OUTPUT.PUT_LINE(num_list.count);
    DBMS_OUTPUT.PUT_LINE(num_list(1234));
    DBMS_OUTPUT.PUT_LINE(num_list(-1000));
END;
/

DECLARE
-- 1 ) 정의
TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY BINARY_INTEGER;

-- 2 ) 선언

num_list num_table_type;


BEGIN
    FOR i IN 1..9  LOOP
        num_list(i) := 2*i;
                

    END LOOP;

    FOR  idx IN num_list.FIRST.. num_list.LAST LOOP
        IF num_list.EXISTS(idx) THEN --exists => 있으면 true
            DBMS_OUTPUT.PUT_LINE(num_list(idx));
        END IF;
    
    END LOOP;
    
    
END;
/


DECLARE
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
        INDEX BY BINARY_INTEGER;
        
        emp_table emp_table_type;
        emp_rec employees%ROWTYPE;
BEGIN

    FOR eid IN 100 .. 110 LOOP
        SELECT *
         INTO emp_rec
        FROM employees
        WHERE employee_id = eid;
    
    emp_table(eid) := emp_rec;
    
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(emp_table(100).employee_id);
    DBMS_OUTPUT.PUT_LINE(emp_table(100).last_name);
    DBMS_OUTPUT.PUT_LINE(emp_table(100).salary);
    DBMS_OUTPUT.PUT_LINE(emp_table(100).department_id);
    
    
    
    --순환
    FOR  idx IN emp_table.FIRST.. emp_table.LAST LOOP
        IF emp_table.EXISTS(idx) THEN --exists => 있으면 true
            DBMS_OUTPUT.PUT(emp_table(idx).employee_id ||' , ');
            DBMS_OUTPUT.PUT_LINE(emp_table(idx).last_name);
             
        END IF;
    
    END LOOP;
    
END;
/


--
--DECLARE
--    TYPE emp_table_type IS TABLE OF employees%ROWTYPE
--        INDEX BY BINARY_INTEGER;
--        
--        emp_table emp_table_type;
--        emp_rec employees%ROWTYPE;
--        
--        firstemployee NUMBER := 0;
--        lastemployee NUMBER := 0;
--BEGIN
--
--    FOR eid IN min(firstemployee) .. MAX(lastemployee) LOOP
--        SELECT *
--         INTO emp_rec
--        FROM employees
--        WHERE employee_id = eid;
--    
--    emp_table(eid) := emp_rec;
--    
--    END LOOP;
--    
--    --순환
--    FOR  idx IN emp_table.FIRST.. emp_table.LAST LOOP
--        IF emp_table.EXISTS(idx) THEN --exists => 있으면 true
--            DBMS_OUTPUT.PUT(emp_table(idx).employee_id ||' , ');
--            DBMS_OUTPUT.PUT_LINE(emp_table(idx).last_name);
--             
--        END IF;
--    
--    END LOOP;
--    
--END;
--/




--테이블 예제
DECLARE
    v_min employees.employee_id%TYPE; -- 최소 사원번호
    v_MAX employees.employee_id%TYPE; -- 최대 사원번호
    v_result NUMBER(1,0);             -- 사원의 존재유무를 확인
    emp_record employees%ROWTYPE;     -- Employees 테이블의 한 행에 대응
    
    TYPE emp_table_type IS TABLE OF emp_record%TYPE
        INDEX BY PLS_INTEGER;
    
    emp_table emp_table_type;
BEGIN
    -- 최소 사원번호, 최대 사원번호
    SELECT MIN(employee_id), MAX(employee_id)
    INTO v_min, v_max
    FROM employees;
    
    FOR eid IN v_min .. v_max LOOP
        SELECT COUNT(*)
        INTO v_result
        FROM employees
        WHERE employee_id = eid;
        
        IF v_result = 0 THEN
            CONTINUE;
        END IF;
        
        SELECT *
        INTO emp_record
        FROM employees
        WHERE employee_id = eid;
        
        emp_table(eid) := emp_record;     
    END LOOP;
    
    FOR eid IN emp_table.FIRST .. emp_table.LAST LOOP
        IF emp_table.EXISTS(eid) THEN -- 데이터가있는지 확인
            DBMS_OUTPUT.PUT(emp_table(eid).employee_id || ', ');
            DBMS_OUTPUT.PUT_LINE(emp_table(eid).last_name);
        END IF;
    END LOOP;    
END;
/

--  CURSOR
SELECT employee_id, last_name
                        FROM employees
                        WHERE department_id = 50;

------
                                                
DECLARE
                CURSOR emp_dept_cursor IS
                        SELECT employee_id, last_name
                        FROM employees
                        WHERE department_id = &부서번호;               
                
                v_eid employees.employee_id%TYPE;
                v_ename employees.last_name%TYPE;
                
BEGIN
        OPEN emp_dept_cursor;
        
        FETCH emp_dept_cursor INTO v_eid, v_ename ;
        DBMS_OUTPUT.PUT_LINE(v_eid);
        DBMS_OUTPUT.PUT_LINE(v_ename);

        CLOSE emp_dept_cursor;
        
END;
/


DECLARE
                CURSOR emp_info_cursor IS 
                SELECT employee_id eid, last_name ename, hire_date hdate --별칭을 사용해 필드명 변경 가능
                FROM employees
                WHERE department_id = &부서번호 --60,80입력
                ORDER BY hire_date DESC;
            
    emp_rec emp_info_cursor%ROWTYPE;
    
BEGIN

            OPEN emp_info_cursor;
            
            LOOP
                    FETCH emp_info_cursor INTO emp_rec;
                    EXIT WHEN emp_info_cursor%NOTFOUND OR emp_info_cursor%ROWCOUNT > 10;
                  --  EXIT WHEN emp_info_cursor%ROWCOUNT > 10;
                    
                    DBMS_OUTPUT.PUT(emp_info_cursor%ROWCOUNT || ', ' ); --loop안에서는 rowcount는 변동성이 있다 
                    DBMS_OUTPUT.PUT(emp_rec.eid || ', ' );
                    DBMS_OUTPUT.PUT(emp_rec.ename || ', ' );
                    DBMS_OUTPUT.PUT_LINE(emp_rec.hdate);
                    
        END LOOP;
        
        -- 커서의 총 데이터 숫자
        IF emp_info_cursor%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('현재 커서의 데이터는 존재하지 않습니다');
        END IF;
        
    CLOSE emp_info_cursor;
END;
/

SELECT department_id, COUNT(employee_id)
from employees right join departments
using(department_id)
group by department_id
order by 2 asc;


select * from employees;
--1) 모든 사원의 사원번호, 이름, 부서이름 출력
-- 입력 : x
-- 출력 : 사원번호, 이름, 부서이름 => 테이블 : employees + departments

DECLARE
                CURSOR emp_cursor IS 
                SELECT employee_id eid, last_name ename, department_name dname      --별칭을 사용해 필드명 변경 가능
                FROM employees LEFT join departments 
                on employees.department_id = departments.department_id
                ORDER BY employee_id asc;
            
    emp_rec emp_cursor%ROWTYPE;
    
BEGIN
            OPEN emp_cursor;
            
            LOOP
                    FETCH emp_cursor INTO emp_rec;
                    EXIT WHEN emp_cursor%NOTFOUND ;
                  --  EXIT WHEN emp_cursor%ROWCOUNT > 10;
                  
                    DBMS_OUTPUT.PUT('사번 : '|| emp_rec.eid || ', ' );
                    DBMS_OUTPUT.PUT('이름 : ' ||emp_rec.ename || ', ' );
                    DBMS_OUTPUT.PUT_LINE('부서: '||emp_rec.dname);
                    
        END LOOP;
        
        -- 커서의 총 데이터 숫자
        IF emp_cursor%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('현재 커서의 데이터는 존재하지 않습니다');
        END IF;
        
    CLOSE emp_cursor;
END;
/

--2) 부서번호가 50이거나 80인 사원들의 사원이름, 급여, 연봉 출력 --(급여*12+(NVL(급여,0)*NVL(커미션,0)*12))

DECLARE
                CURSOR emp_cursor IS 
                SELECT last_name lname, salary sal, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual , department_id did, employee_id eid --연봉은 별칭필요
                FROM employees 
                WHERE department_id IN(50,80) -- or과 쓰임 비슷
                ORDER BY employee_id asc;
            
    emp_rec emp_cursor%ROWTYPE;
    
BEGIN
        IF NOT emp_cursor%ISOPEN THEN           --open되지않았을때 open되게 하고..open상태면 바로 루프로 접근 가능
                OPEN emp_cursor;
        END IF;
        
            LOOP
                    FETCH emp_cursor INTO emp_rec;
                    EXIT WHEN emp_cursor%NOTFOUND ;
                    
                    
                  
                    DBMS_OUTPUT.PUT('부서번호:  '||emp_rec.did);
                    DBMS_OUTPUT.PUT(' 사번 :  '|| emp_rec.eid || ', ' );
                    DBMS_OUTPUT.PUT('사원이름 : '|| emp_rec.lname || ', ' );
                    DBMS_OUTPUT.PUT('급여 : ' ||emp_rec.sal || ', ' );
                    DBMS_OUTPUT.PUT_LINE('연봉: '||emp_rec.annual);
                    
                    
                    
        END LOOP;
        
        -- 커서의 총 데이터 숫자
        IF emp_cursor%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('현재 커서의 데이터는 존재하지 않습니다');
        END IF;
        
    CLOSE emp_cursor;
END;
/

--2번째 방식
--LOOP 안에 v_annual := nvl (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)); 를 집어넣는 방식도 있다( 더 자주 사용)

DECLARE

v_sal employees.salary%TYPE;
v_comm employees.commission_pct%TYPE;
v_annual v_sal%TYPE;
v_ename employees.last_name%TYPE;

CURSOR emp_cursor IS 
                SELECT salary sal, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual, last_name ename --연봉은 별칭필요
                FROM employees 
                WHERE department_id IN(50,80) 
                ORDER BY employee_id asc;
            
    emp_rec emp_cursor%ROWTYPE;
BEGIN
OPEN emp_cursor;

LOOP

    FETCH emp_cursor INTO  v_sal, v_annual, v_ename;
    exit when emp_cursor%NOTFOUND;
    
     v_annual := (v_sal*12+(NVL(v_sal,0)*NVL(v_comm,0)*12));
     DBMS_OUTPUT.PUT_LINE(v_ename||','||v_sal||','||v_annual);
     END LOOP;
     
            IF emp_cursor%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('현재 커서의 데이터는 존재하지 않습니다');
            END IF;
     CLOSE emp_cursor;
     
     END;
     /
     
    