From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/18] perf scripts python: exported-sql-viewer.py: Fix table find when table re-ordered
Date: Tue,  6 Nov 2018 09:06:07 -0300
Message-ID: <20181106120612.8262-14-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Table rows can be re-ordered by selecting a column to sort by. After
re-ordering, the "find" operation was highlighting the wrong row, fix
it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181104151238.15947-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index c2fcf6c5237a..f278ce5ebab7 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1975,7 +1975,7 @@ class TableWindow(QMdiSubWindow, ResizeColumnsToContentsBase):
 	def FindDone(self, row):
 		self.find_bar.Idle()
 		if row >= 0:
-			self.view.setCurrentIndex(self.model.index(row, 0, QModelIndex()))
+			self.view.setCurrentIndex(self.model.mapFromSource(self.data_model.index(row, 0, QModelIndex())))
 		else:
 			self.find_bar.NotFound()
 
@@ -2188,6 +2188,8 @@ For PostgreSQL databases, information_schema.tables/views/columns are included.
 Ctrl-F displays a Find bar which finds substrings by either an exact match or a regular expression match.
 Refer to Python documentation for the regular expression syntax.
 All columns are searched, but only currently fetched rows are searched.
+<p>N.B. Results are found in id order, so if the table is re-ordered, find-next and find-previous
+will go to the next/previous result in id order, instead of display order.
 """
 
 # Help window
-- 
2.14.4
