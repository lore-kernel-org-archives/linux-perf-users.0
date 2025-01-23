Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CAC212B0E
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 16:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650197; cv=none; b=Pw8pzXgUJsdI3rGdCcpIZ7InvdzXGRFiTG0MHXGN1d/pf/+lPa7nQKhdtMU/qdOiAr3/dvY0z1xXAimmzkkWVPKhofeEoRP3w0tRHZwUA1YUMwcufcz5L9oA8FQ38oE/AAxQRquw+qvpqRLcY0ElwqlEj5fd05vN2kdDymp64yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650197; c=relaxed/simple;
	bh=64IbdahkgotAOH0lXh1YWGZw+h2qmUEWDwn8/kYlCf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu9q+aPRDvmKPs3aELaRVMW5F7rmfAhO6nVOQxOF+BBuBzez3Z57K3McidkLCRZpUnAMfjKyM8AIdsWEtSp812if/SPdCEQ7pv5C7aYdW+Z9uLL0xSA5BjGBseTlBwxemE9BYeyKvUhCxTT+XT578GnYyuNQn/eb7ilCZz8CjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPAGaaZ6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPAGaaZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737650196; x=1769186196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=64IbdahkgotAOH0lXh1YWGZw+h2qmUEWDwn8/kYlCf8=;
  b=GPAGaaZ69O9kbVjVFpzylb1Kpoh/qjHz6RVC+z9Mq5Y/7lW9Zzh4Y0lx
   8IH4yLtHi707x6i4kX+AgKCCfierysgp11v+eXIk8XfQsq577i/5h37MK
   xxAH9kKvUserpDNvW8AwMBCbHvFVFmLXD39UbA9WDrbWljrO7LTf2WAHM
   SPMrax2Tj79CkaiDvCdELxglGL/Bb+INP5hSFM2261uERw4JpHrX4XrLj
   /Mxi3K9QeXysoHCQKVcXkNpZTgdWFYM6YJUAT6acTgGZlBG2b+SzASnF7
   O9rAvXqHxRksZIy5JyR2u2MiSbt+xraqBrFgaFnsMqhbZXOxWgx8hpgwJ
   Q==;
X-CSE-ConnectionGUID: jmDH6RKPQgeFBibeWMtJhA==
X-CSE-MsgGUID: LUYzvNX3TTuK/EXvIPoHhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41829848"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="41829848"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 08:36:34 -0800
X-CSE-ConnectionGUID: OwLx5jYZSYOGjjZerFwCog==
X-CSE-MsgGUID: Ck57eXAbQWGSkjVpXC1uCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138386915"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.110.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 08:36:33 -0800
Date: Thu, 23 Jan 2025 10:36:25 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, 
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v15 4/6] drm/xe/pmu: Add attribute skeleton
Message-ID: <5ngh3ary4rxw6spemr4aj5qhyaehalizexn3tha2xkdbar4mdw@ekcugbqqjild>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
 <20250123041923.1892837-5-lucas.demarchi@intel.com>
 <c0f2047a-9c6e-4a31-a8f8-0f287c09e242@intel.com>
 <xmu2uobe7p76cqpbyzyx7psfzm4aueta5egslo7ru3vgo3gqvb@7wwv5aym65hw>
 <b1fcdb65-c9b8-4dae-a54b-042742202ffe@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1fcdb65-c9b8-4dae-a54b-042742202ffe@intel.com>

On Thu, Jan 23, 2025 at 08:32:39PM +0530, Riana Tauro wrote:
>
>
>On 1/23/2025 8:18 PM, Lucas De Marchi wrote:
>>On Thu, Jan 23, 2025 at 07:24:22PM +0530, Riana Tauro wrote:
>>>Hi Lucas
>>>
>>>On 1/23/2025 9:49 AM, Lucas De Marchi wrote:
>>>>Add the generic support for defining new attributes. This uses
>>>>gt-c6-residency as first attribute to bootstrap it, but its
>>>>implementation will be added by a follow up commit: until proper support
>>>>is added, it will always be invisible in sysfs since the corresponding
>>>>bit is not set in the supported_events bitmap.
>>>>
>>>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>>>---
>>>> drivers/gpu/drm/xe/xe_pmu.c       | 60 ++++++++++++++++++++++++++++---
>>>> drivers/gpu/drm/xe/xe_pmu_types.h |  4 +++
>>>> 2 files changed, 60 insertions(+), 4 deletions(-)
>>>>
>>>>diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
>>>>index 33598272db6aa..5e5a9fcf30ace 100644
>>>>--- a/drivers/gpu/drm/xe/xe_pmu.c
>>>>+++ b/drivers/gpu/drm/xe/xe_pmu.c
>>>>@@ -46,6 +46,8 @@ static unsigned int config_to_gt_id(u64 config)
>>>>     return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
>>>> }
>>>>+#define XE_PMU_EVENT_GT_C6_RESIDENCY    0x01
>>>>+
>>>> static struct xe_gt *event_to_gt(struct perf_event *event)
>>>> {
>>>>     struct xe_device *xe = container_of(event->pmu, 
>>>>typeof(*xe), pmu.base);
>>>>@@ -60,7 +62,8 @@ static bool event_supported(struct xe_pmu 
>>>>*pmu, unsigned int gt,
>>>>     if (gt >= XE_MAX_GT_PER_TILE)
>>>>         return false;
>>>>-    return false;
>>>>+    return id < sizeof(pmu->supported_events) * BITS_PER_BYTE &&
>>>>+        pmu->supported_events & BIT_ULL(id);
>>>> }
>>>> static void xe_pmu_event_destroy(struct perf_event *event)
>>>>@@ -210,16 +213,62 @@ static const struct attribute_group 
>>>>pmu_format_attr_group = {
>>>>     .attrs = pmu_format_attrs,
>>>> };
>>>>-static struct attribute *pmu_event_attrs[] = {
>>>>-    /* No events yet */
>>>>+static ssize_t event_attr_show(struct device *dev,
>>>>+                   struct device_attribute *attr, char *buf)
>>>>+{
>>>>+    struct perf_pmu_events_attr *pmu_attr =
>>>>+        container_of(attr, struct perf_pmu_events_attr, attr);
>>>>+
>>>>+    return sprintf(buf, "event=%#04llx\n", pmu_attr->id);
>>>>+}
>>>>+
>>>>+#define XE_EVENT_ATTR(name_, v_, id_, unit_)                \
>>>>+    PMU_EVENT_ATTR(name_, pmu_event_ ## v_, id_, event_attr_show)    \
>>>>+    PMU_EVENT_ATTR_STRING(name_.unit, pmu_event_unit_ ## v_, 
>>>>unit_)    \
>>>>+    static struct attribute *pmu_attr_ ##v_[] = {            \
>>>>+        &pmu_event_ ##v_.attr.attr,                \
>>>>+        &pmu_event_unit_ ##v_.attr.attr,            \
>>>>+        NULL                            \
>>>>+    };                                \
>>>>+    static umode_t is_visible_##v_(struct kobject *kobj,        \
>>>>+                       struct attribute *attr, int idx) \
>>>>+    {                                \
>>>>+        struct perf_pmu_events_attr *pmu_attr;            \
>>>>+        struct xe_pmu *pmu;                    \
>>>>+                                    \
>>>>+        pmu_attr = container_of(attr, typeof(*pmu_attr), attr.attr); \
>>>>+        pmu = container_of(dev_get_drvdata(kobj_to_dev(kobj)),    \
>>>>+                   typeof(*pmu), base);            \
>>>>+                                    \
>>>>+        return event_supported(pmu, 0, id_) ? attr->mode : 0;    \
>>>>+    }                                \
>>>>+    static const struct attribute_group pmu_group_ ##v_ = {        \
>>>>+        .name = "events",                    \
>>>>+        .attrs = pmu_attr_ ## v_,                \
>>>>+        .is_visible = is_visible_ ## v_,            \
>>>>+    }
>>>>+
>>>There will be some events that do not have the unit. The previous 
>>>rev was simpler to handle such events
>>>
>>>Can the previous revision be retained?
>>
>>that would depend on merging the first patch in perf/core or bring that
>>define here.
>>
>>I think we can live with the similar approach of other drivers above and
>>in future try to add PMU_EVENT_ATTR_ID_STRING. However I'd like to have pmu
>>merged in xe without depending on that.
>Sorry, my bad. I missed that the core patch was removed in this series
> And if we simply add the macro
>>in xe, it means it will probably stay forever with nobody cleaning it up
>>later.
>>
>>Also, what event are you talking about?
>The upcoming per-engine-class-activity counters. They are similar to 
>the per-client and have no units.

on the per-client report to userspace we call it cycles to note
it's a time on the gpu domain, so just calling it "cycles" would
maintain consistency:

https://docs.kernel.org/gpu/drm-usage-stats.html

drm-cycles-<keystr>: <uint>
drm-total-cycles-<keystr>: <uint>


assuming userspace knows the CS frequency they can then even convert to
time unit.

>There are 2 or 3 alternatives:
>>
>>1) add a unit
>>
>>2) add an indirection to the macro above to allow defining an event
>>without unit. That's doable by having 3 macros: __XE_EVENT_ATTR,
>>XE_EVENT_ATTR, and XE_EVENT_ATTR_WITH_UNIT. Then you'd have:
>>
>>XE_EVENT_ATTR_WITH_UNIT(foo, ...)
>>XE_EVENT_ATTR(bar, ...)
>>
>>
>>3) Ungroup the macro so the group is separate, then we'd do:
>>
>>     XE_EVENT_ATTR(foo)
>>     XE_EVENT_ATTR_UNIT(foo, "ms")
>>     XE_EVENT_GROUP(foo, &pmu_event_foo.attr.attr,
>>                &pmu_event_unit_foo.attr.attr)
>>
>>     XE_EVENT_ATTR(bar)
>>     XE_EVENT_GROUP(bar, &pmu_event_bar.attr.attr)
>>
>Yeah will have to seperate it out.

I'm not against keep it unit less as I see several other drivers doing
so for cycle counters. If we are going to have unitless counters, I can
do that split in this patch.

thanks
Lucas De Marchi

>Sorry for the confusion.
>
>Thanks
>Riana
>>Lucas De Marchi
>>
>>>
>>>Thanks
>>>Riana
>>>>+XE_EVENT_ATTR(gt-c6-residency, gt_c6_residency, 
>>>>XE_PMU_EVENT_GT_C6_RESIDENCY, "ms");
>>>>+
>>>>+static struct attribute *pmu_empty_event_attrs[] = {
>>>>+    /* Empty - all events are added as groups with .attr_update() */
>>>>     NULL,
>>>> };
>>>> static const struct attribute_group pmu_events_attr_group = {
>>>>     .name = "events",
>>>>-    .attrs = pmu_event_attrs,
>>>>+    .attrs = pmu_empty_event_attrs,
>>>> };
>>>>+static const struct attribute_group *pmu_events_attr_update[] = {
>>>>+    &pmu_group_gt_c6_residency,
>>>>+    NULL,
>>>>+};
>>>>+
>>>>+static void set_supported_events(struct xe_pmu *pmu)
>>>>+{
>>>>+}
>>>>+
>>>> /**
>>>>  * xe_pmu_unregister() - Remove/cleanup PMU registration
>>>>  * @arg: Ptr to pmu
>>>>@@ -270,6 +319,7 @@ int xe_pmu_register(struct xe_pmu *pmu)
>>>>     pmu->name        = name;
>>>>     pmu->base.attr_groups    = attr_groups;
>>>>+    pmu->base.attr_update    = pmu_events_attr_update;
>>>>     pmu->base.scope        = PERF_PMU_SCOPE_SYS_WIDE;
>>>>     pmu->base.module    = THIS_MODULE;
>>>>     pmu->base.task_ctx_nr    = perf_invalid_context;
>>>>@@ -280,6 +330,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
>>>>     pmu->base.stop        = xe_pmu_event_stop;
>>>>     pmu->base.read        = xe_pmu_event_read;
>>>>+    set_supported_events(pmu);
>>>>+
>>>>     ret = perf_pmu_register(&pmu->base, pmu->name, -1);
>>>>     if (ret)
>>>>         goto err_name;
>>>>diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h 
>>>>b/drivers/gpu/drm/xe/ xe_pmu_types.h
>>>>index 0e8faae6bc1b3..f5ba4d56622cb 100644
>>>>--- a/drivers/gpu/drm/xe/xe_pmu_types.h
>>>>+++ b/drivers/gpu/drm/xe/xe_pmu_types.h
>>>>@@ -30,6 +30,10 @@ struct xe_pmu {
>>>>      * @name: Name as registered with perf core.
>>>>      */
>>>>     const char *name;
>>>>+    /**
>>>>+     * @supported_events: Bitmap of supported events, indexed 
>>>>by event id
>>>>+     */
>>>>+    u64 supported_events;
>>>> };
>>>> #endif
>>>
>
