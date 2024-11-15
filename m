Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F7F1CC898
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677819; cv=none; b=LmvPXtrDtOOhgEo/7pKnelFZFpe8buQ2pawQiQDZKpIxWSvZsEFAfwqkXxFPLCmaLviVnXlNwSoJOs3mKmpP9NF0OWOdGghQ3C9t+aTMzFyGOWisuRyGw2UHBspvEE6qJpT2G3AHFvyPhNx4TRdgsIhOIl5l9tW1BkcY5yQGF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677819; c=relaxed/simple;
	bh=fgtlRXZ2dy97wSJztOlQu9tvL1DKpnFjcdfdzMxJHVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uh67WIvMMdLQlSInsJCHz+U15SZs7qxCAGwnk9kj1ol5UlrB27VeMm2LPzMhO+iNa0Z2OrLUH7vSDT9nPE+m0P6BYo4Ay0quPTbIG59Vcqe4Igz6r/hMdKGVOMOGp2bDBATe1o84veQ/GdZ+uDU8j4yGJFvtNpTvyDqHHOuiwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeCjIsU8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeCjIsU8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731677818; x=1763213818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fgtlRXZ2dy97wSJztOlQu9tvL1DKpnFjcdfdzMxJHVo=;
  b=QeCjIsU8+fhsXhmIRm3orQM9ImMRuCh2rSe6EoWJjYR2i/ebn4woHQ1R
   1ZW4iRVh06oDefXi6+2ImXpdZnAcPWchLfTMdEubaUvhiywwB/FX/OnG3
   jXlwmr9KhujuqE4SUrggY4QaNZ7y3doStxlyl2py3fGFWoEFn3UDVnWPh
   gSrmmUDE1b7bsOMcrk4wh1KgNnOdk0LE70auLYSXYFnnhZ0b9UYYZx9x7
   +MQ9gJ59mfP5jWZ5+ftto9y1ZSDaeDZlVGYyvJDsWFUcipDL151WB6Zfk
   TxkRVt/U9spGc6wF0zX6x+m9+Owi9VLkjNp0v+geeZ6gfWvBbk6W1IQjG
   g==;
X-CSE-ConnectionGUID: yTuBLV7gSpyjbvsoLrtUFw==
X-CSE-MsgGUID: 1E/NgGswROy1Jk/tuULNKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="49211682"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="49211682"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 05:36:58 -0800
X-CSE-ConnectionGUID: jnhTbF2MSwqwAiwelDFEQA==
X-CSE-MsgGUID: Q4AoZWP3S+m8Ij/s9rfhAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="111856651"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 05:36:57 -0800
Received: from [10.125.32.174] (kliang2-mobl1.ccr.corp.intel.com [10.125.32.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2F3D620B5703;
	Fri, 15 Nov 2024 05:36:56 -0800 (PST)
Message-ID: <d3fffe92-8e64-423d-8ab7-075dfaa8a0dd@linux.intel.com>
Date: Fri, 15 Nov 2024 08:36:55 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intel Arrowlake and hwcache events
To: Qiao Zhao <qzhao@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>, alexander.shishkin@linux.intel.com,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 vmolnaro@redhat.com
References: <ea7b2c27-7512-f412-32c0-3a247fd930f9@redhat.com>
 <e37d7c6b-91c7-4fd7-831b-98f0dca5d46c@linux.intel.com>
 <CAATMXfkt28rjB03xFEcYzvhWsgtCe9Fp6eaFgDMEJq3c8_2hAQ@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAATMXfkt28rjB03xFEcYzvhWsgtCe9Fp6eaFgDMEJq3c8_2hAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-11-15 12:43 a.m., Qiao Zhao wrote:
> On Thu, Nov 14, 2024 at 10:33 PM Liang, Kan <kan.liang@linux.intel.com>
> wrote:
> 
>>
>>
>> On 2024-11-14 4:54 a.m., Michael Petlan wrote:
>>> Hello!
>>>
>>> Qiao Zhao (CC'd) has found out that there are no hwcache events available
>>> on an Arrowlake system he was testing perf on.
>>
>> There are several variants for Arrowlake.
>> #define INTEL_ARROWLAKE_H               IFM(6, 0xC5)
>> #define INTEL_ARROWLAKE                 IFM(6, 0xC6)
>> #define INTEL_ARROWLAKE_U               IFM(6, 0xB5)
>>
>> The INTEL_ARROWLAKE should be supported in 6.10 and later.
>> The INTEL_ARROWLAKE_H was just merged and should be available in the
>> upcoming 6.13-rc.
>>
>> https://lore.kernel.org/lkml/20240808140210.1666783-1-dapeng1.mi@linux.intel.com/
>>
>> The patch to support INTEL_ARROWLAKE_U hasn't been posted yet.
>>
>> Which system were you testing?
>>
> 
> Hi Kan, thank you for explaining this. I checked my testing history, and I
> happened to use Arrow Lake-U for testing.

Thanks for the confirmation.
I will find a machine and post a patch to fix it ASAP.

Thanks,
Kan

> # lscpu
> Architecture:             x86_64
>   CPU op-mode(s):         32-bit, 64-bit
>   Address sizes:          46 bits physical, 48 bits virtual
>   Byte Order:             Little Endian
> CPU(s):                   14
>   On-line CPU(s) list:    0-13
> Vendor ID:                GenuineIntel
>   BIOS Vendor ID:         Intel(R) Corporation
>   Model name:             Genuine Intel(R) 0000
>     BIOS Model name:      Genuine Intel(R) 0000
>     CPU family:           6
>     Model:                197
>     Thread(s) per core:   1
>     Core(s) per socket:   14
>     Socket(s):            1
>     Stepping:             2
> 
> 
>>
>>> We have found out that it
>>> does not work even on 6.12.0-rc6+. Are there still drivers that haven't
>>> been merged yet?
>>>
>>> Happens that nothing matches in this loop:
>>
>> The HW cache events are usually model specific events. You cannot see it
>> unless there is specific support.
>>
>> You may also get more clues via dmesg | grep PMU.
>> If you see "generic architected perfmon", it means the specific support
>> isn't ready in the kernel.
>>
> 
> Understand! Thank you Ken.
> 
> - Qiao
> 
> 
>>
>> Thanks,
>> Kan
>>>
>>> int print_hwcache_events(const struct print_callbacks *print_cb, void
>> *print_state)
>>> [...]
>>> 305           for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++)
>> {
>>> 306           for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
>>> 307                   /* skip invalid cache type */
>>> 308                   if (!evsel__is_cache_op_valid(type, op))
>>> 309                                   continue;
>>> 310
>>> 311                   for (int res = 0; res <
>> PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
>>> 312                   char name[64];
>>> 313                           char alias_name[128];
>>> 314                           __u64 config;
>>> 315                           int ret;
>>> 316
>>> 317                           __evsel__hw_cache_type_op_res_name(type,
>> op, res,
>>> 318
>>                              name, sizeof(name));
>>> 319
>>> 320                           ret =
>> parse_events__decode_legacy_cache(name, pmu->type,
>>> 321
>>                              &config);
>>> 322                           if (ret ||
>> !is_event_supported(PERF_TYPE_HW_CACHE, config))
>>> 323                                   continue;
>>>
>>> Thanks,
>>> Michael
>>>
>>>
>>
>>
> 

