From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/28] perf scripts python: export-to-postgresql.py: Add has_calls column to comms table
Date: Mon, 15 Jul 2019 18:11:49 -0300
Message-ID: <20190715211200.10984-18-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Now that a thread's current comm is exported, it shows up in the call graph
and call tree even if it has no calls. That can happen because the calls
are recorded against the main thread's initial comm.

Add a table column to make it easy for the exported-sql-viewer.py script to
select only comms with calls.

Committer testing:

  $ rm -f simple-retpoline.db
  $ sudo ~acme/bin/perf script -i simple-retpoline.perf.data --itrace=be -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py simple-retpoline.db branches calls
  2019-07-10 12:25:33.200529 Creating database ...
  2019-07-10 12:25:33.211548 Writing records...
  2019-07-10 12:25:33.549630 Adding indexes
  2019-07-10 12:25:33.560715 Dropping unused tables
  2019-07-10 12:25:33.580201 Done
  $ sha256sum tools/perf/scripts/python/export-to-sqlite.py ~/libexec/perf-core/scripts/python/export-to-sqlite.py
  2922b642c392004dffa1d8789296478c85904623f5895bcb9b6cbf33e3ca999f  tools/perf/scripts/python/export-to-sqlite.py
  2922b642c392004dffa1d8789296478c85904623f5895bcb9b6cbf33e3ca999f  /home/acme/libexec/perf-core/scripts/python/export-to-sqlite.py
  $
  $ sqlite3 simple-retpoline.db
  SQLite version 3.26.0 2018-12-01 12:34:55
  Enter ".help" for usage hints.
  sqlite> .schema comms
  CREATE TABLE comms (id integer NOT NULL PRIMARY KEY,comm varchar(16),c_thread_id bigint,c_time bigint,exec_flag boolean, has_calls boolean);
  sqlite> select id,has_calls from comms;
  0|1
  1|1
  sqlite> select distinct comm_id from calls;
  0
  1
  sqlite>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 01f37877f5bb..13205e4e5b3b 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -886,6 +886,8 @@ def trace_end():
 					'ADD CONSTRAINT parent_call_pathfk FOREIGN KEY (parent_call_path_id) REFERENCES call_paths (id)')
 		do_query(query, 'CREATE INDEX pcpid_idx ON calls (parent_call_path_id)')
 		do_query(query, 'CREATE INDEX pid_idx ON calls (parent_id)')
+		do_query(query, 'ALTER TABLE comms ADD has_calls boolean')
+		do_query(query, 'UPDATE comms SET has_calls = TRUE WHERE comms.id IN (SELECT DISTINCT comm_id FROM calls)')
 	do_query(query, 'ALTER TABLE ptwrite '
 					'ADD CONSTRAINT idfk        FOREIGN KEY (id)           REFERENCES samples   (id)')
 	do_query(query, 'ALTER TABLE  cbr '
-- 
2.21.0
