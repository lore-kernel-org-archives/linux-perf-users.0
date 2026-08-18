Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF16126158B;
	Tue, 18 Aug 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047319; cv=none; b=dXTY0BIRab12wXU8HC2Awu/+ncsXQc+6/2STbJ5YfC71r/j+Owx6027B+AnRmRCk/5Ru/tASTlORCQMTvkKGzCq5NQaEBmN7a5UZdEgmZVLIEOch+3BRQgq7ry//MXxknH+qmOpk458S3FGo8VYO0Q0CGGGMWNmUH9vJ31VDya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047319; c=relaxed/simple;
	bh=aC8jxNkG0sgpCFjQQ6fMvhVMD2WVYXA/runDYs61u+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8b6T+2gmIoqJ5rq0l3SsGg01VU0MPgbpHclLxeSrBSD0wBRba8iK2n2VNTEeRA2gz+vnnJDZdkbmYNuNBml4oa5x89FabLf0crXT9LKxg4oSXiSpSRAGWKsJuiPCyWpHItcGykTdioVTRQkiCzbErllXknekt/A3ctKlylT+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPQGD02ytz18tXg;
	Tue, 18 Aug 2026 18:01:40 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hPQG96MMVz18tWX;
	Tue, 18 Aug 2026 18:01:37 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 89C7278AD;
	Tue, 18 Aug 2026 18:01:32 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 18 Aug
 2026 18:01:37 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<sandipan.das@amd.com>, <ravi.bangoria@amd.com>, <irogers@google.com>,
	<x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>, Zhenglang Hu <huzhenglang@hygon.cn>
Subject: [PATCH v5 1/2] perf/x86/amd/uncore: Add Hygon uncore PMU support
Date: Tue, 18 Aug 2026 10:01:17 +0000
Message-ID: <20260818100118.12944-2-liuqi@hygon.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818100118.12944-1-liuqi@hygon.cn>
References: <20260818100118.12944-1-liuqi@hygon.cn>
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

Add uncore PMU driver for Hygon Family 18h processors, supporting two
PMU types:

  - hygon_df:     Data Fabric counters shared across CPUs within the
                  same DF instance, identified via Node ID.

  - hygon_df_iod: Data Fabric counters on the IO Die (IOD) for
                  monitoring memory access metrics.

A per-context hrtimer periodically reads the counters since uncore
PMUs do not generate interrupts. CPU hotplug callbacks handle context
creation, migration, and teardown.

Keeping Hygon support in a separate driver avoids accumulating vendor
checks in uncore.c as more Hygon-specific features are introduced.
Remove the now-unnecessary Hygon checks from the AMD uncore driver.

Signed-off-by: Qi Liu <liuqi@hygon.cn>
Tested-by: Zhenglang Hu <huzhenglang@hygon.cn>
---
 arch/x86/events/Kconfig            |  11 +
 arch/x86/events/amd/Makefile       |   2 +
 arch/x86/events/amd/hygon_uncore.c | 872 +++++++++++++++++++++++++++++
 arch/x86/events/amd/uncore.c       |  11 +-
 arch/x86/include/asm/msr-index.h   |   2 +
 arch/x86/include/asm/perf_event.h  |  20 +
 include/linux/cpuhotplug.h         |   3 +
 7 files changed, 913 insertions(+), 8 deletions(-)
 create mode 100644 arch/x86/events/amd/hygon_uncore.c

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index dabdf3d7bf84..cc8387236b95 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -45,6 +45,17 @@ config PERF_EVENTS_AMD_UNCORE
 	  To compile this driver as a module, choose M here: the
 	  module will be called 'amd-uncore'.
 
+config PERF_EVENTS_HYGON_UNCORE
+	tristate "Hygon Uncore performance events"
+	depends on PERF_EVENTS && CPU_SUP_HYGON
+	default y
+	help
+	  Include support for Hygon uncore performance events for use with
+	  e.g., perf stat -e hygon_df/.../.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called 'hygon-uncore'.
+
 config PERF_EVENTS_AMD_BRS
 	depends on PERF_EVENTS && CPU_SUP_AMD
 	bool "AMD Zen3 Branch Sampling support"
diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index 527d947eb76b..c373fd1d1525 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -5,6 +5,8 @@ obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
 obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE)	+= amd-uncore.o
 amd-uncore-objs				:= uncore.o
+obj-$(CONFIG_PERF_EVENTS_HYGON_UNCORE)	+= hygon-uncore.o
+hygon-uncore-objs			:= hygon_uncore.o
 ifdef CONFIG_AMD_IOMMU
 obj-$(CONFIG_CPU_SUP_AMD)		+= iommu.o
 endif
diff --git a/arch/x86/events/amd/hygon_uncore.c b/arch/x86/events/amd/hygon_uncore.c
new file mode 100644
index 000000000000..471955d6fc28
--- /dev/null
+++ b/arch/x86/events/amd/hygon_uncore.c
@@ -0,0 +1,872 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Chengdu Haiguang IC Design Co., Ltd.
+ *
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/cpufeature.h>
+#include <linux/hrtimer.h>
+#include <linux/init.h>
+#include <linux/perf_event.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+
+#include <asm/amd/nb.h>
+#include <asm/cpuid/api.h>
+#include <asm/perf_event.h>
+#include <asm/msr.h>
+
+#define HYGON_UNCORE_NUM_COUNTERS_DF	4
+#define HYGON_UNCORE_NUM_COUNTERS_MAX	8
+
+#define HYGON_UNCORE_NAME_LEN		16
+#define HYGON_UNCORE_COUNTER_SHIFT	16
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"hygon_uncore: " fmt
+
+struct hygon_uncore_ctx {
+	int refcnt;
+	int cpu;
+	struct perf_event **events;
+	unsigned long active_mask[BITS_TO_LONGS(HYGON_UNCORE_NUM_COUNTERS_MAX)];
+	int nr_active;
+	struct hrtimer hrtimer;
+	u64 hrtimer_duration;
+};
+
+struct hygon_uncore_pmu {
+	char name[HYGON_UNCORE_NAME_LEN];
+	int type;
+	int num_counters;
+	u32 msr_base;
+	cpumask_t active_mask;
+	struct pmu pmu;
+	struct hygon_uncore_ctx * __percpu *ctx;
+};
+
+enum {
+	HYGON_UNCORE_TYPE_DF,
+	HYGON_UNCORE_TYPE_DF_IOD,
+	HYGON_UNCORE_TYPE_MAX
+};
+
+union hygon_uncore_info {
+	struct {
+		u64	num_iods:8;	/* number of iods of each package */
+		u64	num_pmcs:8;	/* number of counters */
+		u64	cid:8;		/* context id */
+	} split;
+	u64		full;
+};
+
+struct hygon_uncore {
+	union hygon_uncore_info  __percpu *info;
+	struct hygon_uncore_pmu pmu;
+	bool pmu_registered;
+	bool init_done;
+	void (*scan)(struct hygon_uncore *uncore, unsigned int cpu);
+	int  (*init)(struct hygon_uncore *uncore, unsigned int cpu);
+	void (*move)(struct hygon_uncore *uncore, unsigned int cpu);
+	void (*free)(struct hygon_uncore *uncore, unsigned int cpu);
+};
+static struct hygon_uncore uncores[];
+
+static unsigned int update_interval = 60 * MSEC_PER_SEC;
+module_param(update_interval, uint, 0444);
+
+static struct hygon_uncore_pmu *event_to_hygon_uncore_pmu(struct perf_event *event)
+{
+	return container_of(event->pmu, struct hygon_uncore_pmu, pmu);
+}
+
+static __always_inline bool is_uncore_df_iod_event(struct hygon_uncore_pmu *pmu)
+{
+	return pmu->type == HYGON_UNCORE_TYPE_DF_IOD;
+}
+
+static __always_inline int hygon_uncore_ctx_num_pmcs(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	union hygon_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.num_pmcs;
+}
+
+static __always_inline int hygon_uncore_ctx_cid(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	union hygon_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.cid;
+}
+
+static __always_inline int hygon_uncore_ctx_num_iods(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	union hygon_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.num_iods;
+}
+
+static enum hrtimer_restart hygon_uncore_hrtimer(struct hrtimer *hrtimer)
+{
+	struct hygon_uncore_ctx *ctx;
+	struct perf_event *event;
+	int bit;
+
+	ctx = container_of(hrtimer, struct hygon_uncore_ctx, hrtimer);
+
+	if (!ctx->nr_active || ctx->cpu != smp_processor_id())
+		return HRTIMER_NORESTART;
+
+	for_each_set_bit(bit, ctx->active_mask, HYGON_UNCORE_NUM_COUNTERS_MAX) {
+		event = ctx->events[bit];
+		event->pmu->read(event);
+	}
+
+	hrtimer_forward_now(hrtimer, ns_to_ktime(ctx->hrtimer_duration));
+	return HRTIMER_RESTART;
+}
+
+static void hygon_uncore_start_hrtimer(struct hygon_uncore_ctx *ctx)
+{
+	hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
+		      HRTIMER_MODE_REL_PINNED_HARD);
+}
+
+static void hygon_uncore_cancel_hrtimer(struct hygon_uncore_ctx *ctx)
+{
+	hrtimer_cancel(&ctx->hrtimer);
+}
+
+static void hygon_uncore_init_hrtimer(struct hygon_uncore_ctx *ctx)
+{
+	hrtimer_setup(&ctx->hrtimer, hygon_uncore_hrtimer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD);
+}
+
+static void hygon_uncore_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, cur;
+	s64 delta;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		rdmsrq(hwc->event_base, cur);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, cur) != prev);
+	delta = (cur << HYGON_UNCORE_COUNTER_SHIFT) -
+		(prev << HYGON_UNCORE_COUNTER_SHIFT);
+	delta >>= HYGON_UNCORE_COUNTER_SHIFT;
+	local64_add(delta, &event->count);
+}
+
+static void hygon_uncore_start(struct perf_event *event, int flags)
+{
+	struct hygon_uncore_pmu *pmu = event_to_hygon_uncore_pmu(event);
+	struct hygon_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (!ctx->nr_active++)
+		hygon_uncore_start_hrtimer(ctx);
+
+	if (flags & PERF_EF_RELOAD)
+		wrmsrq(hwc->event_base, (u64)local64_read(&hwc->prev_count));
+
+	hwc->state = 0;
+	__set_bit(hwc->idx, ctx->active_mask);
+	wrmsrq(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
+	perf_event_update_userpage(event);
+}
+
+static void hygon_uncore_stop(struct perf_event *event, int flags)
+{
+	struct hygon_uncore_pmu *pmu = event_to_hygon_uncore_pmu(event);
+	struct hygon_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
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
+		hygon_uncore_cancel_hrtimer(ctx);
+
+	__clear_bit(hwc->idx, ctx->active_mask);
+}
+
+static int hygon_uncore_add(struct perf_event *event, int flags)
+{
+	struct hygon_uncore_pmu *pmu = event_to_hygon_uncore_pmu(event);
+	struct hygon_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct hw_perf_event *hwc = &event->hw;
+	int i, iod_idx;
+
+	if (!ctx)
+		return -ENODEV;
+
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
+	hwc->idx = -1;
+	if (is_uncore_df_iod_event(pmu)) {
+		iod_idx = event->attr.config1;
+		for (i = iod_idx * HYGON_UNCORE_NUM_COUNTERS_DF;
+		     i < (iod_idx + 1) * HYGON_UNCORE_NUM_COUNTERS_DF;
+		     i++) {
+			struct perf_event *tmp = NULL;
+
+			if (try_cmpxchg(&ctx->events[i], &tmp, event)) {
+				hwc->idx = i;
+				break;
+			}
+		}
+	} else {
+		for (i = 0; i < pmu->num_counters; i++) {
+			struct perf_event *tmp = NULL;
+
+			if (try_cmpxchg(&ctx->events[i], &tmp, event)) {
+				hwc->idx = i;
+				break;
+			}
+		}
+	}
+out:
+	if (hwc->idx == -1)
+		return -EBUSY;
+
+	hwc->config_base = pmu->msr_base + (2 * hwc->idx);
+	hwc->event_base = pmu->msr_base + 1 + (2 * hwc->idx);
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+	if (flags & PERF_EF_START)
+		event->pmu->start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+static void hygon_uncore_del(struct perf_event *event, int flags)
+{
+	struct hygon_uncore_pmu *pmu = event_to_hygon_uncore_pmu(event);
+	struct hygon_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct hw_perf_event *hwc = &event->hw;
+	int i;
+
+	if (!ctx)
+		return;
+
+	event->pmu->stop(event, PERF_EF_UPDATE);
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
+static int hygon_uncore_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct hygon_uncore_pmu *pmu;
+	struct hygon_uncore_ctx *ctx;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	pmu = event_to_hygon_uncore_pmu(event);
+	ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	if (!ctx)
+		return -ENODEV;
+
+	event->cpu = ctx->cpu;
+	hwc->config = event->attr.config;
+	hwc->idx = -1;
+
+	return 0;
+}
+
+static int hygon_uncore_df_event_init(struct perf_event *event)
+{
+	int ret = hygon_uncore_event_init(event);
+	struct hw_perf_event *hwc = &event->hw;
+	struct hygon_uncore_pmu *pmu;
+	struct hygon_uncore *uncore;
+	u64 event_mask = HYGON_F18H_RAW_EVENT_MASK_DF;
+
+	if (ret)
+		return ret;
+
+	pmu = event_to_hygon_uncore_pmu(event);
+	uncore = &uncores[pmu->type];
+	if (is_uncore_df_iod_event(pmu) &&
+	    (event->attr.config1 >= hygon_uncore_ctx_num_iods(uncore, event->cpu)))
+		return -EINVAL;
+
+	if (boot_cpu_data.x86_model == 0x4 ||
+	    boot_cpu_data.x86_model == 0x5)
+		event_mask = HYGON_F18H_M4H_RAW_EVENT_MASK_DF;
+	else if (boot_cpu_data.x86_model >= 0x6 &&
+		 boot_cpu_data.x86_model <= 0x18)
+		event_mask = HYGON_F18H_M6H_RAW_EVENT_MASK_DF;
+
+	hwc->config = event->attr.config & event_mask;
+	return 0;
+}
+
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct pmu *ptr = dev_get_drvdata(dev);
+	struct hygon_uncore_pmu *pmu = container_of(ptr, struct hygon_uncore_pmu, pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu->active_mask);
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *hygon_uncore_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group hygon_uncore_attr_group = {
+	.attrs = hygon_uncore_attrs,
+};
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
+DEFINE_UNCORE_FORMAT_ATTR(event,	event,		"config:0-5");
+DEFINE_UNCORE_FORMAT_ATTR(umask8,	umask,		"config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(umask10,	umask,		"config:8-17");		/* F18h M4h DF */
+DEFINE_UNCORE_FORMAT_ATTR(umask12,	umask,		"config:8-19");		/* F18h M6h DF */
+DEFINE_UNCORE_FORMAT_ATTR(compid,	compid,	"config:6-7,32-35,61-62");
+DEFINE_UNCORE_FORMAT_ATTR(iod,		iod,		"config1:0-1");
+
+static struct attribute *hygon_uncore_df_umask_attr(void)
+{
+	if (boot_cpu_data.x86_model == 0x4 ||
+	    boot_cpu_data.x86_model == 0x5)
+		return &format_attr_umask10.attr;
+
+	if (boot_cpu_data.x86_model >= 0x6 &&
+	    boot_cpu_data.x86_model <= 0x18)
+		return &format_attr_umask12.attr;
+
+	return &format_attr_umask8.attr;
+}
+
+static struct attribute *hygon_uncore_df_format_attr[] = {
+	&format_attr_event.attr,	/* event */
+	&format_attr_umask8.attr,	/* umask */
+	&format_attr_compid.attr,	/* compid */
+	NULL,
+};
+
+static struct attribute_group hygon_uncore_df_format_group = {
+	.name = "format",
+	.attrs = hygon_uncore_df_format_attr,
+};
+
+static const struct attribute_group *hygon_uncore_df_attr_groups[] = {
+	&hygon_uncore_attr_group,
+	&hygon_uncore_df_format_group,
+	NULL,
+};
+
+static struct attribute *hygon_uncore_df_iod_format_attr[] = {
+	&format_attr_event.attr,	/* event */
+	&format_attr_umask10.attr,	/* umask */
+	&format_attr_compid.attr,	/* compid */
+	&format_attr_iod.attr,		/* iod */
+	NULL,
+};
+
+static struct attribute_group hygon_uncore_df_iod_format_group = {
+	.name = "format",
+	.attrs = hygon_uncore_df_iod_format_attr,
+};
+
+static const struct attribute_group *hygon_uncore_df_iod_attr_groups[] = {
+	&hygon_uncore_attr_group,
+	&hygon_uncore_df_iod_format_group,
+	NULL,
+};
+
+static int hygon_uncore_cpu_starting(unsigned int cpu)
+{
+	struct hygon_uncore *uncore;
+	int i;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		uncore->scan(uncore, cpu);
+	}
+
+	return 0;
+}
+
+static int hygon_uncore_cpu_dead(unsigned int cpu)
+{
+	struct hygon_uncore *uncore;
+	int i;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		uncore->free(uncore, cpu);
+	}
+
+	return 0;
+}
+
+static int hygon_uncore_cpu_online(unsigned int cpu)
+{
+	struct hygon_uncore *uncore;
+	int i;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		if (uncore->init(uncore, cpu))
+			continue;
+	}
+
+	return 0;
+}
+
+static int hygon_uncore_cpu_down_prepare(unsigned int cpu)
+{
+	struct hygon_uncore *uncore;
+	int i;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		uncore->move(uncore, cpu);
+	}
+
+	return 0;
+}
+
+static void hygon_uncore_ctx_free(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	struct hygon_uncore_pmu *pmu = &uncore->pmu;
+	struct hygon_uncore_ctx *ctx;
+
+	if (!uncore->init_done || !uncore->pmu_registered)
+		return;
+
+	if (!pmu->ctx)
+		return;
+
+	ctx = *per_cpu_ptr(pmu->ctx, cpu);
+	if (!ctx)
+		return;
+
+	if (cpu == ctx->cpu)
+		cpumask_clear_cpu(cpu, &pmu->active_mask);
+
+	if (!--ctx->refcnt) {
+		hygon_uncore_cancel_hrtimer(ctx);
+		kfree(ctx->events);
+		kfree(ctx);
+	}
+
+	*per_cpu_ptr(pmu->ctx, cpu) = NULL;
+}
+
+static void hygon_uncore_ctx_move(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	struct hygon_uncore_pmu *pmu = &uncore->pmu;
+	struct hygon_uncore_ctx *curr, *next;
+	int i;
+
+	if (!uncore->init_done || !uncore->pmu_registered)
+		return;
+
+	if (!pmu->ctx)
+		return;
+
+	curr = *per_cpu_ptr(pmu->ctx, cpu);
+	if (!curr)
+		return;
+
+	for_each_online_cpu(i) {
+		next = *per_cpu_ptr(pmu->ctx, i);
+		if (!next || cpu == i)
+			continue;
+
+		if (curr == next) {
+			perf_pmu_migrate_context(&pmu->pmu, cpu, i);
+			cpumask_clear_cpu(cpu, &pmu->active_mask);
+			cpumask_set_cpu(i, &pmu->active_mask);
+			next->cpu = i;
+			break;
+		}
+	}
+}
+
+static int hygon_uncore_ctx_init(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	struct hygon_uncore_ctx *curr, *prev;
+	struct hygon_uncore_pmu *pmu = &uncore->pmu;
+	int node, cid, i;
+
+	if (!uncore->init_done || !uncore->pmu_registered)
+		return 0;
+
+	if (!pmu->ctx)
+		return 0;
+
+	cid = hygon_uncore_ctx_cid(uncore, cpu);
+	*per_cpu_ptr(pmu->ctx, cpu) = NULL;
+	curr = NULL;
+
+	for_each_online_cpu(i) {
+		if (cpu == i)
+			continue;
+
+		prev = *per_cpu_ptr(pmu->ctx, i);
+		if (!prev)
+			continue;
+		if (cid == hygon_uncore_ctx_cid(uncore, i)) {
+			curr = prev;
+			break;
+		}
+	}
+
+	if (!curr) {
+		node = cpu_to_node(cpu);
+		curr = kzalloc_node(sizeof(*curr), GFP_KERNEL, node);
+		if (!curr)
+			goto fail;
+
+		curr->cpu = cpu;
+		curr->events = kzalloc_node(sizeof(*curr->events) *
+					    pmu->num_counters,
+					    GFP_KERNEL, node);
+		if (!curr->events) {
+			kfree(curr);
+			goto fail;
+		}
+
+		cpumask_set_cpu(cpu, &pmu->active_mask);
+
+		hygon_uncore_init_hrtimer(curr);
+		curr->hrtimer_duration = (u64)update_interval * NSEC_PER_MSEC;
+	}
+
+	curr->refcnt++;
+	*per_cpu_ptr(pmu->ctx, cpu) = curr;
+
+	return 0;
+
+fail:
+	hygon_uncore_ctx_free(uncore, cpu);
+
+	return -ENOMEM;
+}
+
+static void hygon_uncore_df_ctx_scan(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	union hygon_uncore_info info = {};
+
+	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
+		return;
+
+	info.split.num_iods = 0;
+	info.split.num_pmcs = HYGON_UNCORE_NUM_COUNTERS_DF;
+	info.split.cid = topology_amd_node_id(cpu);
+
+	*per_cpu_ptr(uncore->info, cpu) = info;
+}
+
+static
+int hygon_uncore_df_ctx_init(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	struct hygon_uncore_pmu *pmu = &uncore->pmu;
+	int num_counters;
+
+	if (uncore->init_done)
+		return hygon_uncore_ctx_init(uncore, cpu);
+
+	num_counters = hygon_uncore_ctx_num_pmcs(uncore, cpu);
+	if (!num_counters)
+		goto done;
+
+	strscpy(pmu->name, "hygon_df", sizeof(pmu->name));
+	pmu->num_counters = num_counters;
+	pmu->msr_base = MSR_HYGON_F18H_DF_CTL;
+	pmu->type = HYGON_UNCORE_TYPE_DF;
+
+	hygon_uncore_df_format_attr[1] = hygon_uncore_df_umask_attr();
+
+	pmu->ctx = alloc_percpu(struct hygon_uncore_ctx *);
+	if (!pmu->ctx)
+		goto done;
+
+	pmu->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.attr_groups	= hygon_uncore_df_attr_groups,
+		.name		= pmu->name,
+		.event_init	= hygon_uncore_df_event_init,
+		.add		= hygon_uncore_add,
+		.del		= hygon_uncore_del,
+		.start		= hygon_uncore_start,
+		.stop		= hygon_uncore_stop,
+		.read		= hygon_uncore_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.module		= THIS_MODULE,
+	};
+
+	if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
+		free_percpu(pmu->ctx);
+		pmu->ctx = NULL;
+		goto done;
+	}
+	uncore->pmu_registered = true;
+
+done:
+	uncore->init_done = true;
+	return hygon_uncore_ctx_init(uncore, cpu);
+}
+
+static
+void hygon_uncore_df_iod_ctx_scan(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	union hygon_uncore_info info = {};
+	int num_packages, num_cdds, iods_per_package;
+
+	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
+		return;
+
+	if (boot_cpu_data.x86_model < 0x4 || boot_cpu_data.x86_model == 0x6)
+		return;
+
+	num_packages = topology_max_packages();
+	num_cdds = topology_max_dies_per_package() * num_packages;
+	iods_per_package = (amd_nb_num() - num_cdds) / num_packages;
+
+	/* Hardware does not support more than 2 IODs per package. */
+	if (iods_per_package <= 0 || iods_per_package > 2)
+		return;
+
+	info.split.cid = topology_physical_package_id(cpu);
+	info.split.num_iods = iods_per_package;
+	info.split.num_pmcs = HYGON_UNCORE_NUM_COUNTERS_DF * iods_per_package;
+
+	*per_cpu_ptr(uncore->info, cpu) = info;
+}
+
+static
+int hygon_uncore_df_iod_ctx_init(struct hygon_uncore *uncore, unsigned int cpu)
+{
+	struct hygon_uncore_pmu *pmu = &uncore->pmu;
+	int num_counters;
+
+	if (uncore->init_done)
+		return hygon_uncore_ctx_init(uncore, cpu);
+
+	num_counters = hygon_uncore_ctx_num_pmcs(uncore, cpu);
+	if (!num_counters)
+		goto done;
+
+	strscpy(pmu->name, "hygon_df_iod", sizeof(pmu->name));
+	pmu->num_counters = num_counters;
+	pmu->msr_base = MSR_HYGON_F18H_DF_IOD_CTL;
+	pmu->type = HYGON_UNCORE_TYPE_DF_IOD;
+
+	hygon_uncore_df_iod_format_attr[1] = hygon_uncore_df_umask_attr();
+
+	pmu->ctx = alloc_percpu(struct hygon_uncore_ctx *);
+	if (!pmu->ctx)
+		goto done;
+
+	pmu->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.attr_groups	= hygon_uncore_df_iod_attr_groups,
+		.name		= pmu->name,
+		.event_init	= hygon_uncore_df_event_init,
+		.add		= hygon_uncore_add,
+		.del		= hygon_uncore_del,
+		.start		= hygon_uncore_start,
+		.stop		= hygon_uncore_stop,
+		.read		= hygon_uncore_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.module		= THIS_MODULE,
+	};
+
+	if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
+		free_percpu(pmu->ctx);
+		pmu->ctx = NULL;
+		goto done;
+	}
+	uncore->pmu_registered = true;
+done:
+	uncore->init_done = true;
+	return hygon_uncore_ctx_init(uncore, cpu);
+}
+
+static struct hygon_uncore uncores[HYGON_UNCORE_TYPE_MAX] = {
+	/* HYGON DF */
+	{
+		.scan = hygon_uncore_df_ctx_scan,
+		.init = hygon_uncore_df_ctx_init,
+		.move = hygon_uncore_ctx_move,
+		.free = hygon_uncore_ctx_free,
+	},
+	/* HYGON DF IOD */
+	{
+		.scan = hygon_uncore_df_iod_ctx_scan,
+		.init = hygon_uncore_df_iod_ctx_init,
+		.move = hygon_uncore_ctx_move,
+		.free = hygon_uncore_ctx_free,
+	}
+};
+
+static void hygon_uncore_pmu_cleanup(void)
+{
+	struct hygon_uncore_ctx *ctx;
+	struct hygon_uncore *uncore;
+	int i, cpu;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+
+		/* Unregister PMU before freeing its contexts. */
+		if (uncore->pmu_registered) {
+			perf_pmu_unregister(&uncore->pmu.pmu);
+			uncore->pmu_registered = false;
+		}
+
+		if (!uncore->pmu.ctx)
+			continue;
+
+		/* Shared ctx objects are released through their refcnt. */
+		for_each_possible_cpu(cpu) {
+			ctx = *per_cpu_ptr(uncore->pmu.ctx, cpu);
+			if (!ctx)
+				continue;
+
+			if (!--ctx->refcnt) {
+				hygon_uncore_cancel_hrtimer(ctx);
+				kfree(ctx->events);
+				kfree(ctx);
+			}
+			*per_cpu_ptr(uncore->pmu.ctx, cpu) = NULL;
+		}
+
+		free_percpu(uncore->pmu.ctx);
+		uncore->pmu.ctx = NULL;
+	}
+}
+
+static void hygon_uncore_info_cleanup(void)
+{
+	struct hygon_uncore *uncore;
+	int i;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+		if (uncore->info) {
+			free_percpu(uncore->info);
+			uncore->info = NULL;
+		}
+	}
+}
+
+static int __init hygon_uncore_init(void)
+{
+	struct hygon_uncore *uncore;
+	int ret = -ENODEV;
+	int i;
+
+
+	if (!update_interval) {
+		pr_err("update_interval must be greater than 0 ms\n");
+		return -EINVAL;
+	}
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
+		return -ENODEV;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &uncores[i];
+
+		uncore->info = alloc_percpu(union hygon_uncore_info);
+		if (!uncore->info) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+	}
+
+	ret = cpuhp_setup_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP,
+				"perf/x86/hygon/uncore:prepare",
+				NULL, hygon_uncore_cpu_dead);
+	if (ret)
+		goto fail;
+
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING,
+				"perf/x86/hygon/uncore:starting",
+				hygon_uncore_cpu_starting, NULL);
+	if (ret)
+		goto fail_prep;
+
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_ONLINE,
+				"perf/x86/hygon/uncore:online",
+				hygon_uncore_cpu_online,
+				hygon_uncore_cpu_down_prepare);
+	if (ret)
+		goto fail_start;
+
+	return 0;
+
+fail_start:
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING);
+fail_prep:
+	cpuhp_remove_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP);
+fail:
+	hygon_uncore_info_cleanup();
+	return ret;
+}
+
+static void __exit hygon_uncore_exit(void)
+{
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_ONLINE);
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING);
+	cpuhp_remove_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP);
+
+	hygon_uncore_pmu_cleanup();
+	hygon_uncore_info_cleanup();
+}
+module_init(hygon_uncore_init);
+module_exit(hygon_uncore_exit);
+
+MODULE_DESCRIPTION("Hygon Uncore Driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dbc00b6dd69e..6c486e1ab001 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -775,9 +775,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		goto done;
 	}
 
-	pr_info("%d %s%s counters detected\n", pmu->num_counters,
-		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON " : "",
-		pmu->pmu.name);
+	pr_info("%d %s counters detected\n", pmu->num_counters, pmu->pmu.name);
 
 	uncore->num_pmus = 1;
 
@@ -911,9 +909,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		goto done;
 	}
 
-	pr_info("%d %s%s counters detected\n", pmu->num_counters,
-		boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON " : "",
-		pmu->pmu.name);
+	pr_info("%d %s counters detected\n", pmu->num_counters, pmu->pmu.name);
 
 	uncore->num_pmus = 1;
 
@@ -1120,8 +1116,7 @@ static int __init amd_uncore_init(void)
 	int ret = -ENODEV;
 	int i;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 18c4be75e927..d20338f0b2b2 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -851,6 +851,8 @@
 #define MSR_F15H_PTSC			0xc0010280
 #define MSR_F15H_IC_CFG			0xc0011021
 #define MSR_F15H_EX_CFG			0xc001102c
+#define MSR_HYGON_F18H_DF_CTL		0xc0010240
+#define MSR_HYGON_F18H_DF_IOD_CTL	0xc0010250
 
 /* Fam 10h MSRs */
 #define MSR_FAM10H_MMIO_CONF_BASE	0xc0010058
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1eb13673e889..7c8c00ad56e9 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -124,6 +124,26 @@
 	(AMD64_PERFMON_V2_EVENTSEL_EVENT_NB	|	\
 	 AMD64_PERFMON_V2_EVENTSEL_UMASK_NB)
 
+#define HYGON_F18H_EVENTSEL_EVENT_DF		0x0000003FULL
+#define HYGON_F18H_EVENTSEL_UMASK_DF		0x0000FF00ULL
+#define HYGON_F18H_M4H_EVENTSEL_UMASK_DF	0x0003FF00ULL
+#define HYGON_F18H_M6H_EVENTSEL_UMASK_DF	0x000FFF00ULL
+#define HYGON_F18H_EVENTSEL_CONSTID_DF			\
+	(0x000000C0ULL | GENMASK_ULL(35, 32) | GENMASK_ULL(62, 61))
+
+#define HYGON_F18H_RAW_EVENT_MASK_DF			\
+	(HYGON_F18H_EVENTSEL_EVENT_DF		|	\
+	 HYGON_F18H_EVENTSEL_UMASK_DF		|	\
+	 HYGON_F18H_EVENTSEL_CONSTID_DF)
+#define HYGON_F18H_M4H_RAW_EVENT_MASK_DF		\
+	(HYGON_F18H_EVENTSEL_EVENT_DF		|	\
+	 HYGON_F18H_M4H_EVENTSEL_UMASK_DF	|	\
+	 HYGON_F18H_EVENTSEL_CONSTID_DF)
+#define HYGON_F18H_M6H_RAW_EVENT_MASK_DF		\
+	(HYGON_F18H_EVENTSEL_EVENT_DF		|	\
+	 HYGON_F18H_M6H_EVENTSEL_UMASK_DF	|	\
+	 HYGON_F18H_EVENTSEL_CONSTID_DF)
+
 #define AMD64_PERFMON_V2_ENABLE_UMC			BIT_ULL(31)
 #define AMD64_PERFMON_V2_EVENTSEL_EVENT_UMC		GENMASK_ULL(7, 0)
 #define AMD64_PERFMON_V2_EVENTSEL_RDWRMASK_UMC		GENMASK_ULL(9, 8)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0fb3a2a62eb0..bccdb87a0c05 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -62,6 +62,7 @@ enum cpuhp_state {
 	CPUHP_CREATE_THREADS,
 	CPUHP_PERF_X86_PREPARE,
 	CPUHP_PERF_X86_AMD_UNCORE_PREP,
+	CPUHP_PERF_X86_HYGON_UNCORE_PREP,
 	CPUHP_PERF_POWER,
 	CPUHP_PERF_SUPERH,
 	CPUHP_X86_HPET_DEAD,
@@ -148,6 +149,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
+	CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
 	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
@@ -205,6 +207,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_ONLINE,
 	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
+	CPUHP_AP_PERF_X86_HYGON_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
-- 
2.34.1


