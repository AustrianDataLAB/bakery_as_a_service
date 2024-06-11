--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

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
-- Name: Customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Customer" (
    id uuid NOT NULL,
    name character varying(255),
    email character varying(255),
    address character varying(255)
);


ALTER TABLE public."Customer" OWNER TO postgres;

--
-- Name: Order_Items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order_Items" (
    id uuid NOT NULL,
    order_id integer,
    quantity integer,
    price_per_item numeric(10,2),
    product_id uuid
);


ALTER TABLE public."Order_Items" OWNER TO postgres;

--
-- Name: Orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Orders" (
    id integer NOT NULL,
    date_created timestamp with time zone,
    customer_id uuid,
    status character varying(20),
    total_price numeric(10,2) NOT NULL
);


ALTER TABLE public."Orders" OWNER TO postgres;

--
-- Name: Orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Orders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Orders_id_seq" OWNER TO postgres;

--
-- Name: Orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Orders_id_seq" OWNED BY public."Orders".id;


--
-- Name: Products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Products" (
    id uuid NOT NULL,
    name character varying(100),
    description text,
    price numeric(10,2),
    image uuid
);


ALTER TABLE public."Products" OWNER TO postgres;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO postgres;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_activity_id_seq OWNER TO postgres;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO postgres;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO postgres;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO postgres;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO postgres;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_fields_id_seq OWNER TO postgres;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer
);


ALTER TABLE public.directus_files OWNER TO postgres;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO postgres;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO postgres;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO postgres;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO postgres;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_notifications_id_seq OWNER TO postgres;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO postgres;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(30) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO postgres;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text
);


ALTER TABLE public.directus_permissions OWNER TO postgres;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_permissions_id_seq OWNER TO postgres;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(30) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO postgres;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_presets_id_seq OWNER TO postgres;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO postgres;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_relations_id_seq OWNER TO postgres;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO postgres;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_revisions_id_seq OWNER TO postgres;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO postgres;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO postgres;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json
);


ALTER TABLE public.directus_settings OWNER TO postgres;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_settings_id_seq OWNER TO postgres;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO postgres;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO postgres;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json
);


ALTER TABLE public.directus_users OWNER TO postgres;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_versions OWNER TO postgres;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO postgres;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_webhooks_id_seq OWNER TO postgres;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: Orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders" ALTER COLUMN id SET DEFAULT nextval('public."Orders_id_seq"'::regclass);


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Customer" (id, name, email, address) FROM stdin;
f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	\N	\N
\.


--
-- Data for Name: Order_Items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order_Items" (id, order_id, quantity, price_per_item, product_id) FROM stdin;
56db6e22-f68f-4b65-8b55-124ab606ac27	101	1	123.00	\N
2255f8cd-5299-4ce4-ad86-f1f294e79a17	101	1	123.00	\N
0727bbf1-566d-4394-ae9a-f5a33e600243	101	1	123.00	\N
d5b4a39f-cf61-4e31-8c6d-4d757be7ff24	101	1	123.00	\N
c8722bd2-d0d8-42b3-a39f-c94166544f70	101	1	123.00	\N
5a621beb-d607-41ae-8065-ccd882a15d60	101	1	123.00	\N
2a929fd8-b719-4d8d-b7b5-3e94e799b58f	101	1	123.00	\N
5d6156bb-0af6-46d1-8224-106d7f4ca769	101	1	123.00	\N
4dc2004f-91d3-49dd-bf74-e13ba04dd4a2	101	1	123.00	\N
46ca07e3-ed46-4696-8d47-ad5f56a9bfaa	101	1	123.00	\N
3b1c7c79-e30a-4e47-a8e8-1154cef60134	101	1	123.00	\N
0b9bb35a-5b4d-4c09-80cd-e6970fdce55a	101	1	123.00	\N
0f646613-1271-4fad-a7df-efb8f6b4c5d9	101	1	123.00	\N
b85e519f-92c1-4644-a446-87ce37415f79	101	1	123.00	\N
5e402599-798c-48d0-917e-d30a1f413ba7	101	1	123.00	\N
7017b603-a4fa-4134-ba6b-bfa9c4ae5d3a	101	1	123.00	\N
8def2be9-20c6-4641-8427-d7b646342031	101	1	123.00	\N
8ee453da-b682-4b1a-abac-52435c648d28	101	1	123.00	\N
9ad325e3-86c4-4e41-b991-a997298c8143	101	1	123.00	\N
138eebc4-9de2-4bcb-b9fd-09b0df2aa8e9	101	1	123.00	\N
ffb4f8ae-a415-43f2-bbc1-24d44ce74d42	134	1	123.00	\N
317d4372-5ac2-47b2-a997-645ea46a6b11	134	1	123.00	\N
f9bab8d9-bf1d-428b-a349-f483c4cefca7	134	1	123.00	\N
fab3589e-2efb-4089-96e3-a8a43ed0eec5	134	1	123.00	\N
0b5601d0-0cb3-4ee5-aba9-8e7e846de607	134	1	123.00	\N
067ffe6e-a81e-4953-a7df-b956bf254c8f	134	1	123.00	\N
7eeae9a0-58c4-48f0-a872-474f876cfcf3	134	1	123.00	\N
507e9421-f74c-4bf8-a0b0-4000b8d0afd9	134	1	123.00	\N
0d48e50a-4885-45e1-8add-34b335896820	134	1	123.00	\N
0ee20a49-a22d-4f10-a659-084a1399187a	134	1	123.00	\N
29e7a1b1-eab3-44db-ace5-b890fc5fdbac	134	1	123.00	\N
f90fd08d-3890-4929-bc2c-ac4777341c5a	134	1	123.00	\N
841796e6-44e1-41d1-9815-5783f84b13bb	134	1	123.00	\N
878eb042-98c7-459e-9326-fcf730e5d13f	134	1	123.00	\N
3cb2fae4-3069-429d-acf8-6439b7fb911f	134	1	123.00	\N
def4eeb3-495f-4ad3-9256-5f874f3f2c4f	134	1	123.00	\N
7cd9adeb-952d-4640-bdeb-87ca0bda3766	134	1	123.00	\N
e769bb7d-7128-4f2b-a1ae-03f13a6f38c4	134	1	123.00	\N
616768bd-a3eb-457b-87e0-3fe67809e542	134	1	123.00	\N
823e5861-ae7c-43e0-afb8-665d5f91fc91	134	1	123.00	\N
8f13af9c-5d29-4a86-a0a0-e2eadcfa4740	134	1	123.00	\N
7af299cc-9bd1-4acb-b244-d3d5789d03dd	134	1	123.00	\N
c5aa8929-2e01-4569-9ad6-c93d4f460ecb	134	1	123.00	\N
7624e6fc-ecf4-4ea1-aee6-0b0df7b9899f	134	1	123.00	\N
d269375e-7cd8-4029-b08e-db405736171d	134	1	123.00	\N
c80c2fdf-8e7f-4b37-b8ec-bcda9b149ad7	134	1	123.00	\N
e08c49c9-cf53-43fa-86a3-3d22c5bb844e	134	1	123.00	\N
d9381d1a-0db2-489b-966c-b0109bf46aee	134	1	123.00	\N
360e2125-8b44-427f-99d4-cf3e996a9308	134	1	123.00	\N
b34be2d6-f442-4cc1-9c24-f15305bef5a6	134	1	123.00	\N
6130d467-62b3-4416-b7dc-f730663e00c3	134	1	123.00	\N
02b0939f-9346-4f46-91f2-abcef74107f3	134	1	123.00	\N
fa36296a-3a4a-4857-8042-2c105ee54ce0	134	1	123.00	\N
e13d5fc0-23a6-43d4-b802-accf174e54f6	134	1	123.00	\N
32cacd74-9f12-46ed-a503-a4c3f8185c31	134	1	123.00	\N
872b3920-9a58-48d6-b7da-6c9a828debdb	167	241	123.00	\N
7e245581-3162-440e-bf2b-9364d1ae34fd	200	100	12300.00	\N
9ad8866b-2d69-452f-997a-786047970573	233	100	123.00	\N
b6459fb0-e35c-41c5-92ae-6991976ecd03	266	100	123.00	\N
e3af0ed5-7cee-49c2-98a5-af77e2a7a573	267	100	123.00	\N
\.


--
-- Data for Name: Orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Orders" (id, date_created, customer_id, status, total_price) FROM stdin;
68	2024-05-23 14:20:48.454+00	f665a758-29c1-40f3-8cbd-7662d66fb5de	ordered	123.00
101	2024-05-24 05:54:49.708+00	f665a758-29c1-40f3-8cbd-7662d66fb5de	ordered	2460.00
134	2024-05-27 16:27:08.5+00	f665a758-29c1-40f3-8cbd-7662d66fb5de	ordered	4305.00
167	2024-05-28 06:43:51.749+00	f665a758-29c1-40f3-8cbd-7662d66fb5de	ordered	123.00
200	2024-05-28 06:45:17.284+00	f665a758-29c1-40f3-8cbd-7662d66fb5de	ordered	123.00
233	2024-05-28 06:48:23.325+00	f665a758-29c1-40f3-8cbd-7662d66fb5de	ordered	12300.00
266	2024-05-28 06:49:00.853+00	f665a758-29c1-40f3-8cbd-7662d66fb5de	ordered	12300.00
267	2024-05-28 06:50:29.667+00	f665a758-29c1-40f3-8cbd-7662d66fb5de	ordered	12300.00
\.


--
-- Data for Name: Products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Products" (id, name, description, price, image) FROM stdin;
0aa6bd72-a1a9-4b49-bd80-c0aeec64390c	Mischbrot	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2.99	a7cb75ac-c5a6-41b0-9c33-1c14f2cfd2a7
de811aba-1969-4b86-a838-7c969c19ab29	Schwarzbrot	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	3.99	b654f730-e04e-47a7-be4a-3808027a7f8c
b74a5132-bfef-46ba-932a-cd9696836d06	Semmel	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	0.42	9b112f00-c32d-4136-8c65-345eaf11ca76
7686b29d-139d-4901-ba37-175ddc2607c3	Punschkrapfen	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	0.99	ea21fca0-2efc-42bb-ac96-b6ef0ade2ab3
0cbaf097-c465-435a-adbe-df092ca8fc8c	Krapfen	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	1.29	ece0936e-da37-4272-93dd-f7cab0b0b359
ae218272-5ab3-4b51-832a-3b9640cf5abe	Topfengolatsche	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	0.99	0db8bdeb-e4e4-45eb-b921-ab71df8ecff2
2b897808-8aa9-4a1c-98cd-676ad363172c	Striezel	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	2.99	fc41a2fc-3c3c-43d5-9880-dc9752132cc8
876f58ef-c17a-4c5d-971f-4c39e7362a16	Kipferl	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	0.89	08f79c4a-3e49-44d3-ba9b-d1a870b816b7
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment, origin) FROM stdin;
1	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:23:12.995+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
2	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:24:31.82+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	1	\N	http://localhost:8055
3	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:24:31.834+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_collections	Customer	\N	http://localhost:8055
4	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:25:20.118+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	2	\N	http://localhost:8055
5	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:25:39.204+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	3	\N	http://localhost:8055
6	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:25:53.288+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	4	\N	http://localhost:8055
7	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:46:41.767+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	5	\N	http://localhost:8055
8	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:46:41.779+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	6	\N	http://localhost:8055
9	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:46:41.783+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_collections	Orders	\N	http://localhost:8055
10	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:57:53.291+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	7	\N	http://localhost:8055
11	update	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:58:27.717+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	6	\N	http://localhost:8055
12	update	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-05 11:59:29.043+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	7	\N	http://localhost:8055
13	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 15:14:47.288+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	8	\N	http://localhost:8055
14	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 16:26:48.236+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	9	\N	http://localhost:8055
15	update	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 16:29:39.64+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	1	\N	http://localhost:8055
16	update	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 16:30:15.681+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	1	\N	http://localhost:8055
17	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 16:30:58.042+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	10	\N	http://localhost:8055
18	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 16:35:42.612+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	\N	http://localhost:8055
19	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:12:31.867+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	11	\N	http://localhost:8055
20	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:14:38.543+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	12	\N	http://localhost:8055
21	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:21:58.897+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	13	\N	http://localhost:8055
22	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:21:58.909+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_collections	Order_Items	\N	http://localhost:8055
23	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:24:14.934+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	14	\N	http://localhost:8055
24	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:27:59.553+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	15	\N	http://localhost:8055
25	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:27:59.565+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_collections	Products	\N	http://localhost:8055
26	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:28:49.851+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	16	\N	http://localhost:8055
27	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:29:14.225+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	17	\N	http://localhost:8055
28	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:29:54.375+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	18	\N	http://localhost:8055
29	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:30:59.082+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	19	\N	http://localhost:8055
30	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:31:25.606+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	20	\N	http://localhost:8055
31	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:32:09.072+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	21	\N	http://localhost:8055
32	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:32:09.15+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_fields	22	\N	http://localhost:8055
33	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-06 17:32:09.154+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_collections	Pro	\N	http://localhost:8055
34	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-12 19:59:21.144+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
35	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-12 20:02:36.238+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
36	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-12 20:09:29.132+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
37	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-13 16:35:46.428+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
70	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-20 12:32:28.742+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
71	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:29:27.41+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
72	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:30:01.917+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
104	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:30:59.691+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	1	\N	http://localhost:8055
107	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:30:59.696+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	4	\N	http://localhost:8055
106	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:30:59.693+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	2	\N	http://localhost:8055
105	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:30:59.693+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	3	\N	http://localhost:8055
108	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:30:59.732+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	5	\N	http://localhost:8055
137	delete	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:31:57.422+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	1	\N	http://localhost:8055
138	delete	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:31:57.432+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	2	\N	http://localhost:8055
139	delete	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:31:57.434+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	3	\N	http://localhost:8055
140	delete	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:31:57.435+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	4	\N	http://localhost:8055
141	delete	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:31:57.436+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	5	\N	http://localhost:8055
142	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:32:00.081+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_permissions	34	\N	http://localhost:8055
170	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:34:53.193+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159	\N	http://localhost:8055
203	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 04:45:25.585+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
236	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 05:38:29.599+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
269	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 08:00:57.729+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
302	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 08:10:33.179+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
368	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 14:10:17.793+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
403	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 14:20:48.432+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Customer	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
404	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 14:20:48.46+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Orders	68	\N	http://localhost:4200
405	run	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 14:20:48.481+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	\N	http://localhost:4200
436	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-23 17:53:18.737+00	10.89.6.64	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
437	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:33:47.817+00	10.89.6.69	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
470	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:34:24.982+00	10.89.6.69	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
602	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:52:34.12+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
635	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.754+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Orders	101	\N	http://localhost:4200
636	run	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.773+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	\N	http://localhost:4200
637	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.798+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	56db6e22-f68f-4b65-8b55-124ab606ac27	\N	http://localhost:4200
638	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.803+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	2255f8cd-5299-4ce4-ad86-f1f294e79a17	\N	http://localhost:4200
639	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.807+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	0727bbf1-566d-4394-ae9a-f5a33e600243	\N	http://localhost:4200
640	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.81+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	d5b4a39f-cf61-4e31-8c6d-4d757be7ff24	\N	http://localhost:4200
641	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.814+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	c8722bd2-d0d8-42b3-a39f-c94166544f70	\N	http://localhost:4200
642	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.817+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	5a621beb-d607-41ae-8065-ccd882a15d60	\N	http://localhost:4200
643	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.82+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	2a929fd8-b719-4d8d-b7b5-3e94e799b58f	\N	http://localhost:4200
644	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.823+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	5d6156bb-0af6-46d1-8224-106d7f4ca769	\N	http://localhost:4200
645	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.825+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	4dc2004f-91d3-49dd-bf74-e13ba04dd4a2	\N	http://localhost:4200
646	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.828+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	46ca07e3-ed46-4696-8d47-ad5f56a9bfaa	\N	http://localhost:4200
647	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.83+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	3b1c7c79-e30a-4e47-a8e8-1154cef60134	\N	http://localhost:4200
648	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.833+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	0b9bb35a-5b4d-4c09-80cd-e6970fdce55a	\N	http://localhost:4200
649	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.835+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	0f646613-1271-4fad-a7df-efb8f6b4c5d9	\N	http://localhost:4200
650	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.838+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	b85e519f-92c1-4644-a446-87ce37415f79	\N	http://localhost:4200
651	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.84+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	5e402599-798c-48d0-917e-d30a1f413ba7	\N	http://localhost:4200
652	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.842+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	7017b603-a4fa-4134-ba6b-bfa9c4ae5d3a	\N	http://localhost:4200
653	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.845+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	8def2be9-20c6-4641-8427-d7b646342031	\N	http://localhost:4200
654	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.848+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	8ee453da-b682-4b1a-abac-52435c648d28	\N	http://localhost:4200
655	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.851+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	9ad325e3-86c4-4e41-b991-a997298c8143	\N	http://localhost:4200
656	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-24 05:54:49.853+00	10.89.6.74	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	138eebc4-9de2-4bcb-b9fd-09b0df2aa8e9	\N	http://localhost:4200
668	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:26:19.185+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
701	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.526+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Orders	134	\N	http://localhost:4200
702	run	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.545+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	\N	http://localhost:4200
703	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.576+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	ffb4f8ae-a415-43f2-bbc1-24d44ce74d42	\N	http://localhost:4200
704	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.581+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	317d4372-5ac2-47b2-a997-645ea46a6b11	\N	http://localhost:4200
705	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.586+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	f9bab8d9-bf1d-428b-a349-f483c4cefca7	\N	http://localhost:4200
706	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.59+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	fab3589e-2efb-4089-96e3-a8a43ed0eec5	\N	http://localhost:4200
707	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.594+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	0b5601d0-0cb3-4ee5-aba9-8e7e846de607	\N	http://localhost:4200
708	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.598+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	067ffe6e-a81e-4953-a7df-b956bf254c8f	\N	http://localhost:4200
709	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.6+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	7eeae9a0-58c4-48f0-a872-474f876cfcf3	\N	http://localhost:4200
710	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.603+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	507e9421-f74c-4bf8-a0b0-4000b8d0afd9	\N	http://localhost:4200
711	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.606+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	0d48e50a-4885-45e1-8add-34b335896820	\N	http://localhost:4200
712	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.609+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	0ee20a49-a22d-4f10-a659-084a1399187a	\N	http://localhost:4200
713	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.612+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	29e7a1b1-eab3-44db-ace5-b890fc5fdbac	\N	http://localhost:4200
714	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.615+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	f90fd08d-3890-4929-bc2c-ac4777341c5a	\N	http://localhost:4200
715	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.617+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	841796e6-44e1-41d1-9815-5783f84b13bb	\N	http://localhost:4200
716	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.62+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	878eb042-98c7-459e-9326-fcf730e5d13f	\N	http://localhost:4200
717	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.623+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	3cb2fae4-3069-429d-acf8-6439b7fb911f	\N	http://localhost:4200
718	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.626+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	def4eeb3-495f-4ad3-9256-5f874f3f2c4f	\N	http://localhost:4200
719	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.629+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	7cd9adeb-952d-4640-bdeb-87ca0bda3766	\N	http://localhost:4200
720	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.631+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	e769bb7d-7128-4f2b-a1ae-03f13a6f38c4	\N	http://localhost:4200
721	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.635+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	616768bd-a3eb-457b-87e0-3fe67809e542	\N	http://localhost:4200
722	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.637+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	823e5861-ae7c-43e0-afb8-665d5f91fc91	\N	http://localhost:4200
723	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.64+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	8f13af9c-5d29-4a86-a0a0-e2eadcfa4740	\N	http://localhost:4200
724	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.643+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	7af299cc-9bd1-4acb-b244-d3d5789d03dd	\N	http://localhost:4200
725	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.646+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	c5aa8929-2e01-4569-9ad6-c93d4f460ecb	\N	http://localhost:4200
726	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.648+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	7624e6fc-ecf4-4ea1-aee6-0b0df7b9899f	\N	http://localhost:4200
727	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.651+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	d269375e-7cd8-4029-b08e-db405736171d	\N	http://localhost:4200
728	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.653+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	c80c2fdf-8e7f-4b37-b8ec-bcda9b149ad7	\N	http://localhost:4200
729	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.655+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	e08c49c9-cf53-43fa-86a3-3d22c5bb844e	\N	http://localhost:4200
730	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.658+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	d9381d1a-0db2-489b-966c-b0109bf46aee	\N	http://localhost:4200
731	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.66+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	360e2125-8b44-427f-99d4-cf3e996a9308	\N	http://localhost:4200
732	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.663+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	b34be2d6-f442-4cc1-9c24-f15305bef5a6	\N	http://localhost:4200
733	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.665+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	6130d467-62b3-4416-b7dc-f730663e00c3	\N	http://localhost:4200
734	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.668+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	02b0939f-9346-4f46-91f2-abcef74107f3	\N	http://localhost:4200
735	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.67+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	fa36296a-3a4a-4857-8042-2c105ee54ce0	\N	http://localhost:4200
736	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.673+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	e13d5fc0-23a6-43d4-b802-accf174e54f6	\N	http://localhost:4200
737	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:08.676+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	32cacd74-9f12-46ed-a503-a4c3f8185c31	\N	http://localhost:4200
767	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-27 16:27:38.516+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
800	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:29:11.633+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
833	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:43:51.794+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Orders	167	\N	http://localhost:4200
834	run	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:43:51.824+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	\N	http://localhost:4200
835	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:43:51.857+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	872b3920-9a58-48d6-b7da-6c9a828debdb	\N	http://localhost:4200
866	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:45:10.288+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
867	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:45:17.302+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Orders	200	\N	http://localhost:4200
868	run	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:45:17.325+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	\N	http://localhost:4200
869	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:45:17.364+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	7e245581-3162-440e-bf2b-9364d1ae34fd	\N	http://localhost:4200
899	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:48:23.372+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Orders	233	\N	http://localhost:4200
900	run	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:48:23.389+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	\N	http://localhost:4200
901	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:48:23.404+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	9ad8866b-2d69-452f-997a-786047970573	\N	http://localhost:4200
932	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:49:00.898+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Orders	266	\N	http://localhost:4200
933	run	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:49:00.915+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	\N	http://localhost:4200
934	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:49:00.929+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	b6459fb0-e35c-41c5-92ae-6991976ecd03	\N	http://localhost:4200
935	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:50:29.696+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Orders	267	\N	http://localhost:4200
936	run	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:50:29.709+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	\N	http://localhost:4200
937	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-05-28 06:50:29.723+00	10.89.6.4	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Order_Items	e3af0ed5-7cee-49c2-98a5-af77e2a7a573	\N	http://localhost:4200
938	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:27:56.655+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:8055
939	delete	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:28:18.91+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_collections	Pro	\N	http://localhost:8055
971	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:28:47.67+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_fields	23	\N	http://localhost:8055
972	delete	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:29:09.798+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159	\N	http://localhost:8055
1004	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:30:31.166+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_files	e49daaba-5cf4-4b3f-97a0-ace3abdd55a0	\N	http://localhost:8055
1005	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:30:39.256+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	6f5c8007-184e-4a46-b9b6-1ddbf70f0afd	\N	http://localhost:8055
1006	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:30:55.331+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4201
1007	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:36:00.147+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
1040	delete	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:39:03.684+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	6f5c8007-184e-4a46-b9b6-1ddbf70f0afd	\N	http://localhost:8055
1073	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:42:20.526+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_fields	56	\N	http://localhost:8055
1106	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:42:37.513+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_files	a7cb75ac-c5a6-41b0-9c33-1c14f2cfd2a7	\N	http://localhost:8055
1107	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:42:38.851+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	0aa6bd72-a1a9-4b49-bd80-c0aeec64390c	\N	http://localhost:8055
1139	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:46:29.683+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_files	b654f730-e04e-47a7-be4a-3808027a7f8c	\N	http://localhost:8055
1140	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:46:32.989+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	de811aba-1969-4b86-a838-7c969c19ab29	\N	http://localhost:8055
1172	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:46:44.653+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_files	9b112f00-c32d-4136-8c65-345eaf11ca76	\N	http://localhost:8055
1173	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:46:45.525+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	b74a5132-bfef-46ba-932a-cd9696836d06	\N	http://localhost:8055
1174	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:46:57.991+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_files	ea21fca0-2efc-42bb-ac96-b6ef0ade2ab3	\N	http://localhost:8055
1175	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:46:58.779+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	7686b29d-139d-4901-ba37-175ddc2607c3	\N	http://localhost:8055
1205	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:47:21.269+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_files	ece0936e-da37-4272-93dd-f7cab0b0b359	\N	http://localhost:8055
1206	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:47:23.223+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	0cbaf097-c465-435a-adbe-df092ca8fc8c	\N	http://localhost:8055
1238	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:47:44.247+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_files	0db8bdeb-e4e4-45eb-b921-ab71df8ecff2	\N	http://localhost:8055
1239	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:47:47.038+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	ae218272-5ab3-4b51-832a-3b9640cf5abe	\N	http://localhost:8055
1240	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:47:58.988+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_files	fc41a2fc-3c3c-43d5-9880-dc9752132cc8	\N	http://localhost:8055
1241	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:48:00.301+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	2b897808-8aa9-4a1c-98cd-676ad363172c	\N	http://localhost:8055
1242	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:48:13.309+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_files	08f79c4a-3e49-44d3-ba9b-d1a870b816b7	\N	http://localhost:8055
1243	create	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:48:17.227+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	Products	876f58ef-c17a-4c5d-971f-4c39e7362a16	\N	http://localhost:8055
1244	login	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 10:07:23.253+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	directus_users	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	http://localhost:4200
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
Customer	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
Orders	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
Order_Items	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
Products	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
2	Customer	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	t	\N	\N	\N
3	Customer	email	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	t	\N	\N	\N
4	Customer	address	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	t	\N	\N	\N
5	Orders	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
6	Orders	date_created	date-created	datetime	\N	datetime	{"relative":true}	f	f	2	half	\N	\N	\N	t	\N	\N	\N
1	Customer	id	uuid	input	\N	\N	\N	t	f	1	full	\N	\N	\N	t	\N	\N	\N
10	Orders	customer_id	m2o	select-dropdown-m2o	{"template":null}	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
11	Orders	status	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
12	Orders	total_price	\N	input	{"min":0}	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
13	Order_Items	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
14	Order_Items	order_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
15	Products	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
16	Products	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
17	Products	description	\N	input-multiline	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
18	Products	price	\N	\N	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
19	Order_Items	quantity	\N	\N	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
20	Order_Items	price_per_item	\N	\N	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
21	Order_Items	product_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
56	Products	image	file	file-image	\N	\N	\N	f	f	5	full	\N	\N	\N	t	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y) FROM stdin;
e49daaba-5cf4-4b3f-97a0-ace3abdd55a0	local	e49daaba-5cf4-4b3f-97a0-ace3abdd55a0.jpeg	mischbrot.jpeg	Mischbrot	image/jpeg	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:30:31.143541+00	\N	2024-06-11 07:30:31.196+00	\N	258312	1800	1013	\N	\N	\N	\N	\N	{"ifd0":{"Make":"Hasselblad","Model":"Hasselblad H3DII-39MS"},"exif":{"FNumber":9.5,"ExposureTime":0.0013333333333333333,"FocalLength":120,"ISOSpeedRatings":100}}	\N	\N
a7cb75ac-c5a6-41b0-9c33-1c14f2cfd2a7	local	a7cb75ac-c5a6-41b0-9c33-1c14f2cfd2a7.jpeg	mischbrot.jpeg	Mischbrot	image/jpeg	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:42:37.479866+00	\N	2024-06-11 07:42:37.545+00	\N	258312	1800	1013	\N	\N	\N	\N	\N	{"ifd0":{"Make":"Hasselblad","Model":"Hasselblad H3DII-39MS"},"exif":{"FNumber":9.5,"ExposureTime":0.0013333333333333333,"FocalLength":120,"ISOSpeedRatings":100}}	\N	\N
b654f730-e04e-47a7-be4a-3808027a7f8c	local	b654f730-e04e-47a7-be4a-3808027a7f8c.jpeg	schwarzbrot.jpeg	Schwarzbrot	image/jpeg	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:46:29.66252+00	\N	2024-06-11 07:46:29.706+00	\N	248915	960	720	\N	\N	\N	\N	\N	{}	\N	\N
9b112f00-c32d-4136-8c65-345eaf11ca76	local	9b112f00-c32d-4136-8c65-345eaf11ca76.jpeg	semmel.jpeg	Semmel	image/jpeg	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:46:44.619117+00	\N	2024-06-11 07:46:44.693+00	\N	66630	900	500	\N	\N	\N	\N	\N	{}	\N	\N
ea21fca0-2efc-42bb-ac96-b6ef0ade2ab3	local	ea21fca0-2efc-42bb-ac96-b6ef0ade2ab3.jpeg	punschkrapfen.jpeg	Punschkrapfen	image/jpeg	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:46:57.965645+00	\N	2024-06-11 07:46:58.011+00	\N	172937	1280	853	\N	\N	\N	\N	\N	{}	\N	\N
ece0936e-da37-4272-93dd-f7cab0b0b359	local	ece0936e-da37-4272-93dd-f7cab0b0b359.jpeg	krapfen.jpeg	Krapfen	image/jpeg	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:47:21.229466+00	\N	2024-06-11 07:47:21.303+00	\N	147583	1024	682	\N	\N	\N	\N	\N	{}	\N	\N
0db8bdeb-e4e4-45eb-b921-ab71df8ecff2	local	0db8bdeb-e4e4-45eb-b921-ab71df8ecff2.jpeg	topfengolatsche.jpeg	Topfengolatsche	image/jpeg	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:47:44.208779+00	\N	2024-06-11 07:47:44.29+00	\N	288744	620	434	\N	\N	\N	\N	\N	{}	\N	\N
fc41a2fc-3c3c-43d5-9880-dc9752132cc8	local	fc41a2fc-3c3c-43d5-9880-dc9752132cc8.jpeg	striezel.jpeg	Striezel	image/jpeg	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:47:58.963445+00	\N	2024-06-11 07:47:59.011+00	\N	277243	620	434	\N	\N	\N	\N	\N	{}	\N	\N
08f79c4a-3e49-44d3-ba9b-d1a870b816b7	local	08f79c4a-3e49-44d3-ba9b-d1a870b816b7.jpg	kipferl.jpg	Kipferl	image/jpeg	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-11 07:48:13.284797+00	\N	2024-06-11 07:48:13.336+00	\N	743359	1920	1280	\N	\N	\N	\N	\N	{"ifd0":{"Make":"NIKON CORPORATION","Model":"NIKON D90"},"exif":{"FNumber":22,"ExposureTime":0.016666666666666666,"FocalLength":105,"ISOSpeedRatings":400}}	\N	\N
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
957264c4-d8a0-43c7-902f-0e09170bd5a1	DocumentService	apk_document	#3399FF	\N	active	event	all	{"type":"action","scope":["items.create"],"collections":["Orders"]}	\N	2024-05-06 16:35:42.59+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2024-05-05 11:21:53.647887+00
20201029A	Remove System Relations	2024-05-05 11:21:53.654772+00
20201029B	Remove System Collections	2024-05-05 11:21:53.657847+00
20201029C	Remove System Fields	2024-05-05 11:21:53.663631+00
20201105A	Add Cascade System Relations	2024-05-05 11:21:53.69148+00
20201105B	Change Webhook URL Type	2024-05-05 11:21:53.695386+00
20210225A	Add Relations Sort Field	2024-05-05 11:21:53.698288+00
20210304A	Remove Locked Fields	2024-05-05 11:21:53.700563+00
20210312A	Webhooks Collections Text	2024-05-05 11:21:53.703201+00
20210331A	Add Refresh Interval	2024-05-05 11:21:53.704302+00
20210415A	Make Filesize Nullable	2024-05-05 11:21:53.707274+00
20210416A	Add Collections Accountability	2024-05-05 11:21:53.7099+00
20210422A	Remove Files Interface	2024-05-05 11:21:53.711139+00
20210506A	Rename Interfaces	2024-05-05 11:21:53.718685+00
20210510A	Restructure Relations	2024-05-05 11:21:53.732201+00
20210518A	Add Foreign Key Constraints	2024-05-05 11:21:53.738974+00
20210519A	Add System Fk Triggers	2024-05-05 11:21:53.755163+00
20210521A	Add Collections Icon Color	2024-05-05 11:21:53.756522+00
20210525A	Add Insights	2024-05-05 11:21:53.767632+00
20210608A	Add Deep Clone Config	2024-05-05 11:21:53.768834+00
20210626A	Change Filesize Bigint	2024-05-05 11:21:53.77677+00
20210716A	Add Conditions to Fields	2024-05-05 11:21:53.77783+00
20210721A	Add Default Folder	2024-05-05 11:21:53.780744+00
20210802A	Replace Groups	2024-05-05 11:21:53.782823+00
20210803A	Add Required to Fields	2024-05-05 11:21:53.784164+00
20210805A	Update Groups	2024-05-05 11:21:53.786187+00
20210805B	Change Image Metadata Structure	2024-05-05 11:21:53.788143+00
20210811A	Add Geometry Config	2024-05-05 11:21:53.789364+00
20210831A	Remove Limit Column	2024-05-05 11:21:53.790402+00
20210903A	Add Auth Provider	2024-05-05 11:21:53.797898+00
20210907A	Webhooks Collections Not Null	2024-05-05 11:21:53.800236+00
20210910A	Move Module Setup	2024-05-05 11:21:53.801657+00
20210920A	Webhooks URL Not Null	2024-05-05 11:21:53.804447+00
20210924A	Add Collection Organization	2024-05-05 11:21:53.807203+00
20210927A	Replace Fields Group	2024-05-05 11:21:53.811109+00
20210927B	Replace M2M Interface	2024-05-05 11:21:53.812146+00
20210929A	Rename Login Action	2024-05-05 11:21:53.813093+00
20211007A	Update Presets	2024-05-05 11:21:53.815753+00
20211009A	Add Auth Data	2024-05-05 11:21:53.816786+00
20211016A	Add Webhook Headers	2024-05-05 11:21:53.817674+00
20211103A	Set Unique to User Token	2024-05-05 11:21:53.819578+00
20211103B	Update Special Geometry	2024-05-05 11:21:53.820625+00
20211104A	Remove Collections Listing	2024-05-05 11:21:53.821614+00
20211118A	Add Notifications	2024-05-05 11:21:53.830232+00
20211211A	Add Shares	2024-05-05 11:21:53.84072+00
20211230A	Add Project Descriptor	2024-05-05 11:21:53.841812+00
20220303A	Remove Default Project Color	2024-05-05 11:21:53.844889+00
20220308A	Add Bookmark Icon and Color	2024-05-05 11:21:53.84615+00
20220314A	Add Translation Strings	2024-05-05 11:21:53.847164+00
20220322A	Rename Field Typecast Flags	2024-05-05 11:21:53.849242+00
20220323A	Add Field Validation	2024-05-05 11:21:53.850393+00
20220325A	Fix Typecast Flags	2024-05-05 11:21:53.852507+00
20220325B	Add Default Language	2024-05-05 11:21:53.856054+00
20220402A	Remove Default Value Panel Icon	2024-05-05 11:21:53.858679+00
20220429A	Add Flows	2024-05-05 11:21:53.877318+00
20220429B	Add Color to Insights Icon	2024-05-05 11:21:53.878505+00
20220429C	Drop Non Null From IP of Activity	2024-05-05 11:21:53.879511+00
20220429D	Drop Non Null From Sender of Notifications	2024-05-05 11:21:53.880436+00
20220614A	Rename Hook Trigger to Event	2024-05-05 11:21:53.881434+00
20220801A	Update Notifications Timestamp Column	2024-05-05 11:21:53.884189+00
20220802A	Add Custom Aspect Ratios	2024-05-05 11:21:53.88524+00
20220826A	Add Origin to Accountability	2024-05-05 11:21:53.886546+00
20230401A	Update Material Icons	2024-05-05 11:21:53.889732+00
20230525A	Add Preview Settings	2024-05-05 11:21:53.890691+00
20230526A	Migrate Translation Strings	2024-05-05 11:21:53.896667+00
20230721A	Require Shares Fields	2024-05-05 11:21:53.898916+00
20230823A	Add Content Versioning	2024-05-05 11:21:53.909038+00
20230927A	Themes	2024-05-05 11:21:53.916939+00
20231009A	Update CSV Fields to Text	2024-05-05 11:21:53.91858+00
20231009B	Update Panel Options	2024-05-05 11:21:53.919793+00
20231010A	Add Extensions	2024-05-05 11:21:53.922186+00
20231215A	Add Focalpoints	2024-05-05 11:21:53.923276+00
20240122A	Add Report URL Fields	2024-05-05 11:21:53.924731+00
20240204A	Marketplace	2024-05-05 11:21:53.935781+00
20240305A	Change Useragent Type	2024-05-05 11:21:53.939173+00
20240311A	Deprecate Webhooks	2024-05-05 11:21:53.943799+00
20240422A	Public Registration	2024-05-23 04:29:14.15482+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields) FROM stdin;
34	\N	Products	read	{}	{}	\N	*
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	Orders	customer_id	Customer	\N	\N	\N	\N	\N	nullify
2	Order_Items	order_id	Orders	\N	\N	\N	\N	\N	nullify
3	Order_Items	product_id	Products	\N	\N	\N	\N	\N	nullify
37	Products	image	directus_files	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_fields	1	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"Customer"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"Customer"}	\N	\N
2	3	directus_collections	Customer	{"singleton":false,"collection":"Customer"}	{"singleton":false,"collection":"Customer"}	\N	\N
3	4	directus_fields	2	{"sort":2,"interface":"input","special":null,"required":true,"collection":"Customer","field":"name"}	{"sort":2,"interface":"input","special":null,"required":true,"collection":"Customer","field":"name"}	\N	\N
4	5	directus_fields	3	{"sort":3,"interface":"input","special":null,"required":true,"collection":"Customer","field":"email"}	{"sort":3,"interface":"input","special":null,"required":true,"collection":"Customer","field":"email"}	\N	\N
5	6	directus_fields	4	{"sort":4,"interface":"input","special":null,"required":true,"collection":"Customer","field":"address"}	{"sort":4,"interface":"input","special":null,"required":true,"collection":"Customer","field":"address"}	\N	\N
6	7	directus_fields	5	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Orders"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"Orders"}	\N	\N
7	8	directus_fields	6	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Orders"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"Orders"}	\N	\N
8	9	directus_collections	Orders	{"singleton":false,"collection":"Orders"}	{"singleton":false,"collection":"Orders"}	\N	\N
9	10	directus_fields	7	{"sort":3,"interface":"input","special":null,"collection":"Orders","field":"customer_id"}	{"sort":3,"interface":"input","special":null,"collection":"Orders","field":"customer_id"}	\N	\N
10	11	directus_fields	6	{"id":6,"collection":"Orders","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":false,"hidden":false,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Orders","field":"date_created","readonly":false,"hidden":false,"required":true}	\N	\N
11	12	directus_fields	7	{"id":7,"collection":"Orders","field":"customer_id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Orders","field":"customer_id","width":"half"}	\N	\N
12	13	directus_fields	8	{"sort":3,"special":["alias","no-data","group"],"collection":"Orders","field":"customer_id"}	{"sort":3,"special":["alias","no-data","group"],"collection":"Orders","field":"customer_id"}	\N	\N
13	14	directus_fields	9	{"sort":3,"interface":"input","special":["uuid"],"collection":"Orders","field":"customer_id"}	{"sort":3,"interface":"input","special":["uuid"],"collection":"Orders","field":"customer_id"}	\N	\N
14	15	directus_fields	1	{"id":1,"collection":"Customer","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"Customer","field":"id","hidden":false}	\N	\N
15	16	directus_fields	1	{"id":1,"collection":"Customer","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":false,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"Customer","field":"id","required":true}	\N	\N
16	17	directus_fields	10	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":null},"collection":"Orders","field":"customer_id"}	{"sort":3,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":null},"collection":"Orders","field":"customer_id"}	\N	\N
17	18	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	{"name":"DocumentService","icon":"apk_document","color":"#3399FF","description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["Orders"]}}	{"name":"DocumentService","icon":"apk_document","color":"#3399FF","description":null,"status":"active","accountability":"all","trigger":"event","options":{"type":"action","scope":["items.create"],"collections":["Orders"]}}	\N	\N
18	19	directus_fields	11	{"sort":4,"interface":"input","special":null,"collection":"Orders","field":"status"}	{"sort":4,"interface":"input","special":null,"collection":"Orders","field":"status"}	\N	\N
19	20	directus_fields	12	{"sort":5,"interface":"input","special":null,"options":{"min":0},"collection":"Orders","field":"total_price"}	{"sort":5,"interface":"input","special":null,"options":{"min":0},"collection":"Orders","field":"total_price"}	\N	\N
20	21	directus_fields	13	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"Order_Items"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"Order_Items"}	\N	\N
21	22	directus_collections	Order_Items	{"singleton":false,"collection":"Order_Items"}	{"singleton":false,"collection":"Order_Items"}	\N	\N
22	23	directus_fields	14	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"Order_Items","field":"order_id"}	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"Order_Items","field":"order_id"}	\N	\N
23	24	directus_fields	15	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"Products"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"Products"}	\N	\N
24	25	directus_collections	Products	{"singleton":false,"collection":"Products"}	{"singleton":false,"collection":"Products"}	\N	\N
25	26	directus_fields	16	{"sort":2,"interface":"input","special":null,"collection":"Products","field":"name"}	{"sort":2,"interface":"input","special":null,"collection":"Products","field":"name"}	\N	\N
26	27	directus_fields	17	{"sort":3,"interface":"input-multiline","special":null,"collection":"Products","field":"description"}	{"sort":3,"interface":"input-multiline","special":null,"collection":"Products","field":"description"}	\N	\N
27	28	directus_fields	18	{"sort":4,"special":null,"collection":"Products","field":"price"}	{"sort":4,"special":null,"collection":"Products","field":"price"}	\N	\N
28	29	directus_fields	19	{"sort":3,"special":null,"collection":"Order_Items","field":"quantity"}	{"sort":3,"special":null,"collection":"Order_Items","field":"quantity"}	\N	\N
29	30	directus_fields	20	{"sort":4,"special":null,"collection":"Order_Items","field":"price_per_item"}	{"sort":4,"special":null,"collection":"Order_Items","field":"price_per_item"}	\N	\N
30	31	directus_fields	21	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"Order_Items","field":"product_id"}	{"sort":5,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"Order_Items","field":"product_id"}	\N	\N
31	32	directus_fields	22	{"sort":1,"hidden":true,"field":"id","collection":"Pro"}	{"sort":1,"hidden":true,"field":"id","collection":"Pro"}	\N	\N
32	33	directus_collections	Pro	{"collection":"Pro"}	{"collection":"Pro"}	\N	\N
35	104	directus_permissions	1	{"role":null,"collection":"Products","action":"update","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Products","action":"update","fields":["*"],"permissions":{},"validation":{}}	\N	\N
33	105	directus_permissions	3	{"role":null,"collection":"Products","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Products","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N	\N
36	106	directus_permissions	2	{"role":null,"collection":"Products","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Products","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N	\N
34	107	directus_permissions	4	{"role":null,"collection":"Products","action":"share","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Products","action":"share","fields":["*"],"permissions":{},"validation":{}}	\N	\N
37	108	directus_permissions	5	{"role":null,"collection":"Products","action":"delete","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Products","action":"delete","fields":["*"],"permissions":{},"validation":{}}	\N	\N
66	142	directus_permissions	34	{"role":null,"collection":"Products","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"Products","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N	\N
99	170	Products	bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159	{"name":"test","description":"test","price":123}	{"name":"test","description":"test","price":123}	\N	\N
134	404	Orders	68	{"date_created":"2024-05-23T14:20:48.344Z","customer_id":{"id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","app_access":true,"admin_access":true,"iat":1716473417,"exp":1716474317,"iss":"directus"},"status":"ordered","total_price":"0123.00"}	{"date_created":"2024-05-23T14:20:48.344Z","customer_id":{"id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","app_access":true,"admin_access":true,"iat":1716473417,"exp":1716474317,"iss":"directus"},"status":"ordered","total_price":"0123.00"}	\N	\N
133	403	Customer	f665a758-29c1-40f3-8cbd-7662d66fb5de	{"id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","app_access":true,"admin_access":true,"iat":1716473417,"exp":1716474317,"iss":"directus"}	{"id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","app_access":true,"admin_access":true,"iat":1716473417,"exp":1716474317,"iss":"directus"}	134	\N
135	405	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	{"steps":[],"data":{"$trigger":{"event":"Orders.items.create","payload":{"date_created":"2024-05-23T14:20:48.344Z","customer_id":{"id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","app_access":true,"admin_access":true,"iat":1716473417,"exp":1716474317,"iss":"directus"},"status":"ordered","total_price":"0123.00"},"key":68,"collection":"Orders"},"$last":{"event":"Orders.items.create","payload":{"date_created":"2024-05-23T14:20:48.344Z","customer_id":{"id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","app_access":true,"admin_access":true,"iat":1716473417,"exp":1716474317,"iss":"directus"},"status":"ordered","total_price":"0123.00"},"key":68,"collection":"Orders"},"$accountability":{"user":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","admin":true,"app":true,"ip":"10.89.6.64","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36","origin":"http://localhost:4200"},"$env":{}}}	\N	\N	\N
166	635	Orders	101	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":2460}	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":2460}	\N	\N
167	636	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	{"steps":[],"data":{"$trigger":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":2460},"key":101,"collection":"Orders"},"$last":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":2460},"key":101,"collection":"Orders"},"$accountability":{"user":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","admin":true,"app":true,"ip":"10.89.6.74","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36","origin":"http://localhost:4200"},"$env":{}}}	\N	\N	\N
168	637	Order_Items	56db6e22-f68f-4b65-8b55-124ab606ac27	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
169	638	Order_Items	2255f8cd-5299-4ce4-ad86-f1f294e79a17	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
170	639	Order_Items	0727bbf1-566d-4394-ae9a-f5a33e600243	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
171	640	Order_Items	d5b4a39f-cf61-4e31-8c6d-4d757be7ff24	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
172	641	Order_Items	c8722bd2-d0d8-42b3-a39f-c94166544f70	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
173	642	Order_Items	5a621beb-d607-41ae-8065-ccd882a15d60	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
174	643	Order_Items	2a929fd8-b719-4d8d-b7b5-3e94e799b58f	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
175	644	Order_Items	5d6156bb-0af6-46d1-8224-106d7f4ca769	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
176	645	Order_Items	4dc2004f-91d3-49dd-bf74-e13ba04dd4a2	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
177	646	Order_Items	46ca07e3-ed46-4696-8d47-ad5f56a9bfaa	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
178	647	Order_Items	3b1c7c79-e30a-4e47-a8e8-1154cef60134	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
179	648	Order_Items	0b9bb35a-5b4d-4c09-80cd-e6970fdce55a	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
180	649	Order_Items	0f646613-1271-4fad-a7df-efb8f6b4c5d9	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
181	650	Order_Items	b85e519f-92c1-4644-a446-87ce37415f79	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
182	651	Order_Items	5e402599-798c-48d0-917e-d30a1f413ba7	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
183	652	Order_Items	7017b603-a4fa-4134-ba6b-bfa9c4ae5d3a	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
184	653	Order_Items	8def2be9-20c6-4641-8427-d7b646342031	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
185	654	Order_Items	8ee453da-b682-4b1a-abac-52435c648d28	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
186	655	Order_Items	9ad325e3-86c4-4e41-b991-a997298c8143	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
187	656	Order_Items	138eebc4-9de2-4bcb-b9fd-09b0df2aa8e9	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":101,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
199	701	Orders	134	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":4305}	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":4305}	\N	\N
200	702	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	{"steps":[],"data":{"$trigger":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":4305},"key":134,"collection":"Orders"},"$last":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":4305},"key":134,"collection":"Orders"},"$accountability":{"user":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","admin":true,"app":true,"ip":"10.89.6.4","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36","origin":"http://localhost:4200"},"$env":{}}}	\N	\N	\N
201	703	Order_Items	ffb4f8ae-a415-43f2-bbc1-24d44ce74d42	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
202	704	Order_Items	317d4372-5ac2-47b2-a997-645ea46a6b11	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
203	705	Order_Items	f9bab8d9-bf1d-428b-a349-f483c4cefca7	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
204	706	Order_Items	fab3589e-2efb-4089-96e3-a8a43ed0eec5	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
205	707	Order_Items	0b5601d0-0cb3-4ee5-aba9-8e7e846de607	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
206	708	Order_Items	067ffe6e-a81e-4953-a7df-b956bf254c8f	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
207	709	Order_Items	7eeae9a0-58c4-48f0-a872-474f876cfcf3	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
208	710	Order_Items	507e9421-f74c-4bf8-a0b0-4000b8d0afd9	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
209	711	Order_Items	0d48e50a-4885-45e1-8add-34b335896820	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
210	712	Order_Items	0ee20a49-a22d-4f10-a659-084a1399187a	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
211	713	Order_Items	29e7a1b1-eab3-44db-ace5-b890fc5fdbac	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
212	714	Order_Items	f90fd08d-3890-4929-bc2c-ac4777341c5a	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
213	715	Order_Items	841796e6-44e1-41d1-9815-5783f84b13bb	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
214	716	Order_Items	878eb042-98c7-459e-9326-fcf730e5d13f	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
215	717	Order_Items	3cb2fae4-3069-429d-acf8-6439b7fb911f	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
216	718	Order_Items	def4eeb3-495f-4ad3-9256-5f874f3f2c4f	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
217	719	Order_Items	7cd9adeb-952d-4640-bdeb-87ca0bda3766	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
218	720	Order_Items	e769bb7d-7128-4f2b-a1ae-03f13a6f38c4	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
219	721	Order_Items	616768bd-a3eb-457b-87e0-3fe67809e542	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
220	722	Order_Items	823e5861-ae7c-43e0-afb8-665d5f91fc91	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
221	723	Order_Items	8f13af9c-5d29-4a86-a0a0-e2eadcfa4740	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
222	724	Order_Items	7af299cc-9bd1-4acb-b244-d3d5789d03dd	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
223	725	Order_Items	c5aa8929-2e01-4569-9ad6-c93d4f460ecb	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
224	726	Order_Items	7624e6fc-ecf4-4ea1-aee6-0b0df7b9899f	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
225	727	Order_Items	d269375e-7cd8-4029-b08e-db405736171d	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
226	728	Order_Items	c80c2fdf-8e7f-4b37-b8ec-bcda9b149ad7	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
227	729	Order_Items	e08c49c9-cf53-43fa-86a3-3d22c5bb844e	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
228	730	Order_Items	d9381d1a-0db2-489b-966c-b0109bf46aee	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
229	731	Order_Items	360e2125-8b44-427f-99d4-cf3e996a9308	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
230	732	Order_Items	b34be2d6-f442-4cc1-9c24-f15305bef5a6	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
231	733	Order_Items	6130d467-62b3-4416-b7dc-f730663e00c3	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
232	734	Order_Items	02b0939f-9346-4f46-91f2-abcef74107f3	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
233	735	Order_Items	fa36296a-3a4a-4857-8042-2c105ee54ce0	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
234	736	Order_Items	e13d5fc0-23a6-43d4-b802-accf174e54f6	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
235	737	Order_Items	32cacd74-9f12-46ed-a503-a4c3f8185c31	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":134,"quantity":1,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
265	833	Orders	167	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":123}	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":123}	\N	\N
266	834	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	{"steps":[],"data":{"$trigger":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":123},"key":167,"collection":"Orders"},"$last":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":123},"key":167,"collection":"Orders"},"$accountability":{"user":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","admin":true,"app":true,"ip":"10.89.6.4","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36","origin":"http://localhost:4200"},"$env":{}}}	\N	\N	\N
267	835	Order_Items	872b3920-9a58-48d6-b7da-6c9a828debdb	{"order_id":167,"quantity":241,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":167,"quantity":241,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
298	867	Orders	200	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":123}	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":123}	\N	\N
299	868	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	{"steps":[],"data":{"$trigger":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":123},"key":200,"collection":"Orders"},"$last":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":123},"key":200,"collection":"Orders"},"$accountability":{"user":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","admin":true,"app":true,"ip":"10.89.6.4","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36","origin":"http://localhost:4200"},"$env":{}}}	\N	\N	\N
300	869	Order_Items	7e245581-3162-440e-bf2b-9364d1ae34fd	{"order_id":200,"quantity":100,"price_per_item":12300,"product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":200,"quantity":100,"price_per_item":12300,"product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
331	899	Orders	233	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300}	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300}	\N	\N
332	900	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	{"steps":[],"data":{"$trigger":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300},"key":233,"collection":"Orders"},"$last":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300},"key":233,"collection":"Orders"},"$accountability":{"user":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","admin":true,"app":true,"ip":"10.89.6.4","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36","origin":"http://localhost:4200"},"$env":{}}}	\N	\N	\N
333	901	Order_Items	9ad8866b-2d69-452f-997a-786047970573	{"order_id":233,"quantity":100,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":233,"quantity":100,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
364	932	Orders	266	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300}	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300}	\N	\N
365	933	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	{"steps":[],"data":{"$trigger":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300},"key":266,"collection":"Orders"},"$last":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300},"key":266,"collection":"Orders"},"$accountability":{"user":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","admin":true,"app":true,"ip":"10.89.6.4","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36","origin":"http://localhost:4200"},"$env":{}}}	\N	\N	\N
366	934	Order_Items	b6459fb0-e35c-41c5-92ae-6991976ecd03	{"order_id":266,"quantity":100,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":266,"quantity":100,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
367	935	Orders	267	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300}	{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300}	\N	\N
368	936	directus_flows	957264c4-d8a0-43c7-902f-0e09170bd5a1	{"steps":[],"data":{"$trigger":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300},"key":267,"collection":"Orders"},"$last":{"event":"Orders.items.create","payload":{"customer_id":"f665a758-29c1-40f3-8cbd-7662d66fb5de","status":"ordered","total_price":12300},"key":267,"collection":"Orders"},"$accountability":{"user":"f665a758-29c1-40f3-8cbd-7662d66fb5de","role":"7805fa26-4186-495e-b6e4-f8a28bbaa44f","admin":true,"app":true,"ip":"10.89.6.4","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36","origin":"http://localhost:4200"},"$env":{}}}	\N	\N	\N
369	937	Order_Items	e3af0ed5-7cee-49c2-98a5-af77e2a7a573	{"order_id":267,"quantity":100,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	{"order_id":267,"quantity":100,"price_per_item":"123.00","product_id":"bb4e6eac-6fbd-4fd7-8164-29a3b8bc7159"}	\N	\N
370	971	directus_fields	23	{"sort":5,"interface":"file-image","special":["file"],"required":true,"options":{"folder":null},"collection":"Products","field":"image"}	{"sort":5,"interface":"file-image","special":["file"],"required":true,"options":{"folder":null},"collection":"Products","field":"image"}	\N	\N
403	1004	directus_files	e49daaba-5cf4-4b3f-97a0-ace3abdd55a0	{"title":"Mischbrot","filename_download":"mischbrot.jpeg","type":"image/jpeg","storage":"local"}	{"title":"Mischbrot","filename_download":"mischbrot.jpeg","type":"image/jpeg","storage":"local"}	\N	\N
404	1005	Products	6f5c8007-184e-4a46-b9b6-1ddbf70f0afd	{"name":"Mischbrot","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ullamcorper sit amet risus nullam. Sem integer vitae justo eget magna. Eu volutpat odio facilisis mauris sit. Nunc sed blandit libero volutpat sed. In ornare quam viverra orci sagittis eu volutpat. Cursus metus aliquam eleifend mi in nulla posuere. Sed adipiscing diam donec adipiscing. Ultricies mi quis hendrerit dolor magna eget est lorem ipsum. Malesuada proin libero nunc consequat interdum varius sit.","price":2.99,"image":"e49daaba-5cf4-4b3f-97a0-ace3abdd55a0"}	{"name":"Mischbrot","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ullamcorper sit amet risus nullam. Sem integer vitae justo eget magna. Eu volutpat odio facilisis mauris sit. Nunc sed blandit libero volutpat sed. In ornare quam viverra orci sagittis eu volutpat. Cursus metus aliquam eleifend mi in nulla posuere. Sed adipiscing diam donec adipiscing. Ultricies mi quis hendrerit dolor magna eget est lorem ipsum. Malesuada proin libero nunc consequat interdum varius sit.","price":2.99,"image":"e49daaba-5cf4-4b3f-97a0-ace3abdd55a0"}	\N	\N
405	1073	directus_fields	56	{"sort":5,"interface":"file-image","special":["file"],"required":true,"collection":"Products","field":"image"}	{"sort":5,"interface":"file-image","special":["file"],"required":true,"collection":"Products","field":"image"}	\N	\N
438	1106	directus_files	a7cb75ac-c5a6-41b0-9c33-1c14f2cfd2a7	{"title":"Mischbrot","filename_download":"mischbrot.jpeg","type":"image/jpeg","storage":"local"}	{"title":"Mischbrot","filename_download":"mischbrot.jpeg","type":"image/jpeg","storage":"local"}	\N	\N
439	1107	Products	0aa6bd72-a1a9-4b49-bd80-c0aeec64390c	{"name":"Mischbrot","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":2.99,"image":"a7cb75ac-c5a6-41b0-9c33-1c14f2cfd2a7"}	{"name":"Mischbrot","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":2.99,"image":"a7cb75ac-c5a6-41b0-9c33-1c14f2cfd2a7"}	\N	\N
471	1139	directus_files	b654f730-e04e-47a7-be4a-3808027a7f8c	{"title":"Schwarzbrot","filename_download":"schwarzbrot.jpeg","type":"image/jpeg","storage":"local"}	{"title":"Schwarzbrot","filename_download":"schwarzbrot.jpeg","type":"image/jpeg","storage":"local"}	\N	\N
472	1140	Products	de811aba-1969-4b86-a838-7c969c19ab29	{"name":"Schwarzbrot","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":3.99,"image":"b654f730-e04e-47a7-be4a-3808027a7f8c"}	{"name":"Schwarzbrot","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":3.99,"image":"b654f730-e04e-47a7-be4a-3808027a7f8c"}	\N	\N
504	1172	directus_files	9b112f00-c32d-4136-8c65-345eaf11ca76	{"title":"Semmel","filename_download":"semmel.jpeg","type":"image/jpeg","storage":"local"}	{"title":"Semmel","filename_download":"semmel.jpeg","type":"image/jpeg","storage":"local"}	\N	\N
505	1173	Products	b74a5132-bfef-46ba-932a-cd9696836d06	{"name":"Semmel","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":0.42,"image":"9b112f00-c32d-4136-8c65-345eaf11ca76"}	{"name":"Semmel","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":0.42,"image":"9b112f00-c32d-4136-8c65-345eaf11ca76"}	\N	\N
506	1174	directus_files	ea21fca0-2efc-42bb-ac96-b6ef0ade2ab3	{"title":"Punschkrapfen","filename_download":"punschkrapfen.jpeg","type":"image/jpeg","storage":"local"}	{"title":"Punschkrapfen","filename_download":"punschkrapfen.jpeg","type":"image/jpeg","storage":"local"}	\N	\N
507	1175	Products	7686b29d-139d-4901-ba37-175ddc2607c3	{"name":"Punschkrapfen","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":0.99,"image":"ea21fca0-2efc-42bb-ac96-b6ef0ade2ab3"}	{"name":"Punschkrapfen","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":0.99,"image":"ea21fca0-2efc-42bb-ac96-b6ef0ade2ab3"}	\N	\N
537	1205	directus_files	ece0936e-da37-4272-93dd-f7cab0b0b359	{"title":"Krapfen","filename_download":"krapfen.jpeg","type":"image/jpeg","storage":"local"}	{"title":"Krapfen","filename_download":"krapfen.jpeg","type":"image/jpeg","storage":"local"}	\N	\N
538	1206	Products	0cbaf097-c465-435a-adbe-df092ca8fc8c	{"name":"Krapfen","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":1.29,"image":"ece0936e-da37-4272-93dd-f7cab0b0b359"}	{"name":"Krapfen","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":1.29,"image":"ece0936e-da37-4272-93dd-f7cab0b0b359"}	\N	\N
570	1238	directus_files	0db8bdeb-e4e4-45eb-b921-ab71df8ecff2	{"title":"Topfengolatsche","filename_download":"topfengolatsche.jpeg","type":"image/jpeg","storage":"local"}	{"title":"Topfengolatsche","filename_download":"topfengolatsche.jpeg","type":"image/jpeg","storage":"local"}	\N	\N
571	1239	Products	ae218272-5ab3-4b51-832a-3b9640cf5abe	{"name":"Topfengolatsche","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":0.99,"image":"0db8bdeb-e4e4-45eb-b921-ab71df8ecff2"}	{"name":"Topfengolatsche","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":0.99,"image":"0db8bdeb-e4e4-45eb-b921-ab71df8ecff2"}	\N	\N
572	1240	directus_files	fc41a2fc-3c3c-43d5-9880-dc9752132cc8	{"title":"Striezel","filename_download":"striezel.jpeg","type":"image/jpeg","storage":"local"}	{"title":"Striezel","filename_download":"striezel.jpeg","type":"image/jpeg","storage":"local"}	\N	\N
573	1241	Products	2b897808-8aa9-4a1c-98cd-676ad363172c	{"name":"Striezel","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":2.99,"image":"fc41a2fc-3c3c-43d5-9880-dc9752132cc8"}	{"name":"Striezel","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":2.99,"image":"fc41a2fc-3c3c-43d5-9880-dc9752132cc8"}	\N	\N
574	1242	directus_files	08f79c4a-3e49-44d3-ba9b-d1a870b816b7	{"title":"Kipferl","filename_download":"kipferl.jpg","type":"image/jpeg","storage":"local"}	{"title":"Kipferl","filename_download":"kipferl.jpg","type":"image/jpeg","storage":"local"}	\N	\N
575	1243	Products	876f58ef-c17a-4c5d-971f-4c39e7362a16	{"name":"Kipferl","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":0.89,"image":"08f79c4a-3e49-44d3-ba9b-d1a870b816b7"}	{"name":"Kipferl","description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.","price":0.89,"image":"08f79c4a-3e49-44d3-ba9b-d1a870b816b7"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
7805fa26-4186-495e-b6e4-f8a28bbaa44f	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin) FROM stdin;
iJVUOnVerKjYjEZhhOzjUbxR6LXRR0jfYk1W7nX-ZAoPrm1B2JJ-TtoaQiyLqUwj	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-18 07:30:55.295+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	\N	http://localhost:4201
C-8MKfvw9bH2Lcri9Mw9QlNBTdoN8QhWUFaYxE-fDiLoaJXCyWr86bFto3KCHLQh	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-18 07:36:00.103+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	\N	http://localhost:4200
Ih-q4ckTIpIYKkfawKZQf7qZZ0iKCOuiH7WbZvmMkmhgMlNe9Pyagp9_i_H4ycHf	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-18 10:07:23.204+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	\N	http://localhost:4200
zImkQjYRCR4W7Mmvy9_mEB_bdjzdYODzsm3A-8HPEKDoGcD0HU2n47MkFJGb1bwF	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-18 11:05:58.828+00	192.168.127.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	\N	http://localhost:8055
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter) FROM stdin;
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides) FROM stdin;
f665a758-29c1-40f3-8cbd-7662d66fb5de	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$PyC70XI4XGyQ5J0RLbB3UA$TVqh6tb2GHBagjq8CUyhuw4bExoVpOQNhnSk/hdx3Gw	\N	\N	\N	\N	\N	\N	\N	active	7805fa26-4186-495e-b6e4-f8a28bbaa44f	\N	2024-06-11 11:05:58.831+00	/content/Products	default	\N	\N	t	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Name: Orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Orders_id_seq"', 267, true);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 1276, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 88, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 66, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 69, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 575, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: Customer Customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Customer"
    ADD CONSTRAINT "Customer_pkey" PRIMARY KEY (id);


--
-- Name: Order_Items Order_Items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Items"
    ADD CONSTRAINT "Order_Items_pkey" PRIMARY KEY (id);


--
-- Name: Orders Orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_pkey" PRIMARY KEY (id);


--
-- Name: Products Products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_pkey" PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: Order_Items order_items_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Items"
    ADD CONSTRAINT order_items_order_id_foreign FOREIGN KEY (order_id) REFERENCES public."Orders"(id) ON DELETE SET NULL;


--
-- Name: Order_Items order_items_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order_Items"
    ADD CONSTRAINT order_items_product_id_foreign FOREIGN KEY (product_id) REFERENCES public."Products"(id) ON DELETE SET NULL;


--
-- Name: Orders orders_customer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT orders_customer_id_foreign FOREIGN KEY (customer_id) REFERENCES public."Customer"(id) ON DELETE SET NULL;


--
-- Name: Products products_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT products_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

