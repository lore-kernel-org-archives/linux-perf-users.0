From: Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf tools: Add machine pointer to struct hists
Date: Mon, 27 Jan 2020 23:34:43 +0900
Message-ID: <20200127143443.89060-1-namhyung@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

This is a preparation to handle cgroup events better for upcoming work.
Having a pointer to struct machine will make it easier to access more
data from output/sort routines.

I added session argument to perf_evsel__object_config callbacks to
enable this as hists objects are accessed via evsel in the normal
workflows.  So it can be NULL if those callbacks are never called or
session was not set when it's called.

If some codes want to access machine from a hists later, it should
check the pointer first.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evlist.c       |  8 ++++---
 tools/perf/util/evsel.c        | 38 ++++++++++++++++++++--------------
 tools/perf/util/evsel.h        | 28 ++++++++++++++++++-------
 tools/perf/util/hist.c         |  9 ++++++--
 tools/perf/util/hist.h         |  1 +
 tools/perf/util/parse-events.c |  4 ++--
 tools/perf/util/python.c       |  4 ++--
 7 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1548237b6558..870e56c75c23 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -248,8 +248,9 @@ int perf_evlist__add_dummy(struct evlist *evlist)
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
 	};
-	struct evsel *evsel = perf_evsel__new_idx(&attr, evlist->core.nr_entries);
+	struct evsel *evsel;
 
+	evsel = perf_evsel__new_idx(&attr, evlist->core.nr_entries, NULL);
 	if (evsel == NULL)
 		return -ENOMEM;
 
@@ -265,7 +266,8 @@ static int evlist__add_attrs(struct evlist *evlist,
 	size_t i;
 
 	for (i = 0; i < nr_attrs; i++) {
-		evsel = perf_evsel__new_idx(attrs + i, evlist->core.nr_entries + i);
+		evsel = perf_evsel__new_idx(attrs + i,
+					    evlist->core.nr_entries + i, NULL);
 		if (evsel == NULL)
 			goto out_delete_partial_list;
 		list_add_tail(&evsel->core.node, &head);
@@ -1720,7 +1722,7 @@ int perf_evlist__add_sb_event(struct evlist **evlist,
 		attr->sample_id_all = 1;
 	}
 
-	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries);
+	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries, NULL);
 	if (!evsel)
 		goto out_err;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c8dc4450884c..cf9bb7bb3542 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -56,21 +56,23 @@ struct perf_missing_features perf_missing_features;
 
 static clockid_t clockid;
 
-static int perf_evsel__no_extra_init(struct evsel *evsel __maybe_unused)
+static int perf_evsel__no_extra_init(struct evsel *evsel __maybe_unused,
+				     struct perf_session *session __maybe_unused)
 {
 	return 0;
 }
 
 void __weak test_attr__ready(void) { }
 
-static void perf_evsel__no_extra_fini(struct evsel *evsel __maybe_unused)
+static void perf_evsel__no_extra_fini(struct evsel *evsel __maybe_unused,
+				      struct perf_session *session __maybe_unused)
 {
 }
 
 static struct {
 	size_t	size;
-	int	(*init)(struct evsel *evsel);
-	void	(*fini)(struct evsel *evsel);
+	int	(*init)(struct evsel *evsel, struct perf_session *session);
+	void	(*fini)(struct evsel *evsel, struct perf_session *session);
 } perf_evsel__object = {
 	.size = sizeof(struct evsel),
 	.init = perf_evsel__no_extra_init,
@@ -78,8 +80,10 @@ static struct {
 };
 
 int perf_evsel__object_config(size_t object_size,
-			      int (*init)(struct evsel *evsel),
-			      void (*fini)(struct evsel *evsel))
+			      int (*init)(struct evsel *evsel,
+					  struct perf_session *session),
+			      void (*fini)(struct evsel *evsel,
+					   struct perf_session *session))
 {
 
 	if (object_size == 0)
@@ -234,8 +238,8 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
 #undef FUNCTION_EVENT
 }
 
-void evsel__init(struct evsel *evsel,
-		 struct perf_event_attr *attr, int idx)
+void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx,
+		 struct perf_session *session)
 {
 	perf_evsel__init(&evsel->core, attr);
 	evsel->idx	   = idx;
@@ -248,7 +252,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->config_terms);
-	perf_evsel__object.init(evsel);
+	perf_evsel__object.init(evsel, session);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
 	perf_evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
@@ -259,13 +263,14 @@ void evsel__init(struct evsel *evsel,
 	evsel->pmu_name      = NULL;
 }
 
-struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
+struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx,
+				  struct perf_session *session)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 
 	if (!evsel)
 		return NULL;
-	evsel__init(evsel, attr, idx);
+	evsel__init(evsel, attr, idx, session);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->core.attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
@@ -334,7 +339,8 @@ struct evsel *perf_evsel__new_cycles(bool precise)
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
-struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
+struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx,
+				    struct perf_session *session)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 	int err = -ENOMEM;
@@ -360,7 +366,7 @@ struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
 		event_attr_init(&attr);
 		attr.config = evsel->tp_format->id;
 		attr.sample_period = 1;
-		evsel__init(evsel, &attr, idx);
+		evsel__init(evsel, &attr, idx, session);
 	}
 
 	return evsel;
@@ -1271,7 +1277,7 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 	}
 }
 
-void perf_evsel__exit(struct evsel *evsel)
+void perf_evsel__exit(struct evsel *evsel, struct perf_session *session)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
@@ -1285,12 +1291,12 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
-	perf_evsel__object.fini(evsel);
+	perf_evsel__object.fini(evsel, session);
 }
 
 void evsel__delete(struct evsel *evsel)
 {
-	perf_evsel__exit(evsel);
+	perf_evsel__exit(evsel, NULL);
 	free(evsel);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dc14f4a823cd..5f93620d7764 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -127,6 +127,7 @@ struct perf_cpu_map;
 struct target;
 struct thread_map;
 struct record_opts;
+struct perf_session;
 
 static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 {
@@ -145,32 +146,43 @@ void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 				struct perf_counts_values *count);
 
 int perf_evsel__object_config(size_t object_size,
-			      int (*init)(struct evsel *evsel),
-			      void (*fini)(struct evsel *evsel));
+			      int (*init)(struct evsel *evsel,
+					  struct perf_session *session),
+			      void (*fini)(struct evsel *evsel,
+					   struct perf_session *session));
 
-struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
+struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx,
+				  struct perf_session *session);
 
 static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 {
-	return perf_evsel__new_idx(attr, 0);
+	return perf_evsel__new_idx(attr, 0, NULL);
 }
 
-struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx);
+static inline struct evsel *evsel__new2(struct perf_event_attr *attr,
+					struct perf_session *session)
+{
+	return perf_evsel__new_idx(attr, 0, session);
+}
+
+struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx,
+				    struct perf_session *session);
 
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
 static inline struct evsel *perf_evsel__newtp(const char *sys, const char *name)
 {
-	return perf_evsel__newtp_idx(sys, name, 0);
+	return perf_evsel__newtp_idx(sys, name, 0, NULL);
 }
 
 struct evsel *perf_evsel__new_cycles(bool precise);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
-void perf_evsel__exit(struct evsel *evsel);
+void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx,
+		 struct perf_session *session);
+void perf_evsel__exit(struct evsel *evsel, struct perf_session *session);
 void evsel__delete(struct evsel *evsel);
 
 struct callchain_param;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index ca5a8f4d007e..2c1f5a967180 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2775,7 +2775,8 @@ static void hists__delete_all_entries(struct hists *hists)
 	hists__delete_remaining_entries(&hists->entries_collapsed);
 }
 
-static void hists_evsel__exit(struct evsel *evsel)
+static void hists_evsel__exit(struct evsel *evsel,
+			      struct perf_session *session __maybe_unused)
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct perf_hpp_fmt *fmt, *pos;
@@ -2793,11 +2794,15 @@ static void hists_evsel__exit(struct evsel *evsel)
 	}
 }
 
-static int hists_evsel__init(struct evsel *evsel)
+static int hists_evsel__init(struct evsel *evsel,
+			     struct perf_session *session)
 {
 	struct hists *hists = evsel__hists(evsel);
 
 	__hists__init(hists, &perf_hpp_list);
+	if (session)
+		hists->machine = &session->machines.host;
+
 	return 0;
 }
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 0aa63aeb58ec..ffce7536761b 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -84,6 +84,7 @@ struct hists {
 	u64			nr_non_filtered_entries;
 	u64			callchain_period;
 	u64			callchain_non_filtered_period;
+	struct machine		*machine;
 	struct thread		*thread_filter;
 	const struct dso	*dso_filter;
 	const char		*uid_filter_str;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c01ba6f8fdad..7290513f7646 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -360,7 +360,7 @@ __add_event(struct list_head *list, int *idx,
 
 	event_attr_init(attr);
 
-	evsel = perf_evsel__new_idx(attr, *idx);
+	evsel = perf_evsel__new_idx(attr, *idx, NULL);
 	if (!evsel)
 		return NULL;
 
@@ -546,7 +546,7 @@ static int add_tracepoint(struct list_head *list, int *idx,
 {
 	struct evsel *evsel;
 
-	evsel = perf_evsel__newtp_idx(sys_name, evt_name, (*idx)++);
+	evsel = perf_evsel__newtp_idx(sys_name, evt_name, (*idx)++, NULL);
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name);
 		return PTR_ERR(evsel);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 83212c65848b..aa6319279448 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -795,13 +795,13 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	attr.sample_id_all  = sample_id_all;
 	attr.size	    = sizeof(attr);
 
-	evsel__init(&pevsel->evsel, &attr, idx);
+	evsel__init(&pevsel->evsel, &attr, idx, NULL);
 	return 0;
 }
 
 static void pyrf_evsel__delete(struct pyrf_evsel *pevsel)
 {
-	perf_evsel__exit(&pevsel->evsel);
+	perf_evsel__exit(&pevsel->evsel, NULL);
 	Py_TYPE(pevsel)->tp_free((PyObject*)pevsel);
 }
 
-- 
2.25.0.341.g760bfbb309-goog
