CREATE TABLE
        IF NOT EXISTS public.location (
                location_id serial NOT NULL,
                Lat_Lng point,
                region_name VARCHAR(100),
                district VARCHAR(100),
                city VARCHAR(100),
                postcode CHAR(5),
                s postcode_extension char(4),
                plus_code VARCHAR(100),
                short_code VARCHAR(100),
                building_number integer,
                address2 VARCHAR(100),
                CONSTRAINT location_pkey PRIMARY KEY (location_id)
        );

CREATE TABLE
        IF NOT EXISTS public.POI (
                POI_ID serial NOT NULL,
                poi_name VARCHAR(200),
                location_id serial,
                CONSTRAINT POI_pkey PRIMARY KEY (POI_ID),
                CONSTRAINT location_id FOREIGN KEY (location_id) REFERENCES public.location (location_id)
        );

CREATE TABLE
        IF NOT EXISTS public.POI_AKA (
                POI_ID serial NOT NULL,
                Also_known_as VARCHAR(100),
                CONSTRAINT POI_AKA_pkey PRIMARY KEY (POI_ID, Also_known_as),
                CONSTRAINT POI_ID FOREIGN KEY (POI_ID) REFERENCES public.POI (POI_ID) ON UPDATE CASCADE ON DELETE CASCADE
        );

CREATE TABLE
        IF NOT EXISTS public.business (
                business_ID serial NOT NULL,
                name VARCHAR(200),
                category VARCHAR(100),
                CONSTRAINT business_pkey PRIMARY KEY (business_ID)
        );

CREATE TABLE
        IF NOT EXISTS public.business_branch (
                branch_id serial NOT NULL,
                business_ID serial,
                location_id serial,
                indoor BOOLEAN,
                outdoor BOOLEAN,
                CONSTRAINT business_branch_pkey PRIMARY KEY (branch_id, business_ID, location_id),
                CONSTRAINT business_ID FOREIGN KEY (business_ID) REFERENCES public.business (business_ID) ON UPDATE CASCADE ON DELETE CASCADE,
                CONSTRAINT location_id FOREIGN KEY (location_id) REFERENCES public.location (location_id) ON UPDATE CASCADE ON DELETE CASCADE
        );

CREATE TABLE
        IF NOT EXISTS public.residential (
                residential_id serial NOT NULL,
                Name VARCHAR(100),
                location_id serial,
                CONSTRAINT residential_pkey PRIMARY KEY (residential_id),
                CONSTRAINT location_id FOREIGN KEY (location_id) REFERENCES public.location (location_id) ON UPDATE CASCADE ON DELETE CASCADE
        );

CREATE TABLE
        IF NOT EXISTS public.street (
                street_id serial NOT NULL,
                street_name VARCHAR(100),
                location_id serial,
                CONSTRAINT street_pkey PRIMARY KEY (street_id),
                CONSTRAINT location_id FOREIGN KEY (location_id) REFERENCES public.location (location_id) ON UPDATE CASCADE ON DELETE CASCADE
        );

CREATE TABLE
        IF NOT EXISTS public.street_AKA (
                street_id serial,
                street_Also_known_as VARCHAR(100),
                CONSTRAINT street_AKA_pkey PRIMARY KEY (street_id, street_Also_known_as),
                CONSTRAINT street_id FOREIGN KEY (street_id) REFERENCES public.street (street_id) ON UPDATE CASCADE ON DELETE CASCADE
        );