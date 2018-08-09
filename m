From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/44] perf trace: Rename some syscall_tp methods to raw_syscall
Date: Thu,  9 Aug 2018 11:57:41 -0300
Message-ID: <20180809145822.21391-4-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Because raw_syscalls have the field for the syscall number as 'id' while
the syscalls:sys_{enter,exit}_NAME have it as __syscall_nr...

Since we want to support both for being able to enable just a
syscalls:sys_{enter,exit}_name instead of asking for
raw_syscalls:sys_{enter,exit} plus filters, make the method names for
each kind of tracepoint more explicit.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4rixbfzco6tsry0w9ghx3ktb@git.kernel.org
Signef-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7336552c22cf..039f94467968 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -239,7 +239,7 @@ static void perf_evsel__delete_priv(struct perf_evsel *evsel)
 	perf_evsel__delete(evsel);
 }
 
-static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel, void *handler)
+static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
 	if (evsel->priv != NULL) {
@@ -257,7 +257,7 @@ static int perf_evsel__init_syscall_tp(struct perf_evsel *evsel, void *handler)
 	return -ENOENT;
 }
 
-static struct perf_evsel *perf_evsel__syscall_newtp(const char *direction, void *handler)
+static struct perf_evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *handler)
 {
 	struct perf_evsel *evsel = perf_evsel__newtp("raw_syscalls", direction);
 
@@ -268,7 +268,7 @@ static struct perf_evsel *perf_evsel__syscall_newtp(const char *direction, void
 	if (IS_ERR(evsel))
 		return NULL;
 
-	if (perf_evsel__init_syscall_tp(evsel, handler))
+	if (perf_evsel__init_raw_syscall_tp(evsel, handler))
 		goto out_delete;
 
 	return evsel;
@@ -2288,14 +2288,14 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	struct perf_evlist *evlist = trace->evlist;
 	struct perf_evsel *sys_enter, *sys_exit;
 
-	sys_enter = perf_evsel__syscall_newtp("sys_enter", trace__sys_enter);
+	sys_enter = perf_evsel__raw_syscall_newtp("sys_enter", trace__sys_enter);
 	if (sys_enter == NULL)
 		goto out;
 
 	if (perf_evsel__init_sc_tp_ptr_field(sys_enter, args))
 		goto out_delete_sys_enter;
 
-	sys_exit = perf_evsel__syscall_newtp("sys_exit", trace__sys_exit);
+	sys_exit = perf_evsel__raw_syscall_newtp("sys_exit", trace__sys_exit);
 	if (sys_exit == NULL)
 		goto out_delete_sys_enter;
 
@@ -2717,7 +2717,7 @@ static int trace__replay(struct trace *trace)
 							     "syscalls:sys_enter");
 
 	if (evsel &&
-	    (perf_evsel__init_syscall_tp(evsel, trace__sys_enter) < 0 ||
+	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_enter) < 0 ||
 	    perf_evsel__init_sc_tp_ptr_field(evsel, args))) {
 		pr_err("Error during initialize raw_syscalls:sys_enter event\n");
 		goto out;
@@ -2729,7 +2729,7 @@ static int trace__replay(struct trace *trace)
 		evsel = perf_evlist__find_tracepoint_by_name(session->evlist,
 							     "syscalls:sys_exit");
 	if (evsel &&
-	    (perf_evsel__init_syscall_tp(evsel, trace__sys_exit) < 0 ||
+	    (perf_evsel__init_raw_syscall_tp(evsel, trace__sys_exit) < 0 ||
 	    perf_evsel__init_sc_tp_uint_field(evsel, ret))) {
 		pr_err("Error during initialize raw_syscalls:sys_exit event\n");
 		goto out;
-- 
2.14.4
