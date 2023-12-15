SET SERVEROUTPUT ON


---2)
DECLARE
v_eid employees.employee_id%TYPE := &사번;
v_dname departments.department_name%TYPE;
v_job employees.job_id%TYPE;
v_salary employees.salary%TYPE;
v_annual employees.salary%TYPE;

BEGIN

SELECT d.department_name, e.job_id,e.salary, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual
INTO v_dname,v_job,v_salary,v_annual
FROM employees e 
JOIN departments d ON e.department_id =  d.department_id
WHERE employee_id = v_eid;

DBMS_OUTPUT.PUT_LINE('부서이름 : '  || v_dname);
DBMS_OUTPUT.PUT_LINE('job_id : '  || v_job);
    DBMS_OUTPUT.PUT_LINE('사원월급 : '  || v_salary);
    DBMS_OUTPUT.PUT_LINE('연봉 : '  || v_annual);


END;
/


--3)


DECLARE
v_year char(4 char);
BEGIN
    SELECT TO_CHAR(hire_date,'yyyy')
    into v_year
    FROM employees
    WHERE employee_id = &사번;
    
        IF v_year >= '2016' THEN
          DBMS_OUTPUT.PUT_LINE('New employee');
          ELSE
          DBMS_OUTPUT.PUT_LINE('Career employee');

    END IF;


END;
/
select * from employees;

--4)



DECLARE
    v_num NUMBER := 2;
    v_num2 NUMBER:=0;
    v_res NUMBER := 0;
    BEGIN
        FOR v_num IN 1..9 LOOP
        IF MOD(v_num,2) <>0 THEN 
        
         DBMS_OUTPUT.PUT_LINE(v_num||' 단');
            FOR v_num2 IN 1..9 LOOP
            
                DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || (v_num * v_num2));
                END LOOP;
                 DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
    
END;
/

--5)


DECLARE
        CURSOR emp_info_cursor IS
         SELECT employee_id eid, last_name ename, salary esal
                FROM employees 
                     WHERE department_id = &부서번호;
                     
                     emp_rec emp_info_cursor%ROWTYPE;
                
        
BEGIN
        OPEN emp_info_cursor;
        
        LOOP
                FETCH emp_info_cursor INTO emp_rec;
                EXIT WHEN emp_info_cursor%NOTFOUND ;
                
                  
                    DBMS_OUTPUT.PUT('사번 :'||emp_rec.eid || ', ' );
                    DBMS_OUTPUT.PUT('이름 :'||emp_rec.ename || ', ' );
                    DBMS_OUTPUT.PUT_LINE('급여 : '||emp_rec.esal);
        END LOOP;
        
        IF emp_info_cursor%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('현재 부서의 데이터는 존재하지 않습니다');
        END IF;
        
        CLOSE emp_info_cursor;
        
END;
/

--6)

CREATE OR REPLACE PROCEDURE y_update(p_eid IN employees.employee_id%TYPE,p_sal2 In employees.salary%TYPE)
IS
    v_salary employees.salary%TYPE;

    origin_sal employees.salary%TYPE;
    after_sal employees.salary%TYPE;
BEGIN
   
   SELECT salary
   INTO origin_sal
   FROM employees
   WHERE employee_id = p_eid;
   
     DBMS_OUTPUT.PUT_LINE('기존sal : '||origin_sal);
     
  
    UPDATE employees
    SET salary = salary + (salary*p_sal2/100)
    WHERE employee_id = p_eid;

    IF SQL%ROWCOUNT =0 THEN
                   RAISE NO_DATA_FOUND;
                 
            END IF;
            
            
SELECT salary
   INTO after_sal
   FROM employees
   WHERE employee_id = p_eid;
            
DBMS_OUTPUT.PUT_LINE('새로운 sal : '||after_sal);


 EXCEPTION                   
            WHEN NO_DATA_FOUND THEN
                     DBMS_OUTPUT.PUT_LINE('No search employee!!');
END;
/
exec y_update(180,20);
select * from test_employee where employee_id = 120;

--7)


  CREATE OR REPLACE PROCEDURE ju_min
    (p_ssn IN VARCHAR2) 
IS

    v_gender  CHAR(1);
    --v_age number;
     v_birth VARCHAR2(11 char);
    
    BEGIN

            --추가
             v_gender := SUBSTR(p_ssn,7,1) ;
             
             IF v_gender IN ('1', '3') THEN
                    DBMS_OUTPUT.PUT_LINE('성별은 남자입니다');
                    
        
                                        
             ELSIF v_gender IN ('2', '4') THEN
                    DBMS_OUTPUT.PUT_LINE('성별은 여자입니다');
             
             END IF;
             
                  IF v_gender IN ('3', '4') THEN
                       v_birth := TO_DATE('20'||SUBSTR(p_ssn,1,6), 'yyyymmdd');

                        DBMS_OUTPUT.PUT_LINE('나이 :' || FLOOR(MONTHS_BETWEEN(sysdate,v_birth) /12));

                          ELSIF v_gender IN ('1','2') THEN
                            v_birth := TO_DATE('19'||SUBSTR(p_ssn,1,6), 'yyyymmdd');
                             END IF;
        
            
    END;
    /
    
    EXECUTE ju_min('0211023234567');
    
    --8)
    CREATE OR REPLACE FUNCTION hire(p_emp IN NUMBER)
    
    RETURN NUMBER
    IS

v_hdate NUMBER;

BEGIN

    SELECT TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12)
    INTO v_hdate
    FROM employees
    WHERE employee_id =  p_emp;
    
    RETURN  v_hdate;
    

END;
/
EXECUTE DBMS_OUTPUT.PUT_LINE('근무 년수 :' ||hire(105)||' 년');




--9)


CREATE OR REPLACE FUNCTION y_dept
(p_deptname departments.department_name%TYPE)


RETURN employees.last_name%TYPE

IS
v_man employees.last_name%TYPE;
 e_no_dept EXCEPTION;
 v_err number;
BEGIN

    SELECT COUNT(*)
    INTO v_err
    FROM departments
    WHERE department_name = p_deptname;

    IF v_err = 0 THEN
    RAISE e_no_dept;
    END IF;


SELECT last_name
INTO v_man
FROM employees 
WHERE employee_id = (SELECT manager_id
                                                            FROM departments
                                                            WHERE department_name = p_deptname);

RETURN v_man;


EXCEPTION


WHEN e_no_dept THEN
        RETURN '해당 부서가 X.';
        
    WHEN NO_DATA_FOUND THEN
        RETURN '해당 부서의 책임자가 존재하지 않습니다.';

END;
/
EXECUTE DBMS_OUTPUT.PUT_LINE(y_dept('IT'));


--10)

SELECT *
FROM user_source
WHERE type IN('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY');

--11)

DECLARE
        v_line varchar2(100)  :='-';
       --v_star varchar2(100) := ''; 
      
BEGIN
    FOR line IN REVERSE 1..9  LOOP  -- 줄 제어
    
        FOR star IN 1..(line-1) LOOP -- 별 제어
            v_line := v_line || '-';
         END LOOP;

         v_line := RPAD(v_line,10,'*');
          DBMS_OUTPUT.PUT_LINE(v_line);
            v_line := '-';
    END LOOP;
END;
    /
    







