From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/47] libperf: Warn when exceeding MAX_NR_CPUS in cpumap
Date: Sun,  1 Sep 2019 09:22:47 -0300
Message-ID: <20190901122326.5793-9-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Russ Anderson <russ.anderson@hpe.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kyle Meyer <meyerk@hpe.com>

Display a warning when attempting to profile more than MAX_NR_CPU CPUs.
This patch should not change any behavior.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-8-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 2834753576b2..1f0e6f334237 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -100,6 +100,9 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *file)
 		if (prev >= 0) {
 			int new_max = nr_cpus + cpu - prev - 1;
 
+			WARN_ONCE(new_max >= MAX_NR_CPUS, "Perf can support %d CPUs. "
+							  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
+
 			if (new_max >= max_entries) {
 				max_entries = new_max + MAX_NR_CPUS / 2;
 				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
@@ -192,6 +195,9 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 			end_cpu = start_cpu;
 		}
 
+		WARN_ONCE(end_cpu >= MAX_NR_CPUS, "Perf can support %d CPUs. "
+						  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
+
 		for (; start_cpu <= end_cpu; start_cpu++) {
 			/* check for duplicates */
 			for (i = 0; i < nr_cpus; i++)
-- 
2.21.0
