From: sathnaga@linux.vnet.ibm.com
Subject: [PATCH v5 1/1] perf/bench/numa: Fixup discontiguous/sparse numa nodes
Date: Wed, 22 Nov 2017 22:13:53 +0530
Message-ID: <1edbcd353c009e109e93d78f2f46381930c340fe.1511368645.git.sathnaga@linux.vnet.ibm.com>
References: <cover.1511368645.git.sathnaga@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751458AbdKVQoL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Nov 2017 11:44:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAMGi5Fr001232
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2017 11:44:10 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2edbk2w4ba-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2017 11:44:10 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <sathnaga@linux.vnet.ibm.com>;
        Wed, 22 Nov 2017 16:44:08 -0000
In-Reply-To: <cover.1511368645.git.sathnaga@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, mingo@kernel.org
Cc: bala24@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Certain systems are designed to have sparse/discontiguous nodes.
On such systems, perf bench numa hangs, shows wrong number of nodes
and shows values for non-existent nodes. Handle this by only
taking nodes that are exposed by kernel to userspace.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 tools/perf/bench/numa.c | 56 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index d95fdcc..944070e 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -216,6 +216,47 @@ static const char * const numa_usage[] = {
 	NULL
 };
 
+/*
+ * To get number of numa nodes present.
+ */
+static int nr_numa_nodes(void)
+{
+	int i, nr_nodes = 0;
+
+	for (i = 0; i < g->p.nr_nodes; i++) {
+		if (numa_bitmask_isbitset(numa_nodes_ptr, i))
+			nr_nodes++;
+	}
+
+	return nr_nodes;
+}
+
+/*
+ * To check if given numa node is present.
+ */
+static int is_node_present(int node)
+{
+	return numa_bitmask_isbitset(numa_nodes_ptr, node);
+}
+
+/*
+ * To check given numa node has cpus.
+ */
+static bool node_has_cpus(int node)
+{
+	struct bitmask *cpu = numa_allocate_cpumask();
+	unsigned int i;
+
+	if (cpu && !numa_node_to_cpus(node, cpu)) {
+		for (i = 0; i < cpu->size; i++) {
+			if (numa_bitmask_isbitset(cpu, i))
+				return true;
+		}
+	}
+
+	return false; /* lets fall back to nocpus safely */
+}
+
 static cpu_set_t bind_to_cpu(int target_cpu)
 {
 	cpu_set_t orig_mask, mask;
@@ -244,12 +285,12 @@ static cpu_set_t bind_to_cpu(int target_cpu)
 
 static cpu_set_t bind_to_node(int target_node)
 {
-	int cpus_per_node = g->p.nr_cpus/g->p.nr_nodes;
+	int cpus_per_node = g->p.nr_cpus / nr_numa_nodes();
 	cpu_set_t orig_mask, mask;
 	int cpu;
 	int ret;
 
-	BUG_ON(cpus_per_node*g->p.nr_nodes != g->p.nr_cpus);
+	BUG_ON(cpus_per_node * nr_numa_nodes() != g->p.nr_cpus);
 	BUG_ON(!cpus_per_node);
 
 	ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
@@ -649,7 +690,7 @@ static int parse_setup_node_list(void)
 			int i;
 
 			for (i = 0; i < mul; i++) {
-				if (t >= g->p.nr_tasks) {
+				if (t >= g->p.nr_tasks || !node_has_cpus(bind_node)) {
 					printf("\n# NOTE: ignoring bind NODEs starting at NODE#%d\n", bind_node);
 					goto out;
 				}
@@ -964,6 +1005,8 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
 	sum = 0;
 
 	for (node = 0; node < g->p.nr_nodes; node++) {
+		if (!is_node_present(node))
+			continue;
 		nr = nodes[node];
 		nr_min = min(nr, nr_min);
 		nr_max = max(nr, nr_max);
@@ -984,8 +1027,11 @@ static void calc_convergence(double runtime_ns_max, double *convergence)
 	process_groups = 0;
 
 	for (node = 0; node < g->p.nr_nodes; node++) {
-		int processes = count_node_processes(node);
+		int processes;
 
+		if (!is_node_present(node))
+			continue;
+		processes = count_node_processes(node);
 		nr = nodes[node];
 		tprintf(" %2d/%-2d", nr, processes);
 
@@ -1291,7 +1337,7 @@ static void print_summary(void)
 
 	printf("\n ###\n");
 	printf(" # %d %s will execute (on %d nodes, %d CPUs):\n",
-		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", g->p.nr_nodes, g->p.nr_cpus);
+		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", nr_numa_nodes(), g->p.nr_cpus);
 	printf(" #      %5dx %5ldMB global  shared mem operations\n",
 			g->p.nr_loops, g->p.bytes_global/1024/1024);
 	printf(" #      %5dx %5ldMB process shared mem operations\n",
-- 
2.7.4
