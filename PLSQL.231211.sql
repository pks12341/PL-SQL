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
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('���� : ' || v_job);
          
END;
/

DECLARE
    v_eid employees.employee_id%TYPE := &�����ȣ;
    v_ename employees.last_name%TYPE;
--ġȯ ����(�������Ҷ� ����)
BEGIN
    SELECT first_name || ', ' || last_name
    INTO v_ename
    FROM employees
    WHERE employee_id = v_eid;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || v_eid);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);

END;
/

-- 1) Ư�� ����� �Ŵ����� �ش��ϴ� ����� ��ȣ�� ���(Ư������� ġȯ������ �̿��� �Է¹�����ȴ�)

DECLARE
v_eid employees.employee_id%TYPE := &�����ȣ;
v_mgr employees.manager_id%TYPE;

BEGIN
    SELECT manager_id
    INTO v_mgr
    FROM employees
    WHERE employee_id=v_eid;
    
  DBMS_OUTPUT.PUT_LINE('��� ��ȣ : ' || v_mgr);
  
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
    WHERE employee_id = &�����ȣ;
    
    INSERT INTO employees(employee_id, last_name, email, hire_date,job_id, department_id)
    VALUES (1000, 'Hong','hkd@google.com',sysdate,'IT_PROG',v_deptno);
    
    DBMS_OUTPUT.PUT_LINE('��� ��� : ' || SQL%ROWCOUNT);
    
    UPDATE employees
    SET salary = (NVL(salary,0) + 10000) * v_comm
    WHERE employee_id = 1000;
    
    DBMS_OUTPUT.PUT_LINE('���� ��� : ' || SQL%ROWCOUNT);
    
end;
/

rollback;

SELECT * FROM employees WHERE employee_id = 1000;
--ó�� 1000�� ������ salary��  null�̾ ������Ʈ �ϰ����� null�̰� ������Ʈ�� ���������� �� NVL�־��൵��

BEGIN
    DELETE FROM employees
    WHERE employee_id = &�����ȣ;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('�ش� ����� �������� �ʽ��ϴ�.');
    END IF;
END;
/

/*1.�����ȣ�� �Է��Ұ�� �����ȣ, ����̸�, �μ��̸��� ����ϴ� pl.sql �ۼ�. �����ȣ�� ġȯ������ ���� �Է¹ޱ�*/

declare
    v_id employees.employee_id%TYPE;
    v_name employees.last_name%TYPE;
    --v_dept_id employees.department_id%TYPE; select�� 2������..
    v_dept_name departments.department_name%TYPE;

begin
    SELECT e.employee_id, e.last_name, d.department_name
     into v_id,v_name,v_dept_name
    FROM employees e 
    join departments d ON e.department_id = d.department_id
    WHERE employee_id = &�����ȣ;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : '  || v_id);
    DBMS_OUTPUT.PUT_LINE('����̸� : '  || v_name);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� : '  || v_dept_name);
    
    
    --���2
    select employee_id, last_name, department_id
    into v_id,v_name,v_deptid
    from employees
    where employee_id = &�����ȣ;
    
    select department_name
    into v_deptname
    from departments
    where department_id = v_deptid;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ : '  || v_id);
    DBMS_OUTPUT.PUT_LINE('����̸� : '  || v_name);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� : '  || v_dept_name);

end;
/

select * from employees
where employee_id = 105;
/*2.�����ȣ�� �Է��� ��� ����̸�, �޿�, ������ ����ϴ� pl/sql �ۼ� . �����ȣ�� ġȯ������ ����ϰ�

������ �Ʒ��� ������ ������� �����Ͻÿ�(�޿�*12+(NVL(�޿�,0)*NVL(Ŀ�̼�,0)*12)) */

declare
v_name employees.last_name%TYPE;
v_salary employees.salary%TYPE;
--v_yb NUMBER;
v_yb v_salary%TYPE; --���� �ص� ��


begin

    SELECT last_name, salary, (salary*12+(NVL(salary,0)*NVL(COMMISSION_PCT,0)*12))
    into v_name,v_salary,v_yb
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    DBMS_OUTPUT.PUT_LINE('����̸� : '  || v_name);
    DBMS_OUTPUT.PUT_LINE('������� : '  || v_salary);
    DBMS_OUTPUT.PUT_LINE('���� : '  || v_yb);

end;
/

--��� 2 =>deaclare�� (v_comm)  �߰��ؾ���..������� select������ �� �� �ʿ�¾���
begin

    SELECT last_name, salary,commission_pct
    into v_name,v_salary,v_comm
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    v_yb := v_salary *12 + NVL(v_salary,0) * NVL(v_comm, 0) *12;
    
    DBMS_OUTPUT.PUT_LINE('����̸� : '  || v_name);
    DBMS_OUTPUT.PUT_LINE('������� : '  || v_salary);
    DBMS_OUTPUT.PUT_LINE('���� : '  || v_yb);

END;
/

-- �⺻IF��

BEGIN
    DELETE FROM employees
    WHERE employee_id = &�����ȣ;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('���������� ������� �ʾҽ��ϴ�.');
        DBMS_OUTPUT.PUT_LINE('�ش� ����� �������� �ʽ��ϴ�.');
    END IF;
    
    
END;
/
select * from employees
where employee_Id = 108;

--IF ~ ELSE �� : ���� ����
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(employee_id) --COUNT : ���̺��� ������� ����� ����(0or1)�� �� �ִ� ������ �Լ�.. �ٸ��� null��
    INTO v_count
    FROM employees
    WHERE manager_id = &eid;
    
    IF v_count = 0 then
        DBMS_OUTPUT.PUT_LINE('�Ϲ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
    END IF;
END;
/

--IF ~ ELSIF ~ ELSE �� :����

DECLARE
v_hdate NUMBER;

BEGIN

    SELECT TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12)
    INTO v_hdate
    FROM employees
    WHERE employee_id =  &�����ȣ;
    
    IF v_hdate < 5 THEN --�Ի� 5�� �̸�
        DBMS_OUTPUT.PUT_LINE('�Ի����� 5�� �̸��Դϴ�.');
    ELSIF v_hdate < 10 THEN -- �Ի����� 5���̻�-10��̸� 
        DBMS_OUTPUT.PUT_LINE('�Ի����� 10�� �̸��Դϴ�.');
    ELSIF v_hdate < 15 THEN -- �Ի����� 10���̻�-15��̸� 
        DBMS_OUTPUT.PUT_LINE('�Ի����� 15�� �̸��Դϴ�.');
    ELSIF v_hdate < 20 THEN -- �Ի����� 15���̻�-20��̸� 
        DBMS_OUTPUT.PUT_LINE('�Ի����� 20�� �̸��Դϴ�.');
    ELSE -- �Ի����� 20���̻�-25��̸�  
        DBMS_OUTPUT.PUT_LINE('�Ի����� 25�� �̸��Դϴ�.');
    END IF;
END;
/

SELECT employee_id, TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12),
                            TRUNC((sysdate-hire_date)/365)
from employees
order by 2 desc;


-- 3. �����ȣ�� �Է�(ġȯ�������)�� ��� �Ի����� 2005�� ����(2005����) �̸� new employee ���
--2005 �����̸� Career employee ���
-- rr yy ���� �˱�
--�Է� : �����ȣ ,��� : �Ի��� 
--���ǹ� (if��) -> �Ի��� >= 2005�� new employee
--elsif career employee���
-- 


-- 1) ��¥ �״�� ��
DECLARE
v_hdate date;

BEGIN
SELECT hire_date
INTO v_hdate
from employees
where employee_id = &�����ȣ;

      IF v_hdate >= to_date('2005-01-01','yyyy-MM-dd')   THEN
        DBMS_OUTPUT.PUT_LINE('New employee');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Career employee');
END if;
END;
/
-- 2) ������ �� to_char�� ����..nn�� ��ݱ� �Ի��ڵ��� �̰ų� �Ҷ� ����Ҽ� �ִ�(7�� ����)
SELECT TO_CHAR(hire_date,'yyyy')
FROM employees;

DECLARE
v_year char(4 char);
BEGIN
    SELECT TO_CHAR(hire_date,'yyyy')
    into v_year
    FROM employees
    WHERE employee_id = &���;
    
        IF v_year >= '2005' THEN
          DBMS_OUTPUT.PUT_LINE('New employee');
          ELSE
          DBMS_OUTPUT.PUT_LINE('Career employee');

    END IF;


END;
/

-- 3-2 �����ȣ�� �Է�(ġȯ�������)�� ��� �Ի����� 2005�� ����(2005����) �̸� new employee ���
--2005 �����̸� Career employee ���
-- rr yy ���� �˱�
--�Է� : �����ȣ ,��� : �Ի��� 
--���ǹ� (if��) -> �Ի��� >= 2005�� new employee
--elsif career employee���
-- �� DBMS_OUTPUT.PUT_LINE()�� �ڵ� �� �ѹ��� �ۼ��Ѵ�.

DECLARE
v_year char(4 char);
v_str varchar2(1000) := 'Career employee';

BEGIN
    SELECT TO_CHAR(hire_date,'yyyy')
    into v_year
    FROM employees
    WHERE employee_id = &���;
    
--          IF v_year >= '2005' THEN
--          v_str := 'new employee';
--          ELSE
--          v_str := 'career employee';
--     
--     
--    END IF;
--    DBMS_OUTPUT.PUT_LINE(v_str);

--�̷��Ե� ���ϼ��ִ� declare�� �⺻������ carre employee�� �ָ�..
    IF v_year >= '2005' THEN
          v_str := 'new employee';
          END IF;
          DBMS_OUTPUT.PUT_LINE(v_str);

END;
/

--4 �޿��� 5000�����̸� 20% �λ�� �޿�
--�޿��� 10000 �����̸� 15% �λ�� �޿�
--�޿��� 15000�����̸� 10%�λ�� �޿�
--�޿��� 15001 �̻��̸� �޿��λ�X

--�����ȣ�� �Է�(ġȯ����)�ϸ� ����̸�,�޿�,�λ�� �޿��� ��µǵ��� pl/sql�ۼ�
--�Է� : ��� ��� : ����̸�,�޿�
DECLARE
v_ename employees.last_name%TYPE;
v_salary employees.salary%TYPE;
v_nsalary NUMBER := 0;

BEGIN
SELECT last_name, salary
into v_ename,v_salary
FROM employees
WHERE employee_id = &���;

IF v_salary<=5000 THEN
    v_nsalary := 20;
ELSIF v_salary<=10000 THEN
    v_nsalary := 15;
    ELSIF v_salary<=15000 THEN
    v_nsalary := 10;
  
    END if;
    
     DBMS_OUTPUT.PUT_LINE('�޿� :' || v_salary);
      DBMS_OUTPUT.PUT_LINE('�̸� : ' || v_ename);
      DBMS_OUTPUT.PUT_LINE('�λ� �޿� : ' || (v_salary * (1+v_nsalary/100)));
      DBMS_OUTPUT.PUT_LINE('�λ�� : ' || (((v_nsalary-v_salary)/v_salary)*10*-1)|| '%');
END;
/

--1���� 10���� �������� ���� ����� ���
--�⺻ LOOP

DECLARE
    v_num NUMBER(2,0) :=1; --1~10
    v_sum NUMBER(2,0) := 0;         -- �� ��
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
    v_sum NUMBER(2,0) := 0;         -- �� ��
BEGIN
    WHILE v_num <= 10  LOOP --  EXIT WHEN v_num > 10;�� ������ LOOP������ �ٿ��ְ� WHILE�� �ٲ� �� 
                                         --  ������ �� �� �⺻ LOOP��(v_num > 10)�� �� �ݴ�� �ָ� �ȴ�
       
         v_sum := v_sum + v_num;
         
         v_num := v_num +1;
           
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;
-- FOR LOOP :--������ �ϳ� �پ���
--1)FOR LOOP �� �ӽú��� => declare ���� ���ǵ� �����̸��� ������ �ȵȴ�..
--2)FOR LOOP�� �⺻������ �������� �����̴�. ���������Ϸ��� in reverse ���


DECLARE
    v_sum NUMBER(2,0) := 0;
    v_n NUMBER(2,0) := 99;
BEGIN
    FOR v_n IN REVERSE 1..10 LOOP --declare���� ����x  reverse���ϰ� 10..1�ϸ� �ȵ��ư�
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

1. ������ ���� ��µǵ��� �Ͻÿ�.
* ù��°�� * 1��
**     *2��
***    ..
****   ..
*****    *5��
*/ --�⺻ Loop
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
    while  v_line <= 4 LOOP --while length(v_star) <=4 Loop �̷����ص���(v_line�� ����)
        
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
    FOR num IN 1..5 LOOP --declare���� ����x//  reverse���ϰ� 10..1�ϸ� �ȵ��ư� // FOR��  IN ���̿� �ִ� ������ readonly(���� �����Ҽ� ����)
         v_star := v_star || '*' ;
       -- v_line := v_line + 1;      
        DBMS_OUTPUT.PUT_LINE(v_star); -- ���� ����� ����ϸ� END �ؿ� ����
        
    END LOOP;
        
END;
/

    --���߹ݺ��� => PUT, PUT_LINE ���
    
DECLARE
       v_star varchar2(6 char) := ''; 
      
BEGIN
    FOR line IN 1..5 LOOP -- �� ����
        FOR star IN 1..line LOOP -- �� ����
      
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
        


