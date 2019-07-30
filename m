From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 043/107] perf evsel: Rename perf_evsel__disable() to evsel__disable()
Date: Mon, 29 Jul 2019 23:55:06 -0300
Message-ID: <20190730025610.22603-44-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Renaming perf_evsel__disable() to evsel__disable(), so we don't have a
name clash when we add perf_evsel__disable() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 2 +-
 tools/perf/arch/x86/util/intel-bts.c | 2 +-
 tools/perf/arch/x86/util/intel-pt.c  | 2 +-
 tools/perf/builtin-trace.c           | 2 +-
 tools/perf/tests/keep-tracking.c     | 2 +-
 tools/perf/tests/switch-tracking.c   | 4 ++--
 tools/perf/util/evlist.c             | 2 +-
 tools/perf/util/evsel.c              | 2 +-
 tools/perf/util/evsel.h              | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 4b70b9504603..268fcb31cd53 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -821,7 +821,7 @@ static int cs_etm_snapshot_start(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->cs_etm_pmu->type)
-			return perf_evsel__disable(evsel);
+			return evsel__disable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index d27832fcb34c..8b0a53d748c9 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -317,7 +317,7 @@ static int intel_bts_snapshot_start(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(btsr->evlist, evsel) {
 		if (evsel->attr.type == btsr->intel_bts_pmu->type)
-			return perf_evsel__disable(evsel);
+			return evsel__disable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index e3dacb2bf01b..4ce157a4e5e2 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -788,7 +788,7 @@ static int intel_pt_snapshot_start(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->intel_pt_pmu->type)
-			return perf_evsel__disable(evsel);
+			return evsel__disable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 89ae4737ef74..95ecefa9ff7e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2400,7 +2400,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 			++trace->nr_events_printed;
 
 			if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
-				perf_evsel__disable(evsel);
+				evsel__disable(evsel);
 				perf_evsel__close(evsel);
 			}
 		}
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index cdc19bcc7523..1976ccb3c812 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -129,7 +129,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 
 	evsel = perf_evlist__last(evlist);
 
-	CHECK__(perf_evsel__disable(evsel));
+	CHECK__(evsel__disable(evsel));
 
 	comm = "Test COMM 2";
 	CHECK__(prctl(PR_SET_NAME, (unsigned long)comm, 0, 0, 0));
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index acc4b5ff0cea..5662dc1c6bd3 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -464,7 +464,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 
 	perf_evlist__enable(evlist);
 
-	err = perf_evsel__disable(cpu_clocks_evsel);
+	err = evsel__disable(cpu_clocks_evsel);
 	if (err) {
 		pr_debug("perf_evlist__disable_event failed!\n");
 		goto out_err;
@@ -483,7 +483,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	err = perf_evsel__disable(cycles_evsel);
+	err = evsel__disable(cycles_evsel);
 	if (err) {
 		pr_debug("perf_evlist__disable_event failed!\n");
 		goto out_err;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e87c43e339d0..9461583c53d9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -350,7 +350,7 @@ void perf_evlist__disable(struct evlist *evlist)
 	evlist__for_each_entry(evlist, pos) {
 		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->fd)
 			continue;
-		perf_evsel__disable(pos);
+		evsel__disable(pos);
 	}
 
 	evlist->enabled = false;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7adae1736191..855d286298eb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1244,7 +1244,7 @@ int evsel__enable(struct evsel *evsel)
 	return err;
 }
 
-int perf_evsel__disable(struct evsel *evsel)
+int evsel__disable(struct evsel *evsel)
 {
 	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
 	/*
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index fa26c583a606..c338ce14e8aa 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -296,7 +296,7 @@ int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct evsel *evsel, const char *filter);
 int evsel__enable(struct evsel *evsel);
-int perf_evsel__disable(struct evsel *evsel);
+int evsel__disable(struct evsel *evsel);
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
 			     struct perf_cpu_map *cpus);
-- 
2.21.0
