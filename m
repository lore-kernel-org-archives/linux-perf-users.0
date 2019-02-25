From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/37] perf scripts python: exported-sql-viewer.py: Remove no selection error
Date: Mon, 25 Feb 2019 18:20:11 -0300
Message-ID: <20190225212035.24781-14-acme@kernel.org>
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

If no selection is made on the 'Selected branches' dialog, then the
output is the same as the 'All branches' report. That is not really an
error, and is not desirable for future reports, so remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index e1c2f9e54238..728200e3a691 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1808,9 +1808,6 @@ class ReportDialogBase(QDialog):
 				vars.where_clause = " AND ( " + vars.where_clause + " ) "
 			else:
 				vars.where_clause = " WHERE " + vars.where_clause + " "
-		else:
-			self.ShowMessage("No selection")
-			return
 		self.accept()
 
 	def ShowMessage(self, msg):
-- 
2.20.1
