-- Create table to save information of special employees choosen from EMP tabele
CREATE TABLE SPECIAL_EMPLOYEES(
    EMP_ID NUMBER(7) NOT NULL,
    EMP_NAME VARCHAR2(20),
    JOB VARCHAR2(9),
    MGR NUMBER(7),
    HIERDATE DATE,
    SAL NUMBER(7,2),
    DEPTNO NUMBER(2)
);
CREATE UNIQUE INDEX SPECIAL_EMPLOYEES_PK ON SPECIAL_EMPLOYEES(EMP_ID);
COMMIT;
