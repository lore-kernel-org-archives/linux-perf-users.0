Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8350185B77;
	Fri, 15 Nov 2024 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651051; cv=fail; b=kFEdNJJSIp+I6jK4Sew6GIGB8wsfDpuZaXHTFuSE0LslHAM9Dypj2DnK5Yl5+RSTPj5qOOeDgrK+SlyJQmXA6Vw0OOtOQcF0iIa0+RvzsXr35mE2Og+gvclAD/rL75iQ0/rGYAcbgoi2buPW4QF09+A4fDk8z81+LwkYTKoxB6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651051; c=relaxed/simple;
	bh=8vqdUmy0a1gRpVlUimzuv/+Dm6jUctK+SMZBW+jDpYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqYCcHgsHoLGcQF+s8aUGYIcbYRW1/2VIQOwnumtu5zaho0TwLROuyRs3Be0FEbtRRchNDW2tqLwia6jmTA67pak5NlSj7/EgOBzV0NlPUtM3a9c4WdM5T0BFFE1LO8c/D7sqhuIg5HhXgWA5X7stIhFWCL7lbfBf6PQ+FKpWRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VI55T76m; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VI55T76m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP2YySJetvZ9g2sPo0+a+iyuNol93Sj1TdapzZWnUXAtjW0AU0UdHQKSBYRKsYYeL3eeIS2IBG3Q9WdhGElcRse2AXjFXXr+krQ+kIEqUQ61l5DKG0QfgGeqBlanIpm23WeqA1YZ3G+8rawOQSUvwl3BF3UG2tDXdp2wyNDTeM4+KpnpgjCNScYe7Z+GLFsqg7EE5HTa4riSmY7eOM9JgMbsSI6Mc1l/NmCPcwJpaSWO4emnKdLwU1suRFVQ7FFzq1PcVO8cu2XA/3LUvJDuIrWo919G8kqnYkvLUbOILUvs0DsEsWP/QWbwnu0XMjnKTNmJaFFLtNx9u2WcS3It/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjASfd2KVx9c9I1JiWBJYadBM0W2dJPk5tZv8x4emNQ=;
 b=TX+n9TPic33Cz3V6hBQSQz62VkHZzlDFrBoPjaUGOqMKTNKin7u4Whk+t2aG1eud2Sz9RDTTvbt5bxuXV1Xjimp3Y1lYGv5JbuEJXWVWVz74YrfysN9OVNkDn3RNBafFhED6P5YEwRXOPlxQPwt0TemOiyZ2OHQaqUajpDmqPcvECy2M+fY6yjhtCjY0AqSlhMEpLYz7rT4ipOsn80XuHy+9EMB2d1ln3Hddh4QwT6VaHPxliTE1mAuxEmrph/gUVyOmpoiXp6E8BHLf/mSahfjIOJHOuKZPkYo8hzj3cW2rewFBXx4Eu305gkeQcNTj7Nn/TewOpa0jIQuTgx6a0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjASfd2KVx9c9I1JiWBJYadBM0W2dJPk5tZv8x4emNQ=;
 b=VI55T76m5CvIeL24QxGaVvInu2zC+RHs7q+cCIpmEhIsPZ/OKLxSPWtkv4ybGfOqeBFABgmg2QHV3x4ydPQRsEkcUSOzwUUnCZzS97ejvBwjzLqiicF99OwI2erlMAKWB/UtNosuVXPAQzLmmVaPW7tFzyF+SF5+OTYW846QARU=
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 06:10:44 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::e3) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Fri, 15 Nov 2024 06:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:10:44 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:10:37 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 07/10] perf/x86/rapl: Modify the generic variable names to *_pkg*
Date: Fri, 15 Nov 2024 06:08:03 +0000
Message-ID: <20241115060805.447565-8-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae948af-d4c2-490e-2354-08dd053c3d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eCGgpOr8IsHqVP3YqQvhdprgxfKXESwLys7YrU1mFR0/eN2PumlyGoKTsV3x?=
 =?us-ascii?Q?ifiT6Wf4knSfjRPlcvQKBBK+E2ZKHaLzRsjSve6d9aK+b4Hn9aSVbvNOZZp3?=
 =?us-ascii?Q?So736d6ltlr3Z2egldpL36cvyW4TPrAsEvEbYbTysE/tRqD1m55JLMwFpZ80?=
 =?us-ascii?Q?kBCWRqQGvSl0skOKVgRGW+tHyAijYhZKR4G/itUgoH9mZrJA6vOENlOTSDRl?=
 =?us-ascii?Q?ley4BQ6AcQFbu0U3Va2KhLRLpGU0cnCCcMMCmgnHgeJAE4f9/scQSxKUqR0T?=
 =?us-ascii?Q?JF4UxhvIO6f9tBN8X5WECblejNeZYWCPZ3QUAW2A2RQaINC59+0h3g9Vda9w?=
 =?us-ascii?Q?4JnWINzW8OPN8LtvISo4v5gJgJChqsMCbdXqy9s3b5j372vP0E0+PBEfUNCZ?=
 =?us-ascii?Q?y9wchKduzsI8OvO8rAp+hr01nOl/mO6dtb91SpIYurhxQ3lsbK8jeZIKVMmb?=
 =?us-ascii?Q?u9xfP/5oXG9S05i9aod0Jmk/CShr4pRJQlm+A/eE12gULjJvwzVnhK2/spVs?=
 =?us-ascii?Q?K+ASziZEVabCvDUV+cdvdgr5mD60dtWgd/DJryql2VWvd29L/Ct2f6+MpXab?=
 =?us-ascii?Q?vMY/8zS0phZrH7tZDvSjz/INlmzrMKOLJGkz9suHQnAFquQhgRNA7t7n0F5T?=
 =?us-ascii?Q?ToQbVPpEBSHqE5hQ48OHOdtmZKFNXl2f9uhcE8MiazdjfZ3FTCzh/9H1Xhm3?=
 =?us-ascii?Q?roBQuwUvOY1lnBhpzW5AMHXiVF45XzltmWw7YeeCjbTkJHVW5tQP+xt0UqzT?=
 =?us-ascii?Q?VJuonSt4ERz11E6Qf8ebwml4TBeXP7tR6pvFYiN7TCvTaDxPX8qxtVC6ZJYv?=
 =?us-ascii?Q?SywzENghS8W8qj4oVk8MTKsVJ8ETlVNcADbvLxL439QIxYo2N5Idh08ibtvz?=
 =?us-ascii?Q?y4p8i5xBZqEidkSz1qidF7Cawk+/cI2NKVJ57j9wsOfLrBA0NuSiVuTqvOJ6?=
 =?us-ascii?Q?fTDiQqk+ecI4Bq8+s/MfBdHthDGUagD343In84fvDYW3+pJ6dZTm08IgQSLA?=
 =?us-ascii?Q?/Da0SHHimSv+vC7lFh6jw7eYcdxDpMWcYzqD0UBh/S9DCjtf53y7bvvPjAa1?=
 =?us-ascii?Q?1BdS5UeA8WKw29R5zIVchlFgnGJK9pf6WDb+WGlIdpHPq4ayXyxiP5U+3uT6?=
 =?us-ascii?Q?0e/iiKuV9LbrudbjCBd+figIGbpsUTcngerF96/qbJ0IaASGQjmmfLzbZ44B?=
 =?us-ascii?Q?p66P+ZhNwz16ucAB6588YXnQJswvb6romskigAS2ZGKh2dWyfK62aGk3GENa?=
 =?us-ascii?Q?LKDfGOkPT8Je8sCMxVDA6nparxRzKNL9CnHzi1xfeeH6l5KFN8RBfp20jTTX?=
 =?us-ascii?Q?cHi/+MrzkUCpKej/wN7UXh9aSUzKMOL6slyln5Nv0AxNRiuP9mgPHQr0BheG?=
 =?us-ascii?Q?3q5+JylVbYdxCQirDO0FL4MQ65FF2upsebUJXCVv8CHZacGDxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:10:44.1771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae948af-d4c2-490e-2354-08dd053c3d89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247

Prepare for the addition of RAPL core energy counter support.

Replace the generic names with *_pkg*, to later on differentiate between
the scopes of the two different PMUs and their variables.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 120 ++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f353008b860b..2398a8452709 100644
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
@@ -163,8 +163,8 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
 	 * (for non-existent mappings in topology map) to UINT_MAX, so
 	 * the error check in the caller is simplified.
 	 */
-	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
-					 topology_logical_die_id(cpu);
+	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
+					     topology_logical_die_id(cpu);
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -176,7 +176,7 @@ static inline u64 rapl_read_counter(struct perf_event *event)
 
 static inline u64 rapl_scale(u64 v, int cfg)
 {
-	if (cfg > NR_RAPL_DOMAINS) {
+	if (cfg > NR_RAPL_PKG_DOMAINS) {
 		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
 		return v;
 	}
@@ -186,7 +186,7 @@ static inline u64 rapl_scale(u64 v, int cfg)
 	 * or use ldexp(count, -32).
 	 * Watts = Joules/Time delta
 	 */
-	return v << (32 - rapl_hw_unit[cfg - 1]);
+	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
 }
 
 static u64 rapl_event_update(struct perf_event *event)
@@ -347,7 +347,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	unsigned int rapl_pmu_idx;
 
 	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus->pmu.type)
+	if (event->attr.type != rapl_pmus_pkg->pmu.type)
 		return -ENOENT;
 
 	/* check only supported bits are set */
@@ -357,14 +357,14 @@ static int rapl_pmu_event_init(struct perf_event *event)
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
@@ -372,11 +372,11 @@ static int rapl_pmu_event_init(struct perf_event *event)
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
 
@@ -530,11 +530,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
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
@@ -550,8 +550,8 @@ static int rapl_check_hw_unit(void)
 	/* protect rdmsrl() to handle virtualization */
 	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
-	for (i = 0; i < NR_RAPL_DOMAINS; i++)
-		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
+	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
+		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
 	switch (rapl_model->unit_quirk) {
 	/*
@@ -561,11 +561,11 @@ static int rapl_check_hw_unit(void)
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
@@ -580,9 +580,9 @@ static int rapl_check_hw_unit(void)
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
@@ -592,12 +592,12 @@ static void __init rapl_advertise(void)
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
@@ -678,71 +678,71 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
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
@@ -798,11 +798,11 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
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
@@ -810,20 +810,20 @@ static int __init rapl_pmu_init(void)
 
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
 
@@ -832,14 +832,14 @@ static int __init rapl_pmu_init(void)
 
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

