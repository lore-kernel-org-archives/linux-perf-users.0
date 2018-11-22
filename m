From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/28] Revert "perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter"
Date: Thu, 22 Nov 2018 00:35:56 -0300
Message-ID: <20181122033611.15890-14-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that we have the "filtered_pids" logic in place, no need to do this
rough filter to avoid the feedback loop from 'perf trace's own syscalls,
revert it.

This reverts commit 7ed71f124284359676b6496ae7db724fee9da753.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-88vh02cnkam0vv5f9vp02o3h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 3f26e705b86c..74ce7574073d 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -44,9 +44,7 @@ struct augmented_filename {
 	char		value[256];
 };
 
-#define SYS_WRITE 1
 #define SYS_OPEN 2
-#define SYS_POLL 7
 #define SYS_OPENAT 257
 
 pid_filter(pids_filtered);
@@ -106,8 +104,6 @@ int sys_enter(struct syscall_enter_args *args)
 	 * 	 after the ctx memory access to prevent their down stream merging.
 	 */
 	switch (augmented_args.args.syscall_nr) {
-	case SYS_WRITE:
-	case SYS_POLL:	 return 0;
 	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
 			__asm__ __volatile__("": : :"memory");
 			 break;
-- 
2.14.5
