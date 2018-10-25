From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/37] perf scripts python: exported-sql-viewer.py: Add ability to shrink / enlarge font
Date: Thu, 25 Oct 2018 08:10:24 -0300
Message-ID: <20181025111031.3440-31-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Shrinking the font allows more information to display.

Committer testing:

Works, tested with the convenient Control+Shift+'+' and Control+'-' as
well with the more cumbersome top menu "Edit" + "Enlarge/Shrink font"
options.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 0386a600ffc7..310ba7147583 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -706,6 +706,20 @@ class WindowMenu():
 	def setActiveSubWindow(self, nr):
 		self.mdi_area.setActiveSubWindow(self.mdi_area.subWindowList()[nr - 1])
 
+# Font resize
+
+def ResizeFont(widget, diff):
+	font = widget.font()
+	sz = font.pointSize()
+	font.setPointSize(sz + diff)
+	widget.setFont(font)
+
+def ShrinkFont(widget):
+	ResizeFont(widget, -1)
+
+def EnlargeFont(widget):
+	ResizeFont(widget, 1)
+
 # Unique name for sub-windows
 
 def NumberedWindowName(name, nr):
@@ -765,6 +779,8 @@ class MainWindow(QMainWindow):
 
 		edit_menu = menu.addMenu("&Edit")
 		edit_menu.addAction(CreateAction("&Find...", "Find items", self.Find, self, QKeySequence.Find))
+		edit_menu.addAction(CreateAction("&Shrink Font", "Make text smaller", self.ShrinkFont, self, [QKeySequence("Ctrl+-")]))
+		edit_menu.addAction(CreateAction("&Enlarge Font", "Make text bigger", self.EnlargeFont, self, [QKeySequence("Ctrl++")]))
 
 		reports_menu = menu.addMenu("&Reports")
 		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
@@ -779,6 +795,14 @@ class MainWindow(QMainWindow):
 			except:
 				pass
 
+	def ShrinkFont(self):
+		win = self.mdi_area.activeSubWindow()
+		ShrinkFont(win.view)
+
+	def EnlargeFont(self):
+		win = self.mdi_area.activeSubWindow()
+		EnlargeFont(win.view)
+
 	def NewCallGraph(self):
 		CallGraphWindow(self.glb, self)
 
-- 
2.14.4
