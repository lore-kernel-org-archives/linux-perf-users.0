From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/28] perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column
Date: Mon, 15 Jul 2019 18:11:51 -0300
Message-ID: <20190715211200.10984-20-acme@kernel.org>
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

If the new 'has_calls' column is present, use it with the call graph and
call tree to select only comms that have calls.

Committer testing:

Just started the exported-sql-view.py and accessed all the reports, no
backtraces.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-17-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index dbbd7a5d9b60..61b3911d91e6 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -623,8 +623,11 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 		super(CallGraphRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
 		self.query_done = True
+		if_has_calls = ""
+		if IsSelectable(glb.db, "comms", columns = "has_calls"):
+			if_has_calls = " WHERE has_calls = TRUE"
 		query = QSqlQuery(glb.db)
-		QueryExec(query, "SELECT id, comm FROM comms")
+		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
 			if not query.value(0):
 				continue
@@ -900,8 +903,11 @@ class CallTreeRootItem(CallGraphLevelItemBase):
 		super(CallTreeRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
 		self.query_done = True
+		if_has_calls = ""
+		if IsSelectable(glb.db, "comms", columns = "has_calls"):
+			if_has_calls = " WHERE has_calls = TRUE"
 		query = QSqlQuery(glb.db)
-		QueryExec(query, "SELECT id, comm FROM comms")
+		QueryExec(query, "SELECT id, comm FROM comms" + if_has_calls)
 		while query.next():
 			if not query.value(0):
 				continue
-- 
2.21.0
