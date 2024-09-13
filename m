Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71A6BFC7;
	Fri, 13 Sep 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242535; cv=fail; b=JIwRMi04ZKc5qHW4njvrMiRXx8QKJXzP25E1HmhnZxiCmWYiOSiQ3/SPcZCEnYAWyFATJ9BmHLmOMYA8KhNbzYB88nmUg/0nbJTCYWJ0iisnD7q7oo5Z1rV6LHhSNCZU2d3f2gOR5ACLupTsMdfo6g/4eeKw78zHP/opgBlJ6/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242535; c=relaxed/simple;
	bh=spPjAY0in27umCBYMVcXthcTAoj8L+g2ax5c8jAJIBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvCQyZFk/faOaXkSe18oc9brGcNC+3U+9rD1KfC/PuMlkZ9qWcBVzWKHI1klaoyAuB1NLanJ3juGtOYLLe0PVTubTiIUCl5tNkLJq3VxNXY94koVR8NgKy9rEqCCbTAuFyNkj+gBg7Mlvs/K+NkrhnELS+e/R0LQvcA04KLuPII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cNo07nWH; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cNo07nWH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2KzkO0RMNqdqdhIdLGUPvxWqQgNaJLUKyLVP+APzMHYPT6t+7HwxLgr5psGgSNbUAYeqeuDqY9ZpiRcAs+UiGV7Ct2qWAgwcWx5SM1pZLehHfxUjSoD0vEYdg7XRhc1zDvQqxyhd7D5ybKcs3Bz/aUOW6GdTgA1ncXCN2ADD3c7iPjwORu1c/0fcfoD1X/vmS8co0x7sILfG/myBzQnuFqj5Lbrpum85azC+y0KzY/J9+iejX0w64HXqzJiCxheD7uRJlJR21XfhL9vcGpQeaJ7eRH3LPT0N5iK7T5+sXEJkKB4PSoPZgRt5aY1SR8pRrm5O5YTFlTnhU8wJAt6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzD7BrAaYjBf1GFLgCjdNU1VGOzVI+HpYQYkucmtKd4=;
 b=rTELv7JsKMVtkn6/7NA6kvP4TXlozIds3gnSlkadiAcIc8McoiW3yo6hNAMqVU4TWNOQLNBXh5sA/Ll2XB55ITFj1+c08Uf/3ubT/EGNGOOTfkyHVZJidRV8VGSpBLLZ1s+7cg8SLZLOkh6na94EnFfXpfv86R4Yj1Q3m+K0eZOgbffZp/24kfypxIcFjNrkcAitkBUZOR4/8wbvb2GXBJjUa7kD777znNtXKAgh2wm25OtMFJ3XcRLRVgzgkfJ4LZcAGU3+WXSALpyVSFvJcAkIxjjFeBUui5Fj5a41dYTqlosjYT1WMh9/HccDjhBoKWMt7kedN9PCUNmXa8d45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzD7BrAaYjBf1GFLgCjdNU1VGOzVI+HpYQYkucmtKd4=;
 b=cNo07nWHWmdT/JNWDYEgr4y3gpemGUv4SsAIW5Lp5bpHaBoZHDy0biULc1LfceEgAqzXwn/vHsUjrEq6SQ0+kNKvjOOeG5U839Ka/CRNWNKtUOiDSfDq3cnlNF7KFXZva6upVDfsNBEEqEMEtKTPLTJSZXKQyp2Ue4naPraGdx0=
Received: from BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43) by
 CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.17; Fri, 13 Sep 2024 15:48:37 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::3e) by BYAPR01CA0030.outlook.office365.com
 (2603:10b6:a02:80::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 15:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:48:36 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:48:28 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <rui.zhang@intel.com>,
	<oleksandr@natalenko.name>
CC: <eranian@google.com>, <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v5 4/9] perf/x86/rapl: Make rapl_model struct global
Date: Fri, 13 Sep 2024 15:47:56 +0000
Message-ID: <20240913154801.6446-1-Dhananjay.Ugwekar@amd.com>
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
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad473d1-82b6-4e49-5bd2-08dcd40b87e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZradLVh9Cg+/TCqwm8/RyV/BzbdJ6p1VeuLfau+Z4tZwzDSwUYeeVoKsZq2Y?=
 =?us-ascii?Q?vwGGrqmJuPGjxBsjIBBsEowqncESiVZgAKPY5/Ca4XyfiKJF+ciUTsUfAgNr?=
 =?us-ascii?Q?KFTrSts3IH8sZxod+lVdp/wpxMTThgNhuavIc47v8ut4iOOblkB9ni875zsy?=
 =?us-ascii?Q?sMpSURkZyO1HiMCmkQCn/3+wCw/jaoMCNcR6N8Fkx5eVJE+++1J+B08lP9o+?=
 =?us-ascii?Q?R338TmwXewPkypC69s2NkjHDgDacPYY0uSMCwVtBsWZfIFHdsZqSTZ8qbStZ?=
 =?us-ascii?Q?Lv/eXDB6amdDjmYI9ZttfN1z5dl0BqLeevZuilsW6+MRJzIEAdi0yOqnGgcb?=
 =?us-ascii?Q?xn+RGWauEkQMB1h8wqU0Czaq2ewDzSoeGVJLuvYyBylpZdMhH30HefF1fua6?=
 =?us-ascii?Q?BhcwSfaYBF+0LK98DIa0wJUrqma0sa+uF+4HmEcapowcfsBhT5Ucfbt1E+qX?=
 =?us-ascii?Q?NHoFrh7L4HOVw/rQpdsgLlLqit4M29AiQyeD3Puh0KuccWVAabKiOml8Bd2a?=
 =?us-ascii?Q?pXTxSLmv4CBXmECosijQg3JkDpH854ZS8vxSqiYQ7yTxKRHtpNI3N65papct?=
 =?us-ascii?Q?SYHVX/sBuLAO+Km79i7G3rQVWfz7XqMJ5y0RB+ZNroUcikkWAJ+Itd9fl4IY?=
 =?us-ascii?Q?p8SET9gUoT7O3lUI2OQwzvoWVm0LAJZkPmn1aGUlfkKFSRV0BQQZJwvy+dru?=
 =?us-ascii?Q?FGOLpwwM0hjR4WHY0NIuXeSxVop/1VmGyDMLkYrV9H3fDy2XktQa4RW4d6OG?=
 =?us-ascii?Q?lXX7Y9wodc0gTLERw57XsitvPovJKaYLxmLNF6+AlmLud9elKz7vFYqxU5dN?=
 =?us-ascii?Q?mSCvjlt/4562C61ab2fdiGypB0mcGbf7zfID2v9eljvtss27h3LzmPWbDvO5?=
 =?us-ascii?Q?CjWEhjJV6r3CZ8FPwE7Mdv6P6Rh+t+qBLnmGZrJaGCzZopZS/HLCU5xKF4VI?=
 =?us-ascii?Q?YUcVSO7YawRFGVx/zauCkQHwi5ptH/6p0gqoud/uSCUaOuGNQlsVHrOdhdf1?=
 =?us-ascii?Q?UdLhfC8semZZNnpeytjlr90vntqxS9v6QPAlzPmBRqfaoYzcJDNaBzUr3UNs?=
 =?us-ascii?Q?rl6zl2HuQxPvoPCYMWm1HUul0kd3hMej6iyYYClAxII4Q56vZNpBy/cekLN8?=
 =?us-ascii?Q?OSRImVUkcY2jOluBWx8voIYHlP1iQg2U4D7RkF1+as4omCnrO9RrcoErdMfQ?=
 =?us-ascii?Q?pktgTG3oiZxoK1PO0y46tRsOabfzC+IRcw9FBa11yS64y4er6vgp6SjkYUQl?=
 =?us-ascii?Q?8ru4236JObB2VxhosuA+Pz/jmxV+NOfClupoOSVeFbakYh6H3++mDKlaBnxc?=
 =?us-ascii?Q?fjEHbW0qS8r/p3fHaclgK9zfB7OxkwIXZU7g0Nn25NN7nDi4jWQirgCTUjO7?=
 =?us-ascii?Q?kdXrxSbE1IkjVxtvvgmm1Cf5HNrtz1Si2paO//7om4UxGuHXjwYiT9qxKVcs?=
 =?us-ascii?Q?vYT03u7xpilbKUt7ih2AtmIHi51hP8+Y0auQBcSlkyDFYRu8bMS2ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:48:36.7783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad473d1-82b6-4e49-5bd2-08dcd40b87e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053

Preparation for per-core energy counter support addition for AMD CPUs.

As there will always be just one rapl_model variable on a system, make it
global, to make it easier to access it from any function.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a2f8c77fe629..46a6aeb61541 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -138,6 +138,7 @@ static struct rapl_pmus *rapl_pmus;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
+static struct rapl_model *rapl_model;
 
 /*
  * RAPL Package energy counter scope:
@@ -536,18 +537,18 @@ static struct perf_msr amd_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
-static int rapl_check_hw_unit(struct rapl_model *rm)
+static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
 	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
+	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
-	switch (rm->unit_quirk) {
+	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
@@ -798,21 +799,20 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct rapl_model *rm;
 	int ret;
 
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
 
-	rm = (struct rapl_model *) id->driver_data;
+	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rm->rapl_msrs;
+	rapl_msrs = rapl_model->rapl_msrs;
 
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rm->events);
+					false, (void *) &rapl_model->events);
 
-	ret = rapl_check_hw_unit(rm);
+	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 
-- 
2.34.1

