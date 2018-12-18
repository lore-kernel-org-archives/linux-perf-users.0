From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/63] perf trace: Make the alignment of the syscall args be configurable
Date: Tue, 18 Dec 2018 19:07:12 -0300
Message-ID: <20181218220733.15839-43-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since the start 'perf trace' aligns the parens enclosing the list of
syscall args to align the syscall results, allow this to be
configurable, keeping the default of 70. Using:

  # perf config
  llvm.dump-obj=true
  trace.add_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=yes
  trace.show_duration=no
  trace.no_inherit=yes
  trace.show_timestamp=no
  trace.show_arg_names=no
  trace.args_alignment=0
  # trace -e open*,close,*sleep sleep 1
  openat(CWD, /etc/ld.so.cache, CLOEXEC) = 3
  close(3) = 0
  openat(CWD, /lib64/libc.so.6, CLOEXEC) = 3
  close(3) = 0
  openat(CWD, /usr/lib/locale/locale-archive, CLOEXEC) = 3
  close(3) = 0
  nanosleep(0x7ffc00de66f0, 0) = 0
  close(1) = 0
  close(2) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-r8cbhoz1lr5npq9tutpvoigr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  4 ++++
 tools/perf/builtin-trace.c               | 12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 35108fd61fa6..0098eab8e5b1 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -529,6 +529,10 @@ trace.*::
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
 
+	trace.args_alignment::
+		Number of columns to align the argument list, default is 70,
+		use 40 for the strace default, zero to no alignment.
+
 	trace.no_inherit::
 		Do not follow children threads.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 95dfcb851604..2d8fd48a4727 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	s16			args_alignment;
 	bool			show_tstamp;
 	bool			show_duration;
 	bool			show_zeros;
@@ -1731,7 +1732,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 		return 0;
 
 	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
-	printed += fprintf(trace->output, "%-70s) ...\n", ttrace->entry_str);
+	printed += fprintf(trace->output, "%-*s) ...\n", trace->args_alignment, ttrace->entry_str);
 	ttrace->entry_pending = false;
 
 	++trace->nr_events_printed;
@@ -1838,7 +1839,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	if (sc->is_exit) {
 		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
 			trace__fprintf_entry_head(trace, thread, 0, false, ttrace->entry_time, trace->output);
-			fprintf(trace->output, "%-70s)\n", ttrace->entry_str);
+			fprintf(trace->output, "%-*s)\n", trace->args_alignment, ttrace->entry_str);
 		}
 	} else {
 		ttrace->entry_pending = true;
@@ -1981,7 +1982,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
 
 	if (ttrace->entry_pending) {
-		fprintf(trace->output, "%-70s", ttrace->entry_str);
+		fprintf(trace->output, "%-*s", trace->args_alignment, ttrace->entry_str);
 	} else {
 		fprintf(trace->output, " ... [");
 		color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
@@ -3563,6 +3564,10 @@ static int trace__config(const char *var, const char *value, void *arg)
 		trace->show_zeros = new_show_zeros;
 	} else if (!strcmp(var, "trace.no_inherit")) {
 		trace->opts.no_inherit = perf_config_bool(var, value);
+	} else if (!strcmp(var, "trace.args_alignment")) {
+		int args_alignment = 0;
+		if (perf_config_int(&args_alignment, var, value) == 0)
+			trace->args_alignment = args_alignment;
 	}
 out:
 	return err;
@@ -3596,6 +3601,7 @@ int cmd_trace(int argc, const char **argv)
 		.show_tstamp = true,
 		.show_duration = true,
 		.show_arg_names = true,
+		.args_alignment = 70,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
-- 
2.19.2
