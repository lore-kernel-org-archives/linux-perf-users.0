From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/37] perf scripts python: exported-sql-viewer.py: Move column headers
Date: Mon, 25 Feb 2019 18:20:05 -0300
Message-ID: <20190225212035.24781-8-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Move column headers from SQLAutoTableModel into SQLTableModel so that
they can be used for other models based on SQLTableModel.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 58a95241ff70..7bd5263d3f39 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1821,12 +1821,13 @@ class SQLTableModel(TableModel):
 
 	progress = Signal(object)
 
-	def __init__(self, glb, sql, column_count, parent=None):
+	def __init__(self, glb, sql, column_headers, parent=None):
 		super(SQLTableModel, self).__init__(parent)
 		self.glb = glb
 		self.more = True
 		self.populated = 0
-		self.fetcher = SQLFetcher(glb, sql, lambda x, y=column_count: SQLTableDataPrep(x, y), self.AddSample)
+		self.column_headers = column_headers
+		self.fetcher = SQLFetcher(glb, sql, lambda x, y=len(column_headers): SQLTableDataPrep(x, y), self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
@@ -1864,6 +1865,12 @@ class SQLTableModel(TableModel):
 	def HasMoreRecords(self):
 		return self.more
 
+	def columnCount(self, parent=None):
+		return len(self.column_headers)
+
+	def columnHeader(self, column):
+		return self.column_headers[column]
+
 # SQL automatic table data model
 
 class SQLAutoTableModel(SQLTableModel):
@@ -1873,12 +1880,12 @@ class SQLAutoTableModel(SQLTableModel):
 		if table_name == "comm_threads_view":
 			# For now, comm_threads_view has no id column
 			sql = "SELECT * FROM " + table_name + " WHERE comm_id > $$last_id$$ ORDER BY comm_id LIMIT " + str(glb_chunk_sz)
-		self.column_headers = []
+		column_headers = []
 		query = QSqlQuery(glb.db)
 		if glb.dbref.is_sqlite3:
 			QueryExec(query, "PRAGMA table_info(" + table_name + ")")
 			while query.next():
-				self.column_headers.append(query.value(1))
+				column_headers.append(query.value(1))
 			if table_name == "sqlite_master":
 				sql = "SELECT * FROM " + table_name
 		else:
@@ -1891,14 +1898,8 @@ class SQLAutoTableModel(SQLTableModel):
 				schema = "public"
 			QueryExec(query, "SELECT column_name FROM information_schema.columns WHERE table_schema = '" + schema + "' and table_name = '" + select_table_name + "'")
 			while query.next():
-				self.column_headers.append(query.value(0))
-		super(SQLAutoTableModel, self).__init__(glb, sql, len(self.column_headers), parent)
-
-	def columnCount(self, parent=None):
-		return len(self.column_headers)
-
-	def columnHeader(self, column):
-		return self.column_headers[column]
+				column_headers.append(query.value(0))
+		super(SQLAutoTableModel, self).__init__(glb, sql, column_headers, parent)
 
 # Base class for custom ResizeColumnsToContents
 
-- 
2.20.1
