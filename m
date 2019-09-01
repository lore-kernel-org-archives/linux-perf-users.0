From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/47] perf machine: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
Date: Sun,  1 Sep 2019 09:22:45 -0300
Message-ID: <20190901122326.5793-7-acme@kernel.org>
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

nr_cpus, the number of CPUs online during a record session bound by
MAX_NR_CPUS, can be used as a dynamic alternative for MAX_NR_CPUS in
__machine__synthesize_threads and machine__set_current_tid.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-6-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 93483f1764d3..a1542b4c047b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2619,7 +2619,9 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
 
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
-	if (cpu < 0 || cpu >= MAX_NR_CPUS || !machine->current_tid)
+	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
+
+	if (cpu < 0 || cpu >= nr_cpus || !machine->current_tid)
 		return -1;
 
 	return machine->current_tid[cpu];
@@ -2629,6 +2631,7 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 			     pid_t tid)
 {
 	struct thread *thread;
+	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
 
 	if (cpu < 0)
 		return -EINVAL;
@@ -2636,14 +2639,14 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 	if (!machine->current_tid) {
 		int i;
 
-		machine->current_tid = calloc(MAX_NR_CPUS, sizeof(pid_t));
+		machine->current_tid = calloc(nr_cpus, sizeof(pid_t));
 		if (!machine->current_tid)
 			return -ENOMEM;
-		for (i = 0; i < MAX_NR_CPUS; i++)
+		for (i = 0; i < nr_cpus; i++)
 			machine->current_tid[i] = -1;
 	}
 
-	if (cpu >= MAX_NR_CPUS) {
+	if (cpu >= nr_cpus) {
 		pr_err("Requested CPU %d too large. ", cpu);
 		pr_err("Consider raising MAX_NR_CPUS\n");
 		return -EINVAL;
-- 
2.21.0
