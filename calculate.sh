#! /bin/bash
set -o errexit
echo "Creating tag CSV file..."
osm-tag-csv-history -i ~/osm/data/ireland-and-northern-ireland-internal.osh.pbf -o iebuilding.csv.gz --tag building --object-types wr --columns iso_timestamp,tag_count_delta,changeset_id,object_type_long,raw_id

echo "Setting up PostgreSQL table..."
psql -c "DROP TABLE IF EXISTS iebuildings;"
psql -c "CREATE TABLE iebuildings ( gid SERIAL PRIMARY KEY, iso_timestamp TIMESTAMP WITH TIME ZONE, delta SMALLINT, changeset_id INTEGER, osmtype TEXT NOT NULL, osmid INTEGER NOT NULL, total_so_far INTEGER NULL );"
psql -c "CREATE INDEX iebuildings__ordering ON iebuildings(iso_timestamp, osmid);"

echo "Importing tag changes into postgresql..."
zcat iebuilding.csv.gz | psql -c "COPY iebuildings ( iso_timestamp, delta, changeset_id, osmtype, osmid ) FROM STDIN CSV HEADER;"

psql -c "WITH results AS ( SELECT gid, SUM(delta) OVER (ORDER BY (iso_timestamp, osmid)) AS total FROM iebuildings)  UPDATE iebuildings SET total_so_far = results.total FROM results WHERE results.gid = iebuildings.gid"

echo "Calculating the results of who added the buildings..."
psql -c "COPY ( select distinct on (total_so_far) iso_timestamp AT TIME ZONE 'Europe/Dublin' AS datetime, total_so_far as rank, changeset_id, 'https://www.openstreetmap.org/changeset/'||changeset_id as changeset_url, osmtype, osmid, 'https://www.openstreetmap.org/'||osmtype||'/'||osmid as object_url from iebuildings where total_so_far%500000 = 0  order by total_so_far, iso_timestamp, osmtype, osmid ) TO STDOUT CSV HEADER;" > results.csv
cat results.csv

psql -c "COPY ( select iso_timestamp at time zone 'Europe/Dublin' as datetime, to_char(delta, 'S9') as tag_change_type, 'https://www.openstreetmap.org/changeset/'||changeset_id as changeset, 'https://www.openstreetmap.org/'||osmtype||'/'||osmid as object, total_so_far as total_buildings_after_this_change from iebuildings where abs(total_so_far - 2000000 ) <= 1 and delta != 0 order by iso_timestamp, osmid ) TO STDOUT CSV HEADER" > two-million-track.csv
