From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/13] perf events parse: Remove some needless local variables
Date: Mon, 21 Aug 2017 16:25:40 -0300
Message-ID: <20170821192549.17251-5-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those are just casting a void pointer to a struct to then pass them to
functions, i.e. remove the local variables and pass the void pointer
directly, the casting will be done and the code will be shorter.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-bzfodzr3mb46gy7u7v0mqad6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 04fd8c9af9f9..96c0fa59aa8f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -225,14 +225,13 @@ event_def: event_pmu |
 event_pmu:
 PE_NAME opt_event_config
 {
-	struct parse_events_evlist *data = _data;
 	struct list_head *list, *orig_terms, *terms;
 
 	if (parse_events_copy_term_list($2, &orig_terms))
 		YYABORT;
 
 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(data, list, $1, $2)) {
+	if (parse_events_add_pmu(_data, list, $1, $2)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
@@ -245,7 +244,7 @@ PE_NAME opt_event_config
 			if (!strncmp($1, name, strlen($1))) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					YYABORT;
-				if (!parse_events_add_pmu(data, list, pmu->name, terms))
+				if (!parse_events_add_pmu(_data, list, pmu->name, terms))
 					ok++;
 				parse_events_terms__delete(terms);
 			}
@@ -286,26 +285,24 @@ PE_VALUE_SYM_SW
 event_legacy_symbol:
 value_sym '/' event_config '/'
 {
-	struct parse_events_evlist *data = _data;
 	struct list_head *list;
 	int type = $1 >> 16;
 	int config = $1 & 255;
 
 	ALLOC_LIST(list);
-	ABORT_ON(parse_events_add_numeric(data, list, type, config, $3));
+	ABORT_ON(parse_events_add_numeric(_data, list, type, config, $3));
 	parse_events_terms__delete($3);
 	$$ = list;
 }
 |
 value_sym sep_slash_dc
 {
-	struct parse_events_evlist *data = _data;
 	struct list_head *list;
 	int type = $1 >> 16;
 	int config = $1 & 255;
 
 	ALLOC_LIST(list);
-	ABORT_ON(parse_events_add_numeric(data, list, type, config, NULL));
+	ABORT_ON(parse_events_add_numeric(_data, list, type, config, NULL));
 	$$ = list;
 }
 
@@ -432,11 +429,10 @@ PE_NAME ':' PE_NAME
 event_legacy_numeric:
 PE_VALUE ':' PE_VALUE opt_event_config
 {
-	struct parse_events_evlist *data = _data;
 	struct list_head *list;
 
 	ALLOC_LIST(list);
-	ABORT_ON(parse_events_add_numeric(data, list, (u32)$1, $3, $4));
+	ABORT_ON(parse_events_add_numeric(_data, list, (u32)$1, $3, $4));
 	parse_events_terms__delete($4);
 	$$ = list;
 }
@@ -444,11 +440,10 @@ PE_VALUE ':' PE_VALUE opt_event_config
 event_legacy_raw:
 PE_RAW opt_event_config
 {
-	struct parse_events_evlist *data = _data;
 	struct list_head *list;
 
 	ALLOC_LIST(list);
-	ABORT_ON(parse_events_add_numeric(data, list, PERF_TYPE_RAW, $1, $2));
+	ABORT_ON(parse_events_add_numeric(_data, list, PERF_TYPE_RAW, $1, $2));
 	parse_events_terms__delete($2);
 	$$ = list;
 }
@@ -468,11 +463,10 @@ PE_BPF_OBJECT opt_event_config
 |
 PE_BPF_SOURCE opt_event_config
 {
-	struct parse_events_evlist *data = _data;
 	struct list_head *list;
 
 	ALLOC_LIST(list);
-	ABORT_ON(parse_events_load_bpf(data, list, $1, true, $2));
+	ABORT_ON(parse_events_load_bpf(_data, list, $1, true, $2));
 	parse_events_terms__delete($2);
 	$$ = list;
 }
-- 
2.13.5
