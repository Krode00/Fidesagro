-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ref
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ref
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ref` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema iam
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema iam
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `iam` ;
-- -----------------------------------------------------
-- Schema core
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema core
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `core` ;
-- -----------------------------------------------------
-- Schema derisk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema derisk
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `derisk` ;
-- -----------------------------------------------------
-- Schema supply
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema supply
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `supply` ;
-- -----------------------------------------------------
-- Schema connect
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema connect
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `connect` ;
-- -----------------------------------------------------
-- Schema partner
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema partner
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `partner` ;
-- -----------------------------------------------------
-- Schema ops
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ops
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ops` ;
USE `ref` ;

-- -----------------------------------------------------
-- Table `ref`.`ref.states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ref.states (
  state_id SMALLINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(191) NOT NULL,
  iso_code VARCHAR(45) NOT NULL,
  geo_zone VARCHAR(191) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (state_id),
  UNIQUE INDEX name_UNIQUE (name),
  UNIQUE INDEX iso_code_UNIQUE (iso_code)
) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `ref`.`ref.lgas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ref.lgas (
  lga_id INT NOT NULL AUTO_INCREMENT,
  state_id SMALLINT NOT NULL,
  name VARCHAR(191) NOT NULL,
  is_operational TINYINT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (lga_id),
  CONSTRAINT fk_lgas_state
    FOREIGN KEY (state_id)
    REFERENCES ref.states (state_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table `ref`.`ref.wards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ref`.`ref.wards` (
  `ward_id` INT NOT NULL,
  `lga_id` INT NOT NULL,
   name VARCHAR(191) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ward_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ref`.`ref.languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ref`.`ref.languages` (
  `language_id` SMALLINT NOT NULL,
  `iso_639_3` VARCHAR(45) NOT NULL,
  `name` TEXT NULL,
  `supports_ussd` TINYINT NULL,
  `supports_ivr` TINYINT NULL,
  `polly_voice_id` TEXT NULL,
  `is_active` TINYINT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ref`.`ref.crops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ref`.`ref.crops` (
  `crop_id` SMALLINT NOT NULL,
  `name` TEXT NULL,
  `scientific_name` TEXT NULL,
  `default_cycle_days` SMALLINT NULL,
  `is_insurable` TINYINT NULL,
  `is_tradeable` TINYINT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`crop_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ref`.`ref.crop_grades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ref`.`ref.crop_grades` (
  `crop_grade_id` SMALLINT NOT NULL,
  `crop_id` SMALLINT NOT NULL,
  `grade_code` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`crop_grade_id`),
  CONSTRAINT `crop_grade_id_crop_id`
    FOREIGN KEY (`crop_grade_id`)
    REFERENCES `ref`.`ref.crops` (`crop_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ref`.`ref.yield_factors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ref`.`ref.yield_factors` (
  `yield_factor_id` BIGINT NOT NULL AUTO_INCREMENT,
  `crop_id` SMALLINT NOT NULL,
  `lga_id` INT NOT NULL,
  `tonnes_per_ha` DECIMAL(8,3) NOT NULL,
  `source` TEXT NOT NULL,
  `effective_from` DATE NOT NULL,
  `effective_to` DATE NOT NULL,
  PRIMARY KEY (`yield_factor_id`),
  INDEX `yield_factor_id_lga_id_idx` (`lga_id` ) ,
  CONSTRAINT `yield_factor_id_lga_id`
    FOREIGN KEY (`lga_id`)
    REFERENCES `ref`.`ref.lgas` (`lga_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ref`.`ref.units_of_measure`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ref`.`ref.units_of_measure` (
  `uom_id` SMALLINT NOT NULL,
  `code` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `base_unit` TEXT NOT NULL,
  `factor_to_base` DECIMAL(12,4) NOT NULL,
  PRIMARY KEY (`uom_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ref`.`ref.cropping_seasons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ref`.`ref.cropping_seasons` (
  `season_id` SMALLINT NOT NULL,
  `label` TEXT NOT NULL,
  `year` SMALLINT NOT NULL,
  `starts_on` DATE NOT NULL,
  `ends_on` DATE NOT NULL,
  `is_current` TINYINT NOT NULL,
  PRIMARY KEY (`season_id`),
  UNIQUE INDEX `label_UNIQUE` (`label` ) )
ENGINE = InnoDB;

USE `iam` ;

-- -----------------------------------------------------
-- Table `iam`.`iam.users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iam`.`iam.users` (
  `user_id` INT NOT NULL,
  `external_auth_id` TEXT NOT NULL,
  `email` VARCHAR(45) CHARACTER SET 'utf8mb4' NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `full_name` TEXT NOT NULL,
  `actor_kind` VARCHAR(45) NOT NULL,
  `preferred_language_id` SMALLINT NULL,
  `status` VARCHAR(45) NOT NULL,
  `mfa_enabled` TINYINT NOT NULL,
  `last_login_at` TIMESTAMP NULL,
  `failed_login_count` SMALLINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `external_auth_id_UNIQUE` (`external_auth_id` ) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ) ,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iam`.`iam.roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iam`.`iam.roles` (
  `role_id` SMALLINT NOT NULL,
  `code` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  `is_internal` TINYINT NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iam`.`iam.permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iam`.`iam.permissions` (
  `permission_id` SMALLINT NOT NULL,
  `code` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  `is_money_adjacent` TINYINT NOT NULL,
  PRIMARY KEY (`permission_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iam`.`iam.role_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iam`.`iam.role_permissions` (
  `role_id` SMALLINT NOT NULL,
  `permission_id` SMALLINT NOT NULL,
  `granted_at` TIMESTAMP NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iam`.`iam.user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iam`.`iam.user_roles` (
  `user_id` INT NULL,
  `role_id` SMALLINT NOT NULL,
  `scope_entity_type` TEXT NULL,
  `assigned_by` VARCHAR(45) NULL,
  `assigned_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `revoked_at` TIMESTAMP NULL ,
  `user_role_id` BIGINT NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iam`.`iam.user_sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `iam`.`iam.user_sessions` (
  `session_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  `user_agent` TEXT NOT NULL,
  `started_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ended_at` TIMESTAMP NULL,
  PRIMARY KEY (`session_id`))
ENGINE = InnoDB;

USE `core` ;

-- -----------------------------------------------------
-- Table `core`.`core.champions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.champions` (
  `champion_id` INT NOT NULL,
  `user_id` INT NULL,
  `champion_code` TEXT NOT NULL,
  `full_name` TEXT NOT NULL,
  `phone` INT NOT NULL,
  `alternate_phone` INT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NULL,
  `home_lga_id` INT NOT NULL,
  `recruited_on` DATE NOT NULL,
  `training_completed_on` DATE NULL,
  `device_issued` TINYINT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `exited_on` DATE NULL,
  `exited_reason` TEXT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`champion_id`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.champion_coverage_areas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.champion_coverage_areas` (
  `champion_id` INT NOT NULL,
  `lga_id` INT NOT NULL,
  `is_primary` TINYINT NOT NULL,
  `assigned_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `released_at` TIMESTAMP NULL,
  PRIMARY KEY (`champion_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.cooperatives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.cooperatives` (
  `cooperative_id` INT NOT NULL,
  `cooperative_code` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `registration_no` TEXT NULL,
  `onboarding_champion_id` INT NOT NULL,
  `lga_id` INT NOT NULL,
  `ward_id` INT NULL,
  `village` TEXT NULL,
  `formed_on` DATE NULL,
  `is_women_led` TINYINT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `onboarded_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activated_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cooperative_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.cooperative_officers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.cooperative_officers` (
  `officer_id` INT NOT NULL,
  `cooperative_id` INT NOT NULL,
  `user_id` INT NULL,
  `full_name` TEXT NOT NULL,
  `phone` INT NOT NULL,
  `office` TEXT NOT NULL,
  `is_portal_admin` TINYINT NOT NULL,
  `term_starts_on` DATE NOT NULL,
  `term_ends_on` DATE NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`officer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.farmers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.farmers` (
  `farmer_id` INT NOT NULL,
  `farmer_code` TEXT NOT NULL,
  `champion_id` INT NOT NULL,
  `cooperative_id` INT NULL,
  `msisdn` INT NOT NULL,
  `full_name` TEXT NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NULL,
  `national_id_hash` TEXT NULL,
  `preferred_language_id` SMALLINT NOT NULL,
  `is_iiterate` TINYINT NULL,
  `household_size` SMALLINT NULL,
  `lga_id` INT NOT NULL,
  `ward_id` INT NULL,
  `village` TEXT NULL,
  `onboarding_path` VARCHAR(45) NOT NULL,
  `kyc_level` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `merged_into_farmer_d` INT NULL,
  `registered_at` TIMESTAMP NULL,
  `synced_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activated_at` TIMESTAMP NULL,
  `exited_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`farmer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.farmer_attribution_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.farmer_attribution_history` (
  `attribution_id` BIGINT NOT NULL,
  `farmer_id` INT NOT NULL,
  `previous_champion_id` INT NULL,
  `new_champion_id` INT NOT NULL,
  `reason` TEXT NOT NULL,
  `changed_by` INT NOT NULL,
  `changed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`attribution_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.farmer_consents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.farmer_consents` (
  `consent_id` INT NOT NULL,
  `farmer_id` INT NOT NULL,
  `purpose` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `channel` VARCHAR(45) NOT NULL,
  `language_id` SMALLINT NOT NULL,
  `script_version` TEXT NOT NULL,
  `witnessed_by_champion_id` INT NULL,
  `granted_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` TIMESTAMP NULL,
  `withdrawn_at` TIMESTAMP NULL,
  PRIMARY KEY (`consent_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.mobile_money_accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.mobile_money_accounts` (
  `wallet_id` INT NOT NULL,
  `farmer_id` INT NOT NULL,
  `provider_code` TEXT NOT NULL,
  `account_msisdn` VARCHAR(45) NOT NULL,
  `account_name` TEXT NOT NULL,
  `is_primary` TINYINT NOT NULL,
  `verified_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`wallet_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.farm_plots`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.farm_plots` (
  `plot_id` INT NOT NULL,
  `farmer_id` INT NOT NULL,
  `plot_label` TEXT NOT NULL,
  `boundary` VARCHAR(45) NULL,
  `centroid` VARCHAR(45) NOT NULL,
  `declared_hectares` VARCHAR(45) NOT NULL,
  `verified_hectares` VARCHAR(45) NULL,
  `hectares_in_use` VARCHAR(45) NULL,
  `measure_source` VARCHAR(45) NOT NULL,
  `verification_status` VARCHAR(45) NOT NULL,
  `variance_pct` VARCHAR(45) NULL,
  `lga_id` INT NOT NULL,
  `tenure_type` TEXT NULL,
  `captured_by_champion_id` INT NOT NULL,
  `captured_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `synced_at` TIMESTAMP NULL,
  `retired_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`plot_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.plot_verifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.plot_verifications` (
  `verification_id` BIGINT NOT NULL,
  `plot_id` INT NOT NULL,
  `provider` TEXT NOT NULL,
  `imagery_date` DATE NOT NULL,
  `computed_hectares` VARCHAR(45) NOT NULL,
  `confidence_pct` VARCHAR(45) NOT NULL,
  `outcome` VARCHAR(45) NOT NULL,
  `reviewer_user_id` INT NULL,
  `review_note` TEXT NULL,
  `requested_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` TIMESTAMP NULL,
  PRIMARY KEY (`verification_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.plot_season_crops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.plot_season_crops` (
  `plot_season_crop_id` INT NOT NULL,
  `plot_id` INT NOT NULL,
  `season_id` SMALLINT NOT NULL,
  `crop_id` SMALLINT NOT NULL,
  `area_hectares` VARCHAR(45) NOT NULL,
  `planted_on` DATE NULL,
  `expected_harvest_on` DATE NULL,
  `actual_harvest_on` DATE NULL,
  `actual_yield_tonnes` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`plot_season_crop_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.aggregated_farm_blocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.aggregated_farm_blocks` (
  `block_id` INT NOT NULL,
  `block_code` TEXT NOT NULL,
  `block_kind` VARCHAR(45) NOT NULL,
  `cooperative_id` INT NULL,
  `coordinating_champion_id` INT NULL,
  `name` TEXT NOT NULL,
  `lga_id` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `min_hectares_to_activate` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `activated_at` TIMESTAMP NULL,
  `dissolved_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`coe.block_plot_memberships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`coe.block_plot_memberships` (
  `membership_id` INT NOT NULL,
  `block_id` INT NOT NULL,
  `plot_id` INT NOT NULL,
  `season_id` SMALLINT NOT NULL,
  `joined_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `left_at` TIMESTAMP NULL,
  `left_reason` TEXT NULL,
  PRIMARY KEY (`membership_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.block_snapshots`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.block_snapshots` (
  `snapshot_id` BIGINT NOT NULL,
  `block_id` INT NOT NULL,
  `season_id` SMALLINT NOT NULL,
  `member_farmer_count` INT NOT NULL,
  `member_plot_count` INT NOT NULL,
  `total_declared_hectares` DECIMAL(14,4) NOT NULL,
  `total_verified_hectres` DECIMAL(14,4) NOT NULL,
  `verified_share_pct` VARCHAR(45) NOT NULL,
  `insured_plot_count` INT NOT NULL,
  `coverage_ratio_pct` VARCHAR(45) NOT NULL,
  `estimated_yield_tonnes` VARCHAR(45) NOT NULL,
  `has_ops_override` TINYINT NOT NULL,
  `computed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `computed_reason` TEXT NOT NULL,
  PRIMARY KEY (`snapshot_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.block_crop_summaries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.block_crop_summaries` (
  `block_crop_summary_id` BIGINT NOT NULL,
  `snapshot_id` BIGINT NOT NULL,
  `crop_id` SMALLINT NOT NULL,
  `area_hectares` DECIMAL(14,4) NOT NULL,
  `estimated_yield_tonnes` VARCHAR(45) NOT NULL,
  `yield_factor_id` BIGINT NULL,
  PRIMARY KEY (`block_crop_summary_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `core`.`core.block_overrides`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `core`.`core.block_overrides` (
  `override_id` BIGINT NOT NULL,
  `block_id` INT NOT NULL,
  `field_name` TEXT NOT NULL,
  `computed_value` DECIMAL(18,4) NOT NULL,
  `override_value` DECIMAL(18,4) NOT NULL,
  `reason` TEXT NOT NULL,
  `overriden_by` VARCHAR(45) NOT NULL,
  `overriden_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `revoked_at` TIMESTAMP NULL,
  PRIMARY KEY (`override_id`))
ENGINE = InnoDB;

USE `derisk` ;

-- -----------------------------------------------------
-- Table `derisk`.`derisk.underwriters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.underwriters` (
  `underwriter_id` INT NOT NULL,
  `legal_name` TEXT NOT NULL,
  `naicom_license_no` TEXT NOT NULL,
  `contract_status` VARCHAR(45) NOT NULL,
  `contract_signed_on` DATE NULL,
  `contract_expires_on` DATE NULL,
  `mga_commission_pct` VARCHAR(45) NULL,
  `is_publicly_nameable` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`underwriter_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.risk_zones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.risk_zones` (
  `risk_zone_id` INT NOT NULL,
  `zone_code` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `lga_id` INT NOT NULL,
  `geometry` VARCHAR(45) NOT NULL,
  `chirps_grid_ref` TEXT NOT NULL,
  `baseline_rainfall_mm` DECIMAL(8,2) NOT NULL,
  `baeline_period` TEXT NOT NULL,
  `is_active` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`risk_zone_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.products` (
  `product_id` INT NOT NULL,
  `product_code` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `crop_id` SMALLINT NOT NULL,
  `underwriter_id` INT NULL,
  `sum_insured_per_ha` VARCHAR(45) NOT NULL,
  `premium_rate_pct` VARCHAR(45) NOT NULL,
  `min_hectares` VARCHAR(45) NOT NULL,
  `max_hectares` VARCHAR(45) NOT NULL,
  `cover_start_on` DATE NOT NULL,
  `cover_end_on` DATE NOT NULL,
  `payout_sla_hours` SMALLINT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.trigger_definitions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.trigger_definitions` (
  `trigger_def_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `risk_zone_id` INT NOT NULL,
  `trigger_kind` VARCHAR(45) NOT NULL,
  `window_start_on` DATE NOT NULL,
  `window_end_on` DATE NOT NULL,
  `threshold_value` DECIMAL(10,3) NOT NULL,
  `threshold_unit` TEXT NOT NULL,
  `payout_share_pct` VARCHAR(45) NOT NULL,
  `tier_rank` SMALLINT NOT NULL,
  `is_active` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`trigger_def_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.policies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.policies` (
  `policy_id` INT NOT NULL,
  `policy_number` TEXT NOT NULL,
  `farmer_id` INT NOT NULL,
  `plot_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `risk_zone_id` INT NOT NULL,
  `season_id` SMALLINT NOT NULL,
  `pricing_mode` VARCHAR(45) NOT NULL,
  `insured_hectares` VARCHAR(45) NOT NULL,
  `sum_insured` VARCHAR(45) NOT NULL,
  `gross_premium` VARCHAR(45) NOT NULL,
  `subsidy_amount` VARCHAR(45) NOT NULL,
  `net_premium` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `cover_starts_on` DATE NOT NULL,
  `cover_ends_on` DATE NOT NULL,
  `quoted_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `issued_at` TIMESTAMP NULL,
  `cancelled_at` TIMESTAMP NULL,
  `cancellation_reason` TEXT NULL,
  `quote_channel` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`policy_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.premium_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.premium_transactions` (
  `premium_txn_id` INT NOT NULL,
  `policy_id` INT NOT NULL,
  `amount` VARCHAR(45) NOT NULL,
  `direction` VARCHAR(45) NOT NULL,
  `provider_code` TEXT NOT NULL,
  `provider_reference` TEXT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `initiated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `settled_at` TIMESTAMP NULL,
  `failure_reason` TEXT NULL,
  PRIMARY KEY (`premium_txn_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.demand_precommitments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.demand_precommitments` (
  `precommitment_id` INT NOT NULL,
  `farmer_id` INT NOT NULL,
  `cooperative_id` INT NULL,
  `product_id` INT NOT NULL,
  `pledged_amount` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `escrow_reference` TEXT NULL,
  `disclosure_script_version` TEXT NOT NULL,
  `legal_review_ref` TEXT NOT NULL,
  `compliance_approved_by` INT NOT NULL,
  `pledged_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `escrowed_at` TIMESTAMP NULL,
  `resolved_at` TIMESTAMP NULL,
  `resolution_note` TEXT NULL,
  PRIMARY KEY (`precommitment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.climate_observations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.climate_observations` (
  `observation_id` BIGINT NOT NULL,
  `risk_zone_id` INT NOT NULL,
  `observed_on` DATE NOT NULL,
  `rainfall_mm` DECIMAL(8,2) NOT NULL,
  `data_source` TEXT NOT NULL,
  `source_version` TEXT NOT NULL,
  `ingested_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_revised` TINYINT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`observation_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.trigger_evaluations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.trigger_evaluations` (
  `evaluation_id` INT NOT NULL,
  `trigger_def_id` INT NOT NULL,
  `risk_zone_id` INT NOT NULL,
  `evaluated_id` DATE NOT NULL,
  `observed_value` DECIMAL(10,3) NOT NULL,
  `threshold_value` DECIMAL(10,3) NOT NULL,
  `is_breached` TINYINT NOT NULL,
  `observation_ids` BIGINT NOT NULL,
  `engine_version` TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `evaluated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`evaluation_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.trigger_events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.trigger_events` (
  `trigger_event_id` INT NOT NULL,
  `evaluation_id` BIGINT NOT NULL,
  `trigger_def_id` INT NOT NULL,
  `risk_zone_id` INT NOT NULL,
  `season_id` SMALLINT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `affected_policy_count` INT NOT NULL,
  `total_payout_amount` VARCHAR(45) NOT NULL,
  `detected_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmed_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmed_by` INT NULL,
  `rejected_reason` TEXT NULL,
  `settled_at` TIMESTAMP NULL,
  PRIMARY KEY (`trigger_event_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.payout_batches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.payout_batches` (
  `batch_id` INT NOT NULL,
  `trigger_event_id` INT NOT NULL,
  `batch_reference` TEXT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `payout_count` INT NOT NULL,
  `total_amount` VARCHAR(45) NOT NULL,
  `prepared_by` INT NOT NULL,
  `prepared_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approved_by` INT NULL,
  `approved_at` TIMESTAMP NULL,
  `released_at` TIMESTAMP NULL,
  `completed_at` TIMESTAMP NULL,
  PRIMARY KEY (`batch_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.payout`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.payout` (
  `payout_id` INT NOT NULL,
  `batch_id` INT NOT NULL,
  `policy_id` INT NOT NULL,
  `farmer_id` INT NOT NULL,
  `wallet_id` INT NOT NULL,
  `amount` VARCHAR(45) NULL,
  `status` VARCHAR(45) NOT NULL,
  `sla_due_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `credited_at` TIMESTAMP NULL,
  `sla_met` TINYINT NULL,
  `failure_reason` TEXT NULL,
  `credited_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payout_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `derisk`.`derisk.payout_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `derisk`.`derisk.payout_transactions` (
  `payout_txn_id` INT NOT NULL,
  `payout_id` INT NOT NULL,
  `attempt_number` SMALLINT NOT NULL,
  `provider_code` TEXT NOT NULL,
  `provider_reference` TEXT NOT NULL,
  `amount` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `initiated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `settled_at` TIMESTAMP NULL,
  `failure_reason` TEXT NULL,
  PRIMARY KEY (`payout_txn_id`))
ENGINE = InnoDB;

USE `supply` ;

-- -----------------------------------------------------
-- Table `supply`.`supply.input_producers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.input_producers` (
  `supplier_id` INT NOT NULL,
  `company_name` TEXT NOT NULL,
  `rc_number` VARCHAR(45) NULL,
  `contact_name` TEXT NOT NULL,
  `contact_email` VARCHAR(45) NOT NULL,
  `contact_phone` VARCHAR(45) NOT NULL,
  `head_office_lga_id` INT NULL,
  `is_organic_certified` TINYINT NOT NULL,
  `certification_body` TEXT NULL,
  `verification_status` VARCHAR(45) NOT NULL,
  `verified_by` INT NULL,
  `verified_at` TIMESTAMP NULL,
  `status` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.`supply.supplier_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.supplier_users` (
  `supplier_user_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `job_title` TEXT NULL,
  `is_account_owner` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.`supply.supplier_coverge_areas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.supplier_coverge_areas` (
  `supplier_id` INT NOT NULL,
  `lga_id` INT NOT NULL,
  `lead_time_days` INT NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.`supply.product_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.product_categories` (
  `category_id` SMALLINT NOT NULL,
  `name` TEXT NOT NULL,
  `parent_category_id` SMALLINT NULL,
  `description` TEXT NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.`supply.products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.products` (
  `product_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  `category_id` SMALLINT NOT NULL,
  `sku` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  `uom_id` SMALLINT NOT NULL,
  `pack_size` DECIMAL(10,3) NOT NULL,
  `is_organic` TINYINT NOT NULL,
  `approval_status` VARCHAR(45) NOT NULL,
  `approved_by` VARCHAR(45) NULL,
  `approved_at` TIMESTAMP NULL,
  `is_available` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.`supply.product_prices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.product_prices` (
  `price_id` BIGINT NOT NULL,
  `product_id` INT NOT NULL,
  `unit_price` VARCHAR(45) NOT NULL,
  `min_order_qty` DECIMAL(12,3) NOT NULL,
  `effective_from` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `effective_to` TIMESTAMP NULL,
  PRIMARY KEY (`price_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.`supply.demand_requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.demand_requests` (
  `demand_request_id` INT NOT NULL,
  `cooperative_id` INT NULL,
  `farmer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `season_id` SMALLINT NOT NULL,
  `quantity` VARCHAR(45) NOT NULL,
  `captured_by_champion_id` INT NULL,
  `input_order_id` INT NULL,
  `requested_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`demand_request_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.`supply.input_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.input_orders` (
  `input_order_id` INT NOT NULL,
  `order_number` TEXT NOT NULL,
  `supplier_id` INT NOT NULL,
  `cooperative_id` INT NULL,
  `farmer_id` INT NULL,
  `placed_by_champion_id` INT NULL,
  `attributed_champion_id` INT NOT NULL,
  `season_id` SMALLINT NOT NULL,
  `delivery_lga_id` INT NOT NULL,
  `delivery_address` TEXT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `subtotal_amount` VARCHAR(45) NOT NULL,
  `logistics_amount` VARCHAR(45) NOT NULL,
  `discount_amount` VARCHAR(45) NOT NULL,
  `total_amount` VARCHAR(45) NOT NULL,
  `placed_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmed_at` TIMESTAMP NULL,
  `dispatched_at` TIMESTAMP NULL,
  `delivered_at` TIMESTAMP NULL,
  `closed_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`input_order_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.`supply.input_order_lines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.input_order_lines` (
  `order_line_id` INT NOT NULL,
  `input_order_id` INT NULL,
  `product_id` INT NULL,
  `quantity` DECIMAL(12,3) NOT NULL,
  `unit_price` VARCHAR(45) NOT NULL,
  `line_total` VARCHAR(45) NOT NULL,
  `quantity_delivered` DECIMAL(12,3) NOT NULL,
  PRIMARY KEY (`order_line_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.`supply.order_fulfilment_events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`supply.order_fulfilment_events` (
  `fufilment_event_id` INT NOT NULL,
  `input_order_id` INT NOT NULL,
  `from_status` VARCHAR(45) NULL,
  `to_status` VARCHAR(45) NOT NULL,
  `note` TEXT NULL,
  `recorded_by_user_id` INT NULL,
  `recorded_by_champion_id` INT NULL,
  `occurred_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `synced_at` TIMESTAMP NULL,
  PRIMARY KEY (`fufilment_event_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supply`.``
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supply`.`` (
)
ENGINE = InnoDB;

USE `connect` ;

-- -----------------------------------------------------
-- Table `connect`.`connect.offtakers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connect`.`connect.offtakers` (
  `offtaker_id` INT NOT NULL,
  `company_name` TEXT NOT NULL,
  `rc_number` VARCHAR(45) NOT NULL,
  `business_type` TEXT NOT NULL,
  `contact_name` TEXT NOT NULL,
  `contact_email` VARCHAR(45) NOT NULL,
  `contact_phone` VARCHAR(45) NOT NULL,
  `head_office_state_id` SMALLINT NULL,
  `annual_volume_tonnes` VARCHAR(45) NULL,
  `verification_status` VARCHAR(45) NOT NULL,
  `verified_by` VARCHAR(45) NULL,
  `verified_at` TIMESTAMP NULL,
  `status` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`offtaker_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connect`.`connect.offtakers_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connect`.`connect.offtakers_users` (
  `offtaker_user_id` INT NOT NULL,
  `offtaker_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `job_title` TEXT NULL,
  `is_account_owner` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`offtaker_user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connect`.`connect.offtaker_crop_interests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connect`.`connect.offtaker_crop_interests` (
  `offtaker_id` INT NOT NULL,
  `crop_id` SMALLINT NOT NULL,
  `target_tonnes_per_season` VARCHAR(45) NULL,
  PRIMARY KEY (`offtaker_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connect`.`connect.produce_listings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connect`.`connect.produce_listings` (
  `listing_id` INT NOT NULL,
  `listing_reference` TEXT NOT NULL,
  `block_id` INT NOT NULL,
  `season_id` SMALLINT NOT NULL,
  `crop_id` SMALLINT NULL,
  `crop_grade_id` SMALLINT NULL,
  `estimated_qantity_tonnes` VARCHAR(45) NOT NULL,
  `committed_quantity_tonnes` VARCHAR(45) NOT NULL,
  `quantity_source` VARCHAR(45) NOT NULL,
  `source_snapshot_id` BIGINT NULL,
  `harvest_window_start` DATE NOT NULL,
  `harvest_window_end` DATE NOT NULL,
  `ask_price_min` VARCHAR(45) NOT NULL,
  `ask_price_max` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `coop_confirmed_at` TIMESTAMP NULL,
  `ops_reviewed_by` VARCHAR(45) NOT NULL,
  `ops_reviewed_at` TIMESTAMP NULL,
  `published_at` TIMESTAMP NULL,
  `expires_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`listing_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connect`.`connect.offers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connect`.`connect.offers` (
  `offer_id` INT NOT NULL,
  `listing_id` INT NOT NULL,
  `offtaker_id` INT NOT NULL,
  `parent_offer_id` VARCHAR(45) NULL,
  `version_number` SMALLINT NOT NULL,
  `quantity_tonnes` VARCHAR(45) NOT NULL,
  `price_per_tonnes` VARCHAR(45) NOT NULL,
  `total_value` VARCHAR(45) NOT NULL,
  `payment_terms` TEXT NOT NULL,
  `delivery_terms` TEXT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `submitted_by_user_id` VARCHAR(45) NOT NULL,
  `submitted_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `responded_at` TIMESTAMP NULL,
  `responded_by_user_id` INT NULL,
  `expires_at` TIMESTAMP NULL,
  PRIMARY KEY (`offer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connect`.`connect.offer_messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connect`.`connect.offer_messages` (
  `message_id` BIGINT NOT NULL,
  `offer_id` INT NOT NULL,
  `sender_user_id` INT NOT NULL,
  `body` TEXT NOT NULL,
  `sent_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` TIMESTAMP NULL,
  PRIMARY KEY (`message_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connect`.`connect.offtake_contracts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connect`.`connect.offtake_contracts` (
  `contract_id` INT NOT NULL,
  `contract_number` TEXT NOT NULL,
  `offer_id` INT NOT NULL,
  `listing_id` INT NOT NULL,
  `block_d` INT NOT NULL,
  `offtaker_id` INT NOT NULL,
  `attributed_champion_id` INT NOT NULL,
  `crop_id` SMALLINT NOT NULL,
  `contracted_tonnes` VARCHAR(45) NOT NULL,
  `delivered_tonnes` VARCHAR(45) NOT NULL,
  `prce_per_tonne` VARCHAR(45) NOT NULL,
  `total_value` VARCHAR(45) NOT NULL,
  `payment_terms` TEXT NOT NULL,
  `status` VARCHAR(45) NULL,
  `settlement_confirmed_by` VARCHAR(45) NULL,
  `settlement_confirmed_at` TIMESTAMP NULL,
  `signed_at` TIMESTAMP NULL,
  `completed_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (`contract_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connect`.`connect.deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connect`.`connect.deliveries` (
  `delivery_id` INT NOT NULL,
  `contract_id` INT NOT NULL,
  `scheduled_for` DATE NOT NULL,
  `quantity_tonnes` VARCHAR(45) NOT NULL,
  `pickup_location` TEXT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `delivered_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`delivery_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `connect`.`connect.dellivery_confirmations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `connect`.`connect.dellivery_confirmations` (
  `confirmation_id` INT NOT NULL,
  `delivery_id` INT NOT NULL,
  `confirming_side` TEXT NOT NULL,
  `confirmed_quantity_tonnes` VARCHAR(45) NOT NULL,
  `confirmed_by_champion_id` INT NULL,
  `quality_note` TEXT NULL,
  `is_disputed` TINYINT NOT NULL,
  `confirmed_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`confirmation_id`))
ENGINE = InnoDB;

USE `partner` ;

-- -----------------------------------------------------
-- Table `partner`.`partner.partners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `partner`.`partner.partners` (
  `partner_id` INT NOT NULL,
  `legal_name` TEXT NOT NULL,
  `partner_type` VARCHAR(45) NOT NULL,
  `short_name` TEXT NOT NULL,
  `country_iso` CHAR(3) NOT NULL,
  `relationship_owner_user_id` INT NULL,
  `primary_contact_name` TEXT NOT NULL,
  `primary_contact_email` VARCHAR(45) NOT NULL,
  `primary_contact_phone` TEXT NULL,
  `underwriter_id` INT NULL,
  `status` VARCHAR(45) NOT NULL,
  `onboarded_on` DATE NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`partner_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `partner`.`patner.patner_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `partner`.`patner.patner_users` (
  `patner_useer_id` INT NOT NULL,
  `partner_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `job_title` TEXT NULL,
  `is_account_owner` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`patner_useer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `partner`.`partner.portal_modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `partner`.`partner.portal_modules` (
  `module_id` INT NOT NULL,
  `code` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  `requires_underwriter_gate` TINYINT NOT NULL,
  PRIMARY KEY (`module_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `partner`.`partner.partner_type_modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `partner`.`partner.partner_type_modules` (
  `partner_type` VARCHAR(45) NOT NULL,
  `module_id` SMALLINT NOT NULL,
  `display_order` SMALLINT NOT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `partner`.`partner.programmes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `partner`.`partner.programmes` (
  `programme_id` INT NOT NULL,
  `partner_id` INT NOT NULL,
  `name` TEXT NOT NULL,
  `reference_code` TEXT NULL,
  `starts_on` DATE NOT NULL,
  `ends_on` DATE NULL,
  `funding_amount` VARCHAR(45) NULL,
  `status` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`programme_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `partner`.`partner.programmes_milestone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `partner`.`partner.programmes_milestone` (
  `milestone_id` INT NOT NULL,
  `programme_id` INT NOT NULL,
  `title` TEXT NULL,
  `description` TEXT NOT NULL,
  `target_metric` TEXT NULL,
  `target_value` DECIMAL(18,4) NULL,
  `achieved_value` DECIMAL(18,4) NULL,
  `due_on` DATE NOT NULL,
  `completed_on` DATE NULL,
  `created_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`milestone_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `partner`.`partner.data_agreements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `partner`.`partner.data_agreements` (
  `agreement_id` INT NOT NULL,
  `partner_id` INT NOT NULL,
  `agreement_type` TEXT NOT NULL,
  `document_uri` TEXT NOT NULL,
  `data_scope` TEXT NOT NULL,
  `permits_pii` TINYINT NOT NULL,
  `signed_on` DATE NOT NULL,
  `expires_on` DATE NULL,
  `approved_by` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`agreement_id`))
ENGINE = InnoDB;

USE `ops` ;

-- -----------------------------------------------------
-- Table `ops`.`ops.commission_rates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.commission_rates` (
  `commission_rates_id` BIGINT NOT NULL,
  `event_type` TEXT NULL,
  `rate_basis` TEXT NULL,
  `flat_amount` VARCHAR(45) NULL,
  `percentage_rate` VARCHAR(45) NULL,
  `is_projection` TINYINT NOT NULL,
  `effective_from` DATE NOT NULL,
  `effective_to` DATE NULL,
  `approved_by` VARCHAR(45) NULL,
  PRIMARY KEY (`commission_rates_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.attribution_ledger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.attribution_ledger` (
  `ledger_entry_id` BIGINT NOT NULL,
  `champion_id` INT NOT NULL,
  `event_type` TEXT NOT NULL,
  `source_entity_type` TEXT NOT NULL,
  `source_entity_id` INT NOT NULL,
  `farmer_id` INT NULL,
  `cooperative_id` INT NULL,
  `base_amount` VARCHAR(45) NULL,
  `commission_rate_id` BIGINT NULL,
  `commission_amount` VARCHAR(45) NOT NULL,
  `is_projection` TINYINT NOT NULL,
  `occurred_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recorded_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ledger_entry_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.feature_flags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.feature_flags` (
  `flag_id` SMALLINT NOT NULL,
  `code` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  `is_enabled` TINYINT NOT NULL,
  `required_approvals` SMALLINT NOT NULL,
  `requires_compliance_approval` TINYINT NOT NULL,
  `last_changed_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`flag_id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.feature_flag_approvals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.feature_flag_approvals` (
  `approval_id` INT NOT NULL,
  `flag_id` SMALLINT NOT NULL,
  `requested_state` TINYINT NOT NULL,
  `approver_user_id` INT NOT NULL,
  `approver_role_id` SMALLINT NOT NULL,
  `decision` VARCHAR(45) NOT NULL,
  `rationale` TEXT NOT NULL,
  `decided_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`approval_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.audit_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.audit_log` (
  `audit_id` INT NOT NULL,
  `entity_schema` TEXT NOT NULL,
  `entity_table` TEXT NOT NULL,
  `entity_id` TEXT NOT NULL,
  `action` VARCHAR(45) NOT NULL,
  `actor_kind` VARCHAR(45) NOT NULL,
  `actor_user_id` INT NULL,
  `actor_champion_id` INT NULL,
  `before_state` JSON NULL,
  `after_state` JSON NULL,
  `reason` TEXT NULL,
  `ip_address` VARCHAR(45) NULL,
  `occurred_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.leads`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.leads` (
  `lead_id` INT NOT NULL,
  `lead_type` VARCHAR(45) NOT NULL,
  `company_name` TEXT NULL,
  `contact_name` TEXT NOT NULL,
  `contact_email` VARCHAR(45) NOT NULL,
  `contact_phone` TEXT NULL,
  `message` TEXT NOT NULL,
  `products_or_crops` TEXT NULL,
  `coverage_note` TEXT NULL,
  `source_page` TEXT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `assigned_to_user_id` INT NULL,
  `converted_supplier_id` INT NULL,
  `converted_offtaker_id` INT NULL,
  `acknowledged_at` TIMESTAMP NULL,
  `first_response_at` TIMESTAMP NULL,
  `submitted_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_address` VARCHAR(45) NULL,
  PRIMARY KEY (`lead_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.notifications` (
  `notification_id` INT NOT NULL,
  `channel` VARCHAR(45) NOT NULL,
  `recipient_farmer_id` INT NULL,
  `recipient_user_id` INT NULL,
  `language_id` SMALLINT NOT NULL,
  `template_code` TEXT NOT NULL,
  `body` TEXT NOT NULL,
  `related_entity_type` TEXT NULL,
  `related_entity_id` TEXT NULL,
  `status` VARCHAR(45) NOT NULL,
  `provider_reference` TEXT NULL,
  `queued_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sent_at` TIMESTAMP NULL,
  `delivered_at` TIMESTAMP NULL,
  `failure_reason` TEXT NULL,
  PRIMARY KEY (`notification_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.ussd_sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.ussd_sessions` (
  `ussd_session_id` INT NOT NULL,
  `aggregator_session_id` TEXT NULL,
  `msisdn` VARCHAR(45) NULL,
  `farmer_id` INT NULL,
  `short_code` TEXT NOT NULL,
  `network_operator` TEXT NOT NULL,
  `language_id` SMALLINT NULL,
  `is_voice_mode` TINYINT NOT NULL,
  `entry_menu` TEXT NOT NULL,
  `final_menu` TEXT NULL,
  `completed_action` TEXT NULL,
  `screen_count` SMALLINT NOT NULL,
  `started_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ended_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `duration_ms` INT NULL,
  PRIMARY KEY (`ussd_session_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.sync_batches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.sync_batches` (
  `sync_batch_id` INT NOT NULL,
  `champion_id` INT NOT NULL,
  `device_id` INT NOT NULL,
  `app_version` TEXT NOT NULL,
  `record_count` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `queued_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `received_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `conflict_count` INT NOT NULL DEFAULT 0,
  `failure_reason` TEXT NULL,
  PRIMARY KEY (`sync_batch_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.sync_conflicts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.sync_conflicts` (
  `conflict_id` BIGINT NOT NULL,
  `sync_batch_id` INT NOT NULL,
  `entity_table` TEXT NOT NULL,
  `entity_id` TEXT NOT NULL,
  `device_payload` JSON NOT NULL,
  `server_payload` JSON NOT NULL,
  `resolution` TEXT NULL,
  `resolved_by` VARCHAR(45) NULL,
  `resolved_at` TIMESTAMP NULL,
  `detected_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`conflict_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.duplicate_candidates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.duplicate_candidates` (
  `candidate_id` BIGINT NOT NULL,
  `farmer_id_a` INT NOT NULL,
  `farmer_id_b` INT NOT NULL,
  `match_score` VARCHAR(45) NOT NULL,
  `match_basis` TEXT NOT NULL,
  `resolution` TEXT NULL,
  `resolved_by` VARCHAR(45) NULL,
  `resolved_at` TIMESTAMP NULL,
  `detected_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`candidate_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.locked_content_metrics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.locked_content_metrics` (
  `metric_key` TEXT NOT NULL,
  `display_label` TEXT NOT NULL,
  `metric_value` TEXT NOT NULL,
  `is_target` TINYINT NOT NULL,
  `is_projection` TINYINT NOT NULL,
  `evidence_source` TEXT NOT NULL,
  `verified_by` VARCHAR(45) NOT NULL,
  `verified_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_as_of` DATE NOT NULL,
  PRIMARY KEY (`metric_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ops`.`ops.documents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ops`.`ops.documents` (
  `document_id` INT NOT NULL,
  `owner_entity_type` TEXT NOT NULL,
  `owner_entity_id` TEXT NOT NULL,
  `document_type` TEXT NOT NULL,
  `file_uri` TEXT NOT NULL,
  `mime_type` TEXT NOT NULL,
  `file_size_bytes` BIGINT NOT NULL,
  `checksum_sha256` CHAR(64) NOT NULL,
  `uploaded_by` INT NULL,
  `uploaded_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`document_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
