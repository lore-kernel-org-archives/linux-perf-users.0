Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F681C0DF0;
	Fri, 25 Oct 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855037; cv=fail; b=a0l9N+L8Vz9FdW62rVsDTRpcps+RXJpRcmYiLMD3UjIIKcTdClVEQrgki/MlhKeL7ePWjmjjSaZQzOLuA4o1peKREiUYemf8VPSKB8e1G2LAwjL+ezy/wuMH4XOWe+xBWfgzPFcVj2K4ZmYTnNUU9V213uyf2GlyyQrGj508tug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855037; c=relaxed/simple;
	bh=DQmYqcsrgOfcArdRNpunEFfymyiZGPC6hw7nDglyoCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcuvkd8+jSsn1MLT98BTJ9T4Rd3pbhYrOhkqhSIXszFGl47jlzxdRhpuTm4SpjnST9DzJk4Sd8CZ5EFC2sr9tHyoWhTwyPqrwQQylojtfrI+YceWuDaUJ28axwtVY1ykXh9/+RQbIAPUrqEjPtgcNL8F+dDfW/gpZrYTVpVEomw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YAnQVKiE; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YAnQVKiE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj7+MGcXx4MsQncAPX6yKtOpUpHY50Hnkrg3HX6Gq77EMaeFVFRhsCoTLHenqu/EonFekbUIgS0qcKcNXKOlsplEZHAG1h22Rl0fcxEwGbfJdX9iETRx3ZJTqnWdDkhqVfr6OMcMFtgnLVeEW001Qnpe6lEHxRsbG3hhLWOknMDY8TuSjIrhnsL6r0Gm912ByWMP3FQoG2ypY7jrUWhHpRt4zyATpisXtN+VgmmzAQSsiDwj63nI4yTML/xoX+frjhqgNCeJhugArJEfqeK1tIrJiDNOsX2zWT2mvYyp6YpEdbWbZ8MmI14kT+LljUENKgP/NuBrGyEZVX/Ugq73mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtdfNHS/TOEDDD37toj8vqIYA0PlE7x/qtLte2HPhYE=;
 b=LKLg9/NFWn7NVrCYaUVmON5BSXeOZZPuLp5LE363f8LUjoBS3aAx+9y5q2SQVcTWHY8sDRHUUug5OsuNYG3fB0o3dyiziK3+lmcXBlEITXe0H/6YDGMS4nyO466WDksBCxmV6TRVrWpZkmszOJS7QKpfaTQTm9KrUsdSbAsVT6FjdsPIl+yrBJQlAtbRAL32XboYrLOYG8jWiFtU9+kWd00r38ZcfjndQ9s/8b6v1Jiwpf5E/VTgPc6j4oTdfKcLspbVbw8oySCRWeN/aNr9HyQ4WKRV0DZbDrhAe6CukrIKXFTkHC7c8+nSPCJyhcThG4f+0D/gLsw44PDL+2UYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtdfNHS/TOEDDD37toj8vqIYA0PlE7x/qtLte2HPhYE=;
 b=YAnQVKiEOukuRJri36G8+yaijr1PQWG1x9RSUxrwV58HGKUCQsQonobBRUxMCMkmUIhQSsPWkB9yguSl4J8an7+PsC85ZonrpsN1VpFSLVSyVZFshlNaU2EbqVm8Dk8dRo0PKIYDWXOhNSev1lvCDdImf5T+id3OxjnIUQphJhs=
Received: from BN0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:408:142::30)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 11:17:09 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::ac) by BN0PR08CA0008.outlook.office365.com
 (2603:10b6:408:142::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Fri, 25 Oct 2024 11:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:17:08 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:17:02 -0500
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
Subject: [PATCH v6 09/10] perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
Date: Fri, 25 Oct 2024 11:13:47 +0000
Message-ID: <20241025111348.3810-10-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c5a49c-4544-4829-0a66-08dcf4e69088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aYiTbtXsq3hNG9qAvQgVEwfzf0vu3ZwuCD7SWBCFryzJRGShSrCPa3iApvke?=
 =?us-ascii?Q?cQiyDNaxeuqFe/ipAior6I4FI3U0poBGOW9M8aiSHoEdiztS2nckvcCVbkAP?=
 =?us-ascii?Q?d9nc5TAiaBjGl2KQJhd4MhgI4yURYbDr/JMqS5sdyH5G/UWFn2wo5f1axvDg?=
 =?us-ascii?Q?nclU4NHf8Vl4JQQYpCceibTVA8FEYMUO0Cjzy4VFy1ilSCdDwsuzFG5dUAHA?=
 =?us-ascii?Q?Pt/x4D2DKoPUDKxJkHe9of9wePmgUiqrtxss/mL4hC+xY0H/xOnGeWUgomJl?=
 =?us-ascii?Q?bArgo9ATQEO1isp+YnPBmK1XTzLVVFQ6xZrVpVyGR31WQEJQCXTzo8YSxFyd?=
 =?us-ascii?Q?w2AHwBP/vb43DBIlNnDBIcDrwazR5yK5nG93rGzsq0OtH9xmsnALC4/Q9Ivb?=
 =?us-ascii?Q?ziLpCycdcbF9MpQU2GjXz+xSaowHkbBCD6lMoL+B8t5NMaJZfdIvsyklgl7b?=
 =?us-ascii?Q?yFTmfYJJgkPQqNHzKIi+hH40o9kN13+4+pFr2zL1OiP/dZoSjJsZ5TqRE2Jn?=
 =?us-ascii?Q?3ivfMj+T7BWXAOPfbDobXrFbxiOiGzMtOWErG+aImmXL7tdpSi6/oNiBjN/7?=
 =?us-ascii?Q?3sxEqfdPWS3oM9B9biXIxvXo6BLnfJbpTBM9JYHvrd6cSoEm30lm0YENF6Tk?=
 =?us-ascii?Q?lYRJ+bWiiItMCQxcncrHIol5EZHzA1WHSEMJCZUdaGoknPyfl5VPWsqOJ85t?=
 =?us-ascii?Q?NP1D6RuS6hPT/Bh0Wm0EWgjHz4X9kIY5T5vLY1un5eetkjG8XdUP9+S6NC0x?=
 =?us-ascii?Q?C6xVcXZKWsMggotfCdt9j5u7K1DKAJRuN1Mk/LeJXmYvv0NG1Eu78qpxvGRY?=
 =?us-ascii?Q?6pHZi9z2cTEn58T9cxN+TEB8Lrwvn7UawZi89heAkQZXk9jYYOgbee2yjRaJ?=
 =?us-ascii?Q?Boitl+wxyTN1wyvbOQ1mMW+T76adDz1DvagM5UHlu3lAveWpBrdDzx8POD3O?=
 =?us-ascii?Q?DGjBA3aJJ/9PehoIRmpevkwOqy2CzixThlDHWaS4qiCy7pjifgk7ONLUk5hp?=
 =?us-ascii?Q?2sPU81GQCGudxW9a7uykxBahABg6HuAU6tYuZJ8xrtMWnD8AdPlXh+tHU3VD?=
 =?us-ascii?Q?jeLIVs4WUArkjhMbodj540jRgCUXaATWV4D7Jd4Ka7kmRxZ5Vn7Bxiy/ZGkq?=
 =?us-ascii?Q?mhYQKBDE85vO3q3b8aIm0pRhWJyxqIgvP52W44Iqbd8F6ykyhx+Qxszipo7b?=
 =?us-ascii?Q?HDHhIP20dJESGWDpmlYtHhByYeOPiZI3TZdDdkenKRW9+oTQX7GWdwvxyre9?=
 =?us-ascii?Q?qJnlS59JxX79+wpLKtRI0kyD3THRm7ymAMCAYlfSGSiEV7eF4ydUdZFeDmXf?=
 =?us-ascii?Q?QEwP0WNKPy1fdhOQTv3MDgWQQolFwChv9lFoXSO8FUptElWlEOEwuvinvDLU?=
 =?us-ascii?Q?dIXrbBMWUldHDMYnswpauUEopVTOZoxtKCRVmEqKh6pmzpy30cY1SNfnnqmZ?=
 =?us-ascii?Q?fAMQab8M0nc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:17:08.3632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c5a49c-4544-4829-0a66-08dcf4e69088
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370

Prepare for the addition of RAPL core energy counter support.

Move cntr_mask to rapl_pmus struct instead of adding a new global
cntr_mask for the new RAPL power_core PMU. This will also ensure that
the second "core_cntr_mask" is only created if needed (i.e. in case of
AMD CPUs).

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e80b62cf9abc..d3acc70a3d31 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -129,6 +129,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		nr_rapl_pmu;
+	unsigned int		cntr_mask;
 	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
 
@@ -148,7 +149,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
-static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
 static struct rapl_model *rapl_model;
 
@@ -358,7 +358,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	bit = cfg - 1;
 
 	/* check event supported */
-	if (!(rapl_pkg_cntr_mask & (1 << bit)))
+	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
 		return -EINVAL;
 
 	/* unsupported modes and filters */
@@ -586,10 +586,10 @@ static void __init rapl_advertise(void)
 	int i;
 
 	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_pkg_cntr_mask), rapl_timer_ms);
+		hweight32(rapl_pmus_pkg->cntr_mask), rapl_timer_ms);
 
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
-		if (rapl_pkg_cntr_mask & (1 << i)) {
+		if (rapl_pmus_pkg->cntr_mask & (1 << i)) {
 			pr_info("hw unit of domain %s 2^-%d Joules\n",
 				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
@@ -804,9 +804,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
-					false, (void *) &rapl_model->pkg_events);
-
 	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
@@ -815,6 +812,10 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
+	rapl_pmus_pkg->cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs,
+						  PERF_RAPL_PKG_EVENTS_MAX, false,
+						  (void *) &rapl_model->pkg_events);
+
 	ret = perf_pmu_register(&rapl_pmus_pkg->pmu, "power", -1);
 	if (ret)
 		goto out;
-- 
2.34.1

