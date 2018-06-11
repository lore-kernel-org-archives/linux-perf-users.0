From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/12] perf tools: Fix error index for pmu event parser
Date: Mon, 11 Jun 2018 14:48:03 -0300
Message-ID: <20180611174810.14815-6-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

For events we provide specific error message we need to set error column
index, PMU parser is missing that, adding it.

Before:

  $ perf stat -e cycles,krava/cycles/ kill
  event syntax error: 'cycles,krava/cycles/'
                       \___ Cannot find PMU `krava'. Missing kernel support?

After:

  $ perf stat -e cycles,krava/cycles/ kill
  event syntax error: 'cycles,krava/cycles/'
                              \___ Cannot find PMU `krava'. Missing kernel support?

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 155d2570274f..da8fe57691b8 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -227,11 +227,16 @@ event_def: event_pmu |
 event_pmu:
 PE_NAME opt_pmu_config
 {
+	struct parse_events_state *parse_state = _parse_state;
+	struct parse_events_error *error = parse_state->error;
 	struct list_head *list, *orig_terms, *terms;
 
 	if (parse_events_copy_term_list($2, &orig_terms))
 		YYABORT;
 
+	if (error)
+		error->idx = @1.first_column;
+
 	ALLOC_LIST(list);
 	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
 		struct perf_pmu *pmu = NULL;
-- 
2.14.3
