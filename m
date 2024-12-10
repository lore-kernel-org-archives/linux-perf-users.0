Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368F2080C5;
	Tue, 10 Dec 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823369; cv=fail; b=MyhlsvbIqNhYTo86sads9z5tSTCvZQKm5oZexHSaAzygnGw9KsPRTN8SMkkW96egBS5dUS0uK/M64UXs3yYTbyBiL5yv9K78rMOOjs/XxwOSgkNdcms86dHpU9YAB54mV5c1lOieAMDzGFRdIgJEINZwFfPz4lbMnyhzabJExkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823369; c=relaxed/simple;
	bh=ef6uWAO2V8mdUZUy94/vbZPIN/G86x3iyNhkUcQ5MHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJ8ysU3wzu38ML7+hAn9DnzmPkwSkHmmx6ttWaxfQRuOL9jyqaVGKg9XnVVfSJsampQ7ainExxuzDkN25NqHM1QnMgwUtsYxT6pGxr/fyfMe1la4iqWpFyxvgy3bUNgqDH9ROMrO5SiYttpcQK6nIwheOYTs7FXQUieYCtncI8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xxZFNEEu; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xxZFNEEu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D70WXdzgv+l3pEYCPKRq3hm4LZ8BFrYBp9rvcZ8VybrRYItJ8T7Yvwa5rFDXfO2OK4ethkxb2DHM5cr4B+5fZOVPri0LZMuD2+AdUhfmpnKIrgZJY9orLg3Pbbv2sl3QVxUO76kiTv+j/sLF0yy+Phr481x91IGmwEOxLadspSqv4fjabbymWbZ0ZHlqVtNAa1/1YXaXtTfK88Ll33Yt6nIYKrGJBfIiFi7+0BjmA7AkhQIlL1V59oN8GyiTD0GFUTPwUdnIXsDDJASR3H1IeKGUBcb2Imbs+8Si1Q1t486j8NWcZRsruqMxLW2VHlAT9SwydX7GmpLF/jioR0hdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePMNRwKyiSsA1gn+/WRfWye0ct5yXvD7Nkg/J2TTYmo=;
 b=AGJ6nVQ3eE8lENlCZ1SMEnldcEZMOLxmPzJFEnJ6lfuHLqU29ZocRzpQVX6omzaiTzbP/Xq8QyOUI+bXB9x3mYI0paMC5+HvOL96/F2y3dnGgrrM5T09Sb+fmrdEmebLflRgMoOB9K0DA26X19afu0jn/44pdis6ZZCuBjvqxVFCEKcF/XBsZoxPFXoh0PvoglQaFROYkNaedW/7AhAN6ClBWf5sInr2BoklqnUH1b/WW5F5bZb7C2RORcXU6PaEAnGBUbOLkZGpaM9e08HZYSvCNP8wN8ICuJfqfasCDGC06OOni6H4//MBAAjU3/oAofPbpYv2nl2MwCDxJ3xBOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePMNRwKyiSsA1gn+/WRfWye0ct5yXvD7Nkg/J2TTYmo=;
 b=xxZFNEEuOU6H+1et28PTuZE4meF2x3p84mnUjNR2Zbbf5iPu2AmYL0YNHwiUxRnZ1+Vw2QM+fJlF9XMWqY97o2JSujkjQy4ln2qoqyfXyC8/X2L120x2wjECmj3cCSZbkrOgBYxPKYa+7wI2mxE90t4CoZ0wHqzFQsXQOhZLEUI=
Received: from MN2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:208:23c::17)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 09:36:03 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::11) by MN2PR18CA0012.outlook.office365.com
 (2603:10b6:208:23c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.20 via Frontend Transport; Tue,
 10 Dec 2024 09:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:36:02 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:35:56 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 08/10] perf/core: Introduce pmu->adjust_period() callback
Date: Tue, 10 Dec 2024 09:34:47 +0000
Message-ID: <20241210093449.1662-9-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5af772-6e1d-441b-1d59-08dd18fe1043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gto650qhIQg11DkS42u5jxdY3qCmOxT+XUC4jxe850y/8qPlcWnYVD3s7JIv?=
 =?us-ascii?Q?siub+iWX7qpFNIHFWujrx5c+npJcH79DahQqe2IxHdRMaGHL6dlveOvkprx7?=
 =?us-ascii?Q?NlQLXnYYCtc/zuPnyGK+FNrPD9K1tWyhg2tBrPWfk2UEvQBBXCQ04pJuOxhs?=
 =?us-ascii?Q?m+FE0is9y3JHig3ncz0hiITXmSDBT7TCuRrnQAt6/F/6n9XqTJX8TF6uDzg0?=
 =?us-ascii?Q?uivgBuJtH+pqB8oS7AmV2K3fPCKIRMuvx/Qpdza6qVjvtkXKuFOa/FQNMXvE?=
 =?us-ascii?Q?zUggPMXmm3SWCpvq/v3liUwC4+WOIfdtjIt/VFz5YO0hNhTm6FlH3skDT7td?=
 =?us-ascii?Q?UhzG5gRINqNhagMMTsx9VS5JKyYWHanKZDqjGGRejlRmy2ks1mltqDGgxbpV?=
 =?us-ascii?Q?LWlA08sIWOHOlgOslsj8RCqQlM3fCnJ+UOKwzDwXr8S9nYmIzxxjeJPmCWHS?=
 =?us-ascii?Q?gZe6lqgQbgGy6I3cyaValOXOx8A0ITKD7Nc6z8Wc7bCs6rOnHkKTr38CriIG?=
 =?us-ascii?Q?ZKFjQOimYz36aTUvH9oqWRb5r25bFvG+43n2zL3suE2b+qgt0glztAFpEpMs?=
 =?us-ascii?Q?5SQ31DkMI5y+SRZ3wwulS+Nv/7+g4j25VYb9wwmqJP48KzXJtTOX5ibExaJB?=
 =?us-ascii?Q?U72b9LSwMWmW9+vM/zuFE/4Pu/WGIBwi2t/T8Z1W7tLNudZKo7Mg3Px3/Tws?=
 =?us-ascii?Q?EweuweD9h2i/tfJulSCV57aXbf0PbotrfgaE7O+GLnKbzkz22q7uwLl5lmI2?=
 =?us-ascii?Q?tsIiW/PGLvFzfk7+X/RBNvNpNgsH+jSvJ8n+RVILtTJgwLd0a36pYqAkp3QI?=
 =?us-ascii?Q?Yu0m475XpUoPHHSC9YaB0m+WoLmCHzTEge+cr96MiJpg7RDDFiZmDbCIMz4B?=
 =?us-ascii?Q?s8bdR6pUzyJmyt8RbRDE2o4YQ0hqNnwB3HoYa3rEibUFPNA8Zwk/b/POh5Tx?=
 =?us-ascii?Q?wHQ1VXQpVoUUqJHbteI2cdronp9MLj+tRpzZnhrX7TGpc8qVROHIorroWgM+?=
 =?us-ascii?Q?lP2iup/JpliXs7HX2eqnkCBt1l7vq+X37+WLuXcGACqLKf5g4mWi6PrsuNSP?=
 =?us-ascii?Q?c1YOgH2ipJkhorn1vmx26e84hdGAzrPkhokpySfyNEaC+GWOKBGAjUi1nQOn?=
 =?us-ascii?Q?ZxKpF3otv6hoyOKXpMT6HX9r3Iam9rZU1pG50BycsURJ8HCg+G7bs2AqRvQt?=
 =?us-ascii?Q?qUXmnJ0TZwXKgbEdfb3AkRVdGzZoicSmOt+otehtNofmrXL//qbBlHY0Ots7?=
 =?us-ascii?Q?JxDL3ywDTBD13rKBPEpAzb+74V0jmb+u9J80iCZEfoqA9uO9HNb4ABu7Wtla?=
 =?us-ascii?Q?QLMeG0LAEwfcuMg3OPit9s9F/kSh125jwpboRKCrXUs1XIntYbDr3MyITW0e?=
 =?us-ascii?Q?IepLD64Fv//1cJjYR6xosu3tVU0tdUITr1zEDZj/ex7F04+UyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:36:02.9290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5af772-6e1d-441b-1d59-08dd18fe1043
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

Many hardware PMUs have constraints about sample period. For ex, minimum
supported sample period for IBS Op PMU is 0x90, the sample period must
be multiple of 0x10 for IBS Fetch and IBS Op.

Add an optional callback adjust_period() to struct PMU to allow PMU
specific drivers to adjust sample period calculated by generic code.
This will ensure the sample_period value will always be valid and no
additional code is required in PMU specific drivers to re-adjust the
period.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c  | 11 +++++++++++
 include/linux/perf_event.h |  5 +++++
 kernel/events/core.c       | 12 ++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index aea893a971b6..db6dc7b231e2 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -586,6 +586,15 @@ static int perf_ibs_check_period(struct perf_event *event, u64 value)
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
@@ -719,6 +728,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
 		.check_period	= perf_ibs_check_period,
+		.adjust_period	= perf_ibs_adjust_period,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
@@ -744,6 +754,7 @@ static struct perf_ibs perf_ibs_op = {
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
 		.check_period	= perf_ibs_check_period,
+		.adjust_period	= perf_ibs_adjust_period,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_MAX_CNT,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8333f132f4a9..4dcc51f5d2b6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -582,6 +582,11 @@ struct pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
+
+	/*
+	 * Adjust period value according to PMU constraints.
+	 */
+	u64 (*adjust_period)		(struct perf_event *event, u64 period); /* optional */
 };
 
 enum perf_addr_filter_action_t {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b2bc67791f84..e71aded67ce6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4192,9 +4192,9 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	if (!sample_period)
 		sample_period = 1;
 
-	hwc->sample_period = sample_period;
+	hwc->sample_period = event->pmu->adjust_period(event, sample_period);
 
-	if (local64_read(&hwc->period_left) > 8*sample_period) {
+	if (local64_read(&hwc->period_left) > 8*hwc->sample_period) {
 		if (disable)
 			event->pmu->stop(event, PERF_EF_UPDATE);
 
@@ -11519,6 +11519,11 @@ static int perf_event_nop_int(struct perf_event *event, u64 value)
 	return 0;
 }
 
+static u64 perf_pmu_nop_adjust_period(struct perf_event *event, u64 period)
+{
+	return period;
+}
+
 static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
 
 static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
@@ -11856,6 +11861,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->check_period)
 		pmu->check_period = perf_event_nop_int;
 
+	if (!pmu->adjust_period)
+		pmu->adjust_period = perf_pmu_nop_adjust_period;
+
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
-- 
2.43.0

