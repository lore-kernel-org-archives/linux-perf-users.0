From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/37] perf tools: Add depth checking to rm_rf
Date: Mon, 25 Feb 2019 18:20:17 -0300
Message-ID: <20190225212035.24781-20-acme@kernel.org>
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

Adding depth argument to rm_rf (and renaming it to rm_rf_depth) to
specify the depth we will go searching for files to remove.

It will be used to specify single depth for perf.data directory removal
in following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 3ee410fc047a..bcf436892155 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -117,7 +117,12 @@ int mkdir_p(char *path, mode_t mode)
 	return (stat(path, &st) && mkdir(path, mode)) ? -1 : 0;
 }
 
-int rm_rf(const char *path)
+/*
+ * The depth specify how deep the removal will go.
+ * 0       - will remove only files under the 'path' directory
+ * 1 .. x  - will dive in x-level deep under the 'path' directory
+ */
+static int rm_rf_depth(const char *path, int depth)
 {
 	DIR *dir;
 	int ret;
@@ -155,7 +160,7 @@ int rm_rf(const char *path)
 		}
 
 		if (S_ISDIR(statbuf.st_mode))
-			ret = rm_rf(namebuf);
+			ret = depth ? rm_rf_depth(namebuf, depth - 1) : 0;
 		else
 			ret = unlink(namebuf);
 	}
@@ -167,6 +172,11 @@ int rm_rf(const char *path)
 	return rmdir(path);
 }
 
+int rm_rf(const char *path)
+{
+	return rm_rf_depth(path, INT_MAX);
+}
+
 /* A filter which removes dot files */
 bool lsdir_no_dot_filter(const char *name __maybe_unused, struct dirent *d)
 {
-- 
2.20.1
