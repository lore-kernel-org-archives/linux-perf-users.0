From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/57] perf trace: Hide evsel->access further, simplify code
Date: Mon, 21 Oct 2019 10:38:08 -0300
Message-ID: <20191021133834.25998-32-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Next step will be to have a 'struct evsel_trace' to allow for handling
the syscalls tracepoints via the strace-like code while reusing parts of
that code with the other tracepoints, where we don't have things like
the 'syscall_nr' or 'ret' ((raw_)?syscalls:sys_{enter,exit}(_SYSCALL)?)
args that we want to cache offsets and have been using evsel->priv for
that, while for the other tracepoints we'll have just an array of
'struct syscall_arg_fmt' (i.e. ->scnprint() for number->string and
->strtoul() string->number conversions and other state those functions
need).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fre21jbyoqxmmquxcho7oa0x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 57 +++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e0be1df555a2..1d2ed2823202 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -296,6 +296,15 @@ static inline struct syscall_tp *__evsel__syscall_tp(struct evsel *evsel)
 	return sc;
 }
 
+static struct syscall_tp *evsel__syscall_tp(struct evsel *evsel)
+{
+	if (evsel->priv == NULL) {
+		evsel->priv = zalloc(sizeof(struct syscall_tp));
+	}
+
+	return __evsel__syscall_tp(evsel);
+}
+
 /*
  * Used with all the other tracepoints.
  */
@@ -306,6 +315,15 @@ static inline struct syscall_arg_fmt *__evsel__syscall_arg_fmt(struct evsel *evs
 	return fmt;
 }
 
+static struct syscall_arg_fmt *evsel__syscall_arg_fmt(struct evsel *evsel)
+{
+	if (evsel->priv == NULL) {
+		evsel->priv = calloc(evsel->tp_format->format.nr_fields, sizeof(struct syscall_arg_fmt));
+	}
+
+	return __evsel__syscall_arg_fmt(evsel);
+}
+
 static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
 					  struct tp_field *field,
 					  const char *name)
@@ -346,41 +364,34 @@ static void evsel__delete_priv(struct evsel *evsel)
 
 static int perf_evsel__init_syscall_tp(struct evsel *evsel)
 {
-	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+	struct syscall_tp *sc = evsel__syscall_tp(evsel);
 
-	if (evsel->priv != NULL) {
+	if (sc != NULL) {
 		if (perf_evsel__init_tp_uint_field(evsel, &sc->id, "__syscall_nr") &&
 		    perf_evsel__init_tp_uint_field(evsel, &sc->id, "nr"))
-			goto out_delete;
+			return -ENOENT;
 		return 0;
 	}
 
 	return -ENOMEM;
-out_delete:
-	zfree(&evsel->priv);
-	return -ENOENT;
 }
 
 static int perf_evsel__init_augmented_syscall_tp(struct evsel *evsel, struct evsel *tp)
 {
-	struct syscall_tp *sc = evsel->priv = malloc(sizeof(struct syscall_tp));
+	struct syscall_tp *sc = evsel__syscall_tp(evsel);
 
-	if (evsel->priv != NULL) {
+	if (sc != NULL) {
 		struct tep_format_field *syscall_id = perf_evsel__field(tp, "id");
 		if (syscall_id == NULL)
 			syscall_id = perf_evsel__field(tp, "__syscall_nr");
-		if (syscall_id == NULL)
-			goto out_delete;
-		if (__tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
-			goto out_delete;
+		if (syscall_id == NULL ||
+		    __tp_field__init_uint(&sc->id, syscall_id->size, syscall_id->offset, evsel->needs_swap))
+			return -EINVAL;
 
 		return 0;
 	}
 
 	return -ENOMEM;
-out_delete:
-	zfree(&evsel->priv);
-	return -EINVAL;
 }
 
 static int perf_evsel__init_augmented_syscall_tp_args(struct evsel *evsel)
@@ -399,20 +410,15 @@ static int perf_evsel__init_augmented_syscall_tp_ret(struct evsel *evsel)
 
 static int perf_evsel__init_raw_syscall_tp(struct evsel *evsel, void *handler)
 {
-	evsel->priv = malloc(sizeof(struct syscall_tp));
-	if (evsel->priv != NULL) {
+	if (evsel__syscall_tp(evsel) != NULL) {
 		if (perf_evsel__init_sc_tp_uint_field(evsel, id))
-			goto out_delete;
+			return -ENOENT;
 
 		evsel->handler = handler;
 		return 0;
 	}
 
 	return -ENOMEM;
-
-out_delete:
-	zfree(&evsel->priv);
-	return -ENOENT;
 }
 
 static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *handler)
@@ -1690,11 +1696,10 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 
 static int perf_evsel__init_tp_arg_scnprintf(struct evsel *evsel)
 {
-	int nr_args = evsel->tp_format->format.nr_fields;
+	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
-	evsel->priv = calloc(nr_args, sizeof(struct syscall_arg_fmt));
-	if (evsel->priv != NULL) {
-		syscall_arg_fmt__init_array(evsel->priv, evsel->tp_format->format.fields);
+	if (fmt != NULL) {
+		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
 		return 0;
 	}
 
-- 
2.21.0
