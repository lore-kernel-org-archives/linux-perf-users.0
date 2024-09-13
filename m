Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43707548F7;
	Fri, 13 Sep 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240954; cv=fail; b=YDcYVjJIs2fww/gWAUG9sUJmzHf4qujCVlFgXJbKJMXWBjwpJbfgefwQJsgdJpTBEDHBx72NG93jFGKa1swr1E8jGkdFsouRUmm6qcZEwQmxObU2LQyCQoYBm/VH7nFHOFgioQRLkkGysWXzk0aWONeulB9Ukm0ysfxCsUFIsUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240954; c=relaxed/simple;
	bh=xjzrrqa4V3g8iyVbuvbBxLYyuVTWbjszasg8QlmvZcM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUitAOQxo6nqIX3DmmNZA2Gdxdi8ZOQ0CqkeKAhF5r+KC7w5jppQy3RfTaAwgXwzsUGCYsc2uNW35zW9yaOxvN316AQew4EgivNVlVDQruugDm0wgy57OumShO5i2avkNYkr53vSdA/4+tXsURwjj22OxHeY93thyYkTbPHfewA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dZlmBPtJ; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dZlmBPtJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxDge/ntPYpiq19g5ogLsvrEQFMmlDkwYNiJy/wOoyClB3DOwebv5vWaDz1k64wlwLrc0JO56Sn8UdajW/tzn2hnUaIt9aUb/aFg0/vBOkPBepRMUUgY3KP78fvOQPBNycyPPr7yENKOEVKH6ORsnDhSbVBf1CWByc5TfEj+wVTkyjwuHgsLYC0lQVuTND0IE1PL26x+oKnFkpCo2G+NPFozz5gDgODlu+vYqglWaS/XM58veDf4S0IOTCrlA/2FLKrB339PeSJDKlBEb0cGAyMYD0GZRBm8dcbKjlm7/cqsJLVnoLo5j5t/JXW1MF7PuUbydrEDSCho1VL24LMhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYT4H0BjOPWqniGjEtj0aO5W+Lg5VSEO1rN8KN9PFZ4=;
 b=iz6melzc6RdxrlsPpgxIc+vXUnOoqjFtiiPdT6N+fQ7YvqQqukvVX7AcD64DwgcEla8t7QFF9AFYlbJPmYm9n5luX22WxEhrnU8b/wJOg7v8N+/NBH7NUBfRBOisgRsBAOzNIBkrhxpljlpxfD4NWvTvUI5O/TYM8upBePwHe+64sYBBEa5xwMaE3YIVpQ2sSAQ1U/6AAfU7UbkhynQWzJoaq+nVBDSS/2hbZrhU7wXhWD/IU/pBJCzsDJGSySWbjBR/joGOS2yfqaFvSNvu2cioHl3DWHPo0EQpHmS7LqOQfuvTDp722UiV2Bjkb2GA7h930ZMcSoKBR6JifaDtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYT4H0BjOPWqniGjEtj0aO5W+Lg5VSEO1rN8KN9PFZ4=;
 b=dZlmBPtJElM1A1/Jn/FlnbPeM1fvBJ3eDl3zBMI9r40zFmkeeSYXKaeA0px4HTF5vpj5CXxhJSBEjt2nIRRMCej7WSIhoZJc5XSXTkWsjgBsepHwKMlS/lBSGjRVmgcwYa/aXnWUq9s0T4XqSpM5a11kkPj4wbFzE1B7HITr4HU=
Received: from CH0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:610:b3::19)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 15:22:29 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::8a) by CH0PR03CA0044.outlook.office365.com
 (2603:10b6:610:b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Fri, 13 Sep 2024 15:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:22:27 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:22:21 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <rui.zhang@intel.com>,
	<oleksandr@natalenko.name>
CC: <eranian@google.com>, <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v5 1/9] x86/topology: Introduce topology_logical_core_id()
Date: Fri, 13 Sep 2024 15:21:41 +0000
Message-ID: <20240913152149.6317-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: fb991843-b2fc-4547-83c8-08dcd407e0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w4pZXLEdXG8NMopLFvsU4O8KTS+oL2tEYkmLm7gs5oXTLS2taz3azzdKV85W?=
 =?us-ascii?Q?V7Gap8L6gb2/yoQWDDfCVpkRJi8Kqod6Rl8TgAfppigReRRss11hiiSaQF8k?=
 =?us-ascii?Q?ysQkVSGZvMTKsgneO3eErFYQP+Xlx5l5NMW+mp43GKVn2iA/oCVdc7EpF+PH?=
 =?us-ascii?Q?F1TE+NvCSIbZm/bNETxp4snZ6LKXptzrxwksYdwa/IyRd82rJ/rvtc3o3XzA?=
 =?us-ascii?Q?woQLXYXi2WGU4PiwFSsQITCOzgKmCVs+SyTTiLlV7oy6Bq1LLcGql3V67bCi?=
 =?us-ascii?Q?5OPFyoXDsRy8LAOtIJawJcxHgDOBLgFKhOjexNh9udmBimr8m5Es3AQl+73Y?=
 =?us-ascii?Q?Gkh3Pa6clfInCMhCMJfQv5pyS2yXqrXzRb2FBQqACFEJvqWV3RbUBboGWBGe?=
 =?us-ascii?Q?MKzqZCUnQ/u80U6SsA1Mhe8R87NonIwCD4aFw+CjNLeAYUP832gKwk3OvIIy?=
 =?us-ascii?Q?2OY0LhOdme6WW3etoc6MYLQkantyDIo9wuzt1K4zA5cJ6NuYoPisEbwArmIw?=
 =?us-ascii?Q?UnKh5afPGYmhjm8WxvTFhWbIoXvMyNZWG/5x3VuCSKPgPpH45+kdihq8t+WY?=
 =?us-ascii?Q?28sSevvw8/advTwF8JhoKfv92VqVv6JxWUz8ud5/Tuv43sf9oQipuzhhmJTE?=
 =?us-ascii?Q?htg9PzO4spqSkB3U/VH7JE2X+4gk3H4HOEhjxDeTgX1E6HMYnTsnc8xMk/Or?=
 =?us-ascii?Q?pEgM0lStu2kPMKcLU/goPl/VOSy3BWCR5OnrLy3GyiovUtNIazOuqTo2gtm4?=
 =?us-ascii?Q?DUfTFzcPnhgv2zqf8knvsOLArUapmNrf7h4897Bf9XMEzOEPfuaWECyhOf+A?=
 =?us-ascii?Q?/suS/NlapE4fLdsi8ifjjjt5dM2lreB/Jza617udBU+ErvixikYF/0jA2HMF?=
 =?us-ascii?Q?Y8dadfd5g/E2Q/vL2kUXohJ1ajbaiAJ6NLmPZwwt1Q8WkjItrI56AAuMjaFz?=
 =?us-ascii?Q?F9us7m1AjRv1bn7tLSAaggpZbBuM+cHBEMnYQpHB85rJ8SZGQ1yH1uDu06BB?=
 =?us-ascii?Q?h7sx64IO17LoeZGdWR9VZeQP8JVvAfySundpG2OAeVOXRt6T8m342qf3qfZD?=
 =?us-ascii?Q?xQJ13RmTKGvA7TbVb0iSQ5VYh6b0xQCawOCLMFGrVUfufWFl8vfSZS+7DcNv?=
 =?us-ascii?Q?jY5LJaDVaulLoj/A+iCFUrekxUdOHRpEq9wPn7nU59LVG/eU8+DvcxgRfQFb?=
 =?us-ascii?Q?l/Ct19pzKsP3dNieYU17GnbrECZ82E6iKO8cZF+DVmcxFB3YmF4S1chMCMcG?=
 =?us-ascii?Q?HT2r94ufsyfcmHNJ+hXUwSqbfVpE8CdktNWLnPqhwmSATcfBaGvSa5+iOw76?=
 =?us-ascii?Q?wQRDQ/PdYa36rDM5uLw8IXyBturGB8yrktGVUGJ4Rj7yZ+jVUA3hXoF3/HLk?=
 =?us-ascii?Q?SJA4BFVL9EKVsxSpBvPd+IXyaPTY2kafzOFQ4O/JecBReKORShe4pXOt+SvM?=
 =?us-ascii?Q?LQ9NK3gzmGwIagg30mCXrxXgAPNmFJK3z2DF4rfwt7+Fd6Ir2/UF8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:22:27.9755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb991843-b2fc-4547-83c8-08dcd407e0c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

From: K Prateek Nayak <kprateek.nayak@amd.com>

On x86, topology_core_id() returns a unique core ID within the PKG
domain. Looking at match_smt() suggests that a core ID just needs to be
unique within a LLC domain. For use cases such as the per-core RAPL PMU,
there exists a need for a unique core ID across the entire system with
multiple PKG domains. Introduce topology_logical_core_id() to derive a
unique core ID across the system.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
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
index a75a07f4931f..5a59713ec62b 100644
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
index abe3a8f22cbd..2a6dbf965d92 100644
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

