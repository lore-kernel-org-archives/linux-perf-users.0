Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115826A08F;
	Thu, 30 Apr 2026 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529527; cv=fail; b=fDKG5O5XklqSGHaEpcXi4TYiQ4IeQvkXWWEzWMWkSdClnrnDUghC6oeRfsh9Xj/uqneDyvgrTQ7ipT3vW1GqVpmA4K5Dq2o5TEmwHyr++CqI2A/kwryHOXiSDMAzDU/ivVF+A+jsIZ0ieCrMXl1F7ZBLk894o2AFqJ2MNWQ0P3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529527; c=relaxed/simple;
	bh=5l/VdsglVwU23+bXXIPKUPJ+96qeINNhVOgn5a6Yi74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmC5CKeUPV3W7mKVEaEtwxLOePMu4tS+u6icX8RYnp8Nu388CZjmPSqEU45ioX74UU7ID8Dz+AoPxGHFZnG7RfhQWAwErFJGuGwv/S5neaSsdAyIqySXC7csQrF6m38kcHMNd9G09Lzxx9iVASPbCtY0Vcb/VS04WX8aMxWZPWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QDqi7hD9; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QDqi7hD9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQiOCKa5GvQnMHixYY+7anAJAk7L/8PAaJ7TW1W+z++O+kn80VT/8Rt4e9TR97pat3GYBt+RoxoGY8dOl09pNk0Ln9DDAFlj7ROzmWALreaXJNVMhwMibU0F6KzZKgMlrZ35bQeIR7X3shfdYVHWBT29sG2I7TT3dv7oRC+XeOQ+Ut6oFepVuOBTu7c5SXee4ED3xkf4EQnuvLQRVZqFBmw042suzY77g66J4diSCMe9uG2FN56oBPdjH6wlMcoUmNYK6qqMHDQ7H4g4s26qDQnnEtySeFsiq92SClGywm7m/MwVNQKly/sEYCzf8QD0yR+L+Qm++Z9LUeWP2D4T5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joVzUr+x/UG3WqYGtFWT0CJZJo/pYctk/+rZxcq7lE8=;
 b=JpXFTxecW5tQJTgReFOXFVZoC2bMRIPBXFb0gQQpFtTwTuGoFD3aqmOWdE8KPWsJdYB9rEVyH7rQNEs2MkDNIyfL79ahKVHz6/+bky5gfJAeGfMDxqIw637CUh47LNkCIFQEXwWwTWTGo2lgJZiSukX2fmpabBWo1sTHT50/F76GExUUwv+l3zGow0Mdw/oFwjHXyh+6w58nRQheShpky63+qagOowS0X4pLk4YNa5VX7OkpDJRVRyguR9YKdBZA5xIVJh1HMSeLZWPXN5C2lYmvgDAKkIrnXkslzCqR+dQxpE//+bz/csUjqUseig78TiJ5ax3dDQQmLc4FMHMH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joVzUr+x/UG3WqYGtFWT0CJZJo/pYctk/+rZxcq7lE8=;
 b=QDqi7hD9T81NegQIgDPsNx5ZRYLz2/QTOkyPy2C0wdoOXjeIjk0DvB3wdLlXw3UtT4EelKTpnAZ7GZjEsGBpNOOtutNvUZT2oJUXnZx89aXgB2oCKVeLvmFAQfMIMOjyol4FSLRVIeVxdoiRWAoYw+JiXIPqReQh3V5szIFSvB4=
Received: from PH8PR20CA0001.namprd20.prod.outlook.com (2603:10b6:510:23c::15)
 by LVXPR12MB999198.namprd12.prod.outlook.com (2603:10b6:408:3dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:12:01 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::b5) by PH8PR20CA0001.outlook.office365.com
 (2603:10b6:510:23c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:11:59 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 01:11:54 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 5/8] perf amd ibs: Make Fetch status bits dependent on PhyAddrValid for newer platforms
Date: Thu, 30 Apr 2026 06:11:12 +0000
Message-ID: <20260430061115.10266-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430061115.10266-1-ravi.bangoria@amd.com>
References: <20260430061115.10266-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|LVXPR12MB999198:EE_
X-MS-Office365-Filtering-Correlation-Id: 988982f3-da6c-40e6-f663-08dea67f63e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tGe1ZCHmgPxu9IvyYOf/wd5+kIB1mNZy1a4a1lTbUH7NajaoXkunsjUbHYGUcryoQgN8eyOfmq1SxzcPwF1sRl9bTckiumeR0M3kjtPGGapZBOlkgaLrqniYdnoEGQFkyDopa0R0vo26wnvK1n4tYfzf+TVDzVNCEn4XIAAWwnjmYRyzi18CqGxgpYCGtZjfziC70jogYmURaS1puHSKe8YUKtCHeAw/7XEPLd6IIn8dk9PT9AM60t9UoYytDRSMRdYG6/A2Cpe0QPiJFcux61Egf3HajJYu7c7oSm7MNL+rwsvm8Br4Jj8IN/DspZln1oCgDIA9h6CwK4NW7+AyM2QylFpxeP9n3y7QV0AEMHEi+5r7GW5gG+warfPEeGHydK2GFTHp0fBztwHmz7vnpOLYObkOQRI6bKLfckXYKVlrfRaZERy4txMBbPJ2wVwbTHCglhLsNWEucIwzEUEBfULx026p9ZjRdPDaOyuzZfrV+9e7lu+B3g9ZgjpwIgt7dlOw0bBBnYzjy9RwtOXOXmfHW6qmv8p2B66Ovz1WgBn8A+/cP9J8oOXFsScosKAek69Vob+oU5kKpB5QmHcx61xFTsI9E5mXRoHJ6uls2dPKHA50iW6nz71PoiUv5Pm5Q0FVhj9iekfPZNOkpimZcBDqB+KvWVojMDolUsGPt/0tkqZwQC5yDKz8fNnGvW2syHP14ZRxSlAABZzsocf/7XxYLgrlPdeumTvvJLtc1mWbzKpRxae7aBDGBZYSY4zsKnBnAU3Hu/pUzouZiYTCeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W9caC1pqa0MOc0bFvlUwctyaTbreotO3VegT8stnIgWoc929eNCI773RBqldwyP4DnOxvIbqaaoEppOV79bbikIZEoQ2JMW/8OQR06Pl9qbt/2I7xx5ERSH2u7PTH2QKQDuQl2L7pFyW1eDhOGHdTu3fvCjPFK7nD2kEYl4rG7md8rI640WYX0QpR5g1ige5u9KQng2w92aNu/g/t+R8C00jOkrgSCq+HJQKiBM99eUe8sFFtHaSrPrz+EohwbmiTLvg7m/LQW8IQLcbGalvX5TWmmPNIF28xHUwEM1an7xlL0lOTaGqWo0icQKt2NzRqvCNk2srX0w0HMrnCM9GP0MeNwWKsabVihWghXRV0Uyt+9MOn8OhfRVD2K91AuzGbDf4k0imTxJn65v0lICc8hllcq3vZmzEZksF7QACdLd9W+mI1XYV4y6CH4+pYtLg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:11:59.9391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 988982f3-da6c-40e6-f663-08dea67f63e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999198

On Zen6 and future platforms, IBS_FETCH_CTL status fields are valid only
if IBS_FETCH_CTL[IbsPhyAddrValid] is set. Same for IBS_FETCH_CTL_EXT.
Add these checks while decoding IBS MSRs.

Unfortunately, there is no CPUID bit to indicate the change. Fallback
to Family/Model check.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/amd-sample-raw.c | 42 ++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 385308c55f34..ae005eb0363d 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -22,6 +22,29 @@ static bool zen4_ibs_extensions;
 static bool ldlat_cap;
 static bool dtlb_pgsize_cap;
 
+/*
+ * Status fields of IBS_FETCH_CTL and IBS_FETCH_CTL_EXT are valid only if
+ * IBS_FETCH_CTL[PhyAddrValid] is set.
+ */
+static int fetch_ctl_depends_on_phy_addr_valid(void)
+{
+	static int depends = -1; /* -1: Don't know, 1: Yes, 0: No */
+
+	if (depends != -1)
+		return depends;
+
+	depends = 0;
+	if (cpu_family > 0x1a ||
+	    (cpu_family == 0x1a && (
+	     (cpu_model >= 0x50 && cpu_model <= 0x5f) ||
+	     (cpu_model >= 0x80 && cpu_model <= 0xaf) ||
+	     (cpu_model >= 0xc0 && cpu_model <= 0xcf)))) {
+		depends = 1;
+	}
+
+	return depends;
+}
+
 static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
 {
 	const char * const ic_miss_strs[] = {
@@ -43,6 +66,18 @@ static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
 	const char *ic_miss_str = NULL;
 	const char *l1tlb_pgsz_str = NULL;
 	char l3_miss_str[sizeof(" L3MissOnly _ FetchOcMiss _ FetchL3Miss _")] = "";
+	char l3_miss_only_str[sizeof(" L3MissOnly _")] = "";
+
+	if (fetch_ctl_depends_on_phy_addr_valid() && !reg.phy_addr_valid) {
+		snprintf(l3_miss_only_str, sizeof(l3_miss_only_str),
+			 " L3MissOnly %d", reg.l3_miss_only);
+
+		printf("ibs_fetch_ctl:\t%016llx MaxCnt %7d Cnt %7d En %d Val %d Comp %d "
+		       "PhyAddrValid 0 RandEn %d%s\n", reg.val, reg.fetch_maxcnt << 4,
+		       reg.fetch_cnt << 4, reg.fetch_en, reg.fetch_val, reg.fetch_comp,
+		       reg.rand_en, l3_miss_only_str);
+		return;
+	}
 
 	if (cpu_family == 0x19 && cpu_model < 0x10) {
 		/*
@@ -72,8 +107,11 @@ static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
 		l3_miss_str);
 }
 
-static void pr_ic_ibs_extd_ctl(union ic_ibs_extd_ctl reg)
+static void pr_ic_ibs_extd_ctl(union ibs_fetch_ctl fetch_ctl, union ic_ibs_extd_ctl reg)
 {
+	if (fetch_ctl_depends_on_phy_addr_valid() && !fetch_ctl.phy_addr_valid)
+		return;
+
 	printf("ic_ibs_ext_ctl:\t%016llx IbsItlbRefillLat %3d\n", reg.val, reg.itlb_refill_lat);
 }
 
@@ -285,7 +323,7 @@ static void amd_dump_ibs_fetch(struct perf_sample *sample)
 	printf("IbsFetchLinAd:\t%016llx\n", *addr++);
 	if (fetch_ctl->phy_addr_valid)
 		printf("IbsFetchPhysAd:\t%016llx\n", *addr);
-	pr_ic_ibs_extd_ctl(*extd_ctl);
+	pr_ic_ibs_extd_ctl(*fetch_ctl, *extd_ctl);
 }
 
 /*
-- 
2.43.0

