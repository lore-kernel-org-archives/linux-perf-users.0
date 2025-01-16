Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BFD233531
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068868; cv=none; b=oeNCZ7lGljtAhcUmeY3aSWwDZ9cGAZ4Ve6WU9m8FP7nywNO1QzRWqHPvsCOq8fiqcVFh7u/BxRDYPuZ4Eoj6tX8MUVHgTATRRUefXR7q7ms96MB6KPQYkhm/AuaFJrEkA+w73tG7+Z/SYlrcCY2JcAoF31qCx64s5j/zZ/UqXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068868; c=relaxed/simple;
	bh=tMtDhVyGkS5SekOGTdwSddJh1rLOt2LfE8EEvYIoa+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYpRLuj2FftTAsgN9vFBdtXta+gVO6kt8i6RXCBKP+C18EFkurNL4v/rX7AIWDQxNgsDN4ApH3HqgRcE2rcoB1jyY1jQxiaPeqMXB1L1V3fyfQiJBaiqMFREQsaFvOeVP8NWYtcc3a+MHjrqNfQgOhdMhRfHwGFpax79CRLTH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gr6Qk9rr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gr6Qk9rr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737068867; x=1768604867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tMtDhVyGkS5SekOGTdwSddJh1rLOt2LfE8EEvYIoa+k=;
  b=gr6Qk9rrjUNetqLTY0YqxGWj9x2D3FEY13/bwN0p7ZNkOamXYuNeDg3o
   +GHj7REyRtZKGKcxUAC5MVCkiQb2DWvln9YLac8lZshO+OhtXH+Vx8vCf
   /OHDNfHZvX1K96zF1f77SOdkrqZF9eduuKEhlEGkHdcYU74klbSjRLDub
   jMI4yZVWSL6pqifr0xM+SJrj/WmtsMRf5xjd9K9ZvYPcN/d/yzIRr2kI/
   r80qf9zZ1YzYyYS8ibl+T1L4kGvavxyWx+/sXMA5sXh1NJXooqcItFnH8
   Dws96FnXj8khTGCQSAHJUrSvn5eBGavzhI6wMhPA80pNgoHwotnTaAryz
   Q==;
X-CSE-ConnectionGUID: kzvJhZ17Roawym6V3YrmNQ==
X-CSE-MsgGUID: yEPLbHA4RmK0NtunHHwTMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37364128"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37364128"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:42 -0800
X-CSE-ConnectionGUID: v+LVjOKIQOmmS16210ZmPA==
X-CSE-MsgGUID: lUm4l2iiQZag9E0h0VTi3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="136474348"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v13 2/7] drm/xe/pmu: Enable PMU interface
Date: Thu, 16 Jan 2025 15:07:13 -0800
Message-ID: <20250116230718.82460-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116230718.82460-1-lucas.demarchi@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

Basic PMU enabling patch. Setup the basic framework
for adding events/timers. This patch was previously
reviewed here -
https://patchwork.freedesktop.org/series/119504/

Based on previous versions by Bommu Krishnaiah, Aravind Iddamsetty and
Riana Tauro, using i915 and rapl as reference implementation.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/Makefile          |   2 +
 drivers/gpu/drm/xe/xe_device.c       |   3 +
 drivers/gpu/drm/xe/xe_device_types.h |   4 +
 drivers/gpu/drm/xe/xe_pmu.c          | 300 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_pmu.h          |  20 ++
 drivers/gpu/drm/xe/xe_pmu_types.h    |  43 ++++
 6 files changed, 372 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/xe_pmu.c
 create mode 100644 drivers/gpu/drm/xe/xe_pmu.h
 create mode 100644 drivers/gpu/drm/xe/xe_pmu_types.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 81f63258a7e19..b476866a2a68e 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -304,6 +304,8 @@ endif
 xe-$(CONFIG_DRM_XE_DP_TUNNEL) += \
 	i915-display/intel_dp_tunnel.o
 
+xe-$(CONFIG_PERF_EVENTS) += xe_pmu.o
+
 obj-$(CONFIG_DRM_XE) += xe.o
 obj-$(CONFIG_DRM_XE_KUNIT_TEST) += tests/
 
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 0966d9697cafe..a0a80fa16c39a 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -49,6 +49,7 @@
 #include "xe_pat.h"
 #include "xe_pcode.h"
 #include "xe_pm.h"
+#include "xe_pmu.h"
 #include "xe_query.h"
 #include "xe_sriov.h"
 #include "xe_tile.h"
@@ -865,6 +866,8 @@ int xe_device_probe(struct xe_device *xe)
 
 	xe_oa_register(xe);
 
+	xe_pmu_register(&xe->pmu);
+
 	xe_debugfs_register(xe);
 
 	xe_hwmon_register(xe);
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 16ebb2859877f..58e79e19deaad 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -18,6 +18,7 @@
 #include "xe_memirq_types.h"
 #include "xe_oa_types.h"
 #include "xe_platform_types.h"
+#include "xe_pmu_types.h"
 #include "xe_pt_types.h"
 #include "xe_sriov_types.h"
 #include "xe_step_types.h"
@@ -514,6 +515,9 @@ struct xe_device {
 		int mode;
 	} wedged;
 
+	/** @pmu: performance monitoring unit */
+	struct xe_pmu pmu;
+
 #ifdef TEST_VM_OPS_ERROR
 	/**
 	 * @vm_inject_error_position: inject errors at different places in VM
diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
new file mode 100644
index 0000000000000..b63f819c54d02
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+#include <drm/drm_drv.h>
+#include <drm/drm_managed.h>
+#include <drm/xe_drm.h>
+
+#include "regs/xe_gt_regs.h"
+#include "xe_device.h"
+#include "xe_force_wake.h"
+#include "xe_gt_clock.h"
+#include "xe_gt_printk.h"
+#include "xe_mmio.h"
+#include "xe_macros.h"
+#include "xe_pm.h"
+#include "xe_pmu.h"
+
+/**
+ * DOC: Xe PMU (Performance Monitoring Unit)
+ *
+ * Expose events/counters like C6 residency and GT frequency to user land.
+ * Events will be per device, the GT can be selected with an extra config
+ * sub-field (bits 60-63).
+ *
+ * Perf tool can be used to list these counters from the command line.
+ *
+ * Example commands to list/record supported perf events-
+ *
+ * $ ls -ld /sys/bus/event_source/devices/xe_*
+ * $ ls /sys/bus/event_source/devices/xe_0000_00_02.0/events/
+ * $ ls /sys/bus/event_source/devices/xe_0000_00_02.0/format/
+ *
+ * The format directory has info regarding the configs that can be used.
+ *
+ * The standard perf tool can be used to grep for a certain event as well-
+ * $ perf list | grep c6
+ *
+ * To list a specific event for a GT at regular intervals-
+ * $ perf stat -e <event_name,xe_gt_id=> -I <interval>
+ */
+
+#define XE_PMU_EVENT_GT_MASK		GENMASK_ULL(63, 60)
+#define XE_PMU_EVENT_ID_MASK		GENMASK_ULL(11, 0)
+
+static unsigned int config_to_event_id(u64 config)
+{
+	return FIELD_GET(XE_PMU_EVENT_ID_MASK, config);
+}
+
+static unsigned int config_to_gt_id(u64 config)
+{
+	return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
+}
+
+static struct xe_gt *event_to_gt(struct perf_event *event)
+{
+	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
+	u64 gt = config_to_gt_id(event->attr.config);
+
+	return xe_device_get_gt(xe, gt);
+}
+
+static bool event_supported(struct xe_pmu *pmu, unsigned int gt,
+			    unsigned int id)
+{
+	if (gt >= XE_MAX_GT_PER_TILE)
+		return false;
+
+	return false;
+}
+
+static void xe_pmu_event_destroy(struct perf_event *event)
+{
+	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
+
+	drm_WARN_ON(&xe->drm, event->parent);
+	drm_dev_put(&xe->drm);
+}
+
+static int xe_pmu_event_init(struct perf_event *event)
+{
+	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
+	struct xe_pmu *pmu = &xe->pmu;
+	unsigned int id, gt;
+
+	if (!pmu->registered)
+		return -ENODEV;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* unsupported modes and filters */
+	if (event->attr.sample_period) /* no sampling */
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	gt = config_to_gt_id(event->attr.config);
+	id = config_to_event_id(event->attr.config);
+	if (!event_supported(pmu, gt, id))
+		return -ENOENT;
+
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
+	if (!event->parent) {
+		drm_dev_get(&xe->drm);
+		event->destroy = xe_pmu_event_destroy;
+	}
+
+	return 0;
+}
+
+static u64 __xe_pmu_event_read(struct perf_event *event)
+{
+	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
+	struct xe_gt *gt = event_to_gt(event);
+	u64 val = 0;
+
+	if (!gt)
+		return 0;
+
+	return val;
+}
+
+static void xe_pmu_event_read(struct perf_event *event)
+{
+	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
+	struct hw_perf_event *hwc = &event->hw;
+	struct xe_pmu *pmu = &xe->pmu;
+	u64 prev, new;
+
+	if (!pmu->registered) {
+		event->hw.state = PERF_HES_STOPPED;
+		return;
+	}
+
+	prev = local64_read(&hwc->prev_count);
+	do {
+		new = __xe_pmu_event_read(event);
+	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
+
+	local64_add(new - prev, &event->count);
+}
+
+static void xe_pmu_enable(struct perf_event *event)
+{
+	/*
+	 * Store the current counter value so we can report the correct delta
+	 * for all listeners. Even when the event was already enabled and has
+	 * an existing non-zero value.
+	 */
+	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event));
+}
+
+static void xe_pmu_event_start(struct perf_event *event, int flags)
+{
+	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
+	struct xe_pmu *pmu = &xe->pmu;
+
+	if (!pmu->registered)
+		return;
+
+	xe_pmu_enable(event);
+	event->hw.state = 0;
+}
+
+static void xe_pmu_event_stop(struct perf_event *event, int flags)
+{
+	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
+	struct xe_pmu *pmu = &xe->pmu;
+
+	if (pmu->registered)
+		if (flags & PERF_EF_UPDATE)
+			xe_pmu_event_read(event);
+
+	event->hw.state = PERF_HES_STOPPED;
+}
+
+static int xe_pmu_event_add(struct perf_event *event, int flags)
+{
+	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
+	struct xe_pmu *pmu = &xe->pmu;
+
+	if (!pmu->registered)
+		return -ENODEV;
+
+	if (flags & PERF_EF_START)
+		xe_pmu_event_start(event, flags);
+
+	return 0;
+}
+
+static void xe_pmu_event_del(struct perf_event *event, int flags)
+{
+	xe_pmu_event_stop(event, PERF_EF_UPDATE);
+}
+
+PMU_FORMAT_ATTR(gt,	"config:60-63");
+PMU_FORMAT_ATTR(event,	"config:0-11");
+
+static struct attribute *pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	&format_attr_gt.attr,
+	NULL,
+};
+
+static const struct attribute_group pmu_format_attr_group = {
+	.name = "format",
+	.attrs = pmu_format_attrs,
+};
+
+static struct attribute *pmu_event_attrs[] = {
+	/* No events yet */
+	NULL,
+};
+
+static const struct attribute_group pmu_events_attr_group = {
+	.name = "events",
+	.attrs = pmu_event_attrs,
+};
+
+/**
+ * xe_pmu_unregister() - Remove/cleanup PMU registration
+ * @arg: Ptr to pmu
+ */
+static void xe_pmu_unregister(void *arg)
+{
+	struct xe_pmu *pmu = arg;
+	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
+
+	if (!pmu->registered)
+		return;
+
+	pmu->registered = false;
+
+	perf_pmu_unregister(&pmu->base);
+	kfree(pmu->name);
+}
+
+/**
+ * xe_pmu_register() - Define basic PMU properties for Xe and add event callbacks.
+ * @pmu: the PMU object
+ *
+ * Returns 0 on success and an appropriate error code otherwise
+ */
+int xe_pmu_register(struct xe_pmu *pmu)
+{
+	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
+	static const struct attribute_group *attr_groups[] = {
+		&pmu_format_attr_group,
+		&pmu_events_attr_group,
+		NULL
+	};
+	int ret = -ENOMEM;
+	char *name;
+
+	if (IS_SRIOV_VF(xe))
+		return 0;
+
+	raw_spin_lock_init(&pmu->lock);
+
+	name = kasprintf(GFP_KERNEL, "xe_%s",
+			 dev_name(xe->drm.dev));
+	if (!name)
+		goto err;
+
+	/* tools/perf reserves colons as special. */
+	strreplace(name, ':', '_');
+
+	pmu->name		= name;
+	pmu->base.attr_groups	= attr_groups;
+	pmu->base.scope		= PERF_PMU_SCOPE_SYS_WIDE;
+	pmu->base.module	= THIS_MODULE;
+	pmu->base.task_ctx_nr	= perf_invalid_context;
+	pmu->base.event_init	= xe_pmu_event_init;
+	pmu->base.add		= xe_pmu_event_add;
+	pmu->base.del		= xe_pmu_event_del;
+	pmu->base.start		= xe_pmu_event_start;
+	pmu->base.stop		= xe_pmu_event_stop;
+	pmu->base.read		= xe_pmu_event_read;
+
+	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
+	if (ret)
+		goto err_name;
+
+	pmu->registered = true;
+
+	return devm_add_action_or_reset(xe->drm.dev, xe_pmu_unregister, pmu);
+
+err_name:
+	kfree(name);
+err:
+	drm_err(&xe->drm, "Failed to register PMU (ret=%d)!\n", ret);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/xe/xe_pmu.h b/drivers/gpu/drm/xe/xe_pmu.h
new file mode 100644
index 0000000000000..f9dfe77d00cb6
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_pmu.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+#ifndef _XE_PMU_H_
+#define _XE_PMU_H_
+
+#include "xe_pmu_types.h"
+
+struct xe_gt;
+
+#if IS_ENABLED(CONFIG_PERF_EVENTS)
+int xe_pmu_register(struct xe_pmu *pmu);
+#else
+static inline void xe_pmu_register(struct xe_pmu *pmu) {}
+#endif
+
+#endif
+
diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/xe_pmu_types.h
new file mode 100644
index 0000000000000..e0cf7169f4fda
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_pmu_types.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2025 Intel Corporation
+ */
+
+#ifndef _XE_PMU_TYPES_H_
+#define _XE_PMU_TYPES_H_
+
+#include <linux/perf_event.h>
+#include <linux/spinlock_types.h>
+
+enum {
+	__XE_NUM_PMU_SAMPLERS
+};
+
+#define XE_PMU_MAX_GT 2
+
+/**
+ * struct xe_pmu - PMU related data per Xe device
+ *
+ * Stores per device PMU info that includes event/perf attributes and
+ * sampling counters across all GTs for this device.
+ */
+struct xe_pmu {
+	/**
+	 * @base: PMU base.
+	 */
+	struct pmu base;
+	/**
+	 * @registered: PMU is registered and not in the unregistering process.
+	 */
+	bool registered;
+	/**
+	 * @name: Name as registered with perf core.
+	 */
+	const char *name;
+	/**
+	 * @lock: Lock protecting enable mask and ref count handling.
+	 */
+	raw_spinlock_t lock;
+};
+
+#endif
-- 
2.48.0

