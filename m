Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B461674;
	Fri, 13 Sep 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242558; cv=fail; b=fFTjSu3CeHH4K83MeFt/lvs24W0krhYVIXXSrbbAYs6Cb++h9AVmaHki3XOJJTJAj7j3fBGlVLf0qYDfE6E/4L6HAN9VsMti+UGTl02HnABVcZw18VIv23yj6F6KvPKQHeDqHaQbMWrXuIBdydIPoNVwmue1pThzDX8TRBve6XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242558; c=relaxed/simple;
	bh=vzFD+NCiFPojtCpjusdkLaxCZMht0yLPsyitg2nxro4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoixevDep0vCP1x3p4NLIIvPTZrFAwYuSnX/zLxHQSmv32wStQdvP+P4saCzWOzWkemz77szYU2EtBnHAfoqw6aSRK++trPq5wQ2hDynmqfQ4S7fl9u4LPaWL+4iE0AyDfsyOvw/QxtsxhX3CbT/HM9uwcWikkuekPjyxceyDcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=StmwZloc; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="StmwZloc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thg2Ds1r/Xni/wxjPlRCkz/R+pDAupR4U7OeKooHqB2fOkYiMz3k8+bid119z3GnIaegv3uIZeRuwr/3Kp9ndxsh4oBYhx6l8J+wdHvGrzxBH9xE8H5plnqj610899F31+jT9lw4dVNGQgdML4FGqU9nGs/+KcWkWnh/HyA8CUNRnYkUf4dVIz+hurDJezEquxQy3PgEnRyUi7KAUA5RU9D9TC273lPYcPFnBZaQ5nUTVAXR6Je7UtStiqQcV6aHHv1VRGc9XE4PZJMJorHJGk9r2dFqq/Lw8EAaWm+QMug2kA2WsjTo8N2vEyYHPHuCFtW1OoqslonbUp5u0zMXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeWSqRh4A9ud19wxKWKvQlEHWXIjVJZtrhogqPYMDlc=;
 b=AH40Wg6Bpksc/2ii9XsuQK45Y3wPrJ0gPdJYDE/yF63ANiVCaS/QvNezMxJJRQPhRTwDydd7G7TobsexYKfhEB1nSbOLqLmR/+azntjqFFTcadkR/YIhaHetXD8BbW6d/7/9uHXxhY/hh55J3VHBNVh6Xg4hGiXZ1Au2RXdO8OsBaaCJzoO2jHdKMfASZEdp24mXjzrtImufAjblOfiiggZmHVAkaYtrMNOay20cS1aOHS6gy3apsSOrj6+YOAHlED6GpY6/SD2vN6ZJC+YcDdl2jAoz3GYLUcXjHXUbr8yAymb7pl3MGZgfOCnCY3E9m6vSfcPsRu+xKx3JTxQq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeWSqRh4A9ud19wxKWKvQlEHWXIjVJZtrhogqPYMDlc=;
 b=StmwZlocs6Sb/+UZMNIDX5ySZa1xohx5xpr5T34LgFWGPqizk7qHzUDFB7r3gay7AmJWFHavLnpQDqKZJotS9WZaiErwTh4wVAAlvY3OLSMUi6KOB7+Ft3mB6yOg/lOfCaubtxC8moFkFaflUzft43a1VLU9rizK7dwRX19YT5Y=
Received: from BYAPR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:74::15)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 15:49:13 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::54) by BYAPR05CA0038.outlook.office365.com
 (2603:10b6:a03:74::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Fri, 13 Sep 2024 15:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:49:12 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:49:05 -0500
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
Subject: [PATCH v5 6/9] perf/x86/rapl: Modify the generic variable names to *_pkg*
Date: Fri, 13 Sep 2024 15:47:58 +0000
Message-ID: <20240913154801.6446-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913154801.6446-1-Dhananjay.Ugwekar@amd.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
 <20240913154801.6446-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: ce07fb1c-2b2b-4a65-ec80-08dcd40b9d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LmcDgVUDyWzbFE82/gRsWyncJDDkTPdwbCQOPSx39JlxhdvoLo0an1ATxNdW?=
 =?us-ascii?Q?1rbtAryqiVFGNdNMBC25rLApzf4rxlSbdt/cdoGDyVyNmeim7h+jN7ZryAin?=
 =?us-ascii?Q?nZd5lM2dsARemfdyA6WHJBi3ui7e0pN2Hqh+YXFnzU2+xZu8hmQ1if5ZoMsK?=
 =?us-ascii?Q?9zvWiu+ziCeKDaseMLGnQRj7LJEFxP6FrttDd6lr14YPa3ukI0sFo355hz2Y?=
 =?us-ascii?Q?PpKKw0guD7YTdfTB+GwnWQbXIv9YYAJK06QPq5ATFs28ICIJ4f3aWb05LL6K?=
 =?us-ascii?Q?6TysfdjthzqreYoX1nzMsv3S7CEW3fTrRhjUFipnTwNM5goVK1ijuU6CiPIW?=
 =?us-ascii?Q?YpUvTDy7PqECFmcyKIhsZZhHUzfn1QvBaMtPfz2n5quV0+hOw+i1bp2ezHkX?=
 =?us-ascii?Q?FChiAaO2ZhynOuwgQ8lHZ3Uk4uc51TzkDJazE7RfQMyKAcQ6LGf4J6Xxp219?=
 =?us-ascii?Q?uqkmSxj2LFzA+aC7IJ/bzWDSAATjjkYlS1MvKhy8w8GDijjHAwMwVLVo/PaJ?=
 =?us-ascii?Q?t9vxo4yQLXBOGSvKuO3CUTQMj0Bnz9jRGWJQs2Zb6CWT47852lt89XfE4AYs?=
 =?us-ascii?Q?d8vmVFgJcXciH+/iOaBTaxGmg83Arvfb52VqHDzSCGRgA794hWt36HEnwu9y?=
 =?us-ascii?Q?t8DV5rrk1jPcaRDspRZYmhwejf3Os2qHna0jHv1Y2XgzYz93CS6bun0K7+26?=
 =?us-ascii?Q?tqEzVN2yY8vqgAVrW7tZjuxDasoEh/u5zpCYnYhfkzk+5cbK5L9+f1RK9MVq?=
 =?us-ascii?Q?QPFRWtSwQSLBaY9PFNDNp140hFrAMPCEA0xC0wglmFjIvf3XiuKl0GficoE0?=
 =?us-ascii?Q?3UC/kA1tfg5x4Sy4X8TtcM/FWZBpA/c5mJTGZsPe8hzFIipFXgqvTBlT81ni?=
 =?us-ascii?Q?YlP3rXG/WzZyIkOSp5QrCQCw5xOOztrbQtgj+YHax8JQr1QdE3GL7muHI3rv?=
 =?us-ascii?Q?uZbLJRHiZdZyTtyr6AYGPyQw/5pIuOWxttEdUTLeS98gls9jw9c69pDtRPZf?=
 =?us-ascii?Q?Gf+wyi0C5a77bofKsAA3ZmfKl5cwv0gM1X9uKdb6ctt8Q/vpGYmWghMxRBXf?=
 =?us-ascii?Q?Jcp2ANdIApRRTBFA+x4/NrRi1EaTx7ZmiyILCmHhUwyJ8hJ1TCB5zVz6X3iM?=
 =?us-ascii?Q?A8/pUx64WbAgowitBKwp6uDXIhtEOMCottkR+1+hzUwXKsUkJZyDYSCV7xLP?=
 =?us-ascii?Q?wIa7XXSO4FqViSH+VJdmuQ4PbzNiMdB23IwnZh4RTnRzglJuJ/a3RkaBuqEV?=
 =?us-ascii?Q?LsAuLHEH89aUfYwOrt7YJk3H0u+QNFunGGLEiCK237xDl5OH3bSxFBSGuSBs?=
 =?us-ascii?Q?Uj0otPXecUerA8Cl2gWS6nwDLZmsDKObQuhCO5AwZpiI9bAxzEs+zYVszqi1?=
 =?us-ascii?Q?+guR5OBQRtzRpbxNmeXkzL3dHzeq/105DxI5E6qK3DbTxiq+KyqxD4f60wS+?=
 =?us-ascii?Q?PM8y5u/m+24d5WLCWfQZEMHJSjFqFaKDRRDM373jq4brFoAj0VQZhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:49:12.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce07fb1c-2b2b-4a65-ec80-08dcd40b9d64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125

Prep for addition of power_per_core PMU to handle core scope energy
consumption for AMD CPUs.

Replace the generic names with *_pkg*, to differentiate between the
scopes of the two different PMUs and their variables.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 118 ++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 3bb1da8f96c3..023d208966bc 100644
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
@@ -126,16 +126,16 @@ enum rapl_unit_quirk {
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
@@ -149,7 +149,7 @@ static struct rapl_model *rapl_model;
  *	     considered as either pkg-scope or die-scope, and we are considering
  *	     them as die-scope.
  */
-#define rapl_pmu_is_pkg_scope()				\
+#define rapl_pkg_pmu_is_pkg_scope()				\
 	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
 	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 
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
@@ -681,71 +681,71 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
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
@@ -801,11 +801,11 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
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
@@ -813,20 +813,20 @@ static int __init rapl_pmu_init(void)
 
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
 
@@ -835,14 +835,14 @@ static int __init rapl_pmu_init(void)
 
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

