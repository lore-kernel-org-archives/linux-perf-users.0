From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/91] perf bpf: Decouple creating the evlist from adding the SB event
Date: Wed,  6 May 2020 12:21:28 -0300
Message-ID: <20200506152234.21977-26-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Renaming bpf_event__add_sb_event() to evlist__add_sb_event() and
requiring that the evlist be allocated beforehand.

This will allow using the same side band thread and evlist to be used
for multiple purposes in addition to react to PERF_RECORD_BPF_EVENT soon
after they are generated.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200429131106.27974-4-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 17 ++++++++++++++---
 tools/perf/builtin-top.c    | 15 +++++++++++++--
 tools/perf/util/bpf-event.c |  3 +--
 tools/perf/util/bpf-event.h |  7 +++----
 tools/perf/util/evlist.c    | 21 ++++-----------------
 tools/perf/util/evlist.h    |  2 +-
 6 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a6d887d97ceb..5b6a1d23efe5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1573,16 +1573,27 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			goto out_child;
 	}
 
+	err = -1;
 	if (!rec->no_buildid
 	    && !perf_header__has_feat(&session->header, HEADER_BUILD_ID)) {
 		pr_err("Couldn't generate buildids. "
 		       "Use --no-buildid to profile anyway.\n");
-		err = -1;
 		goto out_child;
 	}
 
-	if (!opts->no_bpf_event)
-		bpf_event__add_sb_event(&rec->sb_evlist, &session->header.env);
+	if (!opts->no_bpf_event) {
+		rec->sb_evlist = evlist__new();
+
+		if (rec->sb_evlist == NULL) {
+			pr_err("Couldn't create side band evlist.\n.");
+			goto out_child;
+		}
+
+		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
+			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			goto out_child;
+		}
+	}
 
 	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 70e1c732db6a..de24aced7213 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1742,8 +1742,19 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
-	if (!top.record_opts.no_bpf_event)
-		bpf_event__add_sb_event(&top.sb_evlist, &perf_env);
+	if (!top.record_opts.no_bpf_event) {
+		top.sb_evlist = evlist__new();
+
+		if (top.sb_evlist == NULL) {
+			pr_err("Couldn't create side band evlist.\n.");
+			goto out_delete_evlist;
+		}
+
+		if (evlist__add_bpf_sb_event(top.sb_evlist, &perf_env)) {
+			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
+			goto out_delete_evlist;
+		}
+	}
 
 	if (perf_evlist__start_sb_thread(top.sb_evlist, target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 0cd41a862952..3742511a08d1 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -509,8 +509,7 @@ static int bpf_event__sb_cb(union perf_event *event, void *data)
 	return 0;
 }
 
-int bpf_event__add_sb_event(struct evlist **evlist,
-			    struct perf_env *env)
+int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env)
 {
 	struct perf_event_attr attr = {
 		.type	          = PERF_TYPE_SOFTWARE,
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 81fdc88e6c1a..68f315c3df5b 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -33,8 +33,7 @@ struct btf_node {
 #ifdef HAVE_LIBBPF_SUPPORT
 int machine__process_bpf(struct machine *machine, union perf_event *event,
 			 struct perf_sample *sample);
-int bpf_event__add_sb_event(struct evlist **evlist,
-				 struct perf_env *env);
+int evlist__add_bpf_sb_event(struct evlist *evlist, struct perf_env *env);
 void bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
 				    struct perf_env *env,
 				    FILE *fp);
@@ -46,8 +45,8 @@ static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 	return 0;
 }
 
-static inline int bpf_event__add_sb_event(struct evlist **evlist __maybe_unused,
-					  struct perf_env *env __maybe_unused)
+static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
+					   struct perf_env *env __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3f7e7d5f008b..6fe11f4d856a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1705,39 +1705,26 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	return leader;
 }
 
-int perf_evlist__add_sb_event(struct evlist **evlist,
+int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data)
 {
 	struct evsel *evsel;
-	bool new_evlist = (*evlist) == NULL;
-
-	if (*evlist == NULL)
-		*evlist = evlist__new();
-	if (*evlist == NULL)
-		return -1;
 
 	if (!attr->sample_id_all) {
 		pr_warning("enabling sample_id_all for all side band events\n");
 		attr->sample_id_all = 1;
 	}
 
-	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries);
+	evsel = perf_evsel__new_idx(attr, evlist->core.nr_entries);
 	if (!evsel)
-		goto out_err;
+		return -1;
 
 	evsel->side_band.cb = cb;
 	evsel->side_band.data = data;
-	evlist__add(*evlist, evsel);
+	evlist__add(evlist, evsel);
 	return 0;
-
-out_err:
-	if (new_evlist) {
-		evlist__delete(*evlist);
-		*evlist = NULL;
-	}
-	return -1;
 }
 
 static void *perf_evlist__poll_thread(void *arg)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 48622e593972..a9d01a11570a 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -107,7 +107,7 @@ int __perf_evlist__add_default_attrs(struct evlist *evlist,
 
 int perf_evlist__add_dummy(struct evlist *evlist);
 
-int perf_evlist__add_sb_event(struct evlist **evlist,
+int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data);
-- 
2.21.1
