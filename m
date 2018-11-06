From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/18] perf scripts python: exported-sql-viewer.py: Fall back to /usr/local/lib/libxed.so
Date: Tue,  6 Nov 2018 09:06:04 -0300
Message-ID: <20181106120612.8262-11-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fall back to /usr/local/lib/libxed.so to cater for distributions that do
not have /usr/local/lib in the library path by default.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181104151238.15947-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 24cb0bd56afa..20cc8e7879b9 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -1929,7 +1929,12 @@ class XEDInstruction():
 class LibXED():
 
 	def __init__(self):
-		self.libxed = CDLL("libxed.so")
+		try:
+			self.libxed = CDLL("libxed.so")
+		except:
+			self.libxed = None
+		if not self.libxed:
+			self.libxed = CDLL("/usr/local/lib/libxed.so")
 
 		self.xed_tables_init = self.libxed.xed_tables_init
 		self.xed_tables_init.restype = None
-- 
2.14.4
