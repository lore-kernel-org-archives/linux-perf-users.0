From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 042/107] perf evsel: Rename perf_evsel__enable() to evsel__enable()
Date: Mon, 29 Jul 2019 23:55:05 -0300
Message-ID: <20190730025610.22603-43-acme@kernel.org>
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

Rename perf_evsel__enable() to evsel__enable(), so we don't have a name
clash when we add perf_evsel__enable() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 2 +-
 tools/perf/arch/x86/util/intel-bts.c | 2 +-
 tools/perf/arch/x86/util/intel-pt.c  | 2 +-
 tools/perf/tests/event-times.c       | 6 +++---
 tools/perf/tests/switch-tracking.c   | 2 +-
 tools/perf/util/evlist.c             | 4 ++--
 tools/perf/util/evsel.c              | 2 +-
 tools/perf/util/evsel.h              | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 91c64daa4487..4b70b9504603 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -834,7 +834,7 @@ static int cs_etm_snapshot_finish(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->cs_etm_pmu->type)
-			return perf_evsel__enable(evsel);
+			return evsel__enable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index c845531d383a..d27832fcb34c 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -330,7 +330,7 @@ static int intel_bts_snapshot_finish(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(btsr->evlist, evsel) {
 		if (evsel->attr.type == btsr->intel_bts_pmu->type)
-			return perf_evsel__enable(evsel);
+			return evsel__enable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index e4dfe8c3d5c3..e3dacb2bf01b 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -801,7 +801,7 @@ static int intel_pt_snapshot_finish(struct auxtrace_record *itr)
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
 		if (evsel->attr.type == ptr->intel_pt_pmu->type)
-			return perf_evsel__enable(evsel);
+			return evsel__enable(evsel);
 	}
 	return -EINVAL;
 }
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 0f74ca103c41..6f9995df2c27 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -77,7 +77,7 @@ static int attach__current_disabled(struct evlist *evlist)
 	}
 
 	thread_map__put(threads);
-	return perf_evsel__enable(evsel) == 0 ? TEST_OK : TEST_FAIL;
+	return evsel__enable(evsel) == 0 ? TEST_OK : TEST_FAIL;
 }
 
 static int attach__current_enabled(struct evlist *evlist)
@@ -104,7 +104,7 @@ static int detach__disable(struct evlist *evlist)
 {
 	struct evsel *evsel = perf_evlist__last(evlist);
 
-	return perf_evsel__enable(evsel);
+	return evsel__enable(evsel);
 }
 
 static int attach__cpu_disabled(struct evlist *evlist)
@@ -133,7 +133,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 	}
 
 	cpu_map__put(cpus);
-	return perf_evsel__enable(evsel);
+	return evsel__enable(evsel);
 }
 
 static int attach__cpu_enabled(struct evlist *evlist)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index ac5da4fd222f..acc4b5ff0cea 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -509,7 +509,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out_err;
 	}
 
-	err = perf_evsel__enable(cycles_evsel);
+	err = evsel__enable(cycles_evsel);
 	if (err) {
 		pr_debug("perf_evlist__disable_event failed!\n");
 		goto out_err;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4627cc47de3e..e87c43e339d0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -363,7 +363,7 @@ void perf_evlist__enable(struct evlist *evlist)
 	evlist__for_each_entry(evlist, pos) {
 		if (!perf_evsel__is_group_leader(pos) || !pos->fd)
 			continue;
-		perf_evsel__enable(pos);
+		evsel__enable(pos);
 	}
 
 	evlist->enabled = true;
@@ -1927,7 +1927,7 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 		goto out_delete_evlist;
 
 	evlist__for_each_entry(evlist, counter) {
-		if (perf_evsel__enable(counter))
+		if (evsel__enable(counter))
 			goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f365d0685268..7adae1736191 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1234,7 +1234,7 @@ int perf_evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 	return perf_evsel__append_filter(evsel, "%s,%s", filter);
 }
 
-int perf_evsel__enable(struct evsel *evsel)
+int evsel__enable(struct evsel *evsel)
 {
 	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d43409bb07c5..fa26c583a606 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -295,7 +295,7 @@ int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct evsel *evsel, const char *filter);
-int perf_evsel__enable(struct evsel *evsel);
+int evsel__enable(struct evsel *evsel);
 int perf_evsel__disable(struct evsel *evsel);
 
 int perf_evsel__open_per_cpu(struct evsel *evsel,
-- 
2.21.0
