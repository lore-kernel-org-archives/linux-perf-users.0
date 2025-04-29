Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53806270ED7;
	Tue, 29 Apr 2025 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899253; cv=fail; b=qJoeKBoiv6jU4IgdsacEddoc5uzY2PJkCGQhPk1b4DMTZIuq9D13xBJINiuQDrg6gqhqYp+lEFLyT4PBfHnU5T+GFXlQ2dg0a5f+c3xo49sT191uPmIVf2qrm+BEyJIfQOYAF8nMuJ//tHmIlPLNKXI8z5HiEW6mLLPnSEziGYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899253; c=relaxed/simple;
	bh=SRfGjtHMDf5kt8oO3YSUQuGneOpuUyb3tPJO/rxJ45M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJyE0yoApsV0UjZcQhy7jPrcc6PWDehP4uEz16kaMICeYM2Z+Bk9dsZQ+YAQQA/ptNuZZKBiLciq7rFUNotD84JvdEYuzPThUp3KwhRX5hVYxSNp2DAWCueEJ/DpKLhNjQkD94CvujW5T4Mmf2XFOsmRss04y9ybaXHOSSM4Plo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bpzEdj9F; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bpzEdj9F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewwSTlAh34V1FofGok+Xg4EpbYVpTi85u74XzFJydZbtdTc7PrX7WJ8qx5WEcWi6rfjcDAXOHW/evn/1LrJDycjN09ya7m7FQBsrhC2YwfSHTb63NytSmt/5678gBiy9UGj+K0Xijde+NLY9M8Osbi1nP/P8T1Ia0j4nizkxR7PRG2hpMmSCqt/GHWkINEgglhUH0HvRvRBgdF9XUVokuKNFMG+o/eLKILb6x16I3yGj3IgnlpHlHkZINY9j8UgR8fXFDYudn/HEhIz5WvyV+T/7Fc3cxr/sv8lbJdcLqMq//4yT46g41mygOv3IUrI3m5I3sO3YUUDTlDhm80ATYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QTp/KC4a0jDGDJgHsArdBYT5uvGQGh0pE3YOjdGCQo=;
 b=cX137SRAGdLJmRGrQGk+jpP7QOQW3N5aMVX5+0E3DzhKESl50rWqA5VmgseyI8YXokYrhfNKZvlwyi/qDepIbK9ykQEvQMy2euHEJCpSa3VE/vOQJqX5hSFkJ35bDU/kYlF3oCzTyLhz3Iqa+ondym6kWAIe7gHeuqxk/XuYvQI1rP7Bwyh4Qli6AUVKfF4zlYJZmTePv8nnVoN1wlHQLWNuJ40cUyfXnZ17z98vvnEbWbzokSsR4NgpKWBLD0+tSw8Xao5m/qxkgfItOXk/ZgbaOHVmKC1rlLpzLq8CkSp6NIH1mn/DWKsIZfwLWZ0d/8lPuIQO0/5k4aR/MeZlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QTp/KC4a0jDGDJgHsArdBYT5uvGQGh0pE3YOjdGCQo=;
 b=bpzEdj9FgIQQxdlOpP+3HNfi/1TZrqF2S8mUsh3xv+frsLEYJerZ6u6rUF8Zvl45J3HzgpGPtXq6S/DlZ/zKLChcR6Gjz+PBAwl4ol0XEGgw3VjM/kEvJSgM52aFaLl46z5cKLTg8P5MlS+6/Ac82suFHLUVdcKMu3t+K3El3po=
Received: from CH0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:610:b0::30)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 04:00:47 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::a0) by CH0PR03CA0025.outlook.office365.com
 (2603:10b6:610:b0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Tue,
 29 Apr 2025 04:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 04:00:46 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 23:00:41 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Joe Mario <jmario@redhat.com>, Stephane Eranian
	<eranian@google.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
	<irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v4 3/4] perf mem/c2c amd: Add ldlat support
Date: Tue, 29 Apr 2025 03:59:37 +0000
Message-ID: <20250429035938.1301-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429035938.1301-1-ravi.bangoria@amd.com>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: bce6ef5b-1778-4273-87b2-08dd86d26be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O8DASZE8tRjnZJioGIM8HbohUk5QA2yf5mC/Wwi+qcwgAU1fM/R2RAep4BR6?=
 =?us-ascii?Q?/Q2VE1acEutyWfZ7DiuBYVDHd9uFazpp6wkEmVH8LlW08nfKYsFj9dv0894h?=
 =?us-ascii?Q?AZs1yHoOqyM/cn3UJD7ps6MVRyq/XmE1tIk5ImR4cxM7HTN7Y6AOuSaShlGh?=
 =?us-ascii?Q?gV+XlwUXKal/A7oQYT04rboj8tnJ/GWGMUiGCuwIyMDjQtkzqxWAclcC6ftc?=
 =?us-ascii?Q?EVg3T9Rh2rqN68lMMyP787izahwKBl/yW7+szG6y3IEgy/TwNz9/lJpb0Pb+?=
 =?us-ascii?Q?wsT3lrTxJkTVXKscUw3oczY7//7oAql4Z6FvO7R2qdJMbXyfLPU8c8+wYhJW?=
 =?us-ascii?Q?3r9cks7v+2gGIOKUPGMPPE5HDfYZQjZNG/xIkQMqlSQeiAlLHPWDZDq9aUWA?=
 =?us-ascii?Q?hvHktPA/Y2vqPPt5o75B1N9iN9XFc7X+UIJoPkcmtFaCDfgfYiiNiiwjH1uP?=
 =?us-ascii?Q?LdHTWhR9VVPNfDV3+J0zX41gBZkMssuT0qeKZy72LyTPhemmVpJrgjf8/nvl?=
 =?us-ascii?Q?C7CWF8CttPCfJ0fbYn8n+p5BNEiegeb8AqHqQHQmi6/UbGu5+xvMvpj2PwsY?=
 =?us-ascii?Q?/aMnUSLGgq+z5TUiHlp3pG5Hc9UixkVkoFluSHO/BzHvyQGI33UwAFBdUIIR?=
 =?us-ascii?Q?pgVkK5JX0zcRSj23H3dfV3CJajGPi9HNnvLzfdf3q2X85/41Off3Pf4Dl4Lq?=
 =?us-ascii?Q?+niZSBUxX1JXeKGKnFa9Nfe50gXD77eAg9LTjcLJYWmG8G4zRRyz7B8Qwhxq?=
 =?us-ascii?Q?Wae3mU2XwVzSw8iJJYHatA1iHFtHn8YZTEsrKlcicNBehgVhDRZFM4IkMnzC?=
 =?us-ascii?Q?8PanPikqX+pnhI0WCpV4ub7a6HwTue0r3rj0aV57VZZOdXLpxsIWOAQVwi3/?=
 =?us-ascii?Q?4NW00vvw91/FXo15NAmlaMAknlGnkkagQpoGQakzeMRi3wUJty7+qtI19DpV?=
 =?us-ascii?Q?u9qBG1GfE0V1q9ey2pxvUZU38BSN3eEHjm9osclOBRVhb8eSJtp4OEVBwXel?=
 =?us-ascii?Q?HcmvlzrKpd2fdx3InTvXtm66GV+4lHUuB0DZYvWNQig+F678Y42+C1oNxLOl?=
 =?us-ascii?Q?0/q8WX9LMj5ri9Ojcrte8s/nLY2v/t9jlJLt9DX5ej4gEWXVO4caCgNLKUdP?=
 =?us-ascii?Q?mr/aSrXMaDrY+4RZ0pCgU9SCV61mPpPUeW7wBbxeTd9YKIFTNuS4c+g7Z30c?=
 =?us-ascii?Q?qNpzLb98+e2//7P4y1JWHjtFSkSMn85+TY9c23wGhK45MOvGuYuFJecpB1qY?=
 =?us-ascii?Q?3EIKY0MMNfjgjhN9jBHhy9xbgZIEdT5BErg6nnluKZ44yCQRYs1kER3jO4Aq?=
 =?us-ascii?Q?JSXXOr4yc7jeSmNFF6n8uU6ykMYVg+VzKOz2A0Hi5it7jrDhMn4D2kFZFy7S?=
 =?us-ascii?Q?u5B3xEkffRfmgC4EZx2xU17U/9LUbiIXuqMt70V3XIGYNKoceUOqnXl2IrWU?=
 =?us-ascii?Q?6/fiUVxj+vaIQBX6lyvJIj9HrZkooL2FK+W8rmYAPYSsLfqdI9nXwQknqxU7?=
 =?us-ascii?Q?BwBlg0oGlZi+xRMv5fuLkTQphHYMUz4/Qz/n?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 04:00:46.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce6ef5b-1778-4273-87b2-08dd86d26be7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335

Perf mem and c2c uses IBS Op PMU on AMD platforms. IBS Op PMU on Zen5
uarch has added support for Load Latency filtering. Implement perf mem/
c2c --ldlat using IBS Op Load Latency filtering capability.

Some subtle differences between AMD and other arch:
o --ldlat is disabled by default on AMD
o Supported values are 128 to 2048.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-c2c.txt      | 11 ++++++--
 tools/perf/Documentation/perf-mem.txt      | 13 ++++++++--
 tools/perf/arch/x86/util/mem-events.c      |  6 +++++
 tools/perf/arch/x86/util/mem-events.h      |  1 +
 tools/perf/arch/x86/util/pmu.c             | 20 ++++++++++++---
 tools/perf/tests/shell/test_data_symbol.sh | 29 +++++++++++++++++++---
 tools/perf/util/pmu.c                      | 11 ++++++++
 tools/perf/util/pmu.h                      |  2 ++
 8 files changed, 83 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 856f0dfb8e5a..f4af2dd6ab31 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -54,8 +54,15 @@ RECORD OPTIONS
 
 -l::
 --ldlat::
-	Configure mem-loads latency. Supported on Intel and Arm64 processors
-	only. Ignored on other archs.
+	Configure mem-loads latency. Supported on Intel, Arm64 and some AMD
+	processors. Ignored on other archs.
+
+	On supported AMD processors:
+	- /sys/bus/event_source/devices/ibs_op/caps/ldlat file contains '1'.
+	- Supported latency values are 128 to 2048 (both inclusive).
+	- Latency value which is a multiple of 128 incurs a little less profiling
+	  overhead compared to other values.
+	- Load latency filtering is disabled by default.
 
 -k::
 --all-kernel::
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 8a1bd9ff0f86..a9e3c71a2205 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -28,6 +28,8 @@ and kernel support is required. See linkperf:perf-arm-spe[1] for a setup guide.
 Due to the statistical nature of SPE sampling, not every memory operation will
 be sampled.
 
+On AMD this use IBS Op PMU to sample load-store operations.
+
 COMMON OPTIONS
 --------------
 -f::
@@ -67,8 +69,15 @@ RECORD OPTIONS
 	Configure all used events to run in user space.
 
 --ldlat <n>::
-	Specify desired latency for loads event. Supported on Intel and Arm64
-	processors only. Ignored on other archs.
+	Specify desired latency for loads event. Supported on Intel, Arm64 and
+	some AMD processors. Ignored on other archs.
+
+	On supported AMD processors:
+	- /sys/bus/event_source/devices/ibs_op/caps/ldlat file contains '1'.
+	- Supported latency values are 128 to 2048 (both inclusive).
+	- Latency value which is a multiple of 128 incurs a little less profiling
+	  overhead compared to other values.
+	- Load latency filtering is disabled by default.
 
 REPORT OPTIONS
 --------------
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index 62df03e91c7e..b38f519020ff 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -26,3 +26,9 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E("mem-ldst",	"%s//",		NULL,	false,	0),
 };
+
+struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX] = {
+	E(NULL,		NULL,		NULL,	false,	0),
+	E(NULL,		NULL,		NULL,	false,	0),
+	E("mem-ldst",	"%s/ldlat=%u/",	NULL,	true,	0),
+};
diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
index f55c8d3b7d59..11e09a256f5b 100644
--- a/tools/perf/arch/x86/util/mem-events.h
+++ b/tools/perf/arch/x86/util/mem-events.h
@@ -6,5 +6,6 @@ extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
 extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
 
 extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
+extern struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX];
 
 #endif /* _X86_MEM_EVENTS_H */
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index e0060dac2a9f..8712cbbbc712 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -18,8 +18,10 @@
 #include "mem-events.h"
 #include "util/env.h"
 
-void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
+void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
+	struct perf_pmu_caps *ldlat_cap;
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
@@ -33,8 +35,20 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 #endif
 
 	if (x86__is_amd_cpu()) {
-		if (!strcmp(pmu->name, "ibs_op"))
-			pmu->mem_events = perf_mem_events_amd;
+		if (strcmp(pmu->name, "ibs_op"))
+			return;
+
+		pmu->mem_events = perf_mem_events_amd;
+
+		if (!perf_pmu__caps_parse(pmu))
+			return;
+
+		ldlat_cap = perf_pmu__get_cap(pmu, "ldlat");
+		if (!ldlat_cap || strcmp(ldlat_cap->value, "1"))
+			return;
+
+		perf_mem_events__loads_ldlat = 0;
+		pmu->mem_events = perf_mem_events_amd_ldlat;
 	} else if (pmu->is_core) {
 		if (perf_pmu__have_event(pmu, "mem-loads-aux"))
 			pmu->mem_events = perf_mem_events_intel_aux;
diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index bbe8277496ae..d61b5659a46d 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -54,11 +54,34 @@ trap cleanup_files exit term int
 
 echo "Recording workload..."
 
-# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
-# user/kernel filtering and per-process monitoring, spin program on
-# specific CPU and test in per-CPU mode.
 is_amd=$(grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
 if (($is_amd >= 1)); then
+	mem_events="$(perf mem record -v -e list 2>&1)"
+	if ! [[ "$mem_events" =~ ^mem\-ldst.*ibs_op/(.*)/.*available ]]; then
+		echo "ERROR: mem-ldst event is not matching"
+		exit 1
+	fi
+
+	# --ldlat on AMD:
+	# o Zen4 and earlier uarch does not support ldlat
+	# o Even on supported platforms, it's disabled (--ldlat=0) by default.
+	ldlat=${BASH_REMATCH[1]}
+	if [[ -n $ldlat ]]; then
+		if ! [[ "$ldlat" =~ ldlat=0 ]]; then
+			echo "ERROR: ldlat not initialized to 0?"
+			exit 1
+		fi
+
+		mem_events="$(perf mem record -v --ldlat=150 -e list 2>&1)"
+		if ! [[ "$mem_events" =~ ^mem-ldst.*ibs_op/ldlat=150/.*available ]]; then
+			echo "ERROR: --ldlat not honored?"
+			exit 1
+		fi
+	fi
+
+	# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't
+	# support user/kernel filtering and per-process monitoring on older
+	# kernels, spin program on specific CPU and test in per-CPU mode.
 	perf mem record -vvv -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM 2>"${ERR_FILE}"
 else
 	perf mem record -vvv --all-user -o ${PERF_DATA} -- $TEST_PROGRAM 2>"${ERR_FILE}"
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bbb906bb2159..d08972aa461c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2259,6 +2259,17 @@ static void perf_pmu__del_caps(struct perf_pmu *pmu)
 	}
 }
 
+struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name)
+{
+	struct perf_pmu_caps *caps;
+
+	list_for_each_entry(caps, &pmu->caps, list) {
+		if (!strcmp(caps->name, name))
+			return caps;
+	}
+	return NULL;
+}
+
 /*
  * Reading/parsing the given pmu capabilities, which should be located at:
  * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 13dd3511f504..a1fdd6d50c53 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -277,6 +277,8 @@ bool pmu_uncore_identifier_match(const char *compat, const char *id);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
+struct perf_pmu_caps *perf_pmu__get_cap(struct perf_pmu *pmu, const char *name);
+
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
-- 
2.43.0

