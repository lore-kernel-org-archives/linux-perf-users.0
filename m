Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44413D600
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605995; cv=none; b=AaWjD29e/nnReYMsX28qjmuv5N6aHJBGTbs4qiU+j8oVzFYQKa/YXy3SJTRLKvAh8VoU7moTykkyrGhhylc/pZYPohi6KqYIP0UZXAZzPRebVBB+u9CFccqLGCQCv1UHJPv4Gza9BYbsydALjPYbDeG5jqyvE07Tle6uwMFxLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605995; c=relaxed/simple;
	bh=GMYtN58lSxmb/FadiQtd/pr85r7tPSKbpF8uj1qju9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ/RSweVGLfC6461uPUxU/LpyQB4a1nyTz/I9gUYCSWeoHUGQOCoFqIKkFMnHkYuCKapO5bNhNXo8665eK87N/vGlitNqrXF1ypkrqcOpWV5364WXLvuZt6u4ubQvBUMRdiLvxpEL+znBtnoXlzSJRs+MPleitmfSftZigkh5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuEj/VMA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuEj/VMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737605995; x=1769141995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GMYtN58lSxmb/FadiQtd/pr85r7tPSKbpF8uj1qju9M=;
  b=AuEj/VMA3q24x0575mhzJNGcbTW0KHTyyM1saiuNppei+3q2AwOYRJrj
   nCza4BCNySXAkbrK7dg2JDREpqCj9wauUpeBHNimavDGPXbtlj7Y6eJTN
   UAH94PinX1nV/d6fAosp1VJ/kGPmYViO00dC7hvYwtu1jgWL5Vc8XKTnl
   QzPtod+wvk5Nyv7PXvCJbmRTqy351GZzIxbLOt7a2ar2dLruIn99U4Yyw
   VcRhTs1EfHdzeVza/Fk9pwOuFnLvPLxjobdUKT7KxVIN0ZTuR/edqsRPI
   slr2+66BfVPTTdiuEilUOYGYlLi++lG0KuRKkjhwY21khP9hTJbIt2eAh
   Q==;
X-CSE-ConnectionGUID: nxQlcM1hR5OCMouAuiV4/A==
X-CSE-MsgGUID: +sOK5Y/fQIWhpeYhuX+pOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37971656"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37971656"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:19:48 -0800
X-CSE-ConnectionGUID: Tz/70hzzRk6ULIslq8FJ1w==
X-CSE-MsgGUID: potXgsHvSvOukD1p/kfpgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107202070"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:19:47 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v15 6/6] drm/xe/pmu: Add GT C6 events
Date: Wed, 22 Jan 2025 20:19:23 -0800
Message-ID: <20250123041923.1892837-7-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250123041923.1892837-1-lucas.demarchi@intel.com>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

Provide a PMU interface for GT C6 residency counters. The interface is
similar to the one available for i915, but gt is passed in the config
when creating the event.

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

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index 2b66a7957b665..850bc48053a6b 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 
 #include "xe_device.h"
+#include "xe_gt_idle.h"
 #include "xe_pm.h"
 #include "xe_pmu.h"
 
@@ -115,12 +116,16 @@ static int xe_pmu_event_init(struct perf_event *event)
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
@@ -270,6 +275,10 @@ static const struct attribute_group *pmu_events_attr_update[] = {
 
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

