From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/12] perf pmu: Fix pmu events parsing rule
Date: Wed, 25 Apr 2018 13:00:01 -0300
Message-ID: <20180425160008.3407-6-acme@kernel.org>
References: <20180425160008.3407-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425160008.3407-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently all the event parsing fails end up in the event_pmu rule, and
display misleading help like:

  $ perf stat -e inst kill
  event syntax error: 'inst'
                       \___ Cannot find PMU `inst'. Missing kernel support?
  ...

The reason is that the event_pmu is too strong and match also single
string. Changing it to force the '/' separators to be part of the rule,
and getting the proper error now:

  $ perf stat -e inst kill
  event syntax error: 'inst'
                       \___ parser error
  Run 'perf list' for a list of valid events
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 7afeb80cc39e..d14464c42714 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -224,15 +224,15 @@ event_def: event_pmu |
 	   event_bpf_file
 
 event_pmu:
-PE_NAME opt_event_config
+PE_NAME '/' event_config '/'
 {
 	struct list_head *list, *orig_terms, *terms;
 
-	if (parse_events_copy_term_list($2, &orig_terms))
+	if (parse_events_copy_term_list($3, &orig_terms))
 		YYABORT;
 
 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $3, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 		char *pattern;
@@ -262,7 +262,7 @@ PE_NAME opt_event_config
 		if (!ok)
 			YYABORT;
 	}
-	parse_events_terms__delete($2);
+	parse_events_terms__delete($3);
 	parse_events_terms__delete(orig_terms);
 	$$ = list;
 }
-- 
2.14.3
