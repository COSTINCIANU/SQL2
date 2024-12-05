
--1. Exercice Vues

-- 1. Vue pour afficher les détails des tickets
-- Vue combine les tables ticket, vendeur, produit_ticket et produit
-- pour calculer le montant total de chaque ticket
CREATE VIEW v_tickets_details AS
SELECT 
    t.id_ticket,                                  
    v.nom_vendeur,                                 
    v.prenom_vendeur,                              
    SUM(p.tarif * pt.quantite) as montant_ttc      
FROM ticket t
JOIN vendeur v ON t.id_vendeur = v.id_vendeur         
JOIN produit_ticket pt ON t.id_ticket = pt.id_ticket  
JOIN produit p ON pt.id_produit = p.id_produit        
GROUP BY t.id_ticket, v.nom_vendeur, v.prenom_vendeur;

-- 2. Vue pour les 5 produits les plus vendus
-- Vue calcule la quantite totale vendue pour chaque produit
CREATE VIEW v_top_5_produits AS
SELECT 
    p.nom_produit,                                  
    SUM(pt.quantite) as total_ventes                
FROM produit p
JOIN produit_ticket pt ON p.id_produit = pt.id_produit
GROUP BY p.id_produit, p.nom_produit
ORDER BY total_ventes DESC                         
LIMIT 5;                                           

-- 3. Vue pour le chiffre d'affaires par vendeur
-- Vue calcule le total des ventes pour chaque vendeur
CREATE VIEW v_ca_vendeurs AS
SELECT 
    v.nom_vendeur,
    v.prenom_vendeur,
    SUM(p.tarif * pt.quantite) as chiffre_affaire  
FROM vendeur v
JOIN ticket t ON v.id_vendeur = t.id_vendeur
JOIN produit_ticket pt ON t.id_ticket = pt.id_ticket
JOIN produit p ON pt.id_produit = p.id_produit
GROUP BY v.id_vendeur, v.nom_vendeur, v.prenom_vendeur;

