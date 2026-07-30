Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4043C7C4;
	Thu, 30 Jul 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426309; cv=none; b=rLDm7Qw6Xo5vnRTZJ4GntozRSIgDUboppG7pf++YuVY5Wd1ngNhBIDNKwxeSuFWYhCey8T2sX4483DIxYRFRl+BUTFB/sK/nnUg+WUssDrqeq6dd58DBfuGNgab7amUMOiWOu49ZMqB5Uk2TK5ho/HYAprF0FJuX9rPVEuIk0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426309; c=relaxed/simple;
	bh=K8jGPRIbU/4fEg3XbqlxfxTZioamTfWErR33qeGGRH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjAm/tZC0XVt6ZrXz0VkMiX74r2/Xu46YZU1mu4Btvm+NmE1LyuQ9EcclpKxynAR7PnelmDzqPhDZcnoITmBOUdHE56Fyf2jNnpsmSkXv9I4hDyQQbByEvQNI3EApsxGNE1tlB+g74ayuW1deiNNKHh9DXOMIJZL46UkeQJgUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHM36fzF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHM36fzF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785426308; x=1816962308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K8jGPRIbU/4fEg3XbqlxfxTZioamTfWErR33qeGGRH8=;
  b=lHM36fzF0nZsmmlS5i2mIjWjgJJRTB8vF6Ttl/wbjhqgVOU05YAhKDIu
   kaX5TjR4elB59Ai1M9ohm71nODK/ZrMm11uEfYobg9wr9xqcaj1pXnKx7
   aIySEDYAe8eSjAzPCr2bEOdxU4qIZVfN9u0XFzg8WM0WfujC7LrgYBXLM
   o0bS7gjtqKawQFW9yGDNmjA2NR9fErT69HYSSErFrbxtysvasGOfv7/It
   vWM5hH9p6/pDubFKxKQ5FlQkXorPFb03r3XrNnBrwu6QweDWp1BtBR6B8
   LusZgo0Q/KiKJrNR+/Zei7wA+Obq4+fUssBIxXVXv1LJb+6vblhyIo88N
   w==;
X-CSE-ConnectionGUID: ohI+xr5CTfaZgMHp8GCP3g==
X-CSE-MsgGUID: wcLmhXr4Tmm1IEN93RVNfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96406414"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="96406414"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 08:45:07 -0700
X-CSE-ConnectionGUID: mCB6mlH9QsqMdcDMK+jKMA==
X-CSE-MsgGUID: 8nrhI5iASLisKcN0KUbwrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260939655"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 08:45:06 -0700
Message-ID: <19d92f60-c0b3-4057-9521-0662121d6e17@intel.com>
Date: Thu, 30 Jul 2026 08:45:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] perf/cxl: Clear stale event fields before
 reprogramming a counter
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-3-dave.jiang@intel.com>
 <20260729232529.27d08ff4@jic23-huawei>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260729232529.27d08ff4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/26 3:25 PM, Jonathan Cameron wrote:
> On Wed, 29 Jul 2026 07:55:48 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> cxl_pmu_event_start() ORs the event group id, event mask, edge and invert
>> selections into a configurable counter's config register without clearing
>> those fields first, and cxl_pmu_event_stop() leaves them set. Reusing a
>> counter for another event therefore ORs the new selection onto the old,
>> counting the wrong events with stale edge/invert behaviour.
>>
>> Clear EVENT_GRP_ID_IDX, EVENTS, EDGE and INVERT before applying the new
>> values.
> 
> Maybe use FIELD_MODIFY() instead of mask then fill?

Will do

DJ

> 
> Otherwise LGTM.
> 
>>
>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/perf/cxl_pmu.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index e77c0650a7eb..3138514157cd 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -641,6 +641,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
>>  	}
>>  
>>  	cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
>> +	cfg &= ~(CXL_PMU_COUNTER_CFG_EDGE | CXL_PMU_COUNTER_CFG_INVERT);
>>  	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
>>  	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
>>  	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1);
>> @@ -651,6 +652,8 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
>>  
>>  	/* Fixed purpose counters have next two fields RO */
>>  	if (test_bit(hwc->idx, info->conf_counter_bm)) {
>> +		cfg &= ~(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK |
>> +			 CXL_PMU_COUNTER_CFG_EVENTS_MSK);
>>  		cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
>>  				  hwc->event_base);
>>  		cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,
> 

