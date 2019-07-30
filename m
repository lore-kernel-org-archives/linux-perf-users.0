From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 003/107] perf evsel: Store backpointer to attached bpf_object
Date: Mon, 29 Jul 2019 23:54:26 -0300
Message-ID: <20190730025610.22603-4-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We may want to get to this bpf_object, to search for other BPF programs,
etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3y8hrb6lszjfi23vjlic3cib@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c   | 4 ++--
 tools/perf/util/bpf-loader.h   | 2 +-
 tools/perf/util/evsel.c        | 1 +
 tools/perf/util/evsel.h        | 3 +++
 tools/perf/util/parse-events.c | 3 ++-
 5 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index c61974a50aa5..6d0dfb777a79 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -763,7 +763,7 @@ int bpf__foreach_event(struct bpf_object *obj,
 
 		if (priv->is_tp) {
 			fd = bpf_program__fd(prog);
-			err = (*func)(priv->sys_name, priv->evt_name, fd, arg);
+			err = (*func)(priv->sys_name, priv->evt_name, fd, obj, arg);
 			if (err) {
 				pr_debug("bpf: tracepoint call back failed, stop iterate\n");
 				return err;
@@ -788,7 +788,7 @@ int bpf__foreach_event(struct bpf_object *obj,
 				return fd;
 			}
 
-			err = (*func)(tev->group, tev->event, fd, arg);
+			err = (*func)(tev->group, tev->event, fd, obj, arg);
 			if (err) {
 				pr_debug("bpf: call back failed, stop iterate\n");
 				return err;
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 3f46856e3330..8c3441a4b72c 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -46,7 +46,7 @@ struct parse_events_term;
 #define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
 
 typedef int (*bpf_prog_iter_callback_t)(const char *group, const char *event,
-					int fd, void *arg);
+					int fd, struct bpf_object *obj, void *arg);
 
 #ifdef HAVE_LIBBPF_SUPPORT
 struct bpf_object *bpf__prepare_load(const char *filename, bool source);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 52459dd5ad0c..7d1757a2ec46 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -234,6 +234,7 @@ void perf_evsel__init(struct perf_evsel *evsel,
 	evsel->scale	   = 1.0;
 	evsel->max_events  = ULONG_MAX;
 	evsel->evlist	   = NULL;
+	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->node);
 	INIT_LIST_HEAD(&evsel->config_terms);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cad54e8ba522..b27935a6d36c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -82,6 +82,8 @@ enum perf_tool_event {
 	PERF_TOOL_DURATION_TIME = 1,
 };
 
+struct bpf_object;
+
 /** struct perf_evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -152,6 +154,7 @@ struct perf_evsel {
 	char			*group_name;
 	bool			cmdline_group_boundary;
 	struct list_head	config_terms;
+	struct bpf_object	*bpf_obj;
 	int			bpf_fd;
 	bool			auto_merge_stats;
 	bool			merged_stat;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fac6b32ef94a..0540303e5e97 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -630,7 +630,7 @@ struct __add_bpf_event_param {
 	struct list_head *head_config;
 };
 
-static int add_bpf_event(const char *group, const char *event, int fd,
+static int add_bpf_event(const char *group, const char *event, int fd, struct bpf_object *obj,
 			 void *_param)
 {
 	LIST_HEAD(new_evsels);
@@ -672,6 +672,7 @@ static int add_bpf_event(const char *group, const char *event, int fd,
 		pr_debug("adding %s:%s to %p\n",
 			 group, event, pos);
 		pos->bpf_fd = fd;
+		pos->bpf_obj = obj;
 	}
 	list_splice(&new_evsels, list);
 	return 0;
-- 
2.21.0
