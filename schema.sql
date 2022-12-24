-- Table: public.animals

-- DROP TABLE IF EXISTS public.animals;

CREATE TABLE IF NOT EXISTS animals.animals
(
    animals_id integer NOT NULL,
    name text COLLATE pg_catalog."default",
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg numeric,
    PRIMARY KEY (animals_id),
)

-- Create a table named owners
BEGIN;
CREATE TABLE animals.owners (
    id serial PRIMARY KEY,
    full_name text,
    age text
)
COMMIT;

-- Create a table named species
BEGIN;
CREATE TABLE animals.species (
    species_id serial PRIMARY KEY,
    name text,
)
COMMIT;

-- Modify animals table
-- id is set as autoincremented PRIMARY KEY
BEGIN;

ALTER TABLE animals.animals
ADD serial PRIMARY KEY (animals_id)

-- Remove column species
ALTER TABLE animals.animals 
DROP species

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals.animals 
ADD species_id

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals.animals 
ADD owner_id

COMMIT;

-- Create a table named vets
BEGIN;

CREATE TABLE animals.vets (
    id serial PRIMARY KEY,
    name text,
    age integer,
    date_of_graduation date
);

-- many-many relationship: create table to connects two table together
CREATE TABLE specializations(
    species_id INT REFERENCES species(id) ON DELETE CASCADE,
    vets_id INT REFERENCES vets(id) ON DELETE CASCADE
);

CREATE TABLE visits(
    animals_id INT REFERENCES animals(id) ON DELETE CASCADE,
    vets_id INT REFERENCES vets(id) ON DELETE CASCADE,
    visit_date DATE
);



