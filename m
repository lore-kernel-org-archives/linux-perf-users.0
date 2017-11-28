From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/30] perf record: Ignore kptr_restrict when not sampling the kernel
Date: Tue, 28 Nov 2017 12:02:04 -0300
Message-ID: <20171128150220.5064-15-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If we're not sampling the kernel, we shouldn't care about kptr_restrict
neither synthesize anything for assisting in resolving kernel samples,
like the reference relocation symbol or kernel modules information.

Before:

  $ cat /proc/sys/kernel/kptr_restrict /proc/sys/kernel/perf_event_paranoid
  2
  2
  $ perf record sleep 1
  WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
  check /proc/sys/kernel/kptr_restrict.

  Samples in kernel functions may not be resolved if a suitable vmlinux
  file is not found in the buildid cache or in the vmlinux path.

  Samples in kernel modules won't be resolved at all.

  If some relocation was applied (e.g. kexec) symbols may be misresolved
  even with a suitable vmlinux or kallsyms file.

  Couldn't record kernel reference relocation symbol
  Symbol resolution may be skewed if relocation was used (e.g. kexec).
  Check /proc/kallsyms permission or run as root.
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (8 samples) ]
  $ perf evlist -v
  cycles:uppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, exclude_kernel: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
  $

After:

  $ perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (10 samples) ]
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-t025e9zftbx2b8cq2w01g5e5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 5f78ce943407..003255910c05 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -765,17 +765,19 @@ static int record__synthesize(struct record *rec, bool tail)
 			goto out;
 	}
 
-	err = perf_event__synthesize_kernel_mmap(tool, process_synthesized_event,
-						 machine);
-	WARN_ONCE(err < 0, "Couldn't record kernel reference relocation symbol\n"
-			   "Symbol resolution may be skewed if relocation was used (e.g. kexec).\n"
-			   "Check /proc/kallsyms permission or run as root.\n");
-
-	err = perf_event__synthesize_modules(tool, process_synthesized_event,
-					     machine);
-	WARN_ONCE(err < 0, "Couldn't record kernel module information.\n"
-			   "Symbol resolution may be skewed if relocation was used (e.g. kexec).\n"
-			   "Check /proc/modules permission or run as root.\n");
+	if (!perf_evlist__exclude_kernel(rec->evlist)) {
+		err = perf_event__synthesize_kernel_mmap(tool, process_synthesized_event,
+							 machine);
+		WARN_ONCE(err < 0, "Couldn't record kernel reference relocation symbol\n"
+				   "Symbol resolution may be skewed if relocation was used (e.g. kexec).\n"
+				   "Check /proc/kallsyms permission or run as root.\n");
+
+		err = perf_event__synthesize_modules(tool, process_synthesized_event,
+						     machine);
+		WARN_ONCE(err < 0, "Couldn't record kernel module information.\n"
+				   "Symbol resolution may be skewed if relocation was used (e.g. kexec).\n"
+				   "Check /proc/modules permission or run as root.\n");
+	}
 
 	if (perf_guest) {
 		machines__process_guests(&session->machines,
@@ -1709,7 +1711,7 @@ int cmd_record(int argc, const char **argv)
 
 	err = -ENOMEM;
 
-	if (symbol_conf.kptr_restrict)
+	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(rec->evlist))
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
 "check /proc/sys/kernel/kptr_restrict.\n\n"
-- 
2.13.6
