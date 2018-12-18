From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 48/63] perf augmented_raw_syscalls: Copy 'access' arg as well
Date: Tue, 18 Dec 2018 19:07:18 -0300
Message-ID: <20181218220733.15839-49-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This will all come from userspace, but to test the changes to make 'perf
trace' output similar to strace's, do this one more now manually.

To update the precompiled augmented_raw_syscalls.o binary I just run:

  # perf record -e ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.022 MB perf.data ]
  #

Because to have augmented_raw_syscalls to be always used and a fast
startup and remove the need to have the llvm toolchain installed, I'm
using:

  # perf config | grep add_events
  trace.add_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  #

So when doing changes to augmented_raw_syscals.c one needs to rebuild
the .o file.

This will be done automagically later, i.e. have a 'make' behaviour of
recompiling when the .c gets changed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-lw3i2atyq8549fpqwmszn3qp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 6c5db6baeb3a..53c233370fae 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -55,6 +55,7 @@ struct augmented_filename {
 };
 
 #define SYS_OPEN 2
+#define SYS_ACCESS 21
 #define SYS_OPENAT 257
 
 pid_filter(pids_filtered);
@@ -119,6 +120,7 @@ int sys_enter(struct syscall_enter_args *args)
 	 * 	 after the ctx memory access to prevent their down stream merging.
 	 */
 	switch (augmented_args.args.syscall_nr) {
+	case SYS_ACCESS:
 	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
 			__asm__ __volatile__("": : :"memory");
 			 break;
-- 
2.19.2
