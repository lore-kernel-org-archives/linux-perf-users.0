Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4047D236A73;
	Tue, 19 May 2026 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161589; cv=none; b=L7QJ9CAyH4mVppYHTWBV5jk1TcAzkeA1WaNEm23A6dJXO9dvTyL5LqKrkMEvmRts0jRSQXPctFT7YlwzPs8eT2M9tQtJFzTSK/dORIUo4l73m5aRnLB4OEQcGoes4b3uBMtRzZktXnvgUXWlgU86q+dFwhL6ARrvtyp7NL2fVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161589; c=relaxed/simple;
	bh=T3Lz1by1HQVAW4dYR0txXIenZZ4KnjRAfhQPsuWf2Gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5XVvpXCrK6RtB8oCuwu9XDL3UGXv5kkuXz+1cwC4ijFYliteVUjcRV1ppyQQ6v9Af2C8nZBxLmWOiVuCUdHTN2TzhmzzcimFpCtCh51eHS/kzdREuF+CpyERgrZPsS95J1NbIzAPuszgKmdr22c+Q/Ev2TwtdJHn7nRbTLTIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gKKxR3KRXzT1qv;
	Tue, 19 May 2026 11:32:43 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gKKxP3sGtzT1qQ;
	Tue, 19 May 2026 11:32:41 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id A7E0E5955;
	Tue, 19 May 2026 11:32:36 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 19 May
 2026 11:32:41 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>, <x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>, Zhenglang Hu <huzhenglang@hygon.cn>
Subject: [RFC PATCH 1/3] perf/x86/amd/uncore: Add common PMU helper functions
Date: Tue, 19 May 2026 03:32:23 +0000
Message-ID: <20260519033225.1479907-2-liuqi@hygon.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519033225.1479907-1-liuqi@hygon.cn>
References: <20260519033225.1479907-1-liuqi@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

Add common helper functions for AMD-family uncore PMU handling.

The helpers cover event initialization, counter allocation, counter
read/update, event start/stop and per-CPU context management.  These
paths are not tied to a specific uncore unit and can be reused by
drivers with a similar uncore PMU programming model.

Signed-off-by: Qi Liu <liuqi@hygon.cn>
Tested-by: Zhenglang Hu <huzhenglang@hygon.cn>
---
 arch/x86/events/amd/uncore_common.c | 390 ++++++++++++++++++++++++++++
 arch/x86/events/amd/uncore_common.h | 113 ++++++++
 2 files changed, 503 insertions(+)
 create mode 100644 arch/x86/events/amd/uncore_common.c
 create mode 100644 arch/x86/events/amd/uncore_common.h

diff --git a/arch/x86/events/amd/uncore_common.c b/arch/x86/events/amd/uncore_common.c
new file mode 100644
index 000000000000..a6d50fe803df
--- /dev/null
+++ b/arch/x86/events/amd/uncore_common.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Common uncore PMU helpers for AMD-family x86 processors.
+ */
+
+#include <linux/cpumask.h>
+#include <linux/hrtimer.h>
+#include <linux/percpu.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
+#include <asm/msr.h>
+#include <asm/perf_event.h>
+
+#include "uncore_common.h"
+
+#define COUNTER_SHIFT		16
+#define NUM_COUNTERS_MAX	64
+
+/* Interval for hrtimer, defaults to 60000 milliseconds */
+static unsigned int uncore_update_interval = 60 * MSEC_PER_SEC;
+
+void uncore_common_set_update_interval(unsigned int interval)
+{
+	uncore_update_interval = interval;
+}
+
+struct uncore_common_pmu *event_to_uncore_common_pmu(struct perf_event *event)
+{
+	return container_of(event->pmu, struct uncore_common_pmu, pmu);
+}
+
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct pmu *ptr = dev_get_drvdata(dev);
+	struct uncore_common_pmu *pmu;
+
+	pmu = container_of(ptr, struct uncore_common_pmu, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu->active_mask);
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *uncore_common_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+struct attribute_group uncore_common_attr_group = {
+	.attrs = uncore_common_attrs,
+};
+
+static enum hrtimer_restart uncore_common_hrtimer(struct hrtimer *hrtimer)
+{
+	struct uncore_common_ctx *ctx;
+	struct perf_event *event;
+	int bit;
+
+	ctx = container_of(hrtimer, struct uncore_common_ctx, hrtimer);
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
+
+	return HRTIMER_RESTART;
+}
+
+void uncore_common_start_hrtimer(struct uncore_common_ctx *ctx)
+{
+	hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
+		      HRTIMER_MODE_REL_PINNED_HARD);
+}
+
+static void uncore_common_cancel_hrtimer(struct uncore_common_ctx *ctx)
+{
+	hrtimer_cancel(&ctx->hrtimer);
+}
+
+static void uncore_common_init_hrtimer(struct uncore_common_ctx *ctx)
+{
+	hrtimer_setup(&ctx->hrtimer, uncore_common_hrtimer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD);
+}
+
+void uncore_common_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, new;
+	s64 delta;
+
+	/*
+	 * since we do not enable counter overflow interrupts,
+	 * we do not have to worry about prev_count changing on us
+	 */
+	prev = local64_read(&hwc->prev_count);
+
+	/*
+	 * Some uncore PMUs do not have RDPMC assignments. In such cases,
+	 * read counts directly from the corresponding PERF_CTR.
+	 */
+	if (hwc->event_base_rdpmc < 0)
+		rdmsrq(hwc->event_base, new);
+	else
+		new = rdpmc(hwc->event_base_rdpmc);
+
+	local64_set(&hwc->prev_count, new);
+
+	delta = (new << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
+	delta >>= COUNTER_SHIFT;
+
+	local64_add(delta, &event->count);
+}
+
+void uncore_common_start(struct perf_event *event, int flags)
+{
+	struct uncore_common_pmu *pmu = event_to_uncore_common_pmu(event);
+	struct uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!ctx->nr_active++)
+		uncore_common_start_hrtimer(ctx);
+
+	if (flags & PERF_EF_RELOAD)
+		wrmsrq(hwc->event_base, (u64)local64_read(&hwc->prev_count));
+
+	hwc->state = 0;
+
+	__set_bit(hwc->idx, ctx->active_mask);
+	wrmsrq(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
+
+	perf_event_update_userpage(event);
+}
+
+void uncore_common_stop(struct perf_event *event, int flags)
+{
+	struct uncore_common_pmu *pmu = event_to_uncore_common_pmu(event);
+	struct uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	wrmsrq(hwc->config_base, hwc->config);
+	hwc->state |= PERF_HES_STOPPED;
+
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		event->pmu->read(event);
+		hwc->state |= PERF_HES_UPTODATE;
+	}
+
+	if (!--ctx->nr_active)
+		uncore_common_cancel_hrtimer(ctx);
+
+	__clear_bit(hwc->idx, ctx->active_mask);
+}
+
+int uncore_common_event_init(struct perf_event *event)
+{
+	struct uncore_common_pmu *pmu;
+	struct uncore_common_ctx *ctx;
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	pmu = event_to_uncore_common_pmu(event);
+	ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	if (!ctx)
+		return -ENODEV;
+
+	hwc->config = event->attr.config;
+	hwc->idx = -1;
+
+	event->cpu = ctx->cpu;
+
+	return 0;
+}
+
+int uncore_common_add(struct perf_event *event, int flags)
+{
+	struct uncore_common_pmu *pmu = event_to_uncore_common_pmu(event);
+	struct uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct hw_perf_event *hwc = &event->hw;
+	int i;
+
+	/* are we already assigned? */
+	if (hwc->idx != -1 && ctx->events[hwc->idx] == event)
+		goto out;
+
+	for (i = 0; i < pmu->num_counters; i++) {
+		if (ctx->events[i] == event) {
+			hwc->idx = i;
+			goto out;
+		}
+	}
+
+	/* if not, take the first available counter */
+	hwc->idx = -1;
+
+	for (i = 0; i < pmu->num_counters; i++) {
+		struct perf_event *tmp = NULL;
+
+		if (try_cmpxchg(&ctx->events[i], &tmp, event)) {
+			hwc->idx = i;
+			break;
+		}
+	}
+
+out:
+	if (hwc->idx == -1)
+		return -EBUSY;
+
+	hwc->config_base = pmu->msr_base + (2 * hwc->idx);
+	hwc->event_base = pmu->msr_base + 1 + (2 * hwc->idx);
+	hwc->event_base_rdpmc = pmu->rdpmc_base + hwc->idx;
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (pmu->rdpmc_base < 0)
+		hwc->event_base_rdpmc = -1;
+
+	if (flags & PERF_EF_START)
+		event->pmu->start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+void uncore_common_del(struct perf_event *event, int flags)
+{
+	struct uncore_common_pmu *pmu = event_to_uncore_common_pmu(event);
+	struct uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct hw_perf_event *hwc = &event->hw;
+	int i;
+
+	event->pmu->stop(event, PERF_EF_UPDATE);
+
+	for (i = 0; i < pmu->num_counters; i++) {
+		struct perf_event *tmp = event;
+
+		if (try_cmpxchg(&ctx->events[i], &tmp, NULL))
+			break;
+	}
+
+	hwc->idx = -1;
+}
+
+int uncore_common_ctx_init(struct uncore_common *uncore, unsigned int cpu)
+{
+	struct uncore_common_ctx *curr, *prev;
+	struct uncore_common_pmu *pmu;
+	int node, cid, gid;
+	int i, j;
+
+	if (!uncore->init_done || !uncore->num_pmus)
+		return 0;
+
+	cid = uncore_common_ctx_cid(uncore, cpu);
+	gid = uncore_common_ctx_gid(uncore, cpu);
+
+	for (i = 0; i < uncore->num_pmus; i++) {
+		pmu = &uncore->pmus[i];
+		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
+		curr = NULL;
+
+		if (gid != pmu->group)
+			continue;
+
+		for_each_online_cpu(j) {
+			if (cpu == j)
+				continue;
+
+			prev = *per_cpu_ptr(pmu->ctx, j);
+			if (!prev)
+				continue;
+
+			if (cid == uncore_common_ctx_cid(uncore, j)) {
+				curr = prev;
+				break;
+			}
+		}
+
+		if (!curr) {
+			node = cpu_to_node(cpu);
+
+			curr = kzalloc_node(sizeof(*curr), GFP_KERNEL, node);
+			if (!curr)
+				goto fail;
+
+			curr->cpu = cpu;
+			curr->events = kzalloc_node(sizeof(*curr->events) *
+						    pmu->num_counters,
+						    GFP_KERNEL, node);
+			if (!curr->events) {
+				kfree(curr);
+				goto fail;
+			}
+
+			uncore_common_init_hrtimer(curr);
+			curr->hrtimer_duration = (u64)uncore_update_interval * NSEC_PER_MSEC;
+
+			cpumask_set_cpu(cpu, &pmu->active_mask);
+		}
+
+		curr->refcnt++;
+		*per_cpu_ptr(pmu->ctx, cpu) = curr;
+	}
+
+	return 0;
+
+fail:
+	uncore_common_ctx_free(uncore, cpu);
+
+	return -ENOMEM;
+}
+
+void uncore_common_ctx_free(struct uncore_common *uncore, unsigned int cpu)
+{
+	struct uncore_common_pmu *pmu;
+	struct uncore_common_ctx *ctx;
+	int i;
+
+	if (!uncore->init_done)
+		return;
+
+	for (i = 0; i < uncore->num_pmus; i++) {
+		pmu = &uncore->pmus[i];
+
+		if (!pmu->ctx)
+			continue;
+
+		ctx = *per_cpu_ptr(pmu->ctx, cpu);
+		if (!ctx)
+			continue;
+
+		if (cpu == ctx->cpu)
+			cpumask_clear_cpu(cpu, &pmu->active_mask);
+
+		if (!--ctx->refcnt) {
+			kfree(ctx->events);
+			kfree(ctx);
+		}
+
+		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
+	}
+}
+
+void uncore_common_ctx_move(struct uncore_common *uncore, unsigned int cpu)
+{
+	struct uncore_common_ctx *curr, *next;
+	struct uncore_common_pmu *pmu;
+	int i, j;
+
+	if (!uncore->init_done)
+		return;
+
+	for (i = 0; i < uncore->num_pmus; i++) {
+		pmu = &uncore->pmus[i];
+		if (!pmu->ctx)
+			continue;
+
+		curr = *per_cpu_ptr(pmu->ctx, cpu);
+		if (!curr)
+			continue;
+
+		for_each_online_cpu(j) {
+			if (cpu == j)
+				continue;
+
+			next = *per_cpu_ptr(pmu->ctx, j);
+			if (!next)
+				continue;
+
+			if (curr == next) {
+				perf_pmu_migrate_context(&pmu->pmu, cpu, j);
+				cpumask_clear_cpu(cpu, &pmu->active_mask);
+				cpumask_set_cpu(j, &pmu->active_mask);
+				next->cpu = j;
+				break;
+			}
+		}
+	}
+}
diff --git a/arch/x86/events/amd/uncore_common.h b/arch/x86/events/amd/uncore_common.h
new file mode 100644
index 000000000000..3657b22268c0
--- /dev/null
+++ b/arch/x86/events/amd/uncore_common.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _X86_EVENTS_UNCORE_COMMON_H
+#define _X86_EVENTS_UNCORE_COMMON_H
+
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/hrtimer.h>
+#include <linux/perf_event.h>
+#include <linux/percpu.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#define UNCORE_NAME_LEN		16
+#define UNCORE_GROUP_MAX	256
+#define NUM_COUNTERS_MAX	64
+
+#define DEFINE_UNCORE_FORMAT_ATTR(_var, _name, _format)			\
+static ssize_t __uncore_##_var##_show(struct device *dev,		\
+				struct device_attribute *attr,		\
+				char *page)				\
+{									\
+	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
+	return sprintf(page, _format "\n");				\
+}									\
+static struct device_attribute format_attr_##_var =			\
+	__ATTR(_name, 0444, __uncore_##_var##_show, NULL)
+
+union uncore_common_info {
+	struct {
+		u64 aux_data:32;
+		u64 num_pmcs:8;
+		u64 gid:8;
+		u64 cid:8;
+		u64 private:8;
+	} split;
+	u64 full;
+};
+
+struct uncore_common_ctx {
+	int refcnt;
+	int cpu;
+	struct perf_event **events;
+	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
+	int nr_active;
+	struct hrtimer hrtimer;
+	u64 hrtimer_duration;
+};
+
+struct uncore_common_pmu {
+	char name[UNCORE_NAME_LEN];
+	int num_counters;
+	int rdpmc_base;
+	u32 msr_base;
+	int group;
+	cpumask_t active_mask;
+	struct pmu pmu;
+	struct uncore_common_ctx * __percpu *ctx;
+	void *private;
+};
+
+struct uncore_common {
+	union uncore_common_info __percpu *info;
+	struct uncore_common_pmu *pmus;
+	unsigned int num_pmus;
+	bool init_done;
+	void (*scan)(struct uncore_common *uncore, unsigned int cpu);
+	int (*init)(struct uncore_common *uncore, unsigned int cpu);
+	void (*move)(struct uncore_common *uncore, unsigned int cpu);
+	void (*free)(struct uncore_common *uncore, unsigned int cpu);
+};
+
+extern struct attribute_group uncore_common_attr_group;
+
+static inline int uncore_common_ctx_cid(struct uncore_common *uncore,
+					unsigned int cpu)
+{
+	union uncore_common_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.cid;
+}
+
+static inline int uncore_common_ctx_gid(struct uncore_common *uncore,
+					unsigned int cpu)
+{
+	union uncore_common_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.gid;
+}
+
+static inline int uncore_common_ctx_num_pmcs(struct uncore_common *uncore,
+					     unsigned int cpu)
+{
+	union uncore_common_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.num_pmcs;
+}
+
+struct uncore_common_pmu *event_to_uncore_common_pmu(struct perf_event *event);
+
+void uncore_common_set_update_interval(unsigned int interval);
+int uncore_common_event_init(struct perf_event *event);
+int uncore_common_add(struct perf_event *event, int flags);
+void uncore_common_del(struct perf_event *event, int flags);
+void uncore_common_start(struct perf_event *event, int flags);
+void uncore_common_stop(struct perf_event *event, int flags);
+void uncore_common_read(struct perf_event *event);
+
+int uncore_common_ctx_init(struct uncore_common *uncore, unsigned int cpu);
+void uncore_common_ctx_free(struct uncore_common *uncore, unsigned int cpu);
+void uncore_common_ctx_move(struct uncore_common *uncore, unsigned int cpu);
+void uncore_common_start_hrtimer(struct uncore_common_ctx *ctx);
+
+#endif /* _X86_EVENTS_UNCORE_COMMON_H */
-- 
2.34.1


