Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988482;
	b=0VYJZ3JOD9P6XyfAX/t5mhYKU7goGOYnJyaijtl5hQqIoZxb72Gt3oLy1bNq7eZVJLAu
	 bBV1GXoq4JRhIiioX2u34AvO2LyltIHH3iKKzNMjbljaH/6xAlD1R6BlyzDnn1ZjSgPpj
	 dhLG1uqjw7YHRgUZKZAW52QPGN7FZD1ec0v8/0ARrIOeaJeEuXlZHKT1dAX2Fqrh9z/4F
	 Lc9r+5FGED9sEgGtQ4lkBpZIKXD+QZid+Eiir7o3kuq2TadnGyEZjECSGhiexbbL1ge3C
	 jAdAUPLfzsrFs8uUpivpxvjkdjNj1WVOL+57NAJ5wkGKMDU9QDAU4R0r3ikB0ByBP5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988482;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=47g2Jwmjs3rykGmMMHdiGYfwc7QkPmRJ21kw2mqSxpk=;
	b=yhaESSXFRAVxMYJead7b6k2JH37jZMy0nlkUz4ndb6hyOLtOwC4Vahgxp2aomsXS/oLi
	 9SFkNtQcnDw+1O44BX4pqm5v3YsTyKP5qyzk4f5gue8vI7GNHnRl+abRchD8zrC5yBEge
	 xsRReWmCRw9dRqbqCwFdaIKmK/ejsSY7cKsSNZ9PmatVRw/W6t1rYoAij0q2N60FS/YEc
	 ZP//DCL0as+JLVpzIKmUcJqQgk1uVMIcw6hKH+dnRzSHsRSKhpOOwf7qQNWLmZLaYKZWi
	 S6I7KE1yC5iv4OfnU+rcPR5yshDTP8bpOUOlhZMy4ydBhXgVVABy+sDSHGkMKZDaSdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=heM7gCHD;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBCA6082BE1
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCBCA6082BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=heM7gCHD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FA961692;
	Fri,  6 Nov 2026 10:07:58 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 68F553F673;
	Fri,  6 Nov 2026 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793988481; bh=WiAqsp/GeSugdXIAUrKlZKhU2AYH1ijV2kziwpdv9j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heM7gCHDtkZTvfccHg+4p0SsKw2WzJiN7eveK2QJgCZbZe8zVUKLY99XZGeMyA07h
	 rtURyoTuGB+MtVl43fkLdNN6BAlLF/WWlLo7/WFsh09TXxlHmBjkbo/icSK9Zb3Yv5
	 leumJ4Ia/n/P5kGNMZd25kO+4dvq3qs5pQJqvWpM=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] perf: Add Arm Bus Monitor Unit driver
Date: Fri,  6 Nov 2026 18:07:44 +0000
Message-ID: <7bf3b15677548c7e0c88aa03fa18a2b5673ab363.1793986672.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1793986672.git.robin.murphy@arm.com>
References: <cover.1793986672.git.robin.murphy@arm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm's Bus Monitor Unit is a low-level performance analysis tool for
matching and counting transactions at interconnect interfaces. Each
BMU consists of a number of "interface monitoring units", with some
global controls to synchronise them and so permit accurate calculation
of cross-interface metrics. Each IMU contains, among other things, its
own PMU largely based on the CoreSight PMU architecture, but with some
functional incompatibilities due to the nature of how much per-event
filtering needs to be crammed in to categorise AXI/CHI transactions at
the protocol level. As such it gets an honorary home in arm_cspmu/ in
order to share the common register definitions, but for simplicity does
not try to bend the functional abstraction to fit.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/Kconfig   |   6 +
 drivers/perf/arm_cspmu/Makefile  |   2 +
 drivers/perf/arm_cspmu/arm-bmu.c | 528 +++++++++++++++++++++++++++++++
 3 files changed, 536 insertions(+)
 create mode 100644 drivers/perf/arm_cspmu/arm-bmu.c

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 25bd55f036a4..48c2a3ac7fab 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -34,3 +34,9 @@ config ARM_SYSTEM_PMU
 	help
 	  Support additional event filtering attributes for the CoreSight-based
 	  PMU blocks found in various parts of Arm Compute Subsystems and SoCs.
+
+config ARM_BMU
+	tristate "ARM Bus Monitor Unit"
+	depends on (ARM64 && ACPI) || COMPILE_TEST
+	help
+	  Support perf event counting on Arm Bus Monitor Unit devices.
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index 90c3cd710157..4e0b420a2b55 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -9,3 +9,5 @@ arm_cspmu_module-y := arm_cspmu.o
 obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
 obj-$(CONFIG_AMPERE_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += ampere_cspmu.o
 obj-$(CONFIG_ARM_SYSTEM_PMU) += arm_syspmu.o
+
+obj-$(CONFIG_ARM_BMU) += arm-bmu.o
diff --git a/drivers/perf/arm_cspmu/arm-bmu.c b/drivers/perf/arm_cspmu/arm-bmu.c
new file mode 100644
index 000000000000..fe25954ac836
--- /dev/null
+++ b/drivers/perf/arm_cspmu/arm-bmu.c
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2025-2026 Arm Limited
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#include "arm_cspmu.h"
+
+#define MCU_CONFIG			0x0000
+#define MCU_PMU_GLOBAL_EN		0x0008
+#define MCU_PMU_INTERRUPT_STATUS	0x0090
+
+#define MCUCFG_NUM_IMU_MONITORS		GENMASK_ULL(63, 60)
+#define MCUCFG_PMU_ELEMENT_SIZE		GENMASK_ULL(11, 8)
+#define MCUCFG_PMU_ELEMENT_START	GENMASK_ULL(7, 0)
+
+#define BMU_PMIMPDEF			0x0200
+#define BMU_PMCR			0x0e10
+
+/* These are reasonable expectations for now */
+#define PMU_MAX_COUNTERS	16
+#define MAX_IMUS		16
+
+/* Event attributes */
+#define BMU_CONFIG_IMU		GENMASK_ULL(63, 56)
+#define BMU_CONFIG_EVENT	GENMASK_ULL(55, 0)
+#define BMU_CONFIG_FILTER	GENMASK_ULL(63, 0)
+#define BMU_CONFIG_MATCH	GENMASK_ULL(63, 0)
+#define BMU_CONFIG_MASK		GENMASK_ULL(63, 0)
+
+#define BMU_EVENT_IMU(e)	FIELD_GET(BMU_CONFIG_IMU, (e)->attr.config)
+#define BMU_EVENT_EVENT(e)	FIELD_GET(BMU_CONFIG_EVENT, (e)->attr.config)
+#define BMU_EVENT_FILTER(e)	FIELD_GET(BMU_CONFIG_FILTER, (e)->attr.config1)
+#define BMU_EVENT_MATCH(e)	FIELD_GET(BMU_CONFIG_MATCH, (e)->attr.config2)
+#define BMU_EVENT_MASK(e)	FIELD_GET(BMU_CONFIG_MASK, (e)->attr.config3)
+
+static unsigned long arm_bmu_cpuhp_state;
+
+struct arm_bmu_pmu {
+	void __iomem *base;
+	struct perf_event *evcnt[PMU_MAX_COUNTERS];
+	int num_counters;
+};
+
+struct arm_bmu {
+	struct device *dev;
+	void __iomem *base;
+	struct pmu pmu;
+	struct hlist_node cpuhp_node;
+	int cpu;
+	int irq;
+	int num_imus;
+	struct arm_bmu_pmu imus[] __counted_by(num_imus);
+};
+
+#define to_bmu(p)	container_of(p, struct arm_bmu, pmu)
+#define event_imu(e)	(e)->hw.event_base
+#define to_bmu_pmu(e)	&to_bmu(e->pmu)->imus[event_imu(e)]
+
+struct arm_bmu_format_attr {
+	struct device_attribute attr;
+	DECLARE_BITMAP(field, 64);
+	int config;
+};
+
+#define BMU_FORMAT_ATTR(_name, _cfg, _fld)				\
+	(&((struct arm_bmu_format_attr[]) {{				\
+		.attr = __ATTR(_name, 0444, arm_bmu_format_show, NULL),	\
+		.field = { BITMAP_FROM_U64(_fld) },			\
+		.config = _cfg,						\
+	}})[0].attr.attr)
+
+static ssize_t arm_bmu_format_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct arm_bmu_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
+
+	if (!fmt->config)
+		return sysfs_emit(buf, "config:%*pbl\n", 64, &fmt->field);
+
+	return sysfs_emit(buf, "config%d:%*pbl\n", fmt->config, 64, &fmt->field);
+}
+
+static struct attribute *arm_bmu_format_attrs[] = {
+	BMU_FORMAT_ATTR(imu, 0, BMU_CONFIG_IMU),
+	BMU_FORMAT_ATTR(event, 0, BMU_CONFIG_EVENT),
+	BMU_FORMAT_ATTR(filter, 1, BMU_CONFIG_FILTER),
+	BMU_FORMAT_ATTR(match, 2, BMU_CONFIG_MATCH),
+	BMU_FORMAT_ATTR(mask, 3, BMU_CONFIG_MASK),
+	NULL
+};
+
+static const struct attribute_group arm_bmu_format_attrs_group = {
+	.name = "format",
+	.attrs = arm_bmu_format_attrs,
+};
+
+static ssize_t arm_bmu_cpumask_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct arm_bmu *bmu = to_bmu(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(bmu->cpu)));
+}
+
+static struct device_attribute arm_bmu_cpumask_attr =
+		__ATTR(cpumask, 0444, arm_bmu_cpumask_show, NULL);
+
+static ssize_t arm_bmu_identifier_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct arm_bmu *bmu = to_bmu(dev_get_drvdata(dev));
+	u32 reg = readl_relaxed(bmu->imus[0].base + PMIIDR);
+
+	return sysfs_emit(buf, "%x\n", reg);
+}
+
+static struct device_attribute arm_bmu_identifier_attr =
+		__ATTR(identifier, 0444, arm_bmu_identifier_show, NULL);
+
+static struct attribute *arm_bmu_other_attrs[] = {
+	&arm_bmu_cpumask_attr.attr,
+	&arm_bmu_identifier_attr.attr,
+	NULL
+};
+
+static const struct attribute_group arm_bmu_other_attr_group = {
+	.attrs = arm_bmu_other_attrs,
+};
+
+static const struct attribute_group *arm_bmu_attr_groups[] = {
+	&arm_bmu_format_attrs_group,
+	&arm_bmu_other_attr_group,
+	NULL
+};
+
+static void arm_bmu_enable(struct pmu *pmu)
+{
+	writel_relaxed(1, to_bmu(pmu)->base + MCU_PMU_GLOBAL_EN);
+}
+
+static void arm_bmu_disable(struct pmu *pmu)
+{
+	writel_relaxed(0, to_bmu(pmu)->base + MCU_PMU_GLOBAL_EN);
+}
+
+static int arm_bmu_validate_group(struct perf_event *event)
+{
+	struct arm_bmu *bmu = to_bmu(event->pmu);
+	struct perf_event *sibling, *leader = event->group_leader;
+	int num[MAX_IMUS] = { 0 };
+
+	++num[event_imu(event)];
+	if (leader != event) {
+		if (leader->pmu == &bmu->pmu)
+			++num[event_imu(leader)];
+		for_each_sibling_event(sibling, leader) {
+			if (sibling->pmu == &bmu->pmu)
+				++num[event_imu(sibling)];
+		}
+	}
+	for (int i = 0; i < bmu->num_imus; i++) {
+		if (num[i] > bmu->imus[i].num_counters)
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static int arm_bmu_event_init(struct perf_event *event)
+{
+	struct arm_bmu *bmu = to_bmu(event->pmu);
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event))
+		return -EINVAL;
+
+	event->cpu = bmu->cpu;
+	event_imu(event) = BMU_EVENT_IMU(event);
+	if (event_imu(event) >= bmu->num_imus)
+		return -EINVAL;
+
+	return arm_bmu_validate_group(event);
+}
+
+static u64 arm_bmu_read_evcnt(struct perf_event *event)
+{
+	struct arm_bmu_pmu *pmu = to_bmu_pmu(event);
+	void __iomem *reg_base = pmu->base + event->hw.idx * sizeof(u64);
+	u64 lo, hi_old, hi_new;
+	int retries = 3; /* 1st time unlucky, 2nd improbable, 3rd just broken */
+
+	hi_new = readl_relaxed(reg_base + PMEVCNTR_HI);
+	do {
+		hi_old = hi_new;
+		lo = readl_relaxed(reg_base + PMEVCNTR_LO);
+		hi_new = readl_relaxed(reg_base + PMEVCNTR_HI);
+	} while (hi_new != hi_old && --retries);
+	WARN_ON(!retries);
+
+	return (hi_new << 32) | lo;
+}
+
+static void arm_bmu_event_read(struct perf_event *event)
+{
+	struct hw_perf_event *hw = &event->hw;
+	u64 count, prev;
+
+	do {
+		prev = local64_read(&hw->prev_count);
+		count = arm_bmu_read_evcnt(event);
+	} while (local64_cmpxchg(&hw->prev_count, prev, count) != prev);
+
+	count -= prev;
+	local64_add(count, &event->count);
+}
+
+static void arm_bmu_event_start(struct perf_event *event, int flags)
+{
+	struct arm_bmu_pmu *pmu = to_bmu_pmu(event);
+
+	writel_relaxed(1ULL << event->hw.idx, pmu->base + PMCNTENSET);
+}
+
+static void arm_bmu_event_stop(struct perf_event *event, int flags)
+{
+	struct arm_bmu_pmu *pmu = to_bmu_pmu(event);
+
+	writel_relaxed(1ULL << event->hw.idx, pmu->base + PMCNTENCLR);
+	if (flags & PERF_EF_UPDATE)
+		arm_bmu_event_read(event);
+}
+
+static int arm_bmu_event_add(struct perf_event *event, int flags)
+{
+	struct arm_bmu_pmu *pmu = to_bmu_pmu(event);
+	struct hw_perf_event *hw = &event->hw;
+	void __iomem *reg_base;
+
+	hw->idx = 0;
+	while (pmu->evcnt[hw->idx]) {
+		if (++hw->idx == pmu->num_counters)
+			return -ENOSPC;
+	}
+	pmu->evcnt[hw->idx] = event;
+
+	reg_base = pmu->base + hw->idx * sizeof(u64);
+	lo_hi_writeq_relaxed(BMU_EVENT_EVENT(event), reg_base + PMEVTYPER);
+	lo_hi_writeq_relaxed(BMU_EVENT_FILTER(event), reg_base + PMEVFILTR);
+	lo_hi_writeq_relaxed(BMU_EVENT_MATCH(event), reg_base + PMEVFILT2R);
+	lo_hi_writeq_relaxed(BMU_EVENT_MASK(event), reg_base + BMU_PMIMPDEF);
+
+	local64_set(&hw->prev_count, S64_MIN);
+	lo_hi_writeq_relaxed(S64_MIN, reg_base + PMEVCNTR_LO);
+
+	if (flags & PERF_EF_START)
+		arm_bmu_event_start(event, 0);
+	return 0;
+}
+
+static void arm_bmu_event_del(struct perf_event *event, int flags)
+{
+	struct arm_bmu_pmu *pmu = to_bmu_pmu(event);
+
+	arm_bmu_event_stop(event, PERF_EF_UPDATE);
+	pmu->evcnt[event->hw.idx] = NULL;
+}
+
+static void arm_bmu_pmu_irq(struct arm_bmu *bmu, int imu)
+{
+	struct arm_bmu_pmu *pmu = bmu->imus + imu;
+	u32 reg = readl_relaxed(pmu->base + PMOVSCLR);
+	u64 __iomem *pmevcnt = pmu->base + PMEVCNTR_LO;
+
+	for (int i = 0; i < PMU_MAX_COUNTERS; i++) {
+		if (!(reg & (1U << i)))
+			continue;
+		if (!pmu->evcnt[i]) {
+			dev_dbg(bmu->dev, "Spurious oveflow on IMU %d counter %d?\n", imu, i);
+			continue;
+		}
+		arm_bmu_event_read(pmu->evcnt[i]);
+		local64_set(&pmu->evcnt[i]->hw.prev_count, S64_MIN);
+		lo_hi_writeq_relaxed(S64_MIN, pmevcnt + i);
+	}
+	writel_relaxed(reg, pmu->base + PMOVSCLR);
+}
+
+static irqreturn_t arm_bmu_handle_irq(int irq, void *dev_id)
+{
+	struct arm_bmu *bmu = dev_id;
+	u32 reg = readl_relaxed(bmu->base + MCU_PMU_INTERRUPT_STATUS);
+	irqreturn_t ret = reg ? IRQ_HANDLED : IRQ_NONE;
+
+	for (int i = 0; i < bmu->num_imus && reg; i++, reg >>= 1) {
+		if (reg & 1)
+			arm_bmu_pmu_irq(bmu, i);
+	}
+	return ret;
+}
+
+static int arm_bmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct resource *res;
+	struct arm_bmu *bmu;
+	const char *name = NULL;
+	void __iomem *base;
+	static atomic_t n;
+	int err, num, sz, off;
+	u64 cfg;
+	u32 reg;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	/* PMUs and MPAM monitors are intermingled so we can't claim the whole resource */
+	base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!base)
+		return -ENOMEM;
+
+	/* Global and per-PMU-page security all defaults to Root/Secure only */
+	writel_relaxed(1, base + MCU_PMU_GLOBAL_EN);
+	reg = readl_relaxed(base + MCU_PMU_GLOBAL_EN);
+	if (reg != 1)
+		return dev_err_probe(dev, -ENODEV, "Non-Secure access to BMU not enabled?\n");
+	writel_relaxed(0, base + MCU_PMU_GLOBAL_EN);
+
+	cfg = lo_hi_readq_relaxed(base + MCU_CONFIG);
+	num = 1 + FIELD_GET(MCUCFG_NUM_IMU_MONITORS, cfg);
+	/* We don't expect to have dual-page complications to worry about */
+	sz = FIELD_GET(MCUCFG_PMU_ELEMENT_SIZE, cfg);
+	if (sz != 1)
+		return dev_err_probe(dev, -EINVAL, "PMU_ELEMENT_SIZE 0x%x not supported\n", sz);
+
+	/* The PMU pages *are* exclusively ours */
+	off = SZ_4K * FIELD_GET(MCUCFG_PMU_ELEMENT_START, cfg);
+	if (!devm_request_mem_region(dev, res->start + off, num * SZ_4K, dev_name(dev)))
+		return dev_err_probe(dev, -EADDRINUSE, "Unable to request PMU region\n");
+
+	bmu = devm_kzalloc(dev, struct_size(bmu, imus, num), GFP_KERNEL);
+	if (!bmu)
+		return -ENOMEM;
+
+	bmu->dev = dev;
+	bmu->base = base;
+	bmu->num_imus = num;
+	platform_set_drvdata(pdev, bmu);
+
+	base += off;
+	for (int i = 0; i < bmu->num_imus; i++, base += SZ_4K) {
+		/* At least PMCFGR.SIZE should always be nonzero if visible */
+		reg = readl_relaxed(base + PMCFGR);
+		if (!reg) {
+			dev_warn(dev, "Non-Secure access to PMU %d not enabled?\n", i);
+			num = 0;
+		} else {
+			num = 1 + FIELD_GET(PMCFGR_N, reg);
+		}
+		if (num > PMU_MAX_COUNTERS) {
+			dev_notice(dev, "PMU %d has %d counters, only using %d\n",
+				   i, num, PMU_MAX_COUNTERS);
+			num = PMU_MAX_COUNTERS;
+		}
+		bmu->imus[i].base = base;
+		bmu->imus[i].num_counters = num;
+
+		writel_relaxed(PMCR_P | PMCR_E, base + BMU_PMCR);
+		writel_relaxed(U32_MAX, base + PMCNTENCLR);
+		writel_relaxed(U32_MAX, base + PMOVSCLR);
+		writel_relaxed(U32_MAX, base + PMINTENSET);
+	}
+
+	bmu->cpu = cpumask_local_spread(atomic_fetch_inc(&n), dev_to_node(dev));
+	bmu->irq = platform_get_irq(pdev, 0);
+	if (bmu->irq > 0) {
+		err = devm_request_irq(dev, bmu->irq, arm_bmu_handle_irq,
+				       IRQF_NOBALANCING | IRQF_NO_THREAD,
+				       dev_name(dev), bmu);
+		if (err)
+			bmu->irq = err;
+		else
+			irq_set_affinity(bmu->irq, cpumask_of(bmu->cpu));
+	}
+	if (bmu->irq < 0)
+		dev_info(dev, "Continuing without IRQ\n");
+
+	bmu->pmu = (struct pmu) {
+		.module = THIS_MODULE,
+		.parent = dev,
+		.attr_groups = arm_bmu_attr_groups,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr = perf_invalid_context,
+		.pmu_enable = arm_bmu_enable,
+		.pmu_disable = arm_bmu_disable,
+		.event_init = arm_bmu_event_init,
+		.add = arm_bmu_event_add,
+		.del = arm_bmu_event_del,
+		.start = arm_bmu_event_start,
+		.stop = arm_bmu_event_stop,
+		.read = arm_bmu_event_read,
+	};
+
+	name = acpi_device_uid(ACPI_COMPANION(dev));
+
+	if (name)
+		name = devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%s", name);
+	else
+		name = devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%llx", (u64)(res->start >> 12));
+	if (!name)
+		return -ENOMEM;
+
+	err = cpuhp_state_add_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpuhp_node);
+	if (err)
+		return err;
+
+	err = perf_pmu_register(&bmu->pmu, name, -1);
+	if (err)
+		cpuhp_state_remove_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpuhp_node);
+
+	return err;
+}
+
+static void arm_bmu_remove(struct platform_device *pdev)
+{
+	struct arm_bmu *bmu = platform_get_drvdata(pdev);
+
+	for (int i = 0; i < bmu->num_imus; i++)
+		writel_relaxed(U32_MAX, bmu->imus[i].base + PMINTENCLR);
+
+	perf_pmu_unregister(&bmu->pmu);
+	cpuhp_state_remove_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpuhp_node);
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id arm_bmu_acpi_match[] = {
+	{ "ARMHB001" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, arm_bmu_acpi_match);
+#endif
+
+static struct platform_driver arm_bmu_driver = {
+	.driver = {
+		.name = "arm-bmu",
+		.acpi_match_table = ACPI_PTR(arm_bmu_acpi_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe = arm_bmu_probe,
+	.remove = arm_bmu_remove,
+};
+
+static void arm_bmu_migrate(struct arm_bmu *bmu, unsigned int cpu)
+{
+	perf_pmu_migrate_context(&bmu->pmu, bmu->cpu, cpu);
+	if (bmu->irq > 0)
+		irq_set_affinity(bmu->irq, cpumask_of(cpu));
+	bmu->cpu = cpu;
+}
+
+static int arm_bmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+{
+	struct arm_bmu *bmu;
+	int node;
+
+	bmu = hlist_entry_safe(cpuhp_node, struct arm_bmu, cpuhp_node);
+	node = dev_to_node(bmu->dev);
+	if (cpu_to_node(bmu->cpu) != node && cpu_to_node(cpu) == node)
+		arm_bmu_migrate(bmu, cpu);
+	return 0;
+}
+
+static int arm_bmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+{
+	struct arm_bmu *bmu;
+	unsigned int target;
+	int node;
+
+	bmu = hlist_entry_safe(cpuhp_node, struct arm_bmu, cpuhp_node);
+	if (cpu != bmu->cpu)
+		return 0;
+
+	node = dev_to_node(bmu->dev);
+	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		target = cpumask_any_but(cpu_online_mask, cpu);
+
+	if (target < nr_cpu_ids)
+		arm_bmu_migrate(bmu, target);
+	return 0;
+}
+
+static int __init arm_bmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "perf/arm/bmu:online",
+				      arm_bmu_online_cpu, arm_bmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+
+	arm_bmu_cpuhp_state = ret;
+
+	ret = platform_driver_register(&arm_bmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(arm_bmu_cpuhp_state);
+	return ret;
+}
+
+static void __exit arm_bmu_exit(void)
+{
+	platform_driver_unregister(&arm_bmu_driver);
+	cpuhp_remove_multi_state(arm_bmu_cpuhp_state);
+}
+
+module_init(arm_bmu_init);
+module_exit(arm_bmu_exit);
+
+MODULE_DESCRIPTION("ARM Bus Monitor Unit Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.54.0.dirty

