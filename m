From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/37] perf scripts python: call-graph-from-sql.py: Make a "Main" function
Date: Thu, 25 Oct 2018 08:10:14 -0300
Message-ID: <20181025111031.3440-21-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Make a "Main" function so that the variables used do not pollute the global
namespace.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181001062853.28285-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/call-graph-from-sql.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/call-graph-from-sql.py b/tools/perf/scripts/python/call-graph-from-sql.py
index 2e33540f3de0..2b74b94eeccc 100644
--- a/tools/perf/scripts/python/call-graph-from-sql.py
+++ b/tools/perf/scripts/python/call-graph-from-sql.py
@@ -284,7 +284,9 @@ class MainWindow(QMainWindow):
 
 		self.setCentralWidget(self.view)
 
-if __name__ == '__main__':
+# Main
+
+def Main():
 	if (len(sys.argv) < 2):
 		print >> sys.stderr, "Usage is: call-graph-from-sql.py <database name>"
 		raise Exception("Too few arguments")
@@ -331,3 +333,6 @@ if __name__ == '__main__':
 	err = app.exec_()
 	db.close()
 	sys.exit(err)
+
+if __name__ == "__main__":
+	Main()
-- 
2.14.4
