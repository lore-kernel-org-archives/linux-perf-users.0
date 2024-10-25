Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736F201024;
	Fri, 25 Oct 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854984; cv=fail; b=u9VKrFuv8BgOtvX4bACk8YEydWClYF9Vhoj2JOrO4yqM35rIatvHFmr97Q/VTgPMqRfXiYOEMuUFYnGI9eNYprr4j1Q0OwUwlcxVAGR7WWWLl6JufG0E4McXpZxMN7ZpWlgnWr7OQBLTumqt8lIHELOaemkIGOd2k+vWQIA4Cfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854984; c=relaxed/simple;
	bh=iqVDNEY3IqJ/tMZAhoTIBZYxQDQtnQxaqlQFAWYGSvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdJ/2hNBb4OIkFUQ71eZT2zdrPZ6M/VFyeUWmK5fIUp89G74xGVOXAEk7KDVqDRZzCwCjcDTXx+QxPYXBnBZuURozAN/jL+WLjS6k2drVMs9h+dYuQ3Cit5x8rOEcipPvLtjx2beAdiUZ07oZyaUekK9FVDht4ePqvfMeKof5z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zp4cYoba; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zp4cYoba"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaeCyY+UL9hpu5/nwDNcoO48IX5xFLxK1tPMRi2PYzhbYkpp5/k50Dm5d49hBgo1NfUYVP1OIg+YHwSW7+PolmtKq/wCG6PfROOJX14MKne4pGml+gsPGkARE6+dT+CHDn8waEDXTPqRSTqA19dN3WDbGzam8uS8+JmQ12bOkm1Bs9WpeOG47AkS8GjV7CUOGiM0xiwHOqNJ76SR/sHx2ixZdGR0sqXNrPZr29JL+s/glpwrXgU3tVkt0sQ87HBTiojJYKSk0WAc5W9a10czdZ9NRYkgXsEBtppUFuvZFJPIrqf//Q7tkGOkO/nIPRx/JbK1OC6No16a8PBog//jjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+Gi/GIoCUF413fI6Kh2bMLzJKPdLWgWodqSNDlfroY=;
 b=BH+zSRm9lOzjfJD5y/IxpGdrXnQwKzAFDnKSYV4uDUJW9wq5cmEmLGluhiLMJKMQpzhxaoe99D6H05x1iiXikywPWaPNyRTSlrOgAStczNybQVOw3IcNMDvsFnrRXSk+ng27ytJzBckgsoyj5G20IHc0wIehYyLqQHqQpDvLx9Qzr+VrsvqCAunh+/wowjESjamgD1iQJAIsdvfHyU9w1SbYJ3/Fkq7FZA6CKfjV84sysRxna9ayBK6SfqPPcBoQSBEBWXaLu8SU4dzhz5xTWBXT+a5ebu7WxL8nJXXeHqAFIO2EpcWxd1/in9NCgACbnPQ1TN9Bi01gmmH7zfWsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+Gi/GIoCUF413fI6Kh2bMLzJKPdLWgWodqSNDlfroY=;
 b=Zp4cYobaJfWZrdRxn8wAnHu79y4Xx2TroI3/FL1X1RHzAhzod8/OmS/+bCf7fiwwHo6Ypm7MdY3hb4ZqKk0ZfMYcC3ARICAG1+of2F+W3jc3/yrjm35JbalLFzw/EPXgBKBo/HUGlXr0rWa766aVpUHDioIXF+bSLGxryRaqxzA=
Received: from MN2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:208:e8::33)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 11:16:18 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::53) by MN2PR20CA0020.outlook.office365.com
 (2603:10b6:208:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.32 via Frontend
 Transport; Fri, 25 Oct 2024 11:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:16:17 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:16:06 -0500
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
Subject: [PATCH v6 06/10] perf/x86/rapl: Add arguments to the init and cleanup functions
Date: Fri, 25 Oct 2024 11:13:44 +0000
Message-ID: <20241025111348.3810-7-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: e4946aee-30fd-4869-4860-08dcf4e67215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EqD9FzvZx1Db6Yfmf+gQbyq6Iun2IOVGLLxiG/JZIl2bwixU4kV/Qv+RBoxR?=
 =?us-ascii?Q?rluHg48ufZbZ19zB0MIwXaWiBKhNXwaimVDKrR3LZfgKlQtxQT5V6aWTTCug?=
 =?us-ascii?Q?0IsM2Lsy94YH78lMzVYBhG3h4mU8UP+RvMnpdNfFtPMb6rh00olLIY1BuR1Y?=
 =?us-ascii?Q?nZEX843QCYu2+yANdWzozvScgE+OtsSuqQ/mdjrt4dXwLj8uXA8sZfC3oriA?=
 =?us-ascii?Q?fJcFA2oivdFBUzGqxJ2gHlWGLFwvSwt4RisgMvZFg0fJ5jgBlZ/Ipl51SYG9?=
 =?us-ascii?Q?LkHM8Pe6Jx0QEfIFQUvZ4UscUXvgJSyrR5/YhlPvJDJAJBktPo6AX9h+tUKW?=
 =?us-ascii?Q?EXlCt5jJYXHbCLyFndOl6J3z9tyW7RAp8JaZwdmnKILnovfX51YjZMup80Z4?=
 =?us-ascii?Q?9q6D8fINa83S2JjoA54hXqzR4WJvO+J+bGdmGk/xnJBD/JBDVNsdsDWLFH4p?=
 =?us-ascii?Q?MQOzBVdsWHBhjq3Rz8qsllP3Ga9QbC42K2inwn0GlctIfsTMAsnkHeZFDVxI?=
 =?us-ascii?Q?D/hm4CidVJIHnlxTXQzqVymJ6dgnmvck/b8O2NheripTPceh5swfBIfExRML?=
 =?us-ascii?Q?gLBtArRHmqOkXpwB5nFyzB6Lv4cMaPiezUL1nRmySMQCws20QCKgiGrQwRz0?=
 =?us-ascii?Q?omFiy1aEZsUU/JYiPp7fgOd7g0Bfb32hZKZiyS5oPuj3HCAiRW4wfp8jX7T9?=
 =?us-ascii?Q?nJHBo6LExf9PbCL6hQGNTtztitgMcL47GOJMd0l3mBvFMVP9/XOtEUfNYOMc?=
 =?us-ascii?Q?sFHgSWgtBP58G+H+MV+r6buOE3IdHDNBJJ0H6DSfJOu/Bj/WpMiMTugjguRL?=
 =?us-ascii?Q?ymFwCHhuq3Ng01ZSMgbW8wwOoLRY1Wg6WVI+kSR4xLNfSplaKRQwB8jyeJA2?=
 =?us-ascii?Q?BWDPkx3j5RNzXBxd+YLpjAZNcv3XmgEdJSPEVgoiZNZeE7/iMfFiMiXbzr9R?=
 =?us-ascii?Q?RH9cJOMf95WtBXTOZbstXG6vv7ZVAVCeoiQYUkDHKTSk7KYwHM1ocghzPLQp?=
 =?us-ascii?Q?AQG2Ufc9z17orQYyNIrCFqRWATvepVZJSVGjtO6Lj/WQqT96zEMtaPwXxKZY?=
 =?us-ascii?Q?B6QXBI4O0tV/dxp9R2va+Din9//GzHs2uNPbNCALyJnTrfIl8fJtUTmKk9+s?=
 =?us-ascii?Q?+e6d1bQI/BvJuuK+AJJGugzsslcoTOLLSVgJ9/R9wxyViM/j1kuM5gAzG+nZ?=
 =?us-ascii?Q?n5y3jjtfuprLK3DqUCha1kFN9yargzkEZw2Bs8MJO1EdlS5ZfXvxpu0EEQCe?=
 =?us-ascii?Q?1360NMN5PxbpeOrV+jTD8BBCJwKRwi02NduTgGZQhc9+vatKrwMh/KDVyySG?=
 =?us-ascii?Q?zhyzyFbxt4+EUp03ZFat6Z3weUb7ZDMNzCWcrIU3Ow4hj0grnEUBAfWlgSfI?=
 =?us-ascii?Q?8e1+xgewqtVc4db9ecgqIvj+huZWIwYCMmmgqLmXWZwF8ZSA0PAsElcAPxqg?=
 =?us-ascii?Q?CUB5P4TkJVA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:16:17.2795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4946aee-30fd-4869-4860-08dcf4e67215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757

Prepare for the addition of RAPL core energy counter support.

Add arguments to the init and cleanup functions, which will help in
initialization and cleaning up of two separate PMUs.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 447f62caa5f9..bf6fee114294 100644
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
 
-static int __init init_rapl_pmu(void)
+static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 {
 	struct rapl_pmu *rapl_pmu;
 	int idx;
@@ -641,20 +641,20 @@ static int __init init_rapl_pmu(void)
 	return -ENOMEM;
 }
 
-static int __init init_rapl_pmus(void)
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
 {
 	int nr_rapl_pmu = topology_max_packages();
-	int rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
+	struct rapl_pmus *rapl_pmus;
 
-	if (!rapl_pmu_is_pkg_scope()) {
-		nr_rapl_pmu *= topology_max_dies_per_package();
-		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
-	}
+	if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
+		nr_rapl_pmu	*= topology_max_dies_per_package();
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
+	*rapl_pmus_ptr = rapl_pmus;
+
 	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.attr_update	= rapl_attr_update;
@@ -669,7 +669,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
-	return init_rapl_pmu();
+	return init_rapl_pmu(rapl_pmus);
 }
 
 static struct rapl_model model_snb = {
@@ -793,8 +793,12 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
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
@@ -810,7 +814,7 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus();
+	ret = init_rapl_pmus(&rapl_pmus, rapl_pmu_scope);
 	if (ret)
 		return ret;
 
@@ -823,7 +827,7 @@ static int __init rapl_pmu_init(void)
 
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 	return ret;
 }
 module_init(rapl_pmu_init);
@@ -831,6 +835,6 @@ module_init(rapl_pmu_init);
 static void __exit intel_rapl_exit(void)
 {
 	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1

