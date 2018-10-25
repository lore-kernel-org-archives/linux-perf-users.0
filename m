From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/37] perf scripts python: exported-sql-viewer.py: Add support for multiple sub-windows
Date: Thu, 25 Oct 2018 08:10:22 -0300
Message-ID: <20181025111031.3440-29-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Use Qt MDI (multiple document interface) to support multiple sub-windows.
Put the data model in a cache so that each sub-window can share the same
data. This allows mutiple views of the call-graph at the same time and
paves the way to add more reports.

Committer testing:

Starts with a "File  Reports  Windows" main menu, from the "Reports" I
can get what was available up to now, the "Context-Sensitivi Call Graph"
option.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 182 +++++++++++++++++++++--
 1 file changed, 173 insertions(+), 9 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 03e7a1de7f31..c2f44351821e 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -47,6 +47,8 @@
 #       functions that it calls
 
 import sys
+import weakref
+import threading
 from PySide.QtCore import *
 from PySide.QtGui import *
 from PySide.QtSql import *
@@ -138,6 +140,23 @@ class TreeModel(QAbstractItemModel):
 		item = index.internalPointer()
 		return self.DisplayData(item, index)
 
+# Model cache
+
+model_cache = weakref.WeakValueDictionary()
+model_cache_lock = threading.Lock()
+
+def LookupCreateModel(model_name, create_fn):
+	model_cache_lock.acquire()
+	try:
+		model = model_cache[model_name]
+	except:
+		model = None
+	if model is None:
+		model = create_fn()
+		model_cache[model_name] = model
+	model_cache_lock.release()
+	return model
+
 # Context-sensitive call graph data model item base
 
 class CallGraphLevelItemBase(object):
@@ -289,6 +308,144 @@ class CallGraphModel(TreeModel):
 		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
 		return alignment[column]
 
+# Context-sensitive call graph window
+
+class CallGraphWindow(QMdiSubWindow):
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
+		self.setWidget(self.view)
+
+		AddSubWindow(glb.mainwindow.mdi_area, self, "Context-Sensitive Call Graph")
+
+# Action Definition
+
+def CreateAction(label, tip, callback, parent=None, shortcut=None):
+	action = QAction(label, parent)
+	if shortcut != None:
+		action.setShortcuts(shortcut)
+	action.setStatusTip(tip)
+	action.triggered.connect(callback)
+	return action
+
+# Typical application actions
+
+def CreateExitAction(app, parent=None):
+	return CreateAction("&Quit", "Exit the application", app.closeAllWindows, parent, QKeySequence.Quit)
+
+# Typical MDI actions
+
+def CreateCloseActiveWindowAction(mdi_area):
+	return CreateAction("Cl&ose", "Close the active window", mdi_area.closeActiveSubWindow, mdi_area)
+
+def CreateCloseAllWindowsAction(mdi_area):
+	return CreateAction("Close &All", "Close all the windows", mdi_area.closeAllSubWindows, mdi_area)
+
+def CreateTileWindowsAction(mdi_area):
+	return CreateAction("&Tile", "Tile the windows", mdi_area.tileSubWindows, mdi_area)
+
+def CreateCascadeWindowsAction(mdi_area):
+	return CreateAction("&Cascade", "Cascade the windows", mdi_area.cascadeSubWindows, mdi_area)
+
+def CreateNextWindowAction(mdi_area):
+	return CreateAction("Ne&xt", "Move the focus to the next window", mdi_area.activateNextSubWindow, mdi_area, QKeySequence.NextChild)
+
+def CreatePreviousWindowAction(mdi_area):
+	return CreateAction("Pre&vious", "Move the focus to the previous window", mdi_area.activatePreviousSubWindow, mdi_area, QKeySequence.PreviousChild)
+
+# Typical MDI window menu
+
+class WindowMenu():
+
+	def __init__(self, mdi_area, menu):
+		self.mdi_area = mdi_area
+		self.window_menu = menu.addMenu("&Windows")
+		self.close_active_window = CreateCloseActiveWindowAction(mdi_area)
+		self.close_all_windows = CreateCloseAllWindowsAction(mdi_area)
+		self.tile_windows = CreateTileWindowsAction(mdi_area)
+		self.cascade_windows = CreateCascadeWindowsAction(mdi_area)
+		self.next_window = CreateNextWindowAction(mdi_area)
+		self.previous_window = CreatePreviousWindowAction(mdi_area)
+		self.window_menu.aboutToShow.connect(self.Update)
+
+	def Update(self):
+		self.window_menu.clear()
+		sub_window_count = len(self.mdi_area.subWindowList())
+		have_sub_windows = sub_window_count != 0
+		self.close_active_window.setEnabled(have_sub_windows)
+		self.close_all_windows.setEnabled(have_sub_windows)
+		self.tile_windows.setEnabled(have_sub_windows)
+		self.cascade_windows.setEnabled(have_sub_windows)
+		self.next_window.setEnabled(have_sub_windows)
+		self.previous_window.setEnabled(have_sub_windows)
+		self.window_menu.addAction(self.close_active_window)
+		self.window_menu.addAction(self.close_all_windows)
+		self.window_menu.addSeparator()
+		self.window_menu.addAction(self.tile_windows)
+		self.window_menu.addAction(self.cascade_windows)
+		self.window_menu.addSeparator()
+		self.window_menu.addAction(self.next_window)
+		self.window_menu.addAction(self.previous_window)
+		if sub_window_count == 0:
+			return
+		self.window_menu.addSeparator()
+		nr = 1
+		for sub_window in self.mdi_area.subWindowList():
+			label = str(nr) + " " + sub_window.name
+			if nr < 10:
+				label = "&" + label
+			action = self.window_menu.addAction(label)
+			action.setCheckable(True)
+			action.setChecked(sub_window == self.mdi_area.activeSubWindow())
+			action.triggered.connect(lambda x=nr: self.setActiveSubWindow(x))
+			self.window_menu.addAction(action)
+			nr += 1
+
+	def setActiveSubWindow(self, nr):
+		self.mdi_area.setActiveSubWindow(self.mdi_area.subWindowList()[nr - 1])
+
+# Unique name for sub-windows
+
+def NumberedWindowName(name, nr):
+	if nr > 1:
+		name += " <" + str(nr) + ">"
+	return name
+
+def UniqueSubWindowName(mdi_area, name):
+	nr = 1
+	while True:
+		unique_name = NumberedWindowName(name, nr)
+		ok = True
+		for sub_window in mdi_area.subWindowList():
+			if sub_window.name == unique_name:
+				ok = False
+				break
+		if ok:
+			return unique_name
+		nr += 1
+
+# Add a sub-window
+
+def AddSubWindow(mdi_area, sub_window, name):
+	unique_name = UniqueSubWindowName(mdi_area, name)
+	sub_window.setMinimumSize(200, 100)
+	sub_window.resize(800, 600)
+	sub_window.setWindowTitle(unique_name)
+	sub_window.setAttribute(Qt.WA_DeleteOnClose)
+	sub_window.setWindowIcon(sub_window.style().standardIcon(QStyle.SP_FileIcon))
+	sub_window.name = unique_name
+	mdi_area.addSubWindow(sub_window)
+	sub_window.show()
+
 # Main window
 
 class MainWindow(QMainWindow):
@@ -298,21 +455,28 @@ class MainWindow(QMainWindow):
 
 		self.glb = glb
 
-		self.setWindowTitle("Call Graph: " + glb.dbname)
-		self.move(100, 100)
-		self.resize(800, 600)
+		self.setWindowTitle("Exported SQL Viewer: " + glb.dbname)
 		self.setWindowIcon(self.style().standardIcon(QStyle.SP_ComputerIcon))
 		self.setMinimumSize(200, 100)
 
-		self.model = CallGraphModel(glb)
+		self.mdi_area = QMdiArea()
+		self.mdi_area.setHorizontalScrollBarPolicy(Qt.ScrollBarAsNeeded)
+		self.mdi_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
 
-		self.view = QTreeView()
-		self.view.setModel(self.model)
+		self.setCentralWidget(self.mdi_area)
 
-		for c, w in ((0, 250), (1, 100), (2, 60), (3, 70), (4, 70), (5, 100)):
-			self.view.setColumnWidth(c, w)
+		menu = self.menuBar()
+
+		file_menu = menu.addMenu("&File")
+		file_menu.addAction(CreateExitAction(glb.app, self))
+
+		reports_menu = menu.addMenu("&Reports")
+		reports_menu.addAction(CreateAction("Context-Sensitive Call &Graph", "Create a new window containing a context-sensitive call graph", self.NewCallGraph, self))
+
+		self.window_menu = WindowMenu(self.mdi_area, menu)
 
-		self.setCentralWidget(self.view)
+	def NewCallGraph(self):
+		CallGraphWindow(self.glb, self)
 
 # Global data
 
-- 
2.14.4
