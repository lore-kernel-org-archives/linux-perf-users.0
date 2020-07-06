From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 1/3] perf bench numa: fix incorrect NUMA toplogy assumption
Date: Mon,  6 Jul 2020 11:42:52 +0200
Message-ID: <73667aca03e6f2e1247729f203490166ed16a83d.1594028310.git.agordeev@linux.ibm.com>
References: <cover.1594028310.git.agordeev@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1594028310.git.agordeev@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

The current code assumes that CPUs are evenly spread among
NUMA nodes. That is generally incorrect and leads to failure
on systems that have different NUMA topology.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 tools/perf/bench/numa.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 5797253..23e224e 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -247,12 +247,13 @@ static int is_node_present(int node)
  */
 static bool node_has_cpus(int node)
 {
-	struct bitmask *cpu = numa_allocate_cpumask();
+	struct bitmask *cpumask = numa_allocate_cpumask();
 	unsigned int i;
 
-	if (cpu && !numa_node_to_cpus(node, cpu)) {
-		for (i = 0; i < cpu->size; i++) {
-			if (numa_bitmask_isbitset(cpu, i))
+	BUG_ON(!cpumask);
+	if (!numa_node_to_cpus(node, cpumask)) {
+		for (i = 0; i < cpumask->size; i++) {
+			if (numa_bitmask_isbitset(cpumask, i))
 				return true;
 		}
 	}
@@ -288,14 +289,10 @@ static cpu_set_t bind_to_cpu(int target_cpu)
 
 static cpu_set_t bind_to_node(int target_node)
 {
-	int cpus_per_node = g->p.nr_cpus / nr_numa_nodes();
 	cpu_set_t orig_mask, mask;
 	int cpu;
 	int ret;
 
-	BUG_ON(cpus_per_node * nr_numa_nodes() != g->p.nr_cpus);
-	BUG_ON(!cpus_per_node);
-
 	ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
 	BUG_ON(ret);
 
@@ -305,13 +302,15 @@ static cpu_set_t bind_to_node(int target_node)
 		for (cpu = 0; cpu < g->p.nr_cpus; cpu++)
 			CPU_SET(cpu, &mask);
 	} else {
-		int cpu_start = (target_node + 0) * cpus_per_node;
-		int cpu_stop  = (target_node + 1) * cpus_per_node;
-
-		BUG_ON(cpu_stop > g->p.nr_cpus);
+		struct bitmask *cpumask = numa_allocate_cpumask();
 
-		for (cpu = cpu_start; cpu < cpu_stop; cpu++)
-			CPU_SET(cpu, &mask);
+		BUG_ON(!cpumask);
+		if (!numa_node_to_cpus(target_node, cpumask)) {
+			for (cpu = 0; cpu < (int)cpumask->size; cpu++) {
+				if (numa_bitmask_isbitset(cpumask, cpu))
+					CPU_SET(cpu, &mask);
+			}
+		}
 	}
 
 	ret = sched_setaffinity(0, sizeof(mask), &mask);
-- 
1.8.3.1
