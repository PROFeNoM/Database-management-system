-- ============================================================
--   Utilisateur de la base de données
-- ============================================================

create user if not exists 'velo'@'localhost' identified by 'P@ssW0rd';
grant all on VELO.* to 'velo'@'localhost' with grant option ;
set global log_bin_trust_function_creators=1;
flush privileges;