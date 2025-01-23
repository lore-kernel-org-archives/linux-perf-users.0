Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13301C01
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605992; cv=none; b=k7utsArSxEwC2qj6YPxsPiUwL1l/9Wejq28S2esUPoRIjSzETUbdIyTJM/sjAEom00/aewoRds4uqxU25q62y5MDDuQsPtxNzt/Ft4NmnY8XT7YoIykMXEd2RUnueoRecb//W67pXadg0MnTUzsd8jUBp7b0OCNyVrbtbc8qWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605992; c=relaxed/simple;
	bh=eZTR39QMLiY/RZ674FYLRwrBqzYJ3uTOYgmO00Lrabs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0Ye9SUksB8qSx3ybEaBNBibjz9zgia872enCMXRfDiQQjyrerdcJGlsy34OcydKqUbDgCFStvf2y+fKxmckBpt01WGMKcjvGQuy6emiQZ4zwbauiBU5vQSriWPG8EhPXB6UXaYsoS9NWA8nmRf1jTCWD+9ocNR0xg7/B+rdKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br3dZQti; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br3dZQti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737605991; x=1769141991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZTR39QMLiY/RZ674FYLRwrBqzYJ3uTOYgmO00Lrabs=;
  b=Br3dZQtiZJRz4uS85ezWzRwpRmriSS2DnQGZbMsTWEYHXVP2Hhs2q1ni
   Hs8X2PHQuH0LdvGI8w1n7g5C7qUk+24A1RIdL4PM5boxgU4CMyHfXTzKl
   JAFIQT2n1Ox2R6alSvaCdPIgdFRHwWGFkX2ZLgBxYnGkcnRn/YsKHGIdB
   Hdb6i9sFtXC5mmiB9eo3rVKAJa5faZGLtPnCJgUtcQ3Y9tm6PNFba0XOS
   5qsfwdzN586SjlvdAG4UwhChEPMTokx19bRrqNbEpDM0x2JcG96ENHOxY
   hWVFTX/JdkWenYK5JPm3nU4IJngISfB8kpi94bb6K0KfulIOQ/l0dYJNY
   A==;
X-CSE-ConnectionGUID: gxmGcYImQZGtH7mQ1TnOeQ==
X-CSE-MsgGUID: DqR1SZOLSeyo2U65hZooeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37971647"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37971647"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:19:48 -0800
X-CSE-ConnectionGUID: B9dP2ppGQlGa1Rl989zMvA==
X-CSE-MsgGUID: ogrQEzlSTtiK1cKHx95+Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107202064"
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
Subject: [PATCH v15 4/6] drm/xe/pmu: Add attribute skeleton
Date: Wed, 22 Jan 2025 20:19:21 -0800
Message-ID: <20250123041923.1892837-5-lucas.demarchi@intel.com>
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

Add the generic support for defining new attributes. This uses
gt-c6-residency as first attribute to bootstrap it, but its
implementation will be added by a follow up commit: until proper support
is added, it will always be invisible in sysfs since the corresponding
bit is not set in the supported_events bitmap.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c       | 60 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_pmu_types.h |  4 +++
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index 33598272db6aa..5e5a9fcf30ace 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -46,6 +46,8 @@ static unsigned int config_to_gt_id(u64 config)
 	return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
 }
 
+#define XE_PMU_EVENT_GT_C6_RESIDENCY	0x01
+
 static struct xe_gt *event_to_gt(struct perf_event *event)
 {
 	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
@@ -60,7 +62,8 @@ static bool event_supported(struct xe_pmu *pmu, unsigned int gt,
 	if (gt >= XE_MAX_GT_PER_TILE)
 		return false;
 
-	return false;
+	return id < sizeof(pmu->supported_events) * BITS_PER_BYTE &&
+		pmu->supported_events & BIT_ULL(id);
 }
 
 static void xe_pmu_event_destroy(struct perf_event *event)
@@ -210,16 +213,62 @@ static const struct attribute_group pmu_format_attr_group = {
 	.attrs = pmu_format_attrs,
 };
 
-static struct attribute *pmu_event_attrs[] = {
-	/* No events yet */
+static ssize_t event_attr_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(buf, "event=%#04llx\n", pmu_attr->id);
+}
+
+#define XE_EVENT_ATTR(name_, v_, id_, unit_)				\
+	PMU_EVENT_ATTR(name_, pmu_event_ ## v_, id_, event_attr_show)	\
+	PMU_EVENT_ATTR_STRING(name_.unit, pmu_event_unit_ ## v_, unit_)	\
+	static struct attribute *pmu_attr_ ##v_[] = {			\
+		&pmu_event_ ##v_.attr.attr,				\
+		&pmu_event_unit_ ##v_.attr.attr,			\
+		NULL							\
+	};								\
+	static umode_t is_visible_##v_(struct kobject *kobj,		\
+				       struct attribute *attr, int idx) \
+	{								\
+		struct perf_pmu_events_attr *pmu_attr;			\
+		struct xe_pmu *pmu;					\
+									\
+		pmu_attr = container_of(attr, typeof(*pmu_attr), attr.attr); \
+		pmu = container_of(dev_get_drvdata(kobj_to_dev(kobj)),	\
+				   typeof(*pmu), base);			\
+									\
+		return event_supported(pmu, 0, id_) ? attr->mode : 0;	\
+	}								\
+	static const struct attribute_group pmu_group_ ##v_ = {		\
+		.name = "events",					\
+		.attrs = pmu_attr_ ## v_,				\
+		.is_visible = is_visible_ ## v_,			\
+	}
+
+XE_EVENT_ATTR(gt-c6-residency, gt_c6_residency, XE_PMU_EVENT_GT_C6_RESIDENCY, "ms");
+
+static struct attribute *pmu_empty_event_attrs[] = {
+	/* Empty - all events are added as groups with .attr_update() */
 	NULL,
 };
 
 static const struct attribute_group pmu_events_attr_group = {
 	.name = "events",
-	.attrs = pmu_event_attrs,
+	.attrs = pmu_empty_event_attrs,
 };
 
+static const struct attribute_group *pmu_events_attr_update[] = {
+	&pmu_group_gt_c6_residency,
+	NULL,
+};
+
+static void set_supported_events(struct xe_pmu *pmu)
+{
+}
+
 /**
  * xe_pmu_unregister() - Remove/cleanup PMU registration
  * @arg: Ptr to pmu
@@ -270,6 +319,7 @@ int xe_pmu_register(struct xe_pmu *pmu)
 
 	pmu->name		= name;
 	pmu->base.attr_groups	= attr_groups;
+	pmu->base.attr_update	= pmu_events_attr_update;
 	pmu->base.scope		= PERF_PMU_SCOPE_SYS_WIDE;
 	pmu->base.module	= THIS_MODULE;
 	pmu->base.task_ctx_nr	= perf_invalid_context;
@@ -280,6 +330,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
 	pmu->base.stop		= xe_pmu_event_stop;
 	pmu->base.read		= xe_pmu_event_read;
 
+	set_supported_events(pmu);
+
 	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
 	if (ret)
 		goto err_name;
diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/xe_pmu_types.h
index 0e8faae6bc1b3..f5ba4d56622cb 100644
--- a/drivers/gpu/drm/xe/xe_pmu_types.h
+++ b/drivers/gpu/drm/xe/xe_pmu_types.h
@@ -30,6 +30,10 @@ struct xe_pmu {
 	 * @name: Name as registered with perf core.
 	 */
 	const char *name;
+	/**
+	 * @supported_events: Bitmap of supported events, indexed by event id
+	 */
+	u64 supported_events;
 };
 
 #endif
-- 
2.48.0

