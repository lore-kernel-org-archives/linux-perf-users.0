From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/27] perf report: Support time percent and multiple time ranges
Date: Wed, 10 Jan 2018 18:28:28 -0300
Message-ID: <20180110212844.12441-12-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

perf report has a --time option to limit the time range of output.  It
only supports absolute time.

Now this option is extended to support multiple time ranges and support
the percent of time.

For example:

1. Select the first and second 10% time slices:

perf report --time 10%/1,10%/2

2. Select from 0% to 10% and 30% to 40% slices:

perf report --time 0%-10%,30%-40%

Changelog:

v6: Fix the merge issue with latest perf/core branch.
    No functional changes.

v5: Add checking of first/last sample time to detect if it's recorded
    in perf.data. If it's not recorded, returns error message to user.

v4: Remove perf_time__skip_sample, only uses perf_time__ranges_skip_sample

v3: Since the definitions of first_sample_time/last_sample_time
    are moved from perf_session to perf_evlist so change the
    related code.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512738826-2628-6-git-send-email-yao.jin@linux.intel.com
[ Add missing colons at end of examples in the man page ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 20 ++++++++++++++++++++
 tools/perf/builtin-report.c              | 31 ++++++++++++++++++++++++++-----
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index ddde2b54af57..1e02c4e1a81f 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -402,6 +402,26 @@ OPTIONS
 	stop time is not given (i.e, time string is 'x.y,') then analysis goes
 	to end of file.
 
+	Also support time percent with multiple time range. Time string is
+	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'. The maximum number of slices is 10.
+
+	For example:
+	Select the second 10% time slice:
+
+	  perf report --time 10%/2
+
+	Select from 0% to 10% time slice:
+
+	  perf report --time 0%-10%
+
+	Select the first and second 10% time slices:
+
+	  perf report --time 10%/1,10%/2
+
+	Select from 0% to 10% and 30% to 40% slices:
+
+	  perf report --time 0%-10%,30%-40%
+
 --itrace::
 	Options for decoding instruction tracing data. The options are:
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 07827cd51480..770bf8a614f2 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -52,6 +52,8 @@
 #include <sys/stat.h>
 #include <unistd.h>
 
+#define PTIME_RANGE_MAX	10
+
 struct report {
 	struct perf_tool	tool;
 	struct perf_session	*session;
@@ -69,7 +71,8 @@ struct report {
 	const char		*cpu_list;
 	const char		*symbol_filter_str;
 	const char		*time_str;
-	struct perf_time_interval ptime;
+	struct perf_time_interval ptime_range[PTIME_RANGE_MAX];
+	int			range_num;
 	float			min_percent;
 	u64			nr_entries;
 	u64			queue_size;
@@ -202,8 +205,10 @@ static int process_sample_event(struct perf_tool *tool,
 	};
 	int ret = 0;
 
-	if (perf_time__skip_sample(&rep->ptime, sample->time))
+	if (perf_time__ranges_skip_sample(rep->ptime_range, rep->range_num,
+					  sample->time)) {
 		return 0;
+	}
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_debug("problem processing %d event, skipping it.\n",
@@ -1093,9 +1098,25 @@ int cmd_report(int argc, const char **argv)
 	if (symbol__init(&session->header.env) < 0)
 		goto error;
 
-	if (perf_time__parse_str(&report.ptime, report.time_str) != 0) {
-		pr_err("Invalid time string\n");
-		return -EINVAL;
+	if (perf_time__parse_str(report.ptime_range, report.time_str) != 0) {
+		if (session->evlist->first_sample_time == 0 &&
+		    session->evlist->last_sample_time == 0) {
+			pr_err("No first/last sample time in perf data\n");
+			return -EINVAL;
+		}
+
+		report.range_num = perf_time__percent_parse_str(
+					report.ptime_range, PTIME_RANGE_MAX,
+					report.time_str,
+					session->evlist->first_sample_time,
+					session->evlist->last_sample_time);
+
+		if (report.range_num < 0) {
+			pr_err("Invalid time string\n");
+			return -EINVAL;
+		}
+	} else {
+		report.range_num = 1;
 	}
 
 	sort__setup_elide(stdout);
-- 
2.14.3
