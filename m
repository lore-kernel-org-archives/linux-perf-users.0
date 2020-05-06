From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 61/91] perf evsel: Rename perf_evsel__open_per_*() to evsel__open_per_*()
Date: Wed,  6 May 2020 12:22:04 -0300
Message-ID: <20200506152234.21977-62-acme@kernel.org>
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

As those are not 'struct evsel' methods, not part of tools/lib/perf/,
aka libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/event-times.c    | 8 ++++----
 tools/perf/tests/openat-syscall.c | 2 +-
 tools/perf/util/evsel.c           | 7 ++-----
 tools/perf/util/evsel.h           | 7 ++-----
 tools/perf/util/stat.c            | 4 ++--
 5 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 1e8a9f5c356d..db68894a6f40 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -72,7 +72,7 @@ static int attach__current_disabled(struct evlist *evlist)
 
 	evsel->core.attr.disabled = 1;
 
-	err = perf_evsel__open_per_thread(evsel, threads);
+	err = evsel__open_per_thread(evsel, threads);
 	if (err) {
 		pr_debug("Failed to open event cpu-clock:u\n");
 		return err;
@@ -96,7 +96,7 @@ static int attach__current_enabled(struct evlist *evlist)
 		return -1;
 	}
 
-	err = perf_evsel__open_per_thread(evsel, threads);
+	err = evsel__open_per_thread(evsel, threads);
 
 	perf_thread_map__put(threads);
 	return err == 0 ? TEST_OK : TEST_FAIL;
@@ -125,7 +125,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 
 	evsel->core.attr.disabled = 1;
 
-	err = perf_evsel__open_per_cpu(evsel, cpus, -1);
+	err = evsel__open_per_cpu(evsel, cpus, -1);
 	if (err) {
 		if (err == -EACCES)
 			return TEST_SKIP;
@@ -152,7 +152,7 @@ static int attach__cpu_enabled(struct evlist *evlist)
 		return -1;
 	}
 
-	err = perf_evsel__open_per_cpu(evsel, cpus, -1);
+	err = evsel__open_per_cpu(evsel, cpus, -1);
 	if (err == -EACCES)
 		return TEST_SKIP;
 
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 5ebffae18605..8497a1fe9bac 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -34,7 +34,7 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 		goto out_thread_map_delete;
 	}
 
-	if (perf_evsel__open_per_thread(evsel, threads) < 0) {
+	if (evsel__open_per_thread(evsel, threads) < 0) {
 		pr_debug("failed to open counter: %s, "
 			 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f271764cbf2..bbd57e8fde7d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1863,9 +1863,7 @@ void evsel__close(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 }
 
-int perf_evsel__open_per_cpu(struct evsel *evsel,
-			     struct perf_cpu_map *cpus,
-			     int cpu)
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu)
 {
 	if (cpu == -1)
 		return evsel__open_cpu(evsel, cpus, NULL, 0,
@@ -1874,8 +1872,7 @@ int perf_evsel__open_per_cpu(struct evsel *evsel,
 	return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
 }
 
-int perf_evsel__open_per_thread(struct evsel *evsel,
-				struct perf_thread_map *threads)
+int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 {
 	return evsel__open(evsel, NULL, threads);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index df64d89cd916..e16a9b23556b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -233,11 +233,8 @@ int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 int evsel__disable_cpu(struct evsel *evsel, int cpu);
 
-int perf_evsel__open_per_cpu(struct evsel *evsel,
-			     struct perf_cpu_map *cpus,
-			     int cpu);
-int perf_evsel__open_per_thread(struct evsel *evsel,
-				struct perf_thread_map *threads);
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu);
+int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
 void evsel__close(struct evsel *evsel);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c27f01b944c5..3520b7443615 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -521,7 +521,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
+		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
 
-	return perf_evsel__open_per_thread(evsel, evsel->core.threads);
+	return evsel__open_per_thread(evsel, evsel->core.threads);
 }
-- 
2.21.1
