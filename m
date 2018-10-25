From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/37] perf stat: Poll for monitored tasks being alive
Date: Thu, 25 Oct 2018 08:10:06 -0300
Message-ID: <20181025111031.3440-13-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding the check for tasks we monitor via -p/-t options, and finish stat
if there's no longer task to monitor.

Requested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/r/20181022093015.9106-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b86aba1c8028..d1028d7755bb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -409,6 +409,28 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
 	return leader;
 }
 
+static bool is_target_alive(struct target *_target,
+			    struct thread_map *threads)
+{
+	struct stat st;
+	int i;
+
+	if (!target__has_task(_target))
+		return true;
+
+	for (i = 0; i < threads->nr; i++) {
+		char path[PATH_MAX];
+
+		scnprintf(path, PATH_MAX, "%s/%d", procfs__mountpoint(),
+			  threads->map[i].pid);
+
+		if (!stat(path, &st))
+			return true;
+	}
+
+	return false;
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -579,6 +601,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 		while (!done) {
 			nanosleep(&ts, NULL);
+			if (!is_target_alive(&target, evsel_list->threads))
+				break;
 			if (timeout)
 				break;
 			if (interval) {
-- 
2.14.4
