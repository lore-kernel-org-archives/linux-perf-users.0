From: sathnaga@linux.vnet.ibm.com
Subject: [PATCH v2 1/2] perf/bench/numa: Add functions to detect sparse numa nodes
Date: Mon, 21 Aug 2017 14:57:48 +0530
Message-ID: <2a54db2b5e75b15c6f214899bdc7b4a6a1568af0.1502971981.git.sathnaga@linux.vnet.ibm.com>
References: <cover.1502971981.git.sathnaga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502971981.git.sathnaga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Added functions 1) to get a count of all nodes that are exposed to
userspace. These nodes could be memoryless cpu nodes or cpuless memory
nodes, 2) to check given node is present and 3) to check given
node has cpus

This information can be used to handle sparse/discontiguous nodes.

Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 tools/perf/bench/numa.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 469d65b..300faba1 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -215,6 +215,41 @@ static const char * const numa_usage[] = {
 	NULL
 };
 
+// To get number of numa nodes present.
+static int nr_numa_nodes(void)
+{
+	int i, nr_nodes = 0;
+
+	for (i = 0; i < g->p.nr_nodes; i++) {
+		if (numa_bitmask_isbitset(numa_nodes_ptr, i))
+			nr_nodes++;
+	}
+	return nr_nodes;
+}
+
+// To check if given numa node is present.
+static int is_node_present(int node)
+{
+	return numa_bitmask_isbitset(numa_nodes_ptr, node);
+}
+
+// To check given numa node has cpus.
+static bool node_has_cpus(int node)
+{
+	struct bitmask *cpu = numa_allocate_cpumask();
+	unsigned int i;
+
+	if (cpu == NULL)
+		return false; // lets fall back to nocpus safely
+	if (numa_node_to_cpus(node, cpu) == 0) {
+		for (i = 0; i < cpu->size; i++) {
+			if (numa_bitmask_isbitset(cpu, i))
+				return true;
+			}
+		}
+	return false;
+}
+
 static cpu_set_t bind_to_cpu(int target_cpu)
 {
 	cpu_set_t orig_mask, mask;
-- 
2.7.4
