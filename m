From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 67/91] perf evsel: Rename perf_evsel__is_*() to evsel__is*()
Date: Wed,  6 May 2020 12:22:10 -0300
Message-ID: <20200506152234.21977-68-acme@kernel.org>
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
 tools/perf/builtin-annotate.c           |  3 +--
 tools/perf/builtin-diff.c               |  2 +-
 tools/perf/builtin-report.c             |  8 +++---
 tools/perf/builtin-script.c             |  2 +-
 tools/perf/builtin-top.c                |  3 +--
 tools/perf/builtin-trace.c              |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c |  4 +--
 tools/perf/tests/parse-events.c         | 28 +++++++++----------
 tools/perf/ui/browsers/hists.c          |  6 ++---
 tools/perf/ui/gtk/annotate.c            |  2 +-
 tools/perf/ui/gtk/hists.c               |  2 +-
 tools/perf/ui/hist.c                    |  6 ++---
 tools/perf/util/annotate.c              | 10 +++----
 tools/perf/util/auxtrace.c              |  8 +++---
 tools/perf/util/bpf-loader.c            |  2 +-
 tools/perf/util/data-convert-bt.c       |  4 +--
 tools/perf/util/evlist.c                |  8 +++---
 tools/perf/util/evsel.c                 | 28 +++++++++----------
 tools/perf/util/evsel.h                 | 29 ++++++++++----------
 tools/perf/util/evsel_fprintf.c         |  2 +-
 tools/perf/util/header.c                |  6 ++---
 tools/perf/util/hist.c                  |  2 +-
 tools/perf/util/parse-events.c          |  6 ++---
 tools/perf/util/stat-display.c          |  2 +-
 tools/perf/util/stat-shadow.c           | 36 ++++++++++++-------------
 tools/perf/util/stat.c                  |  2 +-
 26 files changed, 103 insertions(+), 110 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index e0fbc13884df..b0e5a30755ce 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -436,8 +436,7 @@ static int __cmd_annotate(struct perf_annotate *ann)
 			evsel__reset_sample_bit(pos, CALLCHAIN);
 			perf_evsel__output_resort(pos, NULL);
 
-			if (symbol_conf.event_group &&
-			    !perf_evsel__is_group_leader(pos))
+			if (symbol_conf.event_group && !evsel__is_group_leader(pos))
 				continue;
 
 			hists__find_annotations(hists, pos, ann);
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 67d3adadcd5b..f8c9bdd8269a 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -467,7 +467,7 @@ static struct evsel *evsel_match(struct evsel *evsel,
 	struct evsel *e;
 
 	evlist__for_each_entry(evlist, e) {
-		if (perf_evsel__match2(evsel, e))
+		if (evsel__match2(evsel, e))
 			return e;
 	}
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index e00f6244cbda..ba63390246c2 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -459,7 +459,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 		nr_events = hists->stats.total_non_filtered_period;
 	}
 
-	if (perf_evsel__is_group_event(evsel)) {
+	if (evsel__is_group_event(evsel)) {
 		struct evsel *pos;
 
 		evsel__group_desc(evsel, buf, size);
@@ -539,8 +539,7 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 		struct hists *hists = evsel__hists(pos);
 		const char *evname = evsel__name(pos);
 
-		if (symbol_conf.event_group &&
-		    !perf_evsel__is_group_leader(pos))
+		if (symbol_conf.event_group && !evsel__is_group_leader(pos))
 			continue;
 
 		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
@@ -682,8 +681,7 @@ static int report__collapse_hists(struct report *rep)
 			break;
 
 		/* Non-group events are considered as leader */
-		if (symbol_conf.event_group &&
-		    !perf_evsel__is_group_leader(pos)) {
+		if (symbol_conf.event_group && !evsel__is_group_leader(pos)) {
 			struct hists *leader_hists = evsel__hists(pos->leader);
 
 			hists__match(leader_hists, hists);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8ca24e307266..fee56474377b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1948,7 +1948,7 @@ static void process_event(struct perf_script *script,
 	else if (PRINT_FIELD(BRSTACKOFF))
 		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
 
-	if (perf_evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
+	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
 	perf_sample__fprintf_insn(sample, attr, thread, machine, fp);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 55edab99b05d..4403a76f2047 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -298,8 +298,7 @@ static void perf_top__resort_hists(struct perf_top *t)
 		hists__collapse_resort(hists, NULL);
 
 		/* Non-group events are considered as leader */
-		if (symbol_conf.event_group &&
-		    !perf_evsel__is_group_leader(pos)) {
+		if (symbol_conf.event_group && !evsel__is_group_leader(pos)) {
 			struct hists *leader_hists = evsel__hists(pos->leader);
 
 			hists__match(leader_hists, hists);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 871d43d68a1b..025e190fd1c2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2774,7 +2774,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 	fprintf(trace->output, "%s(", evsel->name);
 
-	if (perf_evsel__is_bpf_output(evsel)) {
+	if (evsel__is_bpf_output(evsel)) {
 		bpf_output__fprintf(trace, sample);
 	} else if (evsel->tp_format) {
 		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index f052851bad93..f143de12e38a 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -20,7 +20,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
 		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
 			/* skip invalid cache type */
-			if (!perf_evsel__is_cache_op_valid(type, op))
+			if (!evsel__is_cache_op_valid(type, op))
 				continue;
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
@@ -38,7 +38,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
 		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
 			/* skip invalid cache type */
-			if (!perf_evsel__is_cache_op_valid(type, op))
+			if (!evsel__is_cache_op_valid(type, op))
 				continue;
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 732dde22ab4e..8d0c04855511 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -652,7 +652,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
@@ -694,7 +694,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
@@ -725,7 +725,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	return 0;
@@ -750,7 +750,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong group name",
 		!strcmp(leader->group_name, "group1"));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
@@ -785,7 +785,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong group name",
 		!strcmp(leader->group_name, "group2"));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
@@ -817,7 +817,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	return 0;
@@ -843,7 +843,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
@@ -886,7 +886,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
@@ -918,7 +918,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
@@ -948,7 +948,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 
 	return 0;
 }
@@ -972,7 +972,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
@@ -1012,7 +1012,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
@@ -1052,7 +1052,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
@@ -1092,7 +1092,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong leader", perf_evsel__is_group_leader(evsel));
+	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
 	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 1ad64ca4e21b..2936697bb696 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3424,7 +3424,7 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 	ui_browser__set_color(browser, current_entry ? HE_COLORSET_SELECTED :
 						       HE_COLORSET_NORMAL);
 
-	if (perf_evsel__is_group_event(evsel)) {
+	if (evsel__is_group_event(evsel)) {
 		struct evsel *pos;
 
 		ev_name = evsel__group_name(evsel);
@@ -3554,7 +3554,7 @@ static bool filter_group_entries(struct ui_browser *browser __maybe_unused,
 {
 	struct evsel *evsel = list_entry(entry, struct evsel, core.node);
 
-	if (symbol_conf.event_group && !perf_evsel__is_group_leader(evsel))
+	if (symbol_conf.event_group && !evsel__is_group_leader(evsel))
 		return true;
 
 	return false;
@@ -3622,7 +3622,7 @@ int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
 
 		nr_entries = 0;
 		evlist__for_each_entry(evlist, pos) {
-			if (perf_evsel__is_group_leader(pos))
+			if (evsel__is_group_leader(pos))
 				nr_entries++;
 		}
 
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 35f9641bf670..a7dff77f2018 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -130,7 +130,7 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
 
 		gtk_list_store_append(store, &iter);
 
-		if (perf_evsel__is_group_event(evsel)) {
+		if (evsel__is_group_event(evsel)) {
 			for (i = 0; i < evsel->core.nr_members; i++) {
 				ret += perf_gtk__get_percent(s + ret,
 							     sizeof(s) - ret,
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 40b52ae6ca6a..53ef71a1b15d 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -642,7 +642,7 @@ int perf_evlist__gtk_browse_hists(struct evlist *evlist,
 		size_t size = sizeof(buf);
 
 		if (symbol_conf.event_group) {
-			if (!perf_evsel__is_group_leader(pos))
+			if (!evsel__is_group_leader(pos))
 				continue;
 
 			if (pos->core.nr_members > 1) {
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 025f4c7f96bf..1a83614901a4 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -43,7 +43,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 	} else
 		ret = hpp__call_print_fn(hpp, print_fn, fmt, len, get_field(he));
 
-	if (perf_evsel__is_group_event(evsel)) {
+	if (evsel__is_group_event(evsel)) {
 		int prev_idx, idx_delta;
 		struct hist_entry *pair;
 		int nr_members = evsel->core.nr_members;
@@ -190,7 +190,7 @@ static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
 	int cmp, nr_members, ret, i;
 
 	cmp = field_cmp(get_field(a), get_field(b));
-	if (!perf_evsel__is_group_event(evsel))
+	if (!evsel__is_group_event(evsel))
 		return cmp;
 
 	nr_members = evsel->core.nr_members;
@@ -240,7 +240,7 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		return ret;
 
 	evsel = hists_to_evsel(a->hists);
-	if (!perf_evsel__is_group_event(evsel))
+	if (!evsel__is_group_event(evsel))
 		return ret;
 
 	nr_members = evsel->core.nr_members;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7d03563b608b..dc3342f5586b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1191,7 +1191,7 @@ static struct disasm_line *disasm_line__new(struct annotate_args *args)
 	struct disasm_line *dl = NULL;
 	int nr = 1;
 
-	if (perf_evsel__is_group_event(args->evsel))
+	if (evsel__is_group_event(args->evsel))
 		nr = args->evsel->core.nr_members;
 
 	dl = zalloc(disasm_line_size(nr));
@@ -1437,7 +1437,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 		if (queue)
 			return -1;
 
-		if (perf_evsel__is_group_event(evsel))
+		if (evsel__is_group_event(evsel))
 			width *= evsel->core.nr_members;
 
 		if (!*al->line)
@@ -2368,7 +2368,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 
 	len = symbol__size(sym);
 
-	if (perf_evsel__is_group_event(evsel)) {
+	if (evsel__is_group_event(evsel)) {
 		width *= evsel->core.nr_members;
 		evsel__group_desc(evsel, buf, sizeof(buf));
 		evsel_name = buf;
@@ -2518,7 +2518,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 	if (fp == NULL)
 		goto out_free_filename;
 
-	if (perf_evsel__is_group_event(evsel)) {
+	if (evsel__is_group_event(evsel)) {
 		evsel__group_desc(evsel, buf, sizeof(buf));
 		ev_name = buf;
 	}
@@ -3064,7 +3064,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	if (notes->offsets == NULL)
 		return ENOMEM;
 
-	if (perf_evsel__is_group_event(evsel))
+	if (evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
 
 	err = symbol__annotate(ms, evsel, options, parch);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c22ef2e3e079..749487a41cc7 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -70,7 +70,7 @@ static int perf_evlist__regroup(struct evlist *evlist,
 	struct evsel *evsel;
 	bool grp;
 
-	if (!perf_evsel__is_group_leader(leader))
+	if (!evsel__is_group_leader(leader))
 		return -EINVAL;
 
 	grp = false;
@@ -685,7 +685,7 @@ static int auxtrace_validate_aux_sample_size(struct evlist *evlist,
 
 	evlist__for_each_entry(evlist, evsel) {
 		sz = evsel->core.attr.aux_sample_size;
-		if (perf_evsel__is_group_leader(evsel)) {
+		if (evsel__is_group_leader(evsel)) {
 			has_aux_leader = evsel__is_aux_event(evsel);
 			if (sz) {
 				if (has_aux_leader)
@@ -759,7 +759,7 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 
 	/* Set aux_sample_size based on --aux-sample option */
 	evlist__for_each_entry(evlist, evsel) {
-		if (perf_evsel__is_group_leader(evsel)) {
+		if (evsel__is_group_leader(evsel)) {
 			has_aux_leader = evsel__is_aux_event(evsel);
 		} else if (has_aux_leader) {
 			evsel->core.attr.aux_sample_size = sz;
@@ -1247,7 +1247,7 @@ static void unleader_auxtrace(struct perf_session *session)
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (auxtrace__evsel_is_auxtrace(session, evsel) &&
-		    perf_evsel__is_group_leader(evsel)) {
+		    evsel__is_group_leader(evsel)) {
 			unleader_evsel(session->evlist, evsel);
 		}
 	}
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 10c187b8b8ea..83bfb8768235 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1430,7 +1430,7 @@ apply_config_evsel_for_key(const char *name, int map_fd, void *pkey,
 		return -BPF_LOADER_ERRNO__OBJCONF_MAP_EVTINH;
 	}
 
-	if (perf_evsel__is_bpf_output(evsel))
+	if (evsel__is_bpf_output(evsel))
 		check_pass = true;
 	if (attr->type == PERF_TYPE_RAW)
 		check_pass = true;
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 54c345e7b308..5f36fc6a5578 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -835,7 +835,7 @@ static int process_sample_event(struct perf_tool *tool,
 			return -1;
 	}
 
-	if (perf_evsel__is_bpf_output(evsel)) {
+	if (evsel__is_bpf_output(evsel)) {
 		ret = add_bpf_output_values(event_class, event, sample);
 		if (ret)
 			return -1;
@@ -1174,7 +1174,7 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
 			goto err;
 	}
 
-	if (perf_evsel__is_bpf_output(evsel)) {
+	if (evsel__is_bpf_output(evsel)) {
 		ret = add_bpf_output_types(cw, event_class);
 		if (ret)
 			goto err;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 410cd834c39a..404542b69543 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -391,14 +391,14 @@ void evlist__disable(struct evlist *evlist)
 		evlist__for_each_entry(evlist, pos) {
 			if (evsel__cpu_iter_skip(pos, cpu))
 				continue;
-			if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
 				continue;
 			evsel__disable_cpu(pos, pos->cpu_iter - 1);
 		}
 	}
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
-		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
+		if (!evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
 		pos->disabled = true;
 	}
@@ -421,14 +421,14 @@ void evlist__enable(struct evlist *evlist)
 		evlist__for_each_entry(evlist, pos) {
 			if (evsel__cpu_iter_skip(pos, cpu))
 				continue;
-			if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
+			if (!evsel__is_group_leader(pos) || !pos->core.fd)
 				continue;
 			evsel__enable_cpu(pos, pos->cpu_iter - 1);
 		}
 	}
 	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
-		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
+		if (!evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
 		pos->disabled = false;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index aedd554fb4bb..ded511c8def3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -217,14 +217,14 @@ void evsel__set_sample_id(struct evsel *evsel,
 }
 
 /**
- * perf_evsel__is_function_event - Return whether given evsel is a function
+ * evsel__is_function_event - Return whether given evsel is a function
  * trace event
  *
  * @evsel - evsel selector to be tested
  *
  * Return %true if event is function trace event
  */
-bool perf_evsel__is_function_event(struct evsel *evsel)
+bool evsel__is_function_event(struct evsel *evsel)
 {
 #define FUNCTION_EVENT "ftrace:function"
 
@@ -267,13 +267,13 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 		return NULL;
 	evsel__init(evsel, attr, idx);
 
-	if (perf_evsel__is_bpf_output(evsel)) {
+	if (evsel__is_bpf_output(evsel)) {
 		evsel->core.attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
 					    PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
 		evsel->core.attr.sample_period = 1;
 	}
 
-	if (perf_evsel__is_clock(evsel)) {
+	if (evsel__is_clock(evsel)) {
 		/*
 		 * The evsel->unit points to static alias->unit
 		 * so it's ok to use static string in here.
@@ -531,7 +531,7 @@ static unsigned long perf_evsel__hw_cache_stat[C(MAX)] = {
  [C(NODE)]	= (CACHE_READ | CACHE_WRITE | CACHE_PREFETCH),
 };
 
-bool perf_evsel__is_cache_op_valid(u8 type, u8 op)
+bool evsel__is_cache_op_valid(u8 type, u8 op)
 {
 	if (perf_evsel__hw_cache_stat[type] & COP(op))
 		return true;	/* valid */
@@ -570,7 +570,7 @@ static int __evsel__hw_cache_name(u64 config, char *bf, size_t size)
 		goto out_err;
 
 	err = "invalid-cache";
-	if (!perf_evsel__is_cache_op_valid(type, op))
+	if (!evsel__is_cache_op_valid(type, op))
 		goto out_err;
 
 	return __evsel__hw_cache_type_op_res_name(type, op, result, bf, size);
@@ -686,7 +686,7 @@ int evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
 				      struct callchain_param *param)
 {
-	bool function = perf_evsel__is_function_event(evsel);
+	bool function = evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
 
 	evsel__set_sample_bit(evsel, CALLCHAIN);
@@ -1018,7 +1018,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 * event, due to issues with page faults while tracing page
 	 * fault handler and its overall trickiness nature.
 	 */
-	if (perf_evsel__is_function_event(evsel))
+	if (evsel__is_function_event(evsel))
 		evsel->core.attr.exclude_callchain_user = 1;
 
 	if (callchain && callchain->enabled && !evsel->no_aux_samples)
@@ -1103,15 +1103,15 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	 * Disabling only independent events or group leaders,
 	 * keeping group members enabled.
 	 */
-	if (perf_evsel__is_group_leader(evsel))
+	if (evsel__is_group_leader(evsel))
 		attr->disabled = 1;
 
 	/*
 	 * Setting enable_on_exec for independent events and
 	 * group leaders for traced executed by perf.
 	 */
-	if (target__none(&opts->target) && perf_evsel__is_group_leader(evsel) &&
-		!opts->initial_delay)
+	if (target__none(&opts->target) && evsel__is_group_leader(evsel) &&
+	    !opts->initial_delay)
 		attr->enable_on_exec = 1;
 
 	if (evsel->immediate) {
@@ -1389,7 +1389,7 @@ perf_evsel__read_group(struct evsel *leader, int cpu, int thread)
 	if (!(read_format & PERF_FORMAT_ID))
 		return -EINVAL;
 
-	if (!perf_evsel__is_group_leader(leader))
+	if (!evsel__is_group_leader(leader))
 		return -EINVAL;
 
 	if (!data) {
@@ -1445,7 +1445,7 @@ static int get_group_fd(struct evsel *evsel, int cpu, int thread)
 	struct evsel *leader = evsel->leader;
 	int fd;
 
-	if (perf_evsel__is_group_leader(evsel))
+	if (evsel__is_group_leader(evsel))
 		return -1;
 
 	/*
@@ -1829,7 +1829,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	} else if (!perf_missing_features.group_read &&
 		    evsel->core.attr.inherit &&
 		   (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
-		   perf_evsel__is_group_leader(evsel)) {
+		   evsel__is_group_leader(evsel)) {
 		perf_missing_features.group_read = true;
 		pr_debug2_peo("switching off group read\n");
 		goto fallback_missing_features;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d83f7007d6d7..4246cadaf96e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -196,7 +196,7 @@ void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
 int __evsel__sample_size(u64 sample_type);
 void evsel__calc_id_pos(struct evsel *evsel);
 
-bool perf_evsel__is_cache_op_valid(u8 type, u8 op);
+bool evsel__is_cache_op_valid(u8 type, u8 op);
 
 #define PERF_EVSEL__MAX_ALIASES 8
 
@@ -255,12 +255,11 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
 
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
 
-#define perf_evsel__match(evsel, t, c)		\
+#define evsel__match(evsel, t, c)		\
 	(evsel->core.attr.type == PERF_TYPE_##t &&	\
 	 evsel->core.attr.config == PERF_COUNT_##c)
 
-static inline bool perf_evsel__match2(struct evsel *e1,
-				      struct evsel *e2)
+static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
 {
 	return (e1->core.attr.type == e2->core.attr.type) &&
 	       (e1->core.attr.config == e2->core.attr.config);
@@ -321,44 +320,44 @@ static inline struct evsel *perf_evsel__prev(struct evsel *evsel)
 }
 
 /**
- * perf_evsel__is_group_leader - Return whether given evsel is a leader event
+ * evsel__is_group_leader - Return whether given evsel is a leader event
  *
  * @evsel - evsel selector to be tested
  *
  * Return %true if @evsel is a group leader or a stand-alone event
  */
-static inline bool perf_evsel__is_group_leader(const struct evsel *evsel)
+static inline bool evsel__is_group_leader(const struct evsel *evsel)
 {
 	return evsel->leader == evsel;
 }
 
 /**
- * perf_evsel__is_group_event - Return whether given evsel is a group event
+ * evsel__is_group_event - Return whether given evsel is a group event
  *
  * @evsel - evsel selector to be tested
  *
  * Return %true iff event group view is enabled and @evsel is a actual group
  * leader which has other members in the group
  */
-static inline bool perf_evsel__is_group_event(struct evsel *evsel)
+static inline bool evsel__is_group_event(struct evsel *evsel)
 {
 	if (!symbol_conf.event_group)
 		return false;
 
-	return perf_evsel__is_group_leader(evsel) && evsel->core.nr_members > 1;
+	return evsel__is_group_leader(evsel) && evsel->core.nr_members > 1;
 }
 
-bool perf_evsel__is_function_event(struct evsel *evsel);
+bool evsel__is_function_event(struct evsel *evsel);
 
-static inline bool perf_evsel__is_bpf_output(struct evsel *evsel)
+static inline bool evsel__is_bpf_output(struct evsel *evsel)
 {
-	return perf_evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
+	return evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
 }
 
-static inline bool perf_evsel__is_clock(struct evsel *evsel)
+static inline bool evsel__is_clock(struct evsel *evsel)
 {
-	return perf_evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
-	       perf_evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
+	return evsel__match(evsel, SOFTWARE, SW_CPU_CLOCK) ||
+	       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
 }
 
 bool perf_evsel__fallback(struct evsel *evsel, int err,
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index b4c3c7b52b2d..99aed708bd5a 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -44,7 +44,7 @@ int perf_evsel__fprintf(struct evsel *evsel,
 	if (details->event_group) {
 		struct evsel *pos;
 
-		if (!perf_evsel__is_group_leader(evsel))
+		if (!evsel__is_group_leader(evsel))
 			return 0;
 
 		if (evsel->core.nr_members > 1)
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 89031942a2a9..0ce47283a8a1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -783,8 +783,7 @@ static int write_group_desc(struct feat_fd *ff,
 		return ret;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (perf_evsel__is_group_leader(evsel) &&
-		    evsel->core.nr_members > 1) {
+		if (evsel__is_group_leader(evsel) && evsel->core.nr_members > 1) {
 			const char *name = evsel->group_name ?: "{anon_group}";
 			u32 leader_idx = evsel->idx;
 			u32 nr_members = evsel->core.nr_members;
@@ -1907,8 +1906,7 @@ static void print_group_desc(struct feat_fd *ff, FILE *fp)
 	session = container_of(ff->ph, struct perf_session, header);
 
 	evlist__for_each_entry(session->evlist, evsel) {
-		if (perf_evsel__is_group_leader(evsel) &&
-		    evsel->core.nr_members > 1) {
+		if (evsel__is_group_leader(evsel) && evsel->core.nr_members > 1) {
 			fprintf(fp, "# group: %s{%s", evsel->group_name ?: "", evsel__name(evsel));
 
 			nr = evsel->core.nr_members - 1;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index bce49ae97532..12b65d00cf65 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2695,7 +2695,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 		nr_events = hists->stats.total_non_filtered_period;
 	}
 
-	if (perf_evsel__is_group_event(evsel)) {
+	if (evsel__is_group_event(evsel)) {
 		struct evsel *pos;
 
 		evsel__group_desc(evsel, buf, buflen);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 899ced466197..b7a0518d607d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -461,7 +461,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
 			cache_op = parse_aliases(str, perf_evsel__hw_cache_op,
 						 PERF_COUNT_HW_CACHE_OP_MAX);
 			if (cache_op >= 0) {
-				if (!perf_evsel__is_cache_op_valid(cache_type, cache_op))
+				if (!evsel__is_cache_op_valid(cache_type, cache_op))
 					return -EINVAL;
 				continue;
 			}
@@ -1871,7 +1871,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 		evsel->precise_max         = mod.precise_max;
 		evsel->weak_group	   = mod.weak;
 
-		if (perf_evsel__is_group_leader(evsel))
+		if (evsel__is_group_leader(evsel))
 			evsel->core.attr.pinned = mod.pinned;
 	}
 
@@ -2627,7 +2627,7 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 	for (type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
 		for (op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
 			/* skip invalid cache type */
-			if (!perf_evsel__is_cache_op_valid(type, op))
+			if (!evsel__is_cache_op_valid(type, op))
 				continue;
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7f46e2837045..3c6976f7574c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -562,7 +562,7 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
 		    strcmp(alias->unit, counter->unit) ||
-		    perf_evsel__is_clock(alias) != perf_evsel__is_clock(counter) ||
+		    evsel__is_clock(alias) != evsel__is_clock(counter) ||
 		    !strcmp(alias->pmu_name, counter->pmu_name))
 			break;
 		alias->merged_stat = true;
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 518fbb3a6269..129b8c5f2538 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -216,9 +216,9 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 
 	count *= counter->scale;
 
-	if (perf_evsel__is_clock(counter))
+	if (evsel__is_clock(counter))
 		update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns);
-	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
+	else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
 		update_runtime_stat(st, STAT_CYCLES_IN_TX, ctx, cpu, count);
@@ -241,25 +241,25 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
 		update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
 				    ctx, cpu, count);
-	else if (perf_evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
+	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
 				    ctx, cpu, count);
-	else if (perf_evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
+	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_BACK,
 				    ctx, cpu, count);
-	else if (perf_evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
+	else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
 		update_runtime_stat(st, STAT_BRANCHES, ctx, cpu, count);
-	else if (perf_evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
+	else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
 		update_runtime_stat(st, STAT_CACHEREFS, ctx, cpu, count);
-	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
+	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
 		update_runtime_stat(st, STAT_L1_DCACHE, ctx, cpu, count);
-	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
+	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
 		update_runtime_stat(st, STAT_L1_ICACHE, ctx, cpu, count);
-	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_LL))
+	else if (evsel__match(counter, HW_CACHE, HW_CACHE_LL))
 		update_runtime_stat(st, STAT_LL_CACHE, ctx, cpu, count);
-	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
+	else if (evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
 		update_runtime_stat(st, STAT_DTLB_CACHE, ctx, cpu, count);
-	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
+	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
 		update_runtime_stat(st, STAT_ITLB_CACHE, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, SMI_NUM))
 		update_runtime_stat(st, STAT_SMI_NUM, ctx, cpu, count);
@@ -833,7 +833,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	struct metric_event *me;
 	int num = 1;
 
-	if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
+	if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
 		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
 
 		if (total) {
@@ -858,7 +858,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					"stalled cycles per insn",
 					ratio);
 		}
-	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
+	} else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
 		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
 			print_branch_misses(config, cpu, evsel, avg, out, st);
 		else
@@ -913,7 +913,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
-	} else if (perf_evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
+	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
 		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
 
 		if (total)
@@ -924,11 +924,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				     "of all cache refs", ratio);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all cache refs", 0);
-	} else if (perf_evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
+	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
 		print_stalled_cycles_frontend(config, cpu, evsel, avg, out, st);
-	} else if (perf_evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
+	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
 		print_stalled_cycles_backend(config, cpu, evsel, avg, out, st);
-	} else if (perf_evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
+	} else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
 		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
 
 		if (total) {
@@ -979,7 +979,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			ratio = total / avg;
 
 		print_metric(config, ctxp, NULL, "%8.0f", "cycles / elision", ratio);
-	} else if (perf_evsel__is_clock(evsel)) {
+	} else if (evsel__is_clock(evsel)) {
 		if ((ratio = avg_stats(&walltime_nsecs_stats)) != 0)
 			print_metric(config, ctxp, NULL, "%8.3f", "CPUs utilized",
 				     avg / (ratio * evsel->scale));
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 3520b7443615..774468341851 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -509,7 +509,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	 * either manually by us or by kernel via enable_on_exec
 	 * set later.
 	 */
-	if (perf_evsel__is_group_leader(evsel)) {
+	if (evsel__is_group_leader(evsel)) {
 		attr->disabled = 1;
 
 		/*
-- 
2.21.1
