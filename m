Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA61BC9FB
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527060; cv=none; b=qVnHA7KwZjT6bIuQ0nUe9PyZWxWLHbMaZpE5p9CoOqp2izQ6U06D2yFyf/KDTzr7PYXRG1kEri0qXijtPscimKyYc6+5egTlYcGaj+hHJU+baNdLK407JC4/2LJwHH/uBwMUWnVFGhNoWae3qNoKvH9TnD/VPXOQN36ZCTswnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527060; c=relaxed/simple;
	bh=p/+NNg89GlQy/DYDdHWWjMuQtUWq+U3T3MEJJPZV0II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2lQquSX8LvPfgACXliS6KH8ihbR3KmF1TU5dJ4HzDa0BplVZynIGlLg7lIo1dCdgBniYJMT+AxwurnRLbtbtKXXrTHJnK9LPgFvPV8osqeOLUceE87GOQxQmy4sh0xqY9qLwHVRQRkIaJO+2C4L12iXU+JDEeUJaWvigZa77CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyK7thLQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyK7thLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737527059; x=1769063059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/+NNg89GlQy/DYDdHWWjMuQtUWq+U3T3MEJJPZV0II=;
  b=GyK7thLQDagvQfLbK2+XoqguhDaTP164KDDGSUkFOhvKWb7U/WMWIGxu
   rlCFyRLHXHcKiLCOiywElUdb3h+1ihhY6v407WIWczaI6t7P63+XRR2uM
   VGi7pLis0BYHiZW98DTXjyTupm4alRLjywjpf/jgulJ2bMnj23RA2gvy+
   tHmiLnA88xD2NROpWLQw8BgPBl2CQhl+OUdz7vTQMbwNa3q3paTOh7L6T
   Qs5JCaWQHrXImt2oGPtxwHzjoLg7twfb3UnvjVfDPcR+P1PyA9yz3d40x
   f+enmQho6TqgxPybpvO852U62SzT2l1RFEM/Xgc9Yj4pofbyhDFGG1eIm
   A==;
X-CSE-ConnectionGUID: S7G/jv/4ToavtS1G8tjK/g==
X-CSE-MsgGUID: Q7XxJ50TTxSJI0n6xOh0aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41643311"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="41643311"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
X-CSE-ConnectionGUID: etBn6WEWRPaGSGDA7qHbww==
X-CSE-MsgGUID: Tm9DbMGmT2qzMzrDL2UKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112015676"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v14 7/7] drm/xe/pmu: Add GT C6 events
Date: Tue, 21 Jan 2025 22:23:41 -0800
Message-ID: <20250122062341.1100173-8-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250122062341.1100173-1-lucas.demarchi@intel.com>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

Provide a PMU interface for GT C6 residency counters. The implementation
is ported over from the i915 PMU code. Residency is provided in units of
ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).

Sample usage and output:

	$ perf list | grep gt-c6
	  xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU event]

	$ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency*
	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency <==
	event=0x01

	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency.unit <==
	ms

	$ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
	#           time             counts unit events
	     1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
	     2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/

Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index 8d938d67c1f2c..a2e4addd3dd7e 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -11,6 +11,7 @@
 #include "xe_device.h"
 #include "xe_force_wake.h"
 #include "xe_gt_clock.h"
+#include "xe_gt_idle.h"
 #include "xe_gt_printk.h"
 #include "xe_mmio.h"
 #include "xe_macros.h"
@@ -122,12 +123,16 @@ static int xe_pmu_event_init(struct perf_event *event)
 static u64 __xe_pmu_event_read(struct perf_event *event)
 {
 	struct xe_gt *gt = event_to_gt(event);
-	u64 val = 0;
 
 	if (!gt)
 		return 0;
 
-	return val;
+	switch (config_to_event_id(event->attr.config)) {
+	case XE_PMU_EVENT_GT_C6_RESIDENCY:
+		return xe_gt_idle_residency_msec(&gt->gtidle);
+	}
+
+	return 0;
 }
 
 static void xe_pmu_event_update(struct perf_event *event)
@@ -268,6 +273,10 @@ static const struct attribute_group pmu_events_attr_group = {
 
 static void set_supported_events(struct xe_pmu *pmu)
 {
+	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
+
+	if (!xe->info.skip_guc_pc)
+		pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
 }
 
 /**
-- 
2.48.0

