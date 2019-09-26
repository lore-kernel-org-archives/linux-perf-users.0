From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/66] perf record: Move restricted maps check to after a possible fallback to not collect kernel samples
Date: Wed, 25 Sep 2019 21:31:40 -0300
Message-ID: <20190926003244.13962-3-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Before:

  [acme@quaco ~]$ perf record -b -e cycles date
  WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,
  check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.

  Samples in kernel functions may not be resolved if a suitable vmlinux
  file is not found in the buildid cache or in the vmlinux path.

  Samples in kernel modules won't be resolved at all.

  If some relocation was applied (e.g. kexec) symbols may be misresolved
  even with a suitable vmlinux or kallsyms file.

  Mon 23 Sep 2019 11:00:59 AM -03
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.005 MB perf.data (14 samples) ]
  [acme@quaco ~]$

But we did a fallback and exclude_kernel was set, so no need for
resolving kernel symbols:

  $ perf evlist -v
  cycles:u: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY
  $

After:

  [acme@quaco ~]$ perf record -b -e cycles date
  Mon 23 Sep 2019 11:07:18 AM -03
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.007 MB perf.data (16 samples) ]
  [acme@quaco ~]$ perf evlist -v
  cycles:u: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY
  [acme@quaco ~]$

No needless warning is emitted.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/n/tip-5yqnr8xcqwhr15xktj2097ac@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3f66a49a997f..1e1f97139f16 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -788,6 +788,17 @@ static int record__open(struct record *rec)
 		pos->supported = true;
 	}
 
+	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(evlist)) {
+		pr_warning(
+"WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
+"check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
+"Samples in kernel functions may not be resolved if a suitable vmlinux\n"
+"file is not found in the buildid cache or in the vmlinux path.\n\n"
+"Samples in kernel modules won't be resolved at all.\n\n"
+"If some relocation was applied (e.g. kexec) symbols may be misresolved\n"
+"even with a suitable vmlinux or kallsyms file.\n\n");
+	}
+
 	if (perf_evlist__apply_filters(evlist, &pos)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
 			pos->filter, perf_evsel__name(pos), errno,
@@ -2364,16 +2375,6 @@ int cmd_record(int argc, const char **argv)
 
 	err = -ENOMEM;
 
-	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(rec->evlist))
-		pr_warning(
-"WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-"check /proc/sys/kernel/kptr_restrict and /proc/sys/kernel/perf_event_paranoid.\n\n"
-"Samples in kernel functions may not be resolved if a suitable vmlinux\n"
-"file is not found in the buildid cache or in the vmlinux path.\n\n"
-"Samples in kernel modules won't be resolved at all.\n\n"
-"If some relocation was applied (e.g. kexec) symbols may be misresolved\n"
-"even with a suitable vmlinux or kallsyms file.\n\n");
-
 	if (rec->no_buildid_cache || rec->no_buildid) {
 		disable_buildid_cache();
 	} else if (rec->switch_output.enabled) {
-- 
2.21.0
