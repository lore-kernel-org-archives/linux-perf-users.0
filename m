Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D607122B646;
	Fri, 25 Oct 2024 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854959; cv=fail; b=d/HzZ96BxRMJUFmlV9RK7dZVOLbVCsRGyXIpW9kjkj+WEFWKvohg3eU57tqGM0SaeZE/bcQQ5sTouQwEJIFuwa7DhdqqR2IgwGsI2cuvWh7sKowUAjOZX898H5l9SQQLw8EuynJbRut8eyE0IJEH1zlP4d0JY7zrS5lmsZ/O3hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854959; c=relaxed/simple;
	bh=bg5/eg4HNRCp22JowWvBi0KmVZ26FIoTTwP1h+SDKGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnILKd6wAho6b0rb8AnjWOUCZ4vjP/k2TNJPtV2WmqNcrKhKNHKjX5mpsluf8BlctlecxsRe2UJGsuC7SQGfOyAgd2odkQWJAVkkBykLQTjelOUEvSL7zPIJ+DM4DfTucbwW8xOTxCLPZhcINhqEHgLY8aU2Cu8lYnz8S14RKKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=msIcX7X7; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="msIcX7X7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1rv3Q07yho9vE0hBwbtZyxVLsnMcWy9x+NvAChlR1v1Sf68Icl5giFdyYRujpp+KVRnd8Ff/byghTPPhFSrPPUGqH1SZfs8Bgh7nqG/iK4jp5KLSGMpxtMjrn5PhwUy14o5ih6j1z/ONTJWFYK6boz6j+4GTouFbup6Mfymy2YxIPmBJhJALTVJMwQYQH1a0hoO/qTMp7PRg5A6CwznOj1d09v119MdH/Rr5yeYPKxQnA5RNMxZFXZlm8E33DJRLIjoj0BHjYIvjL24hf0ubb/QQr/OOvDqbRvIqeNZf48JG/EZrkY4frWx4MxBJYGGZCHOiIP3SFSnPtwgoerpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vZdDWyxkGu71Ke4NPvGevPKGbK6QIzSyMyUHR24Dfs=;
 b=RjEKXw6v7BCVjS6N7PLX605eVsuYMe9gVZ2rF7hOsQaFZ0FeDsJE6MfUOqlxnzPOjx37izAuaeS3v8uemsRx1IGfmTO6tr9JZ/gDF5nn53J73SxjsV90w+IoMiX+m3Qo5Dnt4+NiUfJqKGycBjBggIqLU+aJRfMynmrzcYRtNrO/TXXd+3VJcoeuoQ06iadHDIXlk33tPjzpB/EEdrOo8Fuu/s7rhkv8UdGU7M25tXLfZcJXtQESp1PLgpotOr/Uf1KZ4h0U+1Nr05ri2f82SDmYTWsiNZIZXQRFnL4mK2At0or92V4LcX63H4rNROGakEPpV3keq2eZTPV51Y9gbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vZdDWyxkGu71Ke4NPvGevPKGbK6QIzSyMyUHR24Dfs=;
 b=msIcX7X7m0alBpty8wbO1js20xSKfHmKivF/EDJ2AFLRZCibfvZKr2OoPJZVKKMBaZN1AEF3aWvQ6nKQjMu9zrK2v9H8POBAW/wNIgUIlNIkDkwf9CXmuCE52iElMYsRf6KLLEQKoH31bX/qFEJMaM+tEdV9jL6wO1G/DC+TVMQ=
Received: from BN9PR03CA0713.namprd03.prod.outlook.com (2603:10b6:408:ef::28)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Fri, 25 Oct 2024 11:15:54 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::cb) by BN9PR03CA0713.outlook.office365.com
 (2603:10b6:408:ef::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 11:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:15:54 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:15:48 -0500
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
Subject: [PATCH v6 05/10] perf/x86/rapl: Make rapl_model struct global
Date: Fri, 25 Oct 2024 11:13:43 +0000
Message-ID: <20241025111348.3810-6-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6a480a-903b-466a-f0ad-08dcf4e66479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pW3bjVtIZxC4isrmmIVWPBIitFkZIIzINvk2F86QZg9UJjvZelIL0DrzvOcJ?=
 =?us-ascii?Q?/iSmXkp0a2NO8AO+m37f1mvZ4zns8qGpfFeZ5v0Vy2eRVlWMrUhArbJrBrbf?=
 =?us-ascii?Q?nVtdIYSbuDG4zXvGT60b2ijXPSISPLuGU3mtMuo7Wuz+xZemYlu3xHY+ob9s?=
 =?us-ascii?Q?DW4bIV50UQKC8OlHQ3AjXm+5oW1CkCR2CW0mN3b3yBcCCGqWSXXGZ+vR+Sm7?=
 =?us-ascii?Q?PxUxPSHBbPFRXgjxG3HZ5V8qI8gelvzgiOz+DRuD7NhKvYDk7+MGz77gcWJz?=
 =?us-ascii?Q?mvlmVRyBL0HA3TdQHgj16VXB030dY2jRHxllPpclrNLCvN3crVCnZfGtaxHq?=
 =?us-ascii?Q?elTq3YozLvk9wCF5RWzYbtP5weRwRE65aDmhl1P8ZKYNG3gIwwUMzdv/OwfU?=
 =?us-ascii?Q?Cwqt5Z4b9dtwUOSeksw0vEX6EYTOIuWdwxjJx3/UpO4Gum0tahcDPNBLzgFf?=
 =?us-ascii?Q?Dfdq4WrgHboi2mBqDT8LpqrZz7zPbmYpzbX6bOIw+pGIJ/pN/US957sawZej?=
 =?us-ascii?Q?Od1jrxjIYgQa8K0t6CET6cfgj1cHAIJnoMqF56tamNFGkvct7deTvePZnjZH?=
 =?us-ascii?Q?Hh9smvRgQnPD5jf8PrV3NGdZHBgAFnFfWUxE5x7ujozntSI5UPSbNghe2UY2?=
 =?us-ascii?Q?xquf0nDeX2+yXialrdiCffJbaY1mVSnJccgbvNG9HhEEU5qrHVkpncf5ENcq?=
 =?us-ascii?Q?P5Dn2IeAxc/x74hZ9EyJ5UVq7V41h5i7y6R+xw8E4S5yN5fBHQjsZObfv7G5?=
 =?us-ascii?Q?IknK+0s8NpJVuViY8MJ+/2ZbUoJFB4GEeCuyPw+9UnyD5T9VegO277PLZD6E?=
 =?us-ascii?Q?d26d/znKvAkdQl6NZa/Au9eYnGoGp/6QSk8kl5x4O57pfvbUkndxEg+7iciW?=
 =?us-ascii?Q?l7sRC0KTpL+rplrhRl55wt6FfRIpSLL9zW6Iw2pJaoHTRiauW5THnrqq+PIP?=
 =?us-ascii?Q?0aSwKf0WxPoWZPC5jiU9kePtE2bMk9Rv1dMJU8L6kVc1zDdhPgDxdCU5EiAd?=
 =?us-ascii?Q?WroU0sk38UTM67Q6mK++fm8AhzMkiUIML242bGHE9K+3l66AbmefFkYuF5lp?=
 =?us-ascii?Q?eGO4c0ADc+CrjnT9wYxgrgQOZE7+9IRNnyw+iuulZpvU0OPkpLZv2LJCgxU/?=
 =?us-ascii?Q?8/UTsf24EirqRLk79/tjJcXARf/JJhX4z5R44JLs6ZcFVrBqcKGMViUXrWT3?=
 =?us-ascii?Q?LPvkAvNdjUkNWqtp0iQgnBp+9B9dmBwKSOkC7zjNbp3WmhFZ+1ILTaqJRk4h?=
 =?us-ascii?Q?h0o5lcBNdVf35g1/7MQQO+50MtwLNeKRBXVjZKpJLjlbzwDW0pAarwBBCxuq?=
 =?us-ascii?Q?80ay9v1Lqasj+9Zlf07C4ro7N9ePXH8ohMTCyEzX7vELo6SoYsL6y7Qe5Dwp?=
 =?us-ascii?Q?QazdRh+TwsnSCn5Ywgaebe1bFySzZ3ZHy8yMfffMl9kQeNFS5Lmu3RCCFdrS?=
 =?us-ascii?Q?6zISee3zi7M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:15:54.4511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6a480a-903b-466a-f0ad-08dcf4e66479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

Prepare for the addition of RAPL core energy counter support.

As there will always be just one rapl_model variable on a system, make it
global, to make it easier to access it from any function.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7387bca95018..447f62caa5f9 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -151,6 +151,7 @@ static struct rapl_pmus *rapl_pmus;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
+static struct rapl_model *rapl_model;
 
 /*
  * Helper function to get the correct topology id according to the
@@ -536,18 +537,18 @@ static struct perf_msr amd_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
-static int rapl_check_hw_unit(struct rapl_model *rm)
+static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
 	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
+	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
-	switch (rm->unit_quirk) {
+	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
@@ -792,21 +793,20 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct rapl_model *rm;
 	int ret;
 
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
 
-	rm = (struct rapl_model *) id->driver_data;
+	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rm->rapl_msrs;
+	rapl_msrs = rapl_model->rapl_msrs;
 
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rm->events);
+					false, (void *) &rapl_model->events);
 
-	ret = rapl_check_hw_unit(rm);
+	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 
-- 
2.34.1

