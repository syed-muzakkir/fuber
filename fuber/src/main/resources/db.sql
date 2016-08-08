create sequence USER_SEQUENCE;


CREATE TABLE fcab_user
(
  id integer NOT NULL,
  user_name text NOT NULL,
  user_type text NOT NULL,
  password text NOT NULL,
  latitude text,
  longitude text,
  email text NOT NULL,
  mobile_number text NOT NULL,
  pickup_loc text ,
  VEHICLE_NUM text ,
  LOCATION text,
  COLOR text ,
  IS_OCCUPIED text,
  CONSTRAINT fcab_user_pkey PRIMARY KEY (id)
);