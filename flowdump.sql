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
-- Name: Pro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Pro" (
    id integer NOT NULL
);


ALTER TABLE public."Pro" OWNER TO postgres;

--
-- Name: Pro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Pro_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Pro_id_seq" OWNER TO postgres;

--
-- Name: Pro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Pro_id_seq" OWNED BY public."Pro".id;


--
-- Name: Products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Products" (
    id uuid NOT NULL,
    name character varying(100),
    description text,
    price numeric(10,2)
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
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test (
    id integer NOT NULL
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_id_seq OWNER TO postgres;

--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- Name: Orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders" ALTER COLUMN id SET DEFAULT nextval('public."Orders_id_seq"'::regclass);


--
-- Name: Pro id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pro" ALTER COLUMN id SET DEFAULT nextval('public."Pro_id_seq"'::regclass);


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
-- Name: test id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- Data for Name: Customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Customer" (id, name, email, address) FROM stdin;
550e8400-e29b-41d4-a716-446655440000	John Doe	john.doe@example.com	1234 Main St, Anytown, USA
550e8400-e29b-41d4-a716-446655440001	Jane Smith	jane.smith@example.com	5678 Market St, Anytown, USA
550e8400-e29b-41d4-a716-446655440002	Alice Johnson	alice.johnson@example.com	91011 Broadway, Anytown, USA
550e8400-e29b-41d4-a716-446655440003	Bob Brown	bob.brown@example.com	1213 Center St, Anytown, USA
550e8400-e29b-41d4-a716-446655440004	Carol White	carol.white@example.com	1415 Oak St, Anytown, USA
\.


--
-- Data for Name: Order_Items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order_Items" (id, order_id, quantity, price_per_item, product_id) FROM stdin;
123e4567-e89b-12d3-a456-426614174000	1	2	1.25	3fa85f64-5717-4562-b3fc-2c963f66afa6
123e4567-e89b-12d3-a456-426614174001	1	3	2.50	3fa85f64-5717-4562-b3fc-2c963f66afa7
123e4567-e89b-12d3-a456-426614174002	2	4	1.00	3fa85f64-5717-4562-b3fc-2c963f66afa8
123e4567-e89b-12d3-a456-426614174003	2	2	4.00	3fa85f64-5717-4562-b3fc-2c963f66afa9
123e4567-e89b-12d3-a456-426614174004	3	1	40.00	3fa85f64-5717-4562-b3fc-2c963f66afaa
123e4567-e89b-12d3-a456-426614174005	4	6	0.50	3fa85f64-5717-4562-b3fc-2c963f66afab
123e4567-e89b-12d3-a456-426614174006	4	2	5.00	3fa85f64-5717-4562-b3fc-2c963f66afac
123e4567-e89b-12d3-a456-426614174007	5	8	7.50	3fa85f64-5717-4562-b3fc-2c963f66afad
\.


--
-- Data for Name: Orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Orders" (id, date_created, customer_id, status, total_price) FROM stdin;
2	2024-05-28 07:54:31.399+00	550e8400-e29b-41d4-a716-446655440001	active	30.00
3	2024-05-28 07:54:31.402+00	550e8400-e29b-41d4-a716-446655440002	inactive	40.00
4	2024-05-28 07:54:31.404+00	550e8400-e29b-41d4-a716-446655440003	active	50.00
1	2024-05-27 07:54:00+00	550e8400-e29b-41d4-a716-446655440000	active	25.00
5	2024-05-27 07:54:00+00	550e8400-e29b-41d4-a716-446655440004	inactive	60.00
\.


--
-- Data for Name: Pro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Pro" (id) FROM stdin;
\.


--
-- Data for Name: Products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Products" (id, name, description, price) FROM stdin;
3fa85f64-5717-4562-b3fc-2c963f66afa6	Brot	Frisches handgebackenes Brot	1.25
3fa85f64-5717-4562-b3fc-2c963f66afa7	Croissant	Buttercroissant, frisch aus dem Ofen	2.50
3fa85f64-5717-4562-b3fc-2c963f66afa8	Brötchen	Knusprige Brötchen, ideal fürs Frühstück	1.00
3fa85f64-5717-4562-b3fc-2c963f66afa9	Kuchen	Hausgemachter Schokoladenkuchen	4.00
3fa85f64-5717-4562-b3fc-2c963f66afaa	Geburtstagstorte	Große Geburtstagstorte mit Schokoladenüberzug	40.00
3fa85f64-5717-4562-b3fc-2c963f66afab	Donut	Donut mit Zuckerglasur	0.50
3fa85f64-5717-4562-b3fc-2c963f66afac	Pastete	Herzhafte Pastete mit Fleischfüllung	5.00
3fa85f64-5717-4562-b3fc-2c963f66afad	Vollkornbrot	Gesundes Vollkornbrot, reich an Ballaststoffen	7.50
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment, origin) FROM stdin;
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
Customer	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
Orders	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
Order_Items	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
Products	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
Pro	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
test	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
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
6	Orders	date_created	date-created	datetime	\N	datetime	{"relative":true}	f	f	2	half	\N	\N	\N	t	\N	\N	\N
1	Customer	id	uuid	input	\N	\N	\N	t	f	1	full	\N	\N	\N	t	\N	\N	\N
10	Orders	customer_id	m2o	select-dropdown-m2o	{"template":null}	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
11	Orders	status	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
12	Orders	total_price	\N	input	{"min":0}	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
13	Order_Items	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
14	Order_Items	order_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
16	Products	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	f	\N	\N	\N
17	Products	description	\N	input-multiline	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
18	Products	price	\N	\N	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
19	Order_Items	quantity	\N	\N	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N
20	Order_Items	price_per_item	\N	\N	\N	\N	\N	f	f	4	full	\N	\N	\N	f	\N	\N	\N
21	Order_Items	product_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N
22	Pro	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
15	Products	id	uuid	input	\N	\N	\N	t	f	1	full	\N	\N	\N	f	\N	\N	\N
24	test	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
5	Orders	id	\N	input	\N	\N	\N	t	f	1	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y) FROM stdin;
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
ae749fa6-501a-401c-97d4-1e821414e551	InvoiceFlow	bolt	\N	\N	active	webhook	all	{"method":"POST"}	c20639ab-7442-46bc-bdf2-f9a28e6ab60e	2024-06-20 11:50:17.1+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
957264c4-d8a0-43c7-902f-0e09170bd5a1	DocumentService	apk_document	#3399FF	\N	inactive	schedule	all	{"cron":"0 23 * * *"}	\N	2024-05-06 16:35:42.59+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
00526ceb-f4f6-4262-8846-6ee20df1b76e	DocumentService	bolt	\N	\N	active	schedule	all	{"cron":"0 0 * * *"}	91b92787-d7cf-4ef3-8a5a-a25c6a143abf	2024-05-27 21:23:10.291+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
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
20240422A	Public Registration	2024-05-21 20:27:52.182372+00
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
4de61673-90a0-4dc7-8ffe-d30b2bf49445	Run Script	exec_3e5xk	exec	18	20	{"code":"module.exports = async function(data) {\\n    // Log the entire data object to understand its structure\\n    console.log('Data from previous step:', data);\\n\\n    // Assuming 'data' contains the result of the previous step\\n    // Replace 'item_read_6hv3y' with the actual key from your previous step\\n    const orderItems = {{item_read_dqroa}}\\n\\n    // Log the orders to verify the input data\\n    console.log('Order Items:', orderItems);\\n\\n    if (!orderItems || !Array.isArray(orderItems)) {\\n        // Log an error message if orders is not an array or is undefined\\n        console.error('Order Item data is not available or is not an array');\\n        return {\\n            productIds: [] // Return an empty array or handle as needed\\n        };\\n    }\\n\\n    // Extract order item IDs (using 'id' field)\\n    const productIds = orderItems.map(product => product.product_id);\\n\\n    // Log the extracted order item IDs\\n    console.log('Extracted Order Item IDs:', productIds);\\n\\n    // Return the extracted IDs for the next step\\n    return {\\n        productIds: productIds\\n    };\\n};\\n"}	0945363e-99e9-47bb-8c6c-fe6ad351973f	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-06-12 12:51:38.76+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
a3cd79bc-feaf-4cdd-8a67-ac705262dc6f	Read Data	item_read_dqroa	item-read	1	20	{"permissions":"$full","collection":"Order_Items","query":{"filter":{"order_id":{"_in":"{{ extraction_key_id.orderItemIds }}"}}},"key":[]}	4de61673-90a0-4dc7-8ffe-d30b2bf49445	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-05-27 21:34:42.875+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
f94129e5-6575-4151-858a-edb3ba7d5dce	Read Data	item_read_6hv3y	item-read	32	1	{"collection":"Orders","permissions":"$full","query":{"filter":{"date_created":{"_gte":"{{$last.startDate}}","_lte":"{{$last.endDate}}"}}}}	7525e912-04e5-4f8b-b959-1db0e6d04656	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-05-27 21:34:42.897+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
91b92787-d7cf-4ef3-8a5a-a25c6a143abf	Run Script	exec_oxwb8	exec	16	1	{"code":"module.exports = async function(data) {\\n\\tconst now = new Date();\\n\\tconst startOfYesterday = new Date(now.getFullYear(), now.getMonth(), now.getDate() - 1);\\n\\tconst endOfYesterday = new Date(now.getFullYear(), now.getMonth(), now.getDate() - 1, 23, 59, 59);\\n\\nreturn {\\n  startDate: startOfYesterday.toISOString(),\\n  endDate: endOfYesterday.toISOString()\\n};\\n}"}	f94129e5-6575-4151-858a-edb3ba7d5dce	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-06-21 08:02:31.984+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
2b8a787d-6f3f-4554-8fe3-a85b139aedb2	Log to Console	log_4lr9f	log	75	26	{"message":"{{item_read_6hv3y}}"}	\N	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-06-03 13:10:55.008+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
ada00cb3-a713-43b9-88af-328ba095dd1b	Webhook / Request URL	request_5krg8	request	37	37	{"method":"POST","url":"http://document-service:80/generate/list","body":"{{exec_pew0v}}"}	\N	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-06-13 16:09:43.551+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
0133fe8d-07c9-4053-a3f4-d4bffb3ee65e	Run Script	exec_iyaqu	exec	19	34	{"code":"module.exports = async function (data) {\\n  const orderItems = data.item_read_buebu;\\n  const products = data.item_read_s0wyq;\\n  const customer = data.item_read_v7iz9[0];\\n  const order = data.read_order[0]\\n    \\n  if (!Array.isArray(orderItems)) {\\n    throw new Error('orderItems is not an array');\\n  }\\n\\n  if (!Array.isArray(products)) {\\n    throw new Error('products is not an array');\\n  }\\n\\n  if (!customer) {\\n    throw new Error('Customer data not found');\\n  }\\n\\n  const entries = orderItems.map(item => {\\n    const product = products.find(p => p.id === item.product_id);\\n\\n    if (!product) {\\n      throw new Error(`Product not found for id: ${item.product_id}`);\\n    }\\n\\n    const pricePerItem = parseFloat(item.price_per_item);\\n    const totalPrice = item.quantity * pricePerItem;\\n    return [\\n      product.name,\\n      \\"10%\\",\\n      item.quantity.toString(),\\n      formatPrice(pricePerItem),\\n      formatPrice(totalPrice)\\n    ];\\n  });\\n\\n  const totalNet = orderItems.reduce((sum, item) => {\\n    const pricePerItem = parseFloat(item.price_per_item);\\n    const totalPrice = item.quantity * pricePerItem;\\n    return sum + totalPrice;\\n  }, 0);\\n\\n  const vatRate = 0.1;\\n  const totalVat = totalNet * vatRate;\\n  const totalGross = totalNet + totalVat;\\n\\n  const totals = [\\n    [\\"Netto\\", formatPrice(totalNet)],\\n    [\\"MwSt.\\", formatPrice(totalVat)],\\n    [\\"Gesamtbetrag\\", formatPrice(totalGross)]\\n  ];\\n\\n  const recipient = [\\n\\tcustomer.name,\\n    customer.address\\n  ];\\n\\n  const invoiceData = {\\n     \\"header\\": {\\n          \\"logo\\": {\\n            \\"image\\": \\"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\\",\\n            \\"format\\": \\"png\\"\\n          },\\n          \\"recipient\\": recipient,\\n          \\"sender\\": [\\n            \\"BaaS GmbH\\",\\n            \\"1010 Wien\\",\\n            \\"Stephansplatz 3\\"\\n          ],\\n          \\"info\\": {\\n            \\"name\\": \\"Kundeninformation\\",\\n            \\"contents\\": [\\n              [\\"Kundennummer\\", customer.customer_number || \\"nicht vorhanden\\"],\\n              [\\"Rechnungsnummer\\", order.invoice_number || \\"nicht vorhanden\\"],\\n              [\\"Rechnungsdatum\\", order.invoice_date || \\"nicht vorhanden\\"],\\n              [\\"Zahlungsreferenz\\", order.payment_reference || \\"nicht vorhanden\\"],\\n              [\\"E-Mail für\\\\nRückfragen\\", \\"info@baas.org\\"]\\n            ]\\n          }\\n        },\\n        \\"content\\": {\\n          \\"title\\": `Rechnung ${order.invoice_number}`,\\n          \\"content\\": \\"Sehr geehrter Kunde, vielen Dank für Ihr vertrauen in unsere Angebote. Wir hoffen, Sie sind mit unseren Leistungen zufrieden. Folgend übermitteln wir Ihnen die Rechnung für unsere Leistungen.\\",\\n          \\"colwidth\\": [1, \\"auto\\", \\"auto\\", \\"auto\\", \\"auto\\"],\\n          \\"align\\": [\\"left\\", \\"right\\", \\"right\\", \\"right\\", \\"right\\"],\\n          \\"fields\\": [\\"Beschreibung\\", \\"\\", \\"Menge\\", \\"Einzelpreis\\", \\"Gesamtpreis\\"],\\n          \\"entries\\": entries,\\n          \\"postmessage\\": \\"Wir bitten um prompte Zahlung ohne Abzug, spätestens bis zum 22.05.2024.\\",\\n          \\"totals\\": totals,\\n         \\"bankinfo\\": {\\n          \\"Kontoinhaber\\": \\"BaaS GmbH\\",\\n          \\"Bank\\": \\"Raiffeisenlandesbank NÖ - Wien AG\\",\\n          \\"IBAN\\": \\"AT30 3200 0000 1155 5638\\", \\n          \\"BIC\\": \\"RLNWATWW\\",\\n          \\"Telefon\\": \\"0660/1234567\\",\\n          \\"E-Mail\\": \\"info@baas.org\\"\\n        }\\n        }\\n       \\n  };\\n    \\n  return invoiceData;\\n}\\n\\n// Helper function to format prices\\nfunction formatPrice(price) {\\n  if (isNaN(price)) {\\n    throw new Error(`Invalid price value: ${price}`);\\n  }\\n  return price.toFixed(2).replace('.', ',') + ' €';\\n}\\n"}	20028b6b-3de5-4570-9dfb-80de48536386	\N	ae749fa6-501a-401c-97d4-1e821414e551	2024-06-20 16:23:16.656+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
661c2ef9-2cff-4c24-b5eb-188529fb31a6	Read Data	item_read_s0wyq	item-read	19	18	{"query":{"filter":{"id":{"_in":"{{ exec_llag8.productIds }}"}}},"permissions":"$full","collection":"Products"}	aec8d9ec-3981-4670-ac41-162af3698a8a	\N	ae749fa6-501a-401c-97d4-1e821414e551	2024-06-20 13:22:57.325+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
8480a4c0-9331-4fff-bc8e-cfb45c90378f	Run Script	exec_llag8	exec	1	18	{"code":"module.exports = async function(data) {\\n    // Log the entire data object to understand its structure\\n    console.log('Data from previous step:', data);\\n\\n    // Assuming 'data' contains the result of the previous step\\n    // Replace 'item_read_6hv3y' with the actual key from your previous step\\n    const orderItems = {{item_read_buebu}}\\n\\n    // Log the orders to verify the input data\\n    console.log('Order Items:', orderItems);\\n\\n    if (!orderItems || !Array.isArray(orderItems)) {\\n        // Log an error message if orders is not an array or is undefined\\n        console.error('Order Item data is not available or is not an array');\\n        return {\\n            productIds: [] // Return an empty array or handle as needed\\n        };\\n    }\\n\\n    // Extract order item IDs (using 'id' field)\\n    const productIds = orderItems.map(product => product.product_id);\\n\\n    // Log the extracted order item IDs\\n    console.log('Extracted Order Item IDs:', productIds);\\n\\n    // Return the extracted IDs for the next step\\n    return {\\n        productIds: productIds\\n    };\\n};\\n"}	661c2ef9-2cff-4c24-b5eb-188529fb31a6	\N	ae749fa6-501a-401c-97d4-1e821414e551	2024-06-20 13:21:26.539+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
77d46bba-fa9a-4309-bbcb-6674bf4a4567	Run Script	exec_0m6mj	exec	1	37	{"code":"module.exports = async function(data) {\\n    // Log the entire data object to understand its structure\\n    console.log('Data from previous step:', data);\\n\\n    // Assuming 'data' contains the result of the previous step\\n    const orderItems = {{item_read_dqroa}};\\n    const products = {{read_products}};\\n\\n    // Log the orders and products to verify the input data\\n    console.log('Order Items:', orderItems);\\n    console.log('Products:', products);\\n\\n    if (!orderItems || !Array.isArray(orderItems)) {\\n        console.error('Order Item data is not available or is not an array');\\n        return {};\\n    }\\n\\n    if (!products || !Array.isArray(products)) {\\n        console.error('Product data is not available or is not an array');\\n        return {};\\n    }\\n\\n    // Create a mapping of product IDs to product details\\n    const productMap = products.reduce((acc, product) => {\\n        acc[product.id] = product;\\n        return acc;\\n    }, {});\\n\\n    // Group order items by product and calculate total quantities\\n    const groupedOrderItems = orderItems.reduce((acc, orderItem) => {\\n        const productId = orderItem.product_id;\\n        if (!acc[productId]) {\\n            acc[productId] = {\\n                product: productMap[productId],\\n                totalQuantity: 0\\n            };\\n        }\\n        acc[productId].totalQuantity += orderItem.quantity;\\n        return acc;\\n    }, {});\\n\\n    // Convert the result to an array if needed\\n    const result = Object.values(groupedOrderItems);\\n\\n    // Log the result to verify\\n    console.log('Grouped Order Items:', result);\\n\\n    // Return the result\\n    return result;\\n};\\n"}	da4310c9-5c9d-49e1-8f64-0074a1a42d2e	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-06-13 15:59:21.773+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
da4310c9-5c9d-49e1-8f64-0074a1a42d2e	Run Script	exec_pew0v	exec	19	37	{"code":"module.exports = async function(data) {\\n    // Assuming 'data' contains the result from the previous step\\n    const groupedOrderItems = {{exec_0m6mj}};\\n\\n    // Log the grouped order items to verify the input data\\n    console.log('Grouped Order Items:', groupedOrderItems);\\n\\n    // Define the table structure\\n    const table = {\\n        \\"title\\": \\"Product Order Summary\\",\\n        \\"tag\\": \\"\\",\\n        \\"numbered\\": true,\\n        \\"lines\\": true,\\n        \\"header\\": [\\"Product\\", \\"Total Quantity\\"],\\n        \\"rows\\": []\\n    };\\n\\n    // Populate the table rows with product and total quantity\\n    groupedOrderItems.forEach(item => {\\n        table.rows.push([item.product.name, item.totalQuantity]);\\n    });\\n\\n    // Log the table to verify\\n    console.log('Formatted Table:', table);\\n\\n    // Return the formatted table\\n    return table;\\n};\\n"}	ada00cb3-a713-43b9-88af-328ba095dd1b	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-06-13 16:05:30.502+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
0945363e-99e9-47bb-8c6c-fe6ad351973f	Read Data	read_products	item-read	36	20	{"collection":"Products","query":{"filter":{"id":{"_in":"{{ exec_3e5xk.productIds }}"}}}}	77d46bba-fa9a-4309-bbcb-6674bf4a4567	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-06-12 12:40:55.835+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
20028b6b-3de5-4570-9dfb-80de48536386	Webhook / Request URL	request_vpel6	request	37	34	{"body":"{{exec_iyaqu}}","method":"POST","url":"http://document-service:80/generate/invoice"}	\N	\N	ae749fa6-501a-401c-97d4-1e821414e551	2024-06-21 07:01:19.467+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
aec8d9ec-3981-4670-ac41-162af3698a8a	Run Script	exec_qarqg	exec	37	18	{"code":"module.exports = async function(data) {\\n    const order = data.read_order[0];\\n    const customer_id = order.customer_id;\\n\\n    return {\\n      customer_id: customer_id,\\n      date_created: order.date_created\\n    };\\n}\\n"}	f87cb624-cbe4-4391-8333-9bf3af5a0906	\N	ae749fa6-501a-401c-97d4-1e821414e551	2024-06-20 16:10:41.218+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
c2432aaf-6db2-4db1-99f0-76f0181f5ce6	Read Data	item_read_buebu	item-read	37	1	{"query":{"filter":{"order_id":{"_eq":"{{$trigger.body.orderId }}"}}},"collection":"Order_Items","permissions":"$full"}	8480a4c0-9331-4fff-bc8e-cfb45c90378f	\N	ae749fa6-501a-401c-97d4-1e821414e551	2024-06-20 13:05:55.068+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
7525e912-04e5-4f8b-b959-1db0e6d04656	Extract Ids	extraction_key_id	exec	48	1	{"code":"module.exports = async function(data) {\\n    // Log the entire data object to understand its structure\\n    console.log('Data from previous step:', data);\\n\\n    // Assuming 'data' contains the result of the previous step\\n    // Replace 'item_read_6hv3y' with the actual key from your previous step\\n    const orders = {{item_read_6hv3y}}\\n\\n    // Log the orders to verify the input data\\n    console.log('Orders:', orders);\\n\\n    if (!orders || !Array.isArray(orders)) {\\n        // Log an error message if orders is not an array or is undefined\\n        console.error('Orders data is not available or is not an array');\\n        return {\\n            orderItemIds: [] // Return an empty array or handle as needed\\n        };\\n    }\\n\\n    // Extract order item IDs (using 'id' field)\\n    const orderItemIds = orders.map(order => order.id);\\n\\n    // Log the extracted order item IDs\\n    console.log('Extracted Order Item IDs:', orderItemIds);\\n\\n    // Return the extracted IDs for the next step\\n    return {\\n        orderItemIds: orderItemIds\\n    };\\n};\\n"}	a3cd79bc-feaf-4cdd-8a67-ac705262dc6f	\N	00526ceb-f4f6-4262-8846-6ee20df1b76e	2024-06-03 13:55:34.451+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
f87cb624-cbe4-4391-8333-9bf3af5a0906	Read Data	item_read_v7iz9	item-read	1	34	{"collection":"Customer","permissions":"$full","query":{"filter":{"id":{"_eq":"{{exec_qarqg.customer_id}}"}}}}	0133fe8d-07c9-4053-a3f4-d4bffb3ee65e	\N	ae749fa6-501a-401c-97d4-1e821414e551	2024-06-20 16:16:42.428+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
c20639ab-7442-46bc-bdf2-f9a28e6ab60e	Read Data	read_order	item-read	19	1	{"query":{"filter":{"id":{"_eq":"{{$trigger.body.orderId}}"}}},"collection":"Orders","permissions":"$full"}	c2432aaf-6db2-4db1-99f0-76f0181f5ce6	\N	ae749fa6-501a-401c-97d4-1e821414e551	2024-06-20 12:59:10.129+00	f665a758-29c1-40f3-8cbd-7662d66fb5de
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
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
2	\N	f665a758-29c1-40f3-8cbd-7662d66fb5de	\N	directus_activity	\N	tabular	{"tabular":{"sort":["-timestamp"],"fields":["action","collection","timestamp","user"],"page":1}}	{"tabular":{"widths":{"action":120,"collection":210,"timestamp":240,"user":240}}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	Orders	customer_id	Customer	\N	\N	\N	\N	\N	nullify
2	Order_Items	order_id	Orders	\N	\N	\N	\N	\N	nullify
3	Order_Items	product_id	Products	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
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
sBDt6bfl2qllsSvQxg2QOAp4InpX_y9RagA2A9qthA19b5OtFq-1TkGvxSbb0xeM	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-21 13:39:18.467+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36	\N	http://localhost:8055
RZUv0UWGN8x0gCxSG_oANYt89BfNYlEes2RW7EF18ccMBB9QeqT0NLjZTTF2m6uE	f665a758-29c1-40f3-8cbd-7662d66fb5de	2024-06-28 08:19:58.179+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36	\N	http://localhost:8055
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
f665a758-29c1-40f3-8cbd-7662d66fb5de	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$PyC70XI4XGyQ5J0RLbB3UA$TVqh6tb2GHBagjq8CUyhuw4bExoVpOQNhnSk/hdx3Gw	\N	\N	\N	\N	\N	\N	\N	active	7805fa26-4186-495e-b6e4-f8a28bbaa44f	\N	2024-06-21 08:19:58.185+00	/settings/flows/00526ceb-f4f6-4262-8846-6ee20df1b76e	default	\N	\N	t	\N	\N	\N	\N	\N
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
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test (id) FROM stdin;
\.


--
-- Name: Orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Orders_id_seq"', 5, true);


--
-- Name: Pro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Pro_id_seq"', 1, false);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 1, false);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 24, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 2, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 3, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 13071, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_id_seq', 1, false);


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
-- Name: Pro Pro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Pro"
    ADD CONSTRAINT "Pro_pkey" PRIMARY KEY (id);


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
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


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
-- PostgreSQL database dump complete
--

