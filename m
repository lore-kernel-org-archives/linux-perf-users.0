From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/77] perf trace: Make the augmented_syscalls filter out the tracepoint event
Date: Wed,  5 Sep 2018 19:03:25 -0300
Message-ID: <20180905220440.20256-3-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we attach a eBPF object to a tracepoint, if we return 1, then that
tracepoint will be stored in the perf's ring buffer. In the
augmented_syscalls.c case we want to just attach and _override_ the
tracepoint payload with an augmented, extended one.

In this example, tools/perf/examples/bpf/augmented_syscalls.c, we are
attaching to the 'openat' syscall, and adding, after the
syscalls:sys_enter_openat usual payload as defined by
/sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format, a
snapshot of its sole pointer arg:

  # grep 'field:.*\*' /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format
	field:const char * filename;	offset:24;	size:8;	signed:0;
  #

For now this is not being considered, the next csets will make use of
it, but as this is overriding the syscall tracepoint enter, we don't
want that event appearing on the ring buffer, just our synthesized one.

Before:

  # perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC
     0.006 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: , flags: CLOEXEC
     0.007 ( 0.004 ms): cat/24044 openat(dfd: CWD, filename: 0x216dda8, flags: CLOEXEC                  ) = 3
     0.028 (         ): __augmented_syscalls__:dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC
     0.030 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: , flags: CLOEXEC
     0.031 ( 0.006 ms): cat/24044 openat(dfd: CWD, filename: 0x2375ce0, flags: CLOEXEC                  ) = 3
     0.291 (         ): __augmented_syscalls__:dfd: CWD, filename: /etc/passwd
     0.293 (         ): syscalls:sys_enter_openat:dfd: CWD, filename:
     0.294 ( 0.004 ms): cat/24044 openat(dfd: CWD, filename: 0x637db06b                                 ) = 3
  #

After:

  # perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x9c6a1da8, flags: CLOEXEC
     0.005 ( 0.015 ms): cat/27341 openat(dfd: CWD, filename: 0x9c6a1da8, flags: CLOEXEC                 ) = 3
     0.040 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x9c8a9ce0, flags: CLOEXEC
     0.041 ( 0.006 ms): cat/27341 openat(dfd: CWD, filename: 0x9c8a9ce0, flags: CLOEXEC                 ) = 3
     0.294 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x482a706b
     0.296 ( 0.067 ms): cat/27341 openat(dfd: CWD, filename: 0x482a706b                                 ) = 3
  #

Now lets replace that __augmented_syscalls__ name with the syscall name,
using:

  # grep 'field:.*syscall_nr' /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format
	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
  #

That the synthesized payload has exactly where the syscall enter
tracepoint puts it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-og4r9k87mzp9hv7el046idmd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 69a31386d8cd..10e7997ab481 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -49,7 +49,7 @@ int syscall_enter(openat)(struct syscall_enter_openat_args *args)
 	probe_read_str(&augmented_args.filename, sizeof(augmented_args.filename), args->filename_ptr);
 	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
 			  &augmented_args, sizeof(augmented_args));
-	return 1;
+	return 0;
 }
 
 license(GPL);
-- 
2.14.4
