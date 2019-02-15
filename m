From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/43] perf tools: Fix legacy events symbol separator parsing
Date: Thu, 14 Feb 2019 21:45:35 -0300
Message-ID: <20190215004539.23571-40-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Fixing legacy symbol events parsing. We can't support single slash
separator, like 'cycles/u', because it conflicts with non empty terms,
like 'cycles/period/u'.

Keeping only '//' and ':' separator for these events:
  cycles//u
  cycles:k

And removing '/' separator support, which is not working
anymore. Also adding automated tests for above events.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 30 ++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.y  |  4 ++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 3b97ac018d5a..4a69c07f4101 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1330,6 +1330,26 @@ static int test__checkevent_complex_name(struct perf_evlist *evlist)
 	return 0;
 }
 
+static int test__sym_event_slash(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel = perf_evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong type", evsel->attr.type == PERF_TYPE_HARDWARE);
+	TEST_ASSERT_VAL("wrong config", evsel->attr.config == PERF_COUNT_HW_CPU_CYCLES);
+	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
+	return 0;
+}
+
+static int test__sym_event_dc(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel = perf_evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong type", evsel->attr.type == PERF_TYPE_HARDWARE);
+	TEST_ASSERT_VAL("wrong config", evsel->attr.config == PERF_COUNT_HW_CPU_CYCLES);
+	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
+	return 0;
+}
+
 static int count_tracepoints(void)
 {
 	struct dirent *events_ent;
@@ -1670,6 +1690,16 @@ static struct evlist_test test__events[] = {
 		.name  = "cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
 		.check = test__checkevent_complex_name,
 		.id    = 53
+	},
+	{
+		.name  = "cycles//u",
+		.check = test__sym_event_slash,
+		.id    = 54,
+	},
+	{
+		.name  = "cycles:k",
+		.check = test__sym_event_dc,
+		.id    = 55,
 	}
 };
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index da8fe57691b8..44819bdb037d 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -311,7 +311,7 @@ value_sym '/' event_config '/'
 	$$ = list;
 }
 |
-value_sym sep_slash_dc
+value_sym sep_slash_slash_dc
 {
 	struct list_head *list;
 	int type = $1 >> 16;
@@ -702,7 +702,7 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
 
 sep_dc: ':' |
 
-sep_slash_dc: '/' | ':' |
+sep_slash_slash_dc: '/' '/' | ':' |
 
 %%
 
-- 
2.19.1
