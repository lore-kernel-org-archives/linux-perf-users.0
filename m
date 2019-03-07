From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/35] perf scripts python: exported-sql-viewer.py: Improve TreeModel abstraction
Date: Thu,  7 Mar 2019 14:44:11 -0300
Message-ID: <20190307174433.28819-14-acme@kernel.org>
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

Instead of passing the tree root, get it from a method that can be
implemented in any derived class.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-ovcv28bg4mt9swk36ypdyz14@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/scripts/python/exported-sql-viewer.py  | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index df854f0a69f0..b2a22525549d 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -167,9 +167,10 @@ class Thread(QThread):
 
 class TreeModel(QAbstractItemModel):
 
-	def __init__(self, root, parent=None):
+	def __init__(self, glb, parent=None):
 		super(TreeModel, self).__init__(parent)
-		self.root = root
+		self.glb = glb
+		self.root = self.GetRoot()
 		self.last_row_read = 0
 
 	def Item(self, parent):
@@ -562,8 +563,10 @@ class CallGraphRootItem(CallGraphLevelItemBase):
 class CallGraphModel(TreeModel):
 
 	def __init__(self, glb, parent=None):
-		super(CallGraphModel, self).__init__(CallGraphRootItem(glb), parent)
-		self.glb = glb
+		super(CallGraphModel, self).__init__(glb, parent)
+
+	def GetRoot(self):
+		return CallGraphRootItem(self.glb)
 
 	def columnCount(self, parent=None):
 		return 7
@@ -1339,8 +1342,7 @@ class BranchModel(TreeModel):
 	progress = Signal(object)
 
 	def __init__(self, glb, event_id, where_clause, parent=None):
-		super(BranchModel, self).__init__(BranchRootItem(), parent)
-		self.glb = glb
+		super(BranchModel, self).__init__(glb, parent)
 		self.event_id = event_id
 		self.more = True
 		self.populated = 0
@@ -1364,6 +1366,9 @@ class BranchModel(TreeModel):
 		self.fetcher.done.connect(self.Update)
 		self.fetcher.Fetch(glb_chunk_sz)
 
+	def GetRoot(self):
+		return BranchRootItem()
+
 	def columnCount(self, parent=None):
 		return 8
 
-- 
2.20.1
