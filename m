Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A563F660E;
	Wed,  1 Jul 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898491; cv=none; b=WKhjEVNBP3WHmunSCtn9wbvY/3z7LBLQNJUmf2EnZTpHo9/APNTuQL9gPds8MnfmIDQg8LPBa8HVZPp9ISCKx8X+aWSY5KbYAo80IW7rRpX1CT7L7uWjN4TzWgWp5o6OJDnrLV9veX2LNrTwNt0cjxgNVR+Zw6B+f3tw2Z6yMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898491; c=relaxed/simple;
	bh=3NY5aEitJKGN0+ye/DQxmSxX6YJa3CdxFKGpSkPC+4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7K1YgoRxppBVi2pz/E+0fBJrxb2ybajZiP1FSWh4LTVmpmBH1J/C0AIqwbv4gg8orUJIIVeDm3oyInEY3qS4eluXya/p++8dtkfGCijAKYaFjbwmmY3UCfnmGqIQ396ZWYhj6qpl5KQVqStyaqKQgd6MMFBar5cBwNeHkR+P5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqvx5397VzT0bw;
	Wed,  1 Jul 2026 17:34:33 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqvx43YzRzT0bp;
	Wed,  1 Jul 2026 17:34:32 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id BF5D9596A;
	Wed,  1 Jul 2026 17:34:25 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 1 Jul
 2026 17:34:31 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>, <x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>, Zhenglang Hu <huzhenglang@hygon.cn>
Subject: [PATCH v2 2/3] perf/x86/amd/uncore: Convert AMD driver to common PMU helpers
Date: Wed, 1 Jul 2026 09:34:16 +0000
Message-ID: <20260701093417.1312443-3-liuqi@hygon.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701093417.1312443-1-liuqi@hygon.cn>
References: <20260701093417.1312443-1-liuqi@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Use the common uncore PMU helpers for AMD uncore event handling and
per-CPU context management.

The AMD-specific DF, L3 and UMC discovery, event encoding and PMU setup
logic remains in the AMD driver.  This only replaces duplicated common
operations with calls to the helper functions.

Signed-off-by: Qi Liu <liuqi@hygon.cn>
Tested-by: Zhenglang Hu <huzhenglang@hygon.cn>
---
 arch/x86/events/Kconfig      |   1 +
 arch/x86/events/amd/uncore.c | 578 +++++------------------------------
 2 files changed, 74 insertions(+), 505 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index ecbcb6efc3a1..77ebdb13ccc3 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -41,6 +41,7 @@ config PERF_EVENTS_AMD_UNCORE_COMMON
 config PERF_EVENTS_AMD_UNCORE
 	tristate "AMD Uncore performance events"
 	depends on PERF_EVENTS && CPU_SUP_AMD
+	select PERF_EVENTS_AMD_UNCORE_COMMON
 	default y
 	help
 	  Include support for AMD uncore performance events for use with
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dbc00b6dd69e..4c6501bb0637 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -19,6 +19,8 @@
 #include <asm/cpuid/api.h>
 #include <asm/msr.h>
 
+#include "amd_uncore_common.h"
+
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
 #define NUM_COUNTERS_L3		6
@@ -36,27 +38,6 @@
 
 static int pmu_version;
 
-struct amd_uncore_ctx {
-	int refcnt;
-	int cpu;
-	struct perf_event **events;
-	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
-	int nr_active;
-	struct hrtimer hrtimer;
-	u64 hrtimer_duration;
-};
-
-struct amd_uncore_pmu {
-	char name[UNCORE_NAME_LEN];
-	int num_counters;
-	int rdpmc_base;
-	u32 msr_base;
-	int group;
-	cpumask_t active_mask;
-	struct pmu pmu;
-	struct amd_uncore_ctx * __percpu *ctx;
-};
-
 enum {
 	UNCORE_TYPE_DF,
 	UNCORE_TYPE_L3,
@@ -65,243 +46,12 @@ enum {
 	UNCORE_TYPE_MAX
 };
 
-union amd_uncore_info {
-	struct {
-		u64	aux_data:32;	/* auxiliary data */
-		u64	num_pmcs:8;	/* number of counters */
-		u64	gid:8;		/* group id */
-		u64	cid:8;		/* context id */
-	} split;
-	u64		full;
-};
-
-struct amd_uncore {
-	union amd_uncore_info  __percpu *info;
-	struct amd_uncore_pmu *pmus;
-	unsigned int num_pmus;
-	bool init_done;
-	void (*scan)(struct amd_uncore *uncore, unsigned int cpu);
-	int  (*init)(struct amd_uncore *uncore, unsigned int cpu);
-	void (*move)(struct amd_uncore *uncore, unsigned int cpu);
-	void (*free)(struct amd_uncore *uncore, unsigned int cpu);
-};
-
-static struct amd_uncore uncores[UNCORE_TYPE_MAX];
+static struct amd_uncore_common uncores[UNCORE_TYPE_MAX];
 
 /* Interval for hrtimer, defaults to 60000 milliseconds */
 static unsigned int update_interval = 60 * MSEC_PER_SEC;
 module_param(update_interval, uint, 0444);
 
-static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
-{
-	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
-}
-
-static enum hrtimer_restart amd_uncore_hrtimer(struct hrtimer *hrtimer)
-{
-	struct amd_uncore_ctx *ctx;
-	struct perf_event *event;
-	int bit;
-
-	ctx = container_of(hrtimer, struct amd_uncore_ctx, hrtimer);
-
-	if (!ctx->nr_active || ctx->cpu != smp_processor_id())
-		return HRTIMER_NORESTART;
-
-	for_each_set_bit(bit, ctx->active_mask, NUM_COUNTERS_MAX) {
-		event = ctx->events[bit];
-		event->pmu->read(event);
-	}
-
-	hrtimer_forward_now(hrtimer, ns_to_ktime(ctx->hrtimer_duration));
-	return HRTIMER_RESTART;
-}
-
-static void amd_uncore_start_hrtimer(struct amd_uncore_ctx *ctx)
-{
-	hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
-		      HRTIMER_MODE_REL_PINNED_HARD);
-}
-
-static void amd_uncore_cancel_hrtimer(struct amd_uncore_ctx *ctx)
-{
-	hrtimer_cancel(&ctx->hrtimer);
-}
-
-static void amd_uncore_init_hrtimer(struct amd_uncore_ctx *ctx)
-{
-	hrtimer_setup(&ctx->hrtimer, amd_uncore_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-}
-
-static void amd_uncore_read(struct perf_event *event)
-{
-	struct hw_perf_event *hwc = &event->hw;
-	u64 prev, new;
-	s64 delta;
-
-	/*
-	 * since we do not enable counter overflow interrupts,
-	 * we do not have to worry about prev_count changing on us
-	 */
-
-	prev = local64_read(&hwc->prev_count);
-
-	/*
-	 * Some uncore PMUs do not have RDPMC assignments. In such cases,
-	 * read counts directly from the corresponding PERF_CTR.
-	 */
-	if (hwc->event_base_rdpmc < 0)
-		rdmsrq(hwc->event_base, new);
-	else
-		new = rdpmc(hwc->event_base_rdpmc);
-
-	local64_set(&hwc->prev_count, new);
-	delta = (new << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
-	delta >>= COUNTER_SHIFT;
-	local64_add(delta, &event->count);
-}
-
-static void amd_uncore_start(struct perf_event *event, int flags)
-{
-	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
-	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
-	struct hw_perf_event *hwc = &event->hw;
-
-	if (!ctx->nr_active++)
-		amd_uncore_start_hrtimer(ctx);
-
-	if (flags & PERF_EF_RELOAD)
-		wrmsrq(hwc->event_base, (u64)local64_read(&hwc->prev_count));
-
-	hwc->state = 0;
-	__set_bit(hwc->idx, ctx->active_mask);
-	wrmsrq(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
-	perf_event_update_userpage(event);
-}
-
-static void amd_uncore_stop(struct perf_event *event, int flags)
-{
-	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
-	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
-	struct hw_perf_event *hwc = &event->hw;
-
-	wrmsrq(hwc->config_base, hwc->config);
-	hwc->state |= PERF_HES_STOPPED;
-
-	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
-		event->pmu->read(event);
-		hwc->state |= PERF_HES_UPTODATE;
-	}
-
-	if (!--ctx->nr_active)
-		amd_uncore_cancel_hrtimer(ctx);
-
-	__clear_bit(hwc->idx, ctx->active_mask);
-}
-
-static int amd_uncore_add(struct perf_event *event, int flags)
-{
-	int i;
-	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
-	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
-	struct hw_perf_event *hwc = &event->hw;
-
-	/* are we already assigned? */
-	if (hwc->idx != -1 && ctx->events[hwc->idx] == event)
-		goto out;
-
-	for (i = 0; i < pmu->num_counters; i++) {
-		if (ctx->events[i] == event) {
-			hwc->idx = i;
-			goto out;
-		}
-	}
-
-	/* if not, take the first available counter */
-	hwc->idx = -1;
-	for (i = 0; i < pmu->num_counters; i++) {
-		struct perf_event *tmp = NULL;
-
-		if (try_cmpxchg(&ctx->events[i], &tmp, event)) {
-			hwc->idx = i;
-			break;
-		}
-	}
-
-out:
-	if (hwc->idx == -1)
-		return -EBUSY;
-
-	hwc->config_base = pmu->msr_base + (2 * hwc->idx);
-	hwc->event_base = pmu->msr_base + 1 + (2 * hwc->idx);
-	hwc->event_base_rdpmc = pmu->rdpmc_base + hwc->idx;
-	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
-
-	if (pmu->rdpmc_base < 0)
-		hwc->event_base_rdpmc = -1;
-
-	if (flags & PERF_EF_START)
-		event->pmu->start(event, PERF_EF_RELOAD);
-
-	return 0;
-}
-
-static void amd_uncore_del(struct perf_event *event, int flags)
-{
-	int i;
-	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
-	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
-	struct hw_perf_event *hwc = &event->hw;
-
-	event->pmu->stop(event, PERF_EF_UPDATE);
-
-	for (i = 0; i < pmu->num_counters; i++) {
-		struct perf_event *tmp = event;
-
-		if (try_cmpxchg(&ctx->events[i], &tmp, NULL))
-			break;
-	}
-
-	hwc->idx = -1;
-}
-
-static int amd_uncore_event_init(struct perf_event *event)
-{
-	struct amd_uncore_pmu *pmu;
-	struct amd_uncore_ctx *ctx;
-	struct hw_perf_event *hwc = &event->hw;
-
-	if (event->attr.type != event->pmu->type)
-		return -ENOENT;
-
-	if (event->cpu < 0)
-		return -EINVAL;
-
-	pmu = event_to_amd_uncore_pmu(event);
-	ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
-	if (!ctx)
-		return -ENODEV;
-
-	/*
-	 * NB and Last level cache counters (MSRs) are shared across all cores
-	 * that share the same NB / Last level cache.  On family 16h and below,
-	 * Interrupts can be directed to a single target core, however, event
-	 * counts generated by processes running on other cores cannot be masked
-	 * out. So we do not support sampling and per-thread events via
-	 * CAP_NO_INTERRUPT, and we do not enable counter overflow interrupts:
-	 */
-	hwc->config = event->attr.config;
-	hwc->idx = -1;
-
-	/*
-	 * since request can come in to any of the shared cores, we will remap
-	 * to a single common cpu.
-	 */
-	event->cpu = ctx->cpu;
-
-	return 0;
-}
-
 static umode_t
 amd_f17h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -315,37 +65,6 @@ amd_f19h_uncore_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return boot_cpu_data.x86 >= 0x19 ? attr->mode : 0;
 }
 
-static ssize_t amd_uncore_attr_show_cpumask(struct device *dev,
-					    struct device_attribute *attr,
-					    char *buf)
-{
-	struct pmu *ptr = dev_get_drvdata(dev);
-	struct amd_uncore_pmu *pmu = container_of(ptr, struct amd_uncore_pmu, pmu);
-
-	return cpumap_print_to_pagebuf(true, buf, &pmu->active_mask);
-}
-static DEVICE_ATTR(cpumask, S_IRUGO, amd_uncore_attr_show_cpumask, NULL);
-
-static struct attribute *amd_uncore_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL,
-};
-
-static struct attribute_group amd_uncore_attr_group = {
-	.attrs = amd_uncore_attrs,
-};
-
-#define DEFINE_UNCORE_FORMAT_ATTR(_var, _name, _format)			\
-static ssize_t __uncore_##_var##_show(struct device *dev,		\
-				struct device_attribute *attr,		\
-				char *page)				\
-{									\
-	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
-	return sprintf(page, _format "\n");				\
-}									\
-static struct device_attribute format_attr_##_var =			\
-	__ATTR(_name, 0444, __uncore_##_var##_show, NULL)
-
 DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
 DEFINE_UNCORE_FORMAT_ATTR(event14v2,	event,		"config:0-7,32-37");	   /* PerfMonV2 DF */
@@ -426,13 +145,13 @@ static struct attribute_group amd_uncore_umc_format_group = {
 };
 
 static const struct attribute_group *amd_uncore_df_attr_groups[] = {
-	&amd_uncore_attr_group,
+	&amd_uncore_common_attr_group,
 	&amd_uncore_df_format_group,
 	NULL,
 };
 
 static const struct attribute_group *amd_uncore_l3_attr_groups[] = {
-	&amd_uncore_attr_group,
+	&amd_uncore_common_attr_group,
 	&amd_uncore_l3_format_group,
 	NULL,
 };
@@ -444,164 +163,14 @@ static const struct attribute_group *amd_uncore_l3_attr_update[] = {
 };
 
 static const struct attribute_group *amd_uncore_umc_attr_groups[] = {
-	&amd_uncore_attr_group,
+	&amd_uncore_common_attr_group,
 	&amd_uncore_umc_format_group,
 	NULL,
 };
 
-static __always_inline
-int amd_uncore_ctx_cid(struct amd_uncore *uncore, unsigned int cpu)
-{
-	union amd_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
-	return info->split.cid;
-}
-
-static __always_inline
-int amd_uncore_ctx_gid(struct amd_uncore *uncore, unsigned int cpu)
-{
-	union amd_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
-	return info->split.gid;
-}
-
-static __always_inline
-int amd_uncore_ctx_num_pmcs(struct amd_uncore *uncore, unsigned int cpu)
-{
-	union amd_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
-	return info->split.num_pmcs;
-}
-
-static void amd_uncore_ctx_free(struct amd_uncore *uncore, unsigned int cpu)
-{
-	struct amd_uncore_pmu *pmu;
-	struct amd_uncore_ctx *ctx;
-	int i;
-
-	if (!uncore->init_done)
-		return;
-
-	for (i = 0; i < uncore->num_pmus; i++) {
-		pmu = &uncore->pmus[i];
-		ctx = *per_cpu_ptr(pmu->ctx, cpu);
-		if (!ctx)
-			continue;
-
-		if (cpu == ctx->cpu)
-			cpumask_clear_cpu(cpu, &pmu->active_mask);
-
-		if (!--ctx->refcnt) {
-			kfree(ctx->events);
-			kfree(ctx);
-		}
-
-		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
-	}
-}
-
-static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
-{
-	struct amd_uncore_ctx *curr, *prev;
-	struct amd_uncore_pmu *pmu;
-	int node, cid, gid, i, j;
-
-	if (!uncore->init_done || !uncore->num_pmus)
-		return 0;
-
-	cid = amd_uncore_ctx_cid(uncore, cpu);
-	gid = amd_uncore_ctx_gid(uncore, cpu);
-
-	for (i = 0; i < uncore->num_pmus; i++) {
-		pmu = &uncore->pmus[i];
-		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
-		curr = NULL;
-
-		/* Check for group exclusivity */
-		if (gid != pmu->group)
-			continue;
-
-		/* Find a sibling context */
-		for_each_online_cpu(j) {
-			if (cpu == j)
-				continue;
-
-			prev = *per_cpu_ptr(pmu->ctx, j);
-			if (!prev)
-				continue;
-
-			if (cid == amd_uncore_ctx_cid(uncore, j)) {
-				curr = prev;
-				break;
-			}
-		}
-
-		/* Allocate context if sibling does not exist */
-		if (!curr) {
-			node = cpu_to_node(cpu);
-			curr = kzalloc_node(sizeof(*curr), GFP_KERNEL, node);
-			if (!curr)
-				goto fail;
-
-			curr->cpu = cpu;
-			curr->events = kzalloc_node(sizeof(*curr->events) *
-						    pmu->num_counters,
-						    GFP_KERNEL, node);
-			if (!curr->events) {
-				kfree(curr);
-				goto fail;
-			}
-
-			amd_uncore_init_hrtimer(curr);
-			curr->hrtimer_duration = (u64)update_interval * NSEC_PER_MSEC;
-
-			cpumask_set_cpu(cpu, &pmu->active_mask);
-		}
-
-		curr->refcnt++;
-		*per_cpu_ptr(pmu->ctx, cpu) = curr;
-	}
-
-	return 0;
-
-fail:
-	amd_uncore_ctx_free(uncore, cpu);
-
-	return -ENOMEM;
-}
-
-static void amd_uncore_ctx_move(struct amd_uncore *uncore, unsigned int cpu)
-{
-	struct amd_uncore_ctx *curr, *next;
-	struct amd_uncore_pmu *pmu;
-	int i, j;
-
-	if (!uncore->init_done)
-		return;
-
-	for (i = 0; i < uncore->num_pmus; i++) {
-		pmu = &uncore->pmus[i];
-		curr = *per_cpu_ptr(pmu->ctx, cpu);
-		if (!curr)
-			continue;
-
-		/* Migrate to a shared sibling if possible */
-		for_each_online_cpu(j) {
-			next = *per_cpu_ptr(pmu->ctx, j);
-			if (!next || cpu == j)
-				continue;
-
-			if (curr == next) {
-				perf_pmu_migrate_context(&pmu->pmu, cpu, j);
-				cpumask_clear_cpu(cpu, &pmu->active_mask);
-				cpumask_set_cpu(j, &pmu->active_mask);
-				next->cpu = j;
-				break;
-			}
-		}
-	}
-}
-
 static int amd_uncore_cpu_starting(unsigned int cpu)
 {
-	struct amd_uncore *uncore;
+	struct amd_uncore_common *uncore;
 	int i;
 
 	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
@@ -614,7 +183,7 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 
 static int amd_uncore_cpu_online(unsigned int cpu)
 {
-	struct amd_uncore *uncore;
+	struct amd_uncore_common *uncore;
 	int i;
 
 	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
@@ -628,7 +197,7 @@ static int amd_uncore_cpu_online(unsigned int cpu)
 
 static int amd_uncore_cpu_down_prepare(unsigned int cpu)
 {
-	struct amd_uncore *uncore;
+	struct amd_uncore_common *uncore;
 	int i;
 
 	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
@@ -641,7 +210,7 @@ static int amd_uncore_cpu_down_prepare(unsigned int cpu)
 
 static int amd_uncore_cpu_dead(unsigned int cpu)
 {
-	struct amd_uncore *uncore;
+	struct amd_uncore_common *uncore;
 	int i;
 
 	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
@@ -655,7 +224,7 @@ static int amd_uncore_cpu_dead(unsigned int cpu)
 static int amd_uncore_df_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int ret = amd_uncore_event_init(event);
+	int ret = amd_uncore_common_event_init(event);
 
 	hwc->config = event->attr.config &
 		      (pmu_version >= 2 ? AMD64_PERFMON_V2_RAW_EVENT_MASK_NB :
@@ -666,7 +235,7 @@ static int amd_uncore_df_event_init(struct perf_event *event)
 
 static int amd_uncore_df_add(struct perf_event *event, int flags)
 {
-	int ret = amd_uncore_add(event, flags & ~PERF_EF_START);
+	int ret = amd_uncore_common_add(event, flags & ~PERF_EF_START);
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (ret)
@@ -684,16 +253,16 @@ static int amd_uncore_df_add(struct perf_event *event, int flags)
 
 	/* Delayed start after rdpmc base update */
 	if (flags & PERF_EF_START)
-		amd_uncore_start(event, PERF_EF_RELOAD);
+		amd_uncore_common_start(event, PERF_EF_RELOAD);
 
 	return 0;
 }
 
 static
-void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
+void amd_uncore_df_ctx_scan(struct amd_uncore_common *uncore, unsigned int cpu)
 {
 	union cpuid_0x80000022_ebx ebx;
-	union amd_uncore_info info;
+	union amd_uncore_common_info info;
 
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
 		return;
@@ -712,17 +281,17 @@ void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 }
 
 static
-int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
+int amd_uncore_df_ctx_init(struct amd_uncore_common *uncore, unsigned int cpu)
 {
 	struct attribute **df_attr = amd_uncore_df_format_attr;
-	struct amd_uncore_pmu *pmu;
+	struct amd_uncore_common_pmu *pmu;
 	int num_counters;
 
 	/* Run just once */
 	if (uncore->init_done)
-		return amd_uncore_ctx_init(uncore, cpu);
+		return amd_uncore_common_ctx_init(uncore, cpu);
 
-	num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	num_counters = amd_uncore_common_ctx_num_pmcs(uncore, cpu);
 	if (!num_counters)
 		goto done;
 
@@ -742,7 +311,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu->num_counters = num_counters;
 	pmu->msr_base = MSR_F15H_NB_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_NB;
-	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
+	pmu->group = amd_uncore_common_ctx_gid(uncore, cpu);
 
 	if (pmu_version >= 2) {
 		*df_attr++ = &format_attr_event14v2.attr;
@@ -751,7 +320,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		*df_attr = &format_attr_event14.attr;
 	}
 
-	pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
+	pmu->ctx = alloc_percpu(struct amd_uncore_common_ctx *);
 	if (!pmu->ctx)
 		goto done;
 
@@ -761,10 +330,10 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		.name		= pmu->name,
 		.event_init	= amd_uncore_df_event_init,
 		.add		= amd_uncore_df_add,
-		.del		= amd_uncore_del,
-		.start		= amd_uncore_start,
-		.stop		= amd_uncore_stop,
-		.read		= amd_uncore_read,
+		.del		= amd_uncore_common_del,
+		.start		= amd_uncore_common_start,
+		.stop		= amd_uncore_common_stop,
+		.read		= amd_uncore_common_read,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 		.module		= THIS_MODULE,
 	};
@@ -775,8 +344,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		goto done;
 	}
 
-	pr_info("%d %s%s counters detected\n", pmu->num_counters,
-		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON " : "",
+	pr_info("%d %s counters detected\n", pmu->num_counters,
 		pmu->pmu.name);
 
 	uncore->num_pmus = 1;
@@ -784,12 +352,12 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 done:
 	uncore->init_done = true;
 
-	return amd_uncore_ctx_init(uncore, cpu);
+	return amd_uncore_common_ctx_init(uncore, cpu);
 }
 
 static int amd_uncore_l3_event_init(struct perf_event *event)
 {
-	int ret = amd_uncore_event_init(event);
+	int ret = amd_uncore_common_event_init(event);
 	struct hw_perf_event *hwc = &event->hw;
 	u64 config = event->attr.config;
 	u64 mask;
@@ -827,9 +395,9 @@ static int amd_uncore_l3_event_init(struct perf_event *event)
 }
 
 static
-void amd_uncore_l3_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
+void amd_uncore_l3_ctx_scan(struct amd_uncore_common *uncore, unsigned int cpu)
 {
-	union amd_uncore_info info;
+	union amd_uncore_common_info info;
 
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_LLC))
 		return;
@@ -846,17 +414,17 @@ void amd_uncore_l3_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 }
 
 static
-int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
+int amd_uncore_l3_ctx_init(struct amd_uncore_common *uncore, unsigned int cpu)
 {
 	struct attribute **l3_attr = amd_uncore_l3_format_attr;
-	struct amd_uncore_pmu *pmu;
+	struct amd_uncore_common_pmu *pmu;
 	int num_counters;
 
 	/* Run just once */
 	if (uncore->init_done)
-		return amd_uncore_ctx_init(uncore, cpu);
+		return amd_uncore_common_ctx_init(uncore, cpu);
 
-	num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	num_counters = amd_uncore_common_ctx_num_pmcs(uncore, cpu);
 	if (!num_counters)
 		goto done;
 
@@ -876,7 +444,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu->num_counters = num_counters;
 	pmu->msr_base = MSR_F16H_L2I_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_LLC;
-	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
+	pmu->group = amd_uncore_common_ctx_gid(uncore, cpu);
 
 	if (boot_cpu_data.x86 >= 0x17) {
 		*l3_attr++ = &format_attr_event8.attr;
@@ -886,7 +454,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 			     &format_attr_threadmask8.attr;
 	}
 
-	pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
+	pmu->ctx = alloc_percpu(struct amd_uncore_common_ctx *);
 	if (!pmu->ctx)
 		goto done;
 
@@ -896,11 +464,11 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		.attr_update	= amd_uncore_l3_attr_update,
 		.name		= pmu->name,
 		.event_init	= amd_uncore_l3_event_init,
-		.add		= amd_uncore_add,
-		.del		= amd_uncore_del,
-		.start		= amd_uncore_start,
-		.stop		= amd_uncore_stop,
-		.read		= amd_uncore_read,
+		.add		= amd_uncore_common_add,
+		.del		= amd_uncore_common_del,
+		.start		= amd_uncore_common_start,
+		.stop		= amd_uncore_common_stop,
+		.read		= amd_uncore_common_read,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 		.module		= THIS_MODULE,
 	};
@@ -911,8 +479,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		goto done;
 	}
 
-	pr_info("%d %s%s counters detected\n", pmu->num_counters,
-		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON " : "",
+	pr_info("%d %s counters detected\n", pmu->num_counters,
 		pmu->pmu.name);
 
 	uncore->num_pmus = 1;
@@ -920,14 +487,14 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 done:
 	uncore->init_done = true;
 
-	return amd_uncore_ctx_init(uncore, cpu);
+	return amd_uncore_common_ctx_init(uncore, cpu);
 }
 
 static int amd_uncore_umc_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	int ret = amd_uncore_event_init(event);
 
+	int ret = amd_uncore_common_event_init(event);
 	if (ret)
 		return ret;
 
@@ -938,12 +505,12 @@ static int amd_uncore_umc_event_init(struct perf_event *event)
 
 static void amd_uncore_umc_start(struct perf_event *event, int flags)
 {
-	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
-	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct amd_uncore_common_pmu *pmu = event_to_amd_uncore_common_pmu(event);
+	struct amd_uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
 	if (!ctx->nr_active++)
-		amd_uncore_start_hrtimer(ctx);
+		amd_uncore_common_start_hrtimer(ctx);
 
 	if (flags & PERF_EF_RELOAD)
 		wrmsrq(hwc->event_base, (u64)local64_read(&hwc->prev_count));
@@ -988,10 +555,10 @@ static void amd_uncore_umc_read(struct perf_event *event)
 }
 
 static
-void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
+void amd_uncore_umc_ctx_scan(struct amd_uncore_common *uncore, unsigned int cpu)
 {
 	union cpuid_0x80000022_ebx ebx;
-	union amd_uncore_info info;
+	union amd_uncore_common_info info;
 	unsigned int eax, ecx, edx;
 
 	if (pmu_version < 2)
@@ -1006,13 +573,13 @@ void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 }
 
 static
-int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
+int amd_uncore_umc_ctx_init(struct amd_uncore_common *uncore, unsigned int cpu)
 {
 	DECLARE_BITMAP(gmask, UNCORE_GROUP_MAX) = { 0 };
 	u8 group_num_pmus[UNCORE_GROUP_MAX] = { 0 };
 	u8 group_num_pmcs[UNCORE_GROUP_MAX] = { 0 };
-	union amd_uncore_info info;
-	struct amd_uncore_pmu *pmu;
+	union amd_uncore_common_info info;
+	struct amd_uncore_common_pmu *pmu;
 	int gid, i;
 	u16 index = 0;
 
@@ -1021,12 +588,13 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 
 	/* Run just once */
 	if (uncore->init_done)
-		return amd_uncore_ctx_init(uncore, cpu);
+		return amd_uncore_common_ctx_init(uncore, cpu);
 
 	/* Find unique groups */
 	for_each_online_cpu(i) {
 		info = *per_cpu_ptr(uncore->info, i);
 		gid = info.split.gid;
+
 		if (test_bit(gid, gmask))
 			continue;
 
@@ -1051,8 +619,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 			pmu->msr_base = MSR_F19H_UMC_PERF_CTL + i * pmu->num_counters * 2;
 			pmu->rdpmc_base = -1;
 			pmu->group = gid;
-
-			pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
+			pmu->ctx = alloc_percpu(struct amd_uncore_common_ctx *);
 			if (!pmu->ctx)
 				goto done;
 
@@ -1061,10 +628,10 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				.attr_groups	= amd_uncore_umc_attr_groups,
 				.name		= pmu->name,
 				.event_init	= amd_uncore_umc_event_init,
-				.add		= amd_uncore_add,
-				.del		= amd_uncore_del,
+				.add		= amd_uncore_common_add,
+				.del		= amd_uncore_common_del,
 				.start		= amd_uncore_umc_start,
-				.stop		= amd_uncore_stop,
+				.stop		= amd_uncore_common_stop,
 				.read		= amd_uncore_umc_read,
 				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 				.module		= THIS_MODULE,
@@ -1087,41 +654,40 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	uncore->num_pmus = index;
 	uncore->init_done = true;
 
-	return amd_uncore_ctx_init(uncore, cpu);
+	return amd_uncore_common_ctx_init(uncore, cpu);
 }
 
-static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
+static struct amd_uncore_common uncores[UNCORE_TYPE_MAX] = {
 	/* UNCORE_TYPE_DF */
 	{
 		.scan = amd_uncore_df_ctx_scan,
 		.init = amd_uncore_df_ctx_init,
-		.move = amd_uncore_ctx_move,
-		.free = amd_uncore_ctx_free,
+		.move = amd_uncore_common_ctx_move,
+		.free = amd_uncore_common_ctx_free,
 	},
 	/* UNCORE_TYPE_L3 */
 	{
 		.scan = amd_uncore_l3_ctx_scan,
 		.init = amd_uncore_l3_ctx_init,
-		.move = amd_uncore_ctx_move,
-		.free = amd_uncore_ctx_free,
+		.move = amd_uncore_common_ctx_move,
+		.free = amd_uncore_common_ctx_free,
 	},
 	/* UNCORE_TYPE_UMC */
 	{
 		.scan = amd_uncore_umc_ctx_scan,
 		.init = amd_uncore_umc_ctx_init,
-		.move = amd_uncore_ctx_move,
-		.free = amd_uncore_ctx_free,
+		.move = amd_uncore_common_ctx_move,
+		.free = amd_uncore_common_ctx_free,
 	},
 };
 
 static int __init amd_uncore_init(void)
 {
-	struct amd_uncore *uncore;
+	struct amd_uncore_common *uncore;
 	int ret = -ENODEV;
 	int i;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
@@ -1130,6 +696,8 @@ static int __init amd_uncore_init(void)
 	if (boot_cpu_has(X86_FEATURE_PERFMON_V2))
 		pmu_version = 2;
 
+	amd_uncore_common_set_update_interval(update_interval);
+
 	for (i = 0; i < UNCORE_TYPE_MAX; i++) {
 		uncore = &uncores[i];
 
@@ -1138,7 +706,7 @@ static int __init amd_uncore_init(void)
 		BUG_ON(!uncore->move);
 		BUG_ON(!uncore->free);
 
-		uncore->info = alloc_percpu(union amd_uncore_info);
+		uncore->info = alloc_percpu(union amd_uncore_common_info);
 		if (!uncore->info) {
 			ret = -ENOMEM;
 			goto fail;
@@ -1187,8 +755,8 @@ static int __init amd_uncore_init(void)
 
 static void __exit amd_uncore_exit(void)
 {
-	struct amd_uncore *uncore;
-	struct amd_uncore_pmu *pmu;
+	struct amd_uncore_common *uncore;
+	struct amd_uncore_common_pmu *pmu;
 	int i, j;
 
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE);
-- 
2.34.1


