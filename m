From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/63] perf trace: Allow configuring if the syscall start timestamp should be printed
Date: Tue, 18 Dec 2018 19:07:10 -0300
Message-ID: <20181218220733.15839-41-acme@kernel.org>
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

  # trace -e open*,close,*sleep sleep 1
     0.000 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
     0.016 close(fd: 3                                                           ) = 0
     0.024 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
     0.074 close(fd: 3                                                           ) = 0
     0.235 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
     0.251 close(fd: 3                                                           ) = 0
     0.285 nanosleep(rqtp: 0x7ffd68e6d620, rmtp: 0                               ) = 0
  1000.386 close(fd: 1                                                           ) = 0
  1000.395 close(fd: 2                                                           ) = 0
  #

  # perf config trace.show_timestamp=no
  # trace -e open*,close,*sleep sleep 1
  openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: , flags: CLOEXEC                           ) = 3
  close(fd: 3                                                           ) = 0
  nanosleep(rqtp: 0x7fffa79c38e0, rmtp: 0                               ) = 0
  close(fd: 1                                                           ) = 0
  close(fd: 2                                                           ) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mjjnicy48367jah6ls4k0nk8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 3 +++
 tools/perf/builtin-trace.c               | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index cd9bf12fb255..ecd1e9514925 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -535,6 +535,9 @@ trace.*::
 	trace.show_duration::
 		Show syscall duration.
 
+	trace.show_timestamp::
+		Show syscall start timestamp.
+
 	trace.show_zeros::
 		Do not suppress syscall arguments that are equal to zero.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a4e2290e57e0..e978ce034863 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	bool			show_tstamp;
 	bool			show_duration;
 	bool			show_zeros;
 	bool			force;
@@ -1215,7 +1216,10 @@ static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread
 static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
 					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
 {
-	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
+	size_t printed = 0;
+
+	if (trace->show_tstamp)
+		printed = trace__fprintf_tstamp(trace, tstamp, fp);
 	if (trace->show_duration)
 		printed += fprintf_duration(duration, duration_calculated, fp);
 	return printed + trace__fprintf_comm_tid(trace, thread, fp);
@@ -3538,6 +3542,8 @@ static int trace__config(const char *var, const char *value, void *arg)
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
 		err = parse_events_option(&o, value, 0);
+	} else if (!strcmp(var, "trace.show_timestamp")) {
+		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
 		trace->show_duration = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_zeros")) {
@@ -3574,6 +3580,7 @@ int cmd_trace(int argc, const char **argv)
 		},
 		.output = stderr,
 		.show_comm = true,
+		.show_tstamp = true,
 		.show_duration = true,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
-- 
2.19.2
