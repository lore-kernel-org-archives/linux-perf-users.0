Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2325A34D;
	Wed,  9 Apr 2025 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185489; cv=fail; b=R4jNWROAMZnnDseC5ZCp2JmDD25o3Jv48iCggju8L+70KzneYR+7rGbtIE6Whd+kTs1Bhg4pMzJvqSLzNCB6nm/sDpBtap7JV6tnkFBmBPIOIg30MlL4vV61HGmSJJIdGkVBzLIBuCxq4VnXWl8XSuXLejNx22kO9UHcQAig/xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185489; c=relaxed/simple;
	bh=fx60cR793brpc8ZHZrpbwG9qAMSb9AvodTSU8vNgROk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKg11P1zteqtTTWOK1tnmsGEX1k/b26tNZFaM7guu2YAE68OCXaL5DqO7DOys/68a8Vlwc7czAHo3pTsA2NMClK+vtQ8VjG5YzAk93o7kAhlvzBt8rxulIxiN8WvBnIol/aE8Rf325BeNePDN/7p+NdXiEE7R85SZuYgTN97AxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VSN9Fhjy; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VSN9Fhjy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbCxrdrZoCan9LNifiSZvErseoDObpKdzqElMjHehv4IZqPc5sg0XCSJAyk2DvcLymp3O86+NOTHS8Wf9fdT/VDQuClUiOapWrX+DIlzRc5wZon4cwYPAySlQ01Ze46jb+BGcxOTiIMo4p5kEI+NOuV+kbC7NDhvVmwPabktw/0f/uVdBPozXZvPdfuGWz7yyt1o65I6c3UCpCQIqvazBIq+UeAOqVVFJTE0zz4O4ZhGbUFBJMYbGhN/G/yKNdF791sMsNKv4572dgXNFnMiIyXwOXJfhuTZa4PFcF5pJQwolSLeptcZ+gy4AgnmqRn8wNkYOWbJnFqnxOEK6BGhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbAbUOKJHKW5feB1DbNVW5QP5r24hXZNDI4IkxP7/JU=;
 b=au5OnSTY+6biXL8hv6Kvfij0KulhWEh3ofMO9s+fu41YqsyzbcxhmXu4MTOjV3a4DTZFC6pHA247/ph7KeSbbyTkC/Wj4cNq7XljVL5/lNGeXODo82uYDNYpoES3Ss0VENV4MuCDeFbfsqUunhNNkIqj6Gg4SDdhCsQIjhKsXRtYHAickNoQUzgtev1vuXPlIuQKd/8ko9h58yVPBO3Nd8rU7wnfqoomdMLVaIpLZi2gUPmqneJyU6QQEAMRc26z2bYRGnLJhnCU4e8VBhWqPOmX4CbKQxcTd3q+m/MzKPuzj5TcjIGolgJG2hJrWkWmJ8eHarhZElMKhclKQhU+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbAbUOKJHKW5feB1DbNVW5QP5r24hXZNDI4IkxP7/JU=;
 b=VSN9FhjyceR44D9BTSrvL4mz3JPr+SvTcw8NQcy8rjLW6O8K7gsbHLMwufZp8DlDD55Lla6jcBmAiXdVGAtgk2gXGR54RH23Mi7idwROd2/v/vpFsQq2DJWRDgFsU4IcTBntaAhpZodLvO5bWnBBuAh4+DYSDtGalI2ghhVgvwY=
Received: from SJ0PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:33f::7)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 07:58:02 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::34) by SJ0PR05CA0032.outlook.office365.com
 (2603:10b6:a03:33f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.10 via Frontend Transport; Wed,
 9 Apr 2025 07:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 07:58:02 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 02:57:54 -0500
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
Subject: [PATCH 2/4] perf/x86/amd/uncore: Use hrtimer for handling overflows
Date: Wed, 9 Apr 2025 13:27:07 +0530
Message-ID: <f3a7703c22e6734f0d1bf34bc56be3124f818a8b.1744184837.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744184837.git.sandipan.das@amd.com>
References: <cover.1744184837.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e728bb1-fa0c-441f-0bf0-08dd773c40dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ialmGmwwKOMsc1UHc8NhBzslETIjPvv4Skva7PPhK+x82L9pNfUpwWeMXhJL?=
 =?us-ascii?Q?mm4DyLHrtn1kqIMQLmjWkdJiski8TwcMAg4pYWpYbihyhST56SSO5Xc+qG5S?=
 =?us-ascii?Q?H5qTqQoNtjM5ohneSZ185g7rFww7BR9vIwKWZEadQffu7n7aHDRgxvVamaxD?=
 =?us-ascii?Q?IQ1rtET9ePe24yzetybpB8+PhTUHqM1oKtrXnBiSvsGOeaDFUcuYevdap96/?=
 =?us-ascii?Q?gMg6mEyvHR5EEqn6+hTqEcsmVG2qq9wzvlWv8fopTTM8ruf5yEJXGpNPY/t/?=
 =?us-ascii?Q?8EGDsPAY3fB08o6QWIS60xX3uJf8nywTnHvPVtwokpeN8AdUqlh7YpBV6scf?=
 =?us-ascii?Q?gLE+MiZtAtLEcGA+c2F57zWCk7Lmv8O9F+bXVSYvuPb5OSiwODQAsUvQKiWk?=
 =?us-ascii?Q?EX/yQKE6ep8+99p+4ygJEgXHRuk74X3YROhQSQZQNYR2O2TuA0zaaVesz7MM?=
 =?us-ascii?Q?uzWErAsGSYufF3cpyjHLAL2QzqfbhELiH4kaxurZmhsZHKvhwgt32MUwQ9UE?=
 =?us-ascii?Q?xHcAvLkoccdLZqXL0wj8Oac97sHWZLRkru0CbWD7fNZODjcd1Nv9lvgipln/?=
 =?us-ascii?Q?PXpZ61tF/VpuSNqDGuAYiewP4Yrw72gQ5K9DX/+vSPu27OftljQEggT8x8cA?=
 =?us-ascii?Q?3R7Ep8HDZJPDELZ5RImGlHpydDX+aq64Rz4xZWdMb72X23gxUkwl4gH/n8vs?=
 =?us-ascii?Q?8owJKl3sgai75hR7UtjMz3qx3fvd/7YcPs/sFWRUwSHsXQn6pNJlDMkkNT6y?=
 =?us-ascii?Q?9bXnS+kveigSu/QNxVh6iVhhMmEGw+yf0zsyknIjNQTCycGmMYs+qPqZLk28?=
 =?us-ascii?Q?tcSF9fQr0Y3/AmES7/sRSuxtPnz7zSlKxdpptaDK3b4Ge767w1iC8T0hRqFY?=
 =?us-ascii?Q?WEDjHrpgbMVEdmJqVVpH6Ul3Q7T4FoV6gb2ZbPPxjoyWq3+6fCNEJO4xmjw2?=
 =?us-ascii?Q?PpiZgBe/SmXJvEQdy6vqkqHcaTLfTisHYl0Yg53PwpwAMudpgxTr+9zm5N1n?=
 =?us-ascii?Q?n7KbUF68rJ+6/TwG9q66+NFXRD/ijy8hVD5lPGzlkxoGhObrCJTsm5hyByVc?=
 =?us-ascii?Q?Oqs2o5/U1F8Ya7VwITNmI7f1mt1ssQZwQte9+3cyUDhasDkaysoleQrLUu+X?=
 =?us-ascii?Q?VMcUeRTNSA6RaNK5buWOr2C++TwynwnvwlyhWbyVwFeYBqPR7FV7QXeS1UQD?=
 =?us-ascii?Q?w8CuFUgARR7VJooT10/bkCXKHWmnWWJt4G065JxOMBJlMrsBR8dm6IQdCY9L?=
 =?us-ascii?Q?xBfnkB06A/m2mXk3MI3ZR1lYrVTSLFp01oL9+TsBGCzcfrrvWkKQaxUyBVVV?=
 =?us-ascii?Q?5rBRDOe48xHKeLHzqgdjiCpxiG1Cj7Vi/2pu/sZay6GgkDqH/AZRXlcq1Udi?=
 =?us-ascii?Q?UtvS+ni7BHT4GGbGJUn1K5e0mEyptI8F5PWpq8J5VTRcACWI8LWJTYUEkKq2?=
 =?us-ascii?Q?f6LTmyO9n+Cv5Si36CC+o0pUS12W8aol6DnhJIFkdsZofMR/4BNe1DL/g1WF?=
 =?us-ascii?Q?A8VYDHw8r7kKy3U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:58:02.5043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e728bb1-fa0c-441f-0bf0-08dd773c40dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

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
 arch/x86/events/amd/uncore.c | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 010024f09f2c..ee6528f2189f 100644
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
@@ -87,6 +92,51 @@ static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
 	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
 }
 
+static enum hrtimer_restart amd_uncore_hrtimer(struct hrtimer *hrtimer)
+{
+	struct amd_uncore_ctx *ctx;
+	struct perf_event *event;
+	unsigned long flags;
+	int bit;
+
+	ctx = container_of(hrtimer, struct amd_uncore_ctx, hrtimer);
+
+	if (!ctx->nr_active || ctx->cpu != smp_processor_id())
+		return HRTIMER_NORESTART;
+
+	/*
+	 * Disable local interrupts to prevent pmu->start() or pmu->stop()
+	 * from interrupting the update process
+	 */
+	local_irq_save(flags);
+
+	for_each_set_bit(bit, ctx->active_mask, NUM_COUNTERS_MAX) {
+		event = ctx->events[bit];
+		event->pmu->read(event);
+	}
+
+	local_irq_restore(flags);
+
+	hrtimer_forward_now(hrtimer, ns_to_ktime(ctx->hrtimer_duration));
+	return HRTIMER_RESTART;
+}
+
+static void amd_uncore_start_hrtimer(struct amd_uncore_ctx *ctx)
+{
+	hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
+		      HRTIMER_MODE_REL_PINNED);
+}
+
+static void amd_uncore_cancel_hrtimer(struct amd_uncore_ctx *ctx)
+{
+	hrtimer_cancel(&ctx->hrtimer);
+}
+
+static void amd_uncore_init_hrtimer(struct amd_uncore_ctx *ctx)
+{
+	hrtimer_setup(&ctx->hrtimer, amd_uncore_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+}
+
 static void amd_uncore_read(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -117,18 +167,26 @@ static void amd_uncore_read(struct perf_event *event)
 
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
@@ -138,6 +196,11 @@ static void amd_uncore_stop(struct perf_event *event, int flags)
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
@@ -490,6 +553,9 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				goto fail;
 			}
 
+			amd_uncore_init_hrtimer(curr);
+			curr->hrtimer_duration = 60LL * NSEC_PER_SEC;
+
 			cpumask_set_cpu(cpu, &pmu->active_mask);
 		}
 
@@ -879,12 +945,18 @@ static int amd_uncore_umc_event_init(struct perf_event *event)
 
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

