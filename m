Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18E285CB4;
	Tue, 11 Nov 2025 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891405; cv=none; b=iu2Ol+aPrJTzULRFHCCukg6+9cxAdUJI+rga3U5vpDSX3a7bgYHHbWb4Gejt5XjkcZcg3H35fhxf8Ph8EtJX9ArX5GfNHG2bYPbu9S6uwAglZvR2asiT72gm5ly9jNZZW2WIMnwmYPLBMB9W2Y1w2k5crKMBSWHSw/xv3gqLRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891405; c=relaxed/simple;
	bh=o4taJyu2TFRMmZekMAPl8Pnr+JvTkgfSawFd4hOXlws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=movT5qZyjTJ3xsPX754l2eBKmtlPQ9a/4UZDrnEGSdgKAX1W2c6kJ5LkVuc/JgWaCl6XW/CsVSzcSbCT4Q5rI6wPPwJ3D+18/78wdJTv8RpNHXt+Nnr0MiIF0ifXjCuOdnafvwoDqGPODhvkwNkefgX2ZjcwxdhZilYAn2yoqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEN58QmH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEN58QmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762891404; x=1794427404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o4taJyu2TFRMmZekMAPl8Pnr+JvTkgfSawFd4hOXlws=;
  b=BEN58QmHU5S3qT+XqMzvUP3oYDIhNOAubQ7VLkE3WjXHptouD5yenFHg
   4LFa/ATfBhDcHJI+q7o4pvvSPXpAbT0X2iTouIuOsOpxPCWDzF+M6giYc
   9WN3JJvLIzyJTKiCxBs0uPUpsCREYa2k7keahL69YLfyGSIesk3bzed5h
   W9LLGw9Uomc/IGWDA/n4dCIJsjBhqeY+mgNgrbcrCHHxeFxL9ythN5wot
   zf73mUvydB10oT9+af3zgtKUXAWHNFIKk7NCJy4LEpNlw6G1PP+En4unW
   52CWth/hXKMFtM41uB3JscwvOsQjraS2+oRRt6gEDHaCggCjIuHFpRa4l
   Q==;
X-CSE-ConnectionGUID: M+ueF5zwQG+VDDt6LNsSjw==
X-CSE-MsgGUID: dml7qfPJTgO8pwlIMQ2jiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76305890"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="76305890"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 12:03:23 -0800
X-CSE-ConnectionGUID: oGrHzvJZS4q64oazY/b6ig==
X-CSE-MsgGUID: Eb/XuKOGTtWSp4zrRxf6nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="219769514"
Received: from aksajnan-mobl1.amr.corp.intel.com (HELO [10.125.50.87]) ([10.125.50.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 12:03:22 -0800
Message-ID: <7ea7c72d-7570-4eca-8a8a-d8f93363691e@intel.com>
Date: Tue, 11 Nov 2025 12:03:22 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix missing feature check for inherit +
 SAMPLE_READ
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20251111075944.2328021-1-namhyung@kernel.org>
 <ac137eff-674c-4fa4-b870-80878af032a0@intel.com>
 <aRORSxu22OSf-v0X@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aRORSxu22OSf-v0X@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/11/2025 11:40 AM, Namhyung Kim wrote:
> On Tue, Nov 11, 2025 at 11:13:20AM -0800, Chen, Zide wrote:
>>
>>
>> On 11/10/2025 11:59 PM, Namhyung Kim wrote:
>>> It should also have PERF_SAMPLE_TID to enable inherit and PERF_SAMPLE_READ
>>> on recent kernels.  Not having _TID makes the feature check wrongly detect
>>> the inherit and _READ support.
>>>
>>> It was reported that the following command failed due to the error in
>>> the missing feature check on Intel SPR machines.
>>>
>>>   $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
>>>   Error:
>>>   Failure to open event 'cpu/mem-loads,ldlat=3/PS' on PMU 'cpu' which will be removed.
>>>   Invalid event (cpu/mem-loads,ldlat=3/PS) in per-thread mode, enable system wide with '-a'.
>>>
>>> Fixes: 3b193a57baf15c468 ("perf tools: Detect missing kernel features properly")
>>> Reported-by: "Chen, Zide" <zide.chen@intel.com>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>  tools/perf/util/evsel.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index 67a898cda86ab559..989c56d4a23f74f4 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -2474,7 +2474,7 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
>>>  	/* Please add new feature detection here. */
>>>  
>>>  	attr.inherit = true;
>>> -	attr.sample_type = PERF_SAMPLE_READ;
>>> +	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;
>>
>>
>> Seems this could have some unintended side effects. For example,
>> consider a :ppp event with PERF_SAMPLE_READ and inherit attributes
>> running on a system where the maximum precise_ip is 2:
>>
>> - It fails to open the event on the first attempt;
>> - It goes through the inherit_sample_read detection and fails again
>> after removing inherit;
> 
> This is not what we want.  The kernel supports inherit + SAMPLE_READ
> so it should not remove the inherit bit.
> 
> 
>> - Finally, it succeeds after falling back to precision 2 — but the
>> inherit attribute has been unexpectedly removed.
> 
> So it'll fallback to precision 2 without removing inherit.
> 
>>
>> I may have missed something, but I don’t quite understand why commit
>> 3b193a57baf15 ("perf tools: Detect missing kernel features properly")
>> performs the check on a dummy evsel instead of the original one. In this
>> way, it might incorrectly fall back an attribute that doesn’t actually help.
> 
> Because different platforms have different limitations on hardware
> events.  You cannot simply use current event for kernel feature check
> since it can result in wrong decisions due to the limitation.  So we
> picked the software event to avoid the hardware characteristics and to
> focus on kernel features.
> 
>>
>> This means evsel__detect_missing_features() could theoretically roll
>> back a feature that might not actually work. Given that it cannot
>> restore the original evsel state after a failed attempt, side effects
>> may occur.
> 
> The purpose is to turn off the non-supported features only and try with
> other settings like precise_ip and exclude_kernels and so on.

OK, thanks!
> Thanks,
> Namhyung
> 

