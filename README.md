# “What was the 2,000,000th building added to OSM in Ireland?”

The [OSM community in Ireland](https://www.openstreetmap.ie/) is engaged in another multi-year mapping project, to [map all the buildings in Ireland](https://tasks.openstreetmap.ie/).

By March 2022, there were over 2,000,000 buildings. Which caused someone to ask “What was the 2,000,000th building?”. So who added #2,000,000? 🥁 drumroll...

The 2,000,000th Building was added by [Boggedy](https://www.openstreetmap.org/user/Boggedy) on 1st March 2022, and is in [An Bhealtaine Íochtarach, Gort a' Choirce, Co. Dhún na nGall](https://www.openstreetmap.org/way/1036394489#map=14/55.1091/-8.1347)! Technical OSM details: It's [way 1,036,394,489](https://www.openstreetmap.org/way/1036394489), added in [changeset 117,996,721](https://www.openstreetmap.org/changeset/117996721).

Here's other milestones:

datetime             |  rank     |  changeset_id  |  changeset_url                                      |  osmtype  |  osmid       |  object_url
---------------------|-----------|----------------|-----------------------------------------------------|-----------|--------------|----------------------------------------------
2018-01-08 10:31:43  |  500000   |  55260556      |  https://www.openstreetmap.org/changeset/55260556   |  way      |  551628233   |  https://www.openstreetmap.org/way/551628233
2020-02-13 23:54:27  |  1000000  |  80979131      |  https://www.openstreetmap.org/changeset/80979131   |  way      |  772271829   |  https://www.openstreetmap.org/way/772271829
2021-02-14 22:04:19  |  1500000  |  99268589      |  https://www.openstreetmap.org/changeset/99268589   |  way      |  907155474   |  https://www.openstreetmap.org/way/907155474
2022-03-01 22:14:16  |  2000000  |  117996721     |  https://www.openstreetmap.org/changeset/117996721  |  way      |  1036394489  |  https://www.openstreetmap.org/way/1036394489


## Installation

If you want to calculate this data yourself:

* Download the latest [full OSM history file from Geofabrik for Ireland](https://osm-internal.download.geofabrik.de/europe/ireland-and-northern-ireland.html) ([`ireland-and-northern-ireland-internal.osh.pbf`](https://osm-internal.download.geofabrik.de/europe/ireland-and-northern-ireland-internal.osh.pbf) currently 381 MB).
* Create a local PostgreSQL database.
* Install the latest version of [`osm-tag-csv-history`](https://github.com/amandasaurus/osm-tag-csv-history) (technically ≥ v0.5).
* Run `./calculate.sh`. `results.csv` has the output.

## The second 2,000,000th building

Observant people might notice a strange way the 2,000,000th building was calculated. Because shortly after we hit 2,000,000, someone [removed](https://www.openstreetmap.org/changeset/117997219) a `building` tag from [something](https://www.openstreetmap.org/way/642701472), bringing us under two mill. Within a few hours, Boggedy had [continued mapping](https://www.openstreetmap.org/changeset/117997767) and added more buidlings, including [another](https://www.openstreetmap.org/way/1036402185) bringing our total above 2,000,000 again.

The progress aobve & below 2,000,000 is visible in the `two-million-track.csv` which `calculate.sh` generates.

## Notes

* “Ireland” here refers to the island of Ireland
* Only OSM `way` & `relations` are analyzed, not `nodes`
* Sometime OSM data is “redacted”, and removed from the history, so it's _techncially_ possible for someone to have added some others. The goal of this is for fun, nothing too serious.
	* In Sept 2012 changed it's licence to the current ODbL. Some people didn't agree to this change (or were uncontactable)
	* Copyright infringing edits are also redacted (because OSM doesn't have permission to distribute that data)
* This code is copyright 2022 ©, released under the Affero GNU GPL v3+, cf. [LICENCE](./LICENCE).
* This contains data [© OpenStreetMap](https://www.openstreetmap.org/copyright), released under the [ODbL licence](https://www.openstreetmap.org/copyright).

## See also

* This code is hosted on [Github: `amandasaurus/osm-two-million-buildings-in-ireland`](https://github.com/amandasaurus/osm-two-million-buildings-in-ireland)
* I posted this on:
  * [my OpenStreetMap Diary](https://www.openstreetmap.org/user/%E1%9A%9B%E1%9A%90%E1%9A%8B%E1%9A%90%E1%9A%85%E1%9A%87%E1%9A%90%E1%9A%9C%20%F0%9F%8F%B3%EF%B8%8F%E2%80%8D%F0%9F%8C%88/diary/398897)
  * [`en.osm.town` mastodon/fediverse server](https://en.osm.town/web/@amapanda/108038077128287734)
  * [twitter](https://twitter.com/lalonde/status/1508671383693373440)
  * [OSM Ireland Telegram](https://t.me/c/1423083417/12504)

