create table couchdb_stats (
       id integer primary key,
       timestamp integer not null default (strftime('%s','now')),
       json_payload TEXT not null
);

create table open_databases(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
);

create table auth_cache_hits(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)

);
create table auth_cache_misses(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table database_reads(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table database_writes(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table request_time(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table open_os_files(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table requests(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table bulk_requests(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table view_reads(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table clients_requesting_changes(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table temporary_view_reads(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_method_delete(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_method_head(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_method_post(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_method_put(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_method_get(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_method_copy(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_400(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_201(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_403(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_409(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_200(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_202(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_404(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_301(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_405(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_500(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_401(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_304(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
       
);
create table http_status_code_412(
       couch_stats_id integer,
        current int default 0 not null,
	sum int default 0 not null,
	mean float default 0 not null,
       stddev float default 0 not null,
       min int default 0 not null,
       max int default 0 not null,
	 FOREIGN KEY(couch_stats_id) REFERENCES couchdb_stats (id)
     
);
