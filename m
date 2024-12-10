Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192ED238732;
	Tue, 10 Dec 2024 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823356; cv=fail; b=jr8jLvLXqCokU+j3IoUt+q9Fc5FEgVmU+UZ8HNz8c1O42EFAfxAMjhRb+uAHWhO0jiOwoR9BB5GRd57OZVGCz0o9MZm3L95DigXdUA82AfRuNMH/yDN0SNXcoDaVa8kh7VzAp7yCwfr1+K+UdmGWAp0rTBoGifzJjQ6WZtCZYjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823356; c=relaxed/simple;
	bh=6DUSl3hOkhElUC7/h6ai+56QchQyf6WiS+ilpvkxes4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jg6GHb17/7vHZIS8t0+wY5su/EmZW1j4Qxf3N/rSE1QEBHmGcZZpjGs7bFN1QPHN/SKpOfqPu+sc+5/AC1Xt1JjvzDwtmvaIDBOy7bWbnj1PD1veDeAeXOU0YPQqfrtSX0EW1Oz44i+K/xADn73wPXH9FNsmhAfRxarSzEsmIuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hs77jbZ0; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hs77jbZ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGICtJo9Fmjsn8gLsc595GHue3Ilxomfs03+T+sGuGBGheQV/i1361LLt6bNAyJexNGQjzMUsOJHA9SN/EpViUJl9Pj0f+PhCsEBOty64Gp9O6AO+J1ae0/elXL7JJLRxdV1gX5GqoqPn/mEqu6WW6qQHEKkJ3hWIPlru/03aGptqWxEI+ffHeW2gNEuGzFOed/BwnYas5SDIdTYPf4TBylvA54ihKwr003ugv9n4p+cU4M/jkc6YMr+8WOkRTIkb+TqE2fQuXJomHm7kaMZxNVSjxS0GFMgFQK3dhbHvbvnZrATINxV29kC2b6kOHFPpWVvaPWzeVl85y54XlLCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OngcRt5TyTocHT4x/EO+sj96PqNmn5WHeeSVujNmMaQ=;
 b=pNS4vIJB8iJGsNWYG0yXjiDvAli0vlzspQo2yI3zxsmhqTeW31Z+qUJoyDh63JX2/JZb2dhOn64MWmW+jdi0YkW8PdjuXHBB2P4T9pwsRudARlrMX5qSZW6QbyEUBzrdEXLB/3JYZV8tmtQFqD+4jPbAzWqDh5K1o3wTvlkMak/cHkA9HOMQGjne6tzKa0YFu8MxzSKqM9EKM+fwmBYTKuTNaFKYJqet5lAaC8aCBP73ibLbmgCQ+LfOHUz+OXYKEBC4vkmRIl+AeRQJAvHNBT0ytCxCDSdr0QWps9+hAeTU1il48NeA4tnfY9dQ7cPI4+AaJY4yx06VCmOFVvh+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OngcRt5TyTocHT4x/EO+sj96PqNmn5WHeeSVujNmMaQ=;
 b=Hs77jbZ0gs+t3v8d/Jolv1ukWnNzIqHO/p9rCXe9Ew3vao6PoAvUxyqw3oO3CMVmd3FApFRhKrI/BvPPhcWi4qP7GeJ+88yZZxLwxtG9TeyzSuQIeD9lYcDJ/C6v0UcKJ7GxOj+RgfHLRU8K/nSjQ8x/dkD+Fbtdv6wvI1pm1Rs=
Received: from BLAPR03CA0080.namprd03.prod.outlook.com (2603:10b6:208:329::25)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 10 Dec
 2024 09:35:51 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::39) by BLAPR03CA0080.outlook.office365.com
 (2603:10b6:208:329::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 09:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:35:51 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:35:44 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 06/10] perf/amd/ibs: Add PMU specific minimum period
Date: Tue, 10 Dec 2024 09:34:45 +0000
Message-ID: <20241210093449.1662-7-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210093449.1662-1-ravi.bangoria@amd.com>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 23933f46-d93a-4422-5631-08dd18fe0933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X2Tal1qrLambz52/wJ2qgxslLCQHsaoyMAPPppjdSFb8AS8uEK7fbqk7dWbj?=
 =?us-ascii?Q?SINjjAFKdy/sAlck/Sa5V+jiG1JAzghA62HAnDcWakO+7kig7kIzzfcxLJLH?=
 =?us-ascii?Q?Tm+ZwpOpJwWO9pKhJa68C8KDgjWMsfFI+pYdfRbXaBvj8b1LcFUtnGEKfjEd?=
 =?us-ascii?Q?3CoILWpVpf0a2pSeTebWmzwcBRmSZx6OKt4/suoQANWLF7uNb4mtlNxgZDFR?=
 =?us-ascii?Q?JXQX5KPksllcgGHvkZ7KHtNVN+srkUHIDDp5yGPf5FaX+5nstriWq7cL6BKf?=
 =?us-ascii?Q?a/2ZY81X1S9uddukn9KtaZZKv98EUnerEKwbAo6oUc8umD5Kv+YcmwQ2EgfT?=
 =?us-ascii?Q?vteYTJp2oPArT6aXgn5T1zFJ1gOorJw1Nb9cVNWmrhlRtHA2KXSKkMGmLtQt?=
 =?us-ascii?Q?lGg5eXklbAHFBacSnkIWSebZ6b/vKRIvtoU8UrB9mg/AjShjASbjxCVaFKgs?=
 =?us-ascii?Q?hOLAo4+XI1oSsmLR1wKfbQmXOVQsddpgAwqZ9cu3e2dERHPaVONxOVp4wOaE?=
 =?us-ascii?Q?PD9npoQb3dwSQT/LxO46GqE2pFW7yFEEim3zrltOabTavcf9fdimKzA9GYiT?=
 =?us-ascii?Q?ETpg07bJfAwrpStJrt59H+MeQxzogmlsKB9Wj5xTYJtKVOx65SYPMRi4m6QD?=
 =?us-ascii?Q?YkgpL1qgLCZtIej3yhMqTszzBk1j9t6FxOr9jvgT2HUM13IFizfuMO+6YOV5?=
 =?us-ascii?Q?saCFVIyV4w36T0J2oHejcgeqwLHCPCF42mCccX6GMBWQnZ0/UbThQzFcLd/V?=
 =?us-ascii?Q?dta8j6daiw8qgFUtVlR+ackBTe9mhJ/JxwNE41EvDlG7Yh0raAEesETODt1b?=
 =?us-ascii?Q?mkZcPi0ZsHpZjfweFneUaQxuyOFTWa73ThTxOQYO+qaog22ypPnB5SvDszzE?=
 =?us-ascii?Q?EZX75dRsOQGy6yR77mTRKFlDz39OAjgEWMv5TSvZy7U8HTws5rerGVJ+3HCF?=
 =?us-ascii?Q?/ZVKJ/gVpMAiRQcpVCVJuqr85creWIVTIHjJcAkKePM5gChMqyB3qleOjug3?=
 =?us-ascii?Q?un7uorJk1y4GlRcWwFmI0h36VI5wM2qoDTzEDcQpF6iSDBx+tWTayyzx6Bdg?=
 =?us-ascii?Q?uoL0jz3992KtL6zUhsQEj9+IA6tnu8pggiltsCCmW/n6/mS3UrXSYkSSNwXL?=
 =?us-ascii?Q?JMJ+H366jxoiijyVv4wBE5CHwo5R2vxa1tsYPRBqRz2BbZ8Gv2Qkvxt8PgJO?=
 =?us-ascii?Q?EWjwb7EdHaFBTs+qBkfN2+JuTm3Dnx9NkUCEBsf8eCiwFUxRRb3BrJKuJZEQ?=
 =?us-ascii?Q?mKHs38SkhaKUqpwekd+Wi9JaPBoQ5bsQfaYElDx/FgyKczz0f46QXbBLO2xv?=
 =?us-ascii?Q?fVkeZ/faT0cvn5/16L4/jU4KYgDrrqZsxRo0M5wAplNeu+OqNL9kHX08obwa?=
 =?us-ascii?Q?boT5ZzJOTsZtRNBznHrxfPTiN9JTrmHXLaqu/r/Giwq10giZaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:35:51.0972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23933f46-d93a-4422-5631-08dd18fe0933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116

0x10 is the minimum sample period for IBS Fetch and 0x90 for IBS Op.
Current IBS PMU driver uses 0x10 for both the PMUs, which is incorrect.
Fix it by adding PMU specific minimum period values in struct perf_ibs.

Also, bail out opening a 'sample period mode' event if the user requested
sample period is less than PMU supported minimum value. For a 'freq mode'
event, start calibrating sample period from PMU specific minimum period.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3e7ca1e2f25e..7b54b76d39f5 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -86,6 +86,7 @@ struct perf_ibs {
 	u64				cnt_mask;
 	u64				enable_mask;
 	u64				valid_mask;
+	u16				min_period;
 	u64				max_period;
 	unsigned long			offset_mask[1];
 	int				offset_max;
@@ -308,10 +309,14 @@ static int perf_ibs_init(struct perf_event *event)
 			/* raw max_cnt may not be set */
 			return -EINVAL;
 
-		/* Silently mask off lower nibble. IBS hw mandates it. */
-		hwc->sample_period &= ~0x0FULL;
-		if (!hwc->sample_period)
-			hwc->sample_period = 0x10;
+		if (event->attr.freq) {
+			hwc->sample_period = perf_ibs->min_period;
+		} else {
+			/* Silently mask off lower nibble. IBS hw mandates it. */
+			hwc->sample_period &= ~0x0FULL;
+			if (hwc->sample_period < perf_ibs->min_period)
+				return -EINVAL;
+		}
 	} else {
 		u64 period = 0;
 
@@ -329,10 +334,10 @@ static int perf_ibs_init(struct perf_event *event)
 		config &= ~perf_ibs->cnt_mask;
 		event->attr.sample_period = period;
 		hwc->sample_period = period;
-	}
 
-	if (!hwc->sample_period)
-		return -EINVAL;
+		if (hwc->sample_period < perf_ibs->min_period)
+			return -EINVAL;
+	}
 
 	/*
 	 * If we modify hwc->sample_period, we also need to update
@@ -353,7 +358,8 @@ static int perf_ibs_set_period(struct perf_ibs *perf_ibs,
 	int overflow;
 
 	/* ignore lower 4 bits in min count: */
-	overflow = perf_event_set_period(hwc, 1<<4, perf_ibs->max_period, period);
+	overflow = perf_event_set_period(hwc, perf_ibs->min_period,
+					 perf_ibs->max_period, period);
 	local64_set(&hwc->prev_count, 0);
 
 	return overflow;
@@ -696,6 +702,7 @@ static struct perf_ibs perf_ibs_fetch = {
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
 	.valid_mask		= IBS_FETCH_VAL,
+	.min_period		= 0x10,
 	.max_period		= IBS_FETCH_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
@@ -720,6 +727,7 @@ static struct perf_ibs perf_ibs_op = {
 				  IBS_OP_CUR_CNT_RAND,
 	.enable_mask		= IBS_OP_ENABLE,
 	.valid_mask		= IBS_OP_VAL,
+	.min_period		= 0x90,
 	.max_period		= IBS_OP_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
-- 
2.43.0

