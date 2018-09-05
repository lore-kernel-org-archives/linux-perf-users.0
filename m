From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/77] perf tools: Switch 'session' argument to 'evlist' in perf_event__synthesize_attrs()
Date: Wed,  5 Sep 2018 19:03:54 -0300
Message-ID: <20180905220440.20256-32-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To be able to pass in other than session's evlist.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-stat.c   | 2 +-
 tools/perf/util/header.c    | 6 +++---
 tools/perf/util/header.h    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 22ebeb92ac51..9853552bcf16 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -758,7 +758,7 @@ static int record__synthesize(struct record *rec, bool tail)
 		 * We need to synthesize events first, because some
 		 * features works on top of them (on report side).
 		 */
-		err = perf_event__synthesize_attrs(tool, session,
+		err = perf_event__synthesize_attrs(tool, rec->evlist,
 						   process_synthesized_event);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 48c88f568fe1..8291f503d0cc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -459,7 +459,7 @@ static int perf_stat_synthesize_config(bool is_pipe)
 	int err;
 
 	if (is_pipe) {
-		err = perf_event__synthesize_attrs(NULL, perf_stat.session,
+		err = perf_event__synthesize_attrs(NULL, evsel_list,
 						   process_synthesized_event);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3cadc252dd89..91e6d9cfd906 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3637,13 +3637,13 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 }
 
 int perf_event__synthesize_attrs(struct perf_tool *tool,
-				   struct perf_session *session,
-				   perf_event__handler_t process)
+				 struct perf_evlist *evlist,
+				 perf_event__handler_t process)
 {
 	struct perf_evsel *evsel;
 	int err = 0;
 
-	evlist__for_each_entry(session->evlist, evsel) {
+	evlist__for_each_entry(evlist, evsel) {
 		err = perf_event__synthesize_attr(tool, &evsel->attr, evsel->ids,
 						  evsel->id, process);
 		if (err) {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 6d7fe44aadc0..ff2a1263fb9b 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -124,7 +124,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool,
 				struct perf_event_attr *attr, u32 ids, u64 *id,
 				perf_event__handler_t process);
 int perf_event__synthesize_attrs(struct perf_tool *tool,
-				 struct perf_session *session,
+				 struct perf_evlist *evlist,
 				 perf_event__handler_t process);
 int perf_event__synthesize_event_update_unit(struct perf_tool *tool,
 					     struct perf_evsel *evsel,
-- 
2.14.4
