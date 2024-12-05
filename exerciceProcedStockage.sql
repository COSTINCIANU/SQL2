
-- 3. Exercice Procedures Stockees
-- Creation de la table utilisateur
CREATE TABLE utilisateur (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(32) NOT NULL
);
DELIMITER $$

-- Procedure pour créer une catégorie
CREATE PROCEDURE create_categorie(IN p_nom_categorie VARCHAR(50))
BEGIN
    -- Vérification si la catégorie existe déjà
    IF NOT EXISTS (SELECT 1 FROM categorie WHERE nom_categorie = p_nom_categorie) THEN
        INSERT INTO categorie (nom_categorie) VALUES (p_nom_categorie);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cette catégorie existe déjà';
    END IF;
END $$

-- Les autres procedures suivent le même modèle..
DELIMITER $$;

