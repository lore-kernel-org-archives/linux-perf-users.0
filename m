From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/44] perf trace: Use perf_evsel__sc_tp_{uint,ptr} for "id"/"args" handling syscalls:* events
Date: Thu,  9 Aug 2018 11:57:44 -0300
Message-ID: <20180809145822.21391-7-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now it looks just about the same as for the trace__sys_{enter,exit}.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-y59may7zx1eccnp4m3qm4u0b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 41799596c045..7232a7302580 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1693,20 +1693,13 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evsel,
 				    struct perf_sample *sample)
 {
-	struct format_field *field = perf_evsel__field(evsel, "__syscall_nr");
 	struct thread_trace *ttrace;
 	struct thread *thread;
-	struct syscall *sc;
+	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	struct syscall *sc = trace__syscall_info(trace, evsel, id);
 	char msg[1024];
-	int id, err = -1;
 	void *args;
 
-	if (field == NULL)
-		return -1;
-
-	id = format_field__intval(field, sample, evsel->needs_swap);
-	sc = trace__syscall_info(trace, evsel, id);
-
 	if (sc == NULL)
 		return -1;
 
@@ -1719,7 +1712,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 	if (ttrace == NULL)
 		goto out_put;
 
-	args = sample->raw_data + field->offset + sizeof(u64); /* skip __syscall_nr, there is where args are */
+	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
 	syscall__scnprintf_args(sc, msg, sizeof(msg), args, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
-- 
2.14.4
