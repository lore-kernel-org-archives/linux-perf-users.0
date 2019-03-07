From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/35] perf scripts python: export-to-postgresql.py: Fix invalid input syntax for integer error
Date: Thu,  7 Mar 2019 14:44:08 -0300
Message-ID: <20190307174433.28819-11-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fix SQL query error "invalid input syntax for integer":

  Traceback (most recent call last):
    File "tools/perf/scripts/python/export-to-postgresql.py", line 465, in <module>
      do_query(query, 'CREATE VIEW calls_view AS '
    File "tools/perf/scripts/python/export-to-postgresql.py", line 274, in do_query
      raise Exception("Query failed: " + q.lastError().text())
  Exception: Query failed: ERROR:  invalid input syntax for integer: ""
  LINE 1: ...ch_count,call_id,return_id,CASE WHEN flags=0 THEN '' WHEN fl...
                                                               ^
  (22P02) QPSQL: Unable to create query
  Error running python script tools/perf/scripts/python/export-to-postgresql.py

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: f08046cb3082 ("perf thread-stack: Represent jmps to the start of a different symbol")
Link: https://lkml.kernel.org/n/tip-strfpdozrvg7bi1xzrivxzqt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 30130213da7e..6358522a69f6 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -478,7 +478,7 @@ if perf_db_export_calls:
 			'branch_count,'
 			'call_id,'
 			'return_id,'
-			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
+			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE CAST ( flags AS VARCHAR(6) ) END AS flags,'
 			'parent_call_path_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
-- 
2.20.1
