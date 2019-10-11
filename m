From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/69] perf trace: Associate the "msr" tracepoint arg name with x86_MSR__scnprintf()
Date: Fri, 11 Oct 2019 17:05:21 -0300
Message-ID: <20191011200559.7156-32-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can go from:

  # perf trace -e msr:write_msr --max-stack=16 sleep 1
       0.000 sleep/6740 msr:write_msr(msr: 3221225728, val: 139636317451648)
                                         do_trace_write_msr ([kernel.kallsyms])
                                         do_trace_write_msr ([kernel.kallsyms])
                                         do_arch_prctl_64 ([kernel.kallsyms])
                                         __x64_sys_arch_prctl ([kernel.kallsyms])
                                         do_syscall_64 ([kernel.kallsyms])
                                         entry_SYSCALL_64 ([kernel.kallsyms])
                                         init_tls (/usr/lib64/ld-2.29.so)
                                         dl_main (/usr/lib64/ld-2.29.so)
                                         _dl_sysdep_start (/usr/lib64/ld-2.29.so)
                                         _dl_start (/usr/lib64/ld-2.29.so)
  #

To:

  # perf trace -e msr:write_msr --max-stack=16 sleep 1
     0.000 sleep/8519 msr:write_msr(msr: FS_BASE, val: 139878031705472)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_arch_prctl_64 ([kernel.kallsyms])
                                       __x64_sys_arch_prctl ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       init_tls (/usr/lib64/ld-2.29.so)
                                       dl_main (/usr/lib64/ld-2.29.so)
                                       _dl_sysdep_start (/usr/lib64/ld-2.29.so)
                                       _dl_start (/usr/lib64/ld-2.29.so)
  #

This, in reverse, will allow for symbolic system call/tracepoint
filtering.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-q1q4unmqja5ex7dy0kb5cjaa@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d52972ca6123..e9f132aa5a09 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1480,6 +1480,7 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 }
 
 static struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+	{ .name = "msr", .scnprintf = SCA_X86_MSR, }
 };
 
 static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
-- 
2.21.0
