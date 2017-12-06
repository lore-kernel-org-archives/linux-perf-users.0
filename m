From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/36] perf record: Synthesize thread map and cpu map
Date: Wed,  6 Dec 2017 11:40:43 -0300
Message-ID: <20171206144115.15097-5-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Synthesize the per attr thread maps and cpu maps in 'perf record'.

This allows code from 'perf stat' called from 'perf script' to access
this information.

Committer testing:

Please see the PERF_RECORD_THREAD_MAP and PERF_RECORD_CPU_MAP records,
added by this patch:

  $ perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (8 samples) ]
  $ perf report -D | grep PERF_RECORD_ | head
  0xe8 [0x20]: PERF_RECORD_TIME_CONV: unhandled!
  0x108 [0x28]: PERF_RECORD_THREAD_MAP nr: 1 thread: 23568
  0x130 [0x18]: PERF_RECORD_CPU_MAP: 0-3
  0 0x148 [0x28]: PERF_RECORD_COMM: perf:23568/23568
  0x570 [0x8]: PERF_RECORD_FINISHED_ROUND
  445342677837144 0x170 [0x28]: PERF_RECORD_COMM exec: sleep:23568/23568
  445342677847339 0x198 [0x68]: PERF_RECORD_MMAP2 23568/23568: [0x564c943a4000(0x208000) @ 0 fd:00 3147174 2566255743]: r-xp /usr/bin/sleep
  445342677862450 0x200 [0x70]: PERF_RECORD_MMAP2 23568/23568: [0x7f25968a8000(0x229000) @ 0 fd:00 3151761 2566238119]: r-xp /usr/lib64/ld-2.25.so
  445342677873174 0x270 [0x60]: PERF_RECORD_MMAP2 23568/23568: [0x7ffc98176000(0x2000) @ 0 00:00 0 0]: r-xp [vdso]
  445342677891928 0x2d0 [0x28]: PERF_RECORD_SAMPLE(IP, 0x4002): 23568/23568: 0xffffffff8f84c7e7 period: 1 addr: 0
  $

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/r/20171117214300.32746-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b92d6d67bca8..e304bc47fe9b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -793,6 +793,21 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err)
 		goto out;
 
+	err = perf_event__synthesize_thread_map2(&rec->tool, rec->evlist->threads,
+						 process_synthesized_event,
+						NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize thread map.\n");
+		return err;
+	}
+
+	err = perf_event__synthesize_cpu_map(&rec->tool, rec->evlist->cpus,
+					     process_synthesized_event, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize cpu map.\n");
+		return err;
+	}
+
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
 					    process_synthesized_event, opts->sample_address,
 					    opts->proc_map_timeout, 1);
-- 
2.13.6
