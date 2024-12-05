
-- 2. Exercice Droits SQL
-- Creation des utilisateurs avec leurs mots de passe
CREATE USER 'admin_caisse'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'gerant_caisse'@'localhost' IDENTIFIED BY 'gerant123';
CREATE USER 'vendeur_caisse'@'localhost' IDENTIFIED BY 'vendeur123';

-- Attribution des droits pour l'administrateur
-- L'administrateur a tous les droits sur la base de données
GRANT ALL PRIVILEGES ON caisse.* TO 'admin_caisse'@'localhost';

-- Attribution des droits pour le gérant
-- Le gérant peut manipuler les données mais pas la structure
GRANT SELECT, INSERT, UPDATE, DELETE ON caisse.* TO 'gerant_caisse'@'localhost';
GRANT SELECT ON caisse.v_tickets_details TO 'gerant_caisse'@'localhost';
GRANT SELECT ON caisse.v_top_5_produits TO 'gerant_caisse'@'localhost';
GRANT SELECT ON caisse.v_ca_vendeurs TO 'gerant_caisse'@'localhost';

-- Attribution des droits pour le vendeur
-- Le vendeur a des droits limités
GRANT SELECT ON caisse.* TO 'vendeur_caisse'@'localhost';
GRANT INSERT ON caisse.ticket TO 'vendeur_caisse'@'localhost';
GRANT INSERT, UPDATE ON caisse.produit_ticket TO 'vendeur_caisse'@'localhost';
GRANT SELECT ON caisse.v_tickets_details TO 'vendeur_caisse'@'localhost';
GRANT SELECT ON caisse.v_top_5_produits TO 'vendeur_caisse'@'localhost';
GRANT SELECT ON caisse.v_ca_vendeurs TO 'vendeur_caisse'@'localhost';

-- Appliquer les modifications des privilèges
FLUSH PRIVILEGES;



-- test pour l'administrateur
mysql -u admin_caisse -p

-- test pour le gérant
mysql -u gerant_caisse -p

-- test pour le vendeur
mysql -u vendeur_caisse -p