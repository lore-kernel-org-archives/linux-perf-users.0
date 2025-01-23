Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5619A
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591086; cv=none; b=YPMmBDAtibC2vREHRqg2rBlyXqhoJ3RBQgtJsF0ITYBbhngafIa/WphVvBmvPpj9ctOZBavoRylR+u8sA4u78h7hlpMvfASF5X9QtSAtAjb0Na0ajKBfhj8Zkti4BvJcm/MlYpU7ycJny92UmsHhnub17lcStTKnnePJ/hCNszU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591086; c=relaxed/simple;
	bh=8Oq1I09chMZ7kCYifAGRlWn4vjEtfV0h2+BWPYR24pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSyXnnQOvkHM5u8cMf6dWHHCgc923RNtWm2BHR5w8RfS68eHqbgesm5EgcpGnbn6WsoAq8J2dwK4cPu5eEhoR0Othn913EPHeK9qh/X3XWcyGVGa/In/Q8rAWWXUYd8T2EEsBtIxsF7AOoQ4lGHmeQhSu47RL/KHjhl5NRxTCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvITVgic; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvITVgic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737591085; x=1769127085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Oq1I09chMZ7kCYifAGRlWn4vjEtfV0h2+BWPYR24pU=;
  b=nvITVgicmUvOxCNIHair0y8Rk52aSv2IVRT1zsvxqch+VBjOAOwd4rdM
   ivhwX3pjFAdHVhjat2JhJn7gWQjxdKTJl67iUxCDO6UF/MevxTA4UAtyK
   c8CUHXC6uQjoFu365r5OGjZ3h50zsPjxm3D8AlbCOn9v2fyGIEOClL98C
   RiecSyaOxTqKK8fgrILTeMk9pwmPyM7mjlkAD4uzh4c8SFN6NSLdqqg5M
   +5wdOkHWOAtvOgGOhnx08y7h/CTkVLMrbvn7nkFZICNK367srVEx625nf
   t/tzUmupsu6uGMRZqMvAHWm6igsx2mIHTaXopzVY680J2hK9w0hDvRbEJ
   w==;
X-CSE-ConnectionGUID: tilHqw9CT2ythAEteV/G7A==
X-CSE-MsgGUID: 08eM67pSQLi6rb9b2fsQjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="48573759"
X-IronPort-AV: E=Sophos;i="6.13,226,1732608000"; 
   d="scan'208";a="48573759"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 16:11:24 -0800
X-CSE-ConnectionGUID: 6F50MrHSTCquORvs+PxXAg==
X-CSE-MsgGUID: FxOJWgs0QnWspheZV8wUlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111306716"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.110.184])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 16:11:23 -0800
Date: Wed, 22 Jan 2025 18:11:16 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, 
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>, Riana Tauro <riana.tauro@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v14 7/7] drm/xe/pmu: Add GT C6 events
Message-ID: <rdvkppomauaxftepmkzyfypf5nkbrw4q6obwz5qyitsljlwkku@rwnsbspgj4ul>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
 <20250122062341.1100173-8-lucas.demarchi@intel.com>
 <Z5DJW7oYSlp6ZTQn@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z5DJW7oYSlp6ZTQn@intel.com>

On Wed, Jan 22, 2025 at 05:32:59AM -0500, Rodrigo Vivi wrote:
>On Tue, Jan 21, 2025 at 10:23:41PM -0800, Lucas De Marchi wrote:
>> From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>>
>> Provide a PMU interface for GT C6 residency counters. The implementation
>> is ported over from the i915 PMU code.
>
>This is not valid anymore right?! Perhaps rephrase to show that the API
>design itself was taken from there?

yep, re-phrased:

Provide a PMU interface for GT C6 residency counters. The interface is  
similar to the one available for i915, but gt is passed in the config   
when creating the event.                                                

>
>> Residency is provided in units of
>> ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).
>>
>> Sample usage and output:
>>
>> 	$ perf list | grep gt-c6
>> 	  xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU event]
>>
>> 	$ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency*
>> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency <==
>> 	event=0x01
>>
>> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency.unit <==
>> 	ms
>>
>> 	$ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
>> 	#           time             counts unit events
>> 	     1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
>> 	     2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
>>
>> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>  drivers/gpu/drm/xe/xe_pmu.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
>> index 8d938d67c1f2c..a2e4addd3dd7e 100644
>> --- a/drivers/gpu/drm/xe/xe_pmu.c
>> +++ b/drivers/gpu/drm/xe/xe_pmu.c
>> @@ -11,6 +11,7 @@
>>  #include "xe_device.h"
>>  #include "xe_force_wake.h"
>>  #include "xe_gt_clock.h"
>> +#include "xe_gt_idle.h"
>>  #include "xe_gt_printk.h"
>>  #include "xe_mmio.h"
>>  #include "xe_macros.h"
>> @@ -122,12 +123,16 @@ static int xe_pmu_event_init(struct perf_event *event)
>>  static u64 __xe_pmu_event_read(struct perf_event *event)
>>  {
>>  	struct xe_gt *gt = event_to_gt(event);
>> -	u64 val = 0;
>>
>>  	if (!gt)
>>  		return 0;
>>
>> -	return val;
>> +	switch (config_to_event_id(event->attr.config)) {
>> +	case XE_PMU_EVENT_GT_C6_RESIDENCY:
>> +		return xe_gt_idle_residency_msec(&gt->gtidle);
>> +	}
>> +
>> +	return 0;
>>  }
>>
>>  static void xe_pmu_event_update(struct perf_event *event)
>> @@ -268,6 +273,10 @@ static const struct attribute_group pmu_events_attr_group = {
>>
>>  static void set_supported_events(struct xe_pmu *pmu)
>>  {
>> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
>> +
>> +	if (!xe->info.skip_guc_pc)
>> +		pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
>>  }
>
>A feeling that it would be better to squash this to the other attribute patch,
>but I understand the reasons...

well... yeah. That part alone is now bigger than this with all the
simplifications and the previous code with dynamic attributes is simply
gone. I'm not comfortable adding others' signoff on a completely new
code.  It's based more on other drivers already in the tree than the
previous implementation for xe (or i915).

>
>Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

thanks
Lucas De Marchi

>
>>
>>  /**
>> --
>> 2.48.0
>>
