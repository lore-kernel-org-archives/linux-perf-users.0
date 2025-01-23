Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9C13A25B
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605995; cv=none; b=eRTjoPsWWKRjno5wipUO3idoiXg5WbezV0Qv7WQ3iI/4YfwscTTCkG8emRFX9ZtStheD8dFlvjBJXIqfp7s8VG4hqB8hJtRaHRiXDVtgPGybt964E6s9vS+G9jY0jqmDERK/6efxy1CAkkFirXBmPSoJCVmg3Gi1WZ0B6vNtuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605995; c=relaxed/simple;
	bh=GbSkrVCQ6St6WTtTFr8henqmfW4s8kz28hTv8mQMS6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF/8xZxdOzud4Ta5OSOFPkKMw9D4iQz8GJvpLzDoPW5Kw48sLkjBPv+n+WFg87SnZEJ+nIwMisU0YWZkTCOHQRtJM/AwCk3/YoXc2aemGdna82+7H3hy/92oMq9iUfLCEk/WPTq8ZGkHnmBPOU4EglYn7HykIjjvJc5w6TCVUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSG21cGn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSG21cGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737605993; x=1769141993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GbSkrVCQ6St6WTtTFr8henqmfW4s8kz28hTv8mQMS6A=;
  b=GSG21cGns314cYhDugFy5FV98XiqcNU1hdOgiJ0jv1yLwBElRczoNjKm
   XFijQ42ZeQncaAHqMJHSETentfu2YnMv/nmQ75bf38oPPwGjyevUF2YkY
   mUvSCgXS/Ixvth6TZixeQtkXvVYUrArCnlYnMXDxY/oE8HSuRXkFFdA8g
   MfzRgess8PryLA+MbqtYtRKFyykF2+8fU8GzXkwN1Ch7hS2Agr7T1NwJq
   zTxE+BippW0f/wtD1scOxaSIzTFqryz/DYYIUW/eDQR+vBusy5d9UFcX6
   Ld9boKe/fw6lUvA5pH8sSTGed9hbRv+vxEWIwFXYChuDA+XGzEmQCOvT+
   w==;
X-CSE-ConnectionGUID: 8z5iXKR5T7Snn3Zvgdx9hA==
X-CSE-MsgGUID: tIfCDUW7RfqPyg9/YaosCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37971650"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37971650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:19:48 -0800
X-CSE-ConnectionGUID: n4sbsBBzSF+zSvTqYuZjrg==
X-CSE-MsgGUID: vn/49FcJQ82R95zpPTXTTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107202067"
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
Subject: [PATCH v15 5/6] drm/xe/pmu: Get/put runtime pm on event init
Date: Wed, 22 Jan 2025 20:19:22 -0800
Message-ID: <20250123041923.1892837-6-lucas.demarchi@intel.com>
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

When the event is created, make sure runtime pm is taken and later put:
in order to read an event counter the GPU needs to remain accessible and
doing a get/put during perf's read is not possible it's holding a
raw_spinlock.

Suggested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index 5e5a9fcf30ace..2b66a7957b665 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 
 #include "xe_device.h"
+#include "xe_pm.h"
 #include "xe_pmu.h"
 
 /**
@@ -71,6 +72,7 @@ static void xe_pmu_event_destroy(struct perf_event *event)
 	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
 
 	drm_WARN_ON(&xe->drm, event->parent);
+	xe_pm_runtime_put(xe);
 	drm_dev_put(&xe->drm);
 }
 
@@ -103,6 +105,7 @@ static int xe_pmu_event_init(struct perf_event *event)
 
 	if (!event->parent) {
 		drm_dev_get(&xe->drm);
+		xe_pm_runtime_get(xe);
 		event->destroy = xe_pmu_event_destroy;
 	}
 
-- 
2.48.0

