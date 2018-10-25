From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/37] perf scripts python: call-graph-from-sql.py: Change icon
Date: Thu, 25 Oct 2018 08:10:13 -0300
Message-ID: <20181025111031.3440-20-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

There are not many standard icons, but the computer icon looks slightly
better than the information icon.

Committer testing:

Noticed the change on the icon on the gnome menu right next to the
"Activities" menu, looks nicer indeed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 68153fa1b4d1..2e33540f3de0 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -271,9 +271,7 @@ class MainWindow(QMainWindow):
 		self.setWindowTitle("Call Graph: " + dbname)
 		self.move(100, 100)
 		self.resize(800, 600)
-		style = self.style()
-		icon = style.standardIcon(QStyle.SP_MessageBoxInformation)
-		self.setWindowIcon(icon);
+		self.setWindowIcon(self.style().standardIcon(QStyle.SP_ComputerIcon))
 		self.setMinimumSize(200, 100)
 
 		self.model = TreeModel(db)
-- 
2.14.4
