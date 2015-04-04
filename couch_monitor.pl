/**
couchdb_stats_to_sqlite.
Copyright (C) 2015  David Santiago

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
**/

package CouchMonitor::Stats::Extractor;
use strict;
use warnings;
use utf8;
use LWP::UserAgent;
use Data::Dumper;
use 5.014;

sub new{
    my $class = shift;
    my $user = shift;
    my $password = shift;
    my $server = shift;
    my $port = shift;
    my $range = shift;
    
    my $self = {
	user=>$user,
	password=>$password,
	server=>$server,
	port=>$port,
	range=>$range,
	connectionString=>"http://$user:$password\@$server:$port/_stats?range=$range",
	ua => LWP::UserAgent->new
    };
    bless $self, $class;
    return $self;
}

sub extract_stats{
    my $self = shift;
    my $response = $self->{ua}->get($self->{connectionString});

    if($response->code == 200){
	return [$response->code, $response->content];
    }

    return [$response->code, $response->status_line];
}

1;


package CouchMonitor::Database::Store::Sqlite;
use DBI;
use warnings;
use strict;
use utf8;
use 5.014;
use Data::Dumper;
use JSON;

my @TABLES = qw/couchdb_stats auth_cache_hits auth_cache_misses database_reads database_writes open_databases open_os_files request_time
bulk_requests clients_requesting_changes requests temporary_view_reads view_reads
http_method_copy http_method_delete http_method_get http_method_head http_method_post http_method_put 
http_status_code_200 http_status_code_201 http_status_code_202 http_status_code_301 http_status_code_304 http_status_code_400 
http_status_code_401 http_status_code_403 http_status_code_404 http_status_code_405 http_status_code_409 http_status_code_412
http_status_code_500/;

sub new{
    my $class = shift;
    my $datasource = shift;
    my $user = shift;
    my $password = shift;
    my $attr = shift;
    
    my $self = {
	datasource=>$datasource,
	username=>$user,
	password=>$password,
	attributes=>$attr,
	dbh=>DBI->connect($datasource, $user, $password, $attr),
	db_verified=>0,
	
    };
    bless $self, $class;
    return $self;
}


sub insert{
    my $self = shift;
    my $json = shift;
    my @first_level = qw /couchdb httpd_request_methods httpd_status_codes httpd/;
    
    if(!$self->{db_verified}){
	$self->verifyDatabase;
    }
    $json =~ s/null/0/g;
    my $json_ref = decode_json($json);
    $self->{statements}[0]->execute($json);

    my $counter=1;
    for my $first_level_key (sort keys %$json_ref){
#	say $first_level_key;
	for my $second_level_key (sort keys %{$json_ref->{$first_level_key}}){
#	    say "\t $second_level_key";
	    $self->{statements}[$counter]->execute($json_ref->{$first_level_key}{$second_level_key}{current}, 
						   $json_ref->{$first_level_key}{$second_level_key}{sum}, 
						   $json_ref->{$first_level_key}{$second_level_key}{mean}, 
						   $json_ref->{$first_level_key}{$second_level_key}{stddev}, 
						   $json_ref->{$first_level_key}{$second_level_key}{min}, 
						   $json_ref->{$first_level_key}{$second_level_key}{max});
	    $counter+=1;
	}

    }

    
    $self->{dbh}->commit;
}

sub verifyDatabase{
    my $self = shift;
    my %existingTables = map{$_=>0} @TABLES;
    
    my @tables = $self->{dbh}->tables('','main','%','TABLE');

    for my $full_table (@tables){
	my $table = (split(/"/,$full_table))[3];
	if(!exists $existingTables{$table}){
	    say "Please point to a correct SQLite database";
	    exit 0;
	}else{
	    $existingTables{$table}=1;
	}
    }

    for (keys %existingTables){
	if($existingTables{$_}==0){
	    say "Please point to a correct SQLite database";
	    exit 0;
	}
    }

    $self->{db_verified}=1;

    my @statements = ();
    for my $table (@TABLES){
	if($table eq 'couchdb_stats'){
	    push @statements, $self->{dbh}->prepare("insert into couchdb_stats(json_payload) values(?)");
	}else{
	    push @statements, $self->{dbh}->prepare("insert into $table(couch_stats_id, current, sum, mean, stddev, min, max) values(last_insert_rowid(),?,?,?,?,?,?)");
	}
    }
    $self->{statements}=\@statements;
   
}

1;


package main;

use utf8;
use strict;
use warnings;
use YAML::Tiny;
use Getopt::Long;
use Data::Dumper;
use 5.014;

my $CONF_FILE;

sub main{
    GetOptions('conf|configuration=s'=>\$CONF_FILE);
    
    if(!defined $CONF_FILE || !-e $CONF_FILE){
	say "Please provide a valid configuration file with -conf switch";
	exit 0;
    }
    my $yaml = YAML::Tiny->read($CONF_FILE);

    collect_stats($yaml->[0]);
}


sub collect_stats{
    my $options = shift;
    
    my $extractor = CouchMonitor::Stats::Extractor->new($options->{authentication}{user},$options->{authentication}{password},$options->{couch_db}{server},$options->{couch_db}{port}, $options->{monitor}{heartbeat});
    my $store = CouchMonitor::Database::Store::Sqlite->new('dbi:SQLite:dbname='.$options->{store}{file},"","", {RaiseError=>1, AutoCommit=>0});

    while(1){
	my $data = $extractor->extract_stats;

	if($data->[0]==200){
	    say "Inserting!";
	    $store->insert($data->[1]);
	}
	sleep $options->{monitor}{heartbeat};
    }
}

main;


1;
