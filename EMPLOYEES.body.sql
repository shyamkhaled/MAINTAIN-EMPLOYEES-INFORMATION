CREATE OR REPLACE PACKAGE BODY EMPLOYEES AS
PROCEDURE ADD_DATA 
 (P_EMP_ID  IN NUMBER,
  P_EMP_NAME IN VARCHAR2,
  P_JOB      IN VARCHAR2,
  P_MGR      IN NUMBER,
  P_HIREDATE      IN DATE,
  P_SAL      IN NUMBER,
  P_DEPTNO   IN NUMBER,
  ERROR_FLAG OUT NUMBER
 ) 

 IS 
V_EMP_ID NUMBER;

BEGIN 
    ERROR_FLAG :=0;
    BEGIN 
    SELECT 1 INTO V_EMP_ID FROM EMP 
    WHERE EMPNO = P_EMP_ID;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN 
    V_EMP_ID :=0;
    END;

    IF V_EMP_ID <> 0 THEN 

    INSERT INTO SPECIAL_EMPLOYEES(EMP_ID,EMP_NAME,JOB,MGR,HIREDATE,SAL,DEPTNO)
    VALUES (P_EMP_ID,P_EMP_NAME,P_JOB,P_MGR,P_HIREDATE,P_SAL,P_DEPTNO);

    ELSE 
        ERROR_FLAG :=1;
        ROLLBACK;
        RETURN; 
    END IF;
    END ADD_DATA;


    PROCEDURE CHANGE_DATA(
    P_EMP_ID  IN NUMBER,
    P_EMP_NAME IN VARCHAR2,
    P_JOB      IN VARCHAR2,
    P_MGR      IN NUMBER,
    P_HIREDATE      IN DATE,
    P_SAL      IN NUMBER,
    P_DEPTNO   IN NUMBER,
    ERROR_FLAG OUT NUMBER) IS 

  BEGIN 
    ERROR_FLAG :=0;

    UPDATE SPECIAL_EMPLOYEES 
    SET EMP_NAME = P_EMP_NAME,
        JOB = P_JOB,
        MGR =P_MGR ,
        SAL =P_SAL 
        WHERE EMP_ID =P_EMP_ID; 

   END CHANGE_DATA;

   PROCEDURE DELETE_DATA(

    P_EMP_ID  IN NUMBER,
    ERROR_FLAG OUT NUMBER
    ) IS

    BEGIN 
        ERROR_FLAG:=0;
        DELETE FROM SPECIAL_EMPLOYEES WHERE EMP_ID= P_EMP_ID;
    END DELETE_DATA;

    PROCEDURE DIS_DATA 
        (P_EMP_ID  IN NUMBER,
        P_EMP_NAME OUT VARCHAR2,
        P_JOB      OUT VARCHAR2,
        P_MGR      OUT NUMBER,
        P_HIREDATE      OUT DATE,
        P_SAL      OUT NUMBER,
        P_DEPTNO   OUT NUMBER,
        ERROR_FLAG OUT NUMBER) IS 


        BEGIN
            ERROR_FLAG:=0;
            BEGIN 
            SELECT 
            EMP_NAME ,
            JOB ,
            MGR ,
            HIREDATE ,
            SAL ,
            DEPTNO  INTO 
            P_EMP_NAME ,
        P_JOB      ,
        P_MGR      ,
        P_HIREDATE      ,
        P_SAL      ,
        P_DEPTNO   
        FROM SPECIAL_EMPLOYEES
        WHERE EMP_ID IN (SELECT EMPNO FROM EMP);

    EXCEPTION
        WHEN OTHERS
        THEN
            ERROR_FLAG:=1;
            ROLLBACK;
            RETURN;
    END;

    END DIS_DATA; 

PROCEDURE DIS_HIREDATE
(P_EMP_ID  IN NUMBER,
 ERROR_FLAG OUT NUMBER) IS 

 CURSOR C IS 
 SELECT EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,DEPTNO
  FROM EMP
   WHERE TO_CHAR(HIREDATE,'MMDD')= TO_CHAR(SYSDATE,'MMDD');

   BEGIN
        ERROR_FLAG:=0;
        FOR C0 IN C LOOP
            INSERT INTO SPECIAL_EMPLOYEES (EMP_ID ,
    EMP_NAME ,
    JOB ,
    MGR ,
    HIREDATE ,
    SAL ,
    DEPTNO )
            VALUES
             ( C0.EMPNO,C0.ENAME,C0.JOB,C0.MGR,C0.HIREDATE,C0.SAL,C0.DEPTNO);
        END LOOP;       
        
    EXCEPTION
        WHEN OTHERS
        THEN
            
            ERROR_FLAG:=1;
            RETURN;

    END DIS_HIREDATE;   


END EMPLOYEES;

