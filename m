From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/37] perf scripts python: call-graph-from-sql.py: Set a minimum window size
Date: Thu, 25 Oct 2018 08:10:12 -0300
Message-ID: <20181025111031.3440-19-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Prevent weirdly small window size.

Committer testing:

Seems to work, but even before this patch, on my system, it always
started with:

xwininfo: Window id: 0x1e00002 "Call Graph: pt_example"
<SNIP>
  Width: 800
  Height: 600
<SNIP>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index e1014f2628a7..68153fa1b4d1 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -274,6 +274,7 @@ class MainWindow(QMainWindow):
 		style = self.style()
 		icon = style.standardIcon(QStyle.SP_MessageBoxInformation)
 		self.setWindowIcon(icon);
+		self.setMinimumSize(200, 100)
 
 		self.model = TreeModel(db)
 
-- 
2.14.4
