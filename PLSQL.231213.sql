SET SERVEROUTPUT ON
-- Ŀ�� FOR ����

DECLARE
        CURSOR emp_cursor IS
                    SELECT employee_id, last_name, job_id
                    FROM employees
                    WHERE department_id = &�μ���ȣ;
            
BEGIN

        FOR emp_rec IN emp_cursor LOOP
                DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT); --����� ������ // �̰� end loop �ؿ� ������ ������
                DBMS_OUTPUT.PUT(', ' || emp_rec.employee_id);
                DBMS_OUTPUT.PUT(', ' || emp_rec.last_name);
                DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.job_id);
                
        END LOOP; -- LOOP�� �����鼭 Ŀ���� ����ȴٴ� �ǹ̵� �ִ�..
    --DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT); --����� ������

END;
/

BEGIN
        FOR emp_rec IN (SELECT employee_id, last_name
                                        FROM employees
                                        WHERE department_id = &�μ���ȣ ) LOOP
                
                DBMS_OUTPUT.PUT(', ' || emp_rec.employee_id);
                DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.last_name);
        
        END LOOP;
        
END;
/

--1) ��� ����� �����ȣ, �̸�, �μ��̸� ���

--���1
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


--2) �μ���ȣ�� 50�̰ų� 80�� ������� ����̸�,�޿�,���� ���
--(�޿�*12+(NVL(�޿�,0)*NVL(Ŀ�̼�,0)*12))


----���1
--DECLARE
--CURSOR emp_cursor IS
--SELECT last_name lname, salary sal, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual , department_id did, employee_id eid --������ ��Ī�ʿ�
--                FROM employees 
--                WHERE department_id IN(50,80) -- or�� ���� ���
--                ORDER BY employee_id asc
--                
--BEGIN
--FOR emp_rec In emp_cursor LOOP
--   DBMS_OUTPUT.PUT('�μ���ȣ:  '||emp_rec.did);
--                    DBMS_OUTPUT.PUT(' ��� :  '|| emp_rec.eid || ', ' );
--                    DBMS_OUTPUT.PUT('����̸� : '|| emp_rec.lname || ', ' );
--                    DBMS_OUTPUT.PUT('�޿� : ' ||emp_rec.sal || ', ' );
--                    DBMS_OUTPUT.PUT_LINE('����: '||emp_rec.annual);
--                    END LOOP;
--
--END;
--/




DECLARE


BEGIN
FOR emp_rec IN(  SELECT last_name lname, salary sal, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual , department_id did, employee_id eid 
                FROM employees 
                WHERE department_id IN(50,80) -- or�� ���� ���
                ORDER BY employee_id asc) LOOP
                
                DBMS_OUTPUT.PUT('�μ���ȣ:  '||emp_rec.did);
                    DBMS_OUTPUT.PUT(' ��� :  '|| emp_rec.eid || ', ' );
                    DBMS_OUTPUT.PUT('����̸� : '|| emp_rec.lname || ', ' );
                    DBMS_OUTPUT.PUT('�޿� : ' ||emp_rec.sal || ', ' );
                    DBMS_OUTPUT.PUT_LINE('����: '||emp_rec.annual);
                    
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

-- ���� �����ϴ� ��� �μ��� �� �Ҽӻ���� ����ϰ�, ���� ��� ���� �Ҽӻ���� ���ٰ� ����ϱ� Ŀ��2�� ����ؾ� �� �������� 2��
-- format 
/*=======�μ��� : �μ� Ǯ ����
1.�����ȣ, ����̸�, �Ի���, ����
2.�����ȣ, ����̸�, �Ի���, ����
.
.
Ŀ���� ������ �ϴ� �ݺ���?
SELECT department_id, department_name
from departments; --��� �μ��� ������ where��x

--2���� ������
SELECT last_name, hire_date,job_id
from employees
WHERE department_id = &department_id;

�ϳ��� �Ϲ�Ŀ��,�ϳ��� �Ű����� ���� Ŀ��
*/
DECLARE
        CURSOR dept_cursor IS
                    SELECT department_id, department_name
                    from departments; --��� �μ��� ������ where��x

--2���� ������

        CURSOR emp_cursor(p_deptno NUMBER) IS
                SELECT employee_id, last_name, hire_date, job_id
                from employees
                WHERE department_id = p_deptno;
                
        emp_rec emp_cursor%ROWTYPE;
BEGIN
       FOR dept_rec IN dept_cursor LOOP
       DBMS_OUTPUT.PUT_LINE('=========�μ���' || dept_rec.department_name);
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
                   DBMS_OUTPUT.PUT_LINE('���� �Ҽӻ���� �����ϴ�.');
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
--Ư���μ������ѻ������ �μ���Ŀ�̼� employee_id��� pk���������������� update�����ϴ�
--commission�� null�� ������� ���� 10% �����
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
            WHERE CURRENT OF sal_info_cursor;  --����� Ŀ������ �������� ����
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
        
        
        ---���� ó��
        --1) �̹� ���ǵǾ� �ְ� �̸��� �����ϴ� ���ܻ����� ���
        DECLARE
            v_ename employees.last_name%TYPE;
        BEGIN
            SELECT last_name
            INTO v_ename
            FROM employees
            WHERE department_id = &�μ���ȣ;
            
            DBMS_OUTPUT.PUT_LINE(v_ename);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
                DBMS_OUTPUT.PUT_LINE('�ش� �μ��� ���� ����� �����ϴ�.');
                
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('�ش� �μ����� �������� ����� �����մϴ�.');
                DBMS_OUTPUT.PUT_LINE('����ó�� ��');
        END;
        /
        
        -- 2) �̹� ���Ǵ� �Ǿ������� ������ �̸��� �������� �ʴ� ���ܻ���
        DECLARE
                e_emps_remaining EXCEPTION;
                PRAGMA EXCEPTION_INIT(e_emps_remaining, -02292);
                
                
        BEGIN
                DELETE FROM departments
                WHERE department_id = &�μ���ȣ;
        EXCEPTION
                WHEN e_emps_remaining THEN
                        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� ���� ����� �����մϴ�.');
        END;
        /
        
    --3) ����� ���� ���� ����(-10000�� ��)
    
    DECLARE
        e_no_deptno EXCEPTION;
        v_ex_code NUMBER;
        v_ex_msg VARCHAR2(1000);
    BEGIN
            DELETE FROM departments
            WHERE department_id = &�μ���ȣ;
            
            IF SQL%ROWCOUNT =0 THEN
                   RAISE e_no_deptno;
                    --DBMS_OUTPUT.PUT_LINE('�ش� �μ���ȣ�� �������� �ʽ��ϴ�.');
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('�ش� �μ���ȣ�� �����Ǿ����ϴ�.');
    EXCEPTION
            WHEN e_no_deptno THEN
                    DBMS_OUTPUT.PUT_LINE('�ش� �μ���ȣ�� �������� �ʽ��ϴ�.');
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
            
    -- test_employee ���̺��� ����Ͽ� Ư�� ����� �����ϴ� PL/SQL �ۼ�
    --�Է�ó���� ġȯ���� ���
    --�ش� ����� ���� ��츦 Ȯ���ؼ� '�ش� ����� �������� �ʽ��ϴ�'�� ����ϼ���
    
DECLARE
      e_no_emp EXCEPTION;
      v_eid employees.employee_id%TYPE := &�����ȣ;
      
BEGIN
    DELETE FROM test_employee
    WHERE employee_id = v_eid;
    
    
    
      IF SQL%ROWCOUNT =0 THEN
                   RAISE e_no_emp;
               
            END IF;
                     DBMS_OUTPUT.PUT(v_eid || ',');
                    DBMS_OUTPUT.PUT_LINE( '�����Ǿ����ϴ�.');
            
            
        EXCEPTION
            
         WHEN e_no_emp THEN 
                DBMS_OUTPUT.PUT('�Է��� : '|| v_eid || ', ');
                DBMS_OUTPUT.PUT_LINE('���� ���̺��� �������� �ʽ��ϴ�');           
    
    
 END;
    /
    
    
    --PROCEDURE
    
    CREATE OR REPLACE PROCEDURE test_pro
    -- ()
    IS
    --IS �� BEGIN ���̰� DECLARE:����� �� ������ ��..DECLARE�� ������
    --��������, ���ڵ�,Ŀ��,EXCEPTION 
    
    
    BEGIN
        DBMS_OUTPUT.PUT_LINE('First Procedur');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('����ó��');
    
    END;
    /
    --1)��� ���ο��� ȣ���ϴ¤� ���
    BEGIN
            test_pro;      
    END;
    /
    --2) execute ��ɾ� ���(������ �׽�Ʈ��)
    EXECUTE test_pro;
    
    --3)create�� ����� drop���θ� ��������
    DROP PROCEDURE test_pro;
    
    -- IN OUT IN OUT
    
    --IN�� ���� �ް� ���ο��� �Ͼ�� �����ǰ���� OUT�� ��Ƽ�������
    
    --IN => raise_salary �� ���� p_eid�� readonly�� ���� ������ ������
    
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
        v_id employees.employee_id%TYPE := &�����ȣ;
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
        DBMS_OUTPUT.PUT_LINE('after ' || v_result);              --result ���� ����� => OUT����� ���� ����� �� �ϳ��� ������ null��..  --IN�� ���� �ް� ���ο��� �Ͼ�� �����ǰ���� OUT�� ��Ƽ�������
    END;
    /
    
    --IN OUT /in��out�� �ϳ��� ���� ó���ϰ��� ����//���� ����뵵�� ���̾� 
    --01012341234 => 010-1234-1324
    CREATE PROCEDURE format_phone
    (p_phone_no IN OUT VARCHAR2) -- 010���� �տ� 0���־ varchar��..�Ű������϶� ũ�� ���� ����
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
    1.�ֹι�ȣ �Է��ϸ� ����ó�� ��µǵ��� yedam_ju ���ν��� �ۼ�
    EXECUTE yedam_ju('9501011667777')  => ���ڷ� �ϸ�ȵ�(2000������ 00�� ���ư�)
    EXECUTE yedam_ju('1511013689977')
    
    ->950101-1******

    �߰�) �ش� �ֹε�Ϲ�ȣ�� �������� �ؼ� ���� ������� ����ϴ� �κ� �߰�
    //rr���� �ȵ� 1949����� 2049������� �ν��� => 1,2,3,4�� ���� �����ϴ°� Ȱ���ؼ� 20,21c ����
    9501011667777 => 1995�� 10�� 11��
    1511013689977 => 2015�� 11�� 01��

    
    */
    

    CREATE OR REPLACE PROCEDURE yedam_ju
    (p_ssn IN VARCHAR2) -- 010���� �տ� 0���־ varchar��..�Ű������϶� ũ�� ���� ����
IS
    v_result VARCHAR2(100);
 v_gender  CHAR(1);
    v_birth VARCHAR2(11 char);
    
    BEGIN
    
         -- v_result := SUBSTR(p_ssn,1,6) ||'-'|| SUBSTR(p_ssn,7,1)||'******'; �̷����ص��ǰ�
                                      
            v_result := SUBSTR(p_ssn,1,6) ||'-'|| RPAD(SUBSTR(p_ssn,7,1),7,'*');
            DBMS_OUTPUT.PUT_LINE(v_result);
            
            --�߰�
             v_gender := SUBSTR(p_ssn,7,1) ;
             
             IF v_gender IN ('1', '2','5','6') THEN
                    v_birth := '19'||SUBSTR(p_ssn,1,2)||'��'
                                        ||SUBSTR(p_ssn,3,2)||'��'
                                        ||SUBSTR(p_ssn,5,2)||'��';
                                        
             ELSIF v_gender IN ('3', '4','7','8') THEN
                v_birth := '20'||SUBSTR(p_ssn,1)
                                        
             
             END IF;
             DBMS_OUTPUT.PUT_LINE(v_birth);
            
    END;
    /
    
    EXECUTE yedam_ju('0011013689977');

/*
2.
�����ȣ�� �Է��� ���
�����ϴ� TEST_PRO ���ν����� �����Ͻÿ�.

��, �ش����� ���� ��� "�ش����� �����ϴ�." ���

��) EXECUTE TEST_PRO(176)

�Է� : �����ȣ, ��� : X    => IN��� �Ű����� ���
���� : �Է¹��� �����ȣ ����  => DELETE, employees 
�������� �ʿ�x delete���ҰŶ�


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
              
                   -- DBMS_OUTPUT.PUT_LINE('�ش� ����� �����ϴ�');
               RAISE e_no_emp;
            END IF;
            
             EXCEPTION
                WHEN e_no_emp THEN
                        DBMS_OUTPUT.PUT_LINE('�ش� ����� �����ϴ�');
         
    END;
    /
EXECUTE TEST_PRO(145);
select * from test_employee where employee_id = 145;



/*
3.
������ ���� PL/SQL ����� ������ ��� 
�����ȣ�� �Է��� ��� ����� �̸�(last_name)�� ù��° ���ڸ� �����ϰ��
'*'�� ��µǵ��� yedam_emp ���ν����� �����Ͻÿ�.

����) EXECUTE yedam_emp(176)
������) TAYLOR -> T*****  <- �̸� ũ�⸸ŭ ��ǥ(*) ���

�Է� : �����ȣ -> IN

���� 1)select,����̸�

2)�ش� �̸��� ���� ���� : substr, length, RPAD ���
2)���

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
    -- �Է¹��� �����ȣ�� �ش��ϴ� ����� last_name�� ��ȸ
    SELECT last_name INTO v_last_name
    FROM employees
    WHERE employee_id = p_eid;

    -- last_name�� NULL�� �ƴϸ� ���
    IF v_last_name IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE(v_last_name || ' -> ' || SUBSTR(v_last_name, 1, 1) || RPAD('*', LENGTH(v_last_name) - 1, '*'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('�ش� ����� �����ϴ�');
    END IF;
END yedam_emp;
/
EXECUTE yedam_emp(111);







/*

4.
�������� ���, �޿� ����ġ�� �Է��ϸ� Employees���̺� ���� ����� �޿��� ������ �� �ִ� y_update ���ν����� �ۼ��ϼ���. 
���� �Է��� ����� ���� ��쿡�� ��No search employee!!����� �޽����� ����ϼ���.(����ó��)
����) EXECUTE y_update(200, 10)

�Է� : ���,�޿�����ġ(����)
���� : ����� �޿��� ���� => �޿� ����ġ(����)
            UPDATE employees
            SET salary = salary + (salary*����ġ/100)  => ������ �Է¹޴°� ����������, 
            �Ǽ��� �����Ѵٸ� SET salary = salary+(salary*����ġ);
            WHERE employee_id = �Է¹޴»��;
            
            


++���� ����->�λ���޵� ����غ�
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
   
     DBMS_OUTPUT.PUT_LINE('����sal : '||origin_sal);
     
  
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
������ ���� ���̺��� �����Ͻÿ�.
create table yedam01
(y_id number(10),
 y_name varchar2(20));

create table yedam02
(y_id number(10),
 y_name varchar2(20));
5-1.
�μ���ȣ�� �Է��ϸ� ����� �߿��� �Ի�⵵�� 2005�� ���� �Ի��� ����� yedam01 ���̺� �Է��ϰ�,
�Ի�⵵�� 2005��(����) ���� �Ի��� ����� yedam02 ���̺� �Է��ϴ� y_proc ���ν����� �����Ͻÿ�.
 
 �Է� : �μ���ȣ
 ���� : �ش� ��� -> �ռ� ���� ���̺� INSERT
            1) SELECT => CURSOR 
            2) IF��, �Ի���(�Ի�⵵)
            2-1) �Ի�⵵ < 2005�� yedam01���̺� insert
            �Ի�⵵ >= 2005 yedam02���̺� insert
 
5-2. => ����� ���� ���� �ʿ�
1. ��, �μ���ȣ�� ���� ��� "�ش�μ��� �����ϴ�" ����ó�� => cursor�� �� ��ȯ�������� rowcount�� ������
2. ��, �ش��ϴ� �μ��� ����� ���� ��� "�ش�μ��� ����� �����ϴ�" ����ó�� => NO_DATA_FOUND ���


*/

CREATE OR REPLACE PROCEDURE y_proc(p_deptno IN departments.department_id%TYPE)
IS
        CURSOR emp_cursor IS
                SELECT employee_id, last_name, hire_date -- => yedam01,02,���̺��� Į���� id�� name�̴�
                FROM employees
                WHERE department_id = p_deptno;
                
                emp_rec emp_cursor%ROWTYPE; --������ ������ ���� : cursor for loop����ϱ� �����ʾƼ�
               
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
                --IF hire_date < TO_DATE('05-01-01', 'yy-MM-dd')THEN -- to_date�� 2��° �Ķ���ʹ� � �������� ó���Ұ���
                --2)���� �� �Ϻκи� ���Ҷ� to_char�� ����
                IF TO_CHAR(emp_rec.hire_date, 'yyyy')<'2005' THEN
                    --2005�� �����̹Ƿ� 01�� ����
                    INSERT INTO yedam01
                    VALUES (emp_rec.employee_id, emp_rec.last_name);
                ELSE
                --02�� ����
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
        DBMS_OUTPUT.PUT_LINE('�ش� �μ����� ����� �����ϴ�.');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �����ϴ�.');


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
--    -- �޿��� ������ų ����� ���� �޿� ��ȸ
--    SELECT salary + p_salary_increase
--    INTO v_new_salary
--    FROM employees
--    WHERE employee_id = p_employee_id;
--
--    -- ����� �����ϸ� �޿��� ����
--    IF SQL%FOUND THEN
--        UPDATE employees
--        SET salary = v_new_salary
--        WHERE employee_id = p_employee_id;
--
--        DBMS_OUTPUT.PUT_LINE('�����ȣ ' || p_employee_id || '�� �޿��� ���ŵǾ����ϴ�.');
--    ELSE
--        -- �ش� ����� ���� ��� ���� ó��
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