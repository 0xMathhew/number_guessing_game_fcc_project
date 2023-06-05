--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guessing_game;
--
-- Name: number_guessing_game; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guessing_game WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guessing_game OWNER TO freecodecamp;

\connect number_guessing_game

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    number_of_guesses integer,
    winning_number integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: player; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.player (
    user_id integer NOT NULL,
    username character varying(22),
    best_game_id integer,
    games_played integer
);


ALTER TABLE public.player OWNER TO freecodecamp;

--
-- Name: player_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.player_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.player_user_id_seq OWNER TO freecodecamp;

--
-- Name: player_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.player_user_id_seq OWNED BY public.player.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: player user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.player ALTER COLUMN user_id SET DEFAULT nextval('public.player_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (65, 191, 190);
INSERT INTO public.games VALUES (66, 485, 484);
INSERT INTO public.games VALUES (67, 114, 113);
INSERT INTO public.games VALUES (68, 822, 819);
INSERT INTO public.games VALUES (69, 701, 699);
INSERT INTO public.games VALUES (70, 146, 145);
INSERT INTO public.games VALUES (71, 133, 132);
INSERT INTO public.games VALUES (72, 470, 469);
INSERT INTO public.games VALUES (73, 804, 803);
INSERT INTO public.games VALUES (74, 227, 224);
INSERT INTO public.games VALUES (75, 817, 815);
INSERT INTO public.games VALUES (76, 14, 13);
INSERT INTO public.games VALUES (77, 268, 267);
INSERT INTO public.games VALUES (78, 275, 274);
INSERT INTO public.games VALUES (79, 704, 703);
INSERT INTO public.games VALUES (80, 568, 565);
INSERT INTO public.games VALUES (81, 669, 667);
INSERT INTO public.games VALUES (82, 912, 911);
INSERT INTO public.games VALUES (83, 270, 269);
INSERT INTO public.games VALUES (84, 342, 341);
INSERT INTO public.games VALUES (85, 882, 881);
INSERT INTO public.games VALUES (86, 682, 681);
INSERT INTO public.games VALUES (87, 70, 67);
INSERT INTO public.games VALUES (88, 156, 154);
INSERT INTO public.games VALUES (89, 884, 883);
INSERT INTO public.games VALUES (90, 345, 344);
INSERT INTO public.games VALUES (91, 956, 955);
INSERT INTO public.games VALUES (92, 662, 661);
INSERT INTO public.games VALUES (93, 669, 668);
INSERT INTO public.games VALUES (94, 632, 629);
INSERT INTO public.games VALUES (95, 871, 869);
INSERT INTO public.games VALUES (96, 921, 920);


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.player VALUES (34, 'user_1685973858303', 67, 2);
INSERT INTO public.player VALUES (33, 'user_1685973858304', NULL, 4);
INSERT INTO public.player VALUES (37, 'user_1685973963885', 72, 2);
INSERT INTO public.player VALUES (35, 'user_1685973963886', 71, 4);
INSERT INTO public.player VALUES (36, 'user_1685973963886', 71, 4);
INSERT INTO public.player VALUES (39, 'user_1685974007316', 78, 2);
INSERT INTO public.player VALUES (38, 'user_1685974007317', NULL, 4);
INSERT INTO public.player VALUES (41, 'user_1685974532365', 86, 2);
INSERT INTO public.player VALUES (40, 'user_1685974532366', 87, 5);
INSERT INTO public.player VALUES (43, 'user_1685974563250', 92, 2);
INSERT INTO public.player VALUES (42, 'user_1685974563251', 90, 5);


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 96, true);


--
-- Name: player_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.player_user_id_seq', 43, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (user_id);


--
-- Name: player fk_best_game_id_games_game_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT fk_best_game_id_games_game_id FOREIGN KEY (best_game_id) REFERENCES public.games(game_id);


--
-- PostgreSQL database dump complete
--

