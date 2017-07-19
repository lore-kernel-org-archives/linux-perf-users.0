From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/86] perf trace: Allow syscall_arg beautifiers to set a different return formatter
Date: Wed, 19 Jul 2017 11:28:40 -0300
Message-ID: <20170719142950.3747-17-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Things like fcntl will use this to set the right formatter based on its
'cmd' argument.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-4ea3wplb8b4j7aymj0d5uo0h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 27 ++++++++++++++++++++++++++-
 tools/perf/trace/beauty/beauty.h |  3 +++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1f070bc43742..d48981c36b70 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -908,6 +908,8 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
  * filename.ptr: The filename char pointer that will be vfs_getname'd
  * filename.entry_str_pos: Where to insert the string translated from
  *                         filename.ptr by the vfs_getname tracepoint/kprobe.
+ * ret_scnprintf: syscall args may set this to a different syscall return
+ *                formatter, for instance, fcntl may return fds, file flags, etc.
  */
 struct thread_trace {
 	u64		  entry_time;
@@ -916,6 +918,7 @@ struct thread_trace {
 	unsigned long	  pfmaj, pfmin;
 	char		  *entry_str;
 	double		  runtime_ms;
+	size_t		  (*ret_scnprintf)(unsigned long value, char *bf, size_t size);
         struct {
 		unsigned long ptr;
 		short int     entry_str_pos;
@@ -966,6 +969,15 @@ static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
 	return NULL;
 }
 
+
+void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
+				    size_t (*ret_scnprintf)(unsigned long val, char *bf, size_t size))
+{
+	struct thread_trace *ttrace = thread__priv(arg->thread);
+
+	ttrace->ret_scnprintf = ret_scnprintf;
+}
+
 #define TRACE_PFMAJ		(1 << 0)
 #define TRACE_PFMIN		(1 << 1)
 
@@ -1390,6 +1402,14 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 {
 	size_t printed = 0;
 	unsigned long val;
+	struct thread_trace *ttrace = thread__priv(thread);
+
+	/*
+	 * Things like fcntl will set this in its 'cmd' formatter to pick the
+	 * right formatter for the return value (an fd? file flags?), which is
+	 * not needed for syscalls that always return a given type, say an fd.
+	 */
+	ttrace->ret_scnprintf = NULL;
 
 	if (sc->args != NULL) {
 		struct format_field *field;
@@ -1704,7 +1724,12 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 		fprintf(trace->output, ") = -1 %s %s", e, emsg);
 	} else if (ret == 0 && sc->fmt->timeout)
 		fprintf(trace->output, ") = 0 Timeout");
-	else if (sc->fmt->hexret)
+	else if (ttrace->ret_scnprintf) {
+		char bf[1024];
+		ttrace->ret_scnprintf(ret, bf, sizeof(bf));
+		ttrace->ret_scnprintf = NULL;
+		fprintf(trace->output, ") = %s", bf);
+	} else if (sc->fmt->hexret)
 		fprintf(trace->output, ") = %#lx", ret);
 	else if (sc->fmt->errpid) {
 		struct thread *child = machine__find_thread(trace->host, ret, ret);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index c05bb2ecf502..a9613d2e6cfe 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -54,4 +54,7 @@ size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_a
 
 size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size);
 
+void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
+				    size_t (*ret_scnprintf)(unsigned long val, char *bf, size_t size));
+
 #endif /* _PERF_TRACE_BEAUTY_H */
-- 
2.9.4
