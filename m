Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AF33F6613;
	Wed,  1 Jul 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898493; cv=none; b=PM4YXsa+unuSaKlqMiBkkluFVBapkYYxIJJCD0cWebB1PNlvCK8JHR46/qfvHZlVMLIbl8I/SlgoNHBtBCZ5rTmddqhWtTjW3Fz2+ckLNsE7tc6A95cHCLttjPspS8XBxu6lTt4nhDXY3PUGahS1XozguMKOFkjx7m2P2F+x8IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898493; c=relaxed/simple;
	bh=Kq7iguTmtIVj6ISmAODpW4xKsajg+TEoj5eTwRUIGyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=to79KQcvmHNK/t7A1m86q6HDeon0pm4bwgTLP7fvTlTQ5oxEMwEEJu8CHMVjX9tmogQr8qmbq7v+2eqibMfLVq89UdX3US4MNjiSdYQlV6Ob0+6DW/TAomHcpvBaKqT/Cm3UT7hPMrRUFFARiVe8ZEfWSTLRmItLMig6ec/tNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqvx53974zT0bp;
	Wed,  1 Jul 2026 17:34:33 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gqvx31LS7zT0bp;
	Wed,  1 Jul 2026 17:34:31 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 284623008F68;
	Wed,  1 Jul 2026 17:32:30 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 1 Jul
 2026 17:34:30 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>, <x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>, Zhenglang Hu <huzhenglang@hygon.cn>
Subject: [PATCH v2 1/3] perf/x86/amd/uncore: Add common PMU helper functions
Date: Wed, 1 Jul 2026 09:34:15 +0000
Message-ID: <20260701093417.1312443-2-liuqi@hygon.cn>
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

Add common helper functions for AMD-family uncore PMU handling.

The helpers cover event initialization, counter allocation, counter
read/update, event start/stop and per-CPU context management.  These
paths are not tied to a specific uncore unit and can be reused by
drivers with a similar uncore PMU programming model.

Signed-off-by: Qi Liu <liuqi@hygon.cn>
Tested-by: Zhenglang Hu <huzhenglang@hygon.cn>
---
 arch/x86/events/Kconfig                 |   4 +
 arch/x86/events/amd/Makefile            |   2 +
 arch/x86/events/amd/amd_uncore_common.c | 403 ++++++++++++++++++++++++
 arch/x86/events/amd/amd_uncore_common.h | 114 +++++++
 4 files changed, 523 insertions(+)
 create mode 100644 arch/x86/events/amd/amd_uncore_common.c
 create mode 100644 arch/x86/events/amd/amd_uncore_common.h

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index dabdf3d7bf84..ecbcb6efc3a1 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -34,6 +34,10 @@ config PERF_EVENTS_AMD_POWER
 	  (CPUID Fn8000_0007_EDX[12]) interface to calculate the
 	  average power consumption on Family 15h processors.
 
+config PERF_EVENTS_AMD_UNCORE_COMMON
+	tristate
+	depends on PERF_EVENTS
+
 config PERF_EVENTS_AMD_UNCORE
 	tristate "AMD Uncore performance events"
 	depends on PERF_EVENTS && CPU_SUP_AMD
diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index 527d947eb76b..3c23ed125fc9 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -3,6 +3,8 @@ obj-$(CONFIG_CPU_SUP_AMD)		+= core.o lbr.o
 obj-$(CONFIG_PERF_EVENTS_AMD_BRS)	+= brs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
 obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
+obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE_COMMON) += amd-uncore-common.o
+amd-uncore-common-objs := amd_uncore_common.o
 obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE)	+= amd-uncore.o
 amd-uncore-objs				:= uncore.o
 ifdef CONFIG_AMD_IOMMU
diff --git a/arch/x86/events/amd/amd_uncore_common.c b/arch/x86/events/amd/amd_uncore_common.c
new file mode 100644
index 000000000000..d9b066b39cb3
--- /dev/null
+++ b/arch/x86/events/amd/amd_uncore_common.c
@@ -0,0 +1,403 @@
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
+#include "amd_uncore_common.h"
+
+/* Interval for hrtimer, defaults to 60000 milliseconds */
+static unsigned int uncore_update_interval = 60 * MSEC_PER_SEC;
+
+void amd_uncore_common_set_update_interval(unsigned int interval)
+{
+	uncore_update_interval = interval;
+}
+EXPORT_SYMBOL_GPL(amd_uncore_common_set_update_interval);
+
+struct amd_uncore_common_pmu *event_to_amd_uncore_common_pmu(struct perf_event *event)
+{
+	return container_of(event->pmu, struct amd_uncore_common_pmu, pmu);
+}
+EXPORT_SYMBOL_GPL(event_to_amd_uncore_common_pmu);
+
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct pmu *ptr = dev_get_drvdata(dev);
+	struct amd_uncore_common_pmu *pmu;
+
+	pmu = container_of(ptr, struct amd_uncore_common_pmu, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu->active_mask);
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *amd_uncore_common_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+struct attribute_group amd_uncore_common_attr_group = {
+	.attrs = amd_uncore_common_attrs,
+};
+EXPORT_SYMBOL_GPL(amd_uncore_common_attr_group);
+
+static enum hrtimer_restart amd_uncore_common_hrtimer(struct hrtimer *hrtimer)
+{
+	struct amd_uncore_common_ctx *ctx;
+	struct perf_event *event;
+	int bit;
+
+	ctx = container_of(hrtimer, struct amd_uncore_common_ctx, hrtimer);
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
+void amd_uncore_common_start_hrtimer(struct amd_uncore_common_ctx *ctx)
+{
+	hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
+		      HRTIMER_MODE_REL_PINNED_HARD);
+}
+EXPORT_SYMBOL_GPL(amd_uncore_common_start_hrtimer);
+
+static void amd_uncore_common_cancel_hrtimer(struct amd_uncore_common_ctx *ctx)
+{
+	hrtimer_cancel(&ctx->hrtimer);
+}
+
+static void amd_uncore_common_init_hrtimer(struct amd_uncore_common_ctx *ctx)
+{
+	hrtimer_setup(&ctx->hrtimer, amd_uncore_common_hrtimer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD);
+}
+
+void amd_uncore_common_read(struct perf_event *event)
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
+EXPORT_SYMBOL_GPL(amd_uncore_common_read);
+
+void amd_uncore_common_start(struct perf_event *event, int flags)
+{
+	struct amd_uncore_common_pmu *pmu = event_to_amd_uncore_common_pmu(event);
+	struct amd_uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!ctx->nr_active++)
+		amd_uncore_common_start_hrtimer(ctx);
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
+EXPORT_SYMBOL_GPL(amd_uncore_common_start);
+
+void amd_uncore_common_stop(struct perf_event *event, int flags)
+{
+	struct amd_uncore_common_pmu *pmu = event_to_amd_uncore_common_pmu(event);
+	struct amd_uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
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
+		amd_uncore_common_cancel_hrtimer(ctx);
+
+	__clear_bit(hwc->idx, ctx->active_mask);
+}
+EXPORT_SYMBOL_GPL(amd_uncore_common_stop);
+
+int amd_uncore_common_event_init(struct perf_event *event)
+{
+	struct amd_uncore_common_pmu *pmu;
+	struct amd_uncore_common_ctx *ctx;
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	pmu = event_to_amd_uncore_common_pmu(event);
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
+EXPORT_SYMBOL_GPL(amd_uncore_common_event_init);
+
+int amd_uncore_common_add(struct perf_event *event, int flags)
+{
+	struct amd_uncore_common_pmu *pmu = event_to_amd_uncore_common_pmu(event);
+	struct amd_uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
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
+EXPORT_SYMBOL_GPL(amd_uncore_common_add);
+
+void amd_uncore_common_del(struct perf_event *event, int flags)
+{
+	struct amd_uncore_common_pmu *pmu = event_to_amd_uncore_common_pmu(event);
+	struct amd_uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
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
+EXPORT_SYMBOL_GPL(amd_uncore_common_del);
+
+int amd_uncore_common_ctx_init(struct amd_uncore_common *uncore, unsigned int cpu)
+{
+	struct amd_uncore_common_ctx *curr, *prev;
+	struct amd_uncore_common_pmu *pmu;
+	int node, cid, gid;
+	int i, j;
+
+	if (!uncore->init_done || !uncore->num_pmus)
+		return 0;
+
+	cid = amd_uncore_common_ctx_cid(uncore, cpu);
+	gid = amd_uncore_common_ctx_gid(uncore, cpu);
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
+			if (cid == amd_uncore_common_ctx_cid(uncore, j)) {
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
+			amd_uncore_common_init_hrtimer(curr);
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
+	amd_uncore_common_ctx_free(uncore, cpu);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(amd_uncore_common_ctx_init);
+
+void amd_uncore_common_ctx_free(struct amd_uncore_common *uncore, unsigned int cpu)
+{
+	struct amd_uncore_common_pmu *pmu;
+	struct amd_uncore_common_ctx *ctx;
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
+EXPORT_SYMBOL_GPL(amd_uncore_common_ctx_free);
+
+void amd_uncore_common_ctx_move(struct amd_uncore_common *uncore, unsigned int cpu)
+{
+	struct amd_uncore_common_ctx *curr, *next;
+	struct amd_uncore_common_pmu *pmu;
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
+EXPORT_SYMBOL_GPL(amd_uncore_common_ctx_move);
+
+MODULE_DESCRIPTION("AMD uncore common support");
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/events/amd/amd_uncore_common.h b/arch/x86/events/amd/amd_uncore_common.h
new file mode 100644
index 000000000000..70422cbead02
--- /dev/null
+++ b/arch/x86/events/amd/amd_uncore_common.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _X86_EVENTS_AMD_UNCORE_COMMON_H
+#define _X86_EVENTS_AMD_UNCORE_COMMON_H
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
+#define COUNTER_SHIFT		16
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
+union amd_uncore_common_info {
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
+struct amd_uncore_common_ctx {
+	int refcnt;
+	int cpu;
+	struct perf_event **events;
+	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
+	int nr_active;
+	struct hrtimer hrtimer;
+	u64 hrtimer_duration;
+};
+
+struct amd_uncore_common_pmu {
+	char name[UNCORE_NAME_LEN];
+	int num_counters;
+	int rdpmc_base;
+	u32 msr_base;
+	int group;
+	cpumask_t active_mask;
+	struct pmu pmu;
+	struct amd_uncore_common_ctx * __percpu *ctx;
+	void *private;
+};
+
+struct amd_uncore_common {
+	union amd_uncore_common_info __percpu *info;
+	struct amd_uncore_common_pmu *pmus;
+	unsigned int num_pmus;
+	bool init_done;
+	void (*scan)(struct amd_uncore_common *uncore, unsigned int cpu);
+	int (*init)(struct amd_uncore_common *uncore, unsigned int cpu);
+	void (*move)(struct amd_uncore_common *uncore, unsigned int cpu);
+	void (*free)(struct amd_uncore_common *uncore, unsigned int cpu);
+};
+
+extern struct attribute_group amd_uncore_common_attr_group;
+
+static inline int amd_uncore_common_ctx_cid(struct amd_uncore_common *uncore,
+					    unsigned int cpu)
+{
+	union amd_uncore_common_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.cid;
+}
+
+static inline int amd_uncore_common_ctx_gid(struct amd_uncore_common *uncore,
+					    unsigned int cpu)
+{
+	union amd_uncore_common_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.gid;
+}
+
+static inline int amd_uncore_common_ctx_num_pmcs(struct amd_uncore_common *uncore,
+						 unsigned int cpu)
+{
+	union amd_uncore_common_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.num_pmcs;
+}
+
+struct amd_uncore_common_pmu *event_to_amd_uncore_common_pmu(struct perf_event *event);
+
+void amd_uncore_common_set_update_interval(unsigned int interval);
+int amd_uncore_common_event_init(struct perf_event *event);
+int amd_uncore_common_add(struct perf_event *event, int flags);
+void amd_uncore_common_del(struct perf_event *event, int flags);
+void amd_uncore_common_start(struct perf_event *event, int flags);
+void amd_uncore_common_stop(struct perf_event *event, int flags);
+void amd_uncore_common_read(struct perf_event *event);
+
+int amd_uncore_common_ctx_init(struct amd_uncore_common *uncore, unsigned int cpu);
+void amd_uncore_common_ctx_free(struct amd_uncore_common *uncore, unsigned int cpu);
+void amd_uncore_common_ctx_move(struct amd_uncore_common *uncore, unsigned int cpu);
+void amd_uncore_common_start_hrtimer(struct amd_uncore_common_ctx *ctx);
+
+#endif /* _X86_EVENTS_AMD_UNCORE_COMMON_H */
-- 
2.34.1


