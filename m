From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/37] perf trace: Put the per-syscall entry/exit prog_array BPF map infrastructure in place
Date: Mon, 22 Jul 2019 14:38:11 -0300
Message-ID: <20190722173839.22898-10-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.e. look for "syscalls_sys_enter" and "syscalls_sys_exit" BPF maps of
type PROG_ARRAY and populate it with the handlers as specified per
syscall, for now only 'open' is wiring it to something, in time all
syscalls that need to copy arguments entering a syscall or returning
from one will set these to the right handlers, reusing when possible
pre-existing ones.

Next step is to use bpf_tail_call() into that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-t0p4u43i9vbpzs1xtowna3gb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                    | 76 ++++++++++++++++++-
 .../examples/bpf/augmented_raw_syscalls.c     | 14 ++++
 2 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6cc696edf24a..fb8b8e78d7b5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0-only
 /*
  * builtin-trace.c
  *
@@ -83,6 +82,10 @@ struct trace {
 		int		max;
 		struct syscall  *table;
 		struct bpf_map  *map;
+		struct { // per syscall BPF_MAP_TYPE_PROG_ARRAY
+			struct bpf_map  *sys_enter,
+					*sys_exit;
+		}		prog_array;
 		struct {
 			struct perf_evsel *sys_enter,
 					  *sys_exit,
@@ -1619,6 +1622,22 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 	goto out;
 }
 
+static __maybe_unused bool trace__syscall_enabled(struct trace *trace, int id)
+{
+	bool in_ev_qualifier;
+
+	if (trace->ev_qualifier_ids.nr == 0)
+		return true;
+
+	in_ev_qualifier = bsearch(&id, trace->ev_qualifier_ids.entries,
+				  trace->ev_qualifier_ids.nr, sizeof(int), intcmp) != NULL;
+
+	if (in_ev_qualifier)
+	       return !trace->not_ev_qualifier;
+
+	return trace->not_ev_qualifier;
+}
+
 /*
  * args is to be interpreted as a series of longs but we need to handle
  * 8-byte unaligned accesses. args points to raw_data within the event
@@ -2784,6 +2803,18 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
 	}
 }
 
+static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
+{
+	struct syscall *sc = trace__syscall_info(trace, NULL, id);
+	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(trace->syscalls.unaugmented_prog);
+}
+
+static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
+{
+	struct syscall *sc = trace__syscall_info(trace, NULL, id);
+	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->syscalls.unaugmented_prog);
+}
+
 static void trace__init_bpf_map_syscall_args(struct trace *trace, int id, struct bpf_map_syscall_entry *entry)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, id);
@@ -2837,10 +2868,8 @@ static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
 	int err = 0, key;
 
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		if (enabled) {
+		if (enabled)
 			trace__init_bpf_map_syscall_args(trace, key, &value);
-			trace__init_syscall_bpf_progs(trace, key);
-		}
 
 		err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
 		if (err)
@@ -2859,6 +2888,34 @@ static int trace__init_syscalls_bpf_map(struct trace *trace)
 
 	return __trace__init_syscalls_bpf_map(trace, enabled);
 }
+
+static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
+{
+	int map_enter_fd = bpf_map__fd(trace->syscalls.prog_array.sys_enter),
+	    map_exit_fd  = bpf_map__fd(trace->syscalls.prog_array.sys_exit);
+	int err = 0, key;
+
+	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
+		int prog_fd;
+
+		if (!trace__syscall_enabled(trace, key))
+			continue;
+
+		trace__init_syscall_bpf_progs(trace, key);
+
+		// It'll get at least the "!raw_syscalls:unaugmented"
+		prog_fd = trace__bpf_prog_sys_enter_fd(trace, key);
+		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
+		if (err)
+			break;
+		prog_fd = trace__bpf_prog_sys_exit_fd(trace, key);
+		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
+		if (err)
+			break;
+	}
+
+	return err;
+}
 #else
 static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
 {
@@ -2875,6 +2932,11 @@ static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace
 {
 	return NULL;
 }
+
+static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace __maybe_unused)
+{
+	return 0;
+}
 #endif // HAVE_LIBBPF_SUPPORT
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
@@ -3129,6 +3191,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->syscalls.map)
 		trace__init_syscalls_bpf_map(trace);
 
+	if (trace->syscalls.prog_array.sys_enter)
+		trace__init_syscalls_bpf_prog_array_maps(trace);
+
+
 	if (trace->ev_qualifier_ids.nr > 0) {
 		err = trace__set_ev_qualifier_filter(trace);
 		if (err < 0)
@@ -3754,6 +3820,8 @@ static void trace__set_bpf_map_filtered_pids(struct trace *trace)
 static void trace__set_bpf_map_syscalls(struct trace *trace)
 {
 	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
+	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
+	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
 }
 
 static int trace__config(const char *var, const char *value, void *arg)
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 66b33b299349..c66474a6ccf4 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -33,6 +33,20 @@ struct syscall {
 
 bpf_map(syscalls, ARRAY, int, struct syscall, 512);
 
+/*
+ * What to augment at entry?
+ *
+ * Pointer arg payloads (filenames, etc) passed from userspace to the kernel
+ */
+bpf_map(syscalls_sys_enter, PROG_ARRAY, u32, u32, 512);
+
+/*
+ * What to augment at exit?
+ *
+ * Pointer arg payloads returned from the kernel (struct stat, etc) to userspace.
+ */
+bpf_map(syscalls_sys_exit, PROG_ARRAY, u32, u32, 512);
+
 struct syscall_enter_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
-- 
2.21.0
