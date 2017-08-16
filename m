From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/10] perf scripts python: Fix query in call-graph-from-postgresql.py
Date: Wed, 16 Aug 2017 17:20:45 -0300
Message-ID: <20170816202050.8865-6-acme@kernel.org>
References: <20170816202050.8865-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816202050.8865-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add a missing space which seemed not to affect PostgreSQL but upsets
SQLite.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/1501749090-20357-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-postgresql.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/call-graph-from-postgresql.py b/tools/perf/scripts/python/call-graph-from-postgresql.py
index e78fdc2a5a9d..ed9f7f3ccf22 100644
--- a/tools/perf/scripts/python/call-graph-from-postgresql.py
+++ b/tools/perf/scripts/python/call-graph-from-postgresql.py
@@ -160,7 +160,7 @@ class TreeItem():
 				  '( SELECT short_name FROM dsos WHERE id = ( SELECT dso_id FROM symbols WHERE id = ( SELECT symbol_id FROM call_paths WHERE id = call_path_id ) ) ), '
 				  '( SELECT ip FROM call_paths where id = call_path_id ) '
 				  'FROM calls WHERE parent_call_path_id = ' + str(self.call_path_id) + ' AND comm_id = ' + str(self.comm_id) + ' AND thread_id = ' + str(self.thread_id) +
-				  'ORDER BY call_path_id')
+				  ' ORDER BY call_path_id')
 		if not ret:
 			raise Exception("Query failed: " + query.lastError().text())
 		last_call_path_id = 0
-- 
2.13.5
