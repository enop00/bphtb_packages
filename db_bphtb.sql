--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.8
-- Dumped by pg_dump version 9.4.8
-- Started on 2016-12-12 17:28:49

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 7 (class 2615 OID 69440)
-- Name: bphtb; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA bphtb;


ALTER SCHEMA bphtb OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 69441)
-- Name: pbb; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pbb;


ALTER SCHEMA pbb OWNER TO postgres;

--
-- TOC entry 1 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2677 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = bphtb, pg_catalog;

--
-- TOC entry 269 (class 1255 OID 69442)
-- Name: get_approvalno(bigint); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_approvalno(id bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare no_out character varying;
begin

 --irul

select tahun||'.'||lpad(kode,2,'0')||'.'||lpad(no_urut::text,6,'0') into no_out
from bphtb_approval_final
where bphtb_approval_final.approval_id=$1;

return no_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_approvalno(id bigint) OWNER TO postgres;

--
-- TOC entry 270 (class 1255 OID 69443)
-- Name: get_berkaskeluarno(bigint); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_berkaskeluarno(id bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare no_out character varying;
begin

 --irul

select tahun||'.'||lpad(kode,2,'0')||'.'||lpad(no_urut::text,6,'0') into no_out
from bphtb_berkas_out
where bphtb_berkas_out.id=$1;

return no_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_berkaskeluarno(id bigint) OWNER TO postgres;

--
-- TOC entry 271 (class 1255 OID 69444)
-- Name: get_berkasmasukno(bigint); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_berkasmasukno(id bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare no_out character varying;
begin

 --irul

select tahun||'.'||lpad(kode,2,'0')||'.'||lpad(no_urut::text,6,'0') into no_out
from bphtb_berkas_in
where bphtb_berkas_in.id=$1;

return no_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_berkasmasukno(id bigint) OWNER TO postgres;

--
-- TOC entry 272 (class 1255 OID 69445)
-- Name: get_bulan(integer, boolean); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_bulan(bulan integer, short boolean) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
DECLARE 
  bulan_out character varying;
begin

if $2 then
  if bulan=1 then 
    bulan_out:='Jan ';
  elseif bulan=2 then 
    bulan_out:='Peb ';
  elseif bulan=3 then 
    bulan_out:='Mar ';
  elseif bulan=4 then 
    bulan_out:='Apr ';
  elseif bulan=5 then 
    bulan_out:='Mei ';
  elseif bulan=6 then 
    bulan_out:='Jun ';
  elseif bulan=7 then 
    bulan_out:='Jul ';
  elseif bulan=8 then 
    bulan_out:='Agt ';
  elseif bulan=9 then 
    bulan_out:='Sep ';
  elseif bulan=10 then 
    bulan_out:='Okt ';
  elseif bulan=11 then 
    bulan_out:='Nop ';
  elseif bulan=12 then 
    bulan_out:='Des ';
  end if;
else
  if bulan=1 then 
    bulan_out:='Januari ';
  elseif bulan=2 then 
    bulan_out:='Pebruari ';
  elseif bulan=3 then 
    bulan_out:='Maret ';
  elseif bulan=4 then 
    bulan_out:='April ';
  elseif bulan=5 then 
    bulan_out:='Mei ' ;
  elseif bulan=6 then 
    bulan_out:='Juni ';
  elseif bulan=7 then 
    bulan_out:='Juli ';
  elseif bulan=8 then 
    bulan_out:='Agustus ';
  elseif bulan=9 then 
    bulan_out:='September ';
  elseif bulan=10 then 
    bulan_out:='Oktober ';
  elseif bulan=11 then 
    bulan_out:='Nopember ';
  elseif bulan=12 then 
    bulan_out:='Desember ';
  end if;
end if;

return bulan_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_bulan(bulan integer, short boolean) OWNER TO postgres;

--
-- TOC entry 273 (class 1255 OID 69446)
-- Name: get_nop_bank(bigint, boolean); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_nop_bank(id bigint, formatted boolean) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare nop_out character varying;
begin

 --irul
 --NOP: 32.79.010.004.007-0061.0
 --source: bphtb_bank, bphtb_sspd

if $2 then

select kd_propinsi||'.'||kd_dati2||'.'||kd_kecamatan||'.'||kd_kelurahan||'.'||kd_blok||'-'||no_urut||'.'||kd_jns_op into nop_out
from bphtb_bank
where bphtb_bank.id=$1;

else

select kd_propinsi||kd_dati2||kd_kecamatan||kd_kelurahan||kd_blok||no_urut||kd_jns_op into nop_out
from bphtb_bank
where bphtb_bank.id=$1;

end if;

return nop_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_nop_bank(id bigint, formatted boolean) OWNER TO postgres;

--
-- TOC entry 274 (class 1255 OID 69447)
-- Name: get_nop_sspd(bigint, boolean); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_nop_sspd(id bigint, formatted boolean) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare nop_out character varying;
begin

 --irul
 --NOP: 32.79.010.004.007-0061.0
 --source: bphtb_bank, bphtb_sspd

if $2 then

select kd_propinsi||'.'||kd_dati2||'.'||kd_kecamatan||'.'||kd_kelurahan||'.'||kd_blok||'-'||no_urut||'.'||kd_jns_op into nop_out
from bphtb_sspd
where bphtb_sspd.id=$1;

else

select kd_propinsi||kd_dati2||kd_kecamatan||kd_kelurahan||kd_blok||no_urut||kd_jns_op into nop_out
from bphtb_sspd
where bphtb_sspd.id=$1;

end if;

return nop_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_nop_sspd(id bigint, formatted boolean) OWNER TO postgres;

--
-- TOC entry 275 (class 1255 OID 69448)
-- Name: get_nop_thn_bank(bigint, boolean); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_nop_thn_bank(id bigint, formatted boolean) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare nop_out character varying;
begin

 --irul
 --NOP: 32.79.010.004.007-0061.0:2014
 --source: bphtb_bank, bphtb_sspd

if $2 then

select kd_propinsi||'.'||kd_dati2||'.'||kd_kecamatan||'.'||kd_kelurahan||'.'||kd_blok||'-'||no_urut||'.'||kd_jns_op||'.'||thn_pajak_sppt into nop_out
from bphtb_bank
where bphtb_bank.id=$1;

else

select kd_propinsi||kd_dati2||kd_kecamatan||kd_kelurahan||kd_blok||no_urut||kd_jns_op||thn_pajak_sppt into nop_out
from bphtb_bank
where bphtb_bank.id=$1;

end if;

return nop_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_nop_thn_bank(id bigint, formatted boolean) OWNER TO postgres;

--
-- TOC entry 276 (class 1255 OID 69449)
-- Name: get_nop_thn_sspd(bigint, boolean); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_nop_thn_sspd(id bigint, formatted boolean) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare nop_out character varying;
begin

 --irul
 --NOP: 32.79.010.004.007-0061.0:2014
 --source: bphtb_bank, bphtb_sspd

if $2 then

select kd_propinsi||'.'||kd_dati2||'.'||kd_kecamatan||'.'||kd_kelurahan||'.'||kd_blok||'-'||no_urut||'.'||kd_jns_op||'.'||thn_pajak_sppt into nop_out
from bphtb_sspd
where bphtb_sspd.id=$1;

else

select kd_propinsi||kd_dati2||kd_kecamatan||kd_kelurahan||kd_blok||no_urut||kd_jns_op||thn_pajak_sppt into nop_out
from bphtb_sspd
where bphtb_sspd.id=$1;

end if;

return nop_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_nop_thn_sspd(id bigint, formatted boolean) OWNER TO postgres;

--
-- TOC entry 277 (class 1255 OID 69450)
-- Name: get_sspd_approvalno(bigint); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_sspd_approvalno(id bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare no_out character varying;
begin

 --irul

select tahun||'.'||lpad(kode,2,'0')||'.'||lpad(no_urut::text,6,'0') into no_out
from bphtb_sspd_approval 
where bphtb_sspd_approval.id=$1;

return no_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_sspd_approvalno(id bigint) OWNER TO postgres;

--
-- TOC entry 278 (class 1255 OID 69451)
-- Name: get_sspdno(bigint); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION get_sspdno(id bigint) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare sspd_out character varying;
begin

 --irul
 --SSPDNO: 32.79.2014.333.22.123456 ->mubazir
 --SSPDNO: 32792014333-22.123456    ->mubazir

-- select kd_propinsi||'.'||kd_dati2||'.'||tahun||'.'||lpad(ppat_id::text,3,'0')||'-'||lpad(kode,2,'0')||'.'||lpad(no_sspd::text,6,'0') into sspd_out
select tahun||'.'||lpad(kode,2,'0')||'.'||lpad(no_sspd::text,6,'0') into sspd_out
from bphtb_sspd 
where bphtb_sspd.id=$1;

return sspd_out;
   
end
$_$;


ALTER FUNCTION bphtb.get_sspdno(id bigint) OWNER TO postgres;

--
-- TOC entry 279 (class 1255 OID 69452)
-- Name: str_status(integer); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION str_status(num integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare status_out character varying;
begin

 --irul
 --status: sudah/belum

select case when num=0 then 'BELUM' when num=1 then 'SUDAH' else 'Unknown' end into status_out;
return status_out;
   
end
$$;


ALTER FUNCTION bphtb.str_status(num integer) OWNER TO postgres;

--
-- TOC entry 280 (class 1255 OID 69453)
-- Name: str_status_daftar(integer); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION str_status_daftar(num integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare status_out character varying;
begin

-- irul
/*
STATUS DAFTAR:
0 = 'Draft';
1 = 'Bayar';
2 = 'Approval';
3 = 'Penelitian';
4 = 'SKPD-KB';
5 = 'SKPD-LB';
6 = 'BPN';
7 = 'Selesai';    
*/

select case 
  when num=0 then 'Draft' 
  when num=2 then 'Bayar' 
  when num=3 then 'Approval' 
  when num=4 then 'Penelitian' 
  when num=5 then 'SKPD-KB' 
  when num=6 then 'SKPD-LB' 
  when num=7 then 'Selesai' 
  else 'Unknown' end 
into status_out;

return status_out;
   
end
$$;


ALTER FUNCTION bphtb.str_status_daftar(num integer) OWNER TO postgres;

--
-- TOC entry 281 (class 1255 OID 69454)
-- Name: str_status_validasi(integer); Type: FUNCTION; Schema: bphtb; Owner: postgres
--

CREATE FUNCTION str_status_validasi(num integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare status_out character varying;
begin

-- aagusti
/*
STATUS VALIDASI:
0 = 'Draft';
1 = 'Validated';
2 = 'Approved';   
*/

select case 
  when num=0 then 'Draft' 
  when num=1 then 'On Validated' 
  when num=2 then 'Approved'
  else 'Unknown' end 
into status_out;

return status_out;
   
end
$$;


ALTER FUNCTION bphtb.str_status_validasi(num integer) OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 282 (class 1255 OID 69455)
-- Name: f_bphtb_bank_bi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION f_bphtb_bank_bi() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
  new.kd_propinsi =substring(new.nop,1,2);
  new.kd_dati2    =substring(new.nop,3,2);
  new.kd_kecamatan=substring(new.nop,5,3);
  new.kd_kelurahan=substring(new.nop,8,3);
  new.kd_blok     =substring(new.nop,11,3);
  new.no_urut     =substring(new.nop,14,4);
  new.kd_jns_op   =substring(new.nop,18,1);
  new.thn_pajak_sppt =cast(new.tahun as varchar);
  
  return new;
end;$$;


ALTER FUNCTION public.f_bphtb_bank_bi() OWNER TO postgres;

--
-- TOC entry 283 (class 1255 OID 69456)
-- Name: f_bphtb_bank_bu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION f_bphtb_bank_bu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
  if new.nop<>old.nop and (old.kd_propinsi is null or old.kd_propinsi='' or
     old.nop=old.kd_propinsi||old.kd_dati2||old.kd_kecamatan||old.kd_kelurahan||old.kd_blok||old.no_urut||old.kd_jns_op) then
  
    new.kd_propinsi =substring(new.nop,1,2);
    new.kd_dati2    =substring(new.nop,3,2);
    new.kd_kecamatan=substring(new.nop,5,3);
    new.kd_kelurahan=substring(new.nop,8,3);
    new.kd_blok     =substring(new.nop,11,3);
    new.no_urut     =substring(new.nop,14,4);
    new.kd_jns_op   =substring(new.nop,18,1);
    --new.thn_pajak_sppt =cast(new.tahun as varchar);
  end if; 
  return new;
end;$$;


ALTER FUNCTION public.f_bphtb_bank_bu() OWNER TO postgres;

--
-- TOC entry 284 (class 1255 OID 69457)
-- Name: footgun(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION footgun(_schema text, _parttionbase text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    row     record;
BEGIN
    FOR row IN 
        SELECT
            table_schema,
            table_name
        FROM
            information_schema.tables
        WHERE
            table_type = 'BASE TABLE'
        AND
            table_schema = _schema
        AND
            table_name ILIKE (_parttionbase || '%')
    LOOP
       BEGIN
        EXECUTE 'DROP TABLE ' || quote_ident(row.table_schema) || '.' || quote_ident(row.table_name);
        RAISE INFO 'Dropped table: %', quote_ident(row.table_schema) || '.' || quote_ident(row.table_name);
       EXCEPTION when division_by_zero  then
        --RAISE INFO 'Cannot Dropped table: %', quote_ident(row.table_schema) || '.' || quote_ident(row.table_name);
       
       END;
    END LOOP;
END;
$$;


ALTER FUNCTION public.footgun(_schema text, _parttionbase text) OWNER TO postgres;

SET search_path = bphtb, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 175 (class 1259 OID 69458)
-- Name: app_status; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE app_status (
    id integer NOT NULL,
    tahun integer,
    app_id smallint,
    step character varying(25),
    operator smallint DEFAULT 0 NOT NULL,
    review smallint DEFAULT 0 NOT NULL,
    manager smallint DEFAULT 0 NOT NULL
);


ALTER TABLE app_status OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 69464)
-- Name: app_status_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE app_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE app_status_id_seq OWNER TO postgres;

--
-- TOC entry 2678 (class 0 OID 0)
-- Dependencies: 176
-- Name: app_status_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE app_status_id_seq OWNED BY app_status.id;


--
-- TOC entry 177 (class 1259 OID 69466)
-- Name: bphtb_alasan_pengurang; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_alasan_pengurang (
    id smallint NOT NULL,
    nama character varying(50) NOT NULL
);


ALTER TABLE bphtb_alasan_pengurang OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 69469)
-- Name: bphtb_approval; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_approval (
    id bigint NOT NULL,
    validasi_id bigint NOT NULL,
    tgl_approval timestamp without time zone DEFAULT now() NOT NULL,
    user_id integer,
    level_id integer DEFAULT 1,
    level integer DEFAULT 1,
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone
);


ALTER TABLE bphtb_approval OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 69476)
-- Name: bphtb_approval_final; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_approval_final (
    id bigint NOT NULL,
    approval_id bigint NOT NULL,
    tahun integer NOT NULL,
    kode character(1),
    no_urut bigint NOT NULL,
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone
);


ALTER TABLE bphtb_approval_final OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 69480)
-- Name: bphtb_approval_final_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_approval_final_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_approval_final_id_seq OWNER TO postgres;

--
-- TOC entry 2679 (class 0 OID 0)
-- Dependencies: 180
-- Name: bphtb_approval_final_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_approval_final_id_seq OWNED BY bphtb_approval_final.id;


--
-- TOC entry 181 (class 1259 OID 69482)
-- Name: bphtb_approval_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_approval_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_approval_id_seq OWNER TO postgres;

--
-- TOC entry 2680 (class 0 OID 0)
-- Dependencies: 181
-- Name: bphtb_approval_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_approval_id_seq OWNED BY bphtb_approval.id;


--
-- TOC entry 182 (class 1259 OID 69484)
-- Name: bphtb_bank; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_bank (
    id bigint NOT NULL,
    tanggal date NOT NULL,
    jam time without time zone NOT NULL,
    seq bigint NOT NULL,
    transno character varying(20) NOT NULL,
    cabang character varying(5),
    users character varying(5),
    bankid integer NOT NULL,
    txs character varying(5) NOT NULL,
    sspd_id bigint,
    nop character varying(50) NOT NULL,
    tahun integer,
    kd_propinsi character varying(2),
    kd_dati2 character varying(2),
    kd_kecamatan character varying(3),
    kd_kelurahan character varying(3),
    kd_blok character varying(3),
    no_urut character varying(4),
    kd_jns_op character varying(1),
    thn_pajak_sppt character varying(4),
    wp_nama character varying(50) NOT NULL,
    wp_alamat character varying(100),
    wp_blok_kav character varying(100),
    wp_rt character varying(3),
    wp_rw character varying(3),
    wp_kelurahan character varying(30),
    wp_kecamatan character varying(30),
    wp_kota character varying(30),
    wp_provinsi character varying(50),
    wp_kdpos character varying(5),
    wp_identitas character varying(50),
    wp_identitaskd character varying(50),
    wp_npwp character varying(50),
    notaris character varying(50),
    bumi_luas integer,
    bumi_njop bigint,
    bng_luas integer,
    bng_njop bigint,
    npop bigint,
    bayar bigint,
    denda integer,
    bphtbjeniskd integer,
    is_validated smallint DEFAULT 0,
    no_tagihan character varying(50),
    catatan character varying(255),
    kd_kanwil character varying(2),
    kd_kantor character varying(2),
    kd_bank_tunggal character varying(2),
    kd_bank_persepsi character varying(2),
    wp_propinsi character varying(100),
    pembayaran_ke smallint DEFAULT 1 NOT NULL
);


ALTER TABLE bphtb_bank OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 69492)
-- Name: bphtb_bank_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_bank_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_bank_id_seq OWNER TO postgres;

--
-- TOC entry 2681 (class 0 OID 0)
-- Dependencies: 183
-- Name: bphtb_bank_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_bank_id_seq OWNED BY bphtb_bank.id;


--
-- TOC entry 184 (class 1259 OID 69494)
-- Name: bphtb_berkas_in; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_berkas_in (
    id bigint NOT NULL,
    tahun integer NOT NULL,
    kode character(1) DEFAULT 'A'::bpchar NOT NULL,
    no_urut bigint NOT NULL,
    tgl_terima date,
    tgl_selesai date,
    notes character varying(100),
    pengirim character varying(50),
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now(),
    updated timestamp without time zone DEFAULT now(),
    ppat_id integer
);


ALTER TABLE bphtb_berkas_in OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 69500)
-- Name: bphtb_berkas_in_det; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_berkas_in_det (
    id bigint NOT NULL,
    berkas_in_id bigint,
    sspd_id bigint,
    sspd_no bigint,
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kd_blok character(3) NOT NULL,
    no_urut character(4) NOT NULL,
    kd_jns_op character(1) NOT NULL,
    thn_pajak_sppt character(4) NOT NULL,
    nominal bigint DEFAULT 0
);


ALTER TABLE bphtb_berkas_in_det OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 69504)
-- Name: bphtb_berkas_in_det_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_berkas_in_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_berkas_in_det_id_seq OWNER TO postgres;

--
-- TOC entry 2682 (class 0 OID 0)
-- Dependencies: 186
-- Name: bphtb_berkas_in_det_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_berkas_in_det_id_seq OWNED BY bphtb_berkas_in_det.id;


--
-- TOC entry 187 (class 1259 OID 69506)
-- Name: bphtb_berkas_in_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_berkas_in_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_berkas_in_id_seq OWNER TO postgres;

--
-- TOC entry 2683 (class 0 OID 0)
-- Dependencies: 187
-- Name: bphtb_berkas_in_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_berkas_in_id_seq OWNED BY bphtb_berkas_in.id;


--
-- TOC entry 188 (class 1259 OID 69508)
-- Name: bphtb_berkas_out; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_berkas_out (
    id bigint NOT NULL,
    tahun integer NOT NULL,
    kode character(1) DEFAULT 'A'::bpchar NOT NULL,
    no_urut bigint NOT NULL,
    tgl_keluar date,
    notes character varying(100),
    penerima character varying(50),
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now(),
    updated timestamp without time zone DEFAULT now(),
    ppat_id integer
);


ALTER TABLE bphtb_berkas_out OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 69514)
-- Name: bphtb_berkas_out_det; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_berkas_out_det (
    id bigint NOT NULL,
    berkas_out_id bigint,
    berkas_in_det_id bigint
);


ALTER TABLE bphtb_berkas_out_det OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 69517)
-- Name: bphtb_berkas_out_det_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_berkas_out_det_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_berkas_out_det_id_seq OWNER TO postgres;

--
-- TOC entry 2684 (class 0 OID 0)
-- Dependencies: 190
-- Name: bphtb_berkas_out_det_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_berkas_out_det_id_seq OWNED BY bphtb_berkas_out_det.id;


--
-- TOC entry 191 (class 1259 OID 69519)
-- Name: bphtb_berkas_out_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_berkas_out_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_berkas_out_id_seq OWNER TO postgres;

--
-- TOC entry 2685 (class 0 OID 0)
-- Dependencies: 191
-- Name: bphtb_berkas_out_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_berkas_out_id_seq OWNED BY bphtb_berkas_out.id;


--
-- TOC entry 192 (class 1259 OID 69521)
-- Name: bphtb_bpn; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_bpn (
    id bigint NOT NULL,
    bank_id bigint,
    sspd_id bigint,
    validasi_id bigint,
    tgl_proses date,
    tgl_selesai date,
    status smallint
);


ALTER TABLE bphtb_bpn OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 69524)
-- Name: bphtb_bpn_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_bpn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_bpn_id_seq OWNER TO postgres;

--
-- TOC entry 2686 (class 0 OID 0)
-- Dependencies: 193
-- Name: bphtb_bpn_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_bpn_id_seq OWNED BY bphtb_bpn.id;


--
-- TOC entry 194 (class 1259 OID 69526)
-- Name: bphtb_channel; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_channel (
    id integer NOT NULL,
    nama character varying(20) NOT NULL
);


ALTER TABLE bphtb_channel OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 69529)
-- Name: bphtb_channel_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_channel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_channel_id_seq OWNER TO postgres;

--
-- TOC entry 2687 (class 0 OID 0)
-- Dependencies: 195
-- Name: bphtb_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_channel_id_seq OWNED BY bphtb_channel.id;


--
-- TOC entry 196 (class 1259 OID 69531)
-- Name: bphtb_dasar; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_dasar (
    id smallint NOT NULL,
    nama character varying(50) NOT NULL
);


ALTER TABLE bphtb_dasar OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 69534)
-- Name: bphtb_hukum; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_hukum (
    id smallint NOT NULL,
    nama character varying(50) NOT NULL,
    uraian character varying(50) NOT NULL
);


ALTER TABLE bphtb_hukum OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 69537)
-- Name: bphtb_inquiry; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_inquiry (
    id integer NOT NULL,
    tgl timestamp without time zone NOT NULL,
    invoice_id bigint NOT NULL,
    transmission timestamp without time zone NOT NULL,
    stan integer NOT NULL,
    settlement date NOT NULL,
    bank_id integer NOT NULL,
    channel_id integer NOT NULL
);


ALTER TABLE bphtb_inquiry OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 69540)
-- Name: bphtb_inquiry_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_inquiry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_inquiry_id_seq OWNER TO postgres;

--
-- TOC entry 2688 (class 0 OID 0)
-- Dependencies: 199
-- Name: bphtb_inquiry_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_inquiry_id_seq OWNED BY bphtb_inquiry.id;


--
-- TOC entry 200 (class 1259 OID 69542)
-- Name: bphtb_pasar; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_pasar (
    id bigint NOT NULL,
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kd_blok character(3) NOT NULL,
    no_urut smallint NOT NULL,
    uraian character varying(100),
    harga bigint
);


ALTER TABLE bphtb_pasar OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 69545)
-- Name: bphtb_pasar_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_pasar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_pasar_id_seq OWNER TO postgres;

--
-- TOC entry 2689 (class 0 OID 0)
-- Dependencies: 201
-- Name: bphtb_pasar_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_pasar_id_seq OWNED BY bphtb_pasar.id;


--
-- TOC entry 202 (class 1259 OID 69547)
-- Name: bphtb_pejabat; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_pejabat (
    id integer NOT NULL,
    nip character varying(18) NOT NULL,
    kd_jabatan character(2) NOT NULL,
    nama character varying(50) NOT NULL,
    enabled smallint DEFAULT 0 NOT NULL,
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE bphtb_pejabat OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 69553)
-- Name: bphtb_pejabat_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_pejabat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_pejabat_id_seq OWNER TO postgres;

--
-- TOC entry 2690 (class 0 OID 0)
-- Dependencies: 203
-- Name: bphtb_pejabat_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_pejabat_id_seq OWNED BY bphtb_pejabat.id;


--
-- TOC entry 204 (class 1259 OID 69555)
-- Name: bphtb_perolehan; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_perolehan (
    id integer NOT NULL,
    nama character varying(100) NOT NULL,
    npoptkp bigint DEFAULT 60000000 NOT NULL,
    pengurang smallint DEFAULT 0,
    singkatan character varying(20)
);


ALTER TABLE bphtb_perolehan OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 69560)
-- Name: bphtb_ppat; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_ppat (
    id integer NOT NULL,
    kode character varying(6),
    nama character varying(50),
    alamat character varying(50),
    kelurahan character varying(50),
    kecamatan character varying(50),
    kota character varying(50),
    wilayah_kerja character varying(50),
    kd_wilayah character varying(4),
    no_telp character varying(20),
    no_fax character varying(20),
    no_sk character varying(30),
    tgl_sk date,
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now(),
    updated timestamp without time zone DEFAULT now(),
    npwp character varying(20),
    pejabat_id integer
);


ALTER TABLE bphtb_ppat OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 69565)
-- Name: bphtb_ppat_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_ppat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_ppat_id_seq OWNER TO postgres;

--
-- TOC entry 2691 (class 0 OID 0)
-- Dependencies: 206
-- Name: bphtb_ppat_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_ppat_id_seq OWNED BY bphtb_ppat.id;


--
-- TOC entry 207 (class 1259 OID 69567)
-- Name: bphtb_sk; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_sk (
    id bigint NOT NULL,
    validasi_id bigint NOT NULL,
    tahun integer NOT NULL,
    kode character(1) NOT NULL,
    no_urut bigint NOT NULL,
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE bphtb_sk OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 69572)
-- Name: bphtb_sk_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_sk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_sk_id_seq OWNER TO postgres;

--
-- TOC entry 2692 (class 0 OID 0)
-- Dependencies: 208
-- Name: bphtb_sk_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_sk_id_seq OWNED BY bphtb_sk.id;


--
-- TOC entry 209 (class 1259 OID 69574)
-- Name: bphtb_sspd; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_sspd (
    id bigint NOT NULL,
    tahun integer NOT NULL,
    kode character(1) NOT NULL,
    no_sspd bigint NOT NULL,
    ppat_id integer,
    wp_nama character varying(50) NOT NULL,
    wp_npwp character varying(50) NOT NULL,
    wp_alamat character varying(100) NOT NULL,
    wp_blok_kav character varying(100) NOT NULL,
    wp_kelurahan character varying(30) NOT NULL,
    wp_rt character varying(3) NOT NULL,
    wp_rw character varying(3) NOT NULL,
    wp_kecamatan character varying(30) NOT NULL,
    wp_kota character varying(30) NOT NULL,
    wp_provinsi character varying(30) NOT NULL,
    wp_identitas character varying(50) NOT NULL,
    wp_identitaskd character varying(50),
    tgl_transaksi date NOT NULL,
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kd_blok character(3) NOT NULL,
    no_urut character(4) NOT NULL,
    kd_jns_op character(1) NOT NULL,
    thn_pajak_sppt character(4) NOT NULL,
    op_alamat character varying(100) NOT NULL,
    op_blok_kav character varying(100) NOT NULL,
    op_rt character varying(3) NOT NULL,
    op_rw character varying(3) NOT NULL,
    bumi_luas bigint NOT NULL,
    bumi_njop bigint NOT NULL,
    bng_luas bigint NOT NULL,
    bng_njop bigint NOT NULL,
    no_sertifikat character varying(30),
    njop bigint NOT NULL,
    perolehan_id integer NOT NULL,
    npop bigint NOT NULL,
    npoptkp bigint NOT NULL,
    tarif double precision NOT NULL,
    terhutang bigint NOT NULL,
    bagian smallint DEFAULT 1 NOT NULL,
    pembagi smallint DEFAULT 1 NOT NULL,
    tarif_pengurang smallint DEFAULT 0 NOT NULL,
    pengurang bigint NOT NULL,
    bphtb_sudah_dibayarkan bigint DEFAULT 0 NOT NULL,
    denda bigint DEFAULT 0 NOT NULL,
    restitusi bigint DEFAULT 0 NOT NULL,
    bphtb_harus_dibayarkan bigint DEFAULT 0 NOT NULL,
    status_pembayaran smallint DEFAULT 0 NOT NULL,
    dasar_id smallint DEFAULT 0 NOT NULL,
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    header_id bigint DEFAULT 0 NOT NULL,
    tgl_print timestamp without time zone,
    tgl_approval timestamp without time zone,
    file1 character varying(150),
    file2 character varying(150),
    file3 character varying(150),
    file4 character varying(150),
    file5 character varying(150),
    wp_kdpos character(5) DEFAULT ''::bpchar,
    file6 character varying(150),
    file7 character varying(150),
    file8 character varying(150),
    file9 character varying(150),
    file10 character varying(150),
    keterangan character varying(100),
    status_daftar smallint DEFAULT 0,
    persen_pengurang_sendiri integer DEFAULT 0,
    pp_nomor_pengurang_sendiri character(50),
    no_ajb character varying(50),
    tgl_ajb timestamp without time zone,
    wp_nama_asal character varying(50),
    jml_pph numeric,
    tgl_pph timestamp without time zone,
    posted smallint DEFAULT 0,
    pos_tp_id integer,
    status_validasi integer DEFAULT 0,
    status_bpn integer DEFAULT 0,
    tgl_jatuh_tempo timestamp without time zone,
    verifikasi_uid character varying(20),
    verifikasi_date timestamp without time zone,
    pbb_nop character varying(24),
    verifikasi_bphtb_uid character varying(20),
    verifikasi_bphtb_date timestamp without time zone,
    hasil_penelitian character varying(20) DEFAULT 'Draft'::character varying,
    no_sk character varying(20),
    pengurangan_sk character varying(20),
    pengurangan_jatuh_tempo_tgl timestamp without time zone,
    pengurangan_sk_tgl timestamp without time zone,
    ketetapan_no character varying(20),
    ketetapan_tgl timestamp without time zone,
    ketetapan_atas_sspd_no character varying(20),
    ketetapan_jatuh_tempo_tgl timestamp without time zone,
    pembayaran_ke smallint DEFAULT 1 NOT NULL,
    mutasi_penuh integer DEFAULT 1,
    harga_transaksi bigint DEFAULT 0,
    npopkp bigint,
    npoptkp_sudah_didapat bigint DEFAULT 0,
    bng_luas_beban bigint DEFAULT 0,
    bng_njop_beban bigint DEFAULT 0,
    bumi_luas_beban bigint DEFAULT 0,
    bumi_njop_beban bigint DEFAULT 0
);


ALTER TABLE bphtb_sspd OWNER TO postgres;

--
-- TOC entry 2693 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.no_ajb; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.no_ajb IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2694 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.tgl_ajb; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.tgl_ajb IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2695 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.jml_pph; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.jml_pph IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2696 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.tgl_pph; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.tgl_pph IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2697 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.posted; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.posted IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2698 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.verifikasi_uid; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.verifikasi_uid IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2699 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.verifikasi_date; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.verifikasi_date IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2700 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.pbb_nop; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.pbb_nop IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2701 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.verifikasi_bphtb_uid; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.verifikasi_bphtb_uid IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2702 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.verifikasi_bphtb_date; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.verifikasi_bphtb_date IS 'dipake di pbb_bphtb aa';


--
-- TOC entry 2703 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.hasil_penelitian; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.hasil_penelitian IS 'Draft/Sesuai/Kurang Bayar/Lebih Bayar';


--
-- TOC entry 2704 (class 0 OID 0)
-- Dependencies: 209
-- Name: COLUMN bphtb_sspd.mutasi_penuh; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_sspd.mutasi_penuh IS 'mutasi penuh=1 (atau sebagian=0)';


--
-- TOC entry 210 (class 1259 OID 69607)
-- Name: bphtb_sspd_approval; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_sspd_approval (
    id bigint NOT NULL,
    sspd_id bigint NOT NULL,
    tahun integer NOT NULL,
    kode character(1) NOT NULL,
    no_urut bigint NOT NULL,
    tgl_approval timestamp without time zone DEFAULT now() NOT NULL,
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE bphtb_sspd_approval OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 69613)
-- Name: bphtb_sspd_approval_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_sspd_approval_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_sspd_approval_id_seq OWNER TO postgres;

--
-- TOC entry 2705 (class 0 OID 0)
-- Dependencies: 211
-- Name: bphtb_sspd_approval_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_sspd_approval_id_seq OWNED BY bphtb_sspd_approval.id;


--
-- TOC entry 212 (class 1259 OID 69615)
-- Name: bphtb_sspd_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_sspd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_sspd_id_seq OWNER TO postgres;

--
-- TOC entry 2706 (class 0 OID 0)
-- Dependencies: 212
-- Name: bphtb_sspd_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_sspd_id_seq OWNED BY bphtb_sspd.id;


--
-- TOC entry 213 (class 1259 OID 69617)
-- Name: bphtb_status_hak; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_status_hak (
    id smallint NOT NULL,
    nama character varying(50) NOT NULL,
    uraian character varying(50) NOT NULL
);


ALTER TABLE bphtb_status_hak OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 69620)
-- Name: bphtb_tp; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_tp (
    id integer NOT NULL,
    singkatan character varying(16) NOT NULL,
    nama character varying(30) NOT NULL
);


ALTER TABLE bphtb_tp OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 69623)
-- Name: bphtb_tp_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_tp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_tp_id_seq OWNER TO postgres;

--
-- TOC entry 2707 (class 0 OID 0)
-- Dependencies: 215
-- Name: bphtb_tp_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_tp_id_seq OWNED BY bphtb_tp.id;


--
-- TOC entry 216 (class 1259 OID 69625)
-- Name: bphtb_user; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_user (
    userid character varying(25),
    ppat_id integer,
    id integer NOT NULL
);


ALTER TABLE bphtb_user OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 69628)
-- Name: bphtb_user_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_user_id_seq OWNER TO postgres;

--
-- TOC entry 2708 (class 0 OID 0)
-- Dependencies: 217
-- Name: bphtb_user_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_user_id_seq OWNED BY bphtb_user.id;


--
-- TOC entry 218 (class 1259 OID 69630)
-- Name: bphtb_validasi; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_validasi (
    id bigint NOT NULL,
    berkas_in_id bigint,
    sspd_id bigint,
    ppat_id integer,
    wp_nama character varying(50) NOT NULL,
    wp_npwp character varying(50) NOT NULL,
    wp_alamat character varying(100) NOT NULL,
    wp_blok_kav character varying(100) NOT NULL,
    wp_kelurahan character varying(30) NOT NULL,
    wp_rt character varying(3) NOT NULL,
    wp_rw character varying(3) NOT NULL,
    wp_kecamatan character varying(30) NOT NULL,
    wp_kota character varying(30) NOT NULL,
    wp_provinsi character varying(30) NOT NULL,
    wp_identitas character varying(50) NOT NULL,
    wp_identitaskd character varying(50) NOT NULL,
    tgl_transaksi date NOT NULL,
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kd_blok character(3) NOT NULL,
    no_urut character(4) NOT NULL,
    kd_jns_op character(1) NOT NULL,
    thn_pajak_sppt character(4) NOT NULL,
    op_alamat character varying(100) NOT NULL,
    op_blok_kav character varying(100) NOT NULL,
    op_rt character varying(3) NOT NULL,
    op_rw character varying(3) NOT NULL,
    bumi_luas bigint NOT NULL,
    bumi_njop bigint NOT NULL,
    bng_luas bigint NOT NULL,
    bng_njop bigint NOT NULL,
    no_sertifikat character varying(30) NOT NULL,
    njop bigint NOT NULL,
    perolehan_id integer NOT NULL,
    npop bigint NOT NULL,
    npoptkp bigint NOT NULL,
    tarif double precision NOT NULL,
    terhutang bigint NOT NULL,
    bagian smallint DEFAULT 1 NOT NULL,
    pembagi smallint DEFAULT 1 NOT NULL,
    tarif_pengurang smallint DEFAULT 0 NOT NULL,
    pengurang bigint NOT NULL,
    bphtb_sudah_dibayarkan bigint DEFAULT 0 NOT NULL,
    denda bigint DEFAULT 0 NOT NULL,
    restitusi bigint DEFAULT 0 NOT NULL,
    bphtb_harus_dibayarkan bigint DEFAULT 0 NOT NULL,
    status_pembayaran smallint DEFAULT 0 NOT NULL,
    dasar_id smallint DEFAULT 0 NOT NULL,
    create_uid character varying(20),
    update_uid character varying(20),
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    header_id bigint DEFAULT 0 NOT NULL,
    bpn_tgl_terima date,
    bpn_tgl_selesai date,
    wp_kdpos character(5),
    bank_id bigint DEFAULT 0 NOT NULL,
    persen_pengurang_sendiri integer DEFAULT 0,
    pp_nomor_pengurang_sendiri character varying(50),
    mutasi_penuh integer DEFAULT 1,
    wp_nama_asal character varying(50),
    harga_transaksi bigint,
    npopkp bigint,
    npoptkp_sudah_didapat bigint DEFAULT 0,
    bng_luas_beban bigint DEFAULT 0,
    bng_njop_beban bigint DEFAULT 0,
    bumi_luas_beban bigint DEFAULT 0,
    bumi_njop_beban bigint DEFAULT 0
);


ALTER TABLE bphtb_validasi OWNER TO postgres;

--
-- TOC entry 2709 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN bphtb_validasi.mutasi_penuh; Type: COMMENT; Schema: bphtb; Owner: postgres
--

COMMENT ON COLUMN bphtb_validasi.mutasi_penuh IS 'mutasi penuh=1 (atau sebagian=0)';


--
-- TOC entry 219 (class 1259 OID 69656)
-- Name: bphtb_validasi_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_validasi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_validasi_id_seq OWNER TO postgres;

--
-- TOC entry 2710 (class 0 OID 0)
-- Dependencies: 219
-- Name: bphtb_validasi_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_validasi_id_seq OWNED BY bphtb_validasi.id;


--
-- TOC entry 220 (class 1259 OID 69658)
-- Name: bphtb_validasi_level; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_validasi_level (
    id integer NOT NULL,
    level integer,
    uraian character varying(20),
    min_value bigint,
    max_value bigint,
    level_id integer
);


ALTER TABLE bphtb_validasi_level OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 69661)
-- Name: bphtb_validasi_level_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_validasi_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_validasi_level_id_seq OWNER TO postgres;

--
-- TOC entry 2711 (class 0 OID 0)
-- Dependencies: 221
-- Name: bphtb_validasi_level_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_validasi_level_id_seq OWNED BY bphtb_validasi_level.id;


--
-- TOC entry 222 (class 1259 OID 69663)
-- Name: bphtb_validasi_level_kec; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_validasi_level_kec (
    id integer NOT NULL,
    level_id integer NOT NULL,
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    nm_kecamatan character varying(30) NOT NULL
);


ALTER TABLE bphtb_validasi_level_kec OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 69666)
-- Name: bphtb_validasi_level_kec_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_validasi_level_kec_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_validasi_level_kec_id_seq OWNER TO postgres;

--
-- TOC entry 2712 (class 0 OID 0)
-- Dependencies: 223
-- Name: bphtb_validasi_level_kec_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_validasi_level_kec_id_seq OWNED BY bphtb_validasi_level_kec.id;


--
-- TOC entry 224 (class 1259 OID 69668)
-- Name: bphtb_validasi_user; Type: TABLE; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_validasi_user (
    id integer NOT NULL,
    user_id integer,
    level_id integer
);


ALTER TABLE bphtb_validasi_user OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 69671)
-- Name: bphtb_validasi_user_id_seq; Type: SEQUENCE; Schema: bphtb; Owner: postgres
--

CREATE SEQUENCE bphtb_validasi_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bphtb_validasi_user_id_seq OWNER TO postgres;

--
-- TOC entry 2713 (class 0 OID 0)
-- Dependencies: 225
-- Name: bphtb_validasi_user_id_seq; Type: SEQUENCE OWNED BY; Schema: bphtb; Owner: postgres
--

ALTER SEQUENCE bphtb_validasi_user_id_seq OWNED BY bphtb_validasi_user.id;


SET search_path = pbb, pg_catalog;

--
-- TOC entry 226 (class 1259 OID 69673)
-- Name: dat_objek_pajak; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE dat_objek_pajak (
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kd_blok character(3) NOT NULL,
    no_urut character(4) NOT NULL,
    kd_jns_op character(1) NOT NULL,
    subjek_pajak_id character(30) NOT NULL,
    no_formulir_spop character(11) NOT NULL,
    no_persil character varying(5),
    jalan_op character varying(30) NOT NULL,
    blok_kav_no_op character varying(15),
    rw_op character(2),
    rt_op character(3),
    kd_status_cabang numeric(1,0) DEFAULT 1,
    kd_status_wp character(1) DEFAULT '1'::bpchar,
    total_luas_bumi numeric(12,0) DEFAULT 0,
    total_luas_bng numeric(12,0) DEFAULT 0,
    njop_bumi numeric(15,0) DEFAULT 0,
    njop_bng numeric(15,0) DEFAULT 0,
    status_peta_op numeric(1,0) DEFAULT 0,
    jns_transaksi_op character(1) DEFAULT '1'::bpchar,
    tgl_pendataan_op date NOT NULL,
    nip_pendata character(18) NOT NULL,
    tgl_pemeriksaan_op date NOT NULL,
    nip_pemeriksa_op character(18) NOT NULL,
    tgl_perekaman_op date DEFAULT '2013-03-29'::date,
    nip_perekam_op character(18) NOT NULL
);


ALTER TABLE dat_objek_pajak OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 69685)
-- Name: dat_subjek_pajak; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE dat_subjek_pajak (
    subjek_pajak_id character(30) NOT NULL,
    nm_wp character varying(30) DEFAULT 'pemilik'::character varying,
    jalan_wp character varying(30),
    blok_kav_no_wp character varying(15),
    rw_wp character(2),
    rt_wp character(3),
    kelurahan_wp character varying(30),
    kota_wp character varying(30),
    kd_pos_wp character varying(5),
    telp_wp character varying(20),
    npwp character varying(15),
    status_pekerjaan_wp character(1) DEFAULT '0'::bpchar,
    kecamatan_wp character varying(30),
    propinsi_wp character varying(30),
    CONSTRAINT dat_subjek_pajak_jalan_wp_check CHECK ((jalan_wp IS NOT NULL)),
    CONSTRAINT dat_subjek_pajak_nm_wp_check CHECK ((nm_wp IS NOT NULL)),
    CONSTRAINT dat_subjek_pajak_status_pekerjaan_wp_check CHECK ((status_pekerjaan_wp IS NOT NULL))
);


ALTER TABLE dat_subjek_pajak OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 69693)
-- Name: dph; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE dph (
    id bigint NOT NULL,
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kode character(3) NOT NULL,
    nama character varying(255),
    tgl_bayar timestamp without time zone DEFAULT now() NOT NULL,
    tgl_posting timestamp without time zone,
    status_posting integer,
    tahun character(4),
    pejabat1_id integer,
    pejabat2_id integer
);


ALTER TABLE dph OWNER TO postgres;

--
-- TOC entry 2714 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN dph.pejabat1_id; Type: COMMENT; Schema: pbb; Owner: postgres
--

COMMENT ON COLUMN dph.pejabat1_id IS 'look up ke tabl user';


--
-- TOC entry 2715 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN dph.pejabat2_id; Type: COMMENT; Schema: pbb; Owner: postgres
--

COMMENT ON COLUMN dph.pejabat2_id IS 'look up ke tabl user';


--
-- TOC entry 229 (class 1259 OID 69697)
-- Name: dph_id_seq; Type: SEQUENCE; Schema: pbb; Owner: postgres
--

CREATE SEQUENCE dph_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dph_id_seq OWNER TO postgres;

--
-- TOC entry 2716 (class 0 OID 0)
-- Dependencies: 229
-- Name: dph_id_seq; Type: SEQUENCE OWNED BY; Schema: pbb; Owner: postgres
--

ALTER SEQUENCE dph_id_seq OWNED BY dph.id;


--
-- TOC entry 230 (class 1259 OID 69699)
-- Name: dph_payment; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE dph_payment (
    id bigint NOT NULL,
    dph_id bigint,
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kd_blok character(3) NOT NULL,
    no_urut character(4) NOT NULL,
    kd_jns_op character(1) NOT NULL,
    thn_pajak_sppt character(4) NOT NULL,
    pembayaran_ke numeric(2,0) NOT NULL,
    denda numeric(12,0),
    jml_yg_dibayar numeric(15,0),
    tgl_rekam_byr date DEFAULT '2013-03-26'::date,
    nip_rekam_byr character(18)
);


ALTER TABLE dph_payment OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 69703)
-- Name: dph_payment_id_seq; Type: SEQUENCE; Schema: pbb; Owner: postgres
--

CREATE SEQUENCE dph_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dph_payment_id_seq OWNER TO postgres;

--
-- TOC entry 2717 (class 0 OID 0)
-- Dependencies: 231
-- Name: dph_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: pbb; Owner: postgres
--

ALTER SEQUENCE dph_payment_id_seq OWNED BY dph_payment.id;


--
-- TOC entry 232 (class 1259 OID 69705)
-- Name: pembayaran_sppt; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE pembayaran_sppt (
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kd_blok character(3) NOT NULL,
    no_urut character(4) NOT NULL,
    kd_jns_op character(1) NOT NULL,
    thn_pajak_sppt character(4) NOT NULL,
    pembayaran_sppt_ke integer NOT NULL,
    kd_kanwil_bank character(2),
    kd_kppbb_bank character(2),
    kd_bank_tunggal character(2),
    kd_bank_persepsi character(2),
    kd_tp character(2) NOT NULL,
    denda_sppt double precision,
    jml_sppt_yg_dibayar double precision NOT NULL,
    tgl_pembayaran_sppt date NOT NULL,
    tgl_rekam_byr_sppt timestamp without time zone NOT NULL,
    nip_rekam_byr_sppt character(18) NOT NULL,
    kd_kanwil character(2) NOT NULL,
    kd_kantor character(2) NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE pembayaran_sppt OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 69708)
-- Name: pembayaran_sppt_id_seq; Type: SEQUENCE; Schema: pbb; Owner: postgres
--

CREATE SEQUENCE pembayaran_sppt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pembayaran_sppt_id_seq OWNER TO postgres;

--
-- TOC entry 2718 (class 0 OID 0)
-- Dependencies: 233
-- Name: pembayaran_sppt_id_seq; Type: SEQUENCE OWNED BY; Schema: pbb; Owner: postgres
--

ALTER SEQUENCE pembayaran_sppt_id_seq OWNED BY pembayaran_sppt.id;


--
-- TOC entry 234 (class 1259 OID 69710)
-- Name: ref_dati2; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_dati2 (
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    nm_dati2 character varying(30) NOT NULL
);


ALTER TABLE ref_dati2 OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 69713)
-- Name: ref_jns_sektor; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_jns_sektor (
    kd_sektor character(2) NOT NULL,
    nm_sektor character varying(75) NOT NULL
);


ALTER TABLE ref_jns_sektor OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 69716)
-- Name: ref_kecamatan; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_kecamatan (
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    nm_kecamatan character varying(30) NOT NULL
);


ALTER TABLE ref_kecamatan OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 69719)
-- Name: ref_kelurahan; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_kelurahan (
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kd_sektor character(2) NOT NULL,
    nm_kelurahan character varying(30) NOT NULL,
    no_kelurahan integer,
    kd_pos_kelurahan character(5)
);


ALTER TABLE ref_kelurahan OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 69722)
-- Name: ref_propinsi; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_propinsi (
    kd_propinsi character(2) NOT NULL,
    nm_propinsi character varying(30) NOT NULL
);


ALTER TABLE ref_propinsi OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 69725)
-- Name: sppt; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE sppt (
    kd_propinsi character(2) NOT NULL,
    kd_dati2 character(2) NOT NULL,
    kd_kecamatan character(3) NOT NULL,
    kd_kelurahan character(3) NOT NULL,
    kd_blok character(3) NOT NULL,
    no_urut character(4) NOT NULL,
    kd_jns_op character(1) NOT NULL,
    thn_pajak_sppt character(4) NOT NULL,
    siklus_sppt integer NOT NULL,
    kd_kanwil_bank character(2),
    kd_kppbb_bank character(2),
    kd_bank_tunggal character(2),
    kd_bank_persepsi character(2),
    kd_tp character(2) NOT NULL,
    nm_wp_sppt character varying(30) NOT NULL,
    jln_wp_sppt character varying(30) NOT NULL,
    blok_kav_no_wp_sppt character varying(15),
    rw_wp_sppt character(2),
    rt_wp_sppt character(3),
    kelurahan_wp_sppt character varying(30),
    kota_wp_sppt character varying(30),
    kd_pos_wp_sppt character varying(5),
    npwp_sppt character varying(15),
    no_persil_sppt character varying(5),
    kd_kls_tanah character(3) DEFAULT 'XXX'::bpchar NOT NULL,
    thn_awal_kls_tanah character(4) DEFAULT '1986'::bpchar NOT NULL,
    kd_kls_bng character(3) DEFAULT 'XXX'::bpchar NOT NULL,
    thn_awal_kls_bng character(4) DEFAULT '1986'::bpchar NOT NULL,
    tgl_jatuh_tempo_sppt date NOT NULL,
    luas_bumi_sppt double precision NOT NULL,
    luas_bng_sppt double precision NOT NULL,
    njop_bumi_sppt double precision NOT NULL,
    njop_bng_sppt double precision NOT NULL,
    njop_sppt double precision NOT NULL,
    njoptkp_sppt integer NOT NULL,
    njkp_sppt integer,
    pbb_terhutang_sppt double precision NOT NULL,
    faktor_pengurang_sppt double precision,
    pbb_yg_harus_dibayar_sppt double precision NOT NULL,
    status_pembayaran_sppt character(1) DEFAULT '0'::bpchar NOT NULL,
    status_tagihan_sppt character(1) DEFAULT '0'::bpchar NOT NULL,
    status_cetak_sppt character(1) DEFAULT '0'::bpchar NOT NULL,
    tgl_terbit_sppt date NOT NULL,
    tgl_cetak_sppt timestamp without time zone NOT NULL,
    nip_pencetak_sppt character varying(18) NOT NULL,
    kd_kanwil character varying(2),
    kd_kantor character varying(2)
);


ALTER TABLE sppt OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 69735)
-- Name: tempat_pembayaran; Type: TABLE; Schema: pbb; Owner: postgres; Tablespace: 
--

CREATE TABLE tempat_pembayaran (
    kd_kanwil character(2) NOT NULL,
    kd_kantor character(2) NOT NULL,
    kd_tp character(2) NOT NULL,
    nm_tp character varying(30) NOT NULL,
    alamat_tp character varying(50) NOT NULL,
    no_rek_tp character varying(15) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE tempat_pembayaran OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 69738)
-- Name: tempat_pembayaran_id_seq; Type: SEQUENCE; Schema: pbb; Owner: postgres
--

CREATE SEQUENCE tempat_pembayaran_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tempat_pembayaran_id_seq OWNER TO postgres;

--
-- TOC entry 2719 (class 0 OID 0)
-- Dependencies: 241
-- Name: tempat_pembayaran_id_seq; Type: SEQUENCE OWNED BY; Schema: pbb; Owner: postgres
--

ALTER SEQUENCE tempat_pembayaran_id_seq OWNED BY tempat_pembayaran.id;


SET search_path = public, pg_catalog;

--
-- TOC entry 242 (class 1259 OID 69740)
-- Name: apps; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE apps (
    id integer NOT NULL,
    nama character varying(50),
    app_path character varying(50),
    disabled smallint DEFAULT 1
);


ALTER TABLE apps OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 69744)
-- Name: apps_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE apps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE apps_id_seq OWNER TO postgres;

--
-- TOC entry 2720 (class 0 OID 0)
-- Dependencies: 243
-- Name: apps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE apps_id_seq OWNED BY apps.id;


--
-- TOC entry 244 (class 1259 OID 69746)
-- Name: bphtb_payment; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_payment (
    id integer NOT NULL,
    tgl timestamp with time zone NOT NULL,
    iso_request character varying(1024) NOT NULL,
    transmission timestamp with time zone NOT NULL,
    settlement date NOT NULL,
    stan integer NOT NULL,
    invoice_id integer NOT NULL,
    invoice_no character varying(32) NOT NULL,
    ntb character varying(32) NOT NULL,
    ntp character varying(32) NOT NULL,
    bank_id integer,
    channel_id integer,
    bank_ip character varying(15) NOT NULL
);


ALTER TABLE bphtb_payment OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 69752)
-- Name: bphtb_reversal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bphtb_reversal (
    id integer NOT NULL,
    tgl timestamp with time zone NOT NULL,
    iso_request character varying(1024) NOT NULL
);


ALTER TABLE bphtb_reversal OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 69758)
-- Name: group_modules; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE group_modules (
    group_id integer,
    id integer NOT NULL,
    module_id integer,
    reads smallint DEFAULT 0 NOT NULL,
    writes smallint DEFAULT 0 NOT NULL,
    deletes smallint DEFAULT 0 NOT NULL,
    inserts smallint DEFAULT 0 NOT NULL
);


ALTER TABLE group_modules OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 69765)
-- Name: group_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE group_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE group_modules_id_seq OWNER TO postgres;

--
-- TOC entry 2721 (class 0 OID 0)
-- Dependencies: 247
-- Name: group_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE group_modules_id_seq OWNED BY group_modules.id;


--
-- TOC entry 248 (class 1259 OID 69767)
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE groups (
    id integer NOT NULL,
    nama character varying(50),
    locked smallint DEFAULT 0,
    kode character varying(10)
);


ALTER TABLE groups OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 69771)
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE groups_id_seq OWNER TO postgres;

--
-- TOC entry 2722 (class 0 OID 0)
-- Dependencies: 249
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- TOC entry 250 (class 1259 OID 69773)
-- Name: modules; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE modules (
    id integer NOT NULL,
    nama character varying(50),
    app_id smallint,
    kode character varying(20)
);


ALTER TABLE modules OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 69776)
-- Name: modules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE modules_id_seq OWNER TO postgres;

--
-- TOC entry 2723 (class 0 OID 0)
-- Dependencies: 251
-- Name: modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE modules_id_seq OWNED BY modules.id;


--
-- TOC entry 252 (class 1259 OID 69778)
-- Name: ref_jabatan; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ref_jabatan (
    kd_jabatan character(2) NOT NULL,
    nm_jabatan character varying(30),
    singkatan_jabatan character varying(30)
);


ALTER TABLE ref_jabatan OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 69781)
-- Name: user_groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_groups (
    id integer NOT NULL,
    user_id integer,
    group_id integer
);


ALTER TABLE user_groups OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 69784)
-- Name: user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_groups_id_seq OWNER TO postgres;

--
-- TOC entry 2724 (class 0 OID 0)
-- Dependencies: 254
-- Name: user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_groups_id_seq OWNED BY user_groups.id;


--
-- TOC entry 255 (class 1259 OID 69786)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    userid character varying(25),
    nama character varying(50),
    created timestamp without time zone,
    disabled smallint,
    passwd character varying(50),
    id integer NOT NULL,
    nip character(18),
    jabatan character varying(50),
    updated timestamp without time zone,
    update_uid bigint,
    create_uid bigint,
    handphone character varying(50)
);


ALTER TABLE users OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 69789)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- TOC entry 2725 (class 0 OID 0)
-- Dependencies: 256
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


SET search_path = bphtb, pg_catalog;

--
-- TOC entry 2163 (class 2604 OID 69791)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY app_status ALTER COLUMN id SET DEFAULT nextval('app_status_id_seq'::regclass);


--
-- TOC entry 2168 (class 2604 OID 69792)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_approval ALTER COLUMN id SET DEFAULT nextval('bphtb_approval_id_seq'::regclass);


--
-- TOC entry 2170 (class 2604 OID 69793)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_approval_final ALTER COLUMN id SET DEFAULT nextval('bphtb_approval_final_id_seq'::regclass);


--
-- TOC entry 2173 (class 2604 OID 69794)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_bank ALTER COLUMN id SET DEFAULT nextval('bphtb_bank_id_seq'::regclass);


--
-- TOC entry 2177 (class 2604 OID 69795)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_berkas_in ALTER COLUMN id SET DEFAULT nextval('bphtb_berkas_in_id_seq'::regclass);


--
-- TOC entry 2179 (class 2604 OID 69796)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_berkas_in_det ALTER COLUMN id SET DEFAULT nextval('bphtb_berkas_in_det_id_seq'::regclass);


--
-- TOC entry 2183 (class 2604 OID 69797)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_berkas_out ALTER COLUMN id SET DEFAULT nextval('bphtb_berkas_out_id_seq'::regclass);


--
-- TOC entry 2184 (class 2604 OID 69798)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_berkas_out_det ALTER COLUMN id SET DEFAULT nextval('bphtb_berkas_out_det_id_seq'::regclass);


--
-- TOC entry 2185 (class 2604 OID 69799)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_bpn ALTER COLUMN id SET DEFAULT nextval('bphtb_bpn_id_seq'::regclass);


--
-- TOC entry 2186 (class 2604 OID 69800)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_channel ALTER COLUMN id SET DEFAULT nextval('bphtb_channel_id_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 69801)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_inquiry ALTER COLUMN id SET DEFAULT nextval('bphtb_inquiry_id_seq'::regclass);


--
-- TOC entry 2188 (class 2604 OID 69802)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_pasar ALTER COLUMN id SET DEFAULT nextval('bphtb_pasar_id_seq'::regclass);


--
-- TOC entry 2192 (class 2604 OID 69803)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_pejabat ALTER COLUMN id SET DEFAULT nextval('bphtb_pejabat_id_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 69804)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_ppat ALTER COLUMN id SET DEFAULT nextval('bphtb_ppat_id_seq'::regclass);


--
-- TOC entry 2200 (class 2604 OID 69805)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_sk ALTER COLUMN id SET DEFAULT nextval('bphtb_sk_id_seq'::regclass);


--
-- TOC entry 2228 (class 2604 OID 69806)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_sspd ALTER COLUMN id SET DEFAULT nextval('bphtb_sspd_id_seq'::regclass);


--
-- TOC entry 2232 (class 2604 OID 69807)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_sspd_approval ALTER COLUMN id SET DEFAULT nextval('bphtb_sspd_approval_id_seq'::regclass);


--
-- TOC entry 2233 (class 2604 OID 69808)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_tp ALTER COLUMN id SET DEFAULT nextval('bphtb_tp_id_seq'::regclass);


--
-- TOC entry 2234 (class 2604 OID 69809)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_user ALTER COLUMN id SET DEFAULT nextval('bphtb_user_id_seq'::regclass);


--
-- TOC entry 2255 (class 2604 OID 69810)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_validasi ALTER COLUMN id SET DEFAULT nextval('bphtb_validasi_id_seq'::regclass);


--
-- TOC entry 2256 (class 2604 OID 69811)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_validasi_level ALTER COLUMN id SET DEFAULT nextval('bphtb_validasi_level_id_seq'::regclass);


--
-- TOC entry 2257 (class 2604 OID 69812)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_validasi_level_kec ALTER COLUMN id SET DEFAULT nextval('bphtb_validasi_level_kec_id_seq'::regclass);


--
-- TOC entry 2258 (class 2604 OID 69813)
-- Name: id; Type: DEFAULT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_validasi_user ALTER COLUMN id SET DEFAULT nextval('bphtb_validasi_user_id_seq'::regclass);


SET search_path = pbb, pg_catalog;

--
-- TOC entry 2274 (class 2604 OID 69814)
-- Name: id; Type: DEFAULT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY dph ALTER COLUMN id SET DEFAULT nextval('dph_id_seq'::regclass);


--
-- TOC entry 2276 (class 2604 OID 69815)
-- Name: id; Type: DEFAULT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY dph_payment ALTER COLUMN id SET DEFAULT nextval('dph_payment_id_seq'::regclass);


--
-- TOC entry 2277 (class 2604 OID 69816)
-- Name: id; Type: DEFAULT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY pembayaran_sppt ALTER COLUMN id SET DEFAULT nextval('pembayaran_sppt_id_seq'::regclass);


--
-- TOC entry 2285 (class 2604 OID 69817)
-- Name: id; Type: DEFAULT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY tempat_pembayaran ALTER COLUMN id SET DEFAULT nextval('tempat_pembayaran_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- TOC entry 2287 (class 2604 OID 69818)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY apps ALTER COLUMN id SET DEFAULT nextval('apps_id_seq'::regclass);


--
-- TOC entry 2292 (class 2604 OID 69819)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_modules ALTER COLUMN id SET DEFAULT nextval('group_modules_id_seq'::regclass);


--
-- TOC entry 2294 (class 2604 OID 69820)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- TOC entry 2295 (class 2604 OID 69821)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY modules ALTER COLUMN id SET DEFAULT nextval('modules_id_seq'::regclass);


--
-- TOC entry 2296 (class 2604 OID 69822)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_groups ALTER COLUMN id SET DEFAULT nextval('user_groups_id_seq'::regclass);


--
-- TOC entry 2297 (class 2604 OID 69823)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


SET search_path = bphtb, pg_catalog;

--
-- TOC entry 2588 (class 0 OID 69458)
-- Dependencies: 175
-- Data for Name: app_status; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY app_status (id, tahun, app_id, step, operator, review, manager) FROM stdin;
\.


--
-- TOC entry 2726 (class 0 OID 0)
-- Dependencies: 176
-- Name: app_status_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('app_status_id_seq', 1, false);


--
-- TOC entry 2590 (class 0 OID 69466)
-- Dependencies: 177
-- Data for Name: bphtb_alasan_pengurang; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_alasan_pengurang (id, nama) FROM stdin;
1	T/B tidak digunakan untuk mencari keuntungan
2	T/B digunakan untuk pendidikan umum
3	T/B digunakan untuk rumah sakit swasta IPSM
4	TB yang dibeli WP dari hasil ganti rugi pembebasan
\.


--
-- TOC entry 2591 (class 0 OID 69469)
-- Dependencies: 178
-- Data for Name: bphtb_approval; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_approval (id, validasi_id, tgl_approval, user_id, level_id, level, create_uid, update_uid, created, updated) FROM stdin;
1	3	2015-12-02 00:00:00	202	1	1	SPV1	\N	2015-12-02 00:00:00	\N
2	4	2015-12-02 00:00:00	202	1	1	SPV1	\N	2015-12-02 00:00:00	\N
3	7	2016-02-15 00:00:00	202	1	1	SPV1	\N	2016-02-15 00:00:00	\N
4	9	2016-02-22 00:00:00	2	1	1	bphtb	\N	2016-02-22 00:00:00	\N
5	10	2016-02-22 00:00:00	2	1	1	bphtb	\N	2016-02-22 00:00:00	\N
6	11	2016-02-25 00:00:00	2	1	1	bphtb	\N	2016-02-25 00:00:00	\N
7	24	2016-03-11 00:00:00	202	1	1	ucok	\N	2016-03-11 00:00:00	\N
\.


--
-- TOC entry 2592 (class 0 OID 69476)
-- Dependencies: 179
-- Data for Name: bphtb_approval_final; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_approval_final (id, approval_id, tahun, kode, no_urut, create_uid, update_uid, created, updated) FROM stdin;
\.


--
-- TOC entry 2727 (class 0 OID 0)
-- Dependencies: 180
-- Name: bphtb_approval_final_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_approval_final_id_seq', 6, true);


--
-- TOC entry 2728 (class 0 OID 0)
-- Dependencies: 181
-- Name: bphtb_approval_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_approval_id_seq', 7, true);


--
-- TOC entry 2595 (class 0 OID 69484)
-- Dependencies: 182
-- Data for Name: bphtb_bank; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_bank (id, tanggal, jam, seq, transno, cabang, users, bankid, txs, sspd_id, nop, tahun, kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, thn_pajak_sppt, wp_nama, wp_alamat, wp_blok_kav, wp_rt, wp_rw, wp_kelurahan, wp_kecamatan, wp_kota, wp_provinsi, wp_kdpos, wp_identitas, wp_identitaskd, wp_npwp, notaris, bumi_luas, bumi_njop, bng_luas, bng_njop, npop, bayar, denda, bphtbjeniskd, is_validated, no_tagihan, catatan, kd_kanwil, kd_kantor, kd_bank_tunggal, kd_bank_persepsi, wp_propinsi, pembayaran_ke) FROM stdin;
\.


--
-- TOC entry 2729 (class 0 OID 0)
-- Dependencies: 183
-- Name: bphtb_bank_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_bank_id_seq', 8214, true);


--
-- TOC entry 2597 (class 0 OID 69494)
-- Dependencies: 184
-- Data for Name: bphtb_berkas_in; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_berkas_in (id, tahun, kode, no_urut, tgl_terima, tgl_selesai, notes, pengirim, create_uid, update_uid, created, updated, ppat_id) FROM stdin;
\.


--
-- TOC entry 2598 (class 0 OID 69500)
-- Dependencies: 185
-- Data for Name: bphtb_berkas_in_det; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_berkas_in_det (id, berkas_in_id, sspd_id, sspd_no, kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, thn_pajak_sppt, nominal) FROM stdin;
\.


--
-- TOC entry 2730 (class 0 OID 0)
-- Dependencies: 186
-- Name: bphtb_berkas_in_det_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_berkas_in_det_id_seq', 966, true);


--
-- TOC entry 2731 (class 0 OID 0)
-- Dependencies: 187
-- Name: bphtb_berkas_in_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_berkas_in_id_seq', 829, true);


--
-- TOC entry 2601 (class 0 OID 69508)
-- Dependencies: 188
-- Data for Name: bphtb_berkas_out; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_berkas_out (id, tahun, kode, no_urut, tgl_keluar, notes, penerima, create_uid, update_uid, created, updated, ppat_id) FROM stdin;
\.


--
-- TOC entry 2602 (class 0 OID 69514)
-- Dependencies: 189
-- Data for Name: bphtb_berkas_out_det; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_berkas_out_det (id, berkas_out_id, berkas_in_det_id) FROM stdin;
\.


--
-- TOC entry 2732 (class 0 OID 0)
-- Dependencies: 190
-- Name: bphtb_berkas_out_det_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_berkas_out_det_id_seq', 37, true);


--
-- TOC entry 2733 (class 0 OID 0)
-- Dependencies: 191
-- Name: bphtb_berkas_out_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_berkas_out_id_seq', 33, true);


--
-- TOC entry 2605 (class 0 OID 69521)
-- Dependencies: 192
-- Data for Name: bphtb_bpn; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_bpn (id, bank_id, sspd_id, validasi_id, tgl_proses, tgl_selesai, status) FROM stdin;
\.


--
-- TOC entry 2734 (class 0 OID 0)
-- Dependencies: 193
-- Name: bphtb_bpn_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_bpn_id_seq', 1, false);


--
-- TOC entry 2607 (class 0 OID 69526)
-- Dependencies: 194
-- Data for Name: bphtb_channel; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_channel (id, nama) FROM stdin;
\.


--
-- TOC entry 2735 (class 0 OID 0)
-- Dependencies: 195
-- Name: bphtb_channel_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_channel_id_seq', 1, false);


--
-- TOC entry 2609 (class 0 OID 69531)
-- Dependencies: 196
-- Data for Name: bphtb_dasar; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_dasar (id, nama) FROM stdin;
1	Penghitungan Wajib Pajak
2	STB / SKBKB / SKBKBT
3	Pengurangan dihitung sendiri
\.


--
-- TOC entry 2610 (class 0 OID 69534)
-- Dependencies: 197
-- Data for Name: bphtb_hukum; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_hukum (id, nama, uraian) FROM stdin;
1	AJB	Akte Jual Beli
2	AHB	Akta Hibah
3	APHT	Akta Pemberian Hak Tanggungan
4	ASKMHT	Akta Surat Kuasa Membebankan Hak Tanggungan
5	APDP	Akta Pemisahan Dan Pembagian
6	AH	Akta Hipotik
7	ACV	Akta Crediet Verband
8	AF	Akta Fiducia
9	APHDHM	Akta Pemberian Hak Di atas Hak Milik
10	APHB	Akta Pembagian Hak Bersama
11	APKP	Akta Pemasukan Kedalam Perusahaan
12	TM	Tukar Menukar
20	RL	Risalah Lelang
50	SKPHB	Surat Ketetapan Pemberian Hak Baru
\.


--
-- TOC entry 2611 (class 0 OID 69537)
-- Dependencies: 198
-- Data for Name: bphtb_inquiry; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_inquiry (id, tgl, invoice_id, transmission, stan, settlement, bank_id, channel_id) FROM stdin;
\.


--
-- TOC entry 2736 (class 0 OID 0)
-- Dependencies: 199
-- Name: bphtb_inquiry_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_inquiry_id_seq', 1, false);


--
-- TOC entry 2613 (class 0 OID 69542)
-- Dependencies: 200
-- Data for Name: bphtb_pasar; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_pasar (id, kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, uraian, harga) FROM stdin;
\.


--
-- TOC entry 2737 (class 0 OID 0)
-- Dependencies: 201
-- Name: bphtb_pasar_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_pasar_id_seq', 69, true);


--
-- TOC entry 2615 (class 0 OID 69547)
-- Dependencies: 202
-- Data for Name: bphtb_pejabat; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_pejabat (id, nip, kd_jabatan, nama, enabled, create_uid, update_uid, created, updated) FROM stdin;
\.


--
-- TOC entry 2738 (class 0 OID 0)
-- Dependencies: 203
-- Name: bphtb_pejabat_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_pejabat_id_seq', 11, true);


--
-- TOC entry 2617 (class 0 OID 69555)
-- Dependencies: 204
-- Data for Name: bphtb_perolehan; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_perolehan (id, nama, npoptkp, pengurang, singkatan) FROM stdin;
1	JUAL BELI	60000000	0	JUAL BELI
2	TUKAR MENUKAR	60000000	0	TUKAR MENUKAR
3	HIBAH	60000000	0	HIBAH
4	HIBAH WASIAT	300000000	0	HIBAH WASIAT
5	WARIS	300000000	0	WARIS
6	Pemasukan Dalam Perseroan Atau Badan Hukum Lain	60000000	0	PDPABHL
7	Pemisahan Hak Yang Mengakibatkan Peralihan	60000000	0	PHYMP
8	Penunjukan pemberi dalam Lelang	60000000	0	Lelang
9	Pelaksanaan Putusan Hakim yang Mempunyai Kekuatan Hukum Tetap	60000000	0	Putusan Hukum
10	Penggabungan Usaha	60000000	0	Penggabungan Usaha
11	Pelebaran Usaha	60000000	0	Pelebaran Usaha
12	Pemekaran Usaha	60000000	0	Pemekaran Usaha 
13	Hadiah	60000000	0	Hadiah
14	Perolehan Hak Rumah Sederhana Sehat dan RSS Melalui KPD Bersubsidi	60000000	0	RSS
15	Pemberian Hak Baru	60000000	0	Hak Baru
16	Pemberian Hak Baru sebagai Kelanjutan Pelepasan Hak	60000000	0	Hak Baru
17	Pemberian Hak Baru di Luar Pelepasan Hak	60000000	0	di Luar Pelepasan
\.


--
-- TOC entry 2618 (class 0 OID 69560)
-- Dependencies: 205
-- Data for Name: bphtb_ppat; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_ppat (id, kode, nama, alamat, kelurahan, kecamatan, kota, wilayah_kerja, kd_wilayah, no_telp, no_fax, no_sk, tgl_sk, create_uid, update_uid, created, updated, npwp, pejabat_id) FROM stdin;
\.


--
-- TOC entry 2739 (class 0 OID 0)
-- Dependencies: 206
-- Name: bphtb_ppat_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_ppat_id_seq', 417, true);


--
-- TOC entry 2620 (class 0 OID 69567)
-- Dependencies: 207
-- Data for Name: bphtb_sk; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_sk (id, validasi_id, tahun, kode, no_urut, create_uid, update_uid, created, updated) FROM stdin;
\.


--
-- TOC entry 2740 (class 0 OID 0)
-- Dependencies: 208
-- Name: bphtb_sk_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_sk_id_seq', 255, true);


--
-- TOC entry 2622 (class 0 OID 69574)
-- Dependencies: 209
-- Data for Name: bphtb_sspd; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_sspd (id, tahun, kode, no_sspd, ppat_id, wp_nama, wp_npwp, wp_alamat, wp_blok_kav, wp_kelurahan, wp_rt, wp_rw, wp_kecamatan, wp_kota, wp_provinsi, wp_identitas, wp_identitaskd, tgl_transaksi, kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, thn_pajak_sppt, op_alamat, op_blok_kav, op_rt, op_rw, bumi_luas, bumi_njop, bng_luas, bng_njop, no_sertifikat, njop, perolehan_id, npop, npoptkp, tarif, terhutang, bagian, pembagi, tarif_pengurang, pengurang, bphtb_sudah_dibayarkan, denda, restitusi, bphtb_harus_dibayarkan, status_pembayaran, dasar_id, create_uid, update_uid, created, updated, header_id, tgl_print, tgl_approval, file1, file2, file3, file4, file5, wp_kdpos, file6, file7, file8, file9, file10, keterangan, status_daftar, persen_pengurang_sendiri, pp_nomor_pengurang_sendiri, no_ajb, tgl_ajb, wp_nama_asal, jml_pph, tgl_pph, posted, pos_tp_id, status_validasi, status_bpn, tgl_jatuh_tempo, verifikasi_uid, verifikasi_date, pbb_nop, verifikasi_bphtb_uid, verifikasi_bphtb_date, hasil_penelitian, no_sk, pengurangan_sk, pengurangan_jatuh_tempo_tgl, pengurangan_sk_tgl, ketetapan_no, ketetapan_tgl, ketetapan_atas_sspd_no, ketetapan_jatuh_tempo_tgl, pembayaran_ke, mutasi_penuh, harga_transaksi, npopkp, npoptkp_sudah_didapat, bng_luas_beban, bng_njop_beban, bumi_luas_beban, bumi_njop_beban) FROM stdin;
\.


--
-- TOC entry 2623 (class 0 OID 69607)
-- Dependencies: 210
-- Data for Name: bphtb_sspd_approval; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_sspd_approval (id, sspd_id, tahun, kode, no_urut, tgl_approval, create_uid, update_uid, created, updated) FROM stdin;
\.


--
-- TOC entry 2741 (class 0 OID 0)
-- Dependencies: 211
-- Name: bphtb_sspd_approval_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_sspd_approval_id_seq', 22, true);


--
-- TOC entry 2742 (class 0 OID 0)
-- Dependencies: 212
-- Name: bphtb_sspd_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_sspd_id_seq', 12186, true);


--
-- TOC entry 2626 (class 0 OID 69617)
-- Dependencies: 213
-- Data for Name: bphtb_status_hak; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_status_hak (id, nama, uraian) FROM stdin;
1	HM	Hak Milik
2	HMA	Hak Milik Adat
3	HMSRS	Hak Milik Satuan Rumah Susun
4	HGB	Hak Guna Bangunan
5	HGU	Hak Guna Usaha
6	HP	Hak Pakai
7	HPL	Hak Pengelolaan Lahan
\.


--
-- TOC entry 2627 (class 0 OID 69620)
-- Dependencies: 214
-- Data for Name: bphtb_tp; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_tp (id, singkatan, nama) FROM stdin;
\.


--
-- TOC entry 2743 (class 0 OID 0)
-- Dependencies: 215
-- Name: bphtb_tp_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_tp_id_seq', 1, false);


--
-- TOC entry 2629 (class 0 OID 69625)
-- Dependencies: 216
-- Data for Name: bphtb_user; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_user (userid, ppat_id, id) FROM stdin;
\.


--
-- TOC entry 2744 (class 0 OID 0)
-- Dependencies: 217
-- Name: bphtb_user_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_user_id_seq', 228, true);


--
-- TOC entry 2631 (class 0 OID 69630)
-- Dependencies: 218
-- Data for Name: bphtb_validasi; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_validasi (id, berkas_in_id, sspd_id, ppat_id, wp_nama, wp_npwp, wp_alamat, wp_blok_kav, wp_kelurahan, wp_rt, wp_rw, wp_kecamatan, wp_kota, wp_provinsi, wp_identitas, wp_identitaskd, tgl_transaksi, kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, thn_pajak_sppt, op_alamat, op_blok_kav, op_rt, op_rw, bumi_luas, bumi_njop, bng_luas, bng_njop, no_sertifikat, njop, perolehan_id, npop, npoptkp, tarif, terhutang, bagian, pembagi, tarif_pengurang, pengurang, bphtb_sudah_dibayarkan, denda, restitusi, bphtb_harus_dibayarkan, status_pembayaran, dasar_id, create_uid, update_uid, created, updated, header_id, bpn_tgl_terima, bpn_tgl_selesai, wp_kdpos, bank_id, persen_pengurang_sendiri, pp_nomor_pengurang_sendiri, mutasi_penuh, wp_nama_asal, harga_transaksi, npopkp, npoptkp_sudah_didapat, bng_luas_beban, bng_njop_beban, bumi_luas_beban, bumi_njop_beban) FROM stdin;
\.


--
-- TOC entry 2745 (class 0 OID 0)
-- Dependencies: 219
-- Name: bphtb_validasi_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_validasi_id_seq', 1095, true);


--
-- TOC entry 2633 (class 0 OID 69658)
-- Dependencies: 220
-- Data for Name: bphtb_validasi_level; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_validasi_level (id, level, uraian, min_value, max_value, level_id) FROM stdin;
\.


--
-- TOC entry 2746 (class 0 OID 0)
-- Dependencies: 221
-- Name: bphtb_validasi_level_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_validasi_level_id_seq', 1, false);


--
-- TOC entry 2635 (class 0 OID 69663)
-- Dependencies: 222
-- Data for Name: bphtb_validasi_level_kec; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_validasi_level_kec (id, level_id, kd_propinsi, kd_dati2, kd_kecamatan, nm_kecamatan) FROM stdin;
\.


--
-- TOC entry 2747 (class 0 OID 0)
-- Dependencies: 223
-- Name: bphtb_validasi_level_kec_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_validasi_level_kec_id_seq', 13, true);


--
-- TOC entry 2637 (class 0 OID 69668)
-- Dependencies: 224
-- Data for Name: bphtb_validasi_user; Type: TABLE DATA; Schema: bphtb; Owner: postgres
--

COPY bphtb_validasi_user (id, user_id, level_id) FROM stdin;
\.


--
-- TOC entry 2748 (class 0 OID 0)
-- Dependencies: 225
-- Name: bphtb_validasi_user_id_seq; Type: SEQUENCE SET; Schema: bphtb; Owner: postgres
--

SELECT pg_catalog.setval('bphtb_validasi_user_id_seq', 14, true);


SET search_path = pbb, pg_catalog;

--
-- TOC entry 2639 (class 0 OID 69673)
-- Dependencies: 226
-- Data for Name: dat_objek_pajak; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY dat_objek_pajak (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, subjek_pajak_id, no_formulir_spop, no_persil, jalan_op, blok_kav_no_op, rw_op, rt_op, kd_status_cabang, kd_status_wp, total_luas_bumi, total_luas_bng, njop_bumi, njop_bng, status_peta_op, jns_transaksi_op, tgl_pendataan_op, nip_pendata, tgl_pemeriksaan_op, nip_pemeriksa_op, tgl_perekaman_op, nip_perekam_op) FROM stdin;
\.


--
-- TOC entry 2640 (class 0 OID 69685)
-- Dependencies: 227
-- Data for Name: dat_subjek_pajak; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY dat_subjek_pajak (subjek_pajak_id, nm_wp, jalan_wp, blok_kav_no_wp, rw_wp, rt_wp, kelurahan_wp, kota_wp, kd_pos_wp, telp_wp, npwp, status_pekerjaan_wp, kecamatan_wp, propinsi_wp) FROM stdin;
\.


--
-- TOC entry 2641 (class 0 OID 69693)
-- Dependencies: 228
-- Data for Name: dph; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY dph (id, kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kode, nama, tgl_bayar, tgl_posting, status_posting, tahun, pejabat1_id, pejabat2_id) FROM stdin;
\.


--
-- TOC entry 2749 (class 0 OID 0)
-- Dependencies: 229
-- Name: dph_id_seq; Type: SEQUENCE SET; Schema: pbb; Owner: postgres
--

SELECT pg_catalog.setval('dph_id_seq', 1, false);


--
-- TOC entry 2643 (class 0 OID 69699)
-- Dependencies: 230
-- Data for Name: dph_payment; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY dph_payment (id, dph_id, kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, thn_pajak_sppt, pembayaran_ke, denda, jml_yg_dibayar, tgl_rekam_byr, nip_rekam_byr) FROM stdin;
\.


--
-- TOC entry 2750 (class 0 OID 0)
-- Dependencies: 231
-- Name: dph_payment_id_seq; Type: SEQUENCE SET; Schema: pbb; Owner: postgres
--

SELECT pg_catalog.setval('dph_payment_id_seq', 1, false);


--
-- TOC entry 2645 (class 0 OID 69705)
-- Dependencies: 232
-- Data for Name: pembayaran_sppt; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY pembayaran_sppt (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, thn_pajak_sppt, pembayaran_sppt_ke, kd_kanwil_bank, kd_kppbb_bank, kd_bank_tunggal, kd_bank_persepsi, kd_tp, denda_sppt, jml_sppt_yg_dibayar, tgl_pembayaran_sppt, tgl_rekam_byr_sppt, nip_rekam_byr_sppt, kd_kanwil, kd_kantor, id) FROM stdin;
\.


--
-- TOC entry 2751 (class 0 OID 0)
-- Dependencies: 233
-- Name: pembayaran_sppt_id_seq; Type: SEQUENCE SET; Schema: pbb; Owner: postgres
--

SELECT pg_catalog.setval('pembayaran_sppt_id_seq', 2501710, true);


--
-- TOC entry 2647 (class 0 OID 69710)
-- Dependencies: 234
-- Data for Name: ref_dati2; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY ref_dati2 (kd_propinsi, kd_dati2, nm_dati2) FROM stdin;
\.


--
-- TOC entry 2648 (class 0 OID 69713)
-- Dependencies: 235
-- Data for Name: ref_jns_sektor; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY ref_jns_sektor (kd_sektor, nm_sektor) FROM stdin;
\.


--
-- TOC entry 2649 (class 0 OID 69716)
-- Dependencies: 236
-- Data for Name: ref_kecamatan; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY ref_kecamatan (kd_propinsi, kd_dati2, kd_kecamatan, nm_kecamatan) FROM stdin;
\.


--
-- TOC entry 2650 (class 0 OID 69719)
-- Dependencies: 237
-- Data for Name: ref_kelurahan; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY ref_kelurahan (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_sektor, nm_kelurahan, no_kelurahan, kd_pos_kelurahan) FROM stdin;
\.


--
-- TOC entry 2651 (class 0 OID 69722)
-- Dependencies: 238
-- Data for Name: ref_propinsi; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY ref_propinsi (kd_propinsi, nm_propinsi) FROM stdin;
\.


--
-- TOC entry 2652 (class 0 OID 69725)
-- Dependencies: 239
-- Data for Name: sppt; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY sppt (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, thn_pajak_sppt, siklus_sppt, kd_kanwil_bank, kd_kppbb_bank, kd_bank_tunggal, kd_bank_persepsi, kd_tp, nm_wp_sppt, jln_wp_sppt, blok_kav_no_wp_sppt, rw_wp_sppt, rt_wp_sppt, kelurahan_wp_sppt, kota_wp_sppt, kd_pos_wp_sppt, npwp_sppt, no_persil_sppt, kd_kls_tanah, thn_awal_kls_tanah, kd_kls_bng, thn_awal_kls_bng, tgl_jatuh_tempo_sppt, luas_bumi_sppt, luas_bng_sppt, njop_bumi_sppt, njop_bng_sppt, njop_sppt, njoptkp_sppt, njkp_sppt, pbb_terhutang_sppt, faktor_pengurang_sppt, pbb_yg_harus_dibayar_sppt, status_pembayaran_sppt, status_tagihan_sppt, status_cetak_sppt, tgl_terbit_sppt, tgl_cetak_sppt, nip_pencetak_sppt, kd_kanwil, kd_kantor) FROM stdin;
\.


--
-- TOC entry 2653 (class 0 OID 69735)
-- Dependencies: 240
-- Data for Name: tempat_pembayaran; Type: TABLE DATA; Schema: pbb; Owner: postgres
--

COPY tempat_pembayaran (kd_kanwil, kd_kantor, kd_tp, nm_tp, alamat_tp, no_rek_tp, id) FROM stdin;
\.


--
-- TOC entry 2752 (class 0 OID 0)
-- Dependencies: 241
-- Name: tempat_pembayaran_id_seq; Type: SEQUENCE SET; Schema: pbb; Owner: postgres
--

SELECT pg_catalog.setval('tempat_pembayaran_id_seq', 1, true);


SET search_path = public, pg_catalog;

--
-- TOC entry 2655 (class 0 OID 69740)
-- Dependencies: 242
-- Data for Name: apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY apps (id, nama, app_path, disabled) FROM stdin;
\.


--
-- TOC entry 2753 (class 0 OID 0)
-- Dependencies: 243
-- Name: apps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('apps_id_seq', 2, true);


--
-- TOC entry 2657 (class 0 OID 69746)
-- Dependencies: 244
-- Data for Name: bphtb_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bphtb_payment (id, tgl, iso_request, transmission, settlement, stan, invoice_id, invoice_no, ntb, ntp, bank_id, channel_id, bank_ip) FROM stdin;
\.


--
-- TOC entry 2658 (class 0 OID 69752)
-- Dependencies: 245
-- Data for Name: bphtb_reversal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bphtb_reversal (id, tgl, iso_request) FROM stdin;
\.


--
-- TOC entry 2659 (class 0 OID 69758)
-- Dependencies: 246
-- Data for Name: group_modules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY group_modules (group_id, id, module_id, reads, writes, deletes, inserts) FROM stdin;
\.


--
-- TOC entry 2754 (class 0 OID 0)
-- Dependencies: 247
-- Name: group_modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('group_modules_id_seq', 76, true);


--
-- TOC entry 2661 (class 0 OID 69767)
-- Dependencies: 248
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY groups (id, nama, locked, kode) FROM stdin;
\.


--
-- TOC entry 2755 (class 0 OID 0)
-- Dependencies: 249
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('groups_id_seq', 10, true);


--
-- TOC entry 2663 (class 0 OID 69773)
-- Dependencies: 250
-- Data for Name: modules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY modules (id, nama, app_id, kode) FROM stdin;
\.


--
-- TOC entry 2756 (class 0 OID 0)
-- Dependencies: 251
-- Name: modules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('modules_id_seq', 12, true);


--
-- TOC entry 2665 (class 0 OID 69778)
-- Dependencies: 252
-- Data for Name: ref_jabatan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ref_jabatan (kd_jabatan, nm_jabatan, singkatan_jabatan) FROM stdin;
\.


--
-- TOC entry 2666 (class 0 OID 69781)
-- Dependencies: 253
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 2757 (class 0 OID 0)
-- Dependencies: 254
-- Name: user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_groups_id_seq', 246, true);


--
-- TOC entry 2668 (class 0 OID 69786)
-- Dependencies: 255
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (userid, nama, created, disabled, passwd, id, nip, jabatan, updated, update_uid, create_uid, handphone) FROM stdin;
\.


--
-- TOC entry 2758 (class 0 OID 0)
-- Dependencies: 256
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 245, true);


SET search_path = bphtb, pg_catalog;

--
-- TOC entry 2299 (class 2606 OID 69827)
-- Name: app_status_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY app_status
    ADD CONSTRAINT app_status_pkey PRIMARY KEY (id);


--
-- TOC entry 2305 (class 2606 OID 69829)
-- Name: bphtb_approval_final_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_approval_final
    ADD CONSTRAINT bphtb_approval_final_pkey PRIMARY KEY (id);


--
-- TOC entry 2303 (class 2606 OID 69831)
-- Name: bphtb_approval_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_approval
    ADD CONSTRAINT bphtb_approval_pkey PRIMARY KEY (id);


--
-- TOC entry 2307 (class 2606 OID 69833)
-- Name: bphtb_bank_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_bank
    ADD CONSTRAINT bphtb_bank_pkey PRIMARY KEY (id);


--
-- TOC entry 2309 (class 2606 OID 69835)
-- Name: bphtb_bank_tanggal_jam_seq_transno_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_bank
    ADD CONSTRAINT bphtb_bank_tanggal_jam_seq_transno_key UNIQUE (tanggal, jam, seq, transno);


--
-- TOC entry 2315 (class 2606 OID 69837)
-- Name: bphtb_berkas_in_det_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_berkas_in_det
    ADD CONSTRAINT bphtb_berkas_in_det_pkey PRIMARY KEY (id);


--
-- TOC entry 2311 (class 2606 OID 69839)
-- Name: bphtb_berkas_in_id_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_berkas_in
    ADD CONSTRAINT bphtb_berkas_in_id_pk PRIMARY KEY (id);


--
-- TOC entry 2313 (class 2606 OID 69841)
-- Name: bphtb_berkas_in_uk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_berkas_in
    ADD CONSTRAINT bphtb_berkas_in_uk UNIQUE (tahun, kode, no_urut);


--
-- TOC entry 2321 (class 2606 OID 69843)
-- Name: bphtb_berkas_out_det_berkas_in_det_id_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_berkas_out_det
    ADD CONSTRAINT bphtb_berkas_out_det_berkas_in_det_id_key UNIQUE (berkas_in_det_id);


--
-- TOC entry 2323 (class 2606 OID 69845)
-- Name: bphtb_berkas_out_det_id_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_berkas_out_det
    ADD CONSTRAINT bphtb_berkas_out_det_id_pk PRIMARY KEY (id);


--
-- TOC entry 2317 (class 2606 OID 69847)
-- Name: bphtb_berkas_out_id_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_berkas_out
    ADD CONSTRAINT bphtb_berkas_out_id_pk PRIMARY KEY (id);


--
-- TOC entry 2319 (class 2606 OID 69849)
-- Name: bphtb_berkas_out_uk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_berkas_out
    ADD CONSTRAINT bphtb_berkas_out_uk UNIQUE (tahun, kode, no_urut);


--
-- TOC entry 2325 (class 2606 OID 69851)
-- Name: bphtb_bpn_id_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_bpn
    ADD CONSTRAINT bphtb_bpn_id_pk PRIMARY KEY (id);


--
-- TOC entry 2327 (class 2606 OID 69853)
-- Name: bphtb_channel_nama_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_channel
    ADD CONSTRAINT bphtb_channel_nama_key UNIQUE (nama);


--
-- TOC entry 2329 (class 2606 OID 69855)
-- Name: bphtb_channel_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_channel
    ADD CONSTRAINT bphtb_channel_pkey PRIMARY KEY (id);


--
-- TOC entry 2331 (class 2606 OID 69857)
-- Name: bphtb_dasar_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_dasar
    ADD CONSTRAINT bphtb_dasar_pkey PRIMARY KEY (id);


--
-- TOC entry 2333 (class 2606 OID 69859)
-- Name: bphtb_hukum_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_hukum
    ADD CONSTRAINT bphtb_hukum_pkey PRIMARY KEY (id);


--
-- TOC entry 2335 (class 2606 OID 69861)
-- Name: bphtb_inquiry_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_inquiry
    ADD CONSTRAINT bphtb_inquiry_pkey PRIMARY KEY (id);


--
-- TOC entry 2340 (class 2606 OID 69863)
-- Name: bphtb_pasar_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_pasar
    ADD CONSTRAINT bphtb_pasar_pk PRIMARY KEY (id);


--
-- TOC entry 2342 (class 2606 OID 69865)
-- Name: bphtb_pasar_uk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_pasar
    ADD CONSTRAINT bphtb_pasar_uk UNIQUE (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut);


--
-- TOC entry 2344 (class 2606 OID 69867)
-- Name: bphtb_pejabat_id_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_pejabat
    ADD CONSTRAINT bphtb_pejabat_id_pk PRIMARY KEY (id);


--
-- TOC entry 2346 (class 2606 OID 69869)
-- Name: bphtb_pejabat_uq; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_pejabat
    ADD CONSTRAINT bphtb_pejabat_uq UNIQUE (nip, kd_jabatan);


--
-- TOC entry 2301 (class 2606 OID 69871)
-- Name: bphtb_pengurangan_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_alasan_pengurang
    ADD CONSTRAINT bphtb_pengurangan_pkey PRIMARY KEY (id);


--
-- TOC entry 2348 (class 2606 OID 69873)
-- Name: bphtb_perolehan_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_perolehan
    ADD CONSTRAINT bphtb_perolehan_pk PRIMARY KEY (id);


--
-- TOC entry 2350 (class 2606 OID 69875)
-- Name: bphtb_ppat_id_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_ppat
    ADD CONSTRAINT bphtb_ppat_id_pk PRIMARY KEY (id);


--
-- TOC entry 2352 (class 2606 OID 69877)
-- Name: bphtb_ppat_kode_uk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_ppat
    ADD CONSTRAINT bphtb_ppat_kode_uk UNIQUE (kode);


--
-- TOC entry 2354 (class 2606 OID 69879)
-- Name: bphtb_ppat_no_sk_uk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_ppat
    ADD CONSTRAINT bphtb_ppat_no_sk_uk UNIQUE (no_sk);


--
-- TOC entry 2356 (class 2606 OID 69881)
-- Name: bphtb_sk_id_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_sk
    ADD CONSTRAINT bphtb_sk_id_pk PRIMARY KEY (id);


--
-- TOC entry 2358 (class 2606 OID 69883)
-- Name: bphtb_sk_uk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_sk
    ADD CONSTRAINT bphtb_sk_uk UNIQUE (tahun, kode, no_urut);


--
-- TOC entry 2360 (class 2606 OID 69885)
-- Name: bphtb_sk_validasi_id; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_sk
    ADD CONSTRAINT bphtb_sk_validasi_id UNIQUE (validasi_id);


--
-- TOC entry 2366 (class 2606 OID 69887)
-- Name: bphtb_sspd_approval_kode_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_sspd_approval
    ADD CONSTRAINT bphtb_sspd_approval_kode_key UNIQUE (tahun, kode, no_urut);


--
-- TOC entry 2368 (class 2606 OID 69889)
-- Name: bphtb_sspd_approval_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_sspd_approval
    ADD CONSTRAINT bphtb_sspd_approval_pk PRIMARY KEY (id);


--
-- TOC entry 2370 (class 2606 OID 69891)
-- Name: bphtb_sspd_approval_sspd_id_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_sspd_approval
    ADD CONSTRAINT bphtb_sspd_approval_sspd_id_key UNIQUE (sspd_id);


--
-- TOC entry 2362 (class 2606 OID 69893)
-- Name: bphtb_sspd_id_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_sspd
    ADD CONSTRAINT bphtb_sspd_id_pk PRIMARY KEY (id);


--
-- TOC entry 2364 (class 2606 OID 69895)
-- Name: bphtb_sspd_tahun_kode_no_sspd_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_sspd
    ADD CONSTRAINT bphtb_sspd_tahun_kode_no_sspd_key UNIQUE (tahun, kode, no_sspd);


--
-- TOC entry 2372 (class 2606 OID 69897)
-- Name: bphtb_status_hak_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_status_hak
    ADD CONSTRAINT bphtb_status_hak_pkey PRIMARY KEY (id);


--
-- TOC entry 2374 (class 2606 OID 69899)
-- Name: bphtb_tp_nama_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_tp
    ADD CONSTRAINT bphtb_tp_nama_key UNIQUE (nama);


--
-- TOC entry 2376 (class 2606 OID 69901)
-- Name: bphtb_tp_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_tp
    ADD CONSTRAINT bphtb_tp_pkey PRIMARY KEY (id);


--
-- TOC entry 2378 (class 2606 OID 69903)
-- Name: bphtb_tp_singkatan_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_tp
    ADD CONSTRAINT bphtb_tp_singkatan_key UNIQUE (singkatan);


--
-- TOC entry 2380 (class 2606 OID 69905)
-- Name: bphtb_user_userid_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_user
    ADD CONSTRAINT bphtb_user_userid_key UNIQUE (userid);


--
-- TOC entry 2383 (class 2606 OID 69907)
-- Name: bphtb_validasi_id_pk; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_validasi
    ADD CONSTRAINT bphtb_validasi_id_pk PRIMARY KEY (id);


--
-- TOC entry 2387 (class 2606 OID 69909)
-- Name: bphtb_validasi_level_kec_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_validasi_level_kec
    ADD CONSTRAINT bphtb_validasi_level_kec_pkey PRIMARY KEY (id);


--
-- TOC entry 2385 (class 2606 OID 69911)
-- Name: bphtb_validasi_level_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_validasi_level
    ADD CONSTRAINT bphtb_validasi_level_pkey PRIMARY KEY (id);


--
-- TOC entry 2389 (class 2606 OID 69913)
-- Name: bphtb_validasi_user_pkey; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_validasi_user
    ADD CONSTRAINT bphtb_validasi_user_pkey PRIMARY KEY (id);


--
-- TOC entry 2391 (class 2606 OID 69915)
-- Name: bphtb_validasi_user_user_id_key; Type: CONSTRAINT; Schema: bphtb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_validasi_user
    ADD CONSTRAINT bphtb_validasi_user_user_id_key UNIQUE (user_id);


SET search_path = pbb, pg_catalog;

--
-- TOC entry 2393 (class 2606 OID 69917)
-- Name: dat_objek_pajak_pk; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dat_objek_pajak
    ADD CONSTRAINT dat_objek_pajak_pk PRIMARY KEY (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op);


--
-- TOC entry 2397 (class 2606 OID 69919)
-- Name: dph_kode_tahun_key; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dph
    ADD CONSTRAINT dph_kode_tahun_key UNIQUE (kode, tahun);


--
-- TOC entry 2401 (class 2606 OID 69921)
-- Name: dph_payment_pkey; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dph_payment
    ADD CONSTRAINT dph_payment_pkey PRIMARY KEY (id);


--
-- TOC entry 2403 (class 2606 OID 69923)
-- Name: dph_payment_ukey; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dph_payment
    ADD CONSTRAINT dph_payment_ukey UNIQUE (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, thn_pajak_sppt, pembayaran_ke);


--
-- TOC entry 2399 (class 2606 OID 69925)
-- Name: dph_pkey; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dph
    ADD CONSTRAINT dph_pkey PRIMARY KEY (id);


--
-- TOC entry 2409 (class 2606 OID 69927)
-- Name: pk_a8; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_jns_sektor
    ADD CONSTRAINT pk_a8 PRIMARY KEY (kd_sektor);


--
-- TOC entry 2395 (class 2606 OID 69929)
-- Name: pk_d11; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dat_subjek_pajak
    ADD CONSTRAINT pk_d11 PRIMARY KEY (subjek_pajak_id);


--
-- TOC entry 2417 (class 2606 OID 69931)
-- Name: pk_e6; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sppt
    ADD CONSTRAINT pk_e6 PRIMARY KEY (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan, kd_blok, no_urut, kd_jns_op, thn_pajak_sppt);


--
-- TOC entry 2405 (class 2606 OID 69933)
-- Name: pk_psppt; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pembayaran_sppt
    ADD CONSTRAINT pk_psppt PRIMARY KEY (id);


--
-- TOC entry 2407 (class 2606 OID 69936)
-- Name: ref_dati2_pk; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_dati2
    ADD CONSTRAINT ref_dati2_pk PRIMARY KEY (kd_propinsi, kd_dati2);


--
-- TOC entry 2411 (class 2606 OID 69938)
-- Name: ref_kecamatan_pk; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_kecamatan
    ADD CONSTRAINT ref_kecamatan_pk PRIMARY KEY (kd_propinsi, kd_dati2, kd_kecamatan);


--
-- TOC entry 2413 (class 2606 OID 69940)
-- Name: ref_kelurahan_pk; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_kelurahan
    ADD CONSTRAINT ref_kelurahan_pk PRIMARY KEY (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan);


--
-- TOC entry 2415 (class 2606 OID 69942)
-- Name: ref_propinsi_pk; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_propinsi
    ADD CONSTRAINT ref_propinsi_pk PRIMARY KEY (kd_propinsi);


--
-- TOC entry 2419 (class 2606 OID 69944)
-- Name: tempat_pembayaran_pk; Type: CONSTRAINT; Schema: pbb; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tempat_pembayaran
    ADD CONSTRAINT tempat_pembayaran_pk PRIMARY KEY (kd_kanwil, kd_kantor, kd_tp);


SET search_path = public, pg_catalog;

--
-- TOC entry 2421 (class 2606 OID 69946)
-- Name: apps_nama_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY apps
    ADD CONSTRAINT apps_nama_key UNIQUE (nama);


--
-- TOC entry 2425 (class 2606 OID 69948)
-- Name: bphtb_payment_ntp_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_payment
    ADD CONSTRAINT bphtb_payment_ntp_key UNIQUE (ntp);


--
-- TOC entry 2427 (class 2606 OID 69950)
-- Name: bphtb_payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_payment
    ADD CONSTRAINT bphtb_payment_pkey PRIMARY KEY (id);


--
-- TOC entry 2429 (class 2606 OID 69952)
-- Name: bphtb_reversal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bphtb_reversal
    ADD CONSTRAINT bphtb_reversal_pkey PRIMARY KEY (id);


--
-- TOC entry 2431 (class 2606 OID 69954)
-- Name: group_modules_group_id_module_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY group_modules
    ADD CONSTRAINT group_modules_group_id_module_id_key UNIQUE (group_id, module_id);


--
-- TOC entry 2433 (class 2606 OID 69956)
-- Name: group_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY group_modules
    ADD CONSTRAINT group_modules_pkey PRIMARY KEY (id);


--
-- TOC entry 2435 (class 2606 OID 69958)
-- Name: groups_nama_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_nama_key UNIQUE (nama);


--
-- TOC entry 2437 (class 2606 OID 69960)
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- TOC entry 2439 (class 2606 OID 69962)
-- Name: modules_nama_app_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modules
    ADD CONSTRAINT modules_nama_app_id_key UNIQUE (nama, app_id);


--
-- TOC entry 2423 (class 2606 OID 69964)
-- Name: pk_apps; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY apps
    ADD CONSTRAINT pk_apps PRIMARY KEY (id);


--
-- TOC entry 2441 (class 2606 OID 69966)
-- Name: pk_modules; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY modules
    ADD CONSTRAINT pk_modules PRIMARY KEY (id);


--
-- TOC entry 2443 (class 2606 OID 69968)
-- Name: ref_jabatan_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ref_jabatan
    ADD CONSTRAINT ref_jabatan_pk PRIMARY KEY (kd_jabatan);


--
-- TOC entry 2445 (class 2606 OID 69970)
-- Name: user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 2447 (class 2606 OID 69972)
-- Name: user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_groups
    ADD CONSTRAINT user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- TOC entry 2449 (class 2606 OID 69974)
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2451 (class 2606 OID 69976)
-- Name: users_userid_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_userid_key UNIQUE (userid);


SET search_path = bphtb, pg_catalog;

--
-- TOC entry 2381 (class 1259 OID 69977)
-- Name: bphtb_validasi_bank_id_idx; Type: INDEX; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE INDEX bphtb_validasi_bank_id_idx ON bphtb_validasi USING btree (bank_id);


--
-- TOC entry 2336 (class 1259 OID 69978)
-- Name: ix_bphtb_inquiry_bank_id; Type: INDEX; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE INDEX ix_bphtb_inquiry_bank_id ON bphtb_inquiry USING btree (bank_id);


--
-- TOC entry 2337 (class 1259 OID 69979)
-- Name: ix_bphtb_inquiry_channel_id; Type: INDEX; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE INDEX ix_bphtb_inquiry_channel_id ON bphtb_inquiry USING btree (channel_id);


--
-- TOC entry 2338 (class 1259 OID 69980)
-- Name: ix_bphtb_inquiry_invoice_id; Type: INDEX; Schema: bphtb; Owner: postgres; Tablespace: 
--

CREATE INDEX ix_bphtb_inquiry_invoice_id ON bphtb_inquiry USING btree (invoice_id);


--
-- TOC entry 2477 (class 2620 OID 69981)
-- Name: bphtb_bank_bi_trg; Type: TRIGGER; Schema: bphtb; Owner: postgres
--

CREATE TRIGGER bphtb_bank_bi_trg BEFORE INSERT ON bphtb_bank FOR EACH ROW EXECUTE PROCEDURE public.f_bphtb_bank_bi();


--
-- TOC entry 2478 (class 2620 OID 69982)
-- Name: bphtb_bank_bu; Type: TRIGGER; Schema: bphtb; Owner: postgres
--

CREATE TRIGGER bphtb_bank_bu BEFORE UPDATE ON bphtb_bank FOR EACH ROW EXECUTE PROCEDURE public.f_bphtb_bank_bu();


--
-- TOC entry 2453 (class 2606 OID 69983)
-- Name: bphtb_berkas_in_det_berkas_in_id_fkey; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_berkas_in_det
    ADD CONSTRAINT bphtb_berkas_in_det_berkas_in_id_fkey FOREIGN KEY (berkas_in_id) REFERENCES bphtb_berkas_in(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2452 (class 2606 OID 69988)
-- Name: bphtb_berkas_in_ppat_id_fkey; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_berkas_in
    ADD CONSTRAINT bphtb_berkas_in_ppat_id_fkey FOREIGN KEY (ppat_id) REFERENCES bphtb_ppat(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2454 (class 2606 OID 69993)
-- Name: bphtb_berkas_out_ppat_id_fkey; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_berkas_out
    ADD CONSTRAINT bphtb_berkas_out_ppat_id_fkey FOREIGN KEY (ppat_id) REFERENCES bphtb_ppat(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2455 (class 2606 OID 69998)
-- Name: bphtb_inquiry_bank_id_fk; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_inquiry
    ADD CONSTRAINT bphtb_inquiry_bank_id_fk FOREIGN KEY (bank_id) REFERENCES bphtb_tp(id);


--
-- TOC entry 2456 (class 2606 OID 70003)
-- Name: bphtb_inquiry_channel_id_fk; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_inquiry
    ADD CONSTRAINT bphtb_inquiry_channel_id_fk FOREIGN KEY (channel_id) REFERENCES bphtb_channel(id);


--
-- TOC entry 2457 (class 2606 OID 70008)
-- Name: bphtb_sk_validasi_id_fk; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_sk
    ADD CONSTRAINT bphtb_sk_validasi_id_fk FOREIGN KEY (validasi_id) REFERENCES bphtb_validasi(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2460 (class 2606 OID 70013)
-- Name: bphtb_sspd_approval_sspd_fk; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_sspd_approval
    ADD CONSTRAINT bphtb_sspd_approval_sspd_fk FOREIGN KEY (sspd_id) REFERENCES bphtb_sspd(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2458 (class 2606 OID 70018)
-- Name: bphtb_sspd_perolehan_id_fk; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_sspd
    ADD CONSTRAINT bphtb_sspd_perolehan_id_fk FOREIGN KEY (perolehan_id) REFERENCES bphtb_perolehan(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2459 (class 2606 OID 70023)
-- Name: bphtb_sspd_ppat_id_fk; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_sspd
    ADD CONSTRAINT bphtb_sspd_ppat_id_fk FOREIGN KEY (ppat_id) REFERENCES bphtb_ppat(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2462 (class 2606 OID 70028)
-- Name: bphtb_validasi_level_kec_level_id_fkey; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_validasi_level_kec
    ADD CONSTRAINT bphtb_validasi_level_kec_level_id_fkey FOREIGN KEY (level_id) REFERENCES bphtb_validasi_level(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2461 (class 2606 OID 70033)
-- Name: bphtb_validasi_perolehan_id_fk; Type: FK CONSTRAINT; Schema: bphtb; Owner: postgres
--

ALTER TABLE ONLY bphtb_validasi
    ADD CONSTRAINT bphtb_validasi_perolehan_id_fk FOREIGN KEY (perolehan_id) REFERENCES bphtb_perolehan(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


SET search_path = pbb, pg_catalog;

--
-- TOC entry 2463 (class 2606 OID 70038)
-- Name: dph_kd_propinsi_fkey; Type: FK CONSTRAINT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY dph
    ADD CONSTRAINT dph_kd_propinsi_fkey FOREIGN KEY (kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan) REFERENCES ref_kelurahan(kd_propinsi, kd_dati2, kd_kecamatan, kd_kelurahan);


--
-- TOC entry 2464 (class 2606 OID 70043)
-- Name: dph_payment_dph_fkey; Type: FK CONSTRAINT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY dph_payment
    ADD CONSTRAINT dph_payment_dph_fkey FOREIGN KEY (dph_id) REFERENCES dph(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2465 (class 2606 OID 70048)
-- Name: ref_dati2_kd_propinsi_fkey; Type: FK CONSTRAINT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY ref_dati2
    ADD CONSTRAINT ref_dati2_kd_propinsi_fkey FOREIGN KEY (kd_propinsi) REFERENCES ref_propinsi(kd_propinsi);


--
-- TOC entry 2466 (class 2606 OID 70053)
-- Name: ref_dati2_prop_fk; Type: FK CONSTRAINT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY ref_dati2
    ADD CONSTRAINT ref_dati2_prop_fk FOREIGN KEY (kd_propinsi) REFERENCES ref_propinsi(kd_propinsi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2467 (class 2606 OID 70058)
-- Name: ref_kecamatan_dati2_fk; Type: FK CONSTRAINT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY ref_kecamatan
    ADD CONSTRAINT ref_kecamatan_dati2_fk FOREIGN KEY (kd_propinsi, kd_dati2) REFERENCES ref_dati2(kd_propinsi, kd_dati2) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2468 (class 2606 OID 70063)
-- Name: ref_kecamatan_kd_propinsi_fkey; Type: FK CONSTRAINT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY ref_kecamatan
    ADD CONSTRAINT ref_kecamatan_kd_propinsi_fkey FOREIGN KEY (kd_propinsi, kd_dati2) REFERENCES ref_dati2(kd_propinsi, kd_dati2);


--
-- TOC entry 2469 (class 2606 OID 70068)
-- Name: ref_kelurahan_kd_propinsi_fkey; Type: FK CONSTRAINT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY ref_kelurahan
    ADD CONSTRAINT ref_kelurahan_kd_propinsi_fkey FOREIGN KEY (kd_propinsi, kd_dati2, kd_kecamatan) REFERENCES ref_kecamatan(kd_propinsi, kd_dati2, kd_kecamatan);


--
-- TOC entry 2470 (class 2606 OID 70073)
-- Name: ref_kelurahan_kecamatan_fk; Type: FK CONSTRAINT; Schema: pbb; Owner: postgres
--

ALTER TABLE ONLY ref_kelurahan
    ADD CONSTRAINT ref_kelurahan_kecamatan_fk FOREIGN KEY (kd_propinsi, kd_dati2, kd_kecamatan) REFERENCES ref_kecamatan(kd_propinsi, kd_dati2, kd_kecamatan) ON UPDATE RESTRICT ON DELETE RESTRICT;


SET search_path = public, pg_catalog;

--
-- TOC entry 2471 (class 2606 OID 70088)
-- Name: bphtb_reversal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bphtb_reversal
    ADD CONSTRAINT bphtb_reversal_id_fkey FOREIGN KEY (id) REFERENCES bphtb_payment(id);


--
-- TOC entry 2472 (class 2606 OID 70093)
-- Name: group_modules_module_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_modules
    ADD CONSTRAINT group_modules_module_id_fkey FOREIGN KEY (module_id) REFERENCES modules(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2473 (class 2606 OID 70098)
-- Name: group_modules_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_modules
    ADD CONSTRAINT group_modules_user_id_fkey FOREIGN KEY (group_id) REFERENCES groups(id) MATCH FULL ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2474 (class 2606 OID 70103)
-- Name: modules_app_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY modules
    ADD CONSTRAINT modules_app_id_fkey FOREIGN KEY (app_id) REFERENCES apps(id);


--
-- TOC entry 2475 (class 2606 OID 70108)
-- Name: user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_groups
    ADD CONSTRAINT user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES groups(id);


--
-- TOC entry 2476 (class 2606 OID 70113)
-- Name: user_groups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_groups
    ADD CONSTRAINT user_groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- TOC entry 2676 (class 0 OID 0)
-- Dependencies: 9
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-12-12 17:28:50

--
-- PostgreSQL database dump complete
--

