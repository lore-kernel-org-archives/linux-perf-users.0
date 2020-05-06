From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 73/91] perf evsel: Rename perf_evsel__fallback() to evsel__fallback()
Date: Wed,  6 May 2020 12:22:16 -0300
Message-ID: <20200506152234.21977-74-acme@kernel.org>
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

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-stat.c   | 2 +-
 tools/perf/builtin-top.c    | 2 +-
 tools/perf/util/cloexec.c   | 2 +-
 tools/perf/util/evsel.c     | 3 +--
 tools/perf/util/evsel.h     | 3 +--
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ab303c4165ac..46aaa6b14ca1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -845,7 +845,7 @@ static int record__open(struct record *rec)
 	evlist__for_each_entry(evlist, pos) {
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
-			if (perf_evsel__fallback(pos, errno, msg, sizeof(msg))) {
+			if (evsel__fallback(pos, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
 				goto try_again;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e3629ca69827..92a59f08db71 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -466,7 +466,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		if ((counter->leader != counter) ||
 		    !(counter->leader->core.nr_members > 1))
 			return COUNTER_SKIP;
-	} else if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
+	} else if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4403a76f2047..d5bfffed2843 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1045,7 +1045,7 @@ static int perf_top__start_counters(struct perf_top *top)
 			    perf_top_overwrite_fallback(top, counter))
 				goto try_again;
 
-			if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
+			if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
 				goto try_again;
diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index a12872f2856a..6b3988a7aba8 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -28,7 +28,7 @@ int __weak sched_getcpu(void)
 
 static int perf_flag_probe(void)
 {
-	/* use 'safest' configuration as used in perf_evsel__fallback() */
+	/* use 'safest' configuration as used in evsel__fallback() */
 	struct perf_event_attr attr = {
 		.type = PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_CPU_CLOCK,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 909e993b4dcd..a75bcb95bf23 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2382,8 +2382,7 @@ u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *n
 	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
 }
 
-bool perf_evsel__fallback(struct evsel *evsel, int err,
-			  char *msg, size_t msgsize)
+bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
 {
 	int paranoid;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 101cfff647c7..783246bf8d0d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -350,8 +350,7 @@ static inline bool evsel__is_clock(struct evsel *evsel)
 	       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
 }
 
-bool perf_evsel__fallback(struct evsel *evsel, int err,
-			  char *msg, size_t msgsize);
+bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize);
 int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 			      int err, char *msg, size_t size);
 
-- 
2.21.1
