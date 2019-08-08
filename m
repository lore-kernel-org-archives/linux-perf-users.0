From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/10] perf bench numa: Fix cpu0 binding
Date: Thu,  8 Aug 2019 15:53:49 -0300
Message-ID: <20190808185358.20125-2-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Michael reported an issue with perf bench numa failing with binding to
cpu0 with '-0' option.

  # perf bench numa mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd
  # Running 'numa/mem' benchmark:

   # Running main, "perf bench numa numa-mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd"
  binding to node 0, mask: 0000000000000001 => -1
  perf: bench/numa.c:356: bind_to_memnode: Assertion `!(ret)' failed.
  Aborted (core dumped)

This happens when the cpu0 is not part of node0, which is the benchmark
assumption and we can see that's not the case for some powerpc servers.

Using correct node for cpu0 binding.

Reported-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190801142642.28004-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/numa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index a640ca7aaada..513cb2f2fa32 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -379,8 +379,10 @@ static u8 *alloc_data(ssize_t bytes0, int map_flags,
 
 	/* Allocate and initialize all memory on CPU#0: */
 	if (init_cpu0) {
-		orig_mask = bind_to_node(0);
-		bind_to_memnode(0);
+		int node = numa_node_of_cpu(0);
+
+		orig_mask = bind_to_node(node);
+		bind_to_memnode(node);
 	}
 
 	bytes = bytes0 + HPSIZE;
-- 
2.21.0
