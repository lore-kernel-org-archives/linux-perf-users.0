Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6215B980;
	Wed, 26 Jun 2024 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387867; cv=fail; b=kp+NxQlhtfx6k+gEAaHtuN9RfxOhCfJ/4Eh/dAi92bfu1Jl3JajDE8/VELF7HDOhHPRmYOIfXKDlnleZ2KPlvj5zrbWofpUenhNntiPozHGGn9n0ZsLvq+uSezouRR6oHKPO0k95grNCN/1Qo7MBr4fxOp2wDW6IWzLk8nJ8znQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387867; c=relaxed/simple;
	bh=Dgt3icfkmQsAyKl5DP8ipKYrWEE0JqUlQ2tpRNZMbDU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lntz39V7UfYkTqRYUi+JKrl9Hzn3LoH0AuLlxvoBK1KgYBTrAAE6V3jS71LROYUZCNhSUZv/ccVJyrJoxKz9lbFaIUMDil+Hq5Yp2j0jQObuhX61kRrUwMdZPIulp45xU4QG9jl/wNDqrGfPbi3z9sp6Rj/eTwR+jjfqV0euE9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N8/5WSXV; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N8/5WSXV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXBjxQWZQn8vQAVJ3/QBJPp4hR2/l8u68g+24Ly/7yLIopHVldALpYNL+AyrAL4x6DjpGtHcFWZM/kuLRXbj7Ho83j2A1R6bRzMH7dJqK/xBjyKieOL88geOJ+FNxdI+oRmE3e24uXgUkG04M4Ul+y0o0VFE9aqBv6hcIM4sqfV7Au/a8CwDa1lM8Zt8AX1X9MUqnVRTVW/6LNfBainRnqIzG+kdzdneOUz/tYfch5u79RZJ9kUFWh5K5rPAdQZKuOCQXZRvK8MRZzcn8CRoMRkHOUVCNzOgiJQ7+okNALIDbNMgwy5AXsbUjdgwLj2knMETP/WzxvV8gZbQ5QG+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LYXGth3DQap4L+9NSPyjx/dxhgr4c5CraECk/HdOUo=;
 b=bkKvHjcJE9MMS1cgKcdifib8IWHY6fEadOi5BT0AJUoJ+Lbp2rhapQRGhUxgCvTU3mxPyZuPhpQ2m1z41hpyWGQo+FgZUWEMLxQtR4+e38iDmhB9b2ukUosXFNPjLQwAZgCtXeU0D3BzsuNR6rFoXzuy6yeBSJAm0tFAwErRq/rC9upkRUSfYkg2EkRfwO1094Fb29IoZLasJ86yGz7VenEj7oURVaclwVADGBuY1jCYacMeKikYJ+Wv04u9CjcdVhYXGvSnbYgV4WYJiC7Y3POA4H1mKKFcvjjhXjCiQB39dPsaqX+BePDI9OQZbzS0EnK6WtRWZHO7UQPPCzkW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LYXGth3DQap4L+9NSPyjx/dxhgr4c5CraECk/HdOUo=;
 b=N8/5WSXVxnF/hOsgHeQEfKwVWn0bvTGvQNIBFUOF9G/LpW+QHEwURjh/4MyZZYA65JPHssExvJKJnlEqwllmOGItY2VV5kdkSA/PNPon0FTwZQcZTR+YcWil0jDOZunULNIaAvV7PLN6JYPGZyH/9tVMDRbNX+skNrZlMCJ8FOk=
Received: from MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::12)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 07:44:22 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::c1) by MW4P223CA0007.outlook.office365.com
 (2603:10b6:303:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.23 via Frontend
 Transport; Wed, 26 Jun 2024 07:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Wed, 26 Jun 2024 07:44:21 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 02:44:12 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/uncore: Avoid PMU registration if counters are unavailable
Date: Wed, 26 Jun 2024 13:14:04 +0530
Message-ID: <20240626074404.1044230-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a09c9b-ca13-462d-9284-08dc95b3cb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HAHbiQsMWJ7ABXSynZWb2oaPqvRIzjy9CQWMdl6rNDpSO+hl0pOtDCGNFwrE?=
 =?us-ascii?Q?ddZIMUiOOx22oR7E4wWGAlIkdlx927JyXLk+Jg6goi5q8gxKgH8J6Tcbqmbn?=
 =?us-ascii?Q?qBGWUivLfqTQHL3k49exXiEyOfRlDwxvfGGWvObHDNU4gzbN6oPW4MCB2Pto?=
 =?us-ascii?Q?zVZxYOsYqEi6vJfIhfY9oeZdy2LvKqzQLDj6trR4heUvpYeAzK5H+YQOiBYG?=
 =?us-ascii?Q?RvYtSofFvqsuWseq4Z7ZRtt3t+zVpvQcPsZ5m7DyL3n/GJtv3JNkcSuxNdeJ?=
 =?us-ascii?Q?nTS5yb/siug3W9CKSZwBwqx/Da66tI1d1oRDkalOWxbP/qtB7ovMU5wBzEM2?=
 =?us-ascii?Q?hNkEtGp78RnkDQmNz5KouDyE3qbTFQ2I1SU7ZZL8sno2UEv0Kx9YsynyJcAy?=
 =?us-ascii?Q?3se8A68FiVFJvirCKmuJWU2le62mMm1k9arkVdcgPNyKgSsqD4kQB0cMXjPi?=
 =?us-ascii?Q?ZDQa7sZjjgwaXTwIMJDtCsL4fBkC3/ulH8aHSvAm+B6F3kR90jczapOSqOzO?=
 =?us-ascii?Q?/OSrtiuGhidy52Od3AoMFCMhfPOvHe9IPe5TjTPdrZpngg+kk+J/IeO2mAJH?=
 =?us-ascii?Q?I8GTMdflcO/w2AR65J05YHOsNgzd++cXkeH6NfNZ3VXkR+K0hVhtUuTWAMVe?=
 =?us-ascii?Q?pGdudN9IViZrUCsm6Yl55MtrZILlI0VZpxsn533HXTHMcllusOKH62mPbHNW?=
 =?us-ascii?Q?N1rqOvxG7XzRQgHaAxxy6S7p/BTprxFv7dDH5N9fn2gVVm2iOnxxJWKShZ6Z?=
 =?us-ascii?Q?GPQyyJF/p3ppmrGiiipytIqKy1OXBCiFEP+ntpXrqDbyG7vdcX1paSCJpJWJ?=
 =?us-ascii?Q?MbfRxc3p5TtdU1pNVdHJ4dMKD7YhU+P8JhlSI4EbWYQ84G7Czk3GU6ekhezd?=
 =?us-ascii?Q?kjw0i+cWIYPc8+notS7jtTvsVNmjLESWEGuUdJ38ejsmZGA4dtmMbyRWcg1H?=
 =?us-ascii?Q?H1E7E1tu5wYsK8LaJNVYVRL0cpGcELUyLQ/jhMYHAaAGaHEpluBcasna9LUX?=
 =?us-ascii?Q?iBd05X4q4JbtD6rMshy8gUsxemlDUoXjn4UnmAn4ZP3Q7ShJ5WyLqSpv1onS?=
 =?us-ascii?Q?p9CPukfNuQDlfPz/LUNIud2+BNU8ZXyf4oN9bOiI/Uhv7zEaNANj6riwr82B?=
 =?us-ascii?Q?0vV4THS9Tcymmy4vR2MlbqrRKTzTP2vaIUC9GjLFtl3RRb5z+MBYRos+GZEU?=
 =?us-ascii?Q?YVdMZt/Fb7mnYWsXvuXd1kX7W5P/jmweEDX7Pydy6qF/J7Jpo8w2sM1crLLD?=
 =?us-ascii?Q?23UpQdTv01wbXY+LdVwPuRQnbbc1pFtTtt+TONQNFrA/Q6++5RW3oWSFgp5j?=
 =?us-ascii?Q?F7MC8fsbTKq6bcesfBKrkRNryIRpR9Dyb8WR6nzg8s4vUMTqUwvuHOR4t0Z6?=
 =?us-ascii?Q?+ZL/HTjKHSFNEeWh/IAPtFZNpOEBsalyzDjNd6ahxIJrOn9vzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 07:44:21.9674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a09c9b-ca13-462d-9284-08dc95b3cb3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209

X86_FEATURE_PERFCTR_NB and X86_FEATURE_PERFCTR_LLC are derived from
CPUID leaf 0x80000001 ECX bits 24 and 28 respectively and denote the
availability of DF and L3 counters. When these bits are not set, the
corresponding PMUs have no counters and hence, should not be registered.

Fixes: 07888daa056e ("perf/x86/amd/uncore: Move discovery and registration")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4ccb8fa483e6..b78e05ab4a73 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -654,17 +654,20 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 {
 	struct attribute **df_attr = amd_uncore_df_format_attr;
 	struct amd_uncore_pmu *pmu;
+	int num_counters;
 
 	/* Run just once */
 	if (uncore->init_done)
 		return amd_uncore_ctx_init(uncore, cpu);
 
+	num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	if (!num_counters)
+		goto done;
+
 	/* No grouping, single instance for a system */
 	uncore->pmus = kzalloc(sizeof(*uncore->pmus), GFP_KERNEL);
-	if (!uncore->pmus) {
-		uncore->num_pmus = 0;
+	if (!uncore->pmus)
 		goto done;
-	}
 
 	/*
 	 * For Family 17h and above, the Northbridge counters are repurposed
@@ -674,7 +677,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu = &uncore->pmus[0];
 	strscpy(pmu->name, boot_cpu_data.x86 >= 0x17 ? "amd_df" : "amd_nb",
 		sizeof(pmu->name));
-	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	pmu->num_counters = num_counters;
 	pmu->msr_base = MSR_F15H_NB_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_NB;
 	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
@@ -785,17 +788,20 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 {
 	struct attribute **l3_attr = amd_uncore_l3_format_attr;
 	struct amd_uncore_pmu *pmu;
+	int num_counters;
 
 	/* Run just once */
 	if (uncore->init_done)
 		return amd_uncore_ctx_init(uncore, cpu);
 
+	num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	if (!num_counters)
+		goto done;
+
 	/* No grouping, single instance for a system */
 	uncore->pmus = kzalloc(sizeof(*uncore->pmus), GFP_KERNEL);
-	if (!uncore->pmus) {
-		uncore->num_pmus = 0;
+	if (!uncore->pmus)
 		goto done;
-	}
 
 	/*
 	 * For Family 17h and above, L3 cache counters are available instead
@@ -805,7 +811,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu = &uncore->pmus[0];
 	strscpy(pmu->name, boot_cpu_data.x86 >= 0x17 ? "amd_l3" : "amd_l2",
 		sizeof(pmu->name));
-	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	pmu->num_counters = num_counters;
 	pmu->msr_base = MSR_F16H_L2I_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_LLC;
 	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
-- 
2.43.0

