From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/28] perf augmented_syscalls: Use pid_filter
Date: Thu, 22 Nov 2018 00:35:50 -0300
Message-ID: <20181122033611.15890-8-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just to test filtering a bunch of pids, now its time to go and get that
hooked up in 'perf trace', right after we load the bpf program, if we
find a "pids_filtered" map defined, we'll populate it with the filtered
pids.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1i9s27wqqdhafk3fappow84x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 34 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 7d729319618c..5fed1eff889d 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -16,6 +16,7 @@
 
 #include <stdio.h>
 #include <unistd.h>
+#include <pid_filter.h>
 
 /* bpf-output associated map */
 struct bpf_map SEC("maps") __augmented_syscalls__ = {
@@ -48,6 +49,29 @@ struct augmented_filename {
 #define SYS_POLL 7
 #define SYS_OPENAT 257
 
+pid_filter(pids_filtered);
+
+static void pid_filter__init(void)
+{
+	/*
+	 * Filter a bunch of pids: gnome-shell, kvm, firefox threads,
+	 * avahi-daemon, etc, just for testing as we go along.
+	 *
+	 * These will come from 'perf trace --filter-pids' in a explicit way
+	 * and also it will filter out itself, to avoid the feedback loop:
+	 * syscalls 'perf trace' does gets caught, reported, causing new
+	 * syscalls to get emitted, rinse repeat forever.
+	 */
+	if (pid_filter__add(&pids_filtered, 2971))
+		return; /* pid_filter__init() was already called, bail out */
+	pid_filter__add(&pids_filtered, 20016);
+	pid_filter__add(&pids_filtered, 12018);
+	pid_filter__add(&pids_filtered, 2310);
+	pid_filter__add(&pids_filtered, 3759);
+	pid_filter__add(&pids_filtered, 25978);
+	pid_filter__add(&pids_filtered, 883);
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
@@ -57,8 +81,14 @@ int sys_enter(struct syscall_enter_args *args)
 	} augmented_args;
 	unsigned int len = sizeof(augmented_args);
 	const void *filename_arg = NULL;
+	/*
+ 	 * We still don't have a "main()" called first and only once
+ 	 * call it always, it will exit as soon as it realizes the
+ 	 * first hard coded filtered pid was already added.
+ 	 */
+	pid_filter__init();
 
-	if (getpid() == 2971)
+	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
@@ -132,7 +162,7 @@ int sys_enter(struct syscall_enter_args *args)
 SEC("raw_syscalls:sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
-	return getpid() != 2971;
+	return !pid_filter__has(&pids_filtered, getpid());
 }
 
 license(GPL);
-- 
2.14.5
