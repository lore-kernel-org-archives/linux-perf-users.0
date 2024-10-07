Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604451494DA;
	Mon,  7 Oct 2024 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272989; cv=fail; b=VEGyqg0ps1egOtMUq6MpQuuzDuj4kRvEESf+3JZbo3hayYzZ5IK3YLHuxEdUYwS7Y34bQlKM2SPc26MEmeC2sjHSGMHF5V7Kb3lwwMxFQBkuaKktaHDJKcWW8PihT3gdRch0l8S0yNrnc8Jusn/RHigM1RjbeszkVVv5EcXpTfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272989; c=relaxed/simple;
	bh=nsqK4EpiT/Q8gR3v2qrpNaT32QRNnnmlY61Ynj/UmfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4IALYt+NVItXLc+NmKqlsaHeZc1feZqR7u1re1kaaFwpnbWMJq1SJNMEzy8zy3OvzGVUPeZR0iSvRIP4rBBxMQx5soGOUyAry5hYfd8D2tgpa9nQbrgKQ9L6lkzgir7YQnVnPHS/0vGy7ACopZvjnCZJn7gX2IN1bOw5AmECVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=foW8qyCH; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="foW8qyCH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNajlOPsqzs/h5uC39CVyzmz/2Q2c9rKfAjO2SmFsueKowbb+fRqCWxWpXsHEyGRgVQcR5nbeFVdG/M4B1IES8+XCH/uqVH4I31rb4J55DGggjr4rNQqWvRS2QyNV8JxO6D/zHfpyx0/LcaGEZ8/sXku2cHf1TaCnDYck9FulQMVjcYUAk8ysIrlKvR/FzGPcXsF3vykD5zptkY3gOFYchCvshUZijkgF9yGHfdHcPA+8I8uAWroQN3FGs4D6t262Jjua/ug9W9h9XlgFCcYOdu2nYaanOPbimNUtJkocPYDXwFE0s5c8sgbz1X5b8BfrG4EdGSPR9bbeHJAwI+3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4jc4bd2dHrtEzClo20dtDdU9tmZDGmRQ+fMvM/KNQg=;
 b=zV39s9VpQ4kkisP/16GfUraW/XYnx9IywYD3kq3L2f0a5wYU0O+hcmULBCOXEoyodXICYd0THCHtdG/Cbl7xT03LA5kJ+97nC1FL5PFueHaXu4u+NcAdDx4IJ98JoufwbWJ0DaZHqA7lCB+pYxYynSIti2j4ojMyje+ncZmEwOiU3/nuh09otzP+rbAwNkPfYLJL9CZLMmXkGt0f9vqFpgtfj6S8bBrHrXWa6Pcrk8KYi+rrvFFSqQ3+HaKEXPewbGDZk5Tfe2XB+Ak951Z872L1CEtenBxwKYFmfluyNyzHg7Aod3dqg2nkrwEXM7GfaJkwe/o5X2pUdWVM2IWSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4jc4bd2dHrtEzClo20dtDdU9tmZDGmRQ+fMvM/KNQg=;
 b=foW8qyCHq5ut1WKoSGyP5XyAF+S6dnWPt0uEqeuxKp0NIzzlnFScQglcFznpymCShaVc572P+HvjLfyszvkve+3rqIGmOz48TUJ1ogrGuEKxCDamTxgRlvJE9PrQ0vIrO57kBXUpszDcGc9XJdDnRS2UHLAM/ymPH0GqXgQKPPU=
Received: from PH7P220CA0140.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::17)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 03:49:42 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::eb) by PH7P220CA0140.outlook.office365.com
 (2603:10b6:510:327::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 03:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 03:49:42 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 22:49:25 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 8/8] perf/core: Introduce pmu->adjust_period() callback
Date: Mon, 7 Oct 2024 03:48:10 +0000
Message-ID: <20241007034810.754-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007034810.754-1-ravi.bangoria@amd.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8030c053-e09c-4197-2864-08dce6831374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l+skD3SG9O4O5Adp0Kmb6/swwpt0BhgWMXck/4zjJx86Uv8PXPcLMXU4JgZf?=
 =?us-ascii?Q?X8MrjFz/2vKImGbWOeGXb9ZcEwBqQ+jh0ofqJnCHmH49Az+o6HFJifjNvZ6j?=
 =?us-ascii?Q?hD4dhIiEyIHgRFTTC7a6gpl3kjXzGYuMlo/ziiqSzbmr/yDSU3b0h50jEjSz?=
 =?us-ascii?Q?HrBLLenkb5g5+WJp5D8btI9YvJczyWWOvtaqMoCFffmmni1KFuYg6GJYA/cV?=
 =?us-ascii?Q?0CfoJKJwIWLASEd45Rv7+DCeBCYBsiGpwzCO1A37sqS+ZyqDgFRtfVLIvZ4M?=
 =?us-ascii?Q?J+HgX68w1vrlMKm0bYSwqdK/zXn3SXbezTjGP+wzRUW8OmM7MRNxTvURsGag?=
 =?us-ascii?Q?MmVGEzLlEf3Bk5q4CptRcOy8gR/GXNaC/5/1XgJdlhO/Z5yUy9HDHW+kX++H?=
 =?us-ascii?Q?W/s0fj+ouBJmAy0w9MZUiNsMgO701mWSK+/l/og1XbTvAK1yd3t1IkNZfYVT?=
 =?us-ascii?Q?gVyDk2nWMXetObUxfeswv+tv7a6jxZBhWsRj/Epkq2jTiDQjg4Ot2nytdx9k?=
 =?us-ascii?Q?NyJoIN4s5PFuQH4ImwF+LnrEAAhA9eb0InH23+b4t//Q8tM2MBF4ThF0V1lD?=
 =?us-ascii?Q?DEsgs+lj5BIbAVIj1A6BKFze5HrK/iIRspHbXLiBUE4zmMrtik4bKMeNC4dc?=
 =?us-ascii?Q?axI+F/cYu5wb/et8JyKGrMcnZo+v5prlbDWl5N/6TXHZDnUhVTf6w8aD32n3?=
 =?us-ascii?Q?9+HKOLO2/JaFLL9Dh5sJQibx07MZpnKJYXLsgats1VYHXqJJLnoHwQOKHKu4?=
 =?us-ascii?Q?dJ+g7DsnxDoo6828g+i15saif9bCE03oyPRIwPxe58ejiHlia1Wf2YG0U11m?=
 =?us-ascii?Q?UO5eIsv+D0G3oYLrPZrRBOSU6rO0XZCH7VEskcwOG+q2mO2zO0c/mJPgApnD?=
 =?us-ascii?Q?2kTKWgqBgwXeyxYt28Vx2XW7isQoYBU3KqGEruJbSiUTrr2YA0tGS5VVPuxD?=
 =?us-ascii?Q?7xrP5uXyJmohEf9o5vygzWiG0oLpKr/xNGu1OjRnXW88+vhzCcnFIkMCkA7S?=
 =?us-ascii?Q?zBoU5W09GlRzDAWYlOZJkHIPBAve+v1ey8zUXOTkLn1JW8hCFRdVq3+wgbFS?=
 =?us-ascii?Q?T86S9g1A69txTDvHWE/0spQsNbWrASFCXF/8sfcxGP/5ef2mXzDjUN3ktOs0?=
 =?us-ascii?Q?QxwzQwQVdQ72GcvVc32TD9ZeX1kVwFcZKo4s5EwaxnRjhN9XHft1axyTF5ZJ?=
 =?us-ascii?Q?BUYg6sohVslkUSwCFSfAi6yfhFZ/Cn3pMtI07bRf34QVrf/OR9vdN8FG1lCC?=
 =?us-ascii?Q?1h00Z2SuU2hWF2LfoRIbyUnIcit2FPVYDchtuTlH2K4oKycWUnGIq3YaUlUv?=
 =?us-ascii?Q?tmULEH3j66j3/h9ZQiZj7SlUu9egvUXrmHD5CncOVpiePXtK4G0tkj/gWslJ?=
 =?us-ascii?Q?/nuHYTvd22DQHFtM9OYPQ4r7OdZ+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:49:42.0470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8030c053-e09c-4197-2864-08dce6831374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407

Many hardware pmus have constraints about sample period. For ex, minimum
supported sample period for IBS Op pmu is 0x90, the sample period must
be multiple of 0x10 for IBS Fetch and IBS Op.

Add an optional callback adjust_period() to struct pmu to allow pmu
specific drivers to adjust sample period calculated by generic code.
This will ensure the sample_period value will always be valid and no
additional code is required in PMU specific drivers to re-adjust the
period.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c  | 11 +++++++++++
 include/linux/perf_event.h |  5 +++++
 kernel/events/core.c       | 12 ++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 33728ed6d7a6..0d1db2fffc5b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -573,6 +573,15 @@ static int perf_ibs_check_period(struct perf_event *event, u64 value)
 	return 0;
 }
 
+static u64 perf_ibs_adjust_period(struct perf_event *event, u64 period)
+{
+	struct perf_ibs *perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
+
+	period &= ~0xFULL;
+
+	return period < perf_ibs->min_period ? perf_ibs->min_period : period;
+}
+
 /*
  * We need to initialize with empty group if all attributes in the
  * group are dynamic.
@@ -699,6 +708,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
 		.check_period	= perf_ibs_check_period,
+		.adjust_period	= perf_ibs_adjust_period,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
@@ -725,6 +735,7 @@ static struct perf_ibs perf_ibs_op = {
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
 		.check_period	= perf_ibs_check_period,
+		.adjust_period	= perf_ibs_adjust_period,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..eca8581d8e5d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -540,6 +540,11 @@ struct pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
+
+	/*
+	 * Adjust period value according to pmu constraints.
+	 */
+	u64 (*adjust_period)		(struct perf_event *event, u64 period); /* optional */
 };
 
 enum perf_addr_filter_action_t {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8a6c6bbcd658..f3de683ec716 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4100,9 +4100,9 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	if (!sample_period)
 		sample_period = 1;
 
-	hwc->sample_period = sample_period;
+	hwc->sample_period = event->pmu->adjust_period(event, sample_period);
 
-	if (local64_read(&hwc->period_left) > 8*sample_period) {
+	if (local64_read(&hwc->period_left) > 8*hwc->sample_period) {
 		if (disable)
 			event->pmu->stop(event, PERF_EF_UPDATE);
 
@@ -11363,6 +11363,11 @@ static int perf_event_nop_int(struct perf_event *event, u64 value)
 	return 0;
 }
 
+static u64 perf_pmu_nop_adjust_period(struct perf_event *event, u64 period)
+{
+	return period;
+}
+
 static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
 
 static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
@@ -11641,6 +11646,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->check_period)
 		pmu->check_period = perf_event_nop_int;
 
+	if (!pmu->adjust_period)
+		pmu->adjust_period = perf_pmu_nop_adjust_period;
+
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
-- 
2.46.2

