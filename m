From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 51/77] perf stat: Use 'evsel->evlist' instead of 'evsel_list' in collect_all_aliases()
Date: Wed,  5 Sep 2018 19:04:14 -0300
Message-ID: <20180905220440.20256-52-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Use 'evsel->evlist' instead of 'evsel_list' in collect_all_aliases(), to
get rid of the global 'evsel_list' variable dependency.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 46181ac492c5..11741f3a8342 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1154,10 +1154,11 @@ static void collect_all_aliases(struct perf_evsel *counter,
 				       bool first),
 			    void *data)
 {
+	struct perf_evlist *evlist = counter->evlist;
 	struct perf_evsel *alias;
 
-	alias = list_prepare_entry(counter, &(evsel_list->entries), node);
-	list_for_each_entry_continue (alias, &evsel_list->entries, node) {
+	alias = list_prepare_entry(counter, &(evlist->entries), node);
+	list_for_each_entry_continue (alias, &evlist->entries, node) {
 		if (strcmp(perf_evsel__name(alias), perf_evsel__name(counter)) ||
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
-- 
2.14.4
