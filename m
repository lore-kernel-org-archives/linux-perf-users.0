From: sathnaga@linux.vnet.ibm.com
Subject: [PATCH 1/2] perf/bench/numa: Add functions to detect sparse numa nodes
Date: Thu, 10 Aug 2017 12:58:49 +0530
Message-ID: <1502350129-10489-1-git-send-email-sathnaga@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751361AbdHJH3I (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2017 03:29:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7A7T7KB139454
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2017 03:29:08 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2c8cykkguy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2017 03:29:08 -0400
Received: from localhost
        by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <sathnaga@linux.vnet.ibm.com>;
        Thu, 10 Aug 2017 17:29:00 +1000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Added functions 1) to get a count of all nodes that are exposed to
userspace. These nodes could be memoryless cpu nodes or cpuless memory
nodes, 2) to check given node is present and 3) to check given
node has cpus

This information can be used to handle sparse/discontiguous nodes.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 tools/perf/bench/numa.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 469d65b..efd7595 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -215,6 +215,41 @@ static const char * const numa_usage[] = {
 	NULL
 };
 
+static int nr_numa_nodes(void)
+{
+	int node = 0, i;
+
+        for (i = 0; i < g->p.nr_nodes; i++) {
+		if (numa_bitmask_isbitset(numa_nodes_ptr, i))
+			node++;
+	}
+	return node;
+}
+
+static bool is_node_present(int node)
+{
+	if (numa_bitmask_isbitset(numa_nodes_ptr, node))
+		return true;
+	else
+		return false;
+}
+
+static bool is_node_hascpu(int node)
+{
+	struct bitmask *cpu;
+	unsigned int i;
+
+	cpu = numa_allocate_cpumask();
+	if (numa_node_to_cpus(node, cpu) == 0) {
+		for (i = 0; i < cpu->size; i++) {
+			if (numa_bitmask_isbitset(cpu, i))
+				return true;
+			}
+	} else
+		return false; // lets fall back to nocpus safely
+	return false;
+}
+
 static cpu_set_t bind_to_cpu(int target_cpu)
 {
 	cpu_set_t orig_mask, mask;
-- 
2.7.4
