SET SERVEROUTPUT ON


--ġȯ������ ����ϸ� ���ڸ� �Է��ϸ� �ش� ������ ��µǰ� �Ͻÿ�
--��) 2�Է½�
--2*1 = 2
--2*2=4
--......2*9 =18
--�Է� :�� 
--��� : ��*���ϴ¼� = ���( ��*���ϴ¼�)
--���ϴ� �� : 1-9���� ������ => �ݺ������� ����

--�⺻ LOOP
DECLARE
    v_num NUMBER(2,0) := &����;
    v_num2 NUMBER(2,0) := 1;   
    v_res NUMBER(2,0) ;
BEGIN

 DBMS_OUTPUT.PUT_LINE(v_num||'�� ================ ');
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
    v_num NUMBER(2,0) := &����;
    v_num2 NUMBER(2,0) := 1;   
    v_res NUMBER(2,0);
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_num||'�� ================ ');
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
    v_num NUMBER(1,0) := &��;
BEGIN
    FOR v_num2 IN 1..9 LOOP
    
        DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || (v_num * v_num2));
    END LOOP;
END;
/

/*3.������ 2~9�ܱ��� ��µǵ��� �Ͻÿ� ���߹ݺ���*/

--�⺻
DECLARE
    v_num NUMBER := 2;
    v_num2 NUMBER:=0;
    v_res NUMBER := 0;
BEGIN
 
 LOOP
DBMS_OUTPUT.PUT_LINE(v_num ||'��');
    v_num2 := 1;
    LOOP -- ���ϴ� ��
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

-- for���¹��
DECLARE
    v_num NUMBER := 2;
    v_num2 NUMBER;
    v_res NUMBER;
    BEGIN
        FOR v_num IN 2..9 LOOP
        DBMS_OUTPUT.PUT_LINE(v_num ||'��');
        
            FOR v_num2 IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || (v_num * v_num2));
        
            END LOOP;
       
 END LOOP;
 
END;
/

--while ���
DECLARE
    v_dan NUMBER := 2;
    v_num NUMBER := 1;
    v_msg varchar2(1000);
    BEGIN
        WHILE v_num <10 LOOP --Ư���� 1_9���ϴ� loop
            v_dan := 2;
            WHILE v_dan < 10 LOOP --Ư���� 2_9�����ݺ��ϴ� loop��
                v_msg := (v_dan || 'x' || v_num || '=' ||  v_dan*v_num);
                
                 DBMS_OUTPUT.PUT(RPAD(v_msg, 10,' ')); -- rpad(����,����)
                 v_dan := v_dan +1;
        END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
         v_num := v_num+1;
    END LOOP;
 END;
 /


/*4. ������ 1~9�ܱ��� ��µǵ��� �Ͻÿ�(��,Ȧ���� ���) MOD����ϱ�, MOD(������ �ִ� ����, ������ ��) => ������ */

DECLARE
    v_num NUMBER := 0;
    v_num2 NUMBER:=0;
    v_res NUMBER := 0;
BEGIN

 LOOP

    v_num2 := 1;
    DBMS_OUTPUT.PUT_LINE(v_num||'��');
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
--for�����

DECLARE
    v_num NUMBER := 2;
    v_num2 NUMBER:=0;
    v_res NUMBER := 0;
    BEGIN
        FOR v_num IN 1..9 LOOP
        IF MOD(v_num,2) <>0 THEN -- <>: ~�ƴϴ� ��¶� !=�� �ص���
        
         DBMS_OUTPUT.PUT_LINE(v_num||' ��');
            FOR v_num2 IN 1..9 LOOP
            
                DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || (v_num * v_num2));
                END LOOP;
                 DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
    END LOOP;
    
END;
/

--for-continue ���
DECLARE
    v_num NUMBER := 2;
    v_num2 NUMBER:=0;
    v_res NUMBER := 0;
    BEGIN
        FOR v_num IN 1..9 LOOP
            IF MOD(v_num,2) <>0 THEN             -- <>: ~�ƴϴ� ��¶� !=�� �ص���
                continue; -- �ƴ� �͵��� �ɷ����� ���
         END IF;
         DBMS_OUTPUT.PUT_LINE(v_num||' ��');
            FOR v_num2 IN 1..9 LOOP
            
                DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_num2 || '=' || (v_num * v_num2));
                END LOOP;
                 DBMS_OUTPUT.PUT_LINE(' ');
       
    END LOOP;
    
END;
/





-- RECORD
DECLARE
    TYPE info_rec_type IS RECORD -- �̸����� ��Ģ�� ������ rec_type�� ���̴°� ����
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
    WHERE employee_id = &�����ȣ;
            
    DBMS_OUTPUT.PUT_LINE(emp_info_rec.employee_id); 
    DBMS_OUTPUT.PUT_LINE(emp_info_rec.last_name); 
    DBMS_OUTPUT.PUT_LINE(emp_info_rec.job_id); 

    
END;
/

--�����ȣ,�̸�,�μ� �̸��� ����Ҷ�..ROWTYPE�� �� ���̺� �����ϹǷ� ������(�μ��̸�)
--�ǹ������� �̻������� �������� ���� : �ʵ���� ���þ��� ������ Ÿ���� ������ ����
DECLARE
    TYPE emp_rec_type IS RECORD
                ( eid employees.employee_id%TYPE, -- NUMBER
                  ename employees.last_name%TYPE, --VARCHAR2
                  deptname departments.department_name%TYPE); --VARCHAR2 
                  
        emp_rec emp_rec_type;
BEGIN
          SELECT employee_id, last_name, department_name
          INTO emp_rec -- ���������� ������ �����ٰ� �����ϸ� ��
          FROM employees e JOIN departments d
                                            ON (e.department_id = d.department_id)-- USING(department_id)////on ��� using�� ��� �ᵵ�� -> e,d ������
         WHERE employee_id = &���;
                                            
        DBMS_OUTPUT.PUT_LINE(emp_rec.ename); 
        DBMS_OUTPUT.PUT_LINE(emp_rec.eid); 
        DBMS_OUTPUT.PUT_LINE(emp_rec.deptname); 

END;
/

--TABLE

DECLARE
-- 1 ) ����
TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY BINARY_INTEGER;

-- 2 ) ����
num_list num_table_type;


BEGIN
--array[0]      =>   table(0)     // [  ] ��� () 
    num_list(-1000) := 1;
    num_list(1234) := 2;
    num_list(11111) := 3;    

    DBMS_OUTPUT.PUT_LINE(num_list.count);
    DBMS_OUTPUT.PUT_LINE(num_list(1234));
    DBMS_OUTPUT.PUT_LINE(num_list(-1000));
END;
/

DECLARE
-- 1 ) ����
TYPE num_table_type IS TABLE OF NUMBER
        INDEX BY BINARY_INTEGER;

-- 2 ) ����

num_list num_table_type;


BEGIN
    FOR i IN 1..9  LOOP
        num_list(i) := 2*i;
                

    END LOOP;

    FOR  idx IN num_list.FIRST.. num_list.LAST LOOP
        IF num_list.EXISTS(idx) THEN --exists => ������ true
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
    
    
    
    --��ȯ
    FOR  idx IN emp_table.FIRST.. emp_table.LAST LOOP
        IF emp_table.EXISTS(idx) THEN --exists => ������ true
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
--    --��ȯ
--    FOR  idx IN emp_table.FIRST.. emp_table.LAST LOOP
--        IF emp_table.EXISTS(idx) THEN --exists => ������ true
--            DBMS_OUTPUT.PUT(emp_table(idx).employee_id ||' , ');
--            DBMS_OUTPUT.PUT_LINE(emp_table(idx).last_name);
--             
--        END IF;
--    
--    END LOOP;
--    
--END;
--/




--���̺� ����
DECLARE
    v_min employees.employee_id%TYPE; -- �ּ� �����ȣ
    v_MAX employees.employee_id%TYPE; -- �ִ� �����ȣ
    v_result NUMBER(1,0);             -- ����� ���������� Ȯ��
    emp_record employees%ROWTYPE;     -- Employees ���̺��� �� �࿡ ����
    
    TYPE emp_table_type IS TABLE OF emp_record%TYPE
        INDEX BY PLS_INTEGER;
    
    emp_table emp_table_type;
BEGIN
    -- �ּ� �����ȣ, �ִ� �����ȣ
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
        IF emp_table.EXISTS(eid) THEN -- �����Ͱ��ִ��� Ȯ��
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
                        WHERE department_id = &�μ���ȣ;               
                
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
                SELECT employee_id eid, last_name ename, hire_date hdate --��Ī�� ����� �ʵ�� ���� ����
                FROM employees
                WHERE department_id = &�μ���ȣ --60,80�Է�
                ORDER BY hire_date DESC;
            
    emp_rec emp_info_cursor%ROWTYPE;
    
BEGIN

            OPEN emp_info_cursor;
            
            LOOP
                    FETCH emp_info_cursor INTO emp_rec;
                    EXIT WHEN emp_info_cursor%NOTFOUND OR emp_info_cursor%ROWCOUNT > 10;
                  --  EXIT WHEN emp_info_cursor%ROWCOUNT > 10;
                    
                    DBMS_OUTPUT.PUT(emp_info_cursor%ROWCOUNT || ', ' ); --loop�ȿ����� rowcount�� �������� �ִ� 
                    DBMS_OUTPUT.PUT(emp_rec.eid || ', ' );
                    DBMS_OUTPUT.PUT(emp_rec.ename || ', ' );
                    DBMS_OUTPUT.PUT_LINE(emp_rec.hdate);
                    
        END LOOP;
        
        -- Ŀ���� �� ������ ����
        IF emp_info_cursor%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('���� Ŀ���� �����ʹ� �������� �ʽ��ϴ�');
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
--1) ��� ����� �����ȣ, �̸�, �μ��̸� ���
-- �Է� : x
-- ��� : �����ȣ, �̸�, �μ��̸� => ���̺� : employees + departments

DECLARE
                CURSOR emp_cursor IS 
                SELECT employee_id eid, last_name ename, department_name dname      --��Ī�� ����� �ʵ�� ���� ����
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
                  
                    DBMS_OUTPUT.PUT('��� : '|| emp_rec.eid || ', ' );
                    DBMS_OUTPUT.PUT('�̸� : ' ||emp_rec.ename || ', ' );
                    DBMS_OUTPUT.PUT_LINE('�μ�: '||emp_rec.dname);
                    
        END LOOP;
        
        -- Ŀ���� �� ������ ����
        IF emp_cursor%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('���� Ŀ���� �����ʹ� �������� �ʽ��ϴ�');
        END IF;
        
    CLOSE emp_cursor;
END;
/

--2) �μ���ȣ�� 50�̰ų� 80�� ������� ����̸�, �޿�, ���� ��� --(�޿�*12+(NVL(�޿�,0)*NVL(Ŀ�̼�,0)*12))

DECLARE
                CURSOR emp_cursor IS 
                SELECT last_name lname, salary sal, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual , department_id did, employee_id eid --������ ��Ī�ʿ�
                FROM employees 
                WHERE department_id IN(50,80) -- or�� ���� ���
                ORDER BY employee_id asc;
            
    emp_rec emp_cursor%ROWTYPE;
    
BEGIN
        IF NOT emp_cursor%ISOPEN THEN           --open�����ʾ����� open�ǰ� �ϰ�..open���¸� �ٷ� ������ ���� ����
                OPEN emp_cursor;
        END IF;
        
            LOOP
                    FETCH emp_cursor INTO emp_rec;
                    EXIT WHEN emp_cursor%NOTFOUND ;
                    
                    
                  
                    DBMS_OUTPUT.PUT('�μ���ȣ:  '||emp_rec.did);
                    DBMS_OUTPUT.PUT(' ��� :  '|| emp_rec.eid || ', ' );
                    DBMS_OUTPUT.PUT('����̸� : '|| emp_rec.lname || ', ' );
                    DBMS_OUTPUT.PUT('�޿� : ' ||emp_rec.sal || ', ' );
                    DBMS_OUTPUT.PUT_LINE('����: '||emp_rec.annual);
                    
                    
                    
        END LOOP;
        
        -- Ŀ���� �� ������ ����
        IF emp_cursor%ROWCOUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('���� Ŀ���� �����ʹ� �������� �ʽ��ϴ�');
        END IF;
        
    CLOSE emp_cursor;
END;
/

--2��° ���
--LOOP �ȿ� v_annual := nvl (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)); �� ����ִ� ��ĵ� �ִ�( �� ���� ���)

DECLARE

v_sal employees.salary%TYPE;
v_comm employees.commission_pct%TYPE;
v_annual v_sal%TYPE;
v_ename employees.last_name%TYPE;

CURSOR emp_cursor IS 
                SELECT salary sal, (salary*12+(NVL(salary,0)*NVL(commission_pct,0)*12)) as annual, last_name ename --������ ��Ī�ʿ�
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
                DBMS_OUTPUT.PUT_LINE('���� Ŀ���� �����ʹ� �������� �ʽ��ϴ�');
            END IF;
     CLOSE emp_cursor;
     
     END;
     /
     
    