Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAA1547CC;
	Fri, 15 Nov 2024 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650965; cv=fail; b=QvBEDTrfEOvDg4U/jIh/a3yuYnD5E+zqj3YT/KtPy+XEBfZ+oEOsEXaHzyvPMqgU7qaLPVOVBQpBTXFubTTZQSFucyElRPyu0EsHryqT9d35CWpnjAM6vhMSG9PTFlxbK4C6ZMd2gGvvUCdQ5SyeQF7J3gbI1eTkx2WtgPyJHs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650965; c=relaxed/simple;
	bh=DCBk+RH+jkqB4FvP+Gb6JLxaAmYg61hYeJaGCvnCKiI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBxTsIFQpshbjcGOyy7CtQhTKJMzviQEhU0X66JzzisenVm2S3RLojLoeM+9gWzzduXwPFhfgGMD5Oea19nFaSMw8VW1fuHigrYoJXSHmbzc16oRCFHqQtY+z/DBXnnK5Cd/yKRRl4uO7WJhfXDgJuxFkrl4VuKGu2WUgbEeviQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=13sN3uBA; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="13sN3uBA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cv26BFdWjxtE53d1lmJsY0j4OP6Pn7saciaWZYWusDXQA8Wzgc+gPASVJVroEmMxP2KuUodfRKd9Kqz/07VMEBp9zD904lvWn76rDzRYtYCUlxGw/GchqtObcKmwhiGx2l04C2Pdic30+Rmpjh4ifOw0eAiSkWjcKJ7VKNRmfeYCTR9KX7Ts+Pq0eM5+bkJ26thWaJ+ll4K18atyRRoh9jqEyLMcesFmP9BEXNlT2m02COqcFz5PGtLKfAGkAuIlx1f60MvycEA4mHeeDp/CDqVR9BwcMX2fg9TZ1fnQhnWAhu7xDlJvQdFK4DxB3kG+N48LEk76u0qDWfz4qV5Fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2z8fGzi8mp9GdSs4KoRl+q4SA73TDgwWEv9ot+7D5c=;
 b=gqto2Jjee/N1P2ZYkrhU4C0SPW/+kmAO/iYEzufbT8va77NDQBSyrAKgsopm06DxGQnH0iDb+cz/RbtztS6mKei+1+Rvos/iMOizLLTmU6SKpyzZevsHuDxny6/xjLDKLKHGe7Go6VfKU62pYuXybsvwiYrvNmJq4ccun5GoNRFmG4c+6rc62adjBKOOFeWjJm7PcvohClCZs10KoS4O5/51XxHwJ+Che4G/Er9AAEL4Bx97mwxQOWRfZTMQXx8ymIWRaCeZdGyuA4r5JFNbPBN1+UZNGvljBdboKsbJwb3E3HIY7uSw7wvaLYfhfSxUmr+X0o4GIYQ4sf/SKDMs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2z8fGzi8mp9GdSs4KoRl+q4SA73TDgwWEv9ot+7D5c=;
 b=13sN3uBA5STcxkB1WeCJPtLOsHCV+bw8i7Yvp5uitvaZtA9+qSjQE0kLy+DJDsPDZtm3DzX5FTVXUsac2GIiyXRGrLs0uoAhfIJBseoFFI6bRUCR45SED0R1jBWIk0omFkwOV+bzHbENnqPm9MbshQ6mJAJJehr3Pv/XfwqZ7r8=
Received: from BYAPR21CA0009.namprd21.prod.outlook.com (2603:10b6:a03:114::19)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 06:09:18 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::7) by BYAPR21CA0009.outlook.office365.com
 (2603:10b6:a03:114::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.8 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:17 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:09:12 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Oleksandr Natalenko" <oleksandr@natalenko.name>, Dhananjay Ugwekar
	<Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 02/10] x86/topology: Introduce topology_logical_core_id()
Date: Fri, 15 Nov 2024 06:07:58 +0000
Message-ID: <20241115060805.447565-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: fc20c54d-4162-4b35-333b-08dd053c0a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZwLLIE8HGQjOY0gqt6tlAfho2DuHPSZ8xjz+KG+zxeCXoUUq2fghSBSQxVyb?=
 =?us-ascii?Q?pqG2LnzXskU4+HhMqGPbO1/xu92PGedtgrs8M5q8WS0mblk1imu1o7CcGc7R?=
 =?us-ascii?Q?b5ycS/nKaRvcsZKaEpgpW+dgqL+79vhT1QPOn560jjtmhSifDqJoG7B+KpSD?=
 =?us-ascii?Q?FoHwgvrpBTeqgBcbpmock3jPfguBWV8zvMZ4QhdWgZw0I6gi8zDsCi+ReUyx?=
 =?us-ascii?Q?gaf+5/UfO3hzOdVwwor2UpIWt1cOn+7HbK+qADqwdVZbnKQjAzjzxQXCi6it?=
 =?us-ascii?Q?atcvHG+fouJ7LS1Xbff99rsBr4Ize0oJ/3K+/jjbilYrNhRuI80GTOAUb3vq?=
 =?us-ascii?Q?agB5WB8ooh8syZ9xLf/56+h31WSsskBtcPDMP1KvINYWgU38JUKMGrPdFLyz?=
 =?us-ascii?Q?ltUKAlmsTGwmQHurA2vnWCO0kdvrsj5NFIkPb1ioschjOmeivrlP6YPM3hmI?=
 =?us-ascii?Q?suDeSDdt5blobuXkGvggXcz75iGrfAsvSXJ95jprWnx6/3Sb8erTKIO60IfI?=
 =?us-ascii?Q?pvlYsEALbLkRtpsjqdDZcOizldBMIo7AxavG+95lQRpukwFm25oSyYKc3S6o?=
 =?us-ascii?Q?xL8OukrAEObSExFoJ8MsMrT6OLKbLTrDX4IJwjohJLyup0pvybaX2cp6P6b1?=
 =?us-ascii?Q?TXolGvIvppKdDjhry6HMSeP30SyuL1oRkJfnODYZzENw+a8KSEbewCnrnAlE?=
 =?us-ascii?Q?WqAZhpOuD8uKeQSDlVnsdaaLXtiBOl+fsgBrFY+YJmaJKQtdpEakanHYJmc7?=
 =?us-ascii?Q?tJpmYut1TQaOfh+gYmDgCPdj2PITnRiDvsxVXSqH/P0WdL6Icm//tbq/ky/2?=
 =?us-ascii?Q?4TAQ8nromh52rI6cMDmdtUANRm3uU9ZHoY5GMMFkoPNfcpJgxBM9U9xFVw9l?=
 =?us-ascii?Q?Jkhj4gnbg54gBqfIiZ5SDSGbDrP1xFgXd9jvtjFCRvqMKdOMD9a6rsIePvkB?=
 =?us-ascii?Q?seml/7u4s6ZFkXdqG4sT6xAdVoCPfaT6cjvCif63I0UR64L8tTcsYXvpaiGx?=
 =?us-ascii?Q?jab9+2Ts36xFZlhePDv3v6jB6kvsrEhLnFOw9MmvZ9/QiP3miYJzOZiZDdSz?=
 =?us-ascii?Q?vQxnxNlTMnDN+1jWHO9GB2wfaICfggTnlBp/waZr9NaPiofZkCwxbec2JjET?=
 =?us-ascii?Q?lgkOsh35LUVHibhbeXkFGD7VwF0VCXZslODSCEdboZTz3ptSqpMudF4khZFs?=
 =?us-ascii?Q?pdMW8hV+vRT1nzppx2jRveGFmzKYEAK5n6RwL6Ieia/jcM5dBTB/vUyXz2XY?=
 =?us-ascii?Q?KsiQYYpNmQ/hERJvp67YnutzSbyQxqZBWU5vgeDmtwbe65tX8fM0k/Zs44JQ?=
 =?us-ascii?Q?rgqwXxTs1A2fEgQAZrvzaCRUEVqIVuWUtu7QrNzNb/LCGd1BI4VfTIUPF2WS?=
 =?us-ascii?Q?xL9/DcXz++pCgAf8n77VvL6asRpOGp6w/fa8wGZgMpow3q7oDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:17.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc20c54d-4162-4b35-333b-08dd053c0a0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623

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
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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

