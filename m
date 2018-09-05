From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/77] perf trace: Extract the comm/tid printing for syscall enter
Date: Wed,  5 Sep 2018 19:03:27 -0300
Message-ID: <20180905220440.20256-5-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used with augmented syscalls, where we haven't transitioned
completely to combining sys_enter_FOO with sys_exit_FOO, so we'll go
as far as having it similar to the end result, strace like, as possible.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-canomaoiybkswwnhj69u9ae4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bcf882afd6d0..92488edd00eb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1144,11 +1144,9 @@ static void sig_handler(int sig)
 	interrupted = sig == SIGINT;
 }
 
-static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
-					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
+static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread, FILE *fp)
 {
-	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
-	printed += fprintf_duration(duration, duration_calculated, fp);
+	size_t printed = 0;
 
 	if (trace->multiple_threads) {
 		if (trace->show_comm)
@@ -1159,6 +1157,14 @@ static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thre
 	return printed;
 }
 
+static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
+					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
+{
+	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
+	printed += fprintf_duration(duration, duration_calculated, fp);
+	return printed + trace__fprintf_comm_tid(trace, thread, fp);
+}
+
 static int trace__process_event(struct trace *trace, struct machine *machine,
 				union perf_event *event, struct perf_sample *sample)
 {
-- 
2.14.4
