From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/7] perf scripts python: export-to-sqlite.py: Fix use of parent_id in calls_view
Date: Fri, 12 Apr 2019 11:22:47 -0300
Message-ID: <20190412142250.20595-5-acme@kernel.org>
References: <20190412142250.20595-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412142250.20595-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fix following error using calls_view:

 Query failed: ambiguous column name: parent_id Unable to execute statement

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: 8ce9a7251d11 ("perf scripts python: export-to-sqlite.py: Export calls parent_id")
Link: http://lkml.kernel.org/r/20190409062557.26138-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index 3b71902a5a21..bf271fbc3a88 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -331,7 +331,7 @@ if perf_db_export_calls:
 			'return_id,'
 			'CASE WHEN flags=0 THEN \'\' WHEN flags=1 THEN \'no call\' WHEN flags=2 THEN \'no return\' WHEN flags=3 THEN \'no call/return\' WHEN flags=6 THEN \'jump\' ELSE flags END AS flags,'
 			'parent_call_path_id,'
-			'parent_id'
+			'calls.parent_id'
 		' FROM calls INNER JOIN call_paths ON call_paths.id = call_path_id')
 
 do_query(query, 'CREATE VIEW samples_view AS '
-- 
2.20.1
