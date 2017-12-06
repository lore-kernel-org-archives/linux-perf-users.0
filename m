From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/36] perf mmap: Fix perf backward recording
Date: Wed,  6 Dec 2017 11:41:13 -0300
Message-ID: <20171206144115.15097-35-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Mengting Zhang <zhangmengting@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wang Nan <wangnan0@huawei.com>

'perf record' backward recording doesn't work as we expected: it never
overwrites when ring buffer gets full.

Test:

Run a busy python printing task background like this:

 while True:
     print 123

send SIGUSR2 to perf to capture snapshot, then:

 # ./perf record --overwrite -e raw_syscalls:sys_enter -e raw_syscalls:sys_exit --exclude-perf -a --switch-output
 [ perf record: dump data: Woken up 1 times ]
 [ perf record: Dump perf.data.2017110101520743 ]
 [ perf record: dump data: Woken up 1 times ]
 [ perf record: Dump perf.data.2017110101521251 ]
 [ perf record: dump data: Woken up 1 times ]
 [ perf record: Dump perf.data.2017110101521692 ]
 ^C[ perf record: Woken up 1 times to write data ]
 [ perf record: Dump perf.data.2017110101521936 ]
 [ perf record: Captured and wrote 0.826 MB perf.data.<timestamp> ]

 # ./perf script -i ./perf.data.2017110101520743 | head -n3
             perf  2717 [000] 12449.310785: raw_syscalls:sys_enter: NR 16 (5, 2400, 0, 59, 100, 0)
             perf  2717 [000] 12449.310790: raw_syscalls:sys_enter: NR 7 (4112340, 2, ffffffff, 3df, 100, 0)
           python  2545 [000] 12449.310800:  raw_syscalls:sys_exit: NR 1 = 4
 # ./perf script -i ./perf.data.2017110101521251 | head -n3
             perf  2717 [000] 12449.310785: raw_syscalls:sys_enter: NR 16 (5, 2400, 0, 59, 100, 0)
             perf  2717 [000] 12449.310790: raw_syscalls:sys_enter: NR 7 (4112340, 2, ffffffff, 3df, 100, 0)
           python  2545 [000] 12449.310800:  raw_syscalls:sys_exit: NR 1 = 4
 # ./perf script -i ./perf.data.2017110101521692 | head -n3
             perf  2717 [000] 12449.310785: raw_syscalls:sys_enter: NR 16 (5, 2400, 0, 59, 100, 0)
             perf  2717 [000] 12449.310790: raw_syscalls:sys_enter: NR 7 (4112340, 2, ffffffff, 3df, 100, 0)
           python  2545 [000] 12449.310800:  raw_syscalls:sys_exit: NR 1 = 4

Timestamps never change, but my background task is a dead loop, can
easily overwhelm the ring buffer.

This patch fixes it by forcing unsetting PROT_WRITE for a backward ring
buffer, so all backward ring buffers become overwrite ring buffers.

Test result:

 # ./perf record --overwrite -e raw_syscalls:sys_enter -e raw_syscalls:sys_exit --exclude-perf -a --switch-output
 [ perf record: dump data: Woken up 1 times ]
 [ perf record: Dump perf.data.2017110101285323 ]
 [ perf record: dump data: Woken up 1 times ]
 [ perf record: Dump perf.data.2017110101290053 ]
 [ perf record: dump data: Woken up 1 times ]
 [ perf record: Dump perf.data.2017110101290446 ]
 ^C[ perf record: Woken up 1 times to write data ]
 [ perf record: Dump perf.data.2017110101290837 ]
 [ perf record: Captured and wrote 0.826 MB perf.data.<timestamp> ]
 # ./perf script -i ./perf.data.2017110101285323 | head -n3
           python  2545 [000] 11064.268083:  raw_syscalls:sys_exit: NR 1 = 4
           python  2545 [000] 11064.268084: raw_syscalls:sys_enter: NR 1 (1, 12cc330, 4, 7fc237280370, 7fc2373d0700, 2c7b0)
           python  2545 [000] 11064.268086:  raw_syscalls:sys_exit: NR 1 = 4
 # ./perf script -i ./perf.data.2017110101290 | head -n3
 failed to open ./perf.data.2017110101290: No such file or directory
 # ./perf script -i ./perf.data.2017110101290053 | head -n3
           python  2545 [000] 11071.564062: raw_syscalls:sys_enter: NR 1 (1, 12cc330, 4, 7fc237280370, 7fc2373d0700, 2c7b0)
           python  2545 [000] 11071.564064:  raw_syscalls:sys_exit: NR 1 = 4
           python  2545 [000] 11071.564066: raw_syscalls:sys_enter: NR 1 (1, 12cc330, 4, 7fc237280370, 7fc2373d0700, 2c7b0)
 # ./perf script -i ./perf.data.2017110101290 | head -n3
 perf.data.2017110101290053  perf.data.2017110101290446  perf.data.2017110101290837
 # ./perf script -i ./perf.data.2017110101290446 | head -n3
             sshd  1321 [000] 11075.499473:  raw_syscalls:sys_exit: NR 14 = 0
             sshd  1321 [000] 11075.499474: raw_syscalls:sys_enter: NR 14 (2, 7ffe98899490, 0, 8, 0, 3000)
             sshd  1321 [000] 11075.499474:  raw_syscalls:sys_exit: NR 14 = 0
 # ./perf script -i ./perf.data.2017110101290837 | head -n3
           python  2545 [000] 11079.280844:  raw_syscalls:sys_exit: NR 1 = 4
           python  2545 [000] 11079.280847: raw_syscalls:sys_enter: NR 1 (1, 12cc330, 4, 7fc237280370, 7fc2373d0700, 2c7b0)
           python  2545 [000] 11079.280850:  raw_syscalls:sys_exit: NR 1 = 4

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Mengting Zhang <zhangmengting@huawei.com>
Link: http://lkml.kernel.org/r/20171204165107.95327-2-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 68c1f9546650..b1cea711232b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -812,6 +812,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		int fd;
 		int cpu;
 
+		mp->prot = PROT_READ | PROT_WRITE;
 		if (evsel->attr.write_backward) {
 			output = _output_backward;
 			maps = evlist->backward_mmap;
@@ -824,6 +825,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 				if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
 					perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 			}
+			mp->prot &= ~PROT_WRITE;
 		}
 
 		if (evsel->system_wide && thread)
@@ -1058,9 +1060,12 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
 	const struct thread_map *threads = evlist->threads;
-	struct mmap_params mp = {
-		.prot = PROT_READ | PROT_WRITE,
-	};
+	/*
+	 * Delay setting mp.prot: set it before calling perf_mmap__mmap.
+	 * Its value is decided by evsel's write_backward.
+	 * So &mp should not be passed through const pointer.
+	 */
+	struct mmap_params mp;
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist);
-- 
2.13.6
