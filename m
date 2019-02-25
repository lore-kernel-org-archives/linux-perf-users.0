From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/37] perf scripts python: exported-sql-viewer.py: Remove leftover debugging prints
Date: Mon, 25 Feb 2019 18:20:03 -0300
Message-ID: <20190225212035.24781-6-acme@kernel.org>
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

Remove leftover debugging prints.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index b296028386a6..c20b510ace8f 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1560,7 +1560,6 @@ class SQLTableDialogDataItem():
 					return str(lower_id)
 
 	def ConvertRelativeTime(self, val):
-		print "val ", val
 		mult = 1
 		suffix = val[-2:]
 		if suffix == "ms":
@@ -1582,29 +1581,23 @@ class SQLTableDialogDataItem():
 		return str(val)
 
 	def ConvertTimeRange(self, vrange):
-		print "vrange ", vrange
 		if vrange[0] == "":
 			vrange[0] = str(self.first_time)
 		if vrange[1] == "":
 			vrange[1] = str(self.last_time)
 		vrange[0] = self.ConvertRelativeTime(vrange[0])
 		vrange[1] = self.ConvertRelativeTime(vrange[1])
-		print "vrange2 ", vrange
 		if not self.IsNumber(vrange[0]) or not self.IsNumber(vrange[1]):
 			return False
-		print "ok1"
 		beg_range = max(int(vrange[0]), self.first_time)
 		end_range = min(int(vrange[1]), self.last_time)
 		if beg_range > self.last_time or end_range < self.first_time:
 			return False
-		print "ok2"
 		vrange[0] = self.BinarySearchTime(0, self.last_id, beg_range, True)
 		vrange[1] = self.BinarySearchTime(1, self.last_id + 1, end_range, False)
-		print "vrange3 ", vrange
 		return True
 
 	def AddTimeRange(self, value, ranges):
-		print "value ", value
 		n = value.count("-")
 		if n == 1:
 			pass
-- 
2.20.1
