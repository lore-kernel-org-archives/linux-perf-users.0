Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2491DDC00;
	Fri, 25 Oct 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854901; cv=fail; b=BaAE3r2byuL9idiavKBCirkmIoAYyLSaJAg04yV3rmT5Y6nnZYiTRvCsxJZgNuD3AENb//8TSO/e/G5NrBnLH9L9Jxe8Te4lVXjlr5yLaBO1sTJJjyfKDb9FtuEc9ocbtjl+rT3o5l/iI65qFgsZCy+nSpIbXIT4EwXMIEtU/q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854901; c=relaxed/simple;
	bh=lYXOnPULJWzXCsM+AkXhm7PaNcz0Ypyi4FTFhnLHpug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZG8nVX66NwjrZ/8yaOU+o05u1ptaa4Wgaph81pRDGbqHu60Sn/Sy8yEbRbKkpwqOHesfoFdiDOkCAWZ2QeWuiGtUhDHo1YPg/KiYmUlSTLDHtmEc/j3yqWO0Us9mllUO0E3jfcKBFbjEAg7AvVvueP2ZUSqckcRBadzK8EHT2/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nBJ7eXlC; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nBJ7eXlC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8JJFebkO9ni3Q8kCQzFQQ7/u3HrzWlKPTfqamYFGeYzqcbE+V5K03G3CrM3nKN6VRqOB5ymj8Rua7PDhx1/RBlVZGT7u2D9j3hhPVW7Cj0tFaYIRu+KdfHAKa1F/tj2qkKNT7szPBv1Azx5YTkwOSd9t5GMZXXWe0jmN0iyCwTc0E/7H8cU5pxUOl6DNvRH4Gi5MxHkaEdeDbRRFwFpyrBJ9TtJ6lxd+tvTJBX8kFLRDSI+gFJRKwLLuSNwIdwT7po34Jf0fDRx++ATuh2BfUeibKR7FenUs1ur4a+Hnql7zUABbMwqZBeyF4mufZNz1erfgAw+5amGHb8pPxJjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG5+1UdnhO5LWzuTCluQSll+5xAZUcZirvdVkkXLxPQ=;
 b=GVSip4RDV+apODiaHiKXBrPXJhW29Ue3L50zmuGCGpf3rbmGSJSDI5y2zrGKSX6NabFZd9qdKEfM47mM6Onskzw2njd1SNgA/a2i5nYVj9ajZiisoceX4HAwvHp4rm88MVq/LcjaJr/uk2bWREO3gAF9QUmdoaAPOejUfBivIj3qXXxImJBhnCNKdWGZmIYa33UqL+gmV7mT7KxPeIYsDV6fNJi/nsIMuKKP+7/P3A+IMLkgiAK9GM48UaRw843Rdo91ScBukbVjKAGYAFsRNGU78IVWQyiB/x0SzXyf8fQwaFGjWmASVpUXwLuZ9CC6g3Gsd17BECC1eeprchkX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG5+1UdnhO5LWzuTCluQSll+5xAZUcZirvdVkkXLxPQ=;
 b=nBJ7eXlCysUowgrNuOsW8IQGlLi+PaToa8+31H21PueabVZuQ7kSsLHoohm8vG44V8IQBdPsbsSAw+Sek2g9WnRn9BuSzAH3yL5QXbl+LDOdzvCOmI/+3uJy0/U/n2bnaTg8hAq7/OlppabpJXadkfZNydbznLXVEQIDBL9gR6c=
Received: from BN9PR03CA0709.namprd03.prod.outlook.com (2603:10b6:408:ef::24)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 11:14:55 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::3d) by BN9PR03CA0709.outlook.office365.com
 (2603:10b6:408:ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 11:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:14:54 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:14:47 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Oleksandr Natalenko" <oleksandr@natalenko.name>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v6 02/10] x86/topology: Introduce topology_logical_core_id()
Date: Fri, 25 Oct 2024 11:13:40 +0000
Message-ID: <20241025111348.3810-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: df1b5e76-2a40-4d07-bf95-08dcf4e640e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PqM9USR/jpiNcX5uvKw1RuF93OKhQ+M5lrrQ65rYYwEVr2fWtOfPlWTw2+t1?=
 =?us-ascii?Q?sePocghQAZxLXmgnrXvTsiXwhCq82+GGGRZq+yoY7gcJufgqirqmy+oLnMYW?=
 =?us-ascii?Q?ro0nNJxLWAlTlMpARPVRX5LphoUILNoGJ0S+JvqamYIEZK/jIhOSmW+oP3Zb?=
 =?us-ascii?Q?ax/4/8RbjXn8MFyjtY2oyalzLQ8tR7GxUjoWw1EDpPDaAi5OMylmybEDZvu8?=
 =?us-ascii?Q?h7TSdhocnBcYbBpayezJ2XBPO7twEaGO9ZynBqoEwI6AcFRoFRDFk2l1Fkz0?=
 =?us-ascii?Q?SaSNcTsFDDF1SSUKCTzSDapGOAGGINuNa/PWHvnhs7cFLx9qmPmRkMrdBe9F?=
 =?us-ascii?Q?A0KjieFiQemboJAOKvj0ZPrg2qgWRdGLNKEH+7i0TwIBsHV7j8SyV9BB7dho?=
 =?us-ascii?Q?t+hUODSNj+RPxVigJR6bs+Uebq3mwyxgAJcn+zjDO0P11NjFSfHw1LAn/S9A?=
 =?us-ascii?Q?9Lbvak/rcg4OPYfXeMKMjMYlnlfOeCnSpGZFV6IL54iRu0DDLm6z1KL/FR1Z?=
 =?us-ascii?Q?/TBwg1l5b0S+5bho97xxoDiLSWnLZbJka2aRYEki5qeib3FeAUQp7oB3LAJH?=
 =?us-ascii?Q?LB/j0KD+vY+re4zYc6g/IRy3hg4ewCEV7cHfxRsve1ebsdKl40e1SqI73nSk?=
 =?us-ascii?Q?pJvXY9j+O6lDE9QQH2zL+TlAzq565tOQXdwnEz6slq0TKgJOTVhdV0xY+/Ma?=
 =?us-ascii?Q?NiNAvveZ0tH6TyqTlekSNiJsc10xiut0gyvnUjzN8AhUcZgLkyvW7xfPMi6W?=
 =?us-ascii?Q?5JoTUjT/2/1oF3Fv87P8s8Y3bcnzro31ddeW0RLUcq/l36EHBxYaJSOzpgQh?=
 =?us-ascii?Q?cuVR+kEqPeNjLU7IfA4E5lcf0sYLQjPzRCD6pY7HwUvsG7FIc86zEA/yUDXB?=
 =?us-ascii?Q?tGnW9zVw+YiUy80Q+kztz+xuGLlPfsqkwkSspQybdshGQu8lI45lI14m0Mm0?=
 =?us-ascii?Q?dDJDBGPBOj10/XRc/IS2rilH+kuoCyXbgYw4DuZkmPxDpXeTGT6fhOv5fgLy?=
 =?us-ascii?Q?3rXLTsRv7C4JPTekt58MyzumkK6j52lLxsOnJGVsii0wO+jSIOcGUiNWWeUq?=
 =?us-ascii?Q?0SmUj8ffcP9gmPfYMFtP6DJBwkP4BFeS80qh2lkNnURFPbaphFd6SN+wCHFQ?=
 =?us-ascii?Q?7QEAajBsZt8AsA6eaIEr+BuRTvlfRhBGMqtWq+J2yklGReV7N3nWBDXsdtb0?=
 =?us-ascii?Q?6dGNckN+lc9y+Dj2kaEKucdREX1x0UpynEIGBlRuoiL7hRCJIcCnwgSPfdSO?=
 =?us-ascii?Q?YvOT/L3sc2PNwDUuupyjlqOek+SKaW3nI6HS4laz8+aICUhqBm0HJZMr7daa?=
 =?us-ascii?Q?iHE5+lS2Wg2CSrs3OOLN9+z9OA4LlY+5wOJJ96tslq6dRzaBi/Y2+vTikUoK?=
 =?us-ascii?Q?7Hs09eZe8B+YvvSk+F/PhhmHi8CHkckHozIB7/nZUxx9bqcCIH/SprInZdu4?=
 =?us-ascii?Q?R9xV8FsWL44=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:14:54.7793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1b5e76-2a40-4d07-bf95-08dcf4e640e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

From: K Prateek Nayak <kprateek.nayak@amd.com>

On x86, topology_core_id() returns a unique core ID within the PKG
domain. Looking at match_smt() suggests that a core ID just needs to be
unique within a LLC domain. For use cases such as the core RAPL PMU,
there exists a need for a unique core ID across the entire system with
multiple PKG domains. Introduce topology_logical_core_id() to derive a
unique core ID across the system.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 Documentation/arch/x86/topology.rst   | 4 ++++
 arch/x86/include/asm/processor.h      | 1 +
 arch/x86/include/asm/topology.h       | 1 +
 arch/x86/kernel/cpu/debugfs.c         | 1 +
 arch/x86/kernel/cpu/topology_common.c | 1 +
 5 files changed, 8 insertions(+)

diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/topology.rst
index 7352ab89a55a..c12837e61bda 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -135,6 +135,10 @@ Thread-related topology information in the kernel:
     The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
     "core_id."
 
+  - topology_logical_core_id();
+
+    The logical core ID to which a thread belongs.
+
 
 
 System topology examples
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0e5dbf..595859cbf7ff 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -98,6 +98,7 @@ struct cpuinfo_topology {
 	// Logical ID mappings
 	u32			logical_pkg_id;
 	u32			logical_die_id;
+	u32			logical_core_id;
 
 	// AMD Node ID and Nodes per Package info
 	u32			amd_node_id;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index aef70336d624..672fccf9f845 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -137,6 +137,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).topo.logical_pkg_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).topo.logical_die_id)
+#define topology_logical_core_id(cpu)		(cpu_data(cpu).topo.logical_core_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e435834..b1eb6d7828db 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -24,6 +24,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
+	seq_printf(m, "logical_core_id:     %u\n", c->topo.logical_core_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
 	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
 	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 9a6069e7133c..23722aa21e2f 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -151,6 +151,7 @@ static void topo_set_ids(struct topo_scan *tscan, bool early)
 	if (!early) {
 		c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
 		c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+		c->topo.logical_core_id = topology_get_logical_id(apicid, TOPO_CORE_DOMAIN);
 	}
 
 	/* Package relative core ID */
-- 
2.34.1

