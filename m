From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/57] perf trace: Introduce accessors to trace specific evsel->priv
Date: Mon, 21 Oct 2019 10:38:07 -0300
Message-ID: <20191021133834.25998-31-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We're using evsel->priv in syscalls:sys_{enter,exit}_SYSCALL and in
raw_syscalls:sys_{enter,exit} to cache the offset of the common fields,
the multiplexor id/syscall_id in the sys_enter case and syscall_id + ret
for sys_exit.

And for the rest of the tracepoints we use it to have a syscall_arg_fmt
array to have scnprintf/strtoul for tracepoint args.

So we better clearly mark them with accessors so that we can move to
having a 'struct evsel_trace' struct for all 'perf trace' specific
evsel->priv usage.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dcoyxfslg7atz821tz9aupjh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 43 ++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cafd18466dfa..e0be1df555a2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -285,6 +285,27 @@ struct syscall_tp {
 	};
 };
 
+/*
+ * Used with raw_syscalls:sys_{enter,exit} and with the
+ * syscalls:sys_{enter,exit}_SYSCALL tracepoints
+ */
+static inline struct syscall_tp *__evsel__syscall_tp(struct evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv;
+
+	return sc;
+}
+
+/*
+ * Used with all the other tracepoints.
+ */
+static inline struct syscall_arg_fmt *__evsel__syscall_arg_fmt(struct evsel *evsel)
+{
+	struct syscall_arg_fmt *fmt = evsel->priv;
+
+	return fmt;
+}
+
 static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
 					  struct tp_field *field,
 					  const char *name)
@@ -298,7 +319,7 @@ static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
 }
 
 #define perf_evsel__init_sc_tp_uint_field(evsel, name) \
-	({ struct syscall_tp *sc = evsel->priv;\
+	({ struct syscall_tp *sc = __evsel__syscall_tp(evsel);\
 	   perf_evsel__init_tp_uint_field(evsel, &sc->name, #name); })
 
 static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
@@ -314,7 +335,7 @@ static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
 }
 
 #define perf_evsel__init_sc_tp_ptr_field(evsel, name) \
-	({ struct syscall_tp *sc = evsel->priv;\
+	({ struct syscall_tp *sc = __evsel__syscall_tp(evsel);\
 	   perf_evsel__init_tp_ptr_field(evsel, &sc->name, #name); })
 
 static void evsel__delete_priv(struct evsel *evsel)
@@ -364,14 +385,14 @@ static int perf_evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evs
 
 static int perf_evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
 {
-	struct syscall_tp *sc = evsel->priv;
+	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
 }
 
 static int perf_evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
 {
-	struct syscall_tp *sc = evsel->priv;
+	struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 	return __tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap);
 }
@@ -416,11 +437,11 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 }
 
 #define perf_evsel__sc_tp_uint(evsel, name, sample) \
-	({ struct syscall_tp *fields = evsel->priv; \
+	({ struct syscall_tp *fields = __evsel__syscall_tp(evsel); \
 	   fields->name.integer(&fields->name, sample); })
 
 #define perf_evsel__sc_tp_ptr(evsel, name, sample) \
-	({ struct syscall_tp *fields = evsel->priv; \
+	({ struct syscall_tp *fields = __evsel__syscall_tp(evsel); \
 	   fields->name.pointer(&fields->name, sample); })
 
 size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_suffix, int val)
@@ -2518,7 +2539,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 	char bf[2048];
 	size_t size = sizeof(bf);
 	struct tep_format_field *field = evsel->tp_format->format.fields;
-	struct syscall_arg_fmt *arg = evsel->priv;
+	struct syscall_arg_fmt *arg = __evsel__syscall_arg_fmt(evsel);
 	size_t printed = 0;
 	unsigned long val;
 	u8 bit = 1;
@@ -3557,7 +3578,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 static struct syscall_arg_fmt *perf_evsel__syscall_arg_fmt(struct evsel *evsel, char *arg)
 {
 	struct tep_format_field *field;
-	struct syscall_arg_fmt *fmt = evsel->priv;
+	struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
 
 	if (evsel->tp_format == NULL || fmt == NULL)
 		return NULL;
@@ -4315,12 +4336,12 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 			return -1;
 
 		if (!strncmp(evsel->tp_format->name, "sys_enter_", 10)) {
-			struct syscall_tp *sc = evsel->priv;
+			struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 			if (__tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64)))
 				return -1;
 		} else if (!strncmp(evsel->tp_format->name, "sys_exit_", 9)) {
-			struct syscall_tp *sc = evsel->priv;
+			struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 			if (__tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap))
 				return -1;
@@ -4856,7 +4877,7 @@ int cmd_trace(int argc, const char **argv)
 init_augmented_syscall_tp:
 				if (perf_evsel__init_augmented_syscall_tp(evsel, evsel))
 					goto out;
-				sc = evsel->priv;
+				sc = __evsel__syscall_tp(evsel);
 				/*
 				 * For now with BPF raw_augmented we hook into
 				 * raw_syscalls:sys_enter and there we get all
-- 
2.21.0
