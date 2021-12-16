--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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
-- Name: cevirmenara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cevirmenara(cevirmenid integer) RETURNS TABLE(id integer, adi character)
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN QUERY SELECT "cevirmen_id","cevirmen_ad" FROM cevirmenler WHERE "cevirmen_id"=cevirmenid;
    END;
    $$;


ALTER FUNCTION public.cevirmenara(cevirmenid integer) OWNER TO postgres;

--
-- Name: kategoriliste(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kategoriliste() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE 
katego kategoriler%ROWTYPE;
sonuc TEXT;
BEGIN
    sonuc:='';
    FOR katego IN SELECT * FROM kategoriler LOOP
    sonuc := sonuc|| katego."kategori_id"|| E'\t'|| katego."kategori"|| E'\r\n';
    END LOOP;
    RETURN sonuc;
    
    END;
    $$;


ALTER FUNCTION public.kategoriliste() OWNER TO postgres;

--
-- Name: kitapara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kitapara(kitapid integer) RETURNS TABLE(id integer, adi character)
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN QUERY SELECT "kitap_id","kitap_ad" FROM kitaplar WHERE "kitap_id"=kitapid;
    END;
    $$;


ALTER FUNCTION public.kitapara(kitapid integer) OWNER TO postgres;

--
-- Name: oyunara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.oyunara(oyuno integer) RETURNS TABLE(id integer, adi character)
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN QUERY SELECT "oyun_id","oyun_ad" FROM oyunlar WHERE "oyun_id"=oyunno;
    END;
    $$;


ALTER FUNCTION public.oyunara(oyuno integer) OWNER TO postgres;

--
-- Name: urunDegisikligi1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."urunDegisikligi1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."defterfiyat" <> OLD."defterfiyat" THEN
        INSERT INTO "UrunDegisikligiIzle"("urunNo", "eskiBirimFiyat", "yeniBirimFiyat", "degisiklikTarihi")
        VALUES(OLD."defter_id", OLD."defterfiyat", NEW."defterfiyat", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."urunDegisikligi1"() OWNER TO postgres;

--
-- Name: urunDegisikligi2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."urunDegisikligi2"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."kalemfiyat" <> OLD."kalemfiyat" THEN
        INSERT INTO "UrunDegisikligiIzle1"("urunNo", "eskiBirimFiyat", "yeniBirimFiyat", "degisiklikTarihi")
        VALUES(OLD."kalem_id", OLD."kalemfiyat", NEW."kalemfiyat", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."urunDegisikligi2"() OWNER TO postgres;

--
-- Name: urunDegisikligi3(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."urunDegisikligi3"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."fiyat" <> OLD."fiyat" THEN
        INSERT INTO "UrunDegisikligiIzle2"("urunNo", "eskiBirimFiyat", "yeniBirimFiyat", "degisiklikTarihi")
        VALUES(OLD."kitap_id", OLD."fiyat", NEW."fiyat", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."urunDegisikligi3"() OWNER TO postgres;

--
-- Name: urunDegisikligi4(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."urunDegisikligi4"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."oyunfiyat" <> OLD."oyunfiyat" THEN
        INSERT INTO "UrunDegisikligiIzle3"("urunNo", "eskiBirimFiyat", "yeniBirimFiyat", "degisiklikTarihi")
        VALUES(OLD."oyun_id", OLD."oyunfiyat", NEW."oyunfiyat", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."urunDegisikligi4"() OWNER TO postgres;

--
-- Name: uyeara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.uyeara(uyenumara integer) RETURNS TABLE(id integer, adi character, soyadi character)
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN QUERY SELECT "uyeno","ad","soyad" FROM uye WHERE "uyeno"=uyenumara;
    END;
    $$;


ALTER FUNCTION public.uyeara(uyenumara integer) OWNER TO postgres;

--
-- Name: yayineviara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yayineviara(yayinevinumara integer) RETURNS TABLE(id integer, yayinevi character)
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN QUERY SELECT "yayinevleri_id","yayinevleri_ad" FROM yayinevleri WHERE "yayinevleri_id"=yayinevinumara;
    END;
    $$;


ALTER FUNCTION public.yayineviara(yayinevinumara integer) OWNER TO postgres;

--
-- Name: yazarara(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yazarara(yazarno integer) RETURNS TABLE(id integer, isim character)
    LANGUAGE plpgsql
    AS $$ 
BEGIN
    RETURN QUERY SELECT "yazar_id","yazar_ad" FROM yazarlar WHERE "yazar_id"=yazarno;
    END;
    $$;


ALTER FUNCTION public.yazarara(yazarno integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: UrunDegisikligiIzle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UrunDegisikligiIzle" (
    "kayitNo" integer NOT NULL,
    "urunNo" integer NOT NULL,
    "eskiBirimFiyat" real NOT NULL,
    "yeniBirimFiyat" real NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL
);


ALTER TABLE public."UrunDegisikligiIzle" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UrunDegisikligiIzle1" (
    "kayitNo" integer NOT NULL,
    "urunNo" integer NOT NULL,
    "eskiBirimFiyat" real NOT NULL,
    "yeniBirimFiyat" real NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL
);


ALTER TABLE public."UrunDegisikligiIzle1" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle1_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UrunDegisikligiIzle1_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UrunDegisikligiIzle1_kayitNo_seq" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle1_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UrunDegisikligiIzle1_kayitNo_seq" OWNED BY public."UrunDegisikligiIzle1"."kayitNo";


--
-- Name: UrunDegisikligiIzle2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UrunDegisikligiIzle2" (
    "kayitNo" integer NOT NULL,
    "urunNo" integer NOT NULL,
    "eskiBirimFiyat" real NOT NULL,
    "yeniBirimFiyat" real NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL
);


ALTER TABLE public."UrunDegisikligiIzle2" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle2_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UrunDegisikligiIzle2_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UrunDegisikligiIzle2_kayitNo_seq" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle2_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UrunDegisikligiIzle2_kayitNo_seq" OWNED BY public."UrunDegisikligiIzle2"."kayitNo";


--
-- Name: UrunDegisikligiIzle3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UrunDegisikligiIzle3" (
    "kayitNo" integer NOT NULL,
    "urunNo" integer NOT NULL,
    "eskiBirimFiyat" real NOT NULL,
    "yeniBirimFiyat" real NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL
);


ALTER TABLE public."UrunDegisikligiIzle3" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle3_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UrunDegisikligiIzle3_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UrunDegisikligiIzle3_kayitNo_seq" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle3_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UrunDegisikligiIzle3_kayitNo_seq" OWNED BY public."UrunDegisikligiIzle3"."kayitNo";


--
-- Name: UrunDegisikligiIzle_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UrunDegisikligiIzle_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."UrunDegisikligiIzle_kayitNo_seq" OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UrunDegisikligiIzle_kayitNo_seq" OWNED BY public."UrunDegisikligiIzle"."kayitNo";


--
-- Name: cevirmenler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cevirmenler (
    cevirmen_id integer NOT NULL,
    cevirmen_ad character(50) NOT NULL,
    cevirmen_soyad character(50) NOT NULL,
    cevirdigidil character(50) NOT NULL
);


ALTER TABLE public.cevirmenler OWNER TO postgres;

--
-- Name: defter_tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defter_tur (
    defter_tur_id integer NOT NULL,
    defter_tur_ad character(50) NOT NULL,
    defter_id integer NOT NULL
);


ALTER TABLE public.defter_tur OWNER TO postgres;

--
-- Name: defterler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.defterler (
    defter_id integer NOT NULL,
    defter_ad character(50) NOT NULL,
    defterfiyat real
);


ALTER TABLE public.defterler OWNER TO postgres;

--
-- Name: diller; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diller (
    dil_no integer NOT NULL,
    dil_ad character(50) NOT NULL
);


ALTER TABLE public.diller OWNER TO postgres;

--
-- Name: il; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.il (
    ilkodu integer NOT NULL,
    il_adi character(50) NOT NULL
);


ALTER TABLE public.il OWNER TO postgres;

--
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    ilcekodu integer NOT NULL,
    ilce_adi character(50) NOT NULL
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- Name: kalem_tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kalem_tur (
    kalem_tur_id integer NOT NULL,
    kalem_tur_ad character(50) NOT NULL,
    kalem_id integer NOT NULL
);


ALTER TABLE public.kalem_tur OWNER TO postgres;

--
-- Name: kalemler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kalemler (
    kalem_id integer NOT NULL,
    kalem_ad character(50) NOT NULL,
    kalemfiyat real
);


ALTER TABLE public.kalemler OWNER TO postgres;

--
-- Name: kategoriler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategoriler (
    kategori_id integer NOT NULL,
    kategori character(50) NOT NULL
);


ALTER TABLE public.kategoriler OWNER TO postgres;

--
-- Name: kitaplar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kitaplar (
    kitap_id integer NOT NULL,
    kitap_ad character(50) NOT NULL,
    dil_no integer NOT NULL,
    kategori_id integer NOT NULL,
    sayfasayisi integer NOT NULL,
    stok character(20) NOT NULL,
    yayim_yili character(20) NOT NULL,
    cilttipi character(40) NOT NULL,
    kagitcinsi character(40) NOT NULL,
    yayinevleri_id integer NOT NULL,
    yazar_id integer,
    cevirmen_id integer,
    fiyat real
);


ALTER TABLE public.kitaplar OWNER TO postgres;

--
-- Name: oyunkategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oyunkategori (
    oyunkategori_id integer NOT NULL,
    oyunkategori_ad character(50) NOT NULL,
    oyun_id integer NOT NULL
);


ALTER TABLE public.oyunkategori OWNER TO postgres;

--
-- Name: oyunlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.oyunlar (
    oyun_id integer NOT NULL,
    oyun_ad character(50) NOT NULL,
    oyunfiyat real
);


ALTER TABLE public.oyunlar OWNER TO postgres;

--
-- Name: siparisler; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.siparisler (
    siparisno integer NOT NULL,
    kitap_id integer,
    defter_id integer,
    uyeno integer,
    kalem_id integer,
    oyun_id integer
);


ALTER TABLE public.siparisler OWNER TO postgres;

--
-- Name: uye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uye (
    uyeno integer NOT NULL,
    ad character(50) NOT NULL,
    soyad character(30) NOT NULL,
    unvan character(20) NOT NULL,
    adres character(150) NOT NULL,
    mail character(50) NOT NULL,
    telefon character(11) NOT NULL,
    ilcekodu integer NOT NULL,
    ilkodu integer NOT NULL
);


ALTER TABLE public.uye OWNER TO postgres;

--
-- Name: yayinevleri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yayinevleri (
    yayinevleri_id integer NOT NULL,
    yayinevleri_ad character(50) NOT NULL
);


ALTER TABLE public.yayinevleri OWNER TO postgres;

--
-- Name: yazarlar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yazarlar (
    yazar_id integer NOT NULL,
    yazar_ad character(60) NOT NULL,
    yazar_soyad character(30) NOT NULL,
    kitapadi character(40)
);


ALTER TABLE public.yazarlar OWNER TO postgres;

--
-- Name: UrunDegisikligiIzle kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."UrunDegisikligiIzle_kayitNo_seq"'::regclass);


--
-- Name: UrunDegisikligiIzle1 kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle1" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."UrunDegisikligiIzle1_kayitNo_seq"'::regclass);


--
-- Name: UrunDegisikligiIzle2 kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle2" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."UrunDegisikligiIzle2_kayitNo_seq"'::regclass);


--
-- Name: UrunDegisikligiIzle3 kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle3" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."UrunDegisikligiIzle3_kayitNo_seq"'::regclass);


--
-- Data for Name: UrunDegisikligiIzle; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."UrunDegisikligiIzle" VALUES
	(1, 1, 5, 100, '2021-12-14 21:25:26.562635'),
	(2, 1, 100, 25, '2021-12-14 22:00:24.648632');


--
-- Data for Name: UrunDegisikligiIzle1; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."UrunDegisikligiIzle1" VALUES
	(1, 1, 23, 100, '2021-12-14 21:39:18.018343'),
	(2, 1, 100, 60, '2021-12-14 21:59:47.913803');


--
-- Data for Name: UrunDegisikligiIzle2; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."UrunDegisikligiIzle2" VALUES
	(1, 1, 100, 2, '2021-12-14 21:58:22.934808'),
	(2, 1, 2, 25, '2021-12-14 21:58:56.083362');


--
-- Data for Name: UrunDegisikligiIzle3; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."UrunDegisikligiIzle3" VALUES
	(1, 1, 150, 50, '2021-12-14 22:22:15.394192');


--
-- Data for Name: cevirmenler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cevirmenler VALUES
	(1, 'sude                                              ', 'cakir                                             ', 'ingilizce                                         ');


--
-- Data for Name: defter_tur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.defter_tur VALUES
	(1, 'çizgili defter                                    ', 1),
	(2, 'kareli defter                                     ', 2),
	(3, 'kareli defter                                     ', 3),
	(4, 'çizgili defter                                    ', 4),
	(5, 'çizgisiz defter                                   ', 5),
	(6, 'çizgili defter                                    ', 6),
	(7, 'çizgisiz defter                                   ', 7);


--
-- Data for Name: defterler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.defterler VALUES
	(2, 'bookinzi okul defteri                             ', 5),
	(3, 'a5 okul defteri                                   ', 10),
	(4, 'a5 okul defteri                                   ', 10),
	(5, 'güzel yazı defteri                                ', 15),
	(6, 'müzik defteri                                     ', 10),
	(7, 'resim defteri                                     ', 20),
	(1, 'bookinzi okul defteri                             ', 25);


--
-- Data for Name: diller; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.diller VALUES
	(1, 'ingilizce                                         '),
	(2, 'almanca                                           '),
	(3, 'fransızca                                         '),
	(4, 'italyanca                                         ');


--
-- Data for Name: il; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.il VALUES
	(54, 'sakarya                                           '),
	(34, 'istanbul                                          ');


--
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ilce VALUES
	(1, 'adapazarı                                         ');


--
-- Data for Name: kalem_tur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kalem_tur VALUES
	(1, 'tükenmez kalem                                    ', 1),
	(2, 'tükenmez kalem                                    ', 2),
	(3, 'tükenmez kalem                                    ', 3),
	(4, 'kurşun kalem                                      ', 4),
	(5, 'keçeli kalem                                      ', 5),
	(6, 'keçeli kalem                                      ', 6);


--
-- Data for Name: kalemler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kalemler VALUES
	(2, 'scriks vintage                                    ', 200),
	(3, 'cross century                                     ', 251),
	(4, 'fibracolor bipunta                                ', 32),
	(5, 'faber castell çift uçlu keçeli                    ', 50),
	(6, 'lets fırça uçlu kalem                             ', 24),
	(1, 'cross3322                                         ', 60),
	(7, 'fee                                               ', 2);


--
-- Data for Name: kategoriler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kategoriler VALUES
	(1, 'edebiyat                                          '),
	(2, 'bilgisayar                                        '),
	(3, 'roman                                             '),
	(4, 'hukuk                                             '),
	(5, 'islam                                             ');


--
-- Data for Name: kitaplar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kitaplar VALUES
	(1, 'hayvan çiftliği                                   ', 1, 1, 20, 'var                 ', '2                   ', 'ciltli                                  ', 'kitap kağıdı                            ', 1, 1, 1, 25);


--
-- Data for Name: oyunkategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.oyunkategori VALUES
	(1, 'çocuk oyunları                                    ', 1),
	(2, 'büyükler için puzzle                              ', 2),
	(3, 'büyükler için puzzle                              ', 3),
	(4, 'geleneksel oyunlar                                ', 4),
	(5, 'geleneksel oyunlar                                ', 5),
	(6, 'geleneksel oyunlar                                ', 6);


--
-- Data for Name: oyunlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.oyunlar VALUES
	(2, 'kaplumbağa terbiyecisi1000 parça                  ', 140),
	(3, 'inci küpeli kız 1000 parça                        ', 140),
	(4, 'kelime üretme oyunu                               ', 250),
	(5, 'satranç                                           ', 100),
	(6, 'kızma birader                                     ', 150),
	(1, 'tabu                                              ', 50);


--
-- Data for Name: siparisler; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.siparisler VALUES
	(2, 1, 2, 1, 1, 1),
	(1, 1, 1, 1, 1, 1),
	(3, 1, 1, 2, 1, 1);


--
-- Data for Name: uye; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.uye VALUES
	(1, 'sude                                              ', 'çakır                         ', 'sude                ', 'karaman                                                                                                                                               ', 'sudecakir                                         ', '2          ', 1, 54),
	(2, 'selim                                             ', 'çakır                         ', 'selim               ', 'karaman mah                                                                                                                                           ', 'selimcakir                                        ', '5310560254 ', 1, 54);


--
-- Data for Name: yayinevleri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yayinevleri VALUES
	(1, 'can yayınları                                     '),
	(2, 'türkiye iş bankası kültür yayınları               '),
	(3, 'ithaki yayınları                                  '),
	(4, 'pegasus yayınları                                 '),
	(5, 'kırmızı kedi yayınevi                             '),
	(6, 'tudem yayınevi                                    '),
	(7, 'iz yayıncılık                                     ');


--
-- Data for Name: yazarlar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.yazarlar VALUES
	(1, 'sude                                                        ', 'cakir                         ', NULL),
	(2, 'drhgr                                                       ', 'rgegre                        ', 'rgeregr                                 ');


--
-- Name: UrunDegisikligiIzle1_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UrunDegisikligiIzle1_kayitNo_seq"', 2, true);


--
-- Name: UrunDegisikligiIzle2_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UrunDegisikligiIzle2_kayitNo_seq"', 2, true);


--
-- Name: UrunDegisikligiIzle3_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UrunDegisikligiIzle3_kayitNo_seq"', 1, true);


--
-- Name: UrunDegisikligiIzle_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UrunDegisikligiIzle_kayitNo_seq"', 2, true);


--
-- Name: UrunDegisikligiIzle PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle"
    ADD CONSTRAINT "PK" PRIMARY KEY ("kayitNo");


--
-- Name: UrunDegisikligiIzle1 PK1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle1"
    ADD CONSTRAINT "PK1" PRIMARY KEY ("kayitNo");


--
-- Name: UrunDegisikligiIzle2 PK2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle2"
    ADD CONSTRAINT "PK2" PRIMARY KEY ("kayitNo");


--
-- Name: UrunDegisikligiIzle3 PK3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UrunDegisikligiIzle3"
    ADD CONSTRAINT "PK3" PRIMARY KEY ("kayitNo");


--
-- Name: cevirmenler cevirmenlerpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cevirmenler
    ADD CONSTRAINT cevirmenlerpk PRIMARY KEY (cevirmen_id);


--
-- Name: defterler defterlerpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defterler
    ADD CONSTRAINT defterlerpk PRIMARY KEY (defter_id);


--
-- Name: defter_tur defterturpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defter_tur
    ADD CONSTRAINT defterturpk PRIMARY KEY (defter_tur_id);


--
-- Name: diller dillerpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diller
    ADD CONSTRAINT dillerpk PRIMARY KEY (dil_no);


--
-- Name: ilce ilcepk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilcepk PRIMARY KEY (ilcekodu);


--
-- Name: il ilpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.il
    ADD CONSTRAINT ilpk PRIMARY KEY (ilkodu);


--
-- Name: kalemler kalemlerpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kalemler
    ADD CONSTRAINT kalemlerpk PRIMARY KEY (kalem_id);


--
-- Name: kalem_tur kalemturpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kalem_tur
    ADD CONSTRAINT kalemturpk PRIMARY KEY (kalem_tur_id);


--
-- Name: kategoriler kategorilerpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategoriler
    ADD CONSTRAINT kategorilerpk PRIMARY KEY (kategori_id);


--
-- Name: kitaplar kitaplar_cevirmen_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitaplar
    ADD CONSTRAINT kitaplar_cevirmen_id_key UNIQUE (cevirmen_id);


--
-- Name: kitaplar kitaplarpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitaplar
    ADD CONSTRAINT kitaplarpk PRIMARY KEY (kitap_id);


--
-- Name: oyunkategori oyunkategoripk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oyunkategori
    ADD CONSTRAINT oyunkategoripk PRIMARY KEY (oyunkategori_id);


--
-- Name: oyunlar oyunlarpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oyunlar
    ADD CONSTRAINT oyunlarpk PRIMARY KEY (oyun_id);


--
-- Name: siparisler siparisler_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparisler
    ADD CONSTRAINT siparisler_pkey PRIMARY KEY (siparisno);


--
-- Name: siparisler siparisler_siparisno_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparisler
    ADD CONSTRAINT siparisler_siparisno_key UNIQUE (siparisno);


--
-- Name: uye uyepk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uye
    ADD CONSTRAINT uyepk PRIMARY KEY (uyeno);


--
-- Name: uye uyeunique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uye
    ADD CONSTRAINT uyeunique UNIQUE (unvan);


--
-- Name: yayinevleri yayinevleripk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yayinevleri
    ADD CONSTRAINT yayinevleripk PRIMARY KEY (yayinevleri_id);


--
-- Name: yazarlar yazarlarpk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yazarlar
    ADD CONSTRAINT yazarlarpk PRIMARY KEY (yazar_id);


--
-- Name: defterler urunBirimFiyatDegistiginde; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "urunBirimFiyatDegistiginde" BEFORE UPDATE ON public.defterler FOR EACH ROW EXECUTE FUNCTION public."urunDegisikligi1"();


--
-- Name: kalemler urunBirimFiyatDegistiginde1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "urunBirimFiyatDegistiginde1" BEFORE UPDATE ON public.kalemler FOR EACH ROW EXECUTE FUNCTION public."urunDegisikligi2"();


--
-- Name: kitaplar urunBirimFiyatDegistiginde2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "urunBirimFiyatDegistiginde2" BEFORE UPDATE ON public.kitaplar FOR EACH ROW EXECUTE FUNCTION public."urunDegisikligi3"();


--
-- Name: oyunlar urunBirimFiyatDegistiginde3; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "urunBirimFiyatDegistiginde3" BEFORE UPDATE ON public.oyunlar FOR EACH ROW EXECUTE FUNCTION public."urunDegisikligi4"();


--
-- Name: defter_tur defterturfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.defter_tur
    ADD CONSTRAINT defterturfk FOREIGN KEY (defter_id) REFERENCES public.defterler(defter_id);


--
-- Name: siparisler fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparisler
    ADD CONSTRAINT fk FOREIGN KEY (uyeno) REFERENCES public.uye(uyeno);


--
-- Name: kalem_tur kalemturfk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kalem_tur
    ADD CONSTRAINT kalemturfk FOREIGN KEY (kalem_id) REFERENCES public.kalemler(kalem_id);


--
-- Name: kitaplar kitaplarfk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitaplar
    ADD CONSTRAINT kitaplarfk2 FOREIGN KEY (dil_no) REFERENCES public.diller(dil_no);


--
-- Name: kitaplar kitaplarfk3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitaplar
    ADD CONSTRAINT kitaplarfk3 FOREIGN KEY (kategori_id) REFERENCES public.kategoriler(kategori_id);


--
-- Name: kitaplar kitaplarfk4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitaplar
    ADD CONSTRAINT kitaplarfk4 FOREIGN KEY (yazar_id) REFERENCES public.yazarlar(yazar_id);


--
-- Name: oyunkategori oyunkategorifk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.oyunkategori
    ADD CONSTRAINT oyunkategorifk FOREIGN KEY (oyun_id) REFERENCES public.oyunlar(oyun_id);


--
-- Name: cevirmenler public.cevirmenler.yeni; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cevirmenler
    ADD CONSTRAINT "public.cevirmenler.yeni" FOREIGN KEY (cevirmen_id) REFERENCES public.kitaplar(cevirmen_id) MATCH FULL;


--
-- Name: siparisler siparislerfk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparisler
    ADD CONSTRAINT siparislerfk1 FOREIGN KEY (kalem_id) REFERENCES public.kalemler(kalem_id);


--
-- Name: siparisler siparislerfk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparisler
    ADD CONSTRAINT siparislerfk2 FOREIGN KEY (oyun_id) REFERENCES public.oyunlar(oyun_id);


--
-- Name: uye uyefk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uye
    ADD CONSTRAINT uyefk1 FOREIGN KEY (ilkodu) REFERENCES public.il(ilkodu);


--
-- Name: uye uyefk2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uye
    ADD CONSTRAINT uyefk2 FOREIGN KEY (ilcekodu) REFERENCES public.ilce(ilcekodu);


--
-- Name: kitaplar yayinevlerifk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kitaplar
    ADD CONSTRAINT yayinevlerifk FOREIGN KEY (yayinevleri_id) REFERENCES public.yayinevleri(yayinevleri_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: siparisler yeni1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparisler
    ADD CONSTRAINT yeni1 FOREIGN KEY (kitap_id) REFERENCES public.kitaplar(kitap_id);


--
-- Name: siparisler yeni2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siparisler
    ADD CONSTRAINT yeni2 FOREIGN KEY (defter_id) REFERENCES public.defterler(defter_id);


--
-- PostgreSQL database dump complete
--

