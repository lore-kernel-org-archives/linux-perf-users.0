From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/57] perf trace: Introduce 'struct evsel__trace' for evsel->priv needs
Date: Mon, 21 Oct 2019 10:38:09 -0300
Message-ID: <20191021133834.25998-33-acme@kernel.org>
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

For syscalls we need to cache the 'syscall_id' and 'ret' field offsets
but as well have a pointer to the syscall_fmt_arg array for the fields,
so that we can expand strings in filter expressions, so introduce
a 'struct evsel_trace' to have in evsel->priv that allows for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hx8ukasuws5sz6rsar73cocv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 54 +++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1d2ed2823202..5792278065f6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -285,21 +285,47 @@ struct syscall_tp {
 	};
 };
 
+/*
+ * The evsel->priv as used by 'perf trace'
+ * sc:	for raw_syscalls:sys_{enter,exit} and syscalls:sys_{enter,exit}_SYSCALLNAME
+ * fmt: for all the other tracepoints
+ */
+struct evsel_trace {
+	struct syscall_tp	sc;
+	struct syscall_arg_fmt  *fmt;
+};
+
+static struct evsel_trace *evsel_trace__new(void)
+{
+	return zalloc(sizeof(struct evsel_trace));
+}
+
+static void evsel_trace__delete(struct evsel_trace *et)
+{
+	if (et == NULL)
+		return;
+
+	zfree(&et->fmt);
+	free(et);
+}
+
 /*
  * Used with raw_syscalls:sys_{enter,exit} and with the
  * syscalls:sys_{enter,exit}_SYSCALL tracepoints
  */
 static inline struct syscall_tp *__evsel__syscall_tp(struct evsel *evsel)
 {
-	struct syscall_tp *sc = evsel->priv;
+	struct evsel_trace *et = evsel->priv;
 
-	return sc;
+	return &et->sc;
 }
 
 static struct syscall_tp *evsel__syscall_tp(struct evsel *evsel)
 {
 	if (evsel->priv == NULL) {
-		evsel->priv = zalloc(sizeof(struct syscall_tp));
+		evsel->priv = evsel_trace__new();
+		if (evsel->priv == NULL)
+			return NULL;
 	}
 
 	return __evsel__syscall_tp(evsel);
@@ -310,18 +336,34 @@ static struct syscall_tp *evsel__syscall_tp(struct evsel *evsel)
  */
 static inline struct syscall_arg_fmt *__evsel__syscall_arg_fmt(struct evsel *evsel)
 {
-	struct syscall_arg_fmt *fmt = evsel->priv;
+	struct evsel_trace *et = evsel->priv;
 
-	return fmt;
+	return et->fmt;
 }
 
 static struct syscall_arg_fmt *evsel__syscall_arg_fmt(struct evsel *evsel)
 {
+	struct evsel_trace *et = evsel->priv;
+
 	if (evsel->priv == NULL) {
-		evsel->priv = calloc(evsel->tp_format->format.nr_fields, sizeof(struct syscall_arg_fmt));
+		et = evsel->priv = evsel_trace__new();
+
+		if (et == NULL)
+			return NULL;
+	}
+
+	if (et->fmt == NULL) {
+		et->fmt = calloc(evsel->tp_format->format.nr_fields, sizeof(struct syscall_arg_fmt));
+		if (et->fmt == NULL)
+			goto out_delete;
 	}
 
 	return __evsel__syscall_arg_fmt(evsel);
+
+out_delete:
+	evsel_trace__delete(evsel->priv);
+	evsel->priv = NULL;
+	return NULL;
 }
 
 static int perf_evsel__init_tp_uint_field(struct evsel *evsel,
-- 
2.21.0
