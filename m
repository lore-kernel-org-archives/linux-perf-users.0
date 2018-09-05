From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/77] perf trace augmented_syscalls: Hook into syscalls:sys_exit_SYSCALL too
Date: Wed,  5 Sep 2018 19:03:47 -0300
Message-ID: <20180905220440.20256-25-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hook the pair enter/exit when using augmented_{filename,sockaddr,etc}_syscall(),
this way we'll be able to see what entries are in the ELF sections generated
from augmented_syscalls.c and filter them out from the main raw_syscalls:*
tracepoints used by 'perf trace'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-cyav42qj5yylolw4attcw99z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 253b3ccbd17d..1419a9186937 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -26,6 +26,12 @@ struct bpf_map SEC("maps") __augmented_syscalls__ = {
        .max_entries = __NR_CPUS__,
 };
 
+struct syscall_exit_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   ret;
+};
+
 struct augmented_filename {
 	int	size;
 	int	reserved;
@@ -49,6 +55,10 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 			  (sizeof(augmented_args) - sizeof(augmented_args.filename.value) +	\
 			   augmented_args.filename.size));					\
 	return 0;										\
+}												\
+int syscall_exit(syscall)(struct syscall_exit_args *args)					\
+{												\
+       return 1; /* 0 as soon as we start copying data returned by the kernel, e.g. 'read' */	\
 }
 
 struct syscall_enter_openat_args {
@@ -116,6 +126,10 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 			  &augmented_args, 							\
 			  sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);	\
 	return 0;										\
+}												\
+int syscall_exit(syscall)(struct syscall_exit_args *args)					\
+{												\
+       return 1; /* 0 as soon as we start copying data returned by the kernel, e.g. 'read' */	\
 }
 
 struct sockaddr;
-- 
2.14.4
