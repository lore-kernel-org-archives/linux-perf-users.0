From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/10] perf stat: Fix segfault for event group in repeat mode
Date: Tue, 23 Jul 2019 17:05:25 -0300
Message-ID: <20190723200530.14090-6-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Numfor Mbiziwo-Tiapo <nums@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, Mark Drayton <mbd@fb.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Numfor Mbiziwo-Tiapo reported segfault on stat of event group in repeat
mode:

  # perf stat -e '{cycles,instructions}' -r 10 ls

It's caused by memory corruption due to not cleaned evsel's id array and
index, which needs to be rebuilt in every stat iteration. Currently the
ids index grows, while the array (which is also not freed) has the same
size.

Fixing this by releasing id array and zeroing ids index in
perf_evsel__close function.

We also need to keep the evsel_list alive for stat record (which is
disabled in repeat mode).

Reported-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Mark Drayton <mbd@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190715142121.GC6032@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 9 ++++++++-
 tools/perf/util/evsel.c   | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b55a534b4de0..352cf39d7c2f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -607,7 +607,13 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * group leaders.
 	 */
 	read_counters(&(struct timespec) { .tv_nsec = t1-t0 });
-	perf_evlist__close(evsel_list);
+
+	/*
+	 * We need to keep evsel_list alive, because it's processed
+	 * later the evsel_list will be closed after.
+	 */
+	if (!STAT_RECORD)
+		perf_evlist__close(evsel_list);
 
 	return WEXITSTATUS(status);
 }
@@ -1997,6 +2003,7 @@ int cmd_stat(int argc, const char **argv)
 			perf_session__write_header(perf_stat.session, evsel_list, fd, true);
 		}
 
+		perf_evlist__close(evsel_list);
 		perf_session__delete(perf_stat.session);
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ebb46da4dfe5..52459dd5ad0c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1291,6 +1291,7 @@ static void perf_evsel__free_id(struct perf_evsel *evsel)
 	xyarray__delete(evsel->sample_id);
 	evsel->sample_id = NULL;
 	zfree(&evsel->id);
+	evsel->ids = 0;
 }
 
 static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
@@ -2077,6 +2078,7 @@ void perf_evsel__close(struct perf_evsel *evsel)
 
 	perf_evsel__close_fd(evsel);
 	perf_evsel__free_fd(evsel);
+	perf_evsel__free_id(evsel);
 }
 
 int perf_evsel__open_per_cpu(struct perf_evsel *evsel,
-- 
2.21.0
