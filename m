From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/44] perf bpf: Add bpf/stdio.h wrapper to bpf_perf_event_output function
Date: Thu,  9 Aug 2018 11:58:12 -0300
Message-ID: <20180809145822.21391-35-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That, together with the map __bpf_output__ that is already handled by
'perf trace' to print that event's contents as strings provides a
debugging facility, to show it in use, print a simple string everytime
the syscalls:sys_enter_openat() syscall tracepoint is hit:

  # cat tools/perf/examples/bpf/hello.c
  #include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
	  puts("Hello, world\n");
	  return 0;
  }

  license(GPL);
  #
  # perf trace -e openat,tools/perf/examples/bpf/hello.c cat /etc/passwd > /dev/null
     0.016 (         ): __bpf_stdout__:Hello, world
     0.018 ( 0.010 ms): cat/9079 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
     0.057 (         ): __bpf_stdout__:Hello, world
     0.059 ( 0.011 ms): cat/9079 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
     0.417 (         ): __bpf_stdout__:Hello, world
     0.419 ( 0.009 ms): cat/9079 openat(dfd: CWD, filename: /etc/passwd) = 3
  #

This is part of an ongoing experimentation on making eBPF scripts as
consumed by perf to be as concise as possible and using familiar
concepts such as stdio.h functions, that end up just wrapping the
existing BPF functions, trying to hide as much boilerplate as possible
while using just conventions and C preprocessor tricks.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4tiaqlx5crf0fwpe7a6j84x7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/hello.c |  9 +++++++++
 tools/perf/include/bpf/stdio.h  | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tools/perf/examples/bpf/hello.c
 create mode 100644 tools/perf/include/bpf/stdio.h

diff --git a/tools/perf/examples/bpf/hello.c b/tools/perf/examples/bpf/hello.c
new file mode 100644
index 000000000000..cf3c2fdc7f79
--- /dev/null
+++ b/tools/perf/examples/bpf/hello.c
@@ -0,0 +1,9 @@
+#include <stdio.h>
+
+int syscall_enter(openat)(void *args)
+{
+	puts("Hello, world\n");
+	return 0;
+}
+
+license(GPL);
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
new file mode 100644
index 000000000000..2899cb7bfed8
--- /dev/null
+++ b/tools/perf/include/bpf/stdio.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <bpf.h>
+
+struct bpf_map SEC("maps") __bpf_stdout__ = {
+       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+       .key_size = sizeof(int),
+       .value_size = sizeof(u32),
+       .max_entries = __NR_CPUS__,
+};
+
+static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) =
+	(void *)BPF_FUNC_perf_event_output;
+
+#define puts(from) \
+	({ const int __len = sizeof(from); \
+	   char __from[__len] = from; \
+	   perf_event_output(args, &__bpf_stdout__, BPF_F_CURRENT_CPU, \
+			  &__from, __len & (sizeof(from) - 1)); })
-- 
2.14.4
