From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 71/91] perf evsel: Rename perf_evsel__{prev,next}() to evsel__{prev,next}()
Date: Wed,  6 May 2020 12:22:14 -0300
Message-ID: <20200506152234.21977-72-acme@kernel.org>
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

As those are 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/evsel-roundtrip-name.c |  2 +-
 tools/perf/tests/parse-events.c         | 52 ++++++++++++-------------
 tools/perf/ui/browsers/hists.c          |  4 +-
 tools/perf/util/evsel.h                 |  4 +-
 tools/perf/util/sort.c                  |  2 +-
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index f143de12e38a..61ecd8e33a01 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -53,7 +53,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 					ret = -1;
 				}
 
-				evsel = perf_evsel__next(evsel);
+				evsel = evsel__next(evsel);
 			}
 		}
 	}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 8d0c04855511..5b90ee3eda71 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -468,7 +468,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 
 	/* syscalls:sys_enter_openat:k */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_TRACEPOINT == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong sample_type",
 		PERF_TP_SAMPLE_TYPE == evsel->core.attr.sample_type);
@@ -479,7 +479,7 @@ static int test__checkevent_list(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 
 	/* 1:1:hp */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 1 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
@@ -501,7 +501,7 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "krava"));
 
 	/* cpu/config=2/u" */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
@@ -529,7 +529,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->core.attr.sample_type));
 
 	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
 	/*
@@ -577,7 +577,7 @@ static int test__checkevent_pmu_events_mix(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
 	/* cpu/pmu-event/u*/
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong exclude_user",
@@ -658,7 +658,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cycles:upp */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -700,7 +700,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cache-references + :u modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_REFERENCES == evsel->core.attr.config);
@@ -715,7 +715,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cycles:k */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -758,7 +758,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* group1 cycles:kppp */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -775,7 +775,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* group2 cycles + G modifier */
-	evsel = leader = perf_evsel__next(evsel);
+	evsel = leader = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -793,7 +793,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* group2 1:3 + G modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", 1 == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config", 3 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
@@ -807,7 +807,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions:u */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -849,7 +849,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions:kp + p */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -892,7 +892,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions + G */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -907,7 +907,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cycles:G */
-	evsel = leader = perf_evsel__next(evsel);
+	evsel = leader = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -924,7 +924,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions:G */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_INSTRUCTIONS == evsel->core.attr.config);
@@ -938,7 +938,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
 
 	/* cycles */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
@@ -977,7 +977,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:G + :H group modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1017,7 +1017,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :G group modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1057,7 +1057,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :u group modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1097,7 +1097,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :uG group modifier */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1135,7 +1135,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	/* cache-misses - not sampling */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
@@ -1149,7 +1149,7 @@ static int test__leader_sample1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	/* branch-misses - not sampling */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
@@ -1188,7 +1188,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong sample_read", evsel->sample_read);
 
 	/* branch-misses - not sampling */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
@@ -1234,14 +1234,14 @@ static int test__pinned_group(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
 
 	/* cache-misses - can not be pinned, but will go on with the leader */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_CACHE_MISSES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
 
 	/* branch-misses - ditto */
-	evsel = perf_evsel__next(evsel);
+	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong config",
 			PERF_COUNT_HW_BRANCH_MISSES == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 2936697bb696..f98a118dfc49 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3512,13 +3512,13 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 				if (pos->core.node.next == &evlist->core.entries)
 					pos = evlist__first(evlist);
 				else
-					pos = perf_evsel__next(pos);
+					pos = evsel__next(pos);
 				goto browse_hists;
 			case K_UNTAB:
 				if (pos->core.node.prev == &evlist->core.entries)
 					pos = evlist__last(evlist);
 				else
-					pos = perf_evsel__prev(pos);
+					pos = evsel__prev(pos);
 				goto browse_hists;
 			case K_SWITCH_INPUT_DATA:
 			case K_RELOAD:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4b5a411c403c..a84a4f6bcf31 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -299,12 +299,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 				  u64 *timestamp);
 
-static inline struct evsel *perf_evsel__next(struct evsel *evsel)
+static inline struct evsel *evsel__next(struct evsel *evsel)
 {
 	return list_entry(evsel->core.node.next, struct evsel, core.node);
 }
 
-static inline struct evsel *perf_evsel__prev(struct evsel *evsel)
+static inline struct evsel *evsel__prev(struct evsel *evsel)
 {
 	return list_entry(evsel->core.node.prev, struct evsel, core.node);
 }
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index dc15ddc18b7d..dc23b349fff9 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2354,7 +2354,7 @@ static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
 
 		evsel = evlist__first(evlist);
 		while (--nr > 0)
-			evsel = perf_evsel__next(evsel);
+			evsel = evsel__next(evsel);
 
 		return evsel;
 	}
-- 
2.21.1
