SELECT (geocode_postalcode_polygons(Array['03204'], Array['Spain'])).*;
SELECT (geocode_postalcode_polygons(Array['03204'], 'ESP')).*;
SELECT (geocode_postalcode_polygons(Array['03204'])).*;
SELECT (geocode_postalcode_points(Array['03204'], 'Spain')).*;
SELECT (geocode_postalcode_points('{03204}', 'Spain')).*;
SELECT (geocode_postalcode_points(Array['03204'])).*;
SELECT (geocode_postalcode_points(Array['03204'], Array['Spain'])).*;
SELECT geocode_greatbritain_outward('YO1 721');
SELECT (admin0_available_services(Array['Spain'])).*;

-- Insert mock source data
INSERT INTO global_postal_code_points (the_geom, iso3, postal_code, postal_code_num) VALUES (
  '0101000020E61000000000000000E040408036B47414764840',
  'ESP',
  '03204',
  3204
);

INSERT INTO global_postal_code_polygons (the_geom, iso3, postal_code, postal_code_num) VALUES (
  '0106000020E610000001000000010300000001000000040000000000000000E000C01F383D7839B740400000000000E000C0AA3C0EDE220F3B4000000000004812404FB7FCCD04893D400000000000E000C01F383D7839B74040',
  'ESP',
  '03204',
  3204
);

INSERT INTO country_decoder (iso3, synonyms) VALUES (
  'ESP',
  Array['spain', 'Spain', 'ESP']
);

INSERT INTO available_services (adm0_a3, admin0, postal_code_points, postal_code_polygons) VALUES (
  'ESP',
  't',
  't',
  't'
);

INSERT INTO admin0_synonyms (adm0_a3, name, name_, rank) VALUES (
	'ESP',
	'Spain',
	'spain',
	3
);

INSERT INTO admin0_synonyms (adm0_a3, name, name_, rank) VALUES (
	'ESP',
	'ESP',
	'esp',
	4
);

-- Check that the geocoding function is callable, should return success = true
SELECT (geocode_postalcode_polygons(Array['03204'], Array['Spain'])).geom;

