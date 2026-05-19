Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7F2673AA;
	Tue, 19 May 2026 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161590; cv=none; b=V9w/W73qNUVEzvBZZXV9Sw0NsodL3P9JNgoVzwNRhFtZP53v+flkX5NPE61uewtc1BZqRNTJS3WxhE0teQYSWW+pvEpmgBuRFQwB88Ot81/Vo16A6P3zvINK+X/zhns0F0b8UK1jrO4suUdx8wj1jrYrwRXee4ZJOpqJWwUSCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161590; c=relaxed/simple;
	bh=yc5obdwewimg5iwq+DDFeT+P/zi++j0aQ6h1d1Xq01A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtEgEyBfibfdbcRQHkwiG/K3gLWhSbuBDpNLs9Vq/MuEVpxURRRB9eP3Lx6GbMorU128Y0FfXvd8sfzz4D4AmowTdouB2bl4V8syZsUUxTwNtmajM7PUkgazOJvzkj00CQ0Jen97/5EMJ8yFeU62FQTyjjBYKTePLA6Zyge7IlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn; spf=fail smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gKKxV3KVMzT1qQ;
	Tue, 19 May 2026 11:32:46 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4gKKxS0xdZzT1qQ;
	Tue, 19 May 2026 11:32:44 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 3BE795955;
	Tue, 19 May 2026 11:32:39 +0800 (CST)
Received: from neptune.hygon.cn (172.22.228.106) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 19 May
 2026 11:32:43 +0800
From: Qi Liu <liuqi@hygon.cn>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>, <x86@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lijing@hygon.cn>, <liuqi@hygon.cn>, Zhenglang Hu <huzhenglang@hygon.cn>
Subject: [RFC PATCH 3/3] perf/x86/amd/uncore: Add Hygon uncore PMU support
Date: Tue, 19 May 2026 03:32:25 +0000
Message-ID: <20260519033225.1479907-4-liuqi@hygon.cn>
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

Add uncore PMU support for Hygon processors based on the
shared AMD-family uncore framework.

Hygon processors implement uncore PMUs for Data Fabric units
with a programming model similar to AMD, but with several
differences:

  - Different MSR base addresses
  - Vendor-specific event encoding and masks
  - DF IOD counter allocation semantics
  - Additional format attributes (e.g. iod, constid)

Reuse the common uncore infrastructure introduced in the
previous patch, this avoids duplicating the full uncore driver
while keeping vendor-specific logic isolated.

Signed-off-by: Qi Liu <liuqi@hygon.cn>
Tested-by: Zhenglang Hu <huzhenglang@hygon.cn>
---
 arch/x86/events/Kconfig            |  11 +
 arch/x86/events/amd/Makefile       |   2 +
 arch/x86/events/amd/hygon_uncore.c | 567 +++++++++++++++++++++++++++++
 arch/x86/include/asm/msr-index.h   |   2 +
 arch/x86/include/asm/perf_event.h  |  20 +
 include/linux/cpuhotplug.h         |   3 +
 6 files changed, 605 insertions(+)
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
index f951ae64ee36..32bf7aae2368 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -5,6 +5,8 @@ obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
 obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE)	+= amd-uncore.o
 amd-uncore-objs				:= uncore_common.o uncore.o
+obj-$(CONFIG_PERF_EVENTS_HYGON_UNCORE)	+= hygon-uncore.o
+hygon-uncore-objs			:= uncore_common.o hygon_uncore.o
 ifdef CONFIG_AMD_IOMMU
 obj-$(CONFIG_CPU_SUP_AMD)		+= iommu.o
 endif
diff --git a/arch/x86/events/amd/hygon_uncore.c b/arch/x86/events/amd/hygon_uncore.c
new file mode 100644
index 000000000000..133b6b1923de
--- /dev/null
+++ b/arch/x86/events/amd/hygon_uncore.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Chengdu Haiguang IC Design Co., Ltd.
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpufeature.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+
+#include <asm/amd/nb.h>
+#include <asm/msr.h>
+#include <asm/perf_event.h>
+
+#include "uncore_common.h"
+
+#define NUM_COUNTERS_DF		4
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"hygon_uncore: " fmt
+
+enum {
+	HYGON_UNCORE_TYPE_DF,
+	HYGON_UNCORE_TYPE_DF_IOD,
+	HYGON_UNCORE_TYPE_MAX,
+};
+
+/* Interval for hrtimer, defaults to 60000 milliseconds */
+static unsigned int update_interval = 60 * MSEC_PER_SEC;
+module_param(update_interval, uint, 0444);
+
+static struct uncore_common hygon_uncores[HYGON_UNCORE_TYPE_MAX];
+
+static __always_inline bool hygon_uncore_is_df_iod(struct uncore_common_pmu *pmu)
+{
+	struct uncore_common *uncore = pmu->private;
+
+	return uncore == &hygon_uncores[HYGON_UNCORE_TYPE_DF_IOD];
+}
+
+static __always_inline int hygon_uncore_num_iods(struct uncore_common *uncore, unsigned int cpu)
+{
+	union uncore_common_info *info = per_cpu_ptr(uncore->info, cpu);
+
+	return info->split.private;
+}
+
+static u64 hygon_uncore_df_event_mask(void)
+{
+	if (boot_cpu_data.x86_model == 0x4 ||
+	    boot_cpu_data.x86_model == 0x5)
+		return HYGON_F18H_M4H_RAW_EVENT_MASK_DF;
+
+	if (boot_cpu_data.x86_model >= 0x6 &&
+	    boot_cpu_data.x86_model <= 0x18)
+		return HYGON_F18H_M6H_RAW_EVENT_MASK_DF;
+
+	return HYGON_F18H_RAW_EVENT_MASK_DF;
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
+DEFINE_UNCORE_FORMAT_ATTR(umask10,	umask,		"config:8-17");
+DEFINE_UNCORE_FORMAT_ATTR(umask12,	umask,		"config:8-19");
+DEFINE_UNCORE_FORMAT_ATTR(constid,	constid,	"config:6-7,32-35,61-62");
+DEFINE_UNCORE_FORMAT_ATTR(iod,		iod,		"config1:0-1");
+
+static struct attribute *hygon_uncore_df_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask8.attr,
+	&format_attr_constid.attr,
+	NULL,
+};
+
+static struct attribute *hygon_uncore_df_iod_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask10.attr,
+	&format_attr_constid.attr,
+	&format_attr_iod.attr,
+	NULL,
+};
+
+static struct attribute_group hygon_uncore_df_format_group = {
+	.name = "format",
+	.attrs = hygon_uncore_df_format_attr,
+};
+
+static struct attribute_group hygon_uncore_df_iod_format_group = {
+	.name = "format",
+	.attrs = hygon_uncore_df_iod_format_attr,
+};
+
+static const struct attribute_group *hygon_uncore_df_attr_groups[] = {
+	&hygon_uncore_attr_group,
+	&hygon_uncore_df_format_group,
+	NULL,
+};
+
+static const struct attribute_group *hygon_uncore_df_iod_attr_groups[] = {
+	&hygon_uncore_attr_group,
+	&hygon_uncore_df_iod_format_group,
+	NULL,
+};
+
+static int hygon_uncore_df_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct uncore_common_pmu *pmu;
+	struct uncore_common *uncore;
+	u64 event_mask;
+	int ret;
+
+	ret = uncore_common_event_init(event);
+	if (ret)
+		return ret;
+
+	pmu = event_to_uncore_common_pmu(event);
+	uncore = pmu->private;
+
+	if (hygon_uncore_is_df_iod(pmu) &&
+	    event->attr.config1 >= hygon_uncore_num_iods(uncore, event->cpu))
+		return -EINVAL;
+
+	event_mask = hygon_uncore_df_event_mask();
+	hwc->config = event->attr.config & event_mask;
+
+	return 0;
+}
+
+static int hygon_uncore_df_iod_add(struct perf_event *event, int flags)
+{
+	struct uncore_common_pmu *pmu = event_to_uncore_common_pmu(event);
+	struct uncore_common_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
+	struct hw_perf_event *hwc = &event->hw;
+	int iod_idx;
+	int i;
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
+	iod_idx = event->attr.config1;
+
+	for (i = iod_idx * NUM_COUNTERS_DF; i < (iod_idx + 1) * NUM_COUNTERS_DF; i++) {
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
+	hwc->config_base = pmu->msr_base + 2 * hwc->idx;
+	hwc->event_base = pmu->msr_base + 1 + 2 * hwc->idx;
+	hwc->event_base_rdpmc = -1;
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		event->pmu->start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+static int hygon_uncore_cpu_starting(unsigned int cpu)
+{
+	struct uncore_common *uncore;
+	int i;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &hygon_uncores[i];
+		uncore->scan(uncore, cpu);
+	}
+
+	return 0;
+}
+
+static int hygon_uncore_cpu_online(unsigned int cpu)
+{
+	struct uncore_common *uncore;
+	int ret;
+	int i;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &hygon_uncores[i];
+
+		ret = uncore->init(uncore, cpu);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int hygon_uncore_cpu_down_prepare(unsigned int cpu)
+{
+	struct uncore_common *uncore;
+	int i;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &hygon_uncores[i];
+		uncore->move(uncore, cpu);
+	}
+
+	return 0;
+}
+
+static int hygon_uncore_cpu_dead(unsigned int cpu)
+{
+	struct uncore_common *uncore;
+	int i;
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &hygon_uncores[i];
+		uncore->free(uncore, cpu);
+	}
+
+	return 0;
+}
+
+static int hygon_uncore_df_ctx_init(struct uncore_common *uncore,
+				    unsigned int cpu)
+{
+	struct attribute *df_attr;
+	struct uncore_common_pmu *pmu;
+	int num_counters;
+
+	if (uncore->init_done)
+		return uncore_common_ctx_init(uncore, cpu);
+
+	num_counters = uncore_common_ctx_num_pmcs(uncore, cpu);
+	if (!num_counters)
+		goto done;
+
+	uncore->pmus = kzalloc_obj(*uncore->pmus);
+	if (!uncore->pmus)
+		goto done;
+
+	pmu = &uncore->pmus[0];
+	strscpy(pmu->name, "hygon_df", sizeof(pmu->name));
+	pmu->num_counters = num_counters;
+	pmu->msr_base = MSR_HYGON_F18H_DF_CTL;
+	pmu->rdpmc_base = -1;
+	pmu->group = uncore_common_ctx_gid(uncore, cpu);
+	pmu->private = uncore;
+
+	df_attr = &format_attr_umask8.attr;
+	if (boot_cpu_data.x86_model == 0x4 ||
+	    boot_cpu_data.x86_model == 0x5)
+		df_attr = &format_attr_umask10.attr;
+	else if (boot_cpu_data.x86_model >= 0x6 &&
+		 boot_cpu_data.x86_model <= 0x18)
+		df_attr = &format_attr_umask12.attr;
+	hygon_uncore_df_format_attr[1] = df_attr;
+
+	pmu->ctx = alloc_percpu(struct uncore_common_ctx *);
+	if (!pmu->ctx)
+		goto done;
+
+	pmu->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.attr_groups	= hygon_uncore_df_attr_groups,
+		.name		= pmu->name,
+		.event_init	= hygon_uncore_df_event_init,
+		.add		= uncore_common_add,
+		.del		= uncore_common_del,
+		.start		= uncore_common_start,
+		.stop		= uncore_common_stop,
+		.read		= uncore_common_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.module		= THIS_MODULE,
+	};
+
+	if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
+		free_percpu(pmu->ctx);
+		pmu->ctx = NULL;
+		goto done;
+	}
+
+	pr_info("%d %s counters detected\n", pmu->num_counters, pmu->pmu.name);
+	uncore->num_pmus = 1;
+
+done:
+	uncore->init_done = true;
+	return uncore_common_ctx_init(uncore, cpu);
+}
+
+static void hygon_uncore_df_ctx_scan(struct uncore_common *uncore,
+				     unsigned int cpu)
+{
+	unsigned int eax, ebx, ecx, edx;
+	union uncore_common_info info;
+
+	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
+		return;
+
+	info.split.gid = 0;
+	info.split.aux_data = 0;
+	info.split.num_pmcs = NUM_COUNTERS_DF;
+
+	cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
+	info.split.cid = ecx & 0xff;
+
+	*per_cpu_ptr(uncore->info, cpu) = info;
+}
+
+static void hygon_uncore_df_iod_ctx_scan(struct uncore_common *uncore,
+					 unsigned int cpu)
+{
+	int num_packages, iods_per_package;
+	union uncore_common_info info;
+
+	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
+		return;
+
+	if (boot_cpu_data.x86_model < 0x4 || boot_cpu_data.x86_model == 0x6)
+		return;
+
+	num_packages = topology_max_packages();
+	iods_per_package = amd_nb_num() / num_packages - topology_max_dies_per_package();
+	if (iods_per_package <= 0)
+		return;
+
+	info.split.cid = topology_physical_package_id(cpu);
+	info.split.gid = 0;
+	info.split.private = iods_per_package;
+	info.split.num_pmcs = NUM_COUNTERS_DF * iods_per_package;
+
+	*per_cpu_ptr(uncore->info, cpu) = info;
+}
+
+static int hygon_uncore_df_iod_ctx_init(struct uncore_common *uncore,
+					unsigned int cpu)
+{
+	struct uncore_common_pmu *pmu;
+	int num_counters;
+
+	if (uncore->init_done)
+		return uncore_common_ctx_init(uncore, cpu);
+
+	num_counters = uncore_common_ctx_num_pmcs(uncore, cpu);
+	if (!num_counters)
+		goto done;
+
+	uncore->pmus = kzalloc_obj(*uncore->pmus);
+	if (!uncore->pmus)
+		goto done;
+
+	pmu = &uncore->pmus[0];
+	strscpy(pmu->name, "hygon_df_iod", sizeof(pmu->name));
+	pmu->num_counters = num_counters;
+	pmu->msr_base = MSR_HYGON_F18H_DF_IOD_CTL;
+	pmu->rdpmc_base = -1;
+	pmu->group = uncore_common_ctx_gid(uncore, cpu);
+	pmu->private = uncore;
+
+	if (boot_cpu_data.x86_model >= 0x6 &&
+	    boot_cpu_data.x86_model <= 0x18)
+		hygon_uncore_df_iod_format_attr[1] = &format_attr_umask12.attr;
+
+	pmu->ctx = alloc_percpu(struct uncore_common_ctx *);
+	if (!pmu->ctx)
+		goto done;
+
+	pmu->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.attr_groups	= hygon_uncore_df_iod_attr_groups,
+		.name		= pmu->name,
+		.event_init	= hygon_uncore_df_event_init,
+		.add		= hygon_uncore_df_iod_add,
+		.del		= uncore_common_del,
+		.start		= uncore_common_start,
+		.stop		= uncore_common_stop,
+		.read		= uncore_common_read,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.module		= THIS_MODULE,
+	};
+
+	if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
+		free_percpu(pmu->ctx);
+		pmu->ctx = NULL;
+		goto done;
+	}
+
+	pr_info("%d %s counters detected\n", pmu->num_counters, pmu->pmu.name);
+	uncore->num_pmus = 1;
+
+done:
+	uncore->init_done = true;
+	return uncore_common_ctx_init(uncore, cpu);
+}
+
+static struct uncore_common hygon_uncores[HYGON_UNCORE_TYPE_MAX] = {
+	/* HYGON_UNCORE_TYPE_DF */
+	{
+		.scan = hygon_uncore_df_ctx_scan,
+		.init = hygon_uncore_df_ctx_init,
+		.move = uncore_common_ctx_move,
+		.free = uncore_common_ctx_free,
+	},
+	/* HYGON_UNCORE_TYPE_DF IOD */
+	{
+		.scan = hygon_uncore_df_iod_ctx_scan,
+		.init = hygon_uncore_df_iod_ctx_init,
+		.move = uncore_common_ctx_move,
+		.free = uncore_common_ctx_free,
+	},
+};
+
+static int __init hygon_uncore_init(void)
+{
+	struct uncore_common *uncore;
+	int ret = -ENODEV;
+	int i;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return -ENODEV;
+
+	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
+		return -ENODEV;
+
+	uncore_common_set_update_interval(update_interval);
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &hygon_uncores[i];
+
+		if (WARN_ON_ONCE(!uncore->scan ||
+				 !uncore->init ||
+				 !uncore->move ||
+				 !uncore->free)) {
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		uncore->info = alloc_percpu(union uncore_common_info);
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
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &hygon_uncores[i];
+
+		if (uncore->info) {
+			free_percpu(uncore->info);
+			uncore->info = NULL;
+		}
+	}
+
+	return ret;
+}
+
+static void __exit hygon_uncore_exit(void)
+{
+	struct uncore_common *uncore;
+	struct uncore_common_pmu *pmu;
+	int i, j;
+
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_ONLINE);
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING);
+	cpuhp_remove_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP);
+
+	for (i = 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
+		uncore = &hygon_uncores[i];
+
+		if (!uncore->info)
+			continue;
+
+		free_percpu(uncore->info);
+		uncore->info = NULL;
+
+		for (j = 0; j < uncore->num_pmus; j++) {
+			pmu = &uncore->pmus[j];
+
+			if (!pmu->ctx)
+				continue;
+
+			perf_pmu_unregister(&pmu->pmu);
+			free_percpu(pmu->ctx);
+			pmu->ctx = NULL;
+		}
+
+		kfree(uncore->pmus);
+		uncore->pmus = NULL;
+	}
+}
+
+module_init(hygon_uncore_init);
+module_exit(hygon_uncore_exit);
+
+MODULE_DESCRIPTION("Hygon Uncore Driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 86554de9a3f5..b81d0003e295 100644
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
index 752cb319d5ea..9e56b5c94d4b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -122,6 +122,26 @@
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
index 22ba327ec227..25f64bdfb5dc 100644
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


