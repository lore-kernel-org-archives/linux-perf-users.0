From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/32] perf report: Remove the time slices number limitation
Date: Wed, 17 Jan 2018 13:12:20 -0300
Message-ID: <20180117161222.15611-31-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Previously it was only allowed to use at most 10 time slices in 'perf
report --time'.

This patch removes this limitation.
For example, following command line is OK (12 time slices)

perf report --stdio --time 1%/1,1%/2,1%/3,1%/4,1%/5,1%/6,1%/7,1%/8,1%/9,1%/10,1%/11,1%/12

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1515596433-24653-8-git-send-email-yao.jin@linux.intel.com
[ No need to check for NULL to call free, use zfree ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  2 +-
 tools/perf/builtin-report.c              | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 63d0db3184c9..907e505b6309 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -403,7 +403,7 @@ OPTIONS
 	to end of file.
 
 	Also support time percent with multiple time range. Time string is
-	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'. The maximum number of slices is 10.
+	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
 
 	For example:
 	Select the second 10% time slice:
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4aaaa37262a8..42a52dcc41cd 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -54,8 +54,6 @@
 #include <unistd.h>
 #include <linux/mman.h>
 
-#define PTIME_RANGE_MAX	10
-
 struct report {
 	struct perf_tool	tool;
 	struct perf_session	*session;
@@ -76,7 +74,8 @@ struct report {
 	const char		*cpu_list;
 	const char		*symbol_filter_str;
 	const char		*time_str;
-	struct perf_time_interval ptime_range[PTIME_RANGE_MAX];
+	struct perf_time_interval *ptime_range;
+	int			range_size;
 	int			range_num;
 	float			min_percent;
 	u64			nr_entries;
@@ -1300,24 +1299,33 @@ int cmd_report(int argc, const char **argv)
 	if (symbol__init(&session->header.env) < 0)
 		goto error;
 
+	report.ptime_range = perf_time__range_alloc(report.time_str,
+						    &report.range_size);
+	if (!report.ptime_range) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
 	if (perf_time__parse_str(report.ptime_range, report.time_str) != 0) {
 		if (session->evlist->first_sample_time == 0 &&
 		    session->evlist->last_sample_time == 0) {
 			pr_err("HINT: no first/last sample time found in perf data.\n"
 			       "Please use latest perf binary to execute 'perf record'\n"
 			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto error;
 		}
 
 		report.range_num = perf_time__percent_parse_str(
-					report.ptime_range, PTIME_RANGE_MAX,
+					report.ptime_range, report.range_size,
 					report.time_str,
 					session->evlist->first_sample_time,
 					session->evlist->last_sample_time);
 
 		if (report.range_num < 0) {
 			pr_err("Invalid time string\n");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto error;
 		}
 	} else {
 		report.range_num = 1;
@@ -1333,6 +1341,8 @@ int cmd_report(int argc, const char **argv)
 		ret = 0;
 
 error:
+	zfree(&report.ptime_range);
+
 	perf_session__delete(session);
 	return ret;
 }
-- 
2.14.3
