From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/28] perf scripts python: exported-sql-viewer.py: Remove redundant semi-colons
Date: Mon, 15 Jul 2019 18:11:50 -0300
Message-ID: <20190715211200.10984-19-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Remove redundant semi-colons added inadvertently.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 6e7934f2ac9a..dbbd7a5d9b60 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -392,7 +392,7 @@ class FindBar():
 		self.hbox.addWidget(self.close_button)
 
 		self.bar = QWidget()
-		self.bar.setLayout(self.hbox);
+		self.bar.setLayout(self.hbox)
 		self.bar.hide()
 
 	def Widget(self):
@@ -470,7 +470,7 @@ class CallGraphLevelItemBase(object):
 		self.params = params
 		self.row = row
 		self.parent_item = parent_item
-		self.query_done = False;
+		self.query_done = False
 		self.child_count = 0
 		self.child_items = []
 		if parent_item:
@@ -517,7 +517,7 @@ class CallGraphLevelTwoPlusItemBase(CallGraphLevelItemBase):
 		self.time = time
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(self.glb.db)
 		if self.params.have_ipc:
 			ipc_str = ", SUM(insn_count), SUM(cyc_count)"
@@ -604,7 +604,7 @@ class CallGraphLevelOneItem(CallGraphLevelItemBase):
 		self.dbid = comm_id
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(self.glb.db)
 		QueryExec(query, "SELECT thread_id, pid, tid"
 					" FROM comm_threads"
@@ -622,7 +622,7 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 	def __init__(self, glb, params):
 		super(CallGraphRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(glb.db)
 		QueryExec(query, "SELECT id, comm FROM comms")
 		while query.next():
@@ -793,7 +793,7 @@ class CallTreeLevelTwoPlusItemBase(CallGraphLevelItemBase):
 		self.time = time
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		if self.calls_id == 0:
 			comm_thread = " AND comm_id = " + str(self.comm_id) + " AND thread_id = " + str(self.thread_id)
 		else:
@@ -881,7 +881,7 @@ class CallTreeLevelOneItem(CallGraphLevelItemBase):
 		self.dbid = comm_id
 
 	def Select(self):
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(self.glb.db)
 		QueryExec(query, "SELECT thread_id, pid, tid"
 					" FROM comm_threads"
@@ -899,7 +899,7 @@ class CallTreeRootItem(CallGraphLevelItemBase):
 	def __init__(self, glb, params):
 		super(CallTreeRootItem, self).__init__(glb, params, 0, None)
 		self.dbid = 0
-		self.query_done = True;
+		self.query_done = True
 		query = QSqlQuery(glb.db)
 		QueryExec(query, "SELECT id, comm FROM comms")
 		while query.next():
@@ -971,7 +971,7 @@ class VBox():
 
 	def __init__(self, w1, w2, w3=None):
 		self.vbox = QWidget()
-		self.vbox.setLayout(QVBoxLayout());
+		self.vbox.setLayout(QVBoxLayout())
 
 		self.vbox.layout().setContentsMargins(0, 0, 0, 0)
 
@@ -1391,7 +1391,7 @@ class FetchMoreRecordsBar():
 		self.hbox.addWidget(self.close_button)
 
 		self.bar = QWidget()
-		self.bar.setLayout(self.hbox);
+		self.bar.setLayout(self.hbox)
 		self.bar.show()
 
 		self.in_progress = False
@@ -2206,7 +2206,7 @@ class ReportDialogBase(QDialog):
 		self.vbox.addLayout(self.grid)
 		self.vbox.addLayout(self.hbox)
 
-		self.setLayout(self.vbox);
+		self.setLayout(self.vbox)
 
 	def Ok(self):
 		vars = self.report_vars
@@ -3139,7 +3139,7 @@ class AboutDialog(QDialog):
 		self.vbox = QVBoxLayout()
 		self.vbox.addWidget(self.text)
 
-		self.setLayout(self.vbox);
+		self.setLayout(self.vbox)
 
 # Font resize
 
-- 
2.21.0
