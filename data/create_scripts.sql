CREATE TABLE public.category
(
    category_id integer NOT NULL,
    category_name character varying(127) COLLATE pg_catalog."default",
    CONSTRAINT category_pkey PRIMARY KEY (category_id)
)

CREATE TABLE public.page
(
    page_id integer NOT NULL,
    title character varying(127) COLLATE pg_catalog."default",
    created_at timestamp without time zone DEFAULT now(),
    page text COLLATE pg_catalog."default",
    CONSTRAINT page_pkey PRIMARY KEY (page_id)
)

CREATE TABLE public.page_vector
(
    page_id integer NOT NULL,
    page_vec double precision[],
    CONSTRAINT page_vector_pkey PRIMARY KEY (page_id),
    CONSTRAINT fk_page_vector FOREIGN KEY (page_id)
        REFERENCES public.page (page_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.page_vector
    OWNER to suketu;

GRANT ALL ON TABLE public.page_vector TO chris;

GRANT ALL ON TABLE public.page_vector TO scott;

GRANT ALL ON TABLE public.page_vector TO suketu;

CREATE TABLE public.category_vector
(
    category_id integer NOT NULL,
    category_vec double precision[],
    CONSTRAINT category_vector_pkey PRIMARY KEY (category_id),
    CONSTRAINT category_vector_category_id_fkey FOREIGN KEY (category_id)
        REFERENCES public.category (category_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.category_vector
    OWNER to suketu;

GRANT ALL ON TABLE public.category_vector TO chris;

GRANT ALL ON TABLE public.category_vector TO scott;

GRANT ALL ON TABLE public.category_vector TO suketu;

CREATE TABLE public.page_cate
(
    page_id integer NOT NULL,
    category_id integer NOT NULL,
    CONSTRAINT pk_page_cate PRIMARY KEY (category_id, page_id),
    CONSTRAINT page_cate_category_id_fkey FOREIGN KEY (category_id)
        REFERENCES public.category (category_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT page_cate_page_id_fkey FOREIGN KEY (page_id)
        REFERENCES public.page (page_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

select c.category_id, c.category_name, p.* from category as c, page as p, page_cate pc 
where pc.page_id = p.page_id and pc.category_id = c.category_id and c.category_id in (2835113,1489690)