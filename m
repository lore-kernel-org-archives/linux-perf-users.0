From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/13] perf scripts python: exported-sql-viewer.py: Fix never-ending loop
Date: Fri, 29 Mar 2019 10:37:59 -0300
Message-ID: <20190329133801.21004-12-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

pyside version 1 fails to handle python3 large integers in some cases,
resulting in Qt getting into a never-ending loop. This affects:
	samples Table
	samples_view Table
	All branches Report
	Selected branches Report

Add workarounds for those cases.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: beda0e725e5f ("perf script python: Add Python3 support to exported-sql-viewer.py")
Link: http://lkml.kernel.org/r/20190327072826.19168-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 60 +++++++++++++++----
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index e38518cdcbc3..0cf30956064a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -107,6 +107,7 @@ import os
 from PySide.QtCore import *
 from PySide.QtGui import *
 from PySide.QtSql import *
+pyside_version_1 = True
 from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
@@ -1526,6 +1527,19 @@ def BranchDataPrep(query):
 			" (" + dsoname(query.value(15)) + ")")
 	return data
 
+def BranchDataPrepWA(query):
+	data = []
+	data.append(query.value(0))
+	# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+	data.append("{:>19}".format(query.value(1)))
+	for i in xrange(2, 8):
+		data.append(query.value(i))
+	data.append(tohex(query.value(8)).rjust(16) + " " + query.value(9) + offstr(query.value(10)) +
+			" (" + dsoname(query.value(11)) + ")" + " -> " +
+			tohex(query.value(12)) + " " + query.value(13) + offstr(query.value(14)) +
+			" (" + dsoname(query.value(15)) + ")")
+	return data
+
 # Branch data model
 
 class BranchModel(TreeModel):
@@ -1553,7 +1567,11 @@ class BranchModel(TreeModel):
 			" AND evsel_id = " + str(self.event_id) +
 			" ORDER BY samples.id"
 			" LIMIT " + str(glb_chunk_sz))
-		self.fetcher = SQLFetcher(glb, sql, BranchDataPrep, self.AddSample)
+		if pyside_version_1 and sys.version_info[0] == 3:
+			prep = BranchDataPrepWA
+		else:
+			prep = BranchDataPrep
+		self.fetcher = SQLFetcher(glb, sql, prep, self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
@@ -2079,14 +2097,6 @@ def IsSelectable(db, table, sql = ""):
 		return False
 	return True
 
-# SQL data preparation
-
-def SQLTableDataPrep(query, count):
-	data = []
-	for i in xrange(count):
-		data.append(query.value(i))
-	return data
-
 # SQL table data model item
 
 class SQLTableItem():
@@ -2110,7 +2120,7 @@ class SQLTableModel(TableModel):
 		self.more = True
 		self.populated = 0
 		self.column_headers = column_headers
-		self.fetcher = SQLFetcher(glb, sql, lambda x, y=len(column_headers): SQLTableDataPrep(x, y), self.AddSample)
+		self.fetcher = SQLFetcher(glb, sql, lambda x, y=len(column_headers): self.SQLTableDataPrep(x, y), self.AddSample)
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
@@ -2154,6 +2164,12 @@ class SQLTableModel(TableModel):
 	def columnHeader(self, column):
 		return self.column_headers[column]
 
+	def SQLTableDataPrep(self, query, count):
+		data = []
+		for i in xrange(count):
+			data.append(query.value(i))
+		return data
+
 # SQL automatic table data model
 
 class SQLAutoTableModel(SQLTableModel):
@@ -2182,8 +2198,32 @@ class SQLAutoTableModel(SQLTableModel):
 			QueryExec(query, "SELECT column_name FROM information_schema.columns WHERE table_schema = '" + schema + "' and table_name = '" + select_table_name + "'")
 			while query.next():
 				column_headers.append(query.value(0))
+		if pyside_version_1 and sys.version_info[0] == 3:
+			if table_name == "samples_view":
+				self.SQLTableDataPrep = self.samples_view_DataPrep
+			if table_name == "samples":
+				self.SQLTableDataPrep = self.samples_DataPrep
 		super(SQLAutoTableModel, self).__init__(glb, sql, column_headers, parent)
 
+	def samples_view_DataPrep(self, query, count):
+		data = []
+		data.append(query.value(0))
+		# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+		data.append("{:>19}".format(query.value(1)))
+		for i in xrange(2, count):
+			data.append(query.value(i))
+		return data
+
+	def samples_DataPrep(self, query, count):
+		data = []
+		for i in xrange(9):
+			data.append(query.value(i))
+		# Workaround pyside failing to handle large integers (i.e. time) in python3 by converting to a string
+		data.append("{:>19}".format(query.value(9)))
+		for i in xrange(10, count):
+			data.append(query.value(i))
+		return data
+
 # Base class for custom ResizeColumnsToContents
 
 class ResizeColumnsToContentsBase(QObject):
-- 
2.20.1
