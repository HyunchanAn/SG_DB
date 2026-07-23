--
-- PostgreSQL database dump
--

\restrict aGTLH0M87p2gkEPgqq4sduhfslGsD3iivAz9JLM4HEb10oxwbf7NpV0aQA267wE

-- Dumped from database version 15.18
-- Dumped by pg_dump version 15.18

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adherend_criteria; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.adherend_criteria (
    id integer NOT NULL,
    level integer,
    representative_surface character varying,
    recommended_adhesion character varying,
    roughness_um character varying,
    gloss character varying,
    surface_energy character varying,
    general_usage character varying
);


ALTER TABLE public.adherend_criteria OWNER TO sg_user;

--
-- Name: adherend_criteria_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.adherend_criteria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adherend_criteria_id_seq OWNER TO sg_user;

--
-- Name: adherend_criteria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.adherend_criteria_id_seq OWNED BY public.adherend_criteria.id;


--
-- Name: adherend_properties; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.adherend_properties (
    id integer NOT NULL,
    classification character varying,
    product_name character varying,
    company character varying,
    thickness_mm double precision,
    roughness_md double precision,
    roughness_td double precision,
    gloss_md double precision,
    gloss_td double precision,
    surface_energy_md double precision,
    surface_energy_td double precision,
    note character varying
);


ALTER TABLE public.adherend_properties OWNER TO sg_user;

--
-- Name: adherend_properties_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.adherend_properties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adherend_properties_id_seq OWNER TO sg_user;

--
-- Name: adherend_properties_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.adherend_properties_id_seq OWNED BY public.adherend_properties.id;


--
-- Name: adherend_stocks; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.adherend_stocks (
    id integer NOT NULL,
    stock_id character varying,
    arrival_date character varying,
    supplier character varying,
    adherend_type character varying,
    adherend_property_id integer,
    color character varying,
    quantity integer,
    thickness_t double precision,
    surface_energy character varying,
    gloss_gu character varying,
    roughness_md character varying,
    roughness_td character varying,
    note text
);


ALTER TABLE public.adherend_stocks OWNER TO sg_user;

--
-- Name: adherend_stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.adherend_stocks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adherend_stocks_id_seq OWNER TO sg_user;

--
-- Name: adherend_stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.adherend_stocks_id_seq OWNED BY public.adherend_stocks.id;


--
-- Name: adhesive_recipes; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.adhesive_recipes (
    id integer NOT NULL,
    adhesive_code character varying,
    formula_data text
);


ALTER TABLE public.adhesive_recipes OWNER TO sg_user;

--
-- Name: adhesive_recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.adhesive_recipes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adhesive_recipes_id_seq OWNER TO sg_user;

--
-- Name: adhesive_recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.adhesive_recipes_id_seq OWNED BY public.adhesive_recipes.id;


--
-- Name: discrimination_criteria; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.discrimination_criteria (
    id integer NOT NULL,
    level integer,
    stainless_surface text,
    stainless_desc text,
    pcm_surface text,
    pcm_desc text,
    processability text,
    peelability text
);


ALTER TABLE public.discrimination_criteria OWNER TO sg_user;

--
-- Name: discrimination_criteria_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.discrimination_criteria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discrimination_criteria_id_seq OWNER TO sg_user;

--
-- Name: discrimination_criteria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.discrimination_criteria_id_seq OWNED BY public.discrimination_criteria.id;


--
-- Name: ft_ir_spectra; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.ft_ir_spectra (
    id integer NOT NULL,
    category character varying,
    material_name character varying,
    material_id integer,
    file_path character varying,
    image_path character varying
);


ALTER TABLE public.ft_ir_spectra OWNER TO sg_user;

--
-- Name: ft_ir_spectra_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.ft_ir_spectra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ft_ir_spectra_id_seq OWNER TO sg_user;

--
-- Name: ft_ir_spectra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.ft_ir_spectra_id_seq OWNED BY public.ft_ir_spectra.id;


--
-- Name: holding_power_tests; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.holding_power_tests (
    id integer NOT NULL,
    product_name character varying,
    product_id integer,
    time_min integer,
    image_path character varying
);


ALTER TABLE public.holding_power_tests OWNER TO sg_user;

--
-- Name: holding_power_tests_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.holding_power_tests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.holding_power_tests_id_seq OWNER TO sg_user;

--
-- Name: holding_power_tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.holding_power_tests_id_seq OWNED BY public.holding_power_tests.id;


--
-- Name: our_products; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.our_products (
    id integer NOT NULL,
    category character varying,
    product_name character varying,
    color character varying,
    layer character varying,
    thickness_um double precision,
    max_roll_length character varying,
    max_width double precision,
    adhesive character varying,
    tg double precision,
    spec character varying,
    mesh character varying,
    adhesion character varying,
    adhesion_after character varying,
    customer character varying,
    end_customer character varying,
    annual_production_m2 double precision,
    production_cost_sqm double precision,
    target_surface_energy double precision,
    target_roughness double precision,
    target_processability_level integer,
    target_finish_type character varying
);


ALTER TABLE public.our_products OWNER TO sg_user;

--
-- Name: our_products_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.our_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.our_products_id_seq OWNER TO sg_user;

--
-- Name: our_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.our_products_id_seq OWNED BY public.our_products.id;


--
-- Name: raw_materials; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.raw_materials (
    id integer NOT NULL,
    material_name character varying,
    category character varying
);


ALTER TABLE public.raw_materials OWNER TO sg_user;

--
-- Name: raw_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.raw_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.raw_materials_id_seq OWNER TO sg_user;

--
-- Name: raw_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.raw_materials_id_seq OWNED BY public.raw_materials.id;


--
-- Name: uv_curing_media; Type: TABLE; Schema: public; Owner: sg_user
--

CREATE TABLE public.uv_curing_media (
    id integer NOT NULL,
    filename character varying,
    file_path character varying
);


ALTER TABLE public.uv_curing_media OWNER TO sg_user;

--
-- Name: uv_curing_media_id_seq; Type: SEQUENCE; Schema: public; Owner: sg_user
--

CREATE SEQUENCE public.uv_curing_media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.uv_curing_media_id_seq OWNER TO sg_user;

--
-- Name: uv_curing_media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sg_user
--

ALTER SEQUENCE public.uv_curing_media_id_seq OWNED BY public.uv_curing_media.id;


--
-- Name: adherend_criteria id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.adherend_criteria ALTER COLUMN id SET DEFAULT nextval('public.adherend_criteria_id_seq'::regclass);


--
-- Name: adherend_properties id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.adherend_properties ALTER COLUMN id SET DEFAULT nextval('public.adherend_properties_id_seq'::regclass);


--
-- Name: adherend_stocks id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.adherend_stocks ALTER COLUMN id SET DEFAULT nextval('public.adherend_stocks_id_seq'::regclass);


--
-- Name: adhesive_recipes id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.adhesive_recipes ALTER COLUMN id SET DEFAULT nextval('public.adhesive_recipes_id_seq'::regclass);


--
-- Name: discrimination_criteria id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.discrimination_criteria ALTER COLUMN id SET DEFAULT nextval('public.discrimination_criteria_id_seq'::regclass);


--
-- Name: ft_ir_spectra id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.ft_ir_spectra ALTER COLUMN id SET DEFAULT nextval('public.ft_ir_spectra_id_seq'::regclass);


--
-- Name: holding_power_tests id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.holding_power_tests ALTER COLUMN id SET DEFAULT nextval('public.holding_power_tests_id_seq'::regclass);


--
-- Name: our_products id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.our_products ALTER COLUMN id SET DEFAULT nextval('public.our_products_id_seq'::regclass);


--
-- Name: raw_materials id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.raw_materials ALTER COLUMN id SET DEFAULT nextval('public.raw_materials_id_seq'::regclass);


--
-- Name: uv_curing_media id; Type: DEFAULT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.uv_curing_media ALTER COLUMN id SET DEFAULT nextval('public.uv_curing_media_id_seq'::regclass);


--
-- Data for Name: adherend_criteria; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.adherend_criteria (id, level, representative_surface, recommended_adhesion, roughness_um, gloss, surface_energy, general_usage) FROM stdin;
\.


--
-- Data for Name: adherend_properties; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.adherend_properties (id, classification, product_name, company, thickness_mm, roughness_md, roughness_td, gloss_md, gloss_td, surface_energy_md, surface_energy_td, note) FROM stdin;
1	2B	SUS304-2B	POSCO	1	150	140	100	98	38.6	38	E2E test sample
2	BA	SUS304-BA	Hyundai Steel	0.8	50	40	510	500	42.3	41.5	E2E test sample
3	Hairline	SUS304-HL	DK Dongshin	1.2	280	250	28.5	25	34.1	33	E2E test sample
\.


--
-- Data for Name: adherend_stocks; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.adherend_stocks (id, stock_id, arrival_date, supplier, adherend_type, adherend_property_id, color, quantity, thickness_t, surface_energy, gloss_gu, roughness_md, roughness_td, note) FROM stdin;
\.


--
-- Data for Name: adhesive_recipes; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.adhesive_recipes (id, adhesive_code, formula_data) FROM stdin;
1	080	{"BA": 68.0, "BMA": 30.0, "AA": 2.0, "EAc": 80.0, "N.V": 27.6, "VIS": 2800.0, "\\uc810\\ucc29\\ub825": 170.0, "\\ub0b4\\ucda9\\uaca9BA": 2.0, "\\ub0b4\\ucda9\\uaca9#4": 4.0}
2	801	{"2-EHA": 68.0, "MMA": 2.0, "MA": 5.0, "VAc": 20.0, "AA": 5.0, "Eac(LAB)": 130.0, "EAc": 150.0, "N.V": 30.22, "VIS": 2300.0, "\\uc810\\ucc29\\ub825": 180.0}
3	802	{"BA": 74.0, "IBOA": 25.0, "AA": 1.0, "Eac(LAB)": 150.0, "EAc": 170.0, "N.V": 26.26, "VIS": 2340.0, "\\uc810\\ucc29\\ub825": 160.0, "\\ub0b4\\ucda9\\uaca9#4": 3.0}
4	803	{"BA": 66.7, "MMA": 5.0, "IBOA": 23.0, "4-HBA": 5.0, "AA": 0.3, "EAc": 130.0, "N.V": 26.55, "VIS": 2800.0, "\\uc810\\ucc29\\ub825": 200.0, "\\ub0b4\\ucda9\\uaca9#4": 2.0}
5	804	{"BA": 56.0, "LMA": 25.0, "IBOA": 6.0, "4-HBA": 10.0, "AA": 4.0, "EAc": 150.0, "N.V": 27.3, "VIS": 3000.0}
6	805	{"2-EHA": 64.0, "MMA": 2.0, "EAM": 30.0, "AA": 4.0, "EAc": 140.0, "N.V": 27.7, "VIS": 2500.0}
7	806	{"BA": 68.0, "MMA": 30.0, "AA": 2.0, "EAc": 100.0, "N.V": 29.7, "VIS": 2200.0, "\\uc810\\ucc29\\ub825": 80.0, "\\ub0b4\\ucda9\\uaca9#4": 1.0}
8	807	{"2-EHA": 65.0, "MMA": 15.0, "EAM": 18.0, "AA": 2.0, "EAc": 80.0, "N.V": 27.95, "VIS": 2300.0, "\\uc810\\ucc29\\ub825": 190.0, "\\ub0b4\\ucda9\\uaca9BA": 3.0, "\\ub0b4\\ucda9\\uaca9#4": 6.0}
9	808	{"BA": 67.0, "MMA": 5.0, "IBOA": 23.0, "2-HEA": 5.0, "EAc": 130.0, "N.V": 27.3, "VIS": 2000.0}
10	800A	{"2-EHA": 79.0, "MMA": 2.0, "MA": 15.0, "AA": 4.0, "EAc": 140.0, "N.V": 26.07, "VIS": 3500.0, "\\uc810\\ucc29\\ub825": 250.0}
11	700P	{"BA": 52.5, "2-EHA": 17.5, "MMA": 10.0, "MA": 15.0, "AA": 5.0, "EAc": 100.0, "N.V": 27.95, "VIS": 11000.0}
12	700H	{"BA": 52.5, "2-EHA": 17.5, "MMA": 10.0, "MA": 15.0, "2-HEA": 5.0, "EAc": 100.0, "N.V": 27.27, "VIS": 4800.0}
13	700A	{"BA": 52.7, "2-EHA": 16.5, "MMA": 10.0, "MA": 15.0, "2-HEA": 5.0, "AA": 0.8, "EAc": 120.0, "N.V": 28.5, "VIS": 2700.0}
14	702	{"BA": 69.7, "MMA": 23.0, "MA": 2.0, "2-HEA": 5.0, "AA": 0.3, "EAc": 80.0, "N.V": 28.36, "VIS": 1810.0}
15	703	{"BA": 51.1, "2-EHA": 16.5, "MMA": 10.0, "MA": 15.0, "2-HEA": 5.0, "AA": 2.4, "EAc": 110.0, "N.V": 27.0, "VIS": 2520.0}
16	704	{"BA": 67.0, "MMA": 23.0, "MA": 2.0, "2-HEA": 5.0, "AA": 3.0, "EAc": 100.0, "N.V": 27.51, "VIS": 2000.0}
17	603	{"BA": 66.0, "IBOA": 10.0, "2-HEMA": 1.0, "AA": 23.0, "Tg": 2.96, "\\uc810\\ucc29\\ub825": 120.0, "\\ub0b4\\ucda9\\uaca9BA": 1.0, "\\ub0b4\\ucda9\\uaca9#4": 2.0}
18	606	{"BA": 64.0, "CHMA": 15.0, "2-HEMA": 1.0, "AA": 20.0, "Tg": 3.46, "\\uc810\\ucc29\\ub825": 115.0, "\\ub0b4\\ucda9\\uaca9BA": 4.0, "\\ub0b4\\ucda9\\uaca9#4": 5.0}
19	607	{"BA": 84.0, "EMA": 5.0, "2-HEMA": 1.0, "AA": 10.0}
20	904	{"BA": 89.7, "MMA": 9.0, "AA": 1.3}
21	906	{"BA": 78.7, "CHMA": 20.0, "AA": 1.3}
22	907	{"BA": 86.0, "VAc": 9.0, "b-CEA": 5.0}
\.


--
-- Data for Name: discrimination_criteria; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.discrimination_criteria (id, level, stainless_surface, stainless_desc, pcm_surface, pcm_desc, processability, peelability) FROM stdin;
\.


--
-- Data for Name: ft_ir_spectra; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.ft_ir_spectra (id, category, material_name, material_id, file_path, image_path) FROM stdin;
\.


--
-- Data for Name: holding_power_tests; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.holding_power_tests (id, product_name, product_id, time_min, image_path) FROM stdin;
\.


--
-- Data for Name: our_products; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.our_products (id, category, product_name, color, layer, thickness_um, max_roll_length, max_width, adhesive, tg, spec, mesh, adhesion, adhesion_after, customer, end_customer, annual_production_m2, production_cost_sqm, target_surface_energy, target_roughness, target_processability_level, target_finish_type) FROM stdin;
1	\N	SGV225	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	42.5	800	1	2B
2	\N	SGV218ME	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	38	1200	2	BA
3	\N	SGV201	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	45	500	3	HL
4	\N	DUMMY001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	40	1000	2	2B
\.


--
-- Data for Name: raw_materials; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.raw_materials (id, material_name, category) FROM stdin;
\.


--
-- Data for Name: uv_curing_media; Type: TABLE DATA; Schema: public; Owner: sg_user
--

COPY public.uv_curing_media (id, filename, file_path) FROM stdin;
\.


--
-- Name: adherend_criteria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.adherend_criteria_id_seq', 1, false);


--
-- Name: adherend_properties_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.adherend_properties_id_seq', 3, true);


--
-- Name: adherend_stocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.adherend_stocks_id_seq', 1, false);


--
-- Name: adhesive_recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.adhesive_recipes_id_seq', 22, true);


--
-- Name: discrimination_criteria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.discrimination_criteria_id_seq', 1, false);


--
-- Name: ft_ir_spectra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.ft_ir_spectra_id_seq', 1, false);


--
-- Name: holding_power_tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.holding_power_tests_id_seq', 1, false);


--
-- Name: our_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.our_products_id_seq', 4, true);


--
-- Name: raw_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.raw_materials_id_seq', 1, false);


--
-- Name: uv_curing_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sg_user
--

SELECT pg_catalog.setval('public.uv_curing_media_id_seq', 1, false);


--
-- Name: adherend_criteria adherend_criteria_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.adherend_criteria
    ADD CONSTRAINT adherend_criteria_pkey PRIMARY KEY (id);


--
-- Name: adherend_properties adherend_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.adherend_properties
    ADD CONSTRAINT adherend_properties_pkey PRIMARY KEY (id);


--
-- Name: adherend_stocks adherend_stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.adherend_stocks
    ADD CONSTRAINT adherend_stocks_pkey PRIMARY KEY (id);


--
-- Name: adhesive_recipes adhesive_recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.adhesive_recipes
    ADD CONSTRAINT adhesive_recipes_pkey PRIMARY KEY (id);


--
-- Name: discrimination_criteria discrimination_criteria_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.discrimination_criteria
    ADD CONSTRAINT discrimination_criteria_pkey PRIMARY KEY (id);


--
-- Name: ft_ir_spectra ft_ir_spectra_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.ft_ir_spectra
    ADD CONSTRAINT ft_ir_spectra_pkey PRIMARY KEY (id);


--
-- Name: holding_power_tests holding_power_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.holding_power_tests
    ADD CONSTRAINT holding_power_tests_pkey PRIMARY KEY (id);


--
-- Name: our_products our_products_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.our_products
    ADD CONSTRAINT our_products_pkey PRIMARY KEY (id);


--
-- Name: raw_materials raw_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.raw_materials
    ADD CONSTRAINT raw_materials_pkey PRIMARY KEY (id);


--
-- Name: uv_curing_media uv_curing_media_pkey; Type: CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.uv_curing_media
    ADD CONSTRAINT uv_curing_media_pkey PRIMARY KEY (id);


--
-- Name: ix_adherend_criteria_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_adherend_criteria_id ON public.adherend_criteria USING btree (id);


--
-- Name: ix_adherend_criteria_level; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_adherend_criteria_level ON public.adherend_criteria USING btree (level);


--
-- Name: ix_adherend_properties_classification; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_adherend_properties_classification ON public.adherend_properties USING btree (classification);


--
-- Name: ix_adherend_properties_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_adherend_properties_id ON public.adherend_properties USING btree (id);


--
-- Name: ix_adherend_properties_product_name; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE UNIQUE INDEX ix_adherend_properties_product_name ON public.adherend_properties USING btree (product_name);


--
-- Name: ix_adherend_stocks_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_adherend_stocks_id ON public.adherend_stocks USING btree (id);


--
-- Name: ix_adherend_stocks_stock_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_adherend_stocks_stock_id ON public.adherend_stocks USING btree (stock_id);


--
-- Name: ix_adhesive_recipes_adhesive_code; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE UNIQUE INDEX ix_adhesive_recipes_adhesive_code ON public.adhesive_recipes USING btree (adhesive_code);


--
-- Name: ix_adhesive_recipes_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_adhesive_recipes_id ON public.adhesive_recipes USING btree (id);


--
-- Name: ix_discrimination_criteria_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_discrimination_criteria_id ON public.discrimination_criteria USING btree (id);


--
-- Name: ix_discrimination_criteria_level; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE UNIQUE INDEX ix_discrimination_criteria_level ON public.discrimination_criteria USING btree (level);


--
-- Name: ix_ft_ir_spectra_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_ft_ir_spectra_id ON public.ft_ir_spectra USING btree (id);


--
-- Name: ix_holding_power_tests_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_holding_power_tests_id ON public.holding_power_tests USING btree (id);


--
-- Name: ix_our_products_category; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_our_products_category ON public.our_products USING btree (category);


--
-- Name: ix_our_products_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_our_products_id ON public.our_products USING btree (id);


--
-- Name: ix_our_products_product_name; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE UNIQUE INDEX ix_our_products_product_name ON public.our_products USING btree (product_name);


--
-- Name: ix_raw_materials_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_raw_materials_id ON public.raw_materials USING btree (id);


--
-- Name: ix_raw_materials_material_name; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE UNIQUE INDEX ix_raw_materials_material_name ON public.raw_materials USING btree (material_name);


--
-- Name: ix_uv_curing_media_id; Type: INDEX; Schema: public; Owner: sg_user
--

CREATE INDEX ix_uv_curing_media_id ON public.uv_curing_media USING btree (id);


--
-- Name: adherend_stocks adherend_stocks_adherend_property_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.adherend_stocks
    ADD CONSTRAINT adherend_stocks_adherend_property_id_fkey FOREIGN KEY (adherend_property_id) REFERENCES public.adherend_properties(id);


--
-- Name: ft_ir_spectra ft_ir_spectra_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.ft_ir_spectra
    ADD CONSTRAINT ft_ir_spectra_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.raw_materials(id);


--
-- Name: holding_power_tests holding_power_tests_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sg_user
--

ALTER TABLE ONLY public.holding_power_tests
    ADD CONSTRAINT holding_power_tests_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.our_products(id);


--
-- PostgreSQL database dump complete
--

\unrestrict aGTLH0M87p2gkEPgqq4sduhfslGsD3iivAz9JLM4HEb10oxwbf7NpV0aQA267wE

