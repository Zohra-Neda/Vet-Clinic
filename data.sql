/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (2, 'Gabumon', '2018-11-15', 2, TRUE, 8.00);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (4, 'Devimon', '2017-05-12', 5, TRUE, 11.00);


-- ALTER ANIMALS TABLE

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (5, 'Charmander', '2020-02-08', 0, FALSE, -11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (6, 'Plantmon', '2021-11-15', 2, TRUE, -5.7);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (8, 'Angemon', '2005-05-12', 1, TRUE, -45);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (9, 'Boarmon', '2005-05-07', 7, TRUE, 20.4);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (10, 'Blossom', '1998-10-13', 3, TRUE, 17);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (11, 'Ditto', '2022-05-14', 4, TRUE, 22);


INSERT INTO  owners (full_name, age)
VALUES ('Sam Smith', 34);

INSERT INTO  owners (full_name, age)
VALUES ('Jennifer Orwell', 19);

INSERT INTO  owners (full_name, age)
VALUES ('Bob', 45);

INSERT INTO  owners (full_name, age)
VALUES ('Melody Pond', 77);

INSERT INTO  owners (full_name, age)
VALUES ('Dean Winchester ', 14);

INSERT INTO  owners (full_name, age)
VALUES ('Jodie Whittaker ', 38);


INSERT INTO  species (name)
VALUES ('Pokemon');

INSERT INTO  species (name)
VALUES ('Digimon');


UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon' ) WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;


UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'San Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob' ) WHERE name IN ('Devimon', 'Plantmon' );
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond' ) WHERE name IN ('Charmander', 'Squirtle', 'Blossom' );
UPDATE animals SET owner_id = ( SELECT id FROM owners WHERE full_name = 'Dean Winchester' ) WHERE name IN ('Angemon', 'Boarmon' );


INSERT INTO  vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23');

INSERT INTO  vets (name, age, date_of_graduation)
VALUES ('Maisy Smith', 26, '2019-01-17');

INSERT INTO  vets (name, age, date_of_graduation)
VALUES ('Stephanie Mendez', 64, '1981-05-04');

INSERT INTO  vets (name, age, date_of_graduation)
VALUES ('Jack Harkness', 38, '2008-06-08');


/*These statements insert the corresponding vet_id and species_id values into the specializations table for each vet and species pair. The SELECT statements are used to retrieve the id values for the given vets and species from their respective tables. Note that since specializations has a composite primary key made up of both foreign keys, each vet and species pair must be inserted separately.*/
INSERT INTO specializations (vet_id, species_id) VALUES
  ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations (vet_id, species_id) VALUES
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
  ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations (vet_id, species_id) VALUES
  ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));


/*These statements insert the corresponding animal_id, vet_id, and visit_date values into the visits table for each animal and vet pair on each visit date. The SELECT statements are used to retrieve the id values for the given animals and vets from their respective tables.*/
INSERT INTO visits (vet_id, animal_id, visit_date)  SELECT v.id, a.id , '2020-05-24' FROM vets v, animals a WHERE v.name = 'William Tatcher' AND a.name = 'Agumon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-06-22' FROM vets v, animals a WHERE v.name = 'Stephanie Mendez' AND a.name = 'Agumon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2021-02-02' FROM vets v, animals a WHERE v.name = 'Jack Harkness' AND a.name = 'Gabumon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-01-05' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Pikachu';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-05-08' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Pikachu';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id, a.id, '2020-05-14' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Pikachu';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2021-05-04' FROM vets v, animals a WHERE v.name = 'Stephanie Mendez' AND a.name = 'Devimon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2021-02-24' FROM vets v, animals a WHERE v.name = 'Jack Harkness' AND a.name = 'Charmander';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2019-12-21' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Plantmon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2020-08-10' FROM vets v, animals a WHERE v.name = 'William Tatcher' AND a.name = 'Plantmon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2021-04-07' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Plantmon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2019-09-29' FROM vets v, animals a WHERE v.name = 'Stephanie Mendez' AND a.name = 'Squirtle';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2020-10-03' FROM vets v, animals a WHERE v.name = 'Jack Harkness' AND a.name = 'Angemon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2020-11-04' FROM vets v, animals a WHERE v.name = 'Jack Harkness' AND a.name = 'Angemon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2019-01-24' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Boarmon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2019-05-15' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Boarmon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2020-02-27' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Boarmon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2020-08-03' FROM vets v, animals a WHERE v.name = 'Maisy Smith' AND a.name = 'Boarmon';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2020-05-24' FROM vets v, animals a WHERE v.name = 'Stephanie Mendez' AND a.name = 'Blossom';

INSERT INTO visits (vet_id, animal_id, visit_date) SELECT v.id , a.id , '2021-01-11' FROM vets v, animals a WHERE v.name = 'William Tatcher' AND a.name = 'Blossom';