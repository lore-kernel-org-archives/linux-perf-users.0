From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/13] perf events parse: Use just one parse events state struct
Date: Mon, 21 Aug 2017 16:25:42 -0300
Message-ID: <20170821192549.17251-7-acme@kernel.org>
References: <20170821192549.17251-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821192549.17251-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Andi reported problems when parse errors were detected with vendor
events (json), because in the yyparse/parse_events_parse function we
dereferenced the _data parameter to two different structs, with
different layouts, which ended up making parse_events_evlist->error to
point to random stack addresses.

Fix it by making _data to always be struct parse_events_state, changing
the only place where 'struct parse_events_term' was used in
parse_events.y.

Reported-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-bc27lshz823hxl8n9nkelcgh@git.kernel.org
Fixes: 90e2b22dee90 ("perf/tool: Add support to reuse event grammar to parse out terms")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 2 +-
 tools/perf/util/parse-events.h | 5 +----
 tools/perf/util/parse-events.y | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 272eab7f5ac8..d4fcf048aa9e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1656,7 +1656,7 @@ static int parse_events__scanner(const char *str, void *data, int start_token)
  */
 int parse_events_terms(struct list_head *terms, const char *str)
 {
-	struct parse_events_terms data = {
+	struct parse_events_state data = {
 		.terms = NULL,
 	};
 	int ret;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 8fff8423469b..2a3617937894 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -114,10 +114,7 @@ struct parse_events_state {
 	int			   nr_groups;
 	struct parse_events_error *error;
 	struct perf_evlist	  *evlist;
-};
-
-struct parse_events_terms {
-	struct list_head *terms;
+	struct list_head	  *terms;
 };
 
 void parse_events__shrink_config_terms(void);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 403a221266b8..4b37546e4914 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -488,7 +488,7 @@ opt_event_config:
 
 start_terms: event_config
 {
-	struct parse_events_terms *data = _data;
+	struct parse_events_state *data = _data;
 	data->terms = $1;
 }
 
-- 
2.13.5
