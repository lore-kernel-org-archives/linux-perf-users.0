Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858561E25E1;
	Fri, 18 Apr 2025 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947860; cv=fail; b=MOF1JEtv5Ktjkgir+aCweYsEqs7ZCrpyniJcJqFAZTuiGjSn1HAEMJxllEIu0igwG3SZGg+RcnGWBQcQbaEfQmj4YVmSjEcWFPQ56reqqrKwgGYm5LqvLyArkllV8Tt8sTFVdPv9sL/d71MZzG5q9fE3Wi6qKA8NkJYNBEvpFyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947860; c=relaxed/simple;
	bh=Wmmc5H34GqbjoCfaIsn0emCN0MR2Iy1SIeSXR0K6clc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XW+yk2kpjIEWkuplWPo85ibuZ8au06eKVpAAHRuS2mmTmQK/1LdPUsgA8Ie2N5IcGYSYvkMLFLh8S+Es52THajg7WhawaDm3FTFhNxuqiDhBVJbz0bLjpy5qAg09go+7XCoGoBSr2kQkTdJ9f+9QksYCatJAbjHi+E5yT91J30k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iCQI9meR; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iCQI9meR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asA+6DAIuiz1gknf0UpFWMNCg3T5gwU9ORVjkpd3quo8Vq/dbWR3qAdwfGatt3tYHLbAR55FhwNJXRoeDok0/32BLjFibB3iOngNK7P73wTIc3bw4Ji/TfDtxYfuiOPHf/PPzhIVX6a3A8gb5sd4FEEripV+u69t88lBj4a57L7nyRIc2Qe6ihcOtV058GDXnMQ6DFOzuwUYCqVb476zwiwZyuLjUJ1ofaStRZjSgL5cXM0wJZzItCxDsGv9RP43nQ5o6VHjpHWqrZoYKWYSlIRjRw6w36+L8it1UqNGPeCDeoIKTGENlGTMZgXVM3T1+8WDeZx6PDjPTcYkTxWBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaWNtIsU2ScJ45LnMjxYvTmqmJQhCXYPgCnJp6GO0UM=;
 b=DUA1r/tIp5agrHRL48X7rmG6n74e7xl5T7mu/d4dtscUhz2hkL9NPlDHBMIV98SY18aoMEaiv7k+tEeTVIZP4uOdKOflr0lp/F9nR0g6UYKl7aS7lGfLz7nUr03njtMgkPKFVvE+NCRO8gk2tuS59t+mfFpuoTPaeZR+2kA1xvGHKIoV2MA5OJ0R3cSGzDihOx80mwg0083lexHzguCerisV6P1yL4ahM28Ia3KDFX77X28KE1+47eXYcY/k6j6Uki3aUeRQjYB6fxH2RTIUyVSaHyxjwq5ytzN8tFwJIonDom+MkZG2vt7Xe1AvQ5rki72lw4vI8PX62IZ+vOZHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaWNtIsU2ScJ45LnMjxYvTmqmJQhCXYPgCnJp6GO0UM=;
 b=iCQI9meRLi/sd8TaJfl4jo1+MoLV0mSy5LKI3d33JkebPI1q81HhR4fDV+68B6lJDwf3NZTW1bl2QGYNF/wB85KCmKsoQLt7xpXr1EupVvYHJtFtGJ9oBe0CYpeVeDJaTlo8hyuf+g1H62c7wLjcuyWHu6Gb0WxBWYaQgvAHCZU=
Received: from BYAPR06CA0025.namprd06.prod.outlook.com (2603:10b6:a03:d4::38)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Fri, 18 Apr
 2025 03:44:13 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::ef) by BYAPR06CA0025.outlook.office365.com
 (2603:10b6:a03:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Fri,
 18 Apr 2025 03:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 03:44:13 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 22:44:07 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <eranian@google.com>,
	<songliubraving@meta.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v2 3/5] perf/x86/amd/uncore: Use hrtimer for handling overflows
Date: Fri, 18 Apr 2025 09:13:01 +0530
Message-ID: <8ecf5fe20452da1cd19cf3ff4954d3e7c5137468.1744906694.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744906694.git.sandipan.das@amd.com>
References: <cover.1744906694.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 12029045-89fe-4fc2-0dc2-08dd7e2b4941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ihc6A7KlLBXddlr9p4ihmLh96gDY5O/3/ebCQtAWbVGQ3YdBYamAxHdUPbsm?=
 =?us-ascii?Q?pbGdd2y/jQoQfmAalnqNFoDgZ16oyMuBc2ylQJfm7Muga5x8iq1yP0Xg2Vsn?=
 =?us-ascii?Q?cGJC/s0ojjy8BvtvtkEY2MN5KQAYC2leHxXp/i/IoVKeX9e2Ol/oNGh8Qa9V?=
 =?us-ascii?Q?j2RH+NF8yguTFwTUP5OTM2/TY80YmP27FwjPeV6fwl/pQfsB/qv0Dx3B1C1D?=
 =?us-ascii?Q?ZueJo8MlwaaRfJbqi5zo4t4fFumrZ5Nj/db65HM27yDx7omfuN1xeC9XIoSn?=
 =?us-ascii?Q?G7vHsnrxmptfLYx4RWSnOI6YfvEYHyzUzDIeVOtx9U/3/oibRQUAswZx9nrj?=
 =?us-ascii?Q?008ETVUUC0wlNX4mp3o9jgKwOfaa3ifS5lmOJUHlR2H0ULxW0U4a5ORToeI3?=
 =?us-ascii?Q?5cz9Fx0o79tA79rWDo7nBAYyswv9CIB/DuoFM9OnqEwR/a73/Cwd8V7VF1CX?=
 =?us-ascii?Q?1+D47vsAagKpo05s2o1Tx6J4yJBlHsGPKLGMvR6qnvE99qTdAH2jK4q9VBU/?=
 =?us-ascii?Q?E3U6cmzgQwUxph1E17p8zuKOXh3/8STAWaqISqsd5k+tQfXOzizcfaKKyoX9?=
 =?us-ascii?Q?VK3OajrcZji3RMyiI9xH4cAEMkntfns9cEgQjf8qNnwRX7OTthZpZqH3pxwg?=
 =?us-ascii?Q?smGhgRTYkmKktipo38qQziHmouvONrg6SctS0SC0DFsASkvPCQuj3k43/gWz?=
 =?us-ascii?Q?gCtECWYuyJ/I7m4NzB/5DDnEu9XPNJFSPzQkOavbiHy5vsW+9Gps+m4R7hQ5?=
 =?us-ascii?Q?VeHqzx0hxer8pW9q0eXowxGjgfXaeKbGPrM0XJsNOWf2pms94AQzEZ3Qa2cV?=
 =?us-ascii?Q?wGVWbSCF9MiibYmLavvqFYIQAfyioGKeGI1LeyRAg+4ndYm4+kCaDZ2RvjkD?=
 =?us-ascii?Q?l/oFQBJ7UNTYpxI+h8Zq0SYlOODaibUtZnEnuglr0WJBBrrDoVseozdcBhJa?=
 =?us-ascii?Q?OqLSINeewN6Z44B6XhN+OIxE5bs8K1dXJWugl7O6CKrzsBLV3duWeoRkt6/P?=
 =?us-ascii?Q?pEpTfQ0raKI1ayXImEnZdzuR/KRvaofMPGom2pJ+TaqLQEGvXa/a/j18Llg0?=
 =?us-ascii?Q?GcDk58i8yWPK27/2nFnfOS6M/2Fv/JJDcfb4+1jOoHlIhrNS8MAepuO/Ip1t?=
 =?us-ascii?Q?1NimkbqNYRLgdXqYpoW/LDf4QwNYnPOkIWA8k3YqzlNHJKgSyiTVwFuG2uOH?=
 =?us-ascii?Q?l2OoHI+2cieRv/v+yM0PchwoxxXTRJDQLpCSc5W3jeocCXVGDq0YIoxyHjq1?=
 =?us-ascii?Q?6/1m+YJatXZQbHkdKTNE0mJz/G0JI1vJSx9/YqTInU/LZh0bvOqoNDhZm5SO?=
 =?us-ascii?Q?aGZH4ZGZW7a6ZIjI+86J2KXZOu4oUx1A29oN9pFHGgvtSvx2TOoggI1kIFkH?=
 =?us-ascii?Q?dAQ/8kEhLH9aDg8cW4mEomqqh2Z3maWrgO86xlbSOQxjFjeHU/jzANC/o2Qq?=
 =?us-ascii?Q?7rJGUMYK5+/BjVbt+ZxlDb2F1zGFynkk8LhJ8qbrb7EGfEMNv4nWJ9XVBS99?=
 =?us-ascii?Q?KrjXTY6hTn4p/YOuPb+s6jLwPSb+5NkYlPir?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 03:44:13.2609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12029045-89fe-4fc2-0dc2-08dd7e2b4941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094

Uncore counters do not provide mechanisms like interrupts to report
overflows and the accumulated user-visible count is incorrect if there
is more than one overflow between two successive read requests for the
same event because the value of prev_count goes out-of-date for
calculating the correct delta.

To avoid this, start a hrtimer to periodically initiate a pmu->read() of
the active counters for keeping prev_count up-to-date. It should be
noted that the hrtimer duration should be lesser than the shortest time
it takes for a counter to overflow for this approach to be effective.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 010024f09f2c..e09bfbb4a4cd 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -21,6 +21,7 @@
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
 #define NUM_COUNTERS_L3		6
+#define NUM_COUNTERS_MAX	64
 
 #define RDPMC_BASE_NB		6
 #define RDPMC_BASE_LLC		10
@@ -38,6 +39,10 @@ struct amd_uncore_ctx {
 	int refcnt;
 	int cpu;
 	struct perf_event **events;
+	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
+	int nr_active;
+	struct hrtimer hrtimer;
+	u64 hrtimer_duration;
 };
 
 struct amd_uncore_pmu {
@@ -87,6 +92,42 @@ static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
 	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
 }
 
+static enum hrtimer_restart amd_uncore_hrtimer(struct hrtimer *hrtimer)
+{
+	struct amd_uncore_ctx *ctx;
+	struct perf_event *event;
+	int bit;
+
+	ctx = container_of(hrtimer, struct amd_uncore_ctx, hrtimer);
+
+	if (!ctx->nr_active || ctx->cpu != smp_processor_id())
+		return HRTIMER_NORESTART;
+
+	for_each_set_bit(bit, ctx->active_mask, NUM_COUNTERS_MAX) {
+		event = ctx->events[bit];
+		event->pmu->read(event);
+	}
+
+	hrtimer_forward_now(hrtimer, ns_to_ktime(ctx->hrtimer_duration));
+	return HRTIMER_RESTART;
+}
+
+static void amd_uncore_start_hrtimer(struct amd_uncore_ctx *ctx)
+{
+	hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
+		      HRTIMER_MODE_REL_PINNED_HARD);
+}
+
+static void amd_uncore_cancel_hrtimer(struct amd_uncore_ctx *ctx)
+{
+	hrtimer_cancel(&ctx->hrtimer);
+}
+
+static void amd_uncore_init_hrtimer(struct amd_uncore_ctx *ctx)
+{
+	hrtimer_setup(&ctx->hrtimer, amd_uncore_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+}
+
 static void amd_uncore_read(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -117,18 +158,26 @@ static void amd_uncore_read(struct perf_event *event)
 
 static void amd_uncore_start(struct perf_event *event, int flags)
 {
+	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
+	if (!ctx->nr_active++)
+		amd_uncore_start_hrtimer(ctx);
+
 	if (flags & PERF_EF_RELOAD)
 		wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
 
 	hwc->state = 0;
+	__set_bit(hwc->idx, ctx->active_mask);
 	wrmsrl(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
 	perf_event_update_userpage(event);
 }
 
 static void amd_uncore_stop(struct perf_event *event, int flags)
 {
+	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
 	wrmsrl(hwc->config_base, hwc->config);
@@ -138,6 +187,11 @@ static void amd_uncore_stop(struct perf_event *event, int flags)
 		event->pmu->read(event);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
+
+	if (!--ctx->nr_active)
+		amd_uncore_cancel_hrtimer(ctx);
+
+	__clear_bit(hwc->idx, ctx->active_mask);
 }
 
 static int amd_uncore_add(struct perf_event *event, int flags)
@@ -490,6 +544,9 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				goto fail;
 			}
 
+			amd_uncore_init_hrtimer(curr);
+			curr->hrtimer_duration = 60LL * NSEC_PER_SEC;
+
 			cpumask_set_cpu(cpu, &pmu->active_mask);
 		}
 
@@ -879,12 +936,18 @@ static int amd_uncore_umc_event_init(struct perf_event *event)
 
 static void amd_uncore_umc_start(struct perf_event *event, int flags)
 {
+	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
+	if (!ctx->nr_active++)
+		amd_uncore_start_hrtimer(ctx);
+
 	if (flags & PERF_EF_RELOAD)
 		wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
 
 	hwc->state = 0;
+	__set_bit(hwc->idx, ctx->active_mask);
 	wrmsrl(hwc->config_base, (hwc->config | AMD64_PERFMON_V2_ENABLE_UMC));
 	perf_event_update_userpage(event);
 }
-- 
2.43.0

