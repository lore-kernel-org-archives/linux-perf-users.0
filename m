Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F117C9B9;
	Tue, 10 Sep 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958586; cv=fail; b=DjfC0xTF096eGukFhppziNaXuhKmbb+RMn7WMNxpaO2fdYPadBFngcrcmIiEv+47X7jZHm8MMQxx7RVLsmcl3HMX+MWuK5FVFcf/i4xuxXky92KIZV5HPCjaK6XpJGOBz0p/N7uDQAT9HR9nQnvBdOXQaVqtXaxQLD4URiMzHPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958586; c=relaxed/simple;
	bh=NQVnPc0yivyJpg9EIdiVg7t/lid9Zb516mnMG6tGfOc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EX67kvgEhNAhDPeWd0hEa2MPvE9EVyihlU+MfUiHZAcU59CsTxfABzjqBqwkWNLqN0s7MzMINiW98QZcdX+JCyfpt28KfzXk+odOT+RzPegnYt1gzzvCQd6uK/PLcXWfqZ6IX9VlBHih2ZzZDaJ+W/Dtohd3+QyFg0nLAmkC7ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tWR8wHnb; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tWR8wHnb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GViyah1MxNyKxQuKJaF6erftPnOvqzFyZyD6MfoHB4dCd7vbvzICKy1TjmE3QRlNhdDTY9Bm6sI/RI6dAhdPNbz+nyCw3gA7CvATRvJu6zrmFZrsx6ibW9JUid2LOMd1DID0m4AT1Xe2ybP6xpFRuYoBWItHN5v4eQLyUms/k+yfgrgm3cuMKir6z04A3RHKJg9ECycVctXsvcdzaUpNhcjBVnGeRAWkMh8iHodnZD0kwbpJ5J7U1gl0U3CGav/QbgaFbr8zkD4DFIh5lCl0w44Kqpjidc2t32k/wmZlN1MAIOzmgbj/2U8TRIcqW9zz4GGrUGwwIg3hgVChLm48VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hd34vzBUMqIAYGilcmX+A0m+ZJ5loLCdF7UdPOzizk=;
 b=dtLIk/cXKVlxOiNi/JrsYE8d5FROZz7iEhv1N1or0MZ7IY2DcJ3cT1BAVN0/kqKzsJ6qZn4zw5dycyCx/hpf7f2UsY4g/A6OyNdFAy/7vj5+/7r6k7vm2B2PdTFzdjwJh+JhzbiPEJpc+AxpdYYrgAzg+4bAb1Qmc4pRobMkBMsQhExLVrY/JTKEoTzJeOWo+7/L/6oWFbvtUk/2fp6ltMjis/vhmw0Vo+87tOOc+kk5i1xXh0JhCh4vt9zl/Ajtfe9A/YpqnzwMDlzFXJYxTXr94uTyp+P98RYxclhudf4M467b5caZC+zSyzLylgW3b8qG0e/wGcQwOnrAcLFffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hd34vzBUMqIAYGilcmX+A0m+ZJ5loLCdF7UdPOzizk=;
 b=tWR8wHnb2fi/R/oGhVdbjlA35WI8WdkhyHt//a7SgADGEybzZsN4hrnp1DD9CJZy3ZUHYFz9CWALG+hPUncmeDKbqIYLGl6F/lXATxx9pfCV9vY7wMrs0xvbAq1/zbWwJEG8Yr6/yFICcPVmp1IaAqiqI7Wmd2iyxCN7jdWsZSA=
Received: from BN9PR03CA0092.namprd03.prod.outlook.com (2603:10b6:408:fd::7)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 08:56:20 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::5b) by BN9PR03CA0092.outlook.office365.com
 (2603:10b6:408:fd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 08:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 08:56:19 +0000
Received: from BLR-L-DUGWEKAR.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 03:56:13 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>
CC: <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v5] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Tue, 10 Sep 2024 14:25:05 +0530
Message-ID: <20240910085504.204814-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f4ccfd-7d6c-40ce-48a5-08dcd1767022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yspAMLYB+ZGihQ1sPaw8t31Hc530tQDp1tyKY8OTHy7DrfQFx6DaH9trNcyr?=
 =?us-ascii?Q?QAWjtn2kGnpxwo60shapN0WJTO3gzbaHPjZJ8UzRhGv3ZoYrNaJINB2hmBPE?=
 =?us-ascii?Q?5NrtM4uhBB0//YUQhTC8+T/l+ECTTQ4ee7lZkwTizw9H3XBfMjkLcz7fTq18?=
 =?us-ascii?Q?MGHZ41P/wCJvljUgMNBV0HibFaqoS836TM30R/RpkXfE0A/3FHPqykGO7tDw?=
 =?us-ascii?Q?r3ujvq+tO+sGRUzlmBL3TcCIDE1mQINwPr6uTMSAVwV3/yd2KYJaaLKqTSMf?=
 =?us-ascii?Q?JalaQ5YjldQts6sbUAyfoIqiCM0mArgzW2YtSQzglV5WDyFYEjgALgpsj0yy?=
 =?us-ascii?Q?Sj5lg+pVs0ilFP+SeVRHYkbtl2Tm0fWg8exKg70HzDeyz8zeQYGuZMhbRAYU?=
 =?us-ascii?Q?RjtURgmQVZ+tWT3w+0POgOTQxVe3ogqrwSWdDSXm2jWB6kypfjjTlXPtF2RS?=
 =?us-ascii?Q?Mkt3grVOYkJT7s/GxJFcKRzsq7UNR8fE2H2DIDIbRla8rWsOvbD60eNapKaj?=
 =?us-ascii?Q?YAjkQQXtIagxYmGceYkz5CDi3Cv2E5NTSSpthEMNw88CReueGE7bu3zLzAbo?=
 =?us-ascii?Q?iu5DRTrw8BVmo5fy1ktCistjTKV76XxaidWRsoUlOdr5ge/BhyeDLRh2yusW?=
 =?us-ascii?Q?R+V3HqsnO8eCmya4lZcRcZQV7SBJP/JL/EBUsBV+9DVtHY0Po+KQYE5X3dBS?=
 =?us-ascii?Q?6+sy8gLo4xxd7Jv9gAfuPOW0g2PMQPkU7Jv2Fh7nbQhs/TC8NGbSbXYl/7fm?=
 =?us-ascii?Q?SUyo5cn+02fsbQ8owJJHengT6RFVQgq4vVCF2Vgqh175W3xeCEWuYe4xIVBp?=
 =?us-ascii?Q?wWuU15Jx3KGLuG0nbmjhQAa58VcvcMrEUHL+xtT1VDa+WHR61mnIAb9IxQ5O?=
 =?us-ascii?Q?fEGzFK9xx99KHgHEs/t7kdiyk/IjVT0VgjlZzFSwkj5vrlvcim1CmAZFfRpa?=
 =?us-ascii?Q?I3oHhGoAVZe83OpydPsj2V0EdtAimOXyOwQNsoaQVBsLJLoWHQtouqP7CNi0?=
 =?us-ascii?Q?z8vPTbEsLP8BnlYe7sG9ipcPhjyE/3EmUFg4jWxgg7B1ahZYKFuWHmU7rqRn?=
 =?us-ascii?Q?6qo45Jtv0qllhMdnMF1ALcLSaVOKobtPDP+PoSAMeEC3dEhm2TQhhXC7vnP6?=
 =?us-ascii?Q?qsI0SgfsMZj7vmcOhFRqk/c5GxmtGnrh4NIFQ1iiUSESli0kbLX9XyUOiUDJ?=
 =?us-ascii?Q?jHyn4Cays2cUvvvYbLFKaj2P9fIwT8j2X+9rI25/9Tlw2zPghrr72xD9mhRw?=
 =?us-ascii?Q?7ePicwNqHNfZ3sEmFvqkqk7x7fVPan+J8avDu70BW2WP6f/uiK40U+RJaTqI?=
 =?us-ascii?Q?tCekcMUlokJWojLj65axlmtSp63N276CAiWYbNLoka0modUFZPCDJI2IZAeJ?=
 =?us-ascii?Q?BN+GiwFbzGgZ8NAuHlyeHF9vyYHeMACO/wbnAB2ztKCp/jO/ADYt8XIbZ7ko?=
 =?us-ascii?Q?v/kLytg/DDm+vQS3ENbjoGQyBJ+awDyfWiwilvFBHPBKcBL3MnbVXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 08:56:19.6627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f4ccfd-7d6c-40ce-48a5-08dcd1767022
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679

After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
on AMD processors that support extended CPUID leaf 0x80000026, the
topology_die_cpumask() and topology_logical_die_id() macros, no longer
return the package cpumask and package id, instead they return the CCD
(Core Complex Die) mask and id respectively. This leads to the energy-pkg
event scope to be modified to CCD instead of package.

So, change the PMU scope for AMD and Hygon back to package.

On a 12 CCD 1 Package AMD Zen4 Genoa machine:

Before:
$ cat /sys/devices/power/cpumask
0,8,16,24,32,40,48,56,64,72,80,88.

The expected cpumask here is supposed to be just "0", as it is a package
scope event, only one CPU will be collecting the event for all the CPUs in
the package.

After:
$ cat /sys/devices/power/cpumask
0

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
v4 Link: https://lore.kernel.org/all/20240905153821.3822-1-Dhananjay.Ugwekar@amd.com/ 

Changes from v4:
* Rebase on top of a fix [1] in the PMU scope patchset [2]

Base: tip/perf/core + PMU scope patchset [2] 

[1]: https://lore.kernel.org/all/8c09633c-5bf2-48a2-91a6-a0af9b9f2e8c@linux.intel.com/
[2]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.com/
---
 arch/x86/events/rapl.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 0f8f4eb01278..ce04dc5844c4 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -139,9 +139,32 @@ static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
+/*
+ * RAPL Package energy counter scope:
+ * 1. AMD/HYGON platforms have a per-PKG package energy counter
+ * 2. For Intel platforms
+ *	2.1. CLX-AP is multi-die and its RAPL MSRs are die-scope
+ *	2.2. Other Intel platforms are single die systems so the scope can be
+ *	     considered as either pkg-scope or die-scope, and we are considering
+ *	     them as die-scope.
+ */
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
+/*
+ * Helper function to get the correct topology id according to the
+ * RAPL PMU scope.
+ */
+static inline unsigned int get_rapl_pmu_idx(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
+					 topology_logical_die_id(cpu);
+}
+
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -617,7 +640,7 @@ static void __init init_rapl_pmu(void)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
+		rapl_pmus->pmus[get_rapl_pmu_idx(cpu)] = pmu;
 	}
 
 	cpus_read_unlock();
@@ -626,6 +649,12 @@ static void __init init_rapl_pmu(void)
 static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
+	int rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
+
+	if (rapl_pmu_is_pkg_scope()) {
+		nr_rapl_pmu		= topology_max_packages();
+		rapl_pmu_scope		= PERF_PMU_SCOPE_PKG;
+	}
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
@@ -641,8 +670,8 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.start		= rapl_pmu_event_start;
 	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
+	rapl_pmus->pmu.scope		= rapl_pmu_scope;
 	rapl_pmus->pmu.module		= THIS_MODULE;
-	rapl_pmus->pmu.scope		= PERF_PMU_SCOPE_DIE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
 	init_rapl_pmu();
-- 
2.34.1

