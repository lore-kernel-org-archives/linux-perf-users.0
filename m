Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E23AEB2D;
	Tue, 13 Oct 2026 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885090; cv=fail; b=P5dxVmsgD2K1mD8Rpe4mPDSjF8UlRVHFd8BPjUXg8Fzx/bztaE4qe1q209qdMZjOs8SA4oPO26w9QurYyCkgNWMojciKr6JLmwfa8p0TdjCysxJmM68msuMdowhPOCaOzuGAuiy0BSMj+J26M3fh0yzVkD4rknB0xdOM4nA3kMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885090; c=relaxed/simple;
	bh=DEdDFTyFMK028WqEWS2OWc+2q/sNViEZcXCb3y3ycYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hx9G6A6EL2jwHSu82g3watsz2CQNnx3wBEUXr0rnasxGjy2Ks2QhsoOne9ZNvhMpxQGG/tPfXz2jlFn+OWdLgQleHpty72a+LZA2wwM2ZE2nF1CpoLbmjvB1dPVOnuLt+l+G2vzP2CfSEP20q2iTfzpQP7D0TccG54Yka8ZG7qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sf9ABjxh; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sf9ABjxh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dguOM9nqU9w7EuVLk0vjjeCpRuGgTbGPxqs3VZ6fb2xr1H/wIR2fvSSwgOd+K1HadmqxG8ZzQruXHfu91i0+BK1p/kN0wn5SABblXU5Uo6PQ1T4oymYo0fQnWxqjwXdIkfRtenO3rbCEfAzWMf5WhjePR1r4JkhOATe6REOgMyIcSjLqbxvRywimZE2ewHbHMGzYTY/GuKUHKavnaet9Dfy8fal12xj9rFssbhSkW254roOrLs+G3v+Sj3nhrV94TtWeXT7wiJ+1qqtEXOcMFTWOvxLSDed4HEOYMpLFUHokS6SKk1MscXLb9WPCeABIOHjBdcmdb/YC8cwNjOeOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExV4U5ncQeRiklwvthOL1o2i6IJMGBcrZHZHW6gekH8=;
 b=Kj2G6IEmk5c49tecKo+8cO9JDr9GdWlOPxteUIlEC6nF24+rq8oLzZDp9h5UnCdCkSDqjyNdQ3bXJWPpkUpKvwd9YHOsf7wRmwh2X52GiHPTqklU2MynCzt6MsGUY0s7FcNv1uxGTjmCIxbhImj9+rNzNatEzFi0JoG8hk8YMUdCOo9y4lNczLoMuDlg/i2aWyctP9UM6z08gDbaR2UMU9CnNYRGt/7NxhmLyLiNvc9ktqq93NwA3iJWfbgqOo96YVEAzk1jKTPgx/xwZYyPH8fJ+6/y6Q9FVmPbs4w2UzdwbrTWMSyV+hRd4Ab2XCnOAmCqbHcgB5U0k9tkYWkaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExV4U5ncQeRiklwvthOL1o2i6IJMGBcrZHZHW6gekH8=;
 b=sf9ABjxhihv0JNDRFzENZrECHcaA+U43ie/WXOxBgYaCIDMjWP+gpFxEBp1J8/FMizLkysDSlbxI59Om+ns/yd1/ytbW9fsONwtVS7DAc+d6UxPTRE/ZlKLcPdOd2mwn8EiChedVyphAdxEn8bd+/7wvvlkmtEHCFciTxstQ3Qo=
Received: from BN9PR03CA0137.namprd03.prod.outlook.com (2603:10b6:408:fe::22)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 09:51:20 +0000
Received: from BN3PEPF00022BD9.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::8) by BN9PR03CA0137.outlook.office365.com
 (2603:10b6:408:fe::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 09:51:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD9.mail.protection.outlook.com (10.167.248.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 09:51:19 +0000
Received: from BLRJANAIR.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 04:51:07 -0500
From: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, Ravi Bangoria <ravi.bangoria@amd.com>,
	"Ananth Narayan" <ananth.narayan@amd.com>, Sandipan Das
	<sandipan.das@amd.com>, "Thomas Gleixner" <tglx@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Jayapal
 Ashwin Nair <jayapalashwin.nair@amd.com>
Subject: [PATCH] perf/x86/rapl: Fix use-after-free on rapl_pmus_core on AMD/Hygon
Date: Tue, 13 Oct 2026 15:20:51 +0530
Message-ID: <20261013095051.24777-1-jayapalashwin.nair@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD9:EE_|DS0PR12MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bb334f-5680-4585-2ea0-08df290f885c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|7416014|82310400026|10067099003|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	eu8SVlmsGr0lABtUYdiPVntiO2UOQUV5Y4OxhLlGMfwPEtiLD+362AFB71qt/nSHuVfQ8az8DPWT6jTaOajszfYXsJBR2Jae0bwdO9Hcvfcw4G4UZawGYes9Crw+ebQ66g4a+DPV8N5Ljz8Oqt9DkOCIit3g1AgCAa9s1G2ZEf+oiLmN2zDMZW05X+4cza3dY6+wXOBJZ9zTOKW8AUCvq4EyHT2W5y2JWxbCE5gCfA/1Am2cMOpvBJSwnb6k1OsJ+QDz0Kt+3eatIkJauy5+sTZ70M8nBT9QYzV+O8XZN9Ny8fBbJbljskN6VEq+bJVsL30KFARCadP8hbgBwLW8T/xP9hOxroZVv3Z9t1P7PfjGXhohSjBK13sX4gCZ5Z28RPlvY0QfXm7ysylfQcKCauVxgcOizlJFe1TVvFn9Pa62MPFsup16UXvuvAFuDcamD/BJh7nR9o19eRu9XIMt0TZ2MBgLXTInjTEUpAyN0TEtCyIL8toR4n2YTpUkTjRN+nUwi2tiiy5vPqeF4QZPWr0H+doAURhzK6Z6B/qJBLTjxoRzGfbu4pf/5aH6OvGor4svoUgrE4BkOML0w0+xhJHAdDacXJbrddnNm8exaMzZmzqx9uVHmvYSoDKCRBFSJtn1Eo3vHnjUbdIFmpHVlapOVNWl6xHKVKhtqowEemgtH8nRcbbQbzC2zFP8W1RVmCFeqa7lef9KsHLbosTTbg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(7416014)(82310400026)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aJ1gKULJohKBmIm2aToeJF4US02lNrnFLTgORKgAEh1ZLaFGTXQbWubthEGApxKJ7lqeixMNiSU3kZhTCCxpqPBZMdNenaB1zSn9EvOJYHAbTlzkdlfahW70sjGfssvqtzYp2TA/6C08CLIJsvLti4qXrbX9v8oHqWkpKMKPuI0WV4L87yvB9Sh5WQSdabx11Q5JaivUdF8Hpd4nWncZNuKpmdVVFEL9+fbmLQmUMeECb8I7RCtxsVxCRusylSNCcKVz84v5TSCfnllEOISnZaXCEhi4C4WD7qRO8MrGf/UQ6f54cjluLnfqq6jFhnx8ulX20/yR/vhodcVmY4uCITsGLYNru+ggPF1vahuDB2T68lXymGnrbO4D+R3T+3lJDjVpPmt1YVbrfNyPU+DaPhd6qTEYKPum+Qpo5xGP4KYxTCkpdnoNoq/2j/AikKoa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:51:19.8445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bb334f-5680-4585-2ea0-08df290f885c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825

The global rapl_pmus_core pointer can be used after it has been freed in
two ways:

1) init_rapl_pmus() stores the newly allocated rapl_pmus in
   *rapl_pmus_ptr before calling init_rapl_pmu(). If init_rapl_pmu()
   fails, rapl_pmus is freed but *rapl_pmus_ptr is not cleared, leaving
   rapl_pmus_core pointing to freed memory. rapl_pmu_init() then jumps
   to core_init_failed, where rapl_advertise() dereferences it.

2) If perf_pmu_register() fails for the power_core PMU,
   cleanup_rapl_pmus() frees rapl_pmus_core, but the pointer is not
   cleared. rapl_advertise() then dereferences the stale pointer in the
   same way as in 1).

In both cases, rmmod can result in use-after-free and a double free.

Fix this by setting rapl_pmus_core to NULL on both failure paths.

Fixes: b4943b8bfc41 ("perf/x86/rapl: Add core energy counter support for AMD CPUs")
Signed-off-by: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>
---
 arch/x86/events/rapl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8ed03c32f560..b67986c58146 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -763,8 +763,10 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
 	ret = init_rapl_pmu(rapl_pmus);
-	if (ret)
+	if (ret) {
+		*rapl_pmus_ptr = NULL;
 		kfree(rapl_pmus);
+	}
 
 	return ret;
 }
@@ -939,6 +941,7 @@ static int __init rapl_pmu_init(void)
 		if (ret) {
 			pr_warn("power-core PMU registration failed (%d)\n", ret);
 			cleanup_rapl_pmus(rapl_pmus_core);
+			rapl_pmus_core = NULL;
 		}
 	}
 
-- 
2.53.0

