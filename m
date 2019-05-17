From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/73] perf scripts python: exported-sql-viewer.py: Move view creation
Date: Fri, 17 May 2019 16:35:11 -0300
Message-ID: <20190517193611.4974-14-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

As preparation for adding support for copying to clipboard, create view
in TreeWindowBase instead of derived classes.

Committer testing:

Tested using an old .db used to test some older patches:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db

Nothing breaks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 74ef92f1d19a..db4655168ab1 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -877,9 +877,10 @@ class TreeWindowBase(QMdiSubWindow):
 		super(TreeWindowBase, self).__init__(parent)
 
 		self.model = None
-		self.view = None
 		self.find_bar = None
 
+		self.view = QTreeView()
+
 	def DisplayFound(self, ids):
 		if not len(ids):
 			return False
@@ -921,7 +922,6 @@ class CallGraphWindow(TreeWindowBase):
 
 		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
 
-		self.view = QTreeView()
 		self.view.setModel(self.model)
 
 		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
@@ -944,7 +944,6 @@ class CallTreeWindow(TreeWindowBase):
 
 		self.model = LookupCreateModel("Call Tree", lambda x=glb: CallTreeModel(x))
 
-		self.view = QTreeView()
 		self.view.setModel(self.model)
 
 		for c, w in ((0, 230), (1, 100), (2, 100), (3, 70), (4, 70), (5, 100)):
-- 
2.20.1
