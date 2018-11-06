From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/18] perf examples bpf: Start augmenting raw_syscalls:sys_{start,exit}
Date: Tue,  6 Nov 2018 09:05:56 -0300
Message-ID: <20181106120612.8262-3-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The previous approach of attaching to each syscall showed how it is
possible to augment tracepoints and use that augmentation, pointer
payloads, in the existing beautifiers in 'perf trace', but for a more
general solution we now will try to augment the main
raw_syscalls:sys_{enter,exit} syscalls, and then pass instructions in
maps so that it knows which syscalls and which pointer contents, and how
many bytes for each of the arguments should be copied.

Start with just the bare minimum to collect what is provided by those
two tracepoints via the __augmented_syscalls__ map + bpf-output perf
event, which results in perf trace showing them without connecting
enter+exit:

  # perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
     0.000 sleep/11563 raw_syscalls:sys_exit:NR 59 = 0
     0.019 (         ): sleep/11563 brk() ...
     0.021 sleep/11563 raw_syscalls:sys_exit:NR 12 = 94682642325504
     0.033 (         ): sleep/11563 access(filename:, mode: R) ...
     0.037 sleep/11563 raw_syscalls:sys_exit:NR 21 = -2
     0.041 (         ): sleep/11563 openat(dfd: CWD, filename: , flags: CLOEXEC) ...
     0.044 sleep/11563 raw_syscalls:sys_exit:NR 257 = 3
     0.045 (         ): sleep/11563 fstat(fd: 3, statbuf: 0x7ffdbf7119b0) ...
     0.046 sleep/11563 raw_syscalls:sys_exit:NR 5 = 0
     0.047 (         ): sleep/11563 mmap(len: 103334, prot: READ, flags: PRIVATE, fd: 3) ...
     0.049 sleep/11563 raw_syscalls:sys_exit:NR 9 = 140196285493248
     0.050 (         ): sleep/11563 close(fd: 3) ...
     0.051 sleep/11563 raw_syscalls:sys_exit:NR 3 = 0
     0.059 (         ): sleep/11563 openat(dfd: CWD, filename: , flags: CLOEXEC) ...
     0.062 sleep/11563 raw_syscalls:sys_exit:NR 257 = 3
     0.063 (         ): sleep/11563 read(fd: 3, buf: 0x7ffdbf711b78, count: 832) ...
     0.065 sleep/11563 raw_syscalls:sys_exit:NR 0 = 832
     0.066 (         ): sleep/11563 fstat(fd: 3, statbuf: 0x7ffdbf711a10) ...
     0.067 sleep/11563 raw_syscalls:sys_exit:NR 5 = 0
     0.068 (         ): sleep/11563 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) ...
     0.070 sleep/11563 raw_syscalls:sys_exit:NR 9 = 140196285485056
     0.073 (         ): sleep/11563 mmap(len: 3889792, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3) ...
     0.076 sleep/11563 raw_syscalls:sys_exit:NR 9 = 140196279463936
     0.077 (         ): sleep/11563 mprotect(start: 0x7f81fd8a8000, len: 2093056) ...
     0.083 sleep/11563 raw_syscalls:sys_exit:NR 10 = 0
     0.084 (         ): sleep/11563 mmap(addr: 0x7f81fdaa7000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 1753088) ...
     0.088 sleep/11563 raw_syscalls:sys_exit:NR 9 = 140196283314176
     0.091 (         ): sleep/11563 mmap(addr: 0x7f81fdaad000, len: 14976, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) ...
     0.093 sleep/11563 raw_syscalls:sys_exit:NR 9 = 140196283338752
     0.097 (         ): sleep/11563 close(fd: 3) ...
     0.098 sleep/11563 raw_syscalls:sys_exit:NR 3 = 0
     0.107 (         ): sleep/11563 arch_prctl(option: 4098, arg2: 140196285490432) ...
     0.108 sleep/11563 raw_syscalls:sys_exit:NR 158 = 0
     0.143 (         ): sleep/11563 mprotect(start: 0x7f81fdaa7000, len: 16384, prot: READ) ...
     0.146 sleep/11563 raw_syscalls:sys_exit:NR 10 = 0
     0.157 (         ): sleep/11563 mprotect(start: 0x561d037e7000, len: 4096, prot: READ) ...
     0.160 sleep/11563 raw_syscalls:sys_exit:NR 10 = 0
     0.163 (         ): sleep/11563 mprotect(start: 0x7f81fdcd5000, len: 4096, prot: READ) ...
     0.165 sleep/11563 raw_syscalls:sys_exit:NR 10 = 0
     0.166 (         ): sleep/11563 munmap(addr: 0x7f81fdcbb000, len: 103334) ...
     0.174 sleep/11563 raw_syscalls:sys_exit:NR 11 = 0
     0.216 (         ): sleep/11563 brk() ...
     0.217 sleep/11563 raw_syscalls:sys_exit:NR 12 = 94682642325504
     0.217 (         ): sleep/11563 brk(brk: 0x561d05453000) ...
     0.219 sleep/11563 raw_syscalls:sys_exit:NR 12 = 94682642460672
     0.220 (         ): sleep/11563 brk() ...
     0.221 sleep/11563 raw_syscalls:sys_exit:NR 12 = 94682642460672
     0.224 (         ): sleep/11563 open(filename: , flags: CLOEXEC) ...
     0.228 sleep/11563 raw_syscalls:sys_exit:NR 2 = 3
     0.229 (         ): sleep/11563 fstat(fd: 3, statbuf: 0x7f81fdaacaa0) ...
     0.230 sleep/11563 raw_syscalls:sys_exit:NR 5 = 0
     0.231 (         ): sleep/11563 mmap(len: 113045344, prot: READ, flags: PRIVATE, fd: 3) ...
     0.234 sleep/11563 raw_syscalls:sys_exit:NR 9 = 140196166418432
     0.237 (         ): sleep/11563 close(fd: 3) ...
     0.238 sleep/11563 raw_syscalls:sys_exit:NR 3 = 0
     0.262 (         ): sleep/11563 nanosleep(rqtp: 0x7ffdbf7126f0) ...
  1000.399 sleep/11563 raw_syscalls:sys_exit:NR 35 = 0
  1000.440 (         ): sleep/11563 close(fd: 1) ...
  1000.447 sleep/11563 raw_syscalls:sys_exit:NR 3 = 0
  1000.454 (         ): sleep/11563 close(fd: 2) ...
  1000.468 (         ): sleep/11563 exit_group(                                                           )
  #

In the next csets we'll connect those events to the existing enter/exit
raw_syscalls handlers in 'perf trace', just like we did with the
syscalls:sys_{enter,exit}_* tracepoints.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-5nl8l4hx1tl9pqdx65nkp6pw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 tools/perf/examples/bpf/augmented_raw_syscalls.c

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
new file mode 100644
index 000000000000..cde91c34b101
--- /dev/null
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Augment the raw_syscalls tracepoints with the contents of the pointer arguments.
+ *
+ * Test it with:
+ *
+ * perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c cat /etc/passwd > /dev/null
+ *
+ * This exactly matches what is marshalled into the raw_syscall:sys_enter
+ * payload expected by the 'perf trace' beautifiers.
+ *
+ * For now it just uses the existing tracepoint augmentation code in 'perf
+ * trace', in the next csets we'll hook up these with the sys_enter/sys_exit
+ * code that will combine entry/exit in a strace like way.
+ */
+
+#include <stdio.h>
+#include <linux/socket.h>
+
+/* bpf-output associated map */
+struct bpf_map SEC("maps") __augmented_syscalls__ = {
+	.type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+	.key_size = sizeof(int),
+	.value_size = sizeof(u32),
+	.max_entries = __NR_CPUS__,
+};
+
+struct syscall_enter_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	unsigned long	   args[6];
+};
+
+struct syscall_exit_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   ret;
+};
+
+SEC("raw_syscalls:sys_enter")
+int sys_enter(struct syscall_enter_args *args)
+{
+	struct {
+		struct syscall_enter_args args;
+	} augmented_args;
+	unsigned int len = sizeof(augmented_args);
+
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, len);
+	return 0;
+}
+
+SEC("raw_syscalls:sys_exit")
+int sys_exit(struct syscall_exit_args *args)
+{
+	return 1; /* 0 as soon as we start copying data returned by the kernel, e.g. 'read' */
+}
+
+license(GPL);
-- 
2.14.4
