From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/44] perf bpf: Make bpf__setup_output_event() return the bpf-output event
Date: Thu,  9 Aug 2018 11:58:18 -0300
Message-ID: <20180809145822.21391-41-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We're calling it to setup that event, and we'll need it later to decide
if the bpf-output event we're handling is the one setup for a specific
purpose, return it using ERR_PTR, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zhachv7il2n1lopt9aonwhu7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c   |  9 +++++----
 tools/perf/util/bpf-loader.c | 23 ++++++++++++-----------
 tools/perf/util/bpf-loader.h |  7 ++++---
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9b4e24217c46..43a699cfcadf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3216,8 +3216,9 @@ int cmd_trace(int argc, const char **argv)
 	};
 	bool __maybe_unused max_stack_user_set = true;
 	bool mmap_pages_user_set = true;
+	struct perf_evsel *evsel;
 	const char * const trace_subcommands[] = { "record", NULL };
-	int err;
+	int err = -1;
 	char bf[BUFSIZ];
 
 	signal(SIGSEGV, sighandler_dump_stack);
@@ -3240,9 +3241,9 @@ int cmd_trace(int argc, const char **argv)
 				       "cgroup monitoring only available in system-wide mode");
 	}
 
-	err = bpf__setup_output_event(trace.evlist, "__augmented_syscalls__");
-	if (err) {
-		bpf__strerror_setup_output_event(trace.evlist, err, bf, sizeof(bf));
+	evsel = bpf__setup_output_event(trace.evlist, "__augmented_syscalls__");
+	if (IS_ERR(evsel)) {
+		bpf__strerror_setup_output_event(trace.evlist, PTR_ERR(evsel), bf, sizeof(bf));
 		pr_err("ERROR: Setup trace syscalls enter failed: %s\n", bf);
 		goto out;
 	}
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 80dead642719..47aac41349a2 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1535,7 +1535,7 @@ int bpf__apply_obj_config(void)
 			(strcmp(name, 			\
 				bpf_map__name(pos)) == 0))
 
-int bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
+struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 {
 	struct bpf_map_priv *tmpl_priv = NULL;
 	struct bpf_object *obj, *tmp;
@@ -1548,7 +1548,7 @@ int bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
-			return -BPF_LOADER_ERRNO__INTERNAL;
+			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
 
 		/*
 		 * No need to check map type: type should have been
@@ -1561,20 +1561,20 @@ int bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 	}
 
 	if (!need_init)
-		return 0;
+		return NULL;
 
 	if (!tmpl_priv) {
 		char *event_definition = NULL;
 
 		if (asprintf(&event_definition, "bpf-output/no-inherit=1,name=%s/", name) < 0)
-			return -ENOMEM;
+			return ERR_PTR(-ENOMEM);
 
 		err = parse_events(evlist, event_definition, NULL);
 		free(event_definition);
 
 		if (err) {
 			pr_debug("ERROR: failed to create the \"%s\" bpf-output event\n", name);
-			return -err;
+			return ERR_PTR(-err);
 		}
 
 		evsel = perf_evlist__last(evlist);
@@ -1584,37 +1584,38 @@ int bpf__setup_output_event(struct perf_evlist *evlist, const char *name)
 		struct bpf_map_priv *priv = bpf_map__priv(map);
 
 		if (IS_ERR(priv))
-			return -BPF_LOADER_ERRNO__INTERNAL;
+			return ERR_PTR(-BPF_LOADER_ERRNO__INTERNAL);
 		if (priv)
 			continue;
 
 		if (tmpl_priv) {
 			priv = bpf_map_priv__clone(tmpl_priv);
 			if (!priv)
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 
 			err = bpf_map__set_priv(map, priv, bpf_map_priv__clear);
 			if (err) {
 				bpf_map_priv__clear(map, priv);
-				return err;
+				return ERR_PTR(err);
 			}
 		} else if (evsel) {
 			struct bpf_map_op *op;
 
 			op = bpf_map__add_newop(map, NULL);
 			if (IS_ERR(op))
-				return PTR_ERR(op);
+				return ERR_PTR(PTR_ERR(op));
 			op->op_type = BPF_MAP_OP_SET_EVSEL;
 			op->v.evsel = evsel;
 		}
 	}
 
-	return 0;
+	return evsel;
 }
 
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
-	return bpf__setup_output_event(evlist, "__bpf_stdout__");
+	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
+	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
 }
 
 #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 8eca75145ac2..62d245a90e1d 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -43,6 +43,7 @@ enum bpf_loader_errno {
 	__BPF_LOADER_ERRNO__END,
 };
 
+struct perf_evsel;
 struct bpf_object;
 struct parse_events_term;
 #define PERF_BPF_PROBE_GROUP "perf_bpf_probe"
@@ -82,7 +83,7 @@ int bpf__apply_obj_config(void);
 int bpf__strerror_apply_obj_config(int err, char *buf, size_t size);
 
 int bpf__setup_stdout(struct perf_evlist *evlist);
-int bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
+struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const char *name);
 int bpf__strerror_setup_output_event(struct perf_evlist *evlist, int err, char *buf, size_t size);
 #else
 #include <errno.h>
@@ -137,10 +138,10 @@ bpf__setup_stdout(struct perf_evlist *evlist __maybe_unused)
 	return 0;
 }
 
-static inline int
+static inline struct perf_evsel *
 bpf__setup_output_event(struct perf_evlist *evlist __maybe_unused, const char *name __maybe_unused)
 {
-	return 0;
+	return NULL;
 }
 
 static inline int
-- 
2.14.4
