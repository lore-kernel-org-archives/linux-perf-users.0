From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/35] perf scripts python: exported-sql-viewer.py: Factor out CallGraphModelBase
Date: Thu,  7 Mar 2019 14:44:12 -0300
Message-ID: <20190307174433.28819-15-acme@kernel.org>
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

Factor out a base class CallGraphModelBase from CallGraphModel, so that
CallGraphModelBase can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-76eybebzjwvgnadkm2oufrqi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 100 ++++++++++--------
 1 file changed, 55 insertions(+), 45 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index b2a22525549d..c4a2134d85f5 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -558,26 +558,12 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 			self.child_items.append(child_item)
 			self.child_count += 1
 
-# Context-sensitive call graph data model
+# Context-sensitive call graph data model base
 
-class CallGraphModel(TreeModel):
+class CallGraphModelBase(TreeModel):
 
 	def __init__(self, glb, parent=None):
-		super(CallGraphModel, self).__init__(glb, parent)
-
-	def GetRoot(self):
-		return CallGraphRootItem(self.glb)
-
-	def columnCount(self, parent=None):
-		return 7
-
-	def columnHeader(self, column):
-		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
-		return headers[column]
-
-	def columnAlignment(self, column):
-		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
-		return alignment[column]
+		super(CallGraphModelBase, self).__init__(glb, parent)
 
 	def FindSelect(self, value, pattern, query):
 		if pattern:
@@ -597,34 +583,7 @@ class CallGraphModel(TreeModel):
 				match = " GLOB '" + str(value) + "'"
 		else:
 			match = " = '" + str(value) + "'"
-		QueryExec(query, "SELECT call_path_id, comm_id, thread_id"
-						" FROM calls"
-						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
-						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
-						" WHERE symbols.name" + match +
-						" GROUP BY comm_id, thread_id, call_path_id"
-						" ORDER BY comm_id, thread_id, call_path_id")
-
-	def FindPath(self, query):
-		# Turn the query result into a list of ids that the tree view can walk
-		# to open the tree at the right place.
-		ids = []
-		parent_id = query.value(0)
-		while parent_id:
-			ids.insert(0, parent_id)
-			q2 = QSqlQuery(self.glb.db)
-			QueryExec(q2, "SELECT parent_id"
-					" FROM call_paths"
-					" WHERE id = " + str(parent_id))
-			if not q2.next():
-				break
-			parent_id = q2.value(0)
-		# The call path root is not used
-		if ids[0] == 1:
-			del ids[0]
-		ids.insert(0, query.value(2))
-		ids.insert(0, query.value(1))
-		return ids
+		self.DoFindSelect(query, match)
 
 	def Found(self, query, found):
 		if found:
@@ -678,6 +637,57 @@ class CallGraphModel(TreeModel):
 	def FindDone(self, thread, callback, ids):
 		callback(ids)
 
+# Context-sensitive call graph data model
+
+class CallGraphModel(CallGraphModelBase):
+
+	def __init__(self, glb, parent=None):
+		super(CallGraphModel, self).__init__(glb, parent)
+
+	def GetRoot(self):
+		return CallGraphRootItem(self.glb)
+
+	def columnCount(self, parent=None):
+		return 7
+
+	def columnHeader(self, column):
+		headers = ["Call Path", "Object", "Count ", "Time (ns) ", "Time (%) ", "Branch Count ", "Branch Count (%) "]
+		return headers[column]
+
+	def columnAlignment(self, column):
+		alignment = [ Qt.AlignLeft, Qt.AlignLeft, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight, Qt.AlignRight ]
+		return alignment[column]
+
+	def DoFindSelect(self, query, match):
+		QueryExec(query, "SELECT call_path_id, comm_id, thread_id"
+						" FROM calls"
+						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
+						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
+						" WHERE symbols.name" + match +
+						" GROUP BY comm_id, thread_id, call_path_id"
+						" ORDER BY comm_id, thread_id, call_path_id")
+
+	def FindPath(self, query):
+		# Turn the query result into a list of ids that the tree view can walk
+		# to open the tree at the right place.
+		ids = []
+		parent_id = query.value(0)
+		while parent_id:
+			ids.insert(0, parent_id)
+			q2 = QSqlQuery(self.glb.db)
+			QueryExec(q2, "SELECT parent_id"
+					" FROM call_paths"
+					" WHERE id = " + str(parent_id))
+			if not q2.next():
+				break
+			parent_id = q2.value(0)
+		# The call path root is not used
+		if ids[0] == 1:
+			del ids[0]
+		ids.insert(0, query.value(2))
+		ids.insert(0, query.value(1))
+		return ids
+
 # Vertical widget layout
 
 class VBox():
-- 
2.20.1
