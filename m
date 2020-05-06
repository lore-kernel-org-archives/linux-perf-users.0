From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 77/91] perf stat: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date: Wed,  6 May 2020 12:22:20 -0300
Message-ID: <20200506152234.21977-78-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b2a971961364..e0c1ad23c768 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -238,9 +238,8 @@ static int write_stat_round_event(u64 tm, u64 type)
 
 #define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
-static int
-perf_evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
-			     struct perf_counts_values *count)
+static int evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
+				   struct perf_counts_values *count)
 {
 	struct perf_sample_id *sid = SID(counter, cpu, thread);
 
@@ -297,7 +296,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 		perf_counts__set_loaded(counter->counts, cpu, thread, false);
 
 		if (STAT_RECORD) {
-			if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
+			if (evsel__write_stat_event(counter, cpu, thread, count)) {
 				pr_err("failed to write stat event\n");
 				return -1;
 			}
@@ -410,7 +409,7 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static bool perf_evsel__should_store_id(struct evsel *counter)
+static bool evsel__should_store_id(struct evsel *counter)
 {
 	return STAT_RECORD || counter->core.attr.read_format & PERF_FORMAT_ID;
 }
@@ -635,7 +634,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (l > stat_config.unit_width)
 			stat_config.unit_width = l;
 
-		if (perf_evsel__should_store_id(counter) &&
+		if (evsel__should_store_id(counter) &&
 		    evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
-- 
2.21.1
