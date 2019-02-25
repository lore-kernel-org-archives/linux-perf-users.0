From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/37] perf tools: Add rm_rf_perf_data function
Date: Mon, 25 Feb 2019 18:20:19 -0300
Message-ID: <20190225212035.24781-22-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To remove perf.data including the directory, with checking on expected
files and no other directories inside.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 11 +++++++++++
 tools/perf/util/util.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 02b7a38f98ce..706818693086 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -202,6 +202,17 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 	return rmdir(path);
 }
 
+int rm_rf_perf_data(const char *path)
+{
+	const char *pat[] = {
+		"header",
+		"data.*",
+		NULL,
+	};
+
+	return rm_rf_depth_pat(path, 0, pat);
+}
+
 int rm_rf(const char *path)
 {
 	return rm_rf_depth_pat(path, INT_MAX, NULL);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index ece040b799f6..01c538027c6f 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -31,6 +31,7 @@ struct strlist;
 
 int mkdir_p(char *path, mode_t mode);
 int rm_rf(const char *path);
+int rm_rf_perf_data(const char *path);
 struct strlist *lsdir(const char *name, bool (*filter)(const char *, struct dirent *));
 bool lsdir_no_dot_filter(const char *name, struct dirent *d);
 int copyfile(const char *from, const char *to);
-- 
2.20.1
