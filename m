From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/40] perf trace: Allow allocating sc->arg_fmt even without the syscall tracepoint
Date: Wed, 26 Jul 2017 11:16:55 -0300
Message-ID: <20170726141730.30750-6-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

At least "clone" doesn't have (enter, exit) entries tracefs/events/syscalls/,
but we can provide a syscall_fmt and use it instead, as will be done for
"clone" in the next cset.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-o12kejgcxddyovn2hlg4gbim@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4370ce4f28c7..1c5238af6d14 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1165,22 +1165,31 @@ static int trace__symbols_init(struct trace *trace, struct perf_evlist *evlist)
 	return err;
 }
 
-static int syscall__set_arg_fmts(struct syscall *sc)
+static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
-	struct format_field *field;
-	int idx = 0, len;
+	int idx;
 
-	sc->arg_fmt = calloc(sc->nr_args, sizeof(*sc->arg_fmt));
+	sc->arg_fmt = calloc(nr_args, sizeof(*sc->arg_fmt));
 	if (sc->arg_fmt == NULL)
 		return -1;
 
-	for (field = sc->args; field; field = field->next, ++idx) {
-		if (sc->fmt) {
+	for (idx = 0; idx < nr_args; ++idx) {
+		if (sc->fmt)
 			sc->arg_fmt[idx] = sc->fmt->arg[idx];
+	}
 
-			if (sc->fmt->arg[idx].scnprintf)
-				continue;
-		}
+	sc->nr_args = nr_args;
+	return 0;
+}
+
+static int syscall__set_arg_fmts(struct syscall *sc)
+{
+	struct format_field *field;
+	int idx = 0, len;
+
+	for (field = sc->args; field; field = field->next, ++idx) {
+		if (sc->fmt && sc->fmt->arg[idx].scnprintf)
+			continue;
 
 		if (strcmp(field->type, "const char *") == 0 &&
 			 (strcmp(field->name, "filename") == 0 ||
@@ -1251,11 +1260,13 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 		sc->tp_format = trace_event__tp_format("syscalls", tp_name);
 	}
 
+	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ? 6 : sc->tp_format->format.nr_fields))
+		return -1;
+
 	if (IS_ERR(sc->tp_format))
 		return -1;
 
 	sc->args = sc->tp_format->format.fields;
-	sc->nr_args = sc->tp_format->format.nr_fields;
 	/*
 	 * We need to check and discard the first variable '__syscall_nr'
 	 * or 'nr' that mean the syscall number. It is needless here.
-- 
2.9.4
