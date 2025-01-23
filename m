Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72638B
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643713; cv=none; b=usUsxI2irtX6Swk1RZUs1pTJ0heM3oYah1e52mNJtOmbTEo5rXEeHitvbNc7whoe8RCJ7fEvePQjFvDvxm8Au+42E5PIrWc0eP3FWNgC1snLxiDREFhTQA+watFOgnQTHDMoRcemdwSlGUX1m14b/lbtcuucD5ZkPqNtToPhwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643713; c=relaxed/simple;
	bh=gJ4TRxCKHffzpEipcS0Tmwgd3yvhusdK55dqfeB96PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzYvWRkUD0XoVwaa9QB3G16mwapCY4Yna6ku6pLdCnCj1TRqUtvSRPWpSSzYb+EqbfAPkTwdi5Z5eb53FGxfRLs9p54008udG26n+XUgq7i2qrXOfYPYi2TkGB3anUAPaUTrHgSO3zwtU/3nmO9q+wYhNLaS+KhJf+p9EPT9fgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyvycs/a; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyvycs/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737643711; x=1769179711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gJ4TRxCKHffzpEipcS0Tmwgd3yvhusdK55dqfeB96PU=;
  b=kyvycs/ayB91mLgP8BXUynHTtA+Le9/ccuEKY3eBLINCsE2tZOF3loGZ
   i3Hz1nlFB2QbKyDeUCAS/nxvo2Yt89YfrrDny0diO72/yXjSIPvdoqvJ5
   gyjHwpxbr//GJNdAY+F9eFY0ihnIbOgFnImOQGAZH8ECUihAXAUDistqT
   a3QZ7bDUYKKdzN7r/40hd69xwssh9j+Q3kM+Szq2fn4zrULbzXY8JEB8s
   bLo8s+VX/fvM79pfxWXnH4SFrh0W8Hw69JmCYVipBj2IK1HHUL8EMY/40
   fADLN6pq6E9ghszBJEgOIBmYTYA23i0eV4EILjEO/w3k4wXOXpNQcgAqQ
   Q==;
X-CSE-ConnectionGUID: k9yD/B0zRZODLhCydeHhHA==
X-CSE-MsgGUID: ONkrNltgRzCguTi1SFWYpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41900578"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="41900578"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:48:31 -0800
X-CSE-ConnectionGUID: H8Sk2nvYRSGM1UW6osgTcg==
X-CSE-MsgGUID: CnCzrRSTQbGv23M3KM+Tww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107291154"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.110.196])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:48:29 -0800
Date: Thu, 23 Jan 2025 08:48:23 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, 
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v15 4/6] drm/xe/pmu: Add attribute skeleton
Message-ID: <xmu2uobe7p76cqpbyzyx7psfzm4aueta5egslo7ru3vgo3gqvb@7wwv5aym65hw>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
 <20250123041923.1892837-5-lucas.demarchi@intel.com>
 <c0f2047a-9c6e-4a31-a8f8-0f287c09e242@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c0f2047a-9c6e-4a31-a8f8-0f287c09e242@intel.com>

On Thu, Jan 23, 2025 at 07:24:22PM +0530, Riana Tauro wrote:
>Hi Lucas
>
>On 1/23/2025 9:49 AM, Lucas De Marchi wrote:
>>Add the generic support for defining new attributes. This uses
>>gt-c6-residency as first attribute to bootstrap it, but its
>>implementation will be added by a follow up commit: until proper support
>>is added, it will always be invisible in sysfs since the corresponding
>>bit is not set in the supported_events bitmap.
>>
>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>---
>>  drivers/gpu/drm/xe/xe_pmu.c       | 60 ++++++++++++++++++++++++++++---
>>  drivers/gpu/drm/xe/xe_pmu_types.h |  4 +++
>>  2 files changed, 60 insertions(+), 4 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
>>index 33598272db6aa..5e5a9fcf30ace 100644
>>--- a/drivers/gpu/drm/xe/xe_pmu.c
>>+++ b/drivers/gpu/drm/xe/xe_pmu.c
>>@@ -46,6 +46,8 @@ static unsigned int config_to_gt_id(u64 config)
>>  	return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
>>  }
>>+#define XE_PMU_EVENT_GT_C6_RESIDENCY	0x01
>>+
>>  static struct xe_gt *event_to_gt(struct perf_event *event)
>>  {
>>  	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
>>@@ -60,7 +62,8 @@ static bool event_supported(struct xe_pmu *pmu, unsigned int gt,
>>  	if (gt >= XE_MAX_GT_PER_TILE)
>>  		return false;
>>-	return false;
>>+	return id < sizeof(pmu->supported_events) * BITS_PER_BYTE &&
>>+		pmu->supported_events & BIT_ULL(id);
>>  }
>>  static void xe_pmu_event_destroy(struct perf_event *event)
>>@@ -210,16 +213,62 @@ static const struct attribute_group pmu_format_attr_group = {
>>  	.attrs = pmu_format_attrs,
>>  };
>>-static struct attribute *pmu_event_attrs[] = {
>>-	/* No events yet */
>>+static ssize_t event_attr_show(struct device *dev,
>>+			       struct device_attribute *attr, char *buf)
>>+{
>>+	struct perf_pmu_events_attr *pmu_attr =
>>+		container_of(attr, struct perf_pmu_events_attr, attr);
>>+
>>+	return sprintf(buf, "event=%#04llx\n", pmu_attr->id);
>>+}
>>+
>>+#define XE_EVENT_ATTR(name_, v_, id_, unit_)				\
>>+	PMU_EVENT_ATTR(name_, pmu_event_ ## v_, id_, event_attr_show)	\
>>+	PMU_EVENT_ATTR_STRING(name_.unit, pmu_event_unit_ ## v_, unit_)	\
>>+	static struct attribute *pmu_attr_ ##v_[] = {			\
>>+		&pmu_event_ ##v_.attr.attr,				\
>>+		&pmu_event_unit_ ##v_.attr.attr,			\
>>+		NULL							\
>>+	};								\
>>+	static umode_t is_visible_##v_(struct kobject *kobj,		\
>>+				       struct attribute *attr, int idx) \
>>+	{								\
>>+		struct perf_pmu_events_attr *pmu_attr;			\
>>+		struct xe_pmu *pmu;					\
>>+									\
>>+		pmu_attr = container_of(attr, typeof(*pmu_attr), attr.attr); \
>>+		pmu = container_of(dev_get_drvdata(kobj_to_dev(kobj)),	\
>>+				   typeof(*pmu), base);			\
>>+									\
>>+		return event_supported(pmu, 0, id_) ? attr->mode : 0;	\
>>+	}								\
>>+	static const struct attribute_group pmu_group_ ##v_ = {		\
>>+		.name = "events",					\
>>+		.attrs = pmu_attr_ ## v_,				\
>>+		.is_visible = is_visible_ ## v_,			\
>>+	}
>>+
>There will be some events that do not have the unit. The previous rev 
>was simpler to handle such events
>
>Can the previous revision be retained?

that would depend on merging the first patch in perf/core or bring that
define here.

I think we can live with the similar approach of other drivers above and
in future try to add PMU_EVENT_ATTR_ID_STRING. However I'd like to have pmu
merged in xe without depending on that. And if we simply add the macro
in xe, it means it will probably stay forever with nobody cleaning it up
later.

Also, what event are you talking about? There are 2 or 3 alternatives:

1) add a unit

2) add an indirection to the macro above to allow defining an event
without unit. That's doable by having 3 macros: __XE_EVENT_ATTR,
XE_EVENT_ATTR, and XE_EVENT_ATTR_WITH_UNIT. Then you'd have:

XE_EVENT_ATTR_WITH_UNIT(foo, ...)
XE_EVENT_ATTR(bar, ...)


3) Ungroup the macro so the group is separate, then we'd do:

	XE_EVENT_ATTR(foo)
	XE_EVENT_ATTR_UNIT(foo, "ms")
	XE_EVENT_GROUP(foo, &pmu_event_foo.attr.attr,
		       &pmu_event_unit_foo.attr.attr)

	XE_EVENT_ATTR(bar)
	XE_EVENT_GROUP(bar, &pmu_event_bar.attr.attr)

Lucas De Marchi

>
>Thanks
>Riana
>>+XE_EVENT_ATTR(gt-c6-residency, gt_c6_residency, XE_PMU_EVENT_GT_C6_RESIDENCY, "ms");
>>+
>>+static struct attribute *pmu_empty_event_attrs[] = {
>>+	/* Empty - all events are added as groups with .attr_update() */
>>  	NULL,
>>  };
>>  static const struct attribute_group pmu_events_attr_group = {
>>  	.name = "events",
>>-	.attrs = pmu_event_attrs,
>>+	.attrs = pmu_empty_event_attrs,
>>  };
>>+static const struct attribute_group *pmu_events_attr_update[] = {
>>+	&pmu_group_gt_c6_residency,
>>+	NULL,
>>+};
>>+
>>+static void set_supported_events(struct xe_pmu *pmu)
>>+{
>>+}
>>+
>>  /**
>>   * xe_pmu_unregister() - Remove/cleanup PMU registration
>>   * @arg: Ptr to pmu
>>@@ -270,6 +319,7 @@ int xe_pmu_register(struct xe_pmu *pmu)
>>  	pmu->name		= name;
>>  	pmu->base.attr_groups	= attr_groups;
>>+	pmu->base.attr_update	= pmu_events_attr_update;
>>  	pmu->base.scope		= PERF_PMU_SCOPE_SYS_WIDE;
>>  	pmu->base.module	= THIS_MODULE;
>>  	pmu->base.task_ctx_nr	= perf_invalid_context;
>>@@ -280,6 +330,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
>>  	pmu->base.stop		= xe_pmu_event_stop;
>>  	pmu->base.read		= xe_pmu_event_read;
>>+	set_supported_events(pmu);
>>+
>>  	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
>>  	if (ret)
>>  		goto err_name;
>>diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/xe_pmu_types.h
>>index 0e8faae6bc1b3..f5ba4d56622cb 100644
>>--- a/drivers/gpu/drm/xe/xe_pmu_types.h
>>+++ b/drivers/gpu/drm/xe/xe_pmu_types.h
>>@@ -30,6 +30,10 @@ struct xe_pmu {
>>  	 * @name: Name as registered with perf core.
>>  	 */
>>  	const char *name;
>>+	/**
>>+	 * @supported_events: Bitmap of supported events, indexed by event id
>>+	 */
>>+	u64 supported_events;
>>  };
>>  #endif
>
