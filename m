From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/37] perf tools: Add pattern name checking to rm_rf
Date: Mon, 25 Feb 2019 18:20:18 -0300
Message-ID: <20190225212035.24781-21-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add pattern argument to rm_rf_depth() (and rename it to rm_rf_depth_pat())
to specify the name pattern files need to match inside the directory.

The function fails if we find different file to remove.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index bcf436892155..02b7a38f98ce 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -21,6 +21,7 @@
 #include <linux/time64.h>
 #include <unistd.h>
 #include "strlist.h"
+#include "string2.h"
 
 /*
  * XXX We need to find a better place for these things...
@@ -117,12 +118,38 @@ int mkdir_p(char *path, mode_t mode)
 	return (stat(path, &st) && mkdir(path, mode)) ? -1 : 0;
 }
 
+static bool match_pat(char *file, const char **pat)
+{
+	int i = 0;
+
+	if (!pat)
+		return true;
+
+	while (pat[i]) {
+		if (strglobmatch(file, pat[i]))
+			return true;
+
+		i++;
+	}
+
+	return false;
+}
+
 /*
  * The depth specify how deep the removal will go.
  * 0       - will remove only files under the 'path' directory
  * 1 .. x  - will dive in x-level deep under the 'path' directory
+ *
+ * If specified the pat is array of string patterns ended with NULL,
+ * which are checked upon every file/directory found. Only matching
+ * ones are removed.
+ *
+ * The function returns:
+ *    0 on success
+ *   -1 on removal failure with errno set
+ *   -2 on pattern failure
  */
-static int rm_rf_depth(const char *path, int depth)
+static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 {
 	DIR *dir;
 	int ret;
@@ -149,6 +176,9 @@ static int rm_rf_depth(const char *path, int depth)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
+		if (!match_pat(d->d_name, pat))
+			return -2;
+
 		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
 			  path, d->d_name);
 
@@ -160,7 +190,7 @@ static int rm_rf_depth(const char *path, int depth)
 		}
 
 		if (S_ISDIR(statbuf.st_mode))
-			ret = depth ? rm_rf_depth(namebuf, depth - 1) : 0;
+			ret = depth ? rm_rf_depth_pat(namebuf, depth - 1, pat) : 0;
 		else
 			ret = unlink(namebuf);
 	}
@@ -174,7 +204,7 @@ static int rm_rf_depth(const char *path, int depth)
 
 int rm_rf(const char *path)
 {
-	return rm_rf_depth(path, INT_MAX);
+	return rm_rf_depth_pat(path, INT_MAX, NULL);
 }
 
 /* A filter which removes dot files */
-- 
2.20.1
