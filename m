From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/32] perf script: Remove the time slices number limitation
Date: Wed, 17 Jan 2018 13:12:21 -0300
Message-ID: <20180117161222.15611-32-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Previously it was only allowed to use at most 10 time slices in 'perf
script --time'.

This patch removes this limitation.
For example, following command line is OK (12 time slices)

perf script --time 1%/1,1%/2,1%/3,1%/4,1%/5,1%/6,1%/7,1%/8,1%/9,1%/10,1%/11,1%/12

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1515596433-24653-9-git-send-email-yao.jin@linux.intel.com
[ No need to check for NULL to call free, use zfree ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt | 10 +++++-----
 tools/perf/builtin-script.c              | 16 ++++++++++++----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 806ec6391fd6..7730c1d2b5d3 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -351,19 +351,19 @@ include::itrace.txt[]
 	to end of file.
 
 	Also support time percent with multipe time range. Time string is
-	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'. The maximum number of slices is 10.
+	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
 
 	For example:
-	Select the second 10% time slice
+	Select the second 10% time slice:
 	perf script --time 10%/2
 
-	Select from 0% to 10% time slice
+	Select from 0% to 10% time slice:
 	perf script --time 0%-10%
 
-	Select the first and second 10% time slices
+	Select the first and second 10% time slices:
 	perf script --time 10%/1,10%/2
 
-	Select from 0% to 10% and 30% to 40% slices
+	Select from 0% to 10% and 30% to 40% slices:
 	perf script --time 0%-10%,30%-40%
 
 --max-blocks::
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ac781916e51e..3499d68e1d70 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1480,8 +1480,6 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 	return 0;
 }
 
-#define PTIME_RANGE_MAX	10
-
 struct perf_script {
 	struct perf_tool	tool;
 	struct perf_session	*session;
@@ -1496,7 +1494,8 @@ struct perf_script {
 	struct thread_map	*threads;
 	int			name_width;
 	const char              *time_str;
-	struct perf_time_interval ptime_range[PTIME_RANGE_MAX];
+	struct perf_time_interval *ptime_range;
+	int			range_size;
 	int			range_num;
 };
 
@@ -3445,6 +3444,13 @@ int cmd_script(int argc, const char **argv)
 	if (err < 0)
 		goto out_delete;
 
+	script.ptime_range = perf_time__range_alloc(script.time_str,
+						    &script.range_size);
+	if (!script.ptime_range) {
+		err = -ENOMEM;
+		goto out_delete;
+	}
+
 	/* needs to be parsed after looking up reference time */
 	if (perf_time__parse_str(script.ptime_range, script.time_str) != 0) {
 		if (session->evlist->first_sample_time == 0 &&
@@ -3457,7 +3463,7 @@ int cmd_script(int argc, const char **argv)
 		}
 
 		script.range_num = perf_time__percent_parse_str(
-					script.ptime_range, PTIME_RANGE_MAX,
+					script.ptime_range, script.range_size,
 					script.time_str,
 					session->evlist->first_sample_time,
 					session->evlist->last_sample_time);
@@ -3476,6 +3482,8 @@ int cmd_script(int argc, const char **argv)
 	flush_scripting();
 
 out_delete:
+	zfree(&script.ptime_range);
+
 	perf_evlist__free_stats(session->evlist);
 	perf_session__delete(session);
 
-- 
2.14.3
