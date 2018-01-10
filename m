From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/27] perf script: Support time percent and multiple time ranges
Date: Wed, 10 Jan 2018 18:28:29 -0300
Message-ID: <20180110212844.12441-13-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

perf script has a --time option to limit the time range of output.  It
only supports absolute time.

Now this option is extended to support multiple time ranges and support
the percent of time.

For example:

1. Select the first and second 10% time slices:

   perf script --time 10%/1,10%/2

2. Select from 0% to 10% and 30% to 40% slices:

   perf script --time 0%-10%,30%-40%

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
Link: http://lkml.kernel.org/r/1512738826-2628-7-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 16 +++++++++++++++
 tools/perf/builtin-script.c              | 34 ++++++++++++++++++++++++++------
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 974ceb12c7f3..7b622a812a72 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -329,6 +329,22 @@ include::itrace.txt[]
 	stop time is not given (i.e, time string is 'x.y,') then analysis goes
 	to end of file.
 
+	Also support time percent with multipe time range. Time string is
+	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'. The maximum number of slices is 10.
+
+	For example:
+	Select the second 10% time slice
+	perf script --time 10%/2
+
+	Select from 0% to 10% time slice
+	perf script --time 0%-10%
+
+	Select the first and second 10% time slices
+	perf script --time 10%/1,10%/2
+
+	Select from 0% to 10% and 30% to 40% slices
+	perf script --time 0%-10%,30%-40%
+
 --max-blocks::
 	Set the maximum number of program blocks to print with brstackasm for
 	each sample.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 77e47cf39f2c..330dcd9b9b8f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1436,6 +1436,8 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 	return 0;
 }
 
+#define PTIME_RANGE_MAX	10
+
 struct perf_script {
 	struct perf_tool	tool;
 	struct perf_session	*session;
@@ -1449,7 +1451,8 @@ struct perf_script {
 	struct thread_map	*threads;
 	int			name_width;
 	const char              *time_str;
-	struct perf_time_interval ptime;
+	struct perf_time_interval ptime_range[PTIME_RANGE_MAX];
+	int			range_num;
 };
 
 static int perf_evlist__max_name_len(struct perf_evlist *evlist)
@@ -1734,8 +1737,10 @@ static int process_sample_event(struct perf_tool *tool,
 	struct perf_script *scr = container_of(tool, struct perf_script, tool);
 	struct addr_location al;
 
-	if (perf_time__skip_sample(&scr->ptime, sample->time))
+	if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_num,
+					  sample->time)) {
 		return 0;
+	}
 
 	if (debug_mode) {
 		if (sample->time < last_timestamp) {
@@ -3360,10 +3365,27 @@ int cmd_script(int argc, const char **argv)
 		goto out_delete;
 
 	/* needs to be parsed after looking up reference time */
-	if (perf_time__parse_str(&script.ptime, script.time_str) != 0) {
-		pr_err("Invalid time string\n");
-		err = -EINVAL;
-		goto out_delete;
+	if (perf_time__parse_str(script.ptime_range, script.time_str) != 0) {
+		if (session->evlist->first_sample_time == 0 &&
+		    session->evlist->last_sample_time == 0) {
+			pr_err("No first/last sample time in perf data\n");
+			err = -EINVAL;
+			goto out_delete;
+		}
+
+		script.range_num = perf_time__percent_parse_str(
+					script.ptime_range, PTIME_RANGE_MAX,
+					script.time_str,
+					session->evlist->first_sample_time,
+					session->evlist->last_sample_time);
+
+		if (script.range_num < 0) {
+			pr_err("Invalid time string\n");
+			err = -EINVAL;
+			goto out_delete;
+		}
+	} else {
+		script.range_num = 1;
 	}
 
 	err = __cmd_script(&script);
-- 
2.14.3
