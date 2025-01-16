Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA38022BAD8
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068873; cv=none; b=MlOHMK1aYOHYqiZqNaQRzro/QVBIGQO++ixmjBpUpHX+3cvLH4Ko8TDXj6Wcv/ctnxaX/SJ9gYvJq7AcRtPQ4Mp4QCDEOrZ3Ljd6cYADPrF5nZ9egxFsBxLJDyrJqqWpHxlXAbyF0OMrLAFjMiusASpzcxbxqhuFJd0z7hv1xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068873; c=relaxed/simple;
	bh=fwZ/deY7X4yLGI7Zlym4Uskr5sN5lEy0B+7dtV6lv3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6egqfxInaYJQLuyD/kRTvDiZhNu0TaYXwfRvLd8GMIGulYSDY+o58Wp5RNXv58B+tD8eQKfNN7hRKfk2CbUF60oZaruT7tAJah8O1HPRyqV6qMDvVnAo3zSNAp/n6NdpX0ODdh5Atc3jdJPIcJBlKXO+XEaPMicInEipaghmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNggzXv/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNggzXv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737068869; x=1768604869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fwZ/deY7X4yLGI7Zlym4Uskr5sN5lEy0B+7dtV6lv3M=;
  b=DNggzXv/HRfTRXo/a0LfSGtrljBx4uciC/6AlbEsKT1mWIV7wvZ+yrxh
   bM1kltlM7TcK+XlR2e0RB29VtXlMY2EuEWqzqhT7u+PpfeZxKAHEnSFxP
   ozZmJn2Y5kzkl/LOAWtHid5i2KyNhAt+4dsUijDsntSgL2bHkvGWRe/QN
   t8bqv1u85jxYUOthnQ05s4e9hS2I0BiW7WdcJ/IW5UX/Y/zxZfmqoBBnG
   JxHyODO0XlMk9sGKOrc1ekUcwIrV/bqdwlypK+2oSs8QkbalVhW9ArqZ4
   Du5mEyS05j0rAqMv41lrNo8JjKgeQLBFh2NN7MQN0zuQT2QDnNG5mIDxe
   A==;
X-CSE-ConnectionGUID: NgbvW9M+Qqmr96daEmNDPA==
X-CSE-MsgGUID: 3UIY61zLRdqzW2zlhaIDkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37364131"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37364131"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:42 -0800
X-CSE-ConnectionGUID: iEoCX+GDRCqCENgOmox29g==
X-CSE-MsgGUID: RyH7YQD2S/WhfIqULBxeNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="136474354"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v13 4/7] drm/xe/pmu: Hook up gt suspend notification
Date: Thu, 16 Jan 2025 15:07:15 -0800
Message-ID: <20250116230718.82460-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116230718.82460-1-lucas.demarchi@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

When the device is runtime suspended it's not desired to wake it up to
read the idle residency - that would make the measurement interfere on
the outcome. Hook up the pmu to the gt suspend flow so it's possible to
estimate the idle residency while device is suspended.

v2: Extract suspend notification as a preparatory step (Lucas)

Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt.c        |  3 +++
 drivers/gpu/drm/xe/xe_pmu.c       | 18 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_pmu.h       |  2 ++
 drivers/gpu/drm/xe/xe_pmu_types.h |  4 ++++
 4 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 26e64530ada27..d3b9df6438d6c 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -47,6 +47,7 @@
 #include "xe_mmio.h"
 #include "xe_pat.h"
 #include "xe_pm.h"
+#include "xe_pmu.h"
 #include "xe_mocs.h"
 #include "xe_reg_sr.h"
 #include "xe_ring_ops.h"
@@ -877,6 +878,8 @@ int xe_gt_suspend(struct xe_gt *gt)
 
 	xe_gt_disable_host_l2_vram(gt);
 
+	xe_pmu_suspend(gt);
+
 	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 	xe_gt_dbg(gt, "suspended\n");
 
diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index 2312c73a3ee16..ce53cfb846470 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -223,6 +223,24 @@ static const struct attribute_group pmu_events_attr_group = {
 	.attrs = pmu_event_attrs,
 };
 
+/**
+ * xe_pmu_suspend() - Save necessary state before suspending
+ * @gt: GT structure
+ */
+void xe_pmu_suspend(struct xe_gt *gt)
+{
+	struct xe_device *xe = gt_to_xe(gt);
+	struct xe_pmu *pmu = &xe->pmu;
+	unsigned long flags;
+
+	if (!pmu->registered)
+		return;
+
+	raw_spin_lock_irqsave(&pmu->lock, flags);
+	pmu->suspend_timestamp[gt->info.id] = ktime_get();
+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+}
+
 /**
  * xe_pmu_unregister() - Remove/cleanup PMU registration
  * @arg: Ptr to pmu
diff --git a/drivers/gpu/drm/xe/xe_pmu.h b/drivers/gpu/drm/xe/xe_pmu.h
index f9dfe77d00cb6..c53c6a4a2ae55 100644
--- a/drivers/gpu/drm/xe/xe_pmu.h
+++ b/drivers/gpu/drm/xe/xe_pmu.h
@@ -12,8 +12,10 @@ struct xe_gt;
 
 #if IS_ENABLED(CONFIG_PERF_EVENTS)
 int xe_pmu_register(struct xe_pmu *pmu);
+void xe_pmu_suspend(struct xe_gt *gt);
 #else
 static inline void xe_pmu_register(struct xe_pmu *pmu) {}
+static inline void xe_pmu_suspend(struct xe_gt *gt) {}
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/xe_pmu_types.h
index e0cf7169f4fda..883e462852377 100644
--- a/drivers/gpu/drm/xe/xe_pmu_types.h
+++ b/drivers/gpu/drm/xe/xe_pmu_types.h
@@ -38,6 +38,10 @@ struct xe_pmu {
 	 * @lock: Lock protecting enable mask and ref count handling.
 	 */
 	raw_spinlock_t lock;
+	/**
+	 * @suspend_timestamp: Last time GT suspended
+	 */
+	ktime_t suspend_timestamp[XE_PMU_MAX_GT];
 };
 
 #endif
-- 
2.48.0

