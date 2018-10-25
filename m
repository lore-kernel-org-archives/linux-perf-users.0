From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/37] perf scripts python: call-graph-from-sql.py: Remove use of setObjectName()
Date: Thu, 25 Oct 2018 08:10:17 -0300
Message-ID: <20181025111031.3440-24-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The object name is never used, so don't bother setting it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 0a4dc13d4818..65c18e351bc4 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -269,7 +269,6 @@ class MainWindow(QMainWindow):
 
 		self.glb = glb
 
-		self.setObjectName("MainWindow")
 		self.setWindowTitle("Call Graph: " + glb.dbname)
 		self.move(100, 100)
 		self.resize(800, 600)
-- 
2.14.4
