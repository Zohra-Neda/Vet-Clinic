/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


/*The BEGIN statement starts a new transaction. The UPDATE statement updates all rows in the 'animals' table
by setting the 'species' column to 'unspecified'. The SELECT statement verifies that the change was made
by selecting all rows where the 'species' column is 'unspecified'. The ROLLBACK statement rolls back the transaction,
undoing the changes made by the UPDATE statement. The final SELECT statement verifies that the 'species' column
went back to its original state by selecting all rows where the 'species' column is not 'unspecified'.*/
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals; -- verify the change
ROLLBACK;
SELECT * FROM animals WHERE; -- verify the rollback

/*The BEGIN statement starts a new transaction. The first UPDATE statement updates all rows in the 'animals'
table where the 'name' column ends with 'mon' by setting the 'species' column to 'digimon'.
The second UPDATE statement updates all rows in the 'animals' table where the 'species' column is
NULL (i.e., not already set) by setting the 'species' column to 'pokemon'.
The SELECT statement verifies that the changes were made by selecting all rows where the 'species'
column is either 'digimon' or 'pokemon'. The COMMIT statement commits the transaction, making the
changes permanent. Finally, the last SELECT statement verifies that the changes persist by selecting
all rows where the 'species' column is either 'digimon' or 'pokemon'.*/
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals WHERE species = 'digimon' OR species = 'pokemon'; -- verify the changes
COMMIT;
SELECT * FROM animals WHERE species = 'digimon' OR species = 'pokemon'; -- verify the changes persist

/* The BEGIN statement starts a new transaction. The DELETE statement deletes all rows from the 'animals' table.
The SELECT statement verifies that all records were deleted by counting the number of rows in the 'animals' table.
The ROLLBACK statement rolls back the transaction, undoing the deletion of all records. The final SELECT statement
verifies that all records still exist by counting the number of rows in the 'animals' table.*/
BEGIN;
DELETE FROM animals;
SELECT COUNT(*) FROM animals; -- verify that all records were deleted
ROLLBACK;
SELECT COUNT(*) FROM animals; -- verify that all records still exist


/*The BEGIN statement starts a new transaction. The DELETE statement deletes all rows from the 'animals' table
where the 'date_of_birth' column is after Jan 1st, 2022. The SAVEPOINT statement creates a savepoint named
'my_savepoint' in the transaction. The first UPDATE statement updates all rows in the 'animals' table by setting
the 'weight_kg' column to its current value multiplied by -1. The ROLLBACK TO statement rolls back the transaction
to the savepoint named 'my_savepoint', undoing the updates made by the first UPDATE statement. The second UPDATE
statement updates all rows in the 'animals' table where the 'weight_kg' column is negative by setting it to its
current value multiplied by -1. The COMMIT statement commits the transaction, making the changes permanent.*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT animals_born_after_Jan1st22;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO animals_born_after_Jan1st22;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

/*This query groups the animals by their neutered status and sums up their 'escape_attempts'
column to get the total number of escape attempts for each group. It then orders the groups by
the total number of escape attempts in descending order and selects the first row (i.e., the group with the
highest number of escape attempts).*/
SELECT neutered, SUM(escape_attempts) AS total_attempts
FROM animals
GROUP BY neutered
ORDER BY total_attempts DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

/*This query selects all animals born between Jan 1st, 1990 and Dec 31st, 2000, groups them by their type,
and calculates the average number of escape attempts for each group.*/
SELECT species, AVG(escape_attempts) AS avg_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


/*This code will select all columns from the animals table where the owner_id matches the id of the owner with the full name of 'Melody Pond'. This will give you a list of all animals that belong to Melody Pond.*/
SELECT animals.*
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

/*This code will select all columns from the animals table where the species_id matches the id of the species with the name 'Pokemon'. This will give you a list of all animals that are Pokemon.*/
SELECT animals.*
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

/*This code will select all columns from the owners table and all columns from the animals table, and it will join them based on the owner_id and id columns, respectively. The LEFT JOIN will ensure that all owners are included in the result set, even if they don't own any animals. The result set will be ordered by the full name of the owners.*/
SELECT owners.full_name, animals.*
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
ORDER BY owners.full_name;

/*This code will select the name of each species and the count of animals that belong to that species. The JOIN between the species and animals tables is based on the id and species_id columns, respectively. The GROUP BY clause groups the result set by the name of the species, and the COUNT function counts the number of animals in each group.*/
SELECT species.name, COUNT(animals.id) AS num_animals FROM species JOIN animals ON species.id = animals.species_id GROUP BY species.name;

/*This code will select all columns from the animals table where the species_id matches the id of the species with the name 'Digimon' and the owner_id matches the id of the owner with the full name 'Jennifer Orwell'. This will give you a list of all Digimon owned by Jennifer Orwell.*/
SELECT animals.* FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

/*This code will select all columns from the animals table where the owner_id matches the id of the owner with the full name 'Dean Winchester' and the tried_to_escape column is false. This will give you a list of all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT animals.* FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

/*This code will select the full name of each owner and the count of animals that belong to that owner. The JOIN between the owners and animals tables is based on the id and owner_id columns, respectively. The GROUP BY clause groups the result set by the full name of the owners, and the COUNT function counts the number of animals in each group. The ORDER BY clause orders the result set by the count of animals in descending order, so the owner with the most animals will be listed first. Finally, the LIMIT 1 clause limits the result set to only one row, which will be the owner with the most animals.*/
SELECT owners.full_name, COUNT(animals.id) AS num_animals FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY num_animals DESC LIMIT 1;

/*This query joins the visits, animals, and vets tables together and filters for visits made by William Tatcher using a WHERE clause. The results are then sorted by visit date in descending order and limited to the first row, which represents the most recent visit. Finally, the animal's name is selected from the animals table in the result set.*/
SELECT animals.name
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

/*This query uses a subquery to find the ID of Stephanie Mendez in the vets table, and then counts the number of distinct animal_id values in the visits table where the vet_id matches Stephanie Mendez's ID. The result is a single value representing the count of different animals seen by Stephanie Mendez.*/
SELECT COUNT(DISTINCT animal_id)
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

/*This query uses a LEFT JOIN to join the vets table with the vet_specialties table on the id column. It then uses another LEFT JOIN to join the vet_specialties table with the specialties table on the specialty_id column. This ensures that all rows from the vets table are included in the result set, even if there is no matching row in the vet_specialties or specialties tables.*/
SELECT vt.name AS vet_name , s.name AS speciality FROM vets vt LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id ORDER BY vt.name;

/*This query joins the visits, animals, and vets tables together and filters for visits made by Stephanie Mendez between April 1st and August 30th, 2020 using a WHERE clause that checks the name column in the vets table and the visit_date column in the visits table. The results are then filtered to include only the animal names from the animals table in the result set.*/
SELECT animals.name
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

/*This query joins the visits and animals tables together on the id column and groups the results by animals.name. It then uses the COUNT function to count the number of visits for each animal and orders the results in descending order based on the number of visits. Finally, the LIMIT clause limits the result set to the first row, which represents the animal with the most visits.*/
SELECT animals.name, COUNT(*) AS num_visits
FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY num_visits DESC
LIMIT 1;

/*This query joins the visits, animals, and vets tables together and filters for visits made by Maisy Smith using a WHERE clause that checks the name column in the vets table. The results are then sorted by visit date in ascending order and limited to the first row, which represents the earliest visit. Finally, the animal's name is selected from the animals table in the result set.*/
SELECT animals.name
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

/*This query joins the visits, animals, and vets tables together and sorts the results by visit date in descending order. The LIMIT clause limits the result set to the first row, which represents the most recent visit.*/
SELECT animals.*, vets.*, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(*) FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id WHERE sp.vet_id IS NULL;

/*This query joins the species, animals, visits, and vets tables together and filters for visits made by Maisy Smith using a WHERE clause that checks the name column in the vets table. The results are then grouped by species and sorted in descending order based on the number of visits for each species. The LIMIT clause limits the result set to the first row, which represents the species with the highest visit count.*/
SELECT s.name AS Maisy_speciality
FROM species s
JOIN animals a ON s.id = a.species_id
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(v.visit_date) DESC
LIMIT 1;


explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;
explain analyze SELECT * FROM visits where vet_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';
