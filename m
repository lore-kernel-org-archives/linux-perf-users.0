From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/63] perf augmented_syscalls: Switch to using a struct for the syscalls map values
Date: Tue, 18 Dec 2018 19:06:54 -0300
Message-ID: <20181218220733.15839-25-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll start adding more perf-syscall stuff, so lets do this prep step so
that the next ones are just about adding more fields.

Run it with the .c file once to cache the .o file:

  # trace --filter-pids 2834,2199 -e openat,augmented_raw_syscalls.c
  LLVM: dumping augmented_raw_syscalls.o
       0.000 ( 0.021 ms): tmux: server/4952 openat(dfd: CWD, filename: /proc/5691/cmdline                         ) = 11
     349.807 ( 0.040 ms): DNS Res~er #39/11082 openat(dfd: CWD, filename: /etc/hosts, flags: CLOEXEC                 ) = 44
    4988.759 ( 0.052 ms): gsd-color/2431 openat(dfd: CWD, filename: /etc/localtime                             ) = 18
    4988.976 ( 0.029 ms): gsd-color/2431 openat(dfd: CWD, filename: /etc/localtime                             ) = 18
  ^C[root@quaco bpf]#

From now on, we can use just the newly built .o file, skipping the
compilation step for a faster startup:

  # trace --filter-pids 2834,2199 -e openat,augmented_raw_syscalls.o
       0.000 ( 0.046 ms): DNS Res~er #39/11088 openat(dfd: CWD, filename: /etc/hosts, flags: CLOEXEC                 ) = 44
    1946.408 ( 0.190 ms): systemd/1 openat(dfd: CWD, filename: /proc/1071/cgroup, flags: CLOEXEC          ) = 20
    1946.792 ( 0.215 ms): systemd/1 openat(dfd: CWD, filename: /proc/954/cgroup, flags: CLOEXEC           ) = 20
  ^C#

Now on to do the same in the builtin-trace.c side of things.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-k8mwu04l8es29rje5loq9vg7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/examples/bpf/augmented_raw_syscalls.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index bb3dcc4ec256..a91c5874433e 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -26,10 +26,14 @@ struct bpf_map SEC("maps") __augmented_syscalls__ = {
 	.max_entries = __NR_CPUS__,
 };
 
+struct syscall {
+	bool	enabled;
+};
+
 struct bpf_map SEC("maps") syscalls = {
 	.type	     = BPF_MAP_TYPE_ARRAY,
 	.key_size    = sizeof(int),
-	.value_size  = sizeof(bool),
+	.value_size  = sizeof(struct syscall),
 	.max_entries = 512,
 };
 
@@ -63,7 +67,7 @@ int sys_enter(struct syscall_enter_args *args)
 		struct syscall_enter_args args;
 		struct augmented_filename filename;
 	} augmented_args;
-	bool *enabled;
+	struct syscall *syscall;
 	unsigned int len = sizeof(augmented_args);
 	const void *filename_arg = NULL;
 
@@ -72,8 +76,8 @@ int sys_enter(struct syscall_enter_args *args)
 
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
 
-	enabled = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
-	if (enabled == NULL || !*enabled)
+	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
+	if (syscall == NULL || !syscall->enabled)
 		return 0;
 	/*
 	 * Yonghong and Edward Cree sayz:
@@ -144,15 +148,15 @@ SEC("raw_syscalls:sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
-	bool *enabled;
+	struct syscall *syscall;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
 	probe_read(&exit_args, sizeof(exit_args), args);
 
-	enabled = bpf_map_lookup_elem(&syscalls, &exit_args.syscall_nr);
-	if (enabled == NULL || !*enabled)
+	syscall = bpf_map_lookup_elem(&syscalls, &exit_args.syscall_nr);
+	if (syscall == NULL || !syscall->enabled)
 		return 0;
 
 	return 1;
-- 
2.19.2
