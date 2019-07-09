From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/25] perf scripts python: export-to-postgresql.py: Fix DROP VIEW power_events_view
Date: Tue,  9 Jul 2019 15:31:22 -0300
Message-ID: <20190709183126.30257-22-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

PostgreSQL can error if power_events_view is not dropped before its
dependent tables e.g.

  Exception: Query failed: ERROR:  cannot drop table mwait because other
  objects depend on it
  DETAIL:  view power_events_view depends on table mwait

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: aba44287a224 ("perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events")
Link: http://lkml.kernel.org/r/20190708055232.5032-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-postgresql.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-postgresql.py b/tools/perf/scripts/python/export-to-postgresql.py
index 4447f0d7c754..92713d93e956 100644
--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -898,11 +898,11 @@ def trace_end():
 	if is_table_empty("ptwrite"):
 		drop("ptwrite")
 	if is_table_empty("mwait") and is_table_empty("pwre") and is_table_empty("exstop") and is_table_empty("pwrx"):
+		do_query(query, 'DROP VIEW power_events_view');
 		drop("mwait")
 		drop("pwre")
 		drop("exstop")
 		drop("pwrx")
-		do_query(query, 'DROP VIEW power_events_view');
 		if is_table_empty("cbr"):
 			drop("cbr")
 
-- 
2.21.0
