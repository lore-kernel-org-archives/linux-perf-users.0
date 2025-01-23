Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C438C07
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644365; cv=none; b=khknAl1yTVjj45pIeZJvJ/aAFrmLzWKYhmD/vtBYSuW9VOzSKWYROUPQkEKqPtE5qXcrlnwo53sG/aei3MvM4uyF8PpRyJQ+GZOCqr1++Rp6J5cFV4j8b6tjaZXFSZvcv5ogpOb9rNaadnL/uBFDfHDKFG0hafuqITQbZLKp294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644365; c=relaxed/simple;
	bh=FBzYMtSjqfM7p/d6XIe2NK6Oa9E03Khm9cQkOjfvEHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDPqaW/SG4ZIFmACwjOV1mB/mkT2FHvRu7WZ/NVYa7XWAD7bLVaiu735WmWqdGq91nvfk5m0aUWWusAXjIDOyddiaIIW2XlzLkcKxCImK2u3I4vf7lDBMbXeXPCMlJ734/sBQHOnhk05SXAPtYGM/JW9ELCy8qQllSh3oIp9WCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbci7Zhj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbci7Zhj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737644363; x=1769180363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FBzYMtSjqfM7p/d6XIe2NK6Oa9E03Khm9cQkOjfvEHY=;
  b=nbci7Zhj+G1Kmfb85Bfj+KvrVFKPveRtk+XTy9g09NxuI0EkzYkne/yH
   jqO7XADJ94N9p+M/d8ms5E1fTagcaFvrDmeJGARKyox0LJQRAo5nDRz5z
   Pv3EgtJx+rcxo3BkrMCT1SPbBqMje59bTXq65veJeH5kn12Z66bNyZSm7
   8vodojx52DjQNGlCf2joymsS+/QeNPk73yGw/snPqMneWlpUJBhOPp4km
   gIQoi9u+tn386719wlZdYCqrEUWVJQWuKpV5Nd4rDzSOJJxQt3dFfxYtW
   ehJPDoWJ5ZV9zHIdq8GCdmGzkRrb622d89sCwaCHrffH5dK3EhIivSZxs
   w==;
X-CSE-ConnectionGUID: gcP4OyRxSJy9KWqTRDjhkg==
X-CSE-MsgGUID: LoFHXjOKTW++fsq6FlGLMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="49134578"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="49134578"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:59:22 -0800
X-CSE-ConnectionGUID: 5bnGgniCTmWT6lxW0Ppa6Q==
X-CSE-MsgGUID: 0pDk5M6uQ+KlhWftR0hEmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107294353"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.110.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 06:59:21 -0800
Date: Thu, 23 Jan 2025 08:59:16 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, 
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>, Riana Tauro <riana.tauro@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v15 3/6] drm/xe/pmu: Extract xe_pmu_event_update()
Message-ID: <djk45hhruejm5yzsvyn7jfmby6holhyhfk74xnbkxmot2yqmwf@l2kz7pjdxvvp>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
 <20250123041923.1892837-4-lucas.demarchi@intel.com>
 <Z5IX2Rixtx6csrKO@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z5IX2Rixtx6csrKO@intel.com>

On Thu, Jan 23, 2025 at 05:20:09AM -0500, Rodrigo Vivi wrote:
>On Wed, Jan 22, 2025 at 08:19:20PM -0800, Lucas De Marchi wrote:
>> Like other pmu drivers, keep the update separate from the read so it can
>> be called from other methods (like stop()) without side effects.
>>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>  drivers/gpu/drm/xe/xe_pmu.c | 24 +++++++++++++++---------
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
>> index df93ba96bdc1e..33598272db6aa 100644
>> --- a/drivers/gpu/drm/xe/xe_pmu.c
>> +++ b/drivers/gpu/drm/xe/xe_pmu.c
>> @@ -117,18 +117,11 @@ static u64 __xe_pmu_event_read(struct perf_event *event)
>>  	return val;
>>  }
>>
>> -static void xe_pmu_event_read(struct perf_event *event)
>> +static void xe_pmu_event_update(struct perf_event *event)
>>  {
>> -	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
>>  	struct hw_perf_event *hwc = &event->hw;
>> -	struct xe_pmu *pmu = &xe->pmu;
>>  	u64 prev, new;
>>
>> -	if (!pmu->registered) {
>> -		event->hw.state = PERF_HES_STOPPED;
>> -		return;
>> -	}
>> -
>>  	prev = local64_read(&hwc->prev_count);
>>  	do {
>>  		new = __xe_pmu_event_read(event);
>
>I really have the feeling that the names are inverted, and that this
>function should be the one actually called read, but I double
>checked and everybody else is doing the same, so I guess I just need
>more coffee...

yeah... that's because "read" here is used in 2 different contexts:

1) as implementation of the perf_pmu functor. We are implementing the
.event_read() so we call the function xe_pmu_event_read()
2) as the verb implying we are reading the HW since it's commonly used
in xe, so we call the function __xe_pmu_event_read()

however the perf_pmu implies that the HW values are updated not only in
the .read() call, but also in e.g. in the .stop() call. So we have

	xe_pmu_event_stop
	  xe_pmu_event_update
	    __xe_pmu_event_read

and

	xe_pmu_event_read
	  xe_pmu_event_update
	    __xe_pmu_event_read

__xe_pmu_event_read could be called event_hw_readout() or something like
that if it helps clearing up the confusion. Thoughts?

>
>Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

let me know what you think about the rename above and I will keep your
r-b.

thanks
Lucas De Marchi

>
>> @@ -137,6 +130,19 @@ static void xe_pmu_event_read(struct perf_event *event)
>>  	local64_add(new - prev, &event->count);
>>  }
>>
>> +static void xe_pmu_event_read(struct perf_event *event)
>> +{
>> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
>> +	struct xe_pmu *pmu = &xe->pmu;
>> +
>> +	if (!pmu->registered) {
>> +		event->hw.state = PERF_HES_STOPPED;
>> +		return;
>> +	}
>> +
>> +	xe_pmu_event_update(event);
>> +}
>> +
>>  static void xe_pmu_enable(struct perf_event *event)
>>  {
>>  	/*
>> @@ -166,7 +172,7 @@ static void xe_pmu_event_stop(struct perf_event *event, int flags)
>>
>>  	if (pmu->registered)
>>  		if (flags & PERF_EF_UPDATE)
>> -			xe_pmu_event_read(event);
>> +			xe_pmu_event_update(event);
>>
>>  	event->hw.state = PERF_HES_STOPPED;
>>  }
>> --
>> 2.48.0
>>
