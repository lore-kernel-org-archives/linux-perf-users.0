Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B49340283
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446265; cv=none; b=gXO1yt8v+tryzTWUgaf3UDtXLshNgPj3ilPS020GZ7fmpSYdjBQIMd9NDw6X9bfAhQK8HZl/ug5fU5V801hd2/GHXM1QigBIrmqcPX4OTUl4C8Ox1arkf5PWRHAE1k3Rd0OIHUfxv4yl+P9SF0Q38iMHQMKhIKejLnVbYawdkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446265; c=relaxed/simple;
	bh=bv+Z3QFv3pHBYsV+l2AEQGKyO/PlBsIS2nYdIqT7+rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afn90H2C9ihOrde9OGgbw2PWc+SiK6A7SXXbpydS3vJKuOn0cnIoTp+TXX9ZhmkukdrlTLGXB8F1FTFi/iki0BmAFLc3hRhApLCeBQwmwvhYjth33XArNP48TFbu+G5uqF0dKSyzFro/Iq1yGcog008Jn68KFpkliql3HV7yS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIfPEf48; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIfPEf48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777446262; x=1808982262;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bv+Z3QFv3pHBYsV+l2AEQGKyO/PlBsIS2nYdIqT7+rw=;
  b=iIfPEf48R4KBz+f/sWTdLzOiXqXaejhVXM4GZQByl0MLBnsWZQy8Hhwp
   Qu8/zay5FIIn/2nFcRzJoq+3dPGStXA5+FSj67bkUj8RM4zK8LQUG2ycx
   wBq5sYfuvCJ98Y6vBVad3+BGEBqRbRD+5gFV2V/BDx9QQfjV4BUoPXV7j
   AkDT/KSOimRIG1nBQOHXLkjZ6pTW80fDo0HtGnIhvHm2pKZQjLo1mOvEJ
   j90pz0jiiF8rJE4+gcTWSUwRM+h9OYUsTpN7iwjcvIrnvLa8Yx/SpUcDF
   elfYUClKZQA4I/ccxb67C6FpTBA/KG6sUt5NuNPR0JwTo8NPfGl9fKxJ2
   A==;
X-CSE-ConnectionGUID: 0yMQpk04RaGDf7zm4xf3RA==
X-CSE-MsgGUID: tKlAksxXQNOGl9x+0VtoDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78245548"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78245548"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:04:21 -0700
X-CSE-ConnectionGUID: 6/qvTXIKR+ypo/ZxFnVnlw==
X-CSE-MsgGUID: S8cYbLv9Rzuk1cpz0oOeYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="231046395"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 00:04:20 -0700
Message-ID: <fdb06f4b-d6d4-4bbe-9861-e8aa52e7b053@linux.intel.com>
Date: Wed, 29 Apr 2026 15:04:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 24/24] perf/x86/intel: Add sanity check for PEBS
 fragment size
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260324004118.3772171-25-dapeng1.mi@linux.intel.com>
 <20260425035339.8032DC2BCB2@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260425035339.8032DC2BCB2@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/25/2026 11:53 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):
> - [Critical] Skipping setup_sample() for corrupted records does not discard the record, but instead leaks stale register states to userspace.
> - [High] The global `corrupted` flag falsely invalidates valid pending samples for unrelated PMU counters.
> - [Medium] The corruption checks fail to flag records with out-of-bounds final fragments or zero-sized fragments as corrupted.
> --
>
> commit ed1fa3eb36814252a303cf5b2e6f3f4bfd3ed81e
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Add sanity check for PEBS fragment size
>
> This commit adds a sanity check to prevent potential infinite loops
> caused by corrupted PEBS fragment sizes. It intends to discard
> corrupted PEBS records and all subsequent records.
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 19f96d9ae04b5..e7bc6a37a3575 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2951,13 +2951,17 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
>>  			    struct pt_regs *iregs,
>>  			    struct pt_regs *regs,
>>  			    struct perf_sample_data *data,
>> -			    void *at,
>> -			    int count,
>> +			    void *at, int count, bool corrupted,
>>  			    setup_fn setup_sample)
>>  {
>>  	struct hw_perf_event *hwc = &event->hw;
>>  
>> -	setup_sample(event, iregs, at, data, regs);
>> +	/* Skip parsing corrupted PEBS record. */
>> +	if (corrupted)
>> +		perf_sample_data_init(data, 0, event->hw.last_period);
>> +	else
>> +		setup_sample(event, iregs, at, data, regs);
>> +
> The commit message states that corrupted PEBS records will be discarded, but
> skipping setup_sample() still allows the execution to continue to
> perf_event_output() or perf_event_overflow() located further down in this
> function.
>
> Since regs points to a per-CPU x86_pebs_regs, and it is not updated with
> the current hardware context when setup_sample() is skipped, does this emit
> stale register states from previously processed PEBS records into the
> userspace ring buffer?

Yes, need to call x86_pmu_clear_perf_regs() for the corrupted case.


>
> [ ... ]
>
>> @@ -3391,6 +3399,10 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
>>  			if (!header->size)
>>  				break;
> If a fragment has header->size == 0, the loop breaks and reaches done: with
> corrupted == false.
>
> Does this miss flagging malformed zero-sized fragments as corrupted, allowing
> them to be parsed and potentially causing out-of-bounds reads?

No,  if the size is 0, then setup_arch_pebs_sample_data() would break the
loop and there should be no out-of-bound reads.


>
>>  			at += header->size;
>> +			if (WARN_ON_ONCE(at >= top)) {
>> +				corrupted = true;
>> +				goto done;
>> +			}
>>  			header = at;
>>  		}
>>  
>>  		/* Skip last fragment or the single record */
>>  		at += header->size;
>>  	}
> If the final fragment of a record (where arch_pebs_record_continued()
> is false) has an out-of-bounds size, at += header->size; is executed
> and the loop terminates naturally with corrupted == false.
>
> Could this allow out-of-bounds reads past ds->pebs_index when the unflagged
> malformed record is parsed by setup_arch_pebs_sample_data()?

Yes, it's a bug. Need to set corrupted to true if the final fragment is
corrupted.


>
>> +done:
>>  	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
>> -					    counts, last,
>> +					    counts, last, corrupted,
>>  					    setup_arch_pebs_sample_data);
> Here a single corrupted flag is passed for the entire PEBS buffer drain
> operation.
>
> If one PMU counter encounters a corrupted record and jumps to done:, this
> global flag is applied to the last events of all active counters.
>
> Does this falsely invalidate perfectly valid pending samples for unrelated
> PMU counters, and subject them to the stale register leak described above?

If a record or fragment is corrupted, all fragments and records after it
have no way to be accessed and further passed. If we clear the stale
register info, there would be no leak issue.

Thanks.


>
