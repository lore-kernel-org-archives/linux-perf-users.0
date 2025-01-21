Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013841B808
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491930; cv=none; b=FyG4QttIK9FySh+W/YSUG+DxfCLxIVuaIlwzJa53mwpkvb2Md/QjkwnWTxgS8MqDAPjbq1yvZaADzfe7aAjykVhB0H/s/pwFgFZfxiD9TFS8tlpexF3AKk3yPCiNXwjYzldKFr+NtCf1V3sjQGtqHv8SVgTqW3+uE8cITJCBSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491930; c=relaxed/simple;
	bh=xKEXXJRqVpXkbeNTN2zb028HNX9NAJMVp96L2lMVeAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECsecUqB5WxJtRkp2AmMyDaToYi3kn9wTDBnRhqZaNSQJPGQUCeAgUAKLBlOY8RjIP2eS70zFUTF/9LBTCkO8QRsGLmyFQlCQwo638D+dQuF/NCtXE3U5H3q2rHgGhvHZQXBs4fXkHSiV+482jF4cznG9cY+PDQ1Q49BVhcHa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjCjhZPk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjCjhZPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737491925; x=1769027925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xKEXXJRqVpXkbeNTN2zb028HNX9NAJMVp96L2lMVeAU=;
  b=TjCjhZPk+PIdNxfQ7FwwCXzk4hLwvd/Jr6i4y03TY6ktkjDg2o4TYozJ
   5H0LA3mPAue1yGpG6B1FvfxnFrIxHxKDlHqQkEns0NmOWNo/BkICH9q7W
   eyEN0PZujqZLt1FW6nvB9AsbfzRIzGahSLRNo1LO6FxRALtL1HlyzBsjJ
   paGu+ky60P5+Kx7JVCKiDY1c5m7vScZIwOnp5+FPL7nh7HPMpsRChsRdH
   41Y1uEcoGMtRHNX/qMHqnJtFfeM5zzTKzbwBGKbVAIjQ0S8mCx0Sy3WgW
   NJoNj7kqIwDpPc/KH8uClJDAO+7U6DJ3tZtPtEbv28aV24esDGVILymk1
   w==;
X-CSE-ConnectionGUID: s+gkf1+3T9KRDjBXOV8liw==
X-CSE-MsgGUID: BqYKm3NnTWC+/m8HS6t8rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48918123"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="48918123"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:38:45 -0800
X-CSE-ConnectionGUID: eurRC1bdToikGbiFAYIkaQ==
X-CSE-MsgGUID: 7xz+FMZJQnqr0jmmf3Ilmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111538031"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.110.72])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:38:43 -0800
Date: Tue, 21 Jan 2025 14:38:39 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org, Vinay Belgaumkar <vinay.belgaumkar@intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v13 7/7] drm/xe/pmu: Add GT C6 events
Message-ID: <kihwh2cftvdw72ou2clk7tchrdl5u2bwzrp6n2cizuqyx7jbvf@oolswepiidsm>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
 <20250116230718.82460-8-lucas.demarchi@intel.com>
 <cbf55ca1-1692-4db4-9589-c07aec53cfe6@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cbf55ca1-1692-4db4-9589-c07aec53cfe6@intel.com>

On Tue, Jan 21, 2025 at 11:46:45AM +0530, Riana Tauro wrote:
>Hi Lucas
>
>On 1/17/2025 4:37 AM, Lucas De Marchi wrote:
>>From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>>
>>Provide a PMU interface for GT C6 residency counters. The implementation
>>is ported over from the i915 PMU code. Residency is provided in units of
>>ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).
>>
>>Sample usage and output:
>>
>>	$ perf list | grep gt-c6
>>	  xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU event]
>>
>>	$ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency*
>>	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency <==
>>	event=0x01
>>
>>	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency.unit <==
>>	ms
>>
>>	$ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
>>	#           time             counts unit events
>>	     1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
>>	     2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
>>
>>Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>---
>>
>>Besides the rebase, that changed a lot how the event was added,
>>here is a summary of other changes:
>>
>>- Use xe_pm_runtime_get_if_active() when reading
>>   xe_gt_idle_residency_msec() as there's not guarantee it will not be
>>   suspended anymore by the time it reads the counter
>>
>>- Drop sample[] from the pmu struct and only use the prev/counter from
>>   the perf_event struct. This avoids mixing the counter reported to 2
>>   separate clients.
>>
>>- Drop time ktime helpers and just use what's provided by
>>   include/linux/ktime.h
>>
>>  drivers/gpu/drm/xe/xe_pmu.c | 56 +++++++++++++++++++++++++++++++------
>>  1 file changed, 48 insertions(+), 8 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
>>index c2af82ec3f793..37df9d3cc110c 100644
>>--- a/drivers/gpu/drm/xe/xe_pmu.c
>>+++ b/drivers/gpu/drm/xe/xe_pmu.c
>>@@ -11,6 +11,7 @@
>>  #include "xe_device.h"
>>  #include "xe_force_wake.h"
>>  #include "xe_gt_clock.h"
>>+#include "xe_gt_idle.h"
>>  #include "xe_gt_printk.h"
>>  #include "xe_mmio.h"
>>  #include "xe_macros.h"
>>@@ -117,16 +118,50 @@ static int xe_pmu_event_init(struct perf_event *event)
>>  	return 0;
>>  }
>>-static u64 __xe_pmu_event_read(struct perf_event *event)
>>+static u64 read_gt_c6_residency(struct xe_pmu *pmu, struct xe_gt *gt, u64 prev)
>>  {
>>-	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
>>+	struct xe_device *xe = gt_to_xe(gt);
>>+	unsigned long flags;
>>+	ktime_t t0;
>>+	s64 delta;
>>+
>>+	if (xe_pm_runtime_get_if_active(xe)) {
>Seeing this lockdep warn on reading gt-c6-residency
>
>[ 5032.731663] =============================
>[ 5032.735699] [ BUG: Invalid wait context ]
>[ 5032.745260] -----------------------------
>[ 5032.749300] perf/3320 is trying to lock:
>[ 5032.753260] ffff888105f2c238 (&dev->power.lock){-.-.}-{3:3}, at: 
>pm_runtime_get_conditional+0x26/0xb0

ugh... thanks. Currently we are papering over that in drm-tip since
i915's pmu is completly broken.  I need to remember reverting that hack
from topic/core-for-CI to test things properly so xe doesn't have the
same fate.

here dev->power.lock is a spinlock, but ....


>[ 5032.762528] other info that might help us debug this:
>[ 5032.767613] context-{5:5}
>[ 5032.770262] 3 locks held by perf/3320:
>[ 5032.774045]  #0: ffff88846f632048 (&cpuctx_mutex){+.+.}-{4:4}, at: 
>perf_event_ctx_lock_nested+0xba/0x230
>[ 5032.783587]  #1: ffff8881037482c0 
>(&event->child_mutex){+.+.}-{4:4}, at: 
>perf_event_for_each_child+0x39/0x90
>[ 5032.793480]  #2: ffff88846f631fb8 (&cpuctx_lock){....}-{2:2}, at: 
>event_function+0x57/0x120

we are already holding a raw_spinlock.

The previous check for xe_pm_runtime_suspended() would get rid of the
warning since it doesn't take the dev->power.lock, but it would also be
racy. I think using the simplified interface Rodrigo proposed would be
the ok:  just take the runtime pm when creating the event
and releasing it when closing. It brings back the issues of releasing
an event after the device unbinds, but hopefully that will be fixed soon
by Peter's patches to perf_pmu_unregister().

Thanks for checking.

Lucas De Marchi

>
>
>[ 5032.829907] Call Trace:
>[ 5032.832384]  <TASK>
>[ 5032.834513]  dump_stack_lvl+0x81/0xc0
>[ 5032.838236]  dump_stack+0x10/0x20
>[ 5032.841586]  __lock_acquire+0xa5a/0x2550
>[ 5032.845548]  lock_acquire+0xc3/0x2f0
>[ 5032.849156]  ? pm_runtime_get_conditional+0x26/0xb0
>[ 5032.854066]  ? is_bpf_text_address+0x71/0x120
>[ 5032.858487]  _raw_spin_lock_irqsave+0x4b/0x70
>[ 5032.862892]  ? pm_runtime_get_conditional+0x26/0xb0
>[ 5032.867814]  pm_runtime_get_conditional+0x26/0xb0
>[ 5032.872570]  pm_runtime_get_if_active+0x13/0x20
>[ 5032.877141]  xe_pm_runtime_get_if_active+0x12/0x20 [xe]
>[ 5032.882545]  __xe_pmu_event_read+0x116/0x2a0 [xe]
>
>Thanks
>Riana
>
>>+		u64 val = xe_gt_idle_residency_msec(&gt->gtidle);
>>+
>>+		xe_pm_runtime_put(xe);
>>+
>>+		return val;
>>+	}
>>+
>>+	/*
>>+	 * Estimate the idle residency by looking at the time the device was
>>+	 * suspended: should be good enough as long as the sampling frequency is
>>+	 * 2x or more than the suspend frequency.
>>+	 */
>>+	raw_spin_lock_irqsave(&pmu->lock, flags);
>>+	t0 = pmu->suspend_timestamp[gt->info.id];
>>+	raw_spin_unlock_irqrestore(&pmu->lock, flags);
>>+
>>+	delta = ktime_ms_delta(ktime_get(), t0);
>>+
>>+	return prev + delta;
>>+}
>>+
>>+static u64 __xe_pmu_event_read(struct perf_event *event, u64 prev)
>>+{
>>+	struct xe_pmu *pmu = container_of(event->pmu, typeof(*pmu), base);
>>+	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
>>  	struct xe_gt *gt = event_to_gt(event);
>>-	u64 val = 0;
>>  	if (!gt)
>>-		return 0;
>>+		return prev;
>>+
>>+	switch (config_to_event_id(event->attr.config)) {
>>+	case XE_PMU_EVENT_GT_C6_RESIDENCY:
>>+		return read_gt_c6_residency(pmu, gt, prev);
>>+	}
>>-	return val;
>>+	return prev;
>>  }
>>  static void xe_pmu_event_update(struct perf_event *event)
>>@@ -136,10 +171,11 @@ static void xe_pmu_event_update(struct perf_event *event)
>>  	prev = local64_read(&hwc->prev_count);
>>  	do {
>>-		new = __xe_pmu_event_read(event);
>>+		new = __xe_pmu_event_read(event, prev);
>>  	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
>>-	local64_add(new - prev, &event->count);
>>+	if (new > prev)
>>+		local64_add(new - prev, &event->count);
>>  }
>>  static void xe_pmu_event_read(struct perf_event *event)
>>@@ -162,7 +198,7 @@ static void xe_pmu_enable(struct perf_event *event)
>>  	 * for all listeners. Even when the event was already enabled and has
>>  	 * an existing non-zero value.
>>  	 */
>>-	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event));
>>+	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event, 0));
>>  }
>>  static void xe_pmu_event_start(struct perf_event *event, int flags)
>>@@ -267,6 +303,10 @@ static const struct attribute_group pmu_events_attr_group = {
>>  static void set_supported_events(struct xe_pmu *pmu)
>>  {
>>+	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
>>+
>>+	if (!xe->info.skip_guc_pc)
>>+		pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
>>  }
>>  /**
>
