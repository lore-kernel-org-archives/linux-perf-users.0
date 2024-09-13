Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7547580A;
	Fri, 13 Sep 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242541; cv=fail; b=SNikSEvzui8W8O+5Yvy+0BbYXomF5uGr/pSWjkG/FDX6mLTap7EfpK68+W9May3pLUR4p2uNUAhzaHhzdvwRVgWreBjYAlcNahhBbQ8WC8X6lUovqErGHjLfdFK37ym7f09EVkztLvZAlpgLEueJR+Xd7KF4L+c/BP6M3hdvIUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242541; c=relaxed/simple;
	bh=5daKmciOE/ppRoRota/0OUpBPPQwKyH3iQ30kP8rHDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcF3ialAI3sY8ZRHrlhc6VuetQMizU8pohx8bXtB5qqxbJ0ByAutDGlhbuOsNvXietBFm1oo2D+/5WBkDVDZ9n/vf8SCroQPpIHH0XTP9tXNFyKuFgcVaiab6CRRPWH+sCWjvCCdWbc77GMjZtfVeNO1kDV+jLZnhFJsKZXrEzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZztFDaAK; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZztFDaAK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSEvu9ZJ//T0URmRIIIr+ifh+EurURwPOdy8TGls5q4QSzIg74LMfGuaowom0ry5M3DW5izf3CcdqhHeK74jBpKnivvEJVzTxGOxqHsx6uKcJhr7vJA8uXNUh40TC7cM3PGV+tIkVXnWOnNl299lQv6SeEtHXnxtC7wdleiC/PhUFzom//1SNTvRIezEVRpf6owVKl34Q2+cipmSDpKuNWnDhupuCgpWZ5PwjBrTDx6NW72WS69jkIuZJfRNiHdGY6Gr9mKymfhkM2Fyy7T5CoLmedg31EDpmIKZapTL1LJW9+AwH7tU8nnnSvASHfGS7z3m9pmrFYlSTr7Tl4qMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STvdnoUc39XVAcIsO1m1VPoYLdZ2lNyxdwjdYLQNf10=;
 b=j/Y8t/oHY3MFFN/05jbxqQmSUCSzI9LGMJ4M+0aCimSo2+KeV8Za8un5HsLhmQmDMrleHQdZiRrj2cV1tNOg2WCoesTEa50ZlBO+8XGTrYAskkRFI8LX/yquAeoo65PZBvSMU3IMrQ6StfPEIUQtjg72NAldIP/tY/9dWYpXB59Rq8i/Eg4hxyyo7lgvOmF2abaZlalJ8a8BuzakOskyC8perzMi03iN8kagGdrHqLDUswVsFkbHRaN2HKvurfqLmZS47Li5HtpCb+dHypdJru280jkMbRTpY7m1gNfn6JurgPHmwqkjutJeP0jewvs6iSD5kR8tREhIAcSfPlCruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STvdnoUc39XVAcIsO1m1VPoYLdZ2lNyxdwjdYLQNf10=;
 b=ZztFDaAKydHbbCNaBHIJ2Wr63YJZUX5/zA5TMZrgiA827+vDL8EVF3x5NFtHnYutgeFBarsfy+HDL+GX/S4lC1In86IGPUi4KY/nyf9Smz14tD3sLIRojqWFl4RZSRZjGaPDUqxclAYaW5jbWp1QY8JKz5NnUnbQ4AC6ZayfbfY=
Received: from BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23) by
 IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.19; Fri, 13 Sep 2024 15:48:56 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::40) by BYAPR01CA0046.outlook.office365.com
 (2603:10b6:a03:94::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Fri, 13 Sep 2024 15:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:48:53 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:48:47 -0500
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
Subject: [PATCH v5 5/9] perf/x86/rapl: Add arguments to the cleanup and init functions
Date: Fri, 13 Sep 2024 15:47:57 +0000
Message-ID: <20240913154801.6446-2-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: a11f882f-2b5b-4eae-cf7e-08dcd40b9211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOkVnKmIMP14z86vJ1T0+fxuHfG2kcMhqMfU7XUEXqCZoxpEPQQcQpQaDHjy?=
 =?us-ascii?Q?ayGNhVXPSV4W9wnfIRrNnlXBibRW0c+OWJ2hUDQHgPVelLIC8nkNGNdcXjN4?=
 =?us-ascii?Q?klHCuElj6p4PqUYQjSXAiBT719sPrk+LiOzTWSGfkvg1LJlch/WS4NRJ+v9o?=
 =?us-ascii?Q?Zyeov5/7+k8tqs8Lt/CzLaR15AqhA36R5Jmm7bHzOhhbpZqKA/DeqSuVqEDU?=
 =?us-ascii?Q?8Dg96OqnZZFIduIGNTnFzPSfHE0Giky0Lh+sawIR+GyYD2ByG5w5vM4IPIHj?=
 =?us-ascii?Q?a3ow+jyeewXaaeHoZBFqnTlfu9hkPFIXIzIZGjXqttBazB8+IItvfRaxY03R?=
 =?us-ascii?Q?4JhO85nc0GhyUP8hcqyODZK+8F33VbIIoSz8l2V5gm8IlXKVS2RbrcFVByBa?=
 =?us-ascii?Q?6Rk/rM6MZK5XFSGpbbvGpIBLJGvvf4rgngRpLYJ3XmaYN6IbUAzmOaSrpfu6?=
 =?us-ascii?Q?48MYvbxsc/ZfE7Vm2Jw5K0ACwxqTOlj4ZKCQHHrlGtm+0Wx2wxnqSSsXYrYY?=
 =?us-ascii?Q?56bNURB2hUInMO3RpszvJBjT+jGX51N42lTCIFoF+8nLKpybsHJzrE3E1EDm?=
 =?us-ascii?Q?sXYkSPrXX8xRPtsl4Tb4g5xkz6JolLWVUQGfXT3MupX55p1TfNDbY5bE/+Rz?=
 =?us-ascii?Q?gRfcSMmpXaudZ56H2zDBEY/cJ1mr3kiGsuZz7u8HHbMHfX+j6L1GxbACpSS0?=
 =?us-ascii?Q?zghJsMZucfsL7u0OSMsavlzl9LztxUrotCCtgRrZAihP6PXtApmvvcTTXLe7?=
 =?us-ascii?Q?M6U8Hj/buKH6vED3q106UvSow/dXqcc66Jj4vmWhL/Wy/IIZjKYArsJYPdpD?=
 =?us-ascii?Q?BhbtYRi91h6p+W52Yzyb1zkauBJfCVjJ/fUpphC7/t0F+U/TkxoYUHQv4B8H?=
 =?us-ascii?Q?0AiQjeTfyNPK2trrGjHxjBtkF/QgSyvmA5oz21ezBXdygpSolN/vOGPIBWyc?=
 =?us-ascii?Q?G5pliWBbSdU4o68M/60+yfZteUr93rqqqp8nzxoJtY74893EXo/Ij+M8NMxP?=
 =?us-ascii?Q?X3Won+PDL1iA51hXsk47vCoz2WGcxpBRPyKQLgZ2Lqx1mKZGBhnOAFthnjvA?=
 =?us-ascii?Q?QkXUDIGLmjeCZzM7A5zLDyU3EcYDRZMSR3hdTgzIe1O9/g25fMvzRlho8ZIr?=
 =?us-ascii?Q?R0nhlQKz1hp8VrpxLnLsOcabvtgWxICSGqaR3is1/rtBWARYFToW+lsqvtRW?=
 =?us-ascii?Q?XUy4kEbIg1usYa54mSTfT8R2WTsHQFPwgpAIzDur84dgalzCzUgyAqhqUM1J?=
 =?us-ascii?Q?z245OAQVqXiw/c184eUEC14cSziv0BoYBZSZZL7RZBKGHXlFRbCC+v6UsSW+?=
 =?us-ascii?Q?PJX07tR4lpvcEMGcyMnd3ADg0OdgHYnGGMfCLblaAabjYAJ3Fj6XnJV1tnLR?=
 =?us-ascii?Q?E4Tpd725w93kgN0LYF4o5gMWS5rAyRYjRW92LjfCfyzsQ+Z1Y3p6YaVEEfoW?=
 =?us-ascii?Q?9zsxWkUFSCGEzwm7WX/Qh5ZT9w5YjuVh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:48:53.8731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11f882f-2b5b-4eae-cf7e-08dcd40b9211
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604

Prep for per-core RAPL PMU addition.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 46a6aeb61541..3bb1da8f96c3 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -597,7 +597,7 @@ static void __init rapl_advertise(void)
 	}
 }
 
-static void cleanup_rapl_pmus(void)
+static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
 {
 	int i;
 
@@ -615,7 +615,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
-static void __init init_rapl_pmu(void)
+static void __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 {
 	struct rapl_pmu *rapl_pmu;
 	int cpu, rapl_pmu_idx;
@@ -645,20 +645,22 @@ static void __init init_rapl_pmu(void)
 	cpus_read_unlock();
 }
 
-static int __init init_rapl_pmus(void)
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
 {
-	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
-	int rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
+	int nr_rapl_pmu;
+	struct rapl_pmus *rapl_pmus;
 
-	if (rapl_pmu_is_pkg_scope()) {
-		nr_rapl_pmu		= topology_max_packages();
-		rapl_pmu_scope		= PERF_PMU_SCOPE_PKG;
-	}
+	if (rapl_pmu_scope == PERF_PMU_SCOPE_PKG)
+		nr_rapl_pmu	= topology_max_packages();
+	else
+		nr_rapl_pmu	= topology_max_packages() * topology_max_dies_per_package();
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
+	*rapl_pmus_ptr = rapl_pmus;
+
 	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.attr_update	= rapl_attr_update;
@@ -673,7 +675,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
-	init_rapl_pmu();
+	init_rapl_pmu(rapl_pmus);
 
 	return 0;
 }
@@ -799,8 +801,12 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
+	int rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
 	int ret;
 
+	if (rapl_pmu_is_pkg_scope())
+		rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
+
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
@@ -816,7 +822,7 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus();
+	ret = init_rapl_pmus(&rapl_pmus, rapl_pmu_scope);
 	if (ret)
 		return ret;
 
@@ -829,7 +835,7 @@ static int __init rapl_pmu_init(void)
 
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 	return ret;
 }
 module_init(rapl_pmu_init);
@@ -837,6 +843,6 @@ module_init(rapl_pmu_init);
 static void __exit intel_rapl_exit(void)
 {
 	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1

