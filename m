From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/28] perf augmented_syscalls: Filter on a hard coded pid
Date: Thu, 22 Nov 2018 00:35:45 -0300
Message-ID: <20181122033611.15890-3-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just to show where we'll hook pid based filters, and what we use to
obtain the current pid, using a BPF getpid() equivalent.

Now we need to remove that hardcoded PID with a BPF hash map, so that we
start by filtering 'perf trace's own PID, implement the --filter-pid
functionality, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-oshrcgcekiyhd0whwisxfvtv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 90a19336310b..2feb00018f79 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -15,6 +15,7 @@
  */
 
 #include <stdio.h>
+#include <unistd.h>
 #include <linux/socket.h>
 
 /* bpf-output associated map */
@@ -56,6 +57,9 @@ int sys_enter(struct syscall_enter_args *args)
 	unsigned int len = sizeof(augmented_args);
 	const void *filename_arg = NULL;
 
+	if (getpid() == 2971)
+		return 0;
+
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
 	/*
 	 * Yonghong and Edward Cree sayz:
@@ -125,7 +129,7 @@ int sys_enter(struct syscall_enter_args *args)
 SEC("raw_syscalls:sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
-	return 1; /* 0 as soon as we start copying data returned by the kernel, e.g. 'read' */
+	return getpid() != 2971;
 }
 
 license(GPL);
-- 
2.14.5
