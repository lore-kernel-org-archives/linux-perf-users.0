From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/69] perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
Date: Fri, 11 Oct 2019 17:05:03 -0300
Message-ID: <20191011200559.7156-14-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add ability for Call tree to open at a specified task and time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20190821083216.1340-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 06b8d55977bc..a5af52f422e6 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1094,7 +1094,7 @@ class CallGraphWindow(TreeWindowBase):
 
 class CallTreeWindow(TreeWindowBase):
 
-	def __init__(self, glb, parent=None):
+	def __init__(self, glb, parent=None, thread_at_time=None):
 		super(CallTreeWindow, self).__init__(parent)
 
 		self.model = LookupCreateModel("Call Tree", lambda x=glb: CallTreeModel(x))
@@ -1112,6 +1112,48 @@ class CallTreeWindow(TreeWindowBase):
 
 		AddSubWindow(glb.mainwindow.mdi_area, self, "Call Tree")
 
+		if thread_at_time:
+			self.DisplayThreadAtTime(*thread_at_time)
+
+	def DisplayThreadAtTime(self, comm_id, thread_id, time):
+		parent = QModelIndex()
+		for dbid in (comm_id, thread_id):
+			found = False
+			n = self.model.rowCount(parent)
+			for row in xrange(n):
+				child = self.model.index(row, 0, parent)
+				if child.internalPointer().dbid == dbid:
+					found = True
+					self.view.setCurrentIndex(child)
+					parent = child
+					break
+			if not found:
+				return
+		found = False
+		while True:
+			n = self.model.rowCount(parent)
+			if not n:
+				return
+			last_child = None
+			for row in xrange(n):
+				child = self.model.index(row, 0, parent)
+				child_call_time = child.internalPointer().call_time
+				if child_call_time < time:
+					last_child = child
+				elif child_call_time == time:
+					self.view.setCurrentIndex(child)
+					return
+				elif child_call_time > time:
+					break
+			if not last_child:
+				if not found:
+					child = self.model.index(0, 0, parent)
+					self.view.setCurrentIndex(child)
+				return
+			found = True
+			self.view.setCurrentIndex(last_child)
+			parent = last_child
+
 # Child data item  finder
 
 class ChildDataItemFinder():
-- 
2.21.0
