From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/63] perf trace: Implement syscall filtering in augmented_syscalls
Date: Tue, 18 Dec 2018 19:06:52 -0300
Message-ID: <20181218220733.15839-23-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just another map, this time an BPF_MAP_TYPE_ARRAY, stating with
one bool per syscall, stating if it should be filtered or not.

So, with a pre-built augmented_raw_syscalls.o file, we use:

  # perf trace -e open*,augmented_raw_syscalls.o
     0.000 ( 0.016 ms): DNS Res~er #37/29652 openat(dfd: CWD, filename: /etc/hosts, flags: CLOEXEC                 ) = 138
   187.039 ( 0.048 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC                 ) = 11
   187.348 ( 0.041 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /proc/self/mountinfo, flags: CLOEXEC       ) = 11
   188.793 ( 0.036 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /proc/self/mountinfo, flags: CLOEXEC       ) = 11
   189.803 ( 0.029 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /proc/self/mountinfo, flags: CLOEXEC       ) = 11
   190.774 ( 0.027 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /proc/self/mountinfo, flags: CLOEXEC       ) = 11
   284.620 ( 0.149 ms): DataStorage/3076 openat(dfd: CWD, filename: /home/acme/.mozilla/firefox/ina67tev.default/SiteSecurityServiceState.txt, flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUSR|IWGRP) = 167
  ^C#

What is it that this gsd-housekeeping thingy needs to open
/proc/self/mountinfo four times periodically? :-)

This map will be extended to tell per-syscall parameters, i.e. how many
bytes to copy per arg, using the function signature to get the types and
then the size of those types, via BTF.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-cy222g9ucvnym3raqvxp0hpg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                    | 66 +++++++++++++++++++
 .../examples/bpf/augmented_raw_syscalls.c     | 26 +++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f9eb5bc4fefb..de81918c7ad4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -76,6 +76,7 @@ struct trace {
 	struct {
 		int		max;
 		struct syscall  *table;
+		struct bpf_map  *map;
 		struct {
 			struct perf_evsel *sys_enter,
 					  *sys_exit,
@@ -2578,8 +2579,64 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 	goto out;
 }
 
+#ifdef HAVE_LIBBPF_SUPPORT
+static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
+{
+	int fd = bpf_map__fd(trace->syscalls.map);
+	bool value = !trace->not_ev_qualifier;
+	int err = 0;
+	size_t i;
+
+	for (i = 0; i < trace->ev_qualifier_ids.nr; ++i) {
+		int key = trace->ev_qualifier_ids.entries[i];
+
+		err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
+{
+	int fd = bpf_map__fd(trace->syscalls.map);
+	int err = 0, key;
+
+	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
+		err = bpf_map_update_elem(fd, &key, &enabled, BPF_ANY);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int trace__init_syscalls_bpf_map(struct trace *trace)
+{
+	bool enabled = true;
+
+	if (trace->ev_qualifier_ids.nr)
+		enabled = trace->not_ev_qualifier;
+
+	return __trace__init_syscalls_bpf_map(trace, enabled);
+}
+#else
+static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
+{
+	return 0;
+}
+
+static int trace__init_syscalls_bpf_map(struct trace *trace __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+
 static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
+	if (trace->syscalls.map)
+		return trace__set_ev_qualifier_bpf_filter(trace);
 	return trace__set_ev_qualifier_tp_filter(trace);
 }
 
@@ -2822,6 +2879,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_mem;
 
+	if (trace->syscalls.map)
+		trace__init_syscalls_bpf_map(trace);
+
 	if (trace->ev_qualifier_ids.nr > 0) {
 		err = trace__set_ev_qualifier_filter(trace);
 		if (err < 0)
@@ -3449,6 +3509,11 @@ static void trace__set_bpf_map_filtered_pids(struct trace *trace)
 	trace->filter_pids.map = bpf__find_map_by_name("pids_filtered");
 }
 
+static void trace__set_bpf_map_syscalls(struct trace *trace)
+{
+	trace->syscalls.map = bpf__find_map_by_name("syscalls");
+}
+
 int cmd_trace(int argc, const char **argv)
 {
 	const char *trace_usage[] = {
@@ -3589,6 +3654,7 @@ int cmd_trace(int argc, const char **argv)
 	if (evsel) {
 		trace.syscalls.events.augmented = evsel;
 		trace__set_bpf_map_filtered_pids(&trace);
+		trace__set_bpf_map_syscalls(&trace);
 	}
 
 	err = bpf__setup_stdout(trace.evlist);
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 74ce7574073d..bb3dcc4ec256 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -26,6 +26,13 @@ struct bpf_map SEC("maps") __augmented_syscalls__ = {
 	.max_entries = __NR_CPUS__,
 };
 
+struct bpf_map SEC("maps") syscalls = {
+	.type	     = BPF_MAP_TYPE_ARRAY,
+	.key_size    = sizeof(int),
+	.value_size  = sizeof(bool),
+	.max_entries = 512,
+};
+
 struct syscall_enter_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
@@ -56,6 +63,7 @@ int sys_enter(struct syscall_enter_args *args)
 		struct syscall_enter_args args;
 		struct augmented_filename filename;
 	} augmented_args;
+	bool *enabled;
 	unsigned int len = sizeof(augmented_args);
 	const void *filename_arg = NULL;
 
@@ -63,6 +71,10 @@ int sys_enter(struct syscall_enter_args *args)
 		return 0;
 
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+
+	enabled = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
+	if (enabled == NULL || !*enabled)
+		return 0;
 	/*
 	 * Yonghong and Edward Cree sayz:
 	 *
@@ -131,7 +143,19 @@ int sys_enter(struct syscall_enter_args *args)
 SEC("raw_syscalls:sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
-	return !pid_filter__has(&pids_filtered, getpid());
+	struct syscall_exit_args exit_args;
+	bool *enabled;
+
+	if (pid_filter__has(&pids_filtered, getpid()))
+		return 0;
+
+	probe_read(&exit_args, sizeof(exit_args), args);
+
+	enabled = bpf_map_lookup_elem(&syscalls, &exit_args.syscall_nr);
+	if (enabled == NULL || !*enabled)
+		return 0;
+
+	return 1;
 }
 
 license(GPL);
-- 
2.19.2
