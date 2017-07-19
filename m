From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/86] perf trace beauty: Give syscall return beautifier more context
Date: Wed, 19 Jul 2017 11:28:47 -0300
Message-ID: <20170719142950.3747-24-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need the current thread and the trace internal state so that we can
use the fd beautifier to augment syscall returns, so use struct
syscall_arg with some fields that make sense on returns (val, thread,
trace).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-lqag8e86ybidrh5zpqne05ov@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c           | 11 ++++++++---
 tools/perf/trace/beauty/beauty.h     |  5 ++++-
 tools/perf/trace/beauty/fcntl.c      |  9 +++++++--
 tools/perf/trace/beauty/open_flags.c |  5 +----
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d48981c36b70..cfa8bf1cca43 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -918,7 +918,7 @@ struct thread_trace {
 	unsigned long	  pfmaj, pfmin;
 	char		  *entry_str;
 	double		  runtime_ms;
-	size_t		  (*ret_scnprintf)(unsigned long value, char *bf, size_t size);
+	size_t		  (*ret_scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
         struct {
 		unsigned long ptr;
 		short int     entry_str_pos;
@@ -971,7 +971,7 @@ static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
 
 
 void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
-				    size_t (*ret_scnprintf)(unsigned long val, char *bf, size_t size))
+				    size_t (*ret_scnprintf)(char *bf, size_t size, struct syscall_arg *arg))
 {
 	struct thread_trace *ttrace = thread__priv(arg->thread);
 
@@ -1726,7 +1726,12 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 		fprintf(trace->output, ") = 0 Timeout");
 	else if (ttrace->ret_scnprintf) {
 		char bf[1024];
-		ttrace->ret_scnprintf(ret, bf, sizeof(bf));
+		struct syscall_arg arg = {
+			.val	= ret,
+			.thread	= thread,
+			.trace	= trace,
+		};
+		ttrace->ret_scnprintf(bf, sizeof(bf), &arg);
 		ttrace->ret_scnprintf = NULL;
 		fprintf(trace->output, ") = %s", bf);
 	} else if (sc->fmt->hexret)
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index a9613d2e6cfe..b64c4116cdc4 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -46,6 +46,9 @@ size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_ar
 size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FCNTL_ARG syscall_arg__scnprintf_fcntl_arg
 
+size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_OPEN_FLAGS syscall_arg__scnprintf_open_flags
+
 size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_FLAGS syscall_arg__scnprintf_statx_flags
 
@@ -55,6 +58,6 @@ size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_a
 size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size);
 
 void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
-				    size_t (*ret_scnprintf)(unsigned long val, char *bf, size_t size));
+				    size_t (*ret_scnprintf)(char *bf, size_t size, struct syscall_arg *arg));
 
 #endif /* _PERF_TRACE_BEAUTY_H */
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 384f177a4304..9de80a7eddfa 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -15,14 +15,19 @@ static size_t fcntl__scnprintf_getfd(unsigned long val, char *bf, size_t size)
 	return scnprintf(bf, size, "%s", val ? "CLOEXEC" : "0");
 }
 
+static size_t syscall_arg__scnprintf_fcntl_getfd(char *bf, size_t size, struct syscall_arg *arg)
+{
+	return fcntl__scnprintf_getfd(arg->val, bf, size);
+}
+
 size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg)
 {
 	if (arg->val == F_GETFL) {
-		syscall_arg__set_ret_scnprintf(arg, open__scnprintf_flags);
+		syscall_arg__set_ret_scnprintf(arg, syscall_arg__scnprintf_open_flags);
 		goto mask_arg;
 	}
 	if (arg->val == F_GETFD) {
-		syscall_arg__set_ret_scnprintf(arg, fcntl__scnprintf_getfd);
+		syscall_arg__set_ret_scnprintf(arg, syscall_arg__scnprintf_fcntl_getfd);
 		goto mask_arg;
 	}
 	/*
diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index 3c20683d8cfb..e359e041dc0e 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -73,7 +73,7 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 	return printed;
 }
 
-static size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
 	int flags = arg->val;
 
@@ -82,6 +82,3 @@ static size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct sy
 
 	return open__scnprintf_flags(flags, bf, size);
 }
-
-
-#define SCA_OPEN_FLAGS syscall_arg__scnprintf_open_flags
-- 
2.9.4
