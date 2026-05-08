Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69295371CEC;
	Fri,  8 May 2026 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220064; cv=fail; b=cimrMyUyhahMKUBGaAgUE12iZYlR/z+kVvkVhpRp8muMtTihkZsDDdXmOZLM01SKMjnY0cY/5Waz1QK4iB7Xm8Iufr065VFXAoQxz1pF8Od3jrY0T7bHbTjqfHDnbJYkLjp1788BuaGqesTts7ve+zrd/91UJn/e2eRUpgizNPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220064; c=relaxed/simple;
	bh=5l/VdsglVwU23+bXXIPKUPJ+96qeINNhVOgn5a6Yi74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaI2znOywaQ3VjJogTmIQ7Lou3kIV6xwS+IiCcL9LuEMAOSLNTvoYyxUSpfJ9km60FQEa8U31XG857LLpKAw/GoTy97bISwI1sYVpwcTlhiRfGAaDeLwoYKiN5vKG0p3L0mdzww/qGwkue+S7W0zTpe4OseyxoYRTMh1+8InidI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qi1/mNZZ; arc=fail smtp.client-ip=52.101.61.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qi1/mNZZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dgm2/Znn+gIu2GLyZrybiK8WVlwqq72rAV0YnCcX5WTQevJmuFsHmFFk7hdU7xJaxQrCsEv7sd0rw6sSRK/wcwq30OacbBdr3Tr9MxCr7Fx5Esf4BCC2wPAaVj7NrrAbbWG5cKflM4bd1FHbdEiIK+lj9Gbw+0At8coaxdhzzARVsMYGbbRVUQlQHsi4hWW6kmPOHb4ghrlXgV/SQGj6jSmcDPHPP7w1P4obB/Tui17MRbyb3znIcsC++VBfsSsIZ31uO82cjx5SpfrIOOl94n/8BXoj9HNP9MsCV00ptnhz4m0R78w20qBlYHWIerC0bK74OS/5WfOFpAz1lNBsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joVzUr+x/UG3WqYGtFWT0CJZJo/pYctk/+rZxcq7lE8=;
 b=rvFB8Mb2RA8fcSBP3uNkV6dNHEJQoOKsEBuYEt0deZXXDn5azVU0slIcB0v7TU3IgKXxzqKeCLp+9hsx5nLOAuN63f/wUN60mqho+n10RYns96hbIWmQduyN3rtvgJV1Au/8AnaXma3K3tcAf4K4bA40mHUoQhBq+KMoylb1Fo+zLYw2WZK2Wu1LBaJYDCxk+LZnsuedhv4liuAn0bkIYt2T/+G+gvDw+ib/mHbNTrFqvbGAyy+mBfp4YJUZTBOCdfLE8K5Qf6/ry1AEup6BLDg2pbaW2FJxph2iYaKw2L3Wvatcrko4pd4v6W6V3rxs2GYl2QULjCZspkLxFxr4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joVzUr+x/UG3WqYGtFWT0CJZJo/pYctk/+rZxcq7lE8=;
 b=qi1/mNZZDghmh4iTA1ESHydaPcYSqfo160sUMsXLC7Js107C1SOTziQQol9e0Nyaa/HldxDpnNwB+cSRiidD3pToQx9NXpejZBQGqvDAWO2HIE2i1N7tHpkyi+lV7txsiTKY27mWtSr1YB0Y4mLmc6/hlO9sjM4vEEHzOZParXo=
Received: from SJ0PR13CA0132.namprd13.prod.outlook.com (2603:10b6:a03:2c6::17)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 06:00:45 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a4) by SJ0PR13CA0132.outlook.office365.com
 (2603:10b6:a03:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.9 via Frontend Transport; Fri, 8
 May 2026 06:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:00:45 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:00:39 -0500
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
Subject: [PATCH v3 5/8] perf amd ibs: Make Fetch status bits dependent on PhyAddrValid for newer platforms
Date: Fri, 8 May 2026 06:00:01 +0000
Message-ID: <20260508060004.2575-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508060004.2575-1-ravi.bangoria@amd.com>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 982d043d-29ec-4f1d-8e24-08deacc724fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	C6cIOCQLguC60XC2TzEfiv2GiPWVDk32sdmXIhLbGBrlAH67YwI/A4HMNuoa062WJZHyDNOKFxpA/AA5UYTViBcgQXG00Lp9UaUEVK4cKQS6BWUlAhO4yQf8cfsNqt5Hpm7ZNwgEuUPN73hDu9N89av4qjE6VTrUfu2IPD3KRLF/JR0XSLGsiuGeLjK/Ea6yGu/VbPrgZYx0eMsgFlKM59NM7q1OQzAKYcxzUl1VAwgXH0UooA2d5HQ3goRd9w4knmA38NPGEckNCLmTasIze2DPAmwiR0v5w/yi2m2qiziJvtgTl3tN1l81QPa5zeDOattaNfz9owjM011HhSudqw40xECtbA5FUJPSUHsYg6Z5T8AnEqIFCWjcP53SMWe/UimV2o2F8XMXn1HLVMz88zXzCOnKgHn1irT6Zx2QZupZTdZgnOrZkGFZxWV1aqYz9Rbnbw1HAlTz1UyD8KEmNERuHYaHPJ/Q4wJz+ctqK2K/4+8bK6hjhK6Z7NbnbPhxGxGOTjQmS67DV9vspD90rNBDPYOk4KOW593sTOrsqAQX4Ftkgy+Qori74F9x6nYC9ci+0KRL0dxi9kFQi+mCER93U9NqVeW86L/k58umrMNsO95RcKXPVIG8plPmcECv/YdWekRQuq18VjSvRO+qZjSq3W9boeNrlrrY4dNxebhfxi80hj+3nq3+dZdFPwX4zF92ipTIWkHBiBcqHWoeHuDx60ofxncMN/3srl9kAYM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wgOcTRZYREcMLGyoKbZDM9S5RdKZU6L4vpBONqtfRovLrhADAm5493hMDVPTyGC3bdo5j/Lo+VT2/KOq8iSJY1Q8rCNHIOTzfpodkmETpyV1vrK6/LJqODnDwrf1h+ExpmaIRhq5jSgWvCLplra7HVQARImU+Zi+07WyWboXYf956cBgI+e20LRZG+7wSj/KqZ6FPshvhdjNK8QicY8p0PnqTY59aYq5ulTlw/rZR1E1Oi+9kx+VNh90hWsWzwAbMeK4VGnQagXR8kVLamN0QnNrARF5gQsR9lVmakvWBgkdGK6bzWQTL9DYADBLMlVsAO9Gpyydk/1ZWvU8wj0pDpmrGZ8ZWrI+Io09VLp5JCS7QGaAfCvBqNXvzKRw09cCDlQ/P3z4Z3QbIw0acW3Aebys5seFgE+GjVhKj3lWWs1PXIOBh6CTCMH0flQcFT/Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:00:45.0781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982d043d-29ec-4f1d-8e24-08deacc724fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

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

