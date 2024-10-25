Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E211DD0C7;
	Fri, 25 Oct 2024 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854999; cv=fail; b=NSbpCVQve84/z0NZYMbyC+v5Byvhp1TKYyzAC8Dcr9QovtAXlLVstUh0gPK8XEqWnmINn3TwRRNFZI7ej4zgyDI9cp+Z31kpQLeKS4NTOVON238uG3FAAQOk1S2jOXUdUovJ+4OjHjx2R6s3+0Hcf+lnmOjSknv9DQE0vmSt5hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854999; c=relaxed/simple;
	bh=T2viPnxqASF8vykU5oV+Hpp05frYibTTLHVAUNNgqko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BirnbAYGfPxgAUwMfQOsr315lmpPUmwgH+b/W629hfiwB8rsStXZ7XcxbadvdewR27zvBPpdlMxSenmqGnLsdn9yAYRYd0Wwtkb4bx3x92AmgAbnuYaVl9fipbuShlEyEmR0hAGvfHPl+X/X/5rj8Lb0ZWFUW6HBEWQJq+B8f98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cBsHVRgf; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cBsHVRgf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPN21XJ/4S8vG6iYtOjyZi3ZRDwdh3yRVf9sGlgTFG+HmactWrqVqq1K3jpaKLXknK0y7236IgwYOqx77V5LfX0rD+B/ryfHCeizRc6UsIQrxqG2j0qrmh4BqSjTf3q7wycvNnmpX56Q2Zam/CN6n9j2Tw+pZJyfFB+4WtsBWBaFCpaP55R4u2eY0XmTeIBZT5K0okqOC1QKJupgxmB0oRXViB11lNTRU6A7we16HKJsSjuwj/lbEp7oeBU5Qq1lD+rYtyrAlkqHdmeQfFwxTXlS/fuRZtL4VkW7ckDaSMLmGVoBeyal4VX9TI7SLC1748eBGmQypHWM8O/KdP8lcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDLJqcMG3yI9IY8EQamJgu2ZeMWGvlzwRzs3mHRvM/Q=;
 b=WR0Bfe2dWFsMFDpmmlh6Q2aX7+1mDLBEZlwB/g67J/1zzED1wx/yFsI3JS2wE069tb9E7Yk3Jjv20JYF5k0HTtdjBtwo0DBOdTnsE6aidh3nkn6wXoZ0hMMHg//6Fb/j10ZGGAmkO2AMLrZ+FgzA8TSf3+zoYUGWvCiMFdinzB3qZ4jhLzzNaNnlBm2uJKW+NgNvsmZ/TyqPbNPtCn6AGu/U7XNSKmaJgmjpAlI2hOmzE/4Hj8Op/xAJX7LOFoG+bMbV/4zQna3sppzkEUigAi5XwHCslZC1WqPJY7lrH/iaN/clhxnJ6vOAlkn0KDSdIvqUrvkX5buCSsBKhdOx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDLJqcMG3yI9IY8EQamJgu2ZeMWGvlzwRzs3mHRvM/Q=;
 b=cBsHVRgfH6b164no6kLsY4uZvnDFRiax55zvn7Do4Wf2pL3hKsu3aACS0i6+jzJOMBRbjEFT7bB7i1hZMYosoetbQvz3Me3ZsW+Z9e94tLGdCG35qVgw9DB6ogGKksiAMsSuQ7z45JmmnRQmxNnQWrY/ZqxxTaqjBalq6UmZ3Mo=
Received: from BN9PR03CA0692.namprd03.prod.outlook.com (2603:10b6:408:ef::7)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 11:16:31 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::ec) by BN9PR03CA0692.outlook.office365.com
 (2603:10b6:408:ef::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 11:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:16:31 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:16:25 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v6 07/10] perf/x86/rapl: Modify the generic variable names to *_pkg*
Date: Fri, 25 Oct 2024 11:13:45 +0000
Message-ID: <20241025111348.3810-8-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: b4cfbe03-d271-4488-39b8-08dcf4e67a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P/rh03CDkPwq/tUBZQfEt4cSYZznt2r8UkAzpZvR9NEoGjdiFgwyDd4+cDHC?=
 =?us-ascii?Q?sDYzsxxWm/HlGz4JNhSVvMQXVCc6bwZAxlxKWPaLRLi1TD/5qyX4qR1PhjiS?=
 =?us-ascii?Q?/OXr+hoR2D0pevlnjtTUPgfxnJL5qHIbicWaxkZ/8eCYTcX8EwwZO6Pnx4PQ?=
 =?us-ascii?Q?emuc3rf9Z8eaST+1c5zbI6FFisFnDgPu1zZQx7CmxYDLHV2ff0V5fKhThBnS?=
 =?us-ascii?Q?WXH88KL+K3ba9ay2Dd/0V66KQGcx0k3MEmyO479Cn+z1IIr41gM9sW7Jq9/o?=
 =?us-ascii?Q?08MEZPC0eCLR37KKB2zTE0LQc77kgASZt3y5AjyygmE5XeQIJd2l8nIKhcTq?=
 =?us-ascii?Q?Yb2gaI+nwQICFZQWqh/Ua4kb0eGPqoPkNsX607lWh1jUzvHOq8f/5G/NopTO?=
 =?us-ascii?Q?UD+DcHrjuuxJ3H8ygHngpd5LV+jyjIDZAAA9yrh/NL+8OiRUrPL7Yn2rc37Q?=
 =?us-ascii?Q?pJ6XNMKzco8WZEux6IX28H74LzI/q9grUgqPCJyzBiBDY7EgWSXUPHt8DVMc?=
 =?us-ascii?Q?2/C+ylLXTcuZaYwK6EREi4FTiIRkp+vtHgWjbTlQJqSkuAniOGuv3/LyBiTS?=
 =?us-ascii?Q?ZnIiGYFdCIYkDR3fRPpar3h9HziiG9wJJc/wV1nI1yd+FMEWGYiWfRrYltHs?=
 =?us-ascii?Q?SWKt9bmePqpseNEdmczuL26XkOoZQinPIxytZbsSYqTBLTv2JIzIXBcIe/8V?=
 =?us-ascii?Q?JucJa2Ew9SBKvgtuYjTg/cvcSJY1sCIqjMlcYX/eRqzE6118KIqZ/Xu9iIZ/?=
 =?us-ascii?Q?QtLRJGp9YVYSt7/F6J3I+s3bn28wHiPWJzOCONKrKoIm1va1gM3Wi2gX4su3?=
 =?us-ascii?Q?UL5ZVudeNL+A/Jq2XYQPw54NAK+fgfr9BpDT3H89ACdU1DZorxjDjwJo0Vfv?=
 =?us-ascii?Q?xQRLs6WiY9tWGHze5U6hrCfQICBeOcvbDERCtNd2L70Um/pm8Sp+MzdYIFgi?=
 =?us-ascii?Q?zYIlYN9MAjqwdam8J9DIsr6Q0+ejghr4Ku7E72K4jXzClQfaexBgRhUbFvMI?=
 =?us-ascii?Q?TOOULjHl3h2vHscmHo07PPLUhWNVo3z8PF8NMS+utosfWU+4zPj7fEfRc5mF?=
 =?us-ascii?Q?5oUqS0pGtcGTAUhaVYO+pk2o7GN15d9rj50TUO0hRP0JrfYtVH75uORHKdBg?=
 =?us-ascii?Q?cxqwMG6tsmPRc/+XCpiDDcVP4vpOakKvIWpV9gcTCrRgPgQgnExeiypMr9vI?=
 =?us-ascii?Q?o6m48S+okm5La9ObLN1T8qnsuUIm6JMKvn1RkRK9X8andSkY/pNLv9t03N4J?=
 =?us-ascii?Q?LPkl2yXRkQrxbCRA03RIwpIYZ8Z/SDLC3SVqm+qXr4meYJ9i9CMrm+2qYAEv?=
 =?us-ascii?Q?vxg5UdfzvZe8o19yYyhZri1ikW9MICZZRlkaSb34P80gL6z8Ml6nrwycsNXM?=
 =?us-ascii?Q?xivWSyaCI4GGauUHu/qoJyMGbExTzEyQz7yEDL7z0qs9xyEayJeu8g3Mm1C2?=
 =?us-ascii?Q?jVJZz6bkzuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:16:31.3104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cfbe03-d271-4488-39b8-08dcf4e67a72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914

Prepare for the addition of RAPL core energy counter support.

Replace the generic names with *_pkg*, to later on differentiate between 
the scopes of the two different PMUs and their variables.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 118 ++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index bf6fee114294..ae8b450caa9b 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -70,18 +70,18 @@ MODULE_LICENSE("GPL");
 /*
  * RAPL energy status counters
  */
-enum perf_rapl_events {
+enum perf_rapl_pkg_events {
 	PERF_RAPL_PP0 = 0,		/* all cores */
 	PERF_RAPL_PKG,			/* entire package */
 	PERF_RAPL_RAM,			/* DRAM */
 	PERF_RAPL_PP1,			/* gpu */
 	PERF_RAPL_PSYS,			/* psys */
 
-	PERF_RAPL_MAX,
-	NR_RAPL_DOMAINS = PERF_RAPL_MAX,
+	PERF_RAPL_PKG_EVENTS_MAX,
+	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
 };
 
-static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
+static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
 	"pp0-core",
 	"package",
 	"dram",
@@ -112,7 +112,7 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
  *	     considered as either pkg-scope or die-scope, and we are considering
  *	     them as die-scope.
  */
-#define rapl_pmu_is_pkg_scope()				\
+#define rapl_pkg_pmu_is_pkg_scope()				\
 	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
 	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 
@@ -139,16 +139,16 @@ enum rapl_unit_quirk {
 };
 
 struct rapl_model {
-	struct perf_msr *rapl_msrs;
-	unsigned long	events;
+	struct perf_msr *rapl_pkg_msrs;
+	unsigned long	pkg_events;
 	unsigned int	msr_power_unit;
 	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
-static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
-static struct rapl_pmus *rapl_pmus;
-static unsigned int rapl_cntr_mask;
+static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
+static struct rapl_pmus *rapl_pmus_pkg;
+static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 static struct rapl_model *rapl_model;
@@ -159,7 +159,7 @@ static struct rapl_model *rapl_model;
  */
 static inline unsigned int get_rapl_pmu_idx(int cpu)
 {
-	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
+	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
 					 topology_logical_die_id(cpu);
 }
 
@@ -172,7 +172,7 @@ static inline u64 rapl_read_counter(struct perf_event *event)
 
 static inline u64 rapl_scale(u64 v, int cfg)
 {
-	if (cfg > NR_RAPL_DOMAINS) {
+	if (cfg > NR_RAPL_PKG_DOMAINS) {
 		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
 		return v;
 	}
@@ -182,7 +182,7 @@ static inline u64 rapl_scale(u64 v, int cfg)
 	 * or use ldexp(count, -32).
 	 * Watts = Joules/Time delta
 	 */
-	return v << (32 - rapl_hw_unit[cfg - 1]);
+	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
 }
 
 static u64 rapl_event_update(struct perf_event *event)
@@ -342,7 +342,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	struct rapl_pmu *rapl_pmu;
 
 	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus->pmu.type)
+	if (event->attr.type != rapl_pmus_pkg->pmu.type)
 		return -ENOENT;
 
 	/* check only supported bits are set */
@@ -352,14 +352,14 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
+	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
 		return -EINVAL;
 
-	cfg = array_index_nospec((long)cfg, NR_RAPL_DOMAINS + 1);
+	cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
 	bit = cfg - 1;
 
 	/* check event supported */
-	if (!(rapl_cntr_mask & (1 << bit)))
+	if (!(rapl_pkg_cntr_mask & (1 << bit)))
 		return -EINVAL;
 
 	/* unsupported modes and filters */
@@ -367,11 +367,11 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
-	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
+	if (rapl_pmu_idx >= rapl_pmus_pkg->nr_rapl_pmu)
 		return -EINVAL;
 
 	/* must be done before validate_group */
-	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
+	rapl_pmu = rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx];
 	if (!rapl_pmu)
 		return -EINVAL;
 
@@ -525,11 +525,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
 };
 
 /*
- * Force to PERF_RAPL_MAX size due to:
- * - perf_msr_probe(PERF_RAPL_MAX)
+ * Force to PERF_RAPL_PKG_EVENTS_MAX size due to:
+ * - perf_msr_probe(PERF_RAPL_PKG_EVENTS_MAX)
  * - want to use same event codes across both architectures
  */
-static struct perf_msr amd_rapl_msrs[] = {
+static struct perf_msr amd_rapl_pkg_msrs[] = {
 	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL, false, 0 },
 	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
 	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
@@ -545,8 +545,8 @@ static int rapl_check_hw_unit(void)
 	/* protect rdmsrl() to handle virtualization */
 	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
-	for (i = 0; i < NR_RAPL_DOMAINS; i++)
-		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
+	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
+		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
 	switch (rapl_model->unit_quirk) {
 	/*
@@ -556,11 +556,11 @@ static int rapl_check_hw_unit(void)
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
 	case RAPL_UNIT_QUIRK_INTEL_HSW:
-		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		rapl_pkg_hw_unit[PERF_RAPL_RAM] = 16;
 		break;
 	/* SPR uses a fixed energy unit for Psys domain. */
 	case RAPL_UNIT_QUIRK_INTEL_SPR:
-		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
+		rapl_pkg_hw_unit[PERF_RAPL_PSYS] = 0;
 		break;
 	default:
 		break;
@@ -575,9 +575,9 @@ static int rapl_check_hw_unit(void)
 	 * if hw unit is 32, then we use 2 ms 1/200/2
 	 */
 	rapl_timer_ms = 2;
-	if (rapl_hw_unit[0] < 32) {
+	if (rapl_pkg_hw_unit[0] < 32) {
 		rapl_timer_ms = (1000 / (2 * 100));
-		rapl_timer_ms *= (1ULL << (32 - rapl_hw_unit[0] - 1));
+		rapl_timer_ms *= (1ULL << (32 - rapl_pkg_hw_unit[0] - 1));
 	}
 	return 0;
 }
@@ -587,12 +587,12 @@ static void __init rapl_advertise(void)
 	int i;
 
 	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_cntr_mask), rapl_timer_ms);
+		hweight32(rapl_pkg_cntr_mask), rapl_timer_ms);
 
-	for (i = 0; i < NR_RAPL_DOMAINS; i++) {
-		if (rapl_cntr_mask & (1 << i)) {
+	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
+		if (rapl_pkg_cntr_mask & (1 << i)) {
 			pr_info("hw unit of domain %s 2^-%d Joules\n",
-				rapl_domain_names[i], rapl_hw_unit[i]);
+				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
 	}
 }
@@ -673,71 +673,71 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
 }
 
 static struct rapl_model model_snb = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_snbep = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsw = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsx = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_knl = {
-	.events		= BIT(PERF_RAPL_PKG) |
+	.pkg_events	= BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs	= intel_rapl_msrs,
 };
 
 static struct rapl_model model_skl = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1) |
 			  BIT(PERF_RAPL_PSYS),
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_msrs,
+	.rapl_pkg_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_spr = {
-	.events		= BIT(PERF_RAPL_PP0) |
+	.pkg_events	= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PSYS),
 	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
-	.rapl_msrs      = intel_rapl_spr_msrs,
+	.rapl_pkg_msrs	= intel_rapl_spr_msrs,
 };
 
 static struct rapl_model model_amd_hygon = {
-	.events		= BIT(PERF_RAPL_PKG),
+	.pkg_events	= BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
-	.rapl_msrs      = amd_rapl_msrs,
+	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -793,11 +793,11 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	int rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
+	int rapl_pkg_pmu_scope = PERF_PMU_SCOPE_DIE;
 	int ret;
 
-	if (rapl_pmu_is_pkg_scope())
-		rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
+	if (rapl_pkg_pmu_is_pkg_scope())
+		rapl_pkg_pmu_scope = PERF_PMU_SCOPE_PKG;
 
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
@@ -805,20 +805,20 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rapl_model->rapl_msrs;
+	rapl_msrs = rapl_model->rapl_pkg_msrs;
 
-	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rapl_model->events);
+	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
+					false, (void *) &rapl_model->pkg_events);
 
 	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus(&rapl_pmus, rapl_pmu_scope);
+	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
 	if (ret)
 		return ret;
 
-	ret = perf_pmu_register(&rapl_pmus->pmu, "power", -1);
+	ret = perf_pmu_register(&rapl_pmus_pkg->pmu, "power", -1);
 	if (ret)
 		goto out;
 
@@ -827,14 +827,14 @@ static int __init rapl_pmu_init(void)
 
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus(rapl_pmus);
+	cleanup_rapl_pmus(rapl_pmus_pkg);
 	return ret;
 }
 module_init(rapl_pmu_init);
 
 static void __exit intel_rapl_exit(void)
 {
-	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus(rapl_pmus);
+	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
+	cleanup_rapl_pmus(rapl_pmus_pkg);
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1

