Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070B33998
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979578; cv=none; b=Aux6FqdCMzIJmJuvnXuGCu3e2OsS2L12cxCJLoCnuY43gLjekTi47568Sp4CFZJqhha6P+AccYJJYAabKQiL+FxFeZO7JYJwOkOeTqOCgDEJnaz8PPQF3ERBpAal98zozjiwT8ZGzfLz4FbuVDkkPYFSYxJmUHVs/6WLCLdeC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979578; c=relaxed/simple;
	bh=RNJCgjhpx/x7FDfWIo6sDM9uxuyza/JHpX8BhsArJRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFL1/ckIdsgDNsMw+/Z3JedPrJCQY4yCEer8wHN/ZcQVwRXmLBIp2zplxMvCo79T5gJFa4KBRKrKX1IuAUZCowaq/WXcINKjMamN8pJFp5CmH+1jmyib44It3zJ1FSFMacmRqDdwHKLuzzTtc5SpKl6fhCBWy7Qm1FMCBh1wIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxpqRpjZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxpqRpjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731979577; x=1763515577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RNJCgjhpx/x7FDfWIo6sDM9uxuyza/JHpX8BhsArJRg=;
  b=GxpqRpjZt9xbpxzX5hP55LE6I8hhGIHebdq2+03QV988Eqycq3rC0+8I
   TdEvwNoRAe5SkUMKNU+pqVitiC2XbIs2dqiKDbRuf9l6zbWNmp/vACrgv
   yPM/WplCQ7Nbtke5x2naUxF8tOFjrX69TZTk5KrcTeUeBxkCvcF2XlK1F
   A3lrF4D3NOHON2xdiNMPmUcfGlQsqEwfY90L+Px+eUYZGDPxmi6NTxpXb
   pudVIzEGBfjYqhcDIJN0GlN53rqe16saUFJtgkm9A0KZNCag4u24XJm8x
   s34ulXLLefI5A9U6DcbARMHsJrGZZv1/6sQQODFYrq3B2F4z4EDvN1uG4
   w==;
X-CSE-ConnectionGUID: ppzi0MH7R6So1XFgX3t9Jg==
X-CSE-MsgGUID: GvmS9H4NQYSVgsmmer4GXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="35632928"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="35632928"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 17:26:17 -0800
X-CSE-ConnectionGUID: 7udbaLWkQXqi75ZYVnBzFg==
X-CSE-MsgGUID: fQAhjYeuTJS7q1yOeeoBGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="88962071"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 17:26:16 -0800
Received: from [10.125.80.116] (kliang2-mobl1.ccr.corp.intel.com [10.125.80.116])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6BFF620B5703;
	Mon, 18 Nov 2024 17:26:15 -0800 (PST)
Message-ID: <bb5bbfe2-453f-4681-81bf-e3eb59e7a58d@linux.intel.com>
Date: Mon, 18 Nov 2024 20:26:13 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intel Arrowlake and hwcache events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Qiao Zhao <qzhao@redhat.com>, Michael Petlan <mpetlan@redhat.com>,
 alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, vmolnaro@redhat.com
References: <ea7b2c27-7512-f412-32c0-3a247fd930f9@redhat.com>
 <e37d7c6b-91c7-4fd7-831b-98f0dca5d46c@linux.intel.com>
 <CAATMXfkt28rjB03xFEcYzvhWsgtCe9Fp6eaFgDMEJq3c8_2hAQ@mail.gmail.com>
 <d3fffe92-8e64-423d-8ab7-075dfaa8a0dd@linux.intel.com>
 <Zzvg41ngE0oQeWx4@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zzvg41ngE0oQeWx4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-11-18 7:50 p.m., Namhyung Kim wrote:
> Hello,
> 
> On Fri, Nov 15, 2024 at 08:36:55AM -0500, Liang, Kan wrote:
>>
>>
>> On 2024-11-15 12:43 a.m., Qiao Zhao wrote:
>>> On Thu, Nov 14, 2024 at 10:33 PM Liang, Kan <kan.liang@linux.intel.com>
>>> wrote:
>>>
>>>>
>>>>
>>>> On 2024-11-14 4:54 a.m., Michael Petlan wrote:
>>>>> Hello!
>>>>>
>>>>> Qiao Zhao (CC'd) has found out that there are no hwcache events available
>>>>> on an Arrowlake system he was testing perf on.
>>>>
>>>> There are several variants for Arrowlake.
>>>> #define INTEL_ARROWLAKE_H               IFM(6, 0xC5)
>>>> #define INTEL_ARROWLAKE                 IFM(6, 0xC6)
>>>> #define INTEL_ARROWLAKE_U               IFM(6, 0xB5)
>>>>
>>>> The INTEL_ARROWLAKE should be supported in 6.10 and later.
>>>> The INTEL_ARROWLAKE_H was just merged and should be available in the
>>>> upcoming 6.13-rc.
>>>>
>>>> https://lore.kernel.org/lkml/20240808140210.1666783-1-dapeng1.mi@linux.intel.com/
>>>>
>>>> The patch to support INTEL_ARROWLAKE_U hasn't been posted yet.
>>>>
>>>> Which system were you testing?
>>>>
>>>
>>> Hi Kan, thank you for explaining this. I checked my testing history, and I
>>> happened to use Arrow Lake-U for testing.
>>
>> Thanks for the confirmation.
>> I will find a machine and post a patch to fix it ASAP.
>>
>> Thanks,
>> Kan
>>
>>> # lscpu
>>> Architecture:             x86_64
>>>   CPU op-mode(s):         32-bit, 64-bit
>>>   Address sizes:          46 bits physical, 48 bits virtual
>>>   Byte Order:             Little Endian
>>> CPU(s):                   14
>>>   On-line CPU(s) list:    0-13
>>> Vendor ID:                GenuineIntel
>>>   BIOS Vendor ID:         Intel(R) Corporation
>>>   Model name:             Genuine Intel(R) 0000
>>>     BIOS Model name:      Genuine Intel(R) 0000
>>>     CPU family:           6
>>>     Model:                197
> 
>   $ python -c 'print(hex(197))'
>   0xc5
> 
> Isn't it ArrowLake-H ?

Good catch. :)

For ARL-H, it should be ready with the upcoming 6.13-rc.

Thanks,
Kan
> 
> Thanks,
> Namhyung
> 
> 
>>>     Thread(s) per core:   1
>>>     Core(s) per socket:   14
>>>     Socket(s):            1
>>>     Stepping:             2
>>>
>>>
>>>>
>>>>> We have found out that it
>>>>> does not work even on 6.12.0-rc6+. Are there still drivers that haven't
>>>>> been merged yet?
>>>>>
>>>>> Happens that nothing matches in this loop:
>>>>
>>>> The HW cache events are usually model specific events. You cannot see it
>>>> unless there is specific support.
>>>>
>>>> You may also get more clues via dmesg | grep PMU.
>>>> If you see "generic architected perfmon", it means the specific support
>>>> isn't ready in the kernel.
>>>>
>>>
>>> Understand! Thank you Ken.
>>>
>>> - Qiao
>>>
>>>
>>>>
>>>> Thanks,
>>>> Kan
>>>>>
>>>>> int print_hwcache_events(const struct print_callbacks *print_cb, void
>>>> *print_state)
>>>>> [...]
>>>>> 305           for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++)
>>>> {
>>>>> 306           for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
>>>>> 307                   /* skip invalid cache type */
>>>>> 308                   if (!evsel__is_cache_op_valid(type, op))
>>>>> 309                                   continue;
>>>>> 310
>>>>> 311                   for (int res = 0; res <
>>>> PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
>>>>> 312                   char name[64];
>>>>> 313                           char alias_name[128];
>>>>> 314                           __u64 config;
>>>>> 315                           int ret;
>>>>> 316
>>>>> 317                           __evsel__hw_cache_type_op_res_name(type,
>>>> op, res,
>>>>> 318
>>>>                              name, sizeof(name));
>>>>> 319
>>>>> 320                           ret =
>>>> parse_events__decode_legacy_cache(name, pmu->type,
>>>>> 321
>>>>                              &config);
>>>>> 322                           if (ret ||
>>>> !is_event_supported(PERF_TYPE_HW_CACHE, config))
>>>>> 323                                   continue;
>>>>>
>>>>> Thanks,
>>>>> Michael
>>>>>
>>>>>
>>>>
>>>>
>>>
>>
> 

