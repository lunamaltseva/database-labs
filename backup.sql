--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    department_id integer NOT NULL,
    name character varying(100) NOT NULL,
    location character varying(100)
);

ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: departments_department_id_seq; Type: SEQUENCE; Schema: public
--

CREATE SEQUENCE public.departments_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.departments ALTER COLUMN department_id SET DEFAULT nextval('public.departments_department_id_seq'::regclass);

--
-- Data for Name: departments; Type: TABLE DATA; Schema: public
--

COPY public.departments (department_id, name, location) FROM stdin;
1	Engineering	New York
2	HR	London
3	Finance	Berlin
\.

--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    department_id integer,
    salary numeric(10,2),
    hire_date date DEFAULT CURRENT_DATE
);

ALTER TABLE public.employees OWNER TO postgres;

CREATE SEQUENCE public.employees_employee_id_seq START WITH 1 INCREMENT BY 1;
ALTER TABLE public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);

COPY public.employees (employee_id, first_name, last_name, department_id, salary, hire_date) FROM stdin;
1	Alice	Johnson	1	80000.00	2024-05-01
2	Bob	Smith	1	95000.00	2023-11-14
3	Charlie	Evans	2	60000.00	2024-06-12
4	Diana	White	3	72000.00	2024-09-22
\.

--
-- Name: assignments; Type: TABLE; Schema: public
--

CREATE TABLE public.assignments (
    employee_id integer,
    project_id integer,
    role character varying(50),
    PRIMARY KEY (employee_id, project_id)
);

COPY public.assignments (employee_id, project_id, role) FROM stdin;
1	1	Developer
2	1	Team Lead
3	2	HR Specialist
4	2	Analyst
\.

--
-- Name: projects; Type: TABLE; Schema: public
--

CREATE TABLE public.projects (
    project_id integer NOT NULL,
    name character varying(100),
    start_date date,
    end_date date
);

CREATE SEQUENCE public.projects_project_id_seq START WITH 1 INCREMENT BY 1;
ALTER TABLE public.projects ALTER COLUMN project_id SET DEFAULT nextval('public.projects_project_id_seq'::regclass);

COPY public.projects (project_id, name, start_date, end_date) FROM stdin;
1	Apollo	2024-01-01	2024-12-31
2	Hermes	2024-03-01	2025-03-01
\.

--
-- Name: assignments_employee_id_fkey; Type: FK CONSTRAINT
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);

--
-- Name: assignments_project_id_fkey; Type: FK CONSTRAINT
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(project_id);

--
-- PostgreSQL database dump complete
--
