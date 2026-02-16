Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A382C11FD;
	Mon, 16 Feb 2026 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215968; cv=fail; b=qW+w+kBNyDqviABjpS9gjonJZX8XvPo1DekhZHdkT0XISShx9fHd7ZPZFj+jdOPSnfpXdqdIHleDAW6ajmeqnFSSmIg6yBVyuylGdUJ32EAcCu7ngqQLbWzLklXyoG2ybvcCMwLIrt8LSEbCZ+t8xu+7nkKbr1ji2YLMl0/j0Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215968; c=relaxed/simple;
	bh=akv00L/auYrXyX1vIWTcfVk62/WLRX5xPZoJWG3+R+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeQO83IU6ucDtiPJ+WCEWcPNj7ernJABNgOtnH9VnmaRzci73R393nggRW1c5fO/23zxcEnFKSBK0wODNfQbD8kp3Ijz30BHimpi3kORm85SkR9IuIG10dcG7xa80L1owpeBr4xdw3W73N/7vwFeMy+acrJpdquAtT164SYorpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5k8+hc7B; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5k8+hc7B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/ZcfDP3hUr4W41BYNSXRv480MPuw4o+aj2wOlgLh9O5cIPsP1dEF19jhQZYmBwF9fv0JS4uilUKWe/NV3ewMkXfoUaTo1ChQSzzAYkDBU5OSdED05ucK66cFZBjmg6cl2hn6ZHze0W13n2SFT9Ei30e7qq3QzO1ivpy+pxXz4SXSwKN31QRebxOmUjXAJwWszVDGAencCV4j/XjaXT9pP7tP3p3z8UKcM/Q7Ofdi+ZiqNJ8+jsWwD3NtlJNji3bdtPFd5VmDVOyVSKmfK1TKt8tpbCI+F6jTVHHoL9RZ/FBeXC567h9Mn2lC5iQpm5eWexWwdXA69zAiZ1qx89ZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeIa79FvF4gJMXua7dvpmga6o1XxFUU7AdFrqkq4mTg=;
 b=TdhvZwl9ydVHN/vV3m70CzrfzqI42Ln3grItzw+bJMY30XUH7rrJixVqT/AjxLZ5Urb7jxukVfSm6ANNE3wR7XxgiEz01/B7WkXlw4tDKdgxngBQIfooClJcdBBQC/G5RMjcvIGW1t9fuSVP/CjY59AEdlN88dEZpcG/mWw/xvGZaJpuOiFMpESvjeJzd8SwZquo7AdEYGisWVMnWKWqu87z73T0yCABCPBRvWZ1bCrrvNEoV7E3Ov5T2g3z4wE8tE8+1otd2eFjKrKecDtT3QpAgh4wRpNXeoV0TLIZ/vd6B4Xs1yRB7JgeSvbeYD54/nIJjnJbCX/0BnAr0zBWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeIa79FvF4gJMXua7dvpmga6o1XxFUU7AdFrqkq4mTg=;
 b=5k8+hc7BQjnghlqTqR6lYWZDmZAT96OQl+qilFyDKr9afRyOIBbPZFXrB9U5Xau98jW2BvThQwqpqG0sVGi9A02WmdKIMHHUfu54EHbN1ks2gN3zzJntawIhE7MzXC38ThyHjUmVhLZytAN8ln13RiGa4hRpoTkokAZEeHPOzb0=
Received: from SA0PR11CA0144.namprd11.prod.outlook.com (2603:10b6:806:131::29)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:26:03 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::ea) by SA0PR11CA0144.outlook.office365.com
 (2603:10b6:806:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:26:02 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:25:57 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 3/7] perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race
Date: Mon, 16 Feb 2026 04:25:26 +0000
Message-ID: <20260216042530.1546-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216042530.1546-1-ravi.bangoria@amd.com>
References: <20260216042530.1546-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: cd58641f-5496-42d2-da73-08de6d137e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lBT795D9FZUZqfxyhxHkUViuXa09iQ+ZyJTN9umRDmkt6COmHsW7ERg5DByo?=
 =?us-ascii?Q?CzfU8PTwT/lPSQJidBqFArFRuogTA71eKyyAcIvpPQDkiVTPq/atEy4hwF+v?=
 =?us-ascii?Q?4NdMi5qPGoXbLQyQ0k3qof5t6UWwf0oRStSEQ2hnWuauS5YCcMs6b27SW6ed?=
 =?us-ascii?Q?btoO7971MCnlCZmhnW4OFz/pubzbZH7xH4btN/unHBfZpF5Fgfs8VGru//qQ?=
 =?us-ascii?Q?tBpzYRj5lXVNHz0ORkwOepTau63DdDpSBZ+lLvE7MHt/XoW6+IItPqTKOwrc?=
 =?us-ascii?Q?2QrylcpaRT+O+C+M6HUoSfeRpJDHEdioKEHNyuCpEHEN7YvXjKBaOtSQ/aQ0?=
 =?us-ascii?Q?ef9JHZX6/KjDHW7IBA2tVyGURWJ1SDVr0Y75guu0Sbgd1O2L8bLkTwDPNy67?=
 =?us-ascii?Q?iOOzluj6QPYsyOuL6QxcRH0RRY3BpjE0nQStvj0OyuC0HQkeZumU3Q5pOSR/?=
 =?us-ascii?Q?Of/dJZ1k3I20xjn9RcqCkVNaTxHGoCjUtuKluhh5kYHb/Vzy5givjvyPJCr4?=
 =?us-ascii?Q?Qx0auy5FXD/2lrQNhiC7XP87OHYmOo+yP1n7bGfhKXjHy94xWJjFS20atfSe?=
 =?us-ascii?Q?7HMklVzW4fKdqWVuL4GxsshTauk3rYUMAbnsRUQKKtaSxEXki9+AQi9OCr8g?=
 =?us-ascii?Q?PH+4GjXeyRIZE9MbLDUw2Bitj9ufQmb75UFOqWgUkK8NyAhLayI+ETijej27?=
 =?us-ascii?Q?F45yU+VDMxJ0xsEZEZ4GMcRedaP4q99uP/w6L77qrLOmAn9exoWX87uckCwE?=
 =?us-ascii?Q?0zI/gXHAh3XcGU7iPesaDJhxCZxTINfmoRZnCI7v7aU22teWIlWy5g3marqJ?=
 =?us-ascii?Q?7NFD5i3xJJMH32RShAMZasVB2PFHIlFN/7Y3B7tbyOFaeEjxDkfZ12f+vomq?=
 =?us-ascii?Q?XJqrHpfZ4vOh9hAfIaCcKLz7x22F9pEqN6qgIaW5krGm5PQxRDI4ZZVgNXKp?=
 =?us-ascii?Q?NamuboIzKfflZOZHxFzEvfN5jq9hQhnna2PZVU8dxVT4wFwPqX9VwEujbM35?=
 =?us-ascii?Q?8ikYgtNrsUOckiXltPzjvhxKrCXTaVR0JE4WMjeyQC0Q7pUPpSPdTdaWHpJU?=
 =?us-ascii?Q?auY8M3aashyt57RDPA2Mr4annA/sPSYP7fhvORqKrG4ZfJRwXZ+izvBsncWO?=
 =?us-ascii?Q?2u0G8BPB36aWdpbl05/e0MpZGNS1Zxu+y6I6PyqBppXQyioPXmckUJQpluJi?=
 =?us-ascii?Q?hO2BUib0R2sdGiOPe1sQjsQ9cuK3l6CIr0vcM9I24tsJpsztptTqN5qDlghI?=
 =?us-ascii?Q?KNw+wrU5decUBCZU3hG7+VQWuyqTUmgbCD99XoFF9/9IUy5ptJabRcWnXJ+3?=
 =?us-ascii?Q?ooNzatbygLjULbV/qmETYMc/4MLCHeyA+7v77qHsPImehfbTdT4l3FMsQBHi?=
 =?us-ascii?Q?1BgoLIU2qCou9ek+pm4gJcGBKiJ2OgT7/pMM/nZ/taUli4yHFJ31PU5a4/j/?=
 =?us-ascii?Q?ITf0Dz3ynp3xQlaZsuHGIN+CuVmLP0RgFAjSiCx+mv0N6Cy/78AmF6IliIOd?=
 =?us-ascii?Q?ClLb1eii/5fNV6ASDTnuJ/XPivnQj5wIQEwPovWT2huz2B2VFrK7WrKudUaz?=
 =?us-ascii?Q?tp7XYY56XNvGXBYYP2IfaeVMjKwptVHMeFi2Y/e1MvuAAwzEE9MnqtrdTv7F?=
 =?us-ascii?Q?/oAfvO23S7ROMgdLSUdVYC1/lRr4nUqOwHc2LMzUMu2T1f/z0FDE9B5KOV0n?=
 =?us-ascii?Q?BdUy3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KPuNfrVEfO4Q8H2Yx53nu9GY5PsvlROoLWeh+X9hjaA4UsUZWH60s07ThLdsRRli5ZxUjR9sYQ6L+Dg/NHf/Dhn5SBtHVjswHDWxs9jpb0L3eTz5/rnits69OJtPG2pFxaC6i12lvCf26GFX6t/TbUalc/kaMlTJFqpu297HNwsRopa3A8tZvwBV9ssmJBf6hP528ULccSBo8F7hbcklb7HoSZ1y0vc0o9MxIKgvH8y1nqEl3rBqQbcwgLQ3KOfTId7hMZGekzbDVH60pdJf+GAS04z9Mji/ycSvJzRMpbeSzvKUedFG+iwC+fiQC528ASeTH/MX/Bzti8JZetzLiJuOcooE0ilqkNYzlYp1VoJS23G/Yv+TUnZ8OlxPM7SwZ2Fr+TfNrjzh5lsn14uYMl3bYbqfWlVPOIvReScn7ZjHXfX/1UCpR8w9/yW/yJFv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:26:02.2356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd58641f-5496-42d2-da73-08de6d137e39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123

The existing IBS_{FETCH|OP}_CTL MSRs combine control and status bits
which leads to RMW race between HW and SW:

  HW                               SW
  ------------------------         ------------------------------
                                   config = rdmsr(IBS_OP_CTL);
                                   config &= ~EN;
  Set IBS_OP_CTL[Val] to 1
  trigger NMI
                                   wrmsr(IBS_OP_CTL, config);
                                   // Val is accidentally cleared

Future hardware adds a control-only MSR, IBS_{FETCH|OP}_CTL2, which
provides a second-level "disable" bit (Dis). IBS is now:

  Enabled:  IBS_{FETCH|OP}_CTL[En] = 1 && IBS_{FETCH|OP}_CTL2[Dis] = 0
  Disabled: IBS_{FETCH|OP}_CTL[En] = 0 || IBS_{FETCH|OP}_CTL2[Dis] = 1

The separate "Dis" bit lets software disable IBS without touching any
status fields, eliminating the hardware/software race.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 2e8fb0615226..b7f0aad9356c 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -86,9 +86,11 @@ struct cpu_perf_ibs {
 struct perf_ibs {
 	struct pmu			pmu;
 	unsigned int			msr;
+	unsigned int			msr2;
 	u64				config_mask;
 	u64				cnt_mask;
 	u64				enable_mask;
+	u64				disable_mask;
 	u64				valid_mask;
 	u16				min_period;
 	u64				max_period;
@@ -292,6 +294,8 @@ static int perf_ibs_init(struct perf_event *event)
 		return -ENOENT;
 
 	config = event->attr.config;
+	hwc->extra_reg.config = 0;
+	hwc->extra_reg.reg = 0;
 
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
@@ -319,6 +323,11 @@ static int perf_ibs_init(struct perf_event *event)
 	if (perf_allow_kernel())
 		hwc->flags |= PERF_X86_EVENT_UNPRIVILEGED;
 
+	if (ibs_caps & IBS_CAPS_DIS) {
+		hwc->extra_reg.config &= ~perf_ibs->disable_mask;
+		hwc->extra_reg.reg = perf_ibs->msr2;
+	}
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -448,6 +457,9 @@ static inline void perf_ibs_enable_event(struct perf_ibs *perf_ibs,
 		wrmsrq(hwc->config_base, tmp & ~perf_ibs->enable_mask);
 
 	wrmsrq(hwc->config_base, tmp | perf_ibs->enable_mask);
+
+	if (hwc->extra_reg.reg)
+		wrmsrq(hwc->extra_reg.reg, hwc->extra_reg.config);
 }
 
 /*
@@ -460,6 +472,11 @@ static inline void perf_ibs_enable_event(struct perf_ibs *perf_ibs,
 static inline void perf_ibs_disable_event(struct perf_ibs *perf_ibs,
 					  struct hw_perf_event *hwc, u64 config)
 {
+	if (ibs_caps & IBS_CAPS_DIS) {
+		wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+		return;
+	}
+
 	config &= ~perf_ibs->cnt_mask;
 	if (boot_cpu_data.x86 == 0x10)
 		wrmsrq(hwc->config_base, config);
@@ -812,6 +829,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
+	.msr2			= MSR_AMD64_IBSFETCHCTL2,
 	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
@@ -837,6 +855,7 @@ static struct perf_ibs perf_ibs_op = {
 		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
+	.msr2			= MSR_AMD64_IBSOPCTL2,
 	.config_mask		= IBS_OP_MAX_CNT,
 	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
 				  IBS_OP_CUR_CNT_RAND,
@@ -1394,6 +1413,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 
 out:
 	if (!throttle) {
+		if (ibs_caps & IBS_CAPS_DIS)
+			wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 				new_config = period & IBS_OP_MAX_CNT_EXT_MASK;
@@ -1465,6 +1487,9 @@ static __init int perf_ibs_fetch_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
 
+	if (ibs_caps & IBS_CAPS_DIS)
+		perf_ibs_fetch.disable_mask = IBS_FETCH_2_DIS;
+
 	perf_ibs_fetch.pmu.attr_groups = fetch_attr_groups;
 	perf_ibs_fetch.pmu.attr_update = fetch_attr_update;
 
@@ -1486,6 +1511,9 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
 
+	if (ibs_caps & IBS_CAPS_DIS)
+		perf_ibs_op.disable_mask = IBS_OP_2_DIS;
+
 	perf_ibs_op.pmu.attr_groups = op_attr_groups;
 	perf_ibs_op.pmu.attr_update = op_attr_update;
 
@@ -1732,6 +1760,23 @@ static void clear_APIC_ibs(void)
 static int x86_pmu_amd_ibs_starting_cpu(unsigned int cpu)
 {
 	setup_APIC_ibs();
+
+	if (ibs_caps & IBS_CAPS_DIS) {
+		/*
+		 * IBS enable sequence:
+		 *   CTL[En] = 1;
+		 *   CTL2[Dis] = 0;
+		 *
+		 * IBS disable sequence:
+		 *   CTL2[Dis] = 1;
+		 *
+		 * Set CTL2[Dis] when CPU comes up. This is needed to make
+		 * enable sequence effective.
+		 */
+		wrmsrq(MSR_AMD64_IBSFETCHCTL2, IBS_FETCH_2_DIS);
+		wrmsrq(MSR_AMD64_IBSOPCTL2, IBS_OP_2_DIS);
+	}
+
 	return 0;
 }
 
-- 
2.43.0

