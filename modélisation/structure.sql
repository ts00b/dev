CREATE TABLE `utilisateurs` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom_complet` varchar(255),
  `nom` varchar(255),
  `type_id` int,
  `titre_id` int,
  `mail` varchar(255),
  `matricule_employe` varchar(255),
  `agence_id` int,
  `tel_bureau` varchar(255),
  `tel_portable` varchar(255),
  `est_actif` boolean,
  `derniere_visite` timestamp,
  `created_at` datetime DEFAULT (now()),
  `code_imputation` varchar(255)
);

CREATE TABLE `utilisateurs_type` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `continent_name` varchar(255)
);

CREATE TABLE `utilisateurs_titre` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE `region` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE `departement` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `region_id` int,
  `nom` varchar(255)
);

CREATE TABLE `agence` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `departement_id` int,
  `nom` varchar(255)
);

CREATE TABLE `entreprise` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `type` int,
  `nom` varchar(255),
  `adresse` varchar(255)
);

CREATE TABLE `entreprise_type` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE `contact` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `entreprise_id` int,
  `nom` varchar(255),
  `prenom` varchar(255),
  `fonction` varchar(255),
  `mail` varchar(255),
  `tel_fixe` varchar(255),
  `tel_portable` varchar(255)
);

CREATE TABLE `avant_vente` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `cree_par` int,
  `demandeur` int,
  `opportunite_Salesforce` varchar(255),
  `client_id` int,
  `nom_projet` varchar(255) NOT NULL,
  `type_demande` int,
  `agence_id` int,
  `format_reponse` int,
  `status` int,
  `Date_souhaitee` datetime,
  `Date_imperative` datetime NOT NULL,
  `Date_rendu` datetime,
  `piece_jointe` varchar(255),
  `raccourci` varchar(255),
  `created_at` datetime DEFAULT (now()),
  `avancement` int,
  `Acteur_principal` int,
  `Charge_acteur_principal` int,
  `Acteur_2` int,
  `Charge_Acteur_2` int,
  `Acteur_3` int,
  `Charge_Acteur_3` int,
  `charge_das_Datacenter` int,
  `charge_das_CUC` int,
  `charge_das_workplace` int,
  `charge_das_IP` int,
  `charge_das_autre` int,
  `indice_confiance` int,
  `budget_negoce` int,
  `budget_build` int,
  `budget_autre` int,
  `duree_contrat_annee` int,
  `version_offre` int DEFAULT 1,
  `date_debut_prestation` datetime,
  `date_remise_effective` datetime
);

CREATE TABLE `avant_Vente_format_reponse` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE `avant_Vente_type` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE `avant_Vente_status` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE `indice_confiance` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE `note` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `texte` text,
  `created_at` datetime DEFAULT (now())
);

CREATE TABLE `assoc_avant_vente_note` (
  `avant_vente_id` int,
  `note_id` int
);

CREATE TABLE `log` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `cree_par` int,
  `contenu` text,
  `created_at` datetime DEFAULT (now())
);

CREATE TABLE `assoc_Avant_vente_log` (
  `log_id` int,
  `avant_vente_id` int
);

CREATE TABLE `planning` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `date` datetime,
  `charge` decimal,
  `AM_ou_PM` boolean COMMENT 'false pour matin, true pour apres midi'
);

CREATE TABLE `assoc_utilisateur_planning_AVV_planification` (
  `user_id` int,
  `type_entree` ENUM ('AVV', 'planification'),
  `planning_id` int,
  `avant_vente_id` int,
  `planification_id` int
);

CREATE TABLE `planification` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `cree_par` int,
  `code_imputation` varchar(255),
  `demandeur` int,
  `client_id` int,
  `contact_client` int,
  `charge_perimetre_valide` boolean,
  `validateur` int,
  `date_debut_souhaitee` datetime,
  `date_fin_souhaitee` datetime,
  `das_principal` int,
  `charge_das1` int,
  `das_2` int,
  `charge_das2` int,
  `das_3` int,
  `charge_das3` int,
  `das_4` int,
  `charge_das4` int,
  `das_5` int,
  `charge_das5` int,
  `piece_jointe` varchar(255),
  `raccourci` varchar(255),
  `status_id` int,
  `created_at` datetime DEFAULT (now()),
  `responsable_planification` int,
  `chef_projet` int
);

CREATE TABLE `planification_status` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `status` varchar(255)
);

CREATE TABLE `planification_responsable` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE `DAS` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE `assoc_planification_note` (
  `planification_id` int,
  `note_id` int
);

ALTER TABLE `utilisateurs` ADD FOREIGN KEY (`type_id`) REFERENCES `utilisateurs_type` (`id`);

ALTER TABLE `utilisateurs` ADD FOREIGN KEY (`titre_id`) REFERENCES `utilisateurs_titre` (`id`);

ALTER TABLE `utilisateurs` ADD FOREIGN KEY (`agence_id`) REFERENCES `agence` (`id`);

ALTER TABLE `departement` ADD FOREIGN KEY (`region_id`) REFERENCES `region` (`id`);

ALTER TABLE `agence` ADD FOREIGN KEY (`departement_id`) REFERENCES `departement` (`id`);

ALTER TABLE `entreprise` ADD FOREIGN KEY (`type`) REFERENCES `entreprise_type` (`id`);

ALTER TABLE `contact` ADD FOREIGN KEY (`entreprise_id`) REFERENCES `entreprise` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`cree_par`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`demandeur`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`client_id`) REFERENCES `entreprise` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`type_demande`) REFERENCES `avant_Vente_type` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`agence_id`) REFERENCES `agence` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`format_reponse`) REFERENCES `avant_Vente_format_reponse` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`status`) REFERENCES `avant_Vente_status` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`Acteur_principal`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`Acteur_2`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`Acteur_3`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `avant_vente` ADD FOREIGN KEY (`indice_confiance`) REFERENCES `indice_confiance` (`id`);

ALTER TABLE `assoc_avant_vente_note` ADD FOREIGN KEY (`avant_vente_id`) REFERENCES `avant_vente` (`id`);

ALTER TABLE `assoc_avant_vente_note` ADD FOREIGN KEY (`note_id`) REFERENCES `note` (`id`);

ALTER TABLE `log` ADD FOREIGN KEY (`cree_par`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `assoc_Avant_vente_log` ADD FOREIGN KEY (`log_id`) REFERENCES `log` (`id`);

ALTER TABLE `assoc_Avant_vente_log` ADD FOREIGN KEY (`avant_vente_id`) REFERENCES `avant_vente` (`id`);

ALTER TABLE `assoc_utilisateur_planning_AVV_planification` ADD FOREIGN KEY (`user_id`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `assoc_utilisateur_planning_AVV_planification` ADD FOREIGN KEY (`planning_id`) REFERENCES `planning` (`id`);

ALTER TABLE `assoc_utilisateur_planning_AVV_planification` ADD FOREIGN KEY (`avant_vente_id`) REFERENCES `avant_vente` (`id`);

ALTER TABLE `assoc_utilisateur_planning_AVV_planification` ADD FOREIGN KEY (`planification_id`) REFERENCES `planification` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`cree_par`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`demandeur`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`client_id`) REFERENCES `entreprise` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`contact_client`) REFERENCES `contact` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`validateur`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`das_principal`) REFERENCES `DAS` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`das_2`) REFERENCES `DAS` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`das_3`) REFERENCES `DAS` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`das_4`) REFERENCES `DAS` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`das_5`) REFERENCES `DAS` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`status_id`) REFERENCES `planification_status` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`responsable_planification`) REFERENCES `planification_responsable` (`id`);

ALTER TABLE `planification` ADD FOREIGN KEY (`chef_projet`) REFERENCES `utilisateurs` (`id`);

ALTER TABLE `assoc_planification_note` ADD FOREIGN KEY (`planification_id`) REFERENCES `planification` (`id`);

ALTER TABLE `assoc_planification_note` ADD FOREIGN KEY (`note_id`) REFERENCES `note` (`id`);

CREATE INDEX `utilisateurs_index_0` ON `utilisateurs` (`id`);

CREATE INDEX `utilisateurs_index_1` ON `utilisateurs` (`nom`);

CREATE INDEX `region_index_2` ON `region` (`id`);

CREATE INDEX `region_index_3` ON `region` (`nom`);

CREATE INDEX `departement_index_4` ON `departement` (`id`);

CREATE INDEX `departement_index_5` ON `departement` (`region_id`);

CREATE INDEX `departement_index_6` ON `departement` (`nom`);

CREATE INDEX `departement_index_7` ON `departement` (`id`, `region_id`, `nom`);

CREATE INDEX `agence_index_8` ON `agence` (`id`);

CREATE INDEX `agence_index_9` ON `agence` (`departement_id`);

CREATE INDEX `agence_index_10` ON `agence` (`nom`);

CREATE INDEX `agence_index_11` ON `agence` (`id`, `departement_id`, `nom`);

CREATE INDEX `entreprise_index_12` ON `entreprise` (`id`);

CREATE INDEX `entreprise_index_13` ON `entreprise` (`nom`);

CREATE INDEX `entreprise_type_index_14` ON `entreprise_type` (`id`);

CREATE INDEX `entreprise_type_index_15` ON `entreprise_type` (`nom`);

CREATE INDEX `contact_index_16` ON `contact` (`id`);

CREATE INDEX `contact_index_17` ON `contact` (`entreprise_id`);

CREATE INDEX `contact_index_18` ON `contact` (`nom`);

CREATE INDEX `contact_index_19` ON `contact` (`id`, `entreprise_id`);
