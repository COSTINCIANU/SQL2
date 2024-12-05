-- Procédures Stockées Complètes
DELIMITER $$

-- Procedure pour créer un produit
CREATE PROCEDURE create_produit(
    IN p_nom VARCHAR(50),
    IN p_description VARCHAR(255),
    IN p_tarif DECIMAL(3,2),
    IN p_id_categorie INT
)
BEGIN
    -- ON fait la Verification du tarif et de l'existence du produit
    IF p_tarif <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Le prix doit être supérieur à 0';
    ELSEIF EXISTS (SELECT 1 FROM produit WHERE nom_produit = p_nom) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ce produit existe déjà';
    ELSE
        INSERT INTO produit (nom_produit, description, tarif, id_categorie)
        VALUES (p_nom, p_description, p_tarif, p_id_categorie);
    END IF;
END 

-- Procedure pour créer un ticket
CREATE PROCEDURE create_ticket(
    IN p_date_creation DATETIME,
    IN p_id_vendeur INT
)
BEGIN
    -- Verification de la date du ticket
    IF p_date_creation > NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La date ne peut pas être future';
    ELSE
        INSERT INTO ticket (date_creation, id_vendeur)
        VALUES (p_date_creation, p_id_vendeur);
    END IF;
END 

-- Procedure pour créer un vendeur
CREATE PROCEDURE create_vendeur(
    IN p_nom VARCHAR(50),
    IN p_prenom VARCHAR(50)
)
BEGIN
    -- Verification de l'existence du vendeur
    IF EXISTS (SELECT 1 FROM vendeur WHERE nom_vendeur = p_nom AND prenom_vendeur = p_prenom) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ce vendeur existe déjà';
    ELSE
        INSERT INTO vendeur (nom_vendeur, prenom_vendeur)
        VALUES (p_nom, p_prenom);
    END IF;
END 

-- Procedure pour vérifier l'existence d'un email
CREATE PROCEDURE verify_email(IN p_email VARCHAR(255))
BEGIN
    IF EXISTS (SELECT 1 FROM utilisateur WHERE email = p_email) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cet email existe déjà';
    END IF;
END 

-- Procedure pour créer un utilisateur
CREATE PROCEDURE create_user(
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    CALL verify_email(p_email);
    INSERT INTO utilisateur (email, mot_de_passe)
    VALUES (p_email, MD5(p_password));
END 

-- Procedure pour vérifier les identifiants de connexion
CREATE PROCEDURE verify_login(
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM utilisateur 
                  WHERE email = p_email 
                  AND mot_de_passe = MD5(p_password)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email ou mot de passe incorrect';
    END IF;
END 

-- Procedure pour mettre à jour le mot de passe
CREATE PROCEDURE update_password(
    IN p_email VARCHAR(255),
    IN p_old_password VARCHAR(255),
    IN p_new_password VARCHAR(255)
)
BEGIN
    CALL verify_login(p_email, p_old_password);
    UPDATE utilisateur 
    SET mot_de_passe = MD5(p_new_password)
    WHERE email = p_email;
END 

DELIMITER $$;

