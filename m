Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034511B423F
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527058; cv=none; b=FmKH0l9WiNi8H0wzFDSne2Q1cwHR/gBAGeQq8vQW05B7uYf+9T26FsMbaQ+eeuv0rkLlMF3TTXEvxypago2/fNw+12Ohrs6L++8lU314M2ex5sVMNiDVm4QYlzAAuBWlACuWTZzlIc0XlhsDSZZa4Z3IfVX5AvtpBD2Sny7/DfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527058; c=relaxed/simple;
	bh=CRZMCoaw+UNdqv2H50kCYYFvtiLmwedcYFLCS1H6GbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N//BnhOXxZf19Q4PZnUMvfJ5bRgL3cWNwtqCTLQKdpY8Gm3apvQ2kXO5Ruu9FzuJdrVAI3ADQVCNI4OFnAhhpJTU3zsz1kMPFYf3aw8jMnDmyo4MVeO4peh25PPin9QDlwfo2ml+EVmRleW9sh0y0aaFGhcAD4GPLY/xh3dnOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ0mbB+Q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ0mbB+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737527057; x=1769063057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CRZMCoaw+UNdqv2H50kCYYFvtiLmwedcYFLCS1H6GbY=;
  b=fZ0mbB+QCErwuvs/nh4je3taOAJwfFe+SnD2uIb56rVQN9j9EqW6vLch
   MFbOTfP7hzDr1Ws8HmWwWVKv624pslODci/LhOQga5Ji8iLajVc13Vg7V
   ZvR+IdmXj71f5ra0iFm3xyH9BtO2B4QA1/YBygisA/w4hYMsx3ao3byjN
   5lt46odVgmrtijWcKQxUVO7N/obJ57SEYxs88KHZWKE8oJbegPRamBCPm
   /VeEFhp7bzixyuL2jvZlDmi2OKz0KHwpNq0oBtuqn3x/+1srmOr9mCf22
   Prqt0EgUYaQdcyGrP2zQcvakzGPR/aJJIvEU0s5z9B43LkEXPF3y+i+F3
   w==;
X-CSE-ConnectionGUID: 1D9QlwOxSx2M2RPqAEfS4w==
X-CSE-MsgGUID: 7/lxrz2JSCmgTsmViSop/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41643301"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="41643301"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
X-CSE-ConnectionGUID: LrmqPodXSDijaO/zogvppQ==
X-CSE-MsgGUID: XScVznsnTYSSBF5bXUQt+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112015670"
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
Subject: [PATCH v14 5/7] drm/xe/pmu: Add attribute skeleton
Date: Tue, 21 Jan 2025 22:23:39 -0800
Message-ID: <20250122062341.1100173-6-lucas.demarchi@intel.com>
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

Add the generic support for defining new attributes. This uses
gt-c6-residency as first attribute to bootstrap it, but its
implementation will be added by a follow up commit: until proper support
is added, it will always be invisible in sysfs since the corresponding
bit is not set in the supported_events bitmap.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c       | 46 +++++++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_pmu_types.h |  4 +++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index 5a93634f17a2b..68ebec1746a53 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -54,6 +54,8 @@ static unsigned int config_to_gt_id(u64 config)
 	return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
 }
 
+#define XE_PMU_EVENT_GT_C6_RESIDENCY	0x01
+
 static struct xe_gt *event_to_gt(struct perf_event *event)
 {
 	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
@@ -68,7 +70,8 @@ static bool event_supported(struct xe_pmu *pmu, unsigned int gt,
 	if (gt >= XE_MAX_GT_PER_TILE)
 		return false;
 
-	return false;
+	return id < sizeof(pmu->supported_events) * BITS_PER_BYTE &&
+		pmu->supported_events & BIT_ULL(id);
 }
 
 static void xe_pmu_event_destroy(struct perf_event *event)
@@ -218,16 +221,53 @@ static const struct attribute_group pmu_format_attr_group = {
 	.attrs = pmu_format_attrs,
 };
 
+static ssize_t event_attr_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(buf, "event=%#04llx\n", pmu_attr->id);
+}
+
+static umode_t event_attr_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, typeof(*pmu_attr), attr.attr);
+	struct xe_pmu *pmu =
+	       container_of(dev_get_drvdata(dev), typeof(*pmu), base);
+
+	if (event_supported(pmu, 0, pmu_attr->id))
+		return attr->mode;
+
+	return 0;
+}
+
+#define XE_EVENT_ATTR(name_, v_, id_, unit_)					\
+	PMU_EVENT_ATTR(name_, pmu_event_ ## v_, id_, event_attr_show)		\
+	PMU_EVENT_ATTR_ID_STRING(name_.unit, pmu_event_unit_ ## v_, id_, unit_)
+
+XE_EVENT_ATTR(gt-c6-residency, gt_c6_residency, XE_PMU_EVENT_GT_C6_RESIDENCY, "ms")
+
 static struct attribute *pmu_event_attrs[] = {
-	/* No events yet */
+	&pmu_event_gt_c6_residency.attr.attr,
+	&pmu_event_unit_gt_c6_residency.attr.attr,
+
 	NULL,
 };
 
 static const struct attribute_group pmu_events_attr_group = {
 	.name = "events",
 	.attrs = pmu_event_attrs,
+	.is_visible = event_attr_is_visible,
 };
 
+static void set_supported_events(struct xe_pmu *pmu)
+{
+}
+
 /**
  * xe_pmu_unregister() - Remove/cleanup PMU registration
  * @arg: Ptr to pmu
@@ -290,6 +330,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
 	pmu->base.stop		= xe_pmu_event_stop;
 	pmu->base.read		= xe_pmu_event_read;
 
+	set_supported_events(pmu);
+
 	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
 	if (ret)
 		goto err_name;
diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/xe_pmu_types.h
index e0cf7169f4fda..64a1ca881c233 100644
--- a/drivers/gpu/drm/xe/xe_pmu_types.h
+++ b/drivers/gpu/drm/xe/xe_pmu_types.h
@@ -38,6 +38,10 @@ struct xe_pmu {
 	 * @lock: Lock protecting enable mask and ref count handling.
 	 */
 	raw_spinlock_t lock;
+	/**
+	 * @supported_events: Bitmap of supported events, indexed by event id
+	 */
+	u64 supported_events;
 };
 
 #endif
-- 
2.48.0

