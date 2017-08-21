From: sathnaga@linux.vnet.ibm.com
Subject: [PATCH v3 2/2] perf/bench/numa: Handle discontiguous/sparse numa nodes
Date: Mon, 21 Aug 2017 15:47:11 +0530
Message-ID: <67b88aa2de6dd199d57bacdecf35d26958780feb.1503310062.git.sathnaga@linux.vnet.ibm.com>
References: <cover.1503310062.git.sathnaga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503310062.git.sathnaga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Certain systems are designed to have sparse/discontiguous nodes.
On such systems, perf bench numa hangs, shows wrong number of nodes
and shows values for non-existent nodes. Handle this by only
taking nodes that are exposed by kernel to userspace.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 tools/perf/bench/numa.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 2483174..d4cccc4 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -287,12 +287,12 @@ static cpu_set_t bind_to_cpu(int target_cpu)
 
 static cpu_set_t bind_to_node(int target_node)
 {
-	int cpus_per_node = g->p.nr_cpus/g->p.nr_nodes;
+	int cpus_per_node = g->p.nr_cpus/nr_numa_nodes();
 	cpu_set_t orig_mask, mask;
 	int cpu;
 	int ret;
 
-	BUG_ON(cpus_per_node*g->p.nr_nodes != g->p.nr_cpus);
+	BUG_ON(cpus_per_node*nr_numa_nodes() != g->p.nr_cpus);
 	BUG_ON(!cpus_per_node);
 
 	ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
@@ -692,7 +692,7 @@ static int parse_setup_node_list(void)
 			int i;
 
 			for (i = 0; i < mul; i++) {
-				if (t >= g->p.nr_tasks) {
+				if (t >= g->p.nr_tasks || !node_has_cpus(bind_node)) {
 					printf("\n# NOTE: ignoring bind NODEs starting at NODE#%d\n", bind_node);
 					goto out;
 				}
@@ -973,6 +973,7 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
 	int node;
 	int cpu;
 	int t;
+	int processes;
 
 	if (!g->p.show_convergence && !g->p.measure_convergence)
 		return;
@@ -1007,13 +1008,14 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
 	sum = 0;
 
 	for (node = 0; node < g->p.nr_nodes; node++) {
+		if (!is_node_present(node))
+			continue;
 		nr = nodes[node];
 		nr_min = min(nr, nr_min);
 		nr_max = max(nr, nr_max);
 		sum += nr;
 	}
 	BUG_ON(nr_min > nr_max);
-
 	BUG_ON(sum > g->p.nr_tasks);
 
 	if (0 && (sum < g->p.nr_tasks))
@@ -1027,8 +1029,9 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
 	process_groups = 0;
 
 	for (node = 0; node < g->p.nr_nodes; node++) {
-		int processes = count_node_processes(node);
-
+		if (!is_node_present(node))
+			continue;
+		processes = count_node_processes(node);
 		nr = nodes[node];
 		tprintf(" %2d/%-2d", nr, processes);
 
@@ -1334,7 +1337,7 @@ static void print_summary(void)
 
 	printf("\n ###\n");
 	printf(" # %d %s will execute (on %d nodes, %d CPUs):\n",
-		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", g->p.nr_nodes, g->p.nr_cpus);
+		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", nr_numa_nodes(), g->p.nr_cpus);
 	printf(" #      %5dx %5ldMB global  shared mem operations\n",
 			g->p.nr_loops, g->p.bytes_global/1024/1024);
 	printf(" #      %5dx %5ldMB process shared mem operations\n",
-- 
2.7.4
