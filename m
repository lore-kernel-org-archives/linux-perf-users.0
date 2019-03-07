From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/35] perf scripts python: exported-sql-viewer.py: Factor out TreeWindowBase
Date: Thu,  7 Mar 2019 14:44:10 -0300
Message-ID: <20190307174433.28819-13-acme@kernel.org>
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

Factor out a base class TreeWindowBase from CallGraphWindow, so that
TreeWindowBase can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-ifirw0c0mhkwxg6l12lk6k4p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 50 ++++++++++++-------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 09ce73b07d35..df854f0a69f0 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -693,28 +693,16 @@ class VBox():
 	def Widget(self):
 		return self.vbox
 
-# Context-sensitive call graph window
-
-class CallGraphWindow(QMdiSubWindow):
-
-	def __init__(self, glb, parent=None):
-		super(CallGraphWindow, self).__init__(parent)
+# Tree window base
 
-		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
+class TreeWindowBase(QMdiSubWindow):
 
-		self.view = QTreeView()
-		self.view.setModel(self.model)
-
-		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
-			self.view.setColumnWidth(c, w)
-
-		self.find_bar = FindBar(self, self)
-
-		self.vbox = VBox(self.view, self.find_bar.Widget())
-
-		self.setWidget(self.vbox.Widget())
+	def __init__(self, parent=None):
+		super(TreeWindowBase, self).__init__(parent)
 
-		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
+		self.model = None
+		self.view = None
+		self.find_bar = None
 
 	def DisplayFound(self, ids):
 		if not len(ids):
@@ -747,6 +735,30 @@ class CallGraphWindow(QMdiSubWindow):
 		if not found:
 			self.find_bar.NotFound()
 
+
+# Context-sensitive call graph window
+
+class CallGraphWindow(TreeWindowBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallGraphWindow, self).__init__(parent)
+
+		self.model = LookupCreateModel("Context-Sensitive Call Graph", lambda x=glb: CallGraphModel(x))
+
+		self.view = QTreeView()
+		self.view.setModel(self.model)
+
+		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
+			self.view.setColumnWidth(c, w)
+
+		self.find_bar = FindBar(self, self)
+
+		self.vbox = VBox(self.view, self.find_bar.Widget())
+
+		self.setWidget(self.vbox.Widget())
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
+
 # Child data item  finder
 
 class ChildDataItemFinder():
-- 
2.20.1
