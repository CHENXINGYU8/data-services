CREATE EXTENSION postgis;
CREATE EXTENSION schema_triggers;
CREATE EXTENSION plpythonu;
CREATE EXTENSION cartodb;
CREATE EXTENSION cdb_geocoder_admin1;

-- Check that the geocoding functions are callable, should return NULL
SELECT (geocode_admin1_polygons(Array['TX','Cuidad Real', 'sevilla'])).*;
SELECT (geocode_admin1_polygons(Array['NH', 'Vermont'], 'United States')).*;
SELECT (geocode_admin1_polygons(Array['az', 'az'], Array['Ecuador', 'USA'])).*;

-- Mock the varnish invalidation function
CREATE OR REPLACE FUNCTION public.cdb_invalidate_varnish(table_name text) RETURNS void AS $$
BEGIN
  RETURN;
END
$$
LANGUAGE plpgsql;

-- Add a few data to the sources
COPY global_province_polygons (the_geom, adm1_code, objectid_1, diss_me, adm1_cod_1, iso_3166_2, wikipedia, iso_a2, adm0_sr, name, name_alt, name_local, type, type_en, code_local, code_hasc, note, hasc_maybe, region, region_cod, provnum_ne, gadm_level, check_me, scalerank, datarank, abbrev, postal, area_sqkm, sameascity, labelrank, featurecla, name_len, mapcolor9, mapcolor13, fips, fips_alt, woe_id, woe_label, woe_name, latitude, longitude, sov_a3, iso3, adm0_label, admin, geonunit, gu_a3, gn_id, gn_name, gns_id, gns_name, gn_level, gn_region, gn_a1_code, region_sub, sub_code, gns_level, gns_lang, gns_adm1, gns_region, cartodb_id, created_at, updated_at, the_geom_webmercator, synonyms, frequency) FROM stdin;
0106000020E6100000010000000103000000010000001C000000701C468693172C405BCFC9FB20EB464010E0C037081E2C40F7FF710981E74640606B2301AC1A2C40B407F55702E64640200BD34801192C40A44EE24698E34640503B8E674E162C4084868DF1EEE246400025D4480D132C40B43156A168E14640701EE41F19082C400CFADB0CA1E24640E0F6B6C345062C401815CAFBB1E24640A00B4B5DB3022C40EF46C124BCE2464010E49A3E6E012C40CB84EFBA8CE24640105943E9D0FA2B40ECD210DDEBE14640008981CA8FF72B40071D4DCAEFE24640B05E6F7FDDDC2B40F3246E6C88E5464060FB4FFA19CE2B40A46CBD87B5E746404058ECF694C52B408CF11C3411EA4640FFF7D7E59FC82B40BCC34EE79AEB46400077C737A4D02B403C3FEF3AB8EC4640E04B53FA05D82B4090EF60F885ED464090EBDCBC6BDD2B40E048DFA985EE464000A5771CC0E92B40BC5B8EF1D4EF4640005BBBFD66F22B40208A181748F04640805CE1823AF92B402CA5060659F0464040FC6A45A0FE2B404B4FC4C11DF046408061640B9F022C4060B922EEBEEF4640FFD76EE28A072C405421278BBDEE4640E09BADEC49092C40FB7EEC1D7AED4640AF09D3481D0B2C40D86DDB0C8DEC4640701C468693172C405BCFC9FB20EB4640    SVN-1035        1473    1035    SVN-1035        SI-     \N      SI      1       Vipava  \N      \N      Opcine  Commune|Municipality    \N      SI.SP.VI        \N
      \N      Goriška \N      162     2       0       10      8       \N      VI      0       -99     10      Admin-1 scale rank      6       2       12      SIE1    \N      -55848385
       \N      \N      45.8271000000000015     13.9723000000000006     SVN     SVN     2       Slovenia        Slovenia        SVN     3239075 Obcina Vipava   243467  Vipava, Obcina  1
       \N      SI.E1   \N      \N      1       div     SI05    \N      3700    2014-02-18 19:53:50.080158+00   2014-04-01 15:18:54.094644+00   0106000020110F0000010000000103000000010000001C00000023340ED8CEDB3741C0404B7264F35541C85B157A4AE13741B323798AF9EE5541CEDCBDE56FDE37414004235027ED5541489EE87B05DD3741D970658A36EA55418D272EB8BADA374116C6965868E95541A8917D26F7D73741F9BBEB238DE75541A6C99293A9CE37417F31C28009E95541DA9DBCA51CCD3741A5FAE31E1EE9554121BD100C14CA37414E69CD7D2AE95541124037ECFFC8374162390EC3F0E85541332B2FC661C337417AB6C1E72CE855418A0578349EC037417308826069E95541BCFC69D6F1A93741B086FDCC92EC55419F7FD8E3679D3741462E0A8039EF554160E7068E2B963741A150E52919F25541861B631AC198374148B84A13F9F3554123289F23909F3741CCF276F254F55541F49EE41CD5A53741895CFAD14FF655415E8C59A46AAA3741EE95F4A487F755414B69D859E3B43741E59BB99720F95541A6ECFD723CBC3741762F910EADF9554144635A9E08C23741DD3BD2B6C1F95541C650CF259EC637415377246A79F9554105D616CA02CA374149377DBD05F9554170AA9CC530CE3741A52C14CCCBF755419A5F7271ACCF37414FD3A85D41F65541A2FB415F39D13741C55D614C20F5554123340ED8CEDB3741C0404B7264F35541    {vipava,"obcina vipava","vipava, obcina",si.e1,si.sp.vi,svn-1035,svn-1035}      5
\.

-- Check that the synonym function is callable, should return true
SELECT (geocode_admin1_polygons(Array['obcina vipava'])).success;
