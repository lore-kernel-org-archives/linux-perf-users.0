Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C7253B58;
	Wed, 29 Jul 2026 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284856; cv=none; b=S4FadX0wwFrvECEOx+CbPo0SIsik1uYGUri41HoheD+VR57Slgi0cklx2GRm/KEUXeNvA1Nh1vqruRGMFAa+J5BwB667NlD6K6J8eH9KEfjgv5nmZRVRvIG3kY0EBaq9RJ08Y/MTi8Rr4teHRlLaWzqgKIItbHNAv68RwxdO/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284856; c=relaxed/simple;
	bh=YRSORLjnM2WwHuZhe4BS9ofIbsb31uGVmX4H2pg8E+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWvIVe133x1+hpeIGSvEp/jAenC7T5ihYaRQhOMSaAale394FTy+ZAnfvxst+68FVvu852M2LcyRheC/qtHOA8pezYY3UQaPeD4mElroJpOVdV9ZhcT2S/5up/fnhLkELJpZy8diKClp0JxnMMzYIFfNkXMLZtZPOB5FYJt2r7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f978zxyr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f978zxyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785284853; x=1816820853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YRSORLjnM2WwHuZhe4BS9ofIbsb31uGVmX4H2pg8E+8=;
  b=f978zxyrw/Y2fGI0XLQwQ8xrIlBPWVGBn6pKI4hukoR36Dp0gwh+MK41
   OJFBWMPVvL/9Ldbwldi8woL4vVwkAzKtgt8BOmZuiNC1qo0Ut3g6rIkuI
   tTSNt8QGZ/+0A8pv8YF81FqNEMb2VuMLp7DZTkFWUEGYnnCx3UVVnhtfi
   jNbkIBicFExBlWJNMUv8WmhPpSYEAQZ8cA8nE4Le+IrgTCtKKgS8PI1Is
   TvZKzcDWBVqJNbcPj9PnlA1h6zU7beLTNglzWOOhfa905Nco6feDLqqJX
   ZG1+4NbVMVivhIPQApE+CmiBGPc+DAxBo7I3hcgoRWUsyjJvVOL2FIKCf
   g==;
X-CSE-ConnectionGUID: nbt/Zz/UTpShU97MMBHM/A==
X-CSE-MsgGUID: DbBM9e1/QA+piGFWEmU50g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="108680490"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="108680490"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 17:27:31 -0700
X-CSE-ConnectionGUID: Nt1OMDs7Qp2tofte8Q437g==
X-CSE-MsgGUID: X3od+ZL5SJmUqV1sfdFBcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="283195056"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.111]) ([10.125.111.111])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 17:27:30 -0700
Message-ID: <b84dbd70-41af-46e2-8052-725dd687c52f@intel.com>
Date: Tue, 28 Jul 2026 17:27:29 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] perf/cxl: Drop bogus counter overflow fixup
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260728210551.2449093-1-dave.jiang@intel.com>
 <20260728210551.2449093-4-dave.jiang@intel.com>
 <20260728211411.47B2D1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260728211411.47B2D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/26 2:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Removing the overflow fixup entirely causes the CXL PMU driver to silently drop a full period of events on overflow when the new counter skid is greater than or equal to the previous skid.

Will fix in v2.

DJ

> --
> 
> --- Patch [3]: [PATCH 3/9] perf/cxl: Drop bogus counter overflow fixup ---
> commit 9b5168bc2e13d25590b1bb314d5cd8b527ba4f3e
> Author: Dave Jiang <dave.jiang@intel.com>
> 
> perf/cxl: Drop bogus counter overflow fixup
> 
> This commit removes the overflow fixup in __cxl_pmu_read() and folds it into
> cxl_pmu_read(). The stated rationale is that masked unsigned subtraction
> already produces the correct delta across a wrap, and that the previous
> fixup caused overcounting.
> 
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> 
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 3138514157cde..410c9162c8246 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
> [ ... ]
>> @@ -698,21 +698,15 @@ static void __cxl_pmu_read(struct perf_event *event, bool overflow)
>>  	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
>>  
>>  	/*
>> -	 * If we know an overflow occur then take that into account.
>> -	 * Note counter is not reset as that would lose events
>> +	 * The counter is not reset on overflow, and the unsigned subtraction
>> +	 * masked to the counter width already yields the correct delta across a
>> +	 * single wrap, so no overflow fixup is needed.
>>  	 */
>>  	delta = (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0);
>> -	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
>> -		delta += (1UL << info->counter_width);
> 
> [Severity: Medium]
> Does removing the overflow fixup entirely cause the driver to drop a full
> period of events when new_cnt >= prev_cnt?
> 
> While standard modulo math handles wraps when the counter is reprogrammed to
> a high value (ensuring new_cnt < prev_cnt), the CXL PMU does not reprogram
> counters on overflow. They start at 0, wrap, and freeze at a small skid
> value.
> 
> If a counter overflows, prev_cnt becomes skid1. On the next overflow,
> new_cnt becomes skid2. If skid2 >= skid1 (which has a roughly 50% chance),
> the masked subtraction only yields the tiny difference (skid2 - skid1),
> completely missing the wrapped period.
> 
> Would it be more correct to keep an overflow fixup specifically for the
> new_cnt >= prev_cnt case when an overflow occurs?
> 
>>  
>>  	local64_add(delta, &event->count);
>>  }
> 

