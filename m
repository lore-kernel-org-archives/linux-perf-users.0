From: sathnaga@linux.vnet.ibm.com
Subject: [PATCH v2 2/2] perf/bench/numa: Handle discontiguous/sparse numa nodes
Date: Mon, 21 Aug 2017 14:58:19 +0530
Message-ID: <f38fdc2da8202b14d184963da219adff06a2cac2.1502971981.git.sathnaga@linux.vnet.ibm.com>
References: <cover.1502971981.git.sathnaga@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38141 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752462AbdHUJ2e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2017 05:28:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7L9OXcT049451
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2017 05:28:34 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cfu1bwq91-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2017 05:28:34 -0400
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <sathnaga@linux.vnet.ibm.com>;
        Mon, 21 Aug 2017 19:28:31 +1000
In-Reply-To: <cover.1502971981.git.sathnaga@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Certain systems are designed to have sparse/discontiguous nodes.
On such systems, perf bench numa hangs, shows wrong number of nodes
and shows values for non-existent nodes. Handle this by only
taking nodes that are exposed by kernel to userspace.

Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 tools/perf/bench/numa.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 300faba1..a3deee2 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -278,12 +278,12 @@ static cpu_set_t bind_to_cpu(int target_cpu)
 
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
@@ -683,7 +683,7 @@ static int parse_setup_node_list(void)
 			int i;
 
 			for (i = 0; i < mul; i++) {
-				if (t >= g->p.nr_tasks) {
+				if (t >= g->p.nr_tasks || !node_has_cpus(bind_node)) {
 					printf("\n# NOTE: ignoring bind NODEs starting at NODE#%d\n", bind_node);
 					goto out;
 				}
@@ -964,6 +964,7 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
 	int node;
 	int cpu;
 	int t;
+	int processes;
 
 	if (!g->p.show_convergence && !g->p.measure_convergence)
 		return;
@@ -998,13 +999,14 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
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
@@ -1018,8 +1020,9 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
 	process_groups = 0;
 
 	for (node = 0; node < g->p.nr_nodes; node++) {
-		int processes = count_node_processes(node);
-
+		if (!is_node_present(node))
+			continue;
+		processes = count_node_processes(node);
 		nr = nodes[node];
 		tprintf(" %2d/%-2d", nr, processes);
 
@@ -1325,7 +1328,7 @@ static void print_summary(void)
 
 	printf("\n ###\n");
 	printf(" # %d %s will execute (on %d nodes, %d CPUs):\n",
-		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", g->p.nr_nodes, g->p.nr_cpus);
+		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", nr_numa_nodes(), g->p.nr_cpus);
 	printf(" #      %5dx %5ldMB global  shared mem operations\n",
 			g->p.nr_loops, g->p.bytes_global/1024/1024);
 	printf(" #      %5dx %5ldMB process shared mem operations\n",
-- 
2.7.4
