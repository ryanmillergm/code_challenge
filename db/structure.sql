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

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: street_cafes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.street_cafes (
    id bigint NOT NULL,
    restaurant_name character varying,
    street_address character varying,
    post_code character varying,
    number_of_chairs integer,
    bench_seating character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category character varying
);


--
-- Name: street_cafes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.street_cafes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: street_cafes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.street_cafes_id_seq OWNED BY public.street_cafes.id;


--
-- Name: street_cafes_report_by_category; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.street_cafes_report_by_category AS
 SELECT street_cafes.category,
    count(street_cafes.id) AS total_places,
    sum(street_cafes.number_of_chairs) AS total_chairs
   FROM public.street_cafes
  GROUP BY street_cafes.category
  ORDER BY street_cafes.category;


--
-- Name: street_cafes_report_by_post_code; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.street_cafes_report_by_post_code AS
 SELECT street.post_code,
    count(*) AS total_places,
    sum(street.number_of_chairs) AS total_chairs,
    round(((((sum(street.number_of_chairs))::numeric * 1.0) / ( SELECT ((sum(cafes.number_of_chairs))::numeric * 1.0)
           FROM public.street_cafes cafes)) * (100)::numeric), 2) AS chair_pct,
    ( SELECT sc.restaurant_name
           FROM public.street_cafes sc
          WHERE ((sc.post_code)::text = (street.post_code)::text)
          ORDER BY sc.number_of_chairs DESC
         LIMIT 1) AS place_with_max_chairs,
    max(street.number_of_chairs) AS max_chairs
   FROM public.street_cafes street
  GROUP BY street.post_code
  ORDER BY street.post_code;


--
-- Name: street_cafes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.street_cafes ALTER COLUMN id SET DEFAULT nextval('public.street_cafes_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: street_cafes street_cafes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.street_cafes
    ADD CONSTRAINT street_cafes_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200211233444'),
('20200427204743'),
('20200429171537'),
('20200507173740');


