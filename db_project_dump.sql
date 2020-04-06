--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6
-- Dumped by pg_dump version 12.0

-- Started on 2020-04-06 16:35:08 EDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 212 (class 1255 OID 924984)
-- Name: firstfirst(character varying, character varying); Type: FUNCTION; Schema: public; Owner: agawi052
--

CREATE FUNCTION public.firstfirst(guest_fname character varying, guest_lname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
	DECLARE full_name varchar(30);
	BEGIN	
		SELECT CONCAT(first_name, ' ', last_name) INTO full_name
		FROM guest 
		WHERE guest.first_name = guest_Fname and guest.last_name = guest_Lname;
	RETURN full_name;
END
$$;


ALTER FUNCTION public.firstfirst(guest_fname character varying, guest_lname character varying) OWNER TO agawi052;

--
-- TOC entry 211 (class 1255 OID 827520)
-- Name: firstnamefirst(character varying); Type: FUNCTION; Schema: public; Owner: agawi052
--

CREATE FUNCTION public.firstnamefirst(guest_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
	declare full_name varchar(30);
	begin	
		select CONCAT(first_name, ' ', last_name) into full_name
		from guest 
		where guest.username = guest_username;
	return full_name;
end
$$;


ALTER FUNCTION public.firstnamefirst(guest_username character varying) OWNER TO agawi052;

--
-- TOC entry 213 (class 1255 OID 924985)
-- Name: firstnamefirst(character varying, character varying); Type: FUNCTION; Schema: public; Owner: agawi052
--

CREATE FUNCTION public.firstnamefirst(guest_fname character varying, guest_lname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
	DECLARE full_name varchar(30);
	BEGIN	
		SELECT CONCAT(first_name, ' ', last_name) INTO full_name
		FROM guest 
		WHERE guest.first_name = guest_Fname and guest.last_name = guest_Lname;
	RETURN full_name;
END
$$;


ALTER FUNCTION public.firstnamefirst(guest_fname character varying, guest_lname character varying) OWNER TO agawi052;

--
-- TOC entry 210 (class 1255 OID 19846)
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: pgsql
--

CREATE FUNCTION public.plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO pgsql;

SET default_tablespace = '';

--
-- TOC entry 208 (class 1259 OID 803499)
-- Name: branch; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.branch (
    branch_id character varying(50) NOT NULL
);


ALTER TABLE public.branch OWNER TO agawi052;

--
-- TOC entry 198 (class 1259 OID 713455)
-- Name: employee; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.employee (
    username character varying(50) NOT NULL,
    "position" character varying(50),
    salary integer,
    first_name character varying(50),
    middle_name character varying(50),
    last_name character varying(50),
    password character varying(50),
    house_number integer,
    street character varying(50),
    city character varying(50),
    province character varying(50),
    country character varying(50),
    email character varying(50),
    branch_id character varying(50)
);


ALTER TABLE public.employee OWNER TO agawi052;

--
-- TOC entry 200 (class 1259 OID 713468)
-- Name: guest; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.guest (
    username character varying(50) NOT NULL,
    first_name character varying(50),
    middle_name character varying(50),
    last_name character varying(50),
    password character varying(50),
    house_number integer,
    street character varying(50),
    city character varying(50),
    province character varying(50),
    country character varying(50),
    email character varying(50)
);


ALTER TABLE public.guest OWNER TO agawi052;

--
-- TOC entry 197 (class 1259 OID 713450)
-- Name: payment; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.payment (
    payment_id integer NOT NULL,
    payment_type character(20) NOT NULL,
    amount numeric(10,2) NOT NULL,
    status character(20) NOT NULL
);


ALTER TABLE public.payment OWNER TO agawi052;

--
-- TOC entry 196 (class 1259 OID 713437)
-- Name: price; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.price (
    property_id integer NOT NULL,
    price numeric(10,2) NOT NULL,
    allowed_guests integer,
    home_type character varying(200),
    rules character varying(255),
    ameneties character varying(255),
    property_class character varying(255)
);


ALTER TABLE public.price OWNER TO agawi052;

--
-- TOC entry 199 (class 1259 OID 713463)
-- Name: property; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.property (
    property_id integer NOT NULL,
    host_username character varying(50) NOT NULL,
    house_number integer,
    street character varying(50),
    city character varying(50),
    province character varying(50),
    country character varying(50),
    property_type character varying(50),
    room_type character varying(50),
    accommodates integer,
    bathrooms integer,
    bedrooms integer,
    beds integer
);


ALTER TABLE public.property OWNER TO agawi052;

--
-- TOC entry 204 (class 1259 OID 713497)
-- Name: rental_agreement; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.rental_agreement (
    guest_username character varying(50) NOT NULL,
    property_id integer NOT NULL,
    payment_id integer NOT NULL,
    start_date date,
    end_date date,
    signing_date date
);


ALTER TABLE public.rental_agreement OWNER TO agawi052;

--
-- TOC entry 209 (class 1259 OID 865711)
-- Name: guestlistview; Type: VIEW; Schema: public; Owner: agawi052
--

CREATE VIEW public.guestlistview AS
 SELECT guest.first_name,
    guest.last_name,
    property.property_type,
    price.price,
    rental_agreement.signing_date,
    property.country,
    payment.payment_type,
    payment.status
   FROM ((((public.guest
     JOIN public.rental_agreement ON (((guest.username)::text = (rental_agreement.guest_username)::text)))
     JOIN public.property USING (property_id))
     JOIN public.price USING (property_id))
     JOIN public.payment USING (payment_id))
  ORDER BY payment.payment_type, rental_agreement.signing_date DESC;


ALTER TABLE public.guestlistview OWNER TO agawi052;

--
-- TOC entry 201 (class 1259 OID 713476)
-- Name: host; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.host (
    username character varying(50) NOT NULL,
    first_name character varying(50),
    middle_name character varying(50),
    last_name character varying(50),
    password character varying(50),
    house_number integer,
    street character varying(50),
    city character varying(50),
    province character varying(50),
    country character varying(50),
    email character varying(50)
);


ALTER TABLE public.host OWNER TO agawi052;

--
-- TOC entry 203 (class 1259 OID 713492)
-- Name: manages; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.manages (
    manager_username character varying(50) NOT NULL,
    managee_username character varying(50) NOT NULL
);


ALTER TABLE public.manages OWNER TO agawi052;

--
-- TOC entry 202 (class 1259 OID 713484)
-- Name: review; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.review (
    username character varying(50) NOT NULL,
    property_id integer NOT NULL,
    rating integer,
    comment character varying(255),
    communication integer,
    cleanliness integer,
    value character varying(255)
);


ALTER TABLE public.review OWNER TO agawi052;

--
-- TOC entry 207 (class 1259 OID 782016)
-- Name: user_phone_employee; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.user_phone_employee (
    username character varying(50) NOT NULL,
    phone_number bigint NOT NULL
);


ALTER TABLE public.user_phone_employee OWNER TO agawi052;

--
-- TOC entry 205 (class 1259 OID 781996)
-- Name: user_phone_guest; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.user_phone_guest (
    username character varying(50) NOT NULL,
    phone_number bigint NOT NULL
);


ALTER TABLE public.user_phone_guest OWNER TO agawi052;

--
-- TOC entry 206 (class 1259 OID 782006)
-- Name: user_phone_host; Type: TABLE; Schema: public; Owner: agawi052
--

CREATE TABLE public.user_phone_host (
    username character varying(50) NOT NULL,
    phone_number bigint NOT NULL
);


ALTER TABLE public.user_phone_host OWNER TO agawi052;

--
-- TOC entry 3379 (class 0 OID 803499)
-- Dependencies: 208
-- Data for Name: branch; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.branch (branch_id) FROM stdin;
Canada
Egypt
Zimbabwe
\.


--
-- TOC entry 3369 (class 0 OID 713455)
-- Dependencies: 198
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.employee (username, "position", salary, first_name, middle_name, last_name, password, house_number, street, city, province, country, email, branch_id) FROM stdin;
aaa	manager	25000	ento	zbalaaaa	a	bassword	1	oofin	Ott	ON	Canada	entozbalaaaa@oofin.com	Canada
bbb	managee	30000	entoo	zbalaaa	o	bassword	2	wa	Tor	ON	Egypt	entoozbalaaa@wa.com	Zimbabwe
ccc	manager	14000	entooo	zbalaa	y	bassword	3	tof	Cai	ON	Zimbabwe	entooozbalaa@tof.com	Egypt
ddd	managee	15000	entoooo	zbala	o	bassword	4	ooo	Alex	ON	EgyCan	entoooozbala@ooo.com	Egypt
eee	managee	20000	eo	zla	m	bassword	5	ooo	Alex	ON	EgyCan	ena@ooo.com	Canada
\.


--
-- TOC entry 3371 (class 0 OID 713468)
-- Dependencies: 200
-- Data for Name: guest; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.guest (username, first_name, middle_name, last_name, password, house_number, street, city, province, country, email) FROM stdin;
Ahmed_Abdel	Ahmed	Mohammed	Abdelrehim	teet	123	laurier	Ottawa	ON	Canada	a7eh@gmail.com
Ahmed_Gawi	Ahmed		Gawish	teet	123	Riverside	Ottawa	ON	Canada	gaw@gmail.com
Omar_Rad	Omar	Radwan	Mohsen	teet	123	Dwntwn	Ottawa	ON	Canada	rad@gmail.com
\.


--
-- TOC entry 3372 (class 0 OID 713476)
-- Dependencies: 201
-- Data for Name: host; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.host (username, first_name, middle_name, last_name, password, house_number, street, city, province, country, email) FROM stdin;
Bebo33	bebo	Mohsen	Ali	teet	123	Dwntwn	Ottawa	ON	Canada	bebo@gmail.com
abcd	aa	bb	cd	passwordd	324	apple	toffaha	ABC	el-waha	abcd@alphabet.com
manb	wa	aw	waw	passwordein	5489	orange	bortoqal	EFG	el-city	waawwaw@gmail.com
\.


--
-- TOC entry 3374 (class 0 OID 713492)
-- Dependencies: 203
-- Data for Name: manages; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.manages (manager_username, managee_username) FROM stdin;
aaa	bbb
ccc	ddd
ccc	eee
\.


--
-- TOC entry 3368 (class 0 OID 713450)
-- Dependencies: 197
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.payment (payment_id, payment_type, amount, status) FROM stdin;
1	credit card         	500.00	accepted            
2	credit card         	300.00	accepted            
3	credit card         	300.00	accepted            
4	credit card         	300.00	accepted            
7	cash                	3500.00	pending             
5	credit card         	300.00	accepted            
6	credit card         	300.00	accepted            
\.


--
-- TOC entry 3367 (class 0 OID 713437)
-- Dependencies: 196
-- Data for Name: price; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.price (property_id, price, allowed_guests, home_type, rules, ameneties, property_class) FROM stdin;
123	500.00	4	Apartment	Drink milk daily	wifi	c-class
124	550.00	\N	\N	\N	\N	\N
325	575.00	\N	\N	\N	\N	\N
42	890.00	\N	\N	\N	\N	\N
50	356.00	\N	\N	\N	\N	\N
\.


--
-- TOC entry 3370 (class 0 OID 713463)
-- Dependencies: 199
-- Data for Name: property; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.property (property_id, host_username, house_number, street, city, province, country, property_type, room_type, accommodates, bathrooms, bedrooms, beds) FROM stdin;
123	Bebo33	1	eldo2y	Ottawa	On	Canada	Apartment	7lwa	1	1	1	1
124	abcd	3	el-haram	Giza	AB	Egypt	House	W7sha	3	3	4	2
325	Bebo33	4	el-do2i	Cairo	CA	Canada	Condo	nosnos	2	2	3	1
42	manb	4	el-do2ii	Masr el-gedeeda	CA	Canada	Condo	ya3ni	5	5	1	0
50	manb	4	shobra	Madinet nasr	CA	Zimbabwe	Condo	ya3ni	5	5	1	0
51	manb	5	shobra	Madinet nasr	CA	Zimbabwe	Condo	ya3ni	5	5	1	0
\.


--
-- TOC entry 3375 (class 0 OID 713497)
-- Dependencies: 204
-- Data for Name: rental_agreement; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.rental_agreement (guest_username, property_id, payment_id, start_date, end_date, signing_date) FROM stdin;
Ahmed_Abdel	123	1	2020-02-20	2020-02-24	2020-01-08
Ahmed_Abdel	124	2	2020-02-25	2020-03-02	2020-01-25
Ahmed_Abdel	325	3	2020-03-04	2020-03-06	2020-01-26
Omar_Rad	50	4	2020-03-07	2020-03-09	2020-01-27
Ahmed_Gawi	123	7	2020-04-08	2020-04-15	2020-03-01
Ahmed_Gawi	50	5	2020-03-10	2020-03-12	2020-01-27
Ahmed_Gawi	51	6	2020-03-13	2020-03-14	2020-01-27
\.


--
-- TOC entry 3373 (class 0 OID 713484)
-- Dependencies: 202
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.review (username, property_id, rating, comment, communication, cleanliness, value) FROM stdin;
Ahmed_Gawi	50	4	ento zbala	3	5	4
Ahmed_Abdel	123	3	ento zbala	3	5	4
Ahmed_Abdel	124	4	ento zbala	3	5	4
Ahmed_Abdel	325	5	ento zbala	3	5	4
Omar_Rad	123	3	ento zbala	3	5	4
Omar_Rad	50	3	ento zbala	3	5	4
\.


--
-- TOC entry 3378 (class 0 OID 782016)
-- Dependencies: 207
-- Data for Name: user_phone_employee; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.user_phone_employee (username, phone_number) FROM stdin;
\.


--
-- TOC entry 3376 (class 0 OID 781996)
-- Dependencies: 205
-- Data for Name: user_phone_guest; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.user_phone_guest (username, phone_number) FROM stdin;
Ahmed_Abdel	6136000273
\.


--
-- TOC entry 3377 (class 0 OID 782006)
-- Dependencies: 206
-- Data for Name: user_phone_host; Type: TABLE DATA; Schema: public; Owner: agawi052
--

COPY public.user_phone_host (username, phone_number) FROM stdin;
\.


--
-- TOC entry 3230 (class 2606 OID 803503)
-- Name: branch branch_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.branch
    ADD CONSTRAINT branch_pkey PRIMARY KEY (branch_id);


--
-- TOC entry 3208 (class 2606 OID 713462)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (username);


--
-- TOC entry 3212 (class 2606 OID 713475)
-- Name: guest guest_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_pkey PRIMARY KEY (username);


--
-- TOC entry 3214 (class 2606 OID 713483)
-- Name: host host_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.host
    ADD CONSTRAINT host_pkey PRIMARY KEY (username);


--
-- TOC entry 3218 (class 2606 OID 713496)
-- Name: manages manages_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.manages
    ADD CONSTRAINT manages_pkey PRIMARY KEY (manager_username, managee_username);


--
-- TOC entry 3206 (class 2606 OID 713454)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 3204 (class 2606 OID 713444)
-- Name: price price_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_pkey PRIMARY KEY (property_id);


--
-- TOC entry 3210 (class 2606 OID 713467)
-- Name: property property_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_pkey PRIMARY KEY (property_id);


--
-- TOC entry 3220 (class 2606 OID 804956)
-- Name: rental_agreement rental_agreement_payment_id_key; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_payment_id_key UNIQUE (payment_id);


--
-- TOC entry 3222 (class 2606 OID 713501)
-- Name: rental_agreement rental_agreement_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_pkey PRIMARY KEY (guest_username, property_id, payment_id);


--
-- TOC entry 3216 (class 2606 OID 713491)
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (username, property_id);


--
-- TOC entry 3228 (class 2606 OID 813453)
-- Name: user_phone_employee user_phone_employee_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.user_phone_employee
    ADD CONSTRAINT user_phone_employee_pkey PRIMARY KEY (username, phone_number);


--
-- TOC entry 3224 (class 2606 OID 813447)
-- Name: user_phone_guest user_phone_guest_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.user_phone_guest
    ADD CONSTRAINT user_phone_guest_pkey PRIMARY KEY (username, phone_number);


--
-- TOC entry 3226 (class 2606 OID 813459)
-- Name: user_phone_host user_phone_host_pkey; Type: CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.user_phone_host
    ADD CONSTRAINT user_phone_host_pkey PRIMARY KEY (username, phone_number);


--
-- TOC entry 3232 (class 2606 OID 865649)
-- Name: employee employee_branch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_branch_id_fkey FOREIGN KEY (branch_id) REFERENCES public.branch(branch_id);


--
-- TOC entry 3238 (class 2606 OID 713527)
-- Name: manages manages_managee_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.manages
    ADD CONSTRAINT manages_managee_username_fkey FOREIGN KEY (managee_username) REFERENCES public.employee(username);


--
-- TOC entry 3237 (class 2606 OID 713522)
-- Name: manages manages_manager_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.manages
    ADD CONSTRAINT manages_manager_username_fkey FOREIGN KEY (manager_username) REFERENCES public.employee(username);


--
-- TOC entry 3231 (class 2606 OID 781953)
-- Name: price price_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(property_id);


--
-- TOC entry 3234 (class 2606 OID 803809)
-- Name: property property_country_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_country_fkey FOREIGN KEY (country) REFERENCES public.branch(branch_id);


--
-- TOC entry 3233 (class 2606 OID 781961)
-- Name: property property_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT property_username_fkey FOREIGN KEY (host_username) REFERENCES public.host(username);


--
-- TOC entry 3241 (class 2606 OID 781991)
-- Name: rental_agreement rental_agreement_payment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.payment(payment_id);


--
-- TOC entry 3240 (class 2606 OID 781986)
-- Name: rental_agreement rental_agreement_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(property_id);


--
-- TOC entry 3239 (class 2606 OID 781981)
-- Name: rental_agreement rental_agreement_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.rental_agreement
    ADD CONSTRAINT rental_agreement_username_fkey FOREIGN KEY (guest_username) REFERENCES public.guest(username);


--
-- TOC entry 3235 (class 2606 OID 781966)
-- Name: review review_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_property_id_fkey FOREIGN KEY (property_id) REFERENCES public.property(property_id);


--
-- TOC entry 3236 (class 2606 OID 781971)
-- Name: review review_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_username_fkey FOREIGN KEY (username) REFERENCES public.guest(username);


--
-- TOC entry 3244 (class 2606 OID 782021)
-- Name: user_phone_employee user_phone_employee_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.user_phone_employee
    ADD CONSTRAINT user_phone_employee_username_fkey FOREIGN KEY (username) REFERENCES public.employee(username);


--
-- TOC entry 3242 (class 2606 OID 782001)
-- Name: user_phone_guest user_phone_guest_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.user_phone_guest
    ADD CONSTRAINT user_phone_guest_username_fkey FOREIGN KEY (username) REFERENCES public.guest(username);


--
-- TOC entry 3243 (class 2606 OID 782011)
-- Name: user_phone_host user_phone_host_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: agawi052
--

ALTER TABLE ONLY public.user_phone_host
    ADD CONSTRAINT user_phone_host_username_fkey FOREIGN KEY (username) REFERENCES public.host(username);


--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO pgsql;


-- Completed on 2020-04-06 16:35:16 EDT

--
-- PostgreSQL database dump complete
--

