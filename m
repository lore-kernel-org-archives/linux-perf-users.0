From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v2 6/7] perf script python: add Python3 support to sql
 scripts
Date: Fri, 8 Mar 2019 11:36:59 -0300
Message-ID: <20190308143659.GA19877@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-7-tonyj@suse.de>
 <7353b42e-ea14-e044-adfe-5a9705bf030c@intel.com>
 <72ea2e3d-1b82-549e-741f-d2b532e4c33b@suse.de>
 <20190307185142.GA32240@kernel.org>
 <f4c9445f-d992-60d8-fab7-67e0eea4416c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f4c9445f-d992-60d8-fab7-67e0eea4416c@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 08, 2019 at 11:47:55AM +0200, Adrian Hunter escreveu:
> On 7/03/19 8:51 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 06, 2019 at 08:32:42AM -0800, Tony Jones escreveu:
> >> On 3/6/19 1:26 AM, Adrian Hunter wrote:
> >>> On 2/03/19 3:19 AM, Tony Jones wrote:
> >>>> Support both Python2 and Python3 in the exported-sql-viewer.py,
> >>>> export-to-postgresql.py and export-to-sqlite.py scripts
> >>>>
> >>>> There may be differences in the ordering of output lines due to
> >>>> differences in dictionary ordering etc.  However the format within lines
> >>>> should be unchanged.
> >>>>
> >>>> The use of 'from __future__' implies the minimum supported Python2 version
> >>>> is now v2.6
> >>>>
> >>>> Signed-off-by: Tony Jones <tonyj@suse.de>
> >>>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> >>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
> >>>
> >>> Apart from one issue (see below), it looks good, thank you!
> >>>
> >>>> ---
> >>>>  tools/perf/scripts/python/export-to-postgresql.py | 65 +++++++++++++++--------
> >>>>  tools/perf/scripts/python/export-to-sqlite.py     | 23 ++++----
> >>>>  tools/perf/scripts/python/exported-sql-viewer.py  | 42 ++++++++++-----
> >>>>  3 files changed, 84 insertions(+), 46 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
> >>>> index 390a351d15ea..439bbbf1e036 100644
> >>>> --- a/tools/perf/scripts/python/export-to-postgresql.py
> >>>> +++ b/tools/perf/scripts/python/export-to-postgresql.py
> >>>> @@ -10,6 +10,8 @@
> >>>>  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> >>>>  # more details.
> >>>>  
> >>>> +from __future__ import print_function
> >>>> +
> >>>>  import os
> >>>>  import sys
> >>>>  import struct
> >>>> @@ -199,6 +201,16 @@ import datetime
> >>>>  
> >>>>  from PySide.QtSql import *
> >>>>  
> >>>> +if sys.version_info < (3, 0):
> >>>> +	def tobytes(str):
> >>>> +		return str
> >>>> +else:
> >>>> +	def tobytes(str):
> >>>> +		# Use latin-1 (ISO-8859-1) so all code-points 0-255 will result
> >>>> +		# in one byte (note utf-8 is 2 bytes for values > 128 and
> >>>> +		# ascii is limited to values <= 128)
> >>>> +		return bytes(str, "ISO-8859-1")
> >>>
> >>> Probably this should be the server_encoding, but python2 allowed UTF-8
> >>> so let's just use UTF-8 for now.  That will also mean doing the conversion
> >>> before getting the len(), otherwise len() can be wrong.
> >>
> >> I'm not totally understanding what you're saying here.  The rationale for 
> >> using latin-1 and not UTF-8 was clearly expressed in the comment.  Else you 
> >> do indeed run into length issues.
> >>
> >> Would it be easier, since you have a) more familiarity with the code b) some
> >> specific issues I'm not fully understanding if you just took this patch and
> >> made the changes you want yourself.  I doubt I'll ever use these scripta, my
> >> interest is purely in eliminating Python2 as a fixed requirement.
> > 
> > Adrian, can you please reply here? I'm not familiar with this tobytes()
> > python2/python3 difference, what do you mean about using
> > 'server_encoding'? Where is that defined?
> 
> Under python 2 the character set was not changed, so UTF-8, for example,
> would pass through unmodified.
> 
> Under python 3, the perf strings are converted to unicode because that
> is what python 3 uses for strings.
> 
> So under python 3, the correct character set must be used when converting
> back to a character encoding that postgrsql expects.
> 
> client_encoding is a postgresql connection parameter.
> 
> server_encoding is a postgresql database parameter.
> 
> To keep things simple for now, I would prefer to hard code UTF-8 rather
> than ISO-8859-1 because I think it is more future-proof.  UTF-8 is a
> superset of ISO-8859-1 but can have multi-byte characters, so the
> conversion must be performed before calculating the output string length.
> 
> Ideally, the script would ask/tell the client or server what character
> encoding to use, but hard coding will do for now.
> 
> 
> This is what I would like:

Tony, can you check this one so that I may process it? Would be nice to
fold Adrian's comments above into the end result, ok?

Thanks,

- Arnaldo
 
> 
> diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
> index 390a351d15ea..00ab972a2eba 100644
> --- a/tools/perf/scripts/python/export-to-postgresql.py
> +++ b/tools/perf/scripts/python/export-to-postgresql.py
> @@ -10,6 +10,8 @@
>  # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>  # more details.
>  
> +from __future__ import print_function
> +
>  import os
>  import sys
>  import struct
> @@ -199,6 +201,18 @@ import datetime
>  
>  from PySide.QtSql import *
>  
> +if sys.version_info < (3, 0):
> +	def toserverstr(str):
> +		return str
> +	def toclientstr(str):
> +		return str
> +else:
> +	# Assume UTF-8 server_encoding and client_encoding
> +	def toserverstr(str):
> +		return bytes(str, "UTF_8")
> +	def toclientstr(str):
> +		return bytes(str, "UTF_8")
> +
>  # Need to access PostgreSQL C library directly to use COPY FROM STDIN
>  from ctypes import *
>  libpq = CDLL("libpq.so.5")
> @@ -234,12 +248,14 @@ perf_db_export_mode = True
>  perf_db_export_calls = False
>  perf_db_export_callchains = False
>  
> +def printerr(*args, **kw_args):
> +	print(*args, file=sys.stderr, **kw_args)
>  
>  def usage():
> -	print >> sys.stderr, "Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]"
> -	print >> sys.stderr, "where:	columns		'all' or 'branches'"
> -	print >> sys.stderr, "		calls		'calls' => create calls and call_paths table"
> -	print >> sys.stderr, "		callchains	'callchains' => create call_paths table"
> +	printerr("Usage is: export-to-postgresql.py <database name> [<columns>] [<calls>] [<callchains>]")
> +	printerr("where:	columns		'all' or 'branches'")
> +	printerr("		calls		'calls' => create calls and call_paths table")
> +	printerr("		callchains	'callchains' => create call_paths table")
>  	raise Exception("Too few arguments")
>  
>  if (len(sys.argv) < 2):
> @@ -273,7 +289,7 @@ def do_query(q, s):
>  		return
>  	raise Exception("Query failed: " + q.lastError().text())
>  
> -print datetime.datetime.today(), "Creating database..."
> +print(datetime.datetime.today(), "Creating database...")
>  
>  db = QSqlDatabase.addDatabase('QPSQL')
>  query = QSqlQuery(db)
> @@ -506,12 +522,12 @@ do_query(query, 'CREATE VIEW samples_view AS '
>  	' FROM samples')
>  
>  
> -file_header = struct.pack("!11sii", "PGCOPY\n\377\r\n\0", 0, 0)
> -file_trailer = "\377\377"
> +file_header = struct.pack("!11sii", b"PGCOPY\n\377\r\n\0", 0, 0)
> +file_trailer = b"\377\377"
>  
>  def open_output_file(file_name):
>  	path_name = output_dir_name + "/" + file_name
> -	file = open(path_name, "w+")
> +	file = open(path_name, "wb+")
>  	file.write(file_header)
>  	return file
>  
> @@ -526,13 +542,13 @@ def copy_output_file_direct(file, table_name):
>  
>  # Use COPY FROM STDIN because security may prevent postgres from accessing the files directly
>  def copy_output_file(file, table_name):
> -	conn = PQconnectdb("dbname = " + dbname)
> +	conn = PQconnectdb(toclientstr("dbname = " + dbname))
>  	if (PQstatus(conn)):
>  		raise Exception("COPY FROM STDIN PQconnectdb failed")
>  	file.write(file_trailer)
>  	file.seek(0)
>  	sql = "COPY " + table_name + " FROM STDIN (FORMAT 'binary')"
> -	res = PQexec(conn, sql)
> +	res = PQexec(conn, toclientstr(sql))
>  	if (PQresultStatus(res) != 4):
>  		raise Exception("COPY FROM STDIN PQexec failed")
>  	data = file.read(65536)
> @@ -566,7 +582,7 @@ if perf_db_export_calls:
>  	call_file		= open_output_file("call_table.bin")
>  
>  def trace_begin():
> -	print datetime.datetime.today(), "Writing to intermediate files..."
> +	print(datetime.datetime.today(), "Writing to intermediate files...")
>  	# id == 0 means unknown.  It is easier to create records for them than replace the zeroes with NULLs
>  	evsel_table(0, "unknown")
>  	machine_table(0, 0, "unknown")
> @@ -582,7 +598,7 @@ def trace_begin():
>  unhandled_count = 0
>  
>  def trace_end():
> -	print datetime.datetime.today(), "Copying to database..."
> +	print(datetime.datetime.today(), "Copying to database...")
>  	copy_output_file(evsel_file,		"selected_events")
>  	copy_output_file(machine_file,		"machines")
>  	copy_output_file(thread_file,		"threads")
> @@ -597,7 +613,7 @@ def trace_end():
>  	if perf_db_export_calls:
>  		copy_output_file(call_file,		"calls")
>  
> -	print datetime.datetime.today(), "Removing intermediate files..."
> +	print(datetime.datetime.today(), "Removing intermediate files...")
>  	remove_output_file(evsel_file)
>  	remove_output_file(machine_file)
>  	remove_output_file(thread_file)
> @@ -612,7 +628,7 @@ def trace_end():
>  	if perf_db_export_calls:
>  		remove_output_file(call_file)
>  	os.rmdir(output_dir_name)
> -	print datetime.datetime.today(), "Adding primary keys"
> +	print(datetime.datetime.today(), "Adding primary keys")
>  	do_query(query, 'ALTER TABLE selected_events ADD PRIMARY KEY (id)')
>  	do_query(query, 'ALTER TABLE machines        ADD PRIMARY KEY (id)')
>  	do_query(query, 'ALTER TABLE threads         ADD PRIMARY KEY (id)')
> @@ -627,7 +643,7 @@ def trace_end():
>  	if perf_db_export_calls:
>  		do_query(query, 'ALTER TABLE calls           ADD PRIMARY KEY (id)')
>  
> -	print datetime.datetime.today(), "Adding foreign keys"
> +	print(datetime.datetime.today(), "Adding foreign keys")
>  	do_query(query, 'ALTER TABLE threads '
>  					'ADD CONSTRAINT machinefk  FOREIGN KEY (machine_id)   REFERENCES machines   (id),'
>  					'ADD CONSTRAINT processfk  FOREIGN KEY (process_id)   REFERENCES threads    (id)')
> @@ -663,8 +679,8 @@ def trace_end():
>  		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
>  
>  	if (unhandled_count):
> -		print datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events"
> -	print datetime.datetime.today(), "Done"
> +		print(datetime.datetime.today(), "Warning: ", unhandled_count, " unhandled events")
> +	print(datetime.datetime.today(), "Done")
>  
>  def trace_unhandled(event_name, context, event_fields_dict):
>  	global unhandled_count
> @@ -674,12 +690,14 @@ def sched__sched_switch(*x):
>  	pass
>  
>  def evsel_table(evsel_id, evsel_name, *x):
> +	evsel_name = toserverstr(evsel_name)
>  	n = len(evsel_name)
>  	fmt = "!hiqi" + str(n) + "s"
>  	value = struct.pack(fmt, 2, 8, evsel_id, n, evsel_name)
>  	evsel_file.write(value)
>  
>  def machine_table(machine_id, pid, root_dir, *x):
> +	root_dir = toserverstr(root_dir)
>  	n = len(root_dir)
>  	fmt = "!hiqiii" + str(n) + "s"
>  	value = struct.pack(fmt, 3, 8, machine_id, 4, pid, n, root_dir)
> @@ -690,6 +708,7 @@ def thread_table(thread_id, machine_id, process_id, pid, tid, *x):
>  	thread_file.write(value)
>  
>  def comm_table(comm_id, comm_str, *x):
> +	comm_str = toserverstr(comm_str)
>  	n = len(comm_str)
>  	fmt = "!hiqi" + str(n) + "s"
>  	value = struct.pack(fmt, 2, 8, comm_id, n, comm_str)
> @@ -701,6 +720,9 @@ def comm_thread_table(comm_thread_id, comm_id, thread_id, *x):
>  	comm_thread_file.write(value)
>  
>  def dso_table(dso_id, machine_id, short_name, long_name, build_id, *x):
> +	short_name = toserverstr(short_name)
> +	long_name = toserverstr(long_name)
> +	build_id = toserverstr(build_id)
>  	n1 = len(short_name)
>  	n2 = len(long_name)
>  	n3 = len(build_id)
> @@ -709,12 +731,14 @@ def dso_table(dso_id, machine_id, short_name, long_name, build_id, *x):
>  	dso_file.write(value)
>  
>  def symbol_table(symbol_id, dso_id, sym_start, sym_end, binding, symbol_name, *x):
> +	symbol_name = toserverstr(symbol_name)
>  	n = len(symbol_name)
>  	fmt = "!hiqiqiqiqiii" + str(n) + "s"
>  	value = struct.pack(fmt, 6, 8, symbol_id, 8, dso_id, 8, sym_start, 8, sym_end, 4, binding, n, symbol_name)
>  	symbol_file.write(value)
>  
>  def branch_type_table(branch_type, name, *x):
> +	name = toserverstr(name)
>  	n = len(name)
>  	fmt = "!hiii" + str(n) + "s"
>  	value = struct.pack(fmt, 2, 4, branch_type, n, name)

-- 

- Arnaldo
