From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/73] perf scripts python: exported-sql-viewer.py: Add tree level
Date: Fri, 17 May 2019 16:35:13 -0300
Message-ID: <20190517193611.4974-16-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

As preparation for adding support for copying to clipboard, keep track of
what level each item is in tree items.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index fd073e4af8da..48953257a1f0 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -456,6 +456,10 @@ class CallGraphLevelItemBase(object):
 		self.query_done = False;
 		self.child_count = 0
 		self.child_items = []
+		if parent_item:
+			self.level = parent_item.level + 1
+		else:
+			self.level = 0
 
 	def getChildItem(self, row):
 		return self.child_items[row]
-- 
2.20.1
