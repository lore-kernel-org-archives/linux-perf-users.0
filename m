From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/17] perf trace: Allow dumping a BPF map after setting up BPF events
Date: Wed, 20 Feb 2019 22:25:43 -0300
Message-ID: <20190221012549.4069-12-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Initial use case:

Dumping the maps setup by tools/perf/examples/bpf/augmented_raw_syscalls.c,
which so far are just booleans, showing just non-zeroed entries:

  # cat ~/.perfconfig
  [llvm]
	dump-obj = true
	clang-opt = -g
  [trace]
	#add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
	add_events = /wb/augmented_raw_syscalls.o
  $ date
  Tue Feb 19 16:29:33 -03 2019
  $ ls -la /wb/augmented_raw_syscalls.o
  -rwxr-xr-x. 1 root root 14048 Jan 24 12:09 /wb/augmented_raw_syscalls.o
  $ file /wb/augmented_raw_syscalls.o
  /wb/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
  $
  # trace -e recvmmsg,sendmmsg --map-dump foobar
  ERROR: BPF map "foobar" not found
  # trace -e recvmmsg,sendmmsg --map-dump filtered_pids
  ERROR: BPF map "filtered_pids" not found
  # trace -e recvmmsg,sendmmsg --map-dump pids_filtered
  [2583] = 1,
  [2267] = 1,
  ^Z
  [1]+  Stopped                 trace -e recvmmsg,sendmmsg --map-dump pids_filtered
  # pidof trace
  2267
  # ps ax|grep gnome-terminal|grep -v grep
  2583 ?        Ssl   58:33 /usr/libexec/gnome-terminal-server
  ^C
  # trace -e recvmmsg,sendmmsg --map-dump syscalls
  [299] = 1,
  [307] = 1,
  ^C
  # grep x64_recvmmsg arch/x86/entry/syscalls/syscall_64.tbl
  299	64	recvmmsg		__x64_sys_recvmmsg
  # grep x64_sendmmsg arch/x86/entry/syscalls/syscall_64.tbl
  307	64	sendmmsg		__x64_sys_sendmmsg
  #

Next step probably will be something like 'perf stat's --interval-print and
--interval-clear.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-ztxj25rtx37ixo9cfajt8ocy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt |  8 ++++++++
 tools/perf/builtin-trace.c              | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 631e687be4eb..fc6e43262c41 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -210,6 +210,14 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	may happen, for instance, when a thread gets migrated to a different CPU
 	while processing a syscall.
 
+--map-dump::
+	Dump BPF maps setup by events passed via -e, for instance the augmented_raw_syscalls
+	living in tools/perf/examples/bpf/augmented_raw_syscalls.c. For now this
+	dumps just boolean map values and integer keys, in time this will print in hex
+	by default and use BTF when available, as well as use functions to do pretty
+	printing using the existing 'perf trace' syscall arg beautifiers to map integer
+	arguments to strings (pid to comm, syscall id to syscall name, etc).
+
 
 PAGEFAULTS
 ----------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 68a01e624ad3..1a11fe656afc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,7 @@
 #include <traceevent/event-parse.h>
 #include <api/fs/tracing_path.h>
 #include <bpf/bpf.h>
+#include "util/bpf_map.h"
 #include "builtin.h"
 #include "util/cgroup.h"
 #include "util/color.h"
@@ -87,6 +88,9 @@ struct trace {
 					  *augmented;
 		}		events;
 	} syscalls;
+	struct {
+		struct bpf_map *map;
+	} dump;
 	struct record_opts	opts;
 	struct perf_evlist	*evlist;
 	struct machine		*host;
@@ -2997,6 +3001,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_apply_filters;
 
+	if (trace->dump.map)
+		bpf_map__fprintf(trace->dump.map, trace->output);
+
 	err = perf_evlist__mmap(evlist, trace->opts.mmap_pages);
 	if (err < 0)
 		goto out_error_mmap;
@@ -3686,6 +3693,7 @@ int cmd_trace(int argc, const char **argv)
 		.max_stack = UINT_MAX,
 		.max_events = ULONG_MAX,
 	};
+	const char *map_dump_str = NULL;
 	const char *output_name = NULL;
 	const struct option trace_options[] = {
 	OPT_CALLBACK('e', "event", &trace, "event",
@@ -3718,6 +3726,9 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
+#ifdef HAVE_LIBBPF_SUPPORT
+	OPT_STRING(0, "map-dump", &map_dump_str, "BPF map", "BPF map to periodically dump"),
+#endif
 	OPT_BOOLEAN(0, "sched", &trace.sched, "show blocking scheduler events"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_BOOLEAN('T', "time", &trace.full_time,
@@ -3812,6 +3823,14 @@ int cmd_trace(int argc, const char **argv)
 
 	err = -1;
 
+	if (map_dump_str) {
+		trace.dump.map = bpf__find_map_by_name(map_dump_str);
+		if (trace.dump.map == NULL) {
+			pr_err("ERROR: BPF map \"%s\" not found\n", map_dump_str);
+			goto out;
+		}
+	}
+
 	if (trace.trace_pgfaults) {
 		trace.opts.sample_address = true;
 		trace.opts.sample_time = true;
-- 
2.19.1
