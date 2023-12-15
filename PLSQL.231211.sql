SET SERVEROUTPUT ON

DECLARE
    v_eid NUMBER;
    v_ename employees.first_name%TYPE;
    v_job VARCHAR2(1000);
    
BEGIN

    SELECT employee_id, first_name, job_id 
    INTO v_eid,v_ename, v_job
    FROM employees
    WHERE employee_id = 0;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('업무 : ' || v_job);
          
END;
/

DECLARE
    v_eid employees.employee_id%TYPE := &사원번호;
    v_ename employees.last_name%TYPE;
--치환 변수(컴파일할때 동작)
BEGIN
    SELECT first_name || ', ' || last_name
    INTO v_ename
    FROM employees
    WHERE employee_id = v_eid;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('사원이름 : ' || v_ename);

END;
/

-- 1) 특정 사원의 매니저에 해당하는 사원의 번호를 출력(특정사원은 치환변수를 이용해 입력받으면된다)

DECLARE
v_eid employees.employee_id%TYPE := &사원번호;
v_mgr employees.manager_id%TYPE;

BEGIN
    SELECT manager_id
    INTO v_mgr
    FROM employees
    WHERE employee_id=v_eid;
    
  DBMS_OUTPUT.PUT_LINE('상사 번호 : ' || v_mgr);
  
END;
/

-- insert, update

declare
    v_deptno departments.department_id%TYPE;
    v_comm employees.commission_pct%TYPE := 0.1;
begin
    SELECT department_id
    INTO v_deptno
    FROM employees
    WHERE employee_id = &사원번호;
    
    INSERT INTO employees(employee_id, last_name, email, hire_date,job_id, department_id)
    VALUES (1000, 'Hong','hkd@google.com',sysdate,'IT_PROG',v_deptno);
    
    DBMS_OUTPUT.PUT_LINE('등록 결과 : ' || SQL%ROWCOUNT);
    
    UPDATE employees
    SET salary = (NVL(salary,0) + 10000) * v_comm
    WHERE employee_id = 1000;
    
    DBMS_OUTPUT.PUT_LINE('수정 결과 : ' || SQL%ROWCOUNT);
    
end;
/

rollback;

SELECT * FROM employees WHERE employee_id = 1000;
--처음 1000번 넣을떄 salary가  null이어서 업데이트 하고나서도 null이고 업데이트는 정상적으로 됨 NVL넣어줘도됨

BEGIN
    DELETE FROM employees
    WHERE employee_id = &사원번호;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원은 존재하지 않습니다.');
    END IF;
END;
/

/*1.사원번호를 입력할경우 사원번호, 사원이름, 부서이름을 출력하는 pl.sql 작성. 사원번호는 치환변수를 통해 입력받기*/

declare
    v_id employees.employee_id%TYPE;
    v_name employees.last_name%TYPE;
    --v_dept_id employees.department_id%TYPE; select문 2개쓸때..
    v_dept_name departments.department_name%TYPE;

begin
    SELECT e.employee_id, e.last_name, d.department_name
     into v_id,v_name,v_dept_name
    FROM employees e 
    join departments d ON e.department_id = d.department_id
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : '  || v_id);
    DBMS_OUTPUT.PUT_LINE('사원이름 : '  || v_name);
    DBMS_OUTPUT.PUT_LINE('부서이름 : '  || v_dept_name);
    
    
    --방법2
    select employee_id, last_name, department_id
    into v_id,v_name,v_deptid
    from employees
    where employee_id = &사원번호;
    
    select department_name
    into v_deptname
    from departments
    where department_id = v_deptid;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 : '  || v_id);
    DBMS_OUTPUT.PUT_LINE('사원이름 : '  || v_name);
    DBMS_OUTPUT.PUT_LINE('부서이름 : '  || v_dept_name);

end;
/

select * from employees
where employee_id = 105;
/*2.사원번호를 입력할 경우 사원이름, 급여, 연봉을 출력하는 pl/sql 작성 . 사원번호는 치환변수를 사용하고

연봉은 아래의 공식을 기반으로 연산하시오(급여*12+(NVL(급여,0)*NVL(커미션,0)*12)) */

declare
v_name employees.last_name%TYPE;
v_salary employees.salary%TYPE;
--v_yb NUMBER;
v_yb v_salary%TYPE; --으로 해도 됨


begin

    SELECT last_name, salary, (salary*12+(NVL(salary,0)*NVL(COMMISSION_PCT,0)*12))
    into v_name,v_salary,v_yb
    FROM employees
    WHERE employee_id = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('사원이름 : '  || v_name);
    DBMS_OUTPUT.PUT_LINE('사원월급 : '  || v_salary);
    DBMS_OUTPUT.PUT_LINE('연봉 : '  || v_yb);

end;
/

--방법 2 =>deaclare에 (v_comm)  추가해야함..연산식을 select문에서 꼭 할 필요는없다
begin

    SELECT last_name, salary,commission_pct
    into v_name,v_salary,v_comm
    FROM employees
    WHERE employee_id = &사원번호;
    
    v_yb := v_salary *12 + NVL(v_salary,0) * NVL(v_comm, 0) *12;
    
    DBMS_OUTPUT.PUT_LINE('사원이름 : '  || v_name);
    DBMS_OUTPUT.PUT_LINE('사원월급 : '  || v_salary);
    DBMS_OUTPUT.PUT_LINE('연봉 : '  || v_yb);

END;
/

-- 기본IF문

BEGIN
    DELETE FROM employees
    WHERE employee_id = &사원번호;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('정상적으로 실행되지 않았습니다.');
        DBMS_OUTPUT.PUT_LINE('해당 사원은 존재하지 않습니다.');
    END IF;
    
    
END;
/
select * from employees
where employee_Id = 108;

--IF ~ ELSE 문 : 팀장 여부
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(employee_id) --COUNT : 테이블이 비었을때 결과를 도출(0or1)할 수 있는 유일한 함수.. 다른건 null뜸
    INTO v_count
    FROM employees
    WHERE manager_id = &eid;
    
    IF v_count = 0 then
        DBMS_OUTPUT.PUT_LINE('일반 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('팀장입니다.');
    END IF;
END;
/

--IF ~ ELSIF ~ ELSE 문 :연차

DECLARE
v_hdate NUMBER;

BEGIN

    SELECT TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12)
    INTO v_hdate
    FROM employees
    WHERE employee_id =  &사원번호;
    
    IF v_hdate < 5 THEN --입사 5년 미만
        DBMS_OUTPUT.PUT_LINE('입사한지 5년 미만입니다.');
    ELSIF v_hdate < 10 THEN -- 입사한지 5년이상-10년미만 
        DBMS_OUTPUT.PUT_LINE('입사한지 10년 미만입니다.');
    ELSIF v_hdate < 15 THEN -- 입사한지 10년이상-15년미만 
        DBMS_OUTPUT.PUT_LINE('입사한지 15년 미만입니다.');
    ELSIF v_hdate < 20 THEN -- 입사한지 15년이상-20년미만 
        DBMS_OUTPUT.PUT_LINE('입사한지 20년 미만입니다.');
    ELSE -- 입사한지 20년이상-25년미만  
        DBMS_OUTPUT.PUT_LINE('입사한지 25년 미만입니다.');
    END IF;
END;
/

SELECT employee_id, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12),
                            TRUNC((sysdate-hire_date)/365)
from employees
order by 2 desc;


-- 3. 사원번호를 입력(치환변수사용)할 경우 입사일이 2005년 이후(2005포함) 이면 new employee 출력
--2005 이전이면 Career employee 출력
-- rr yy 차이 알기
--입력 : 사원번호 ,출력 : 입사일 
--조건문 (if문) -> 입사일 >= 2005년 new employee
--elsif career employee출력
-- 


-- 1) 날짜 그대로 비교
DECLARE
v_hdate date;

BEGIN
SELECT hire_date
INTO v_hdate
from employees
where employee_id = &사원번호;

      IF v_hdate >= to_date('2005-01-01','yyyy-MM-dd')   THEN
        DBMS_OUTPUT.PUT_LINE('New employee');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Career employee');
END if;
END;
/
-- 2) 연도만 비교 to_char의 사용법..nn년 상반기 입사자들을 뽑거나 할때 사용할수 있다(7월 기준)
SELECT TO_CHAR(hire_date,'yyyy')
FROM employees;

DECLARE
v_year char(4 char);
BEGIN
    SELECT TO_CHAR(hire_date,'yyyy')
    into v_year
    FROM employees
    WHERE employee_id = &사번;
    
        IF v_year >= '2005' THEN
          DBMS_OUTPUT.PUT_LINE('New employee');
          ELSE
          DBMS_OUTPUT.PUT_LINE('Career employee');

    END IF;


END;
/

-- 3-2 사원번호를 입력(치환변수사용)할 경우 입사일이 2005년 이후(2005포함) 이면 new employee 출력
--2005 이전이면 Career employee 출력
-- rr yy 차이 알기
--입력 : 사원번호 ,출력 : 입사일 
--조건문 (if문) -> 입사일 >= 2005년 new employee
--elsif career employee출력
-- 단 DBMS_OUTPUT.PUT_LINE()은 코드 상 한번만 작성한다.

DECLARE
v_year char(4 char);
v_str varchar2(1000) := 'Career employee';

BEGIN
    SELECT TO_CHAR(hire_date,'yyyy')
    into v_year
    FROM employees
    WHERE employee_id = &사번;
    
--          IF v_year >= '2005' THEN
--          v_str := 'new employee';
--          ELSE
--          v_str := 'career employee';
--     
--     
--    END IF;
--    DBMS_OUTPUT.PUT_LINE(v_str);

--이렇게도 줄일수있다 declare에 기본값으로 carre employee로 주면..
    IF v_year >= '2005' THEN
          v_str := 'new employee';
          END IF;
          DBMS_OUTPUT.PUT_LINE(v_str);

END;
/

--4 급여가 5000이하이면 20% 인상된 급여
--급여가 10000 이하이면 15% 인상된 급여
--급여가 15000이하이면 10%인상된 급여
--급여가 15001 이상이면 급여인상X

--사원번호를 입력(치환변수)하면 사원이름,급여,인상된 급여가 출력되도록 pl/sql작성
--입력 : 사번 출력 : 사원이름,급여
DECLARE
v_ename employees.last_name%TYPE;
v_salary employees.salary%TYPE;
v_nsalary NUMBER := 0;

BEGIN
SELECT last_name, salary
into v_ename,v_salary
FROM employees
WHERE employee_id = &사번;

IF v_salary<=5000 THEN
    v_nsalary := 20;
ELSIF v_salary<=10000 THEN
    v_nsalary := 15;
    ELSIF v_salary<=15000 THEN
    v_nsalary := 10;
  
    END if;
    
     DBMS_OUTPUT.PUT_LINE('급여 :' || v_salary);
      DBMS_OUTPUT.PUT_LINE('이름 : ' || v_ename);
      DBMS_OUTPUT.PUT_LINE('인상 급여 : ' || (v_salary * (1+v_nsalary/100)));
      DBMS_OUTPUT.PUT_LINE('인상률 : ' || (((v_nsalary-v_salary)/v_salary)*10*-1)|| '%');
END;
/

--1에서 10까지 정수값을 더한 결과를 출력
--기본 LOOP

DECLARE
    v_num NUMBER(2,0) :=1; --1~10
    v_sum NUMBER(2,0) := 0;         -- 결 과
BEGIN
    LOOP
       
         v_sum := v_sum + v_num;
         v_num := v_num +1;
           
         EXIT WHEN v_num > 10;
         
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;
/

--WHILE LOOP

DECLARE
    v_num NUMBER(2,0) :=1; --1~10
    v_sum NUMBER(2,0) := 0;         -- 결 과
BEGIN
    WHILE v_num <= 10  LOOP --  EXIT WHEN v_num > 10;을 복사후 LOOP앞으로 붙여넣고 WHILE로 바꾼 후 
                                         --  조건을 줄 때 기본 LOOP문(v_num > 10)과 정 반대로 주면 된다
       
         v_sum := v_sum + v_num;
         
         v_num := v_num +1;
           
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;
-- FOR LOOP :--변수가 하나 줄어든다
--1)FOR LOOP 의 임시변수 => declare 절에 정의된 변수이름과 같으면 안된다..
--2)FOR LOOP는 기본적으로 오름차순 정렬이다. 내림차순하려면 in reverse 사용


DECLARE
    v_sum NUMBER(2,0) := 0;
    v_n NUMBER(2,0) := 99;
BEGIN
    FOR v_n IN REVERSE 1..10 LOOP --declare절에 선언x  reverse안하고 10..1하면 안돌아감
        DBMS_OUTPUT.PUT_LINE(v_n);
    END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_n);
        

END;
/


DECLARE
    v_sum NUMBER(2,0) := 0;
   
BEGIN
    FOR num IN 1..10 LOOP
        v_sum := v_sum + num;
    END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_sum);
     
END;
/

/* 

1. 다음과 같이 출력되도록 하시오.
* 첫번째줄 * 1개
**     *2개
***    ..
****   ..
*****    *5개
*/ --기본 Loop
DECLARE
    v_star varchar2(6 char) := ''; 
    v_line NUMBER(1,0) := 0;        
BEGIN
    LOOP
            
         v_star := v_star || '*' ;
         DBMS_OUTPUT.PUT_LINE(v_star);
        
         v_line := v_line + 1;
         EXIT WHEN v_line > 4;
         
    END LOOP;
   
END;
/


--while LOOP

DECLARE
    v_star varchar2(6 char) := ''; 
    v_line NUMBER(2,0) := 0;        
BEGIN
    while  v_line <= 4 LOOP --while length(v_star) <=4 Loop 이렇게해도됨(v_line은 빼고)
        
        DBMS_OUTPUT.PUT_LINE(v_star);
         v_star := v_star || '*' ;
         v_line := v_line + 1;
        
           
    END LOOP;
   
END;
/

--for LOOP
DECLARE
    v_star varchar2(6 char) := ''; 
  
BEGIN
    FOR num IN 1..5 LOOP --declare절에 선언x//  reverse안하고 10..1하면 안돌아감 // FOR과  IN 사이에 있는 변수는 readonly(값을 변경할수 없음)
         v_star := v_star || '*' ;
       -- v_line := v_line + 1;      
        DBMS_OUTPUT.PUT_LINE(v_star); -- 최종 결과를 출력하면 END 밑에 적고
        
    END LOOP;
        
END;
/

    --이중반복문 => PUT, PUT_LINE 사용
    
DECLARE
       v_star varchar2(6 char) := ''; 
      
BEGIN
    FOR line IN 1..5 LOOP -- 줄 제어
        FOR star IN 1..line LOOP -- 별 제어
      
         DBMS_OUTPUT.PUT('*');
         
         END LOOP;
         DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
    /
    
    --=================
DECLARE
    v_line number(1,0):= 1;
       v_star number(1,0) := 1; 
      
BEGIN
    LOOP
    v_star :=1;
    LOOP
        DBMS_OUTPUT.PUT('*');
        v_star := v_star +1;
        EXIT WHEN v_star > v_line;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    v_line := v_line +1;
    EXIT WHEN v_line > 5;
 END LOOP;
END;
/
        


