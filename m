Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336BD201021
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246793; cv=none; b=LxXRD87VPAn/VTAghs/rXLp+S1Z2INoCm0jMt4PmsKPt5Xuvl1g76RMbCvvIH70C48Alan0z4LVcrjv8TKWHuoMZIYCy9djUb57b2gRBU/ElSgKqyaFaUUZt/YwE9THWLVW74U/DsVNgzoK0DXW1vk0erG5BHd8Gml6rzOrBngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246793; c=relaxed/simple;
	bh=OGd9ocCpdN1NGOtY2VTjU/vEoVVEaDKhTyJxQlCqRQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJnxz9Jq5o1x/FZbWYArvxL529SbM7kjb0weJgXeycvW3R/yrH0o5FP2MX+zTWj5r/TDQABcoCFpYRxsyoW0SEsi/7mHDj60jHHJ5rKiloL1ZcH7lDDO+47KY7RuT9XKOwRNAr2kgwYb4+hVFEJkS2S+XUtXtkCWmCiJW3z7gdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eI7gmlJe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eI7gmlJe"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4311c285bc9so19155515e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 03:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729246789; x=1729851589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08KcGJv3WQ/rsZu1dJadxRivbpgZgT+/gVvU/9ZsjLg=;
        b=eI7gmlJeHEwgGvIA2g0zpbtDA6Uys54X9csgWSooELFTXhXFNQ2UD+BdPJnMqp62dB
         nQaMZuBZHX7TIuQrOIyWw0uDuIlqWmLzXMmbmgPGgdSR1ldqB+xSjsD+LOWxPWB+BqkL
         QE70vqHIb5YZN+ZbFWnYsxv6uzKl4MJ6s3CAj64YAcKp+czZKNS4azHPUYV3V0inpAEB
         Zj1OoelhgEKeOoECiR92SEJBemQ2x90IXTSyhM/cPIAEnCZeLAezFYjv9jaHDM1Ck95w
         GxsaAEH60YN+km6ndzxAB5mj0ShTVhO8xEHEZP4cid/L/CK4nOBkWcbJ7+dAqY/5mjZ1
         0pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246789; x=1729851589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08KcGJv3WQ/rsZu1dJadxRivbpgZgT+/gVvU/9ZsjLg=;
        b=DR6Rr8SElw46PZ7O/QXHCAkhP1rQxgRvGLeoJY+j0DR1UXlGgtFBouMW/T0T+BOpCg
         PUpqE0zNkjMTjAyxow2bPy4poSHCItNFDhp0McgmQc2IZ1ZjPb59AG6DxChoX3qe4PG1
         NiBbZKj1OaF3lkCml8slr2DrRjQj4ZzxAb8BqhaNI4NcexUg23dCDzNF5D30B5netGwQ
         jbrsMFMZAl2eUp73VvVQmfuRS7Uxj3F4z870vykBn8b1KkmTv0u4EpwAYEFflI45WQYF
         MB4FfG8p706WQOFoRjLIc2y1o6cHmkvqojWZGv2AO+9icXDLOay2ztPQbJN4hHd/Kle9
         TTVA==
X-Gm-Message-State: AOJu0YwwVay85uPiomq3ubr8rI/iWjUOckmTQPQ2tR1TOh2dN4HRaIOe
	CsZLy2C3lhU3WGNifVIXHUlWaYtjEByYuGECahvh0V4iTGNM1MjpXWLvpqZbChI=
X-Google-Smtp-Source: AGHT+IHwSPVlAyG06j8oYoxj8Rfl+iY6xNUbcjcj8kDhM1xJn2SDsMdw1BZEhVpY9UHXflDwBy4zgA==
X-Received: by 2002:a05:600c:1988:b0:431:59b2:f0d1 with SMTP id 5b1f17b1804b1-4316163614bmr12258915e9.4.1729246789347;
        Fri, 18 Oct 2024 03:19:49 -0700 (PDT)
Received: from [192.168.68.135] ([145.224.66.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf11560csm1523780f8f.93.2024.10.18.03.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:19:48 -0700 (PDT)
Message-ID: <472dbd91-9efb-4a78-abdb-95d8b0e03c00@linaro.org>
Date: Fri, 18 Oct 2024 11:19:47 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid
 platform
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20241015145416.583690-1-james.clark@linaro.org>
 <20241015145416.583690-2-james.clark@linaro.org>
 <CAP-5=fW7aERe3KHtAoYX9UWsVWrhU95RcCgabgP+DNHi1whjsQ@mail.gmail.com>
 <d9a4bebe-dde1-438f-bcf7-70b7a5e21848@linaro.org>
 <CAP-5=fUi-Y408hZmPosfejOW=SkXZZTTvRm326fBz-9zrHk8ew@mail.gmail.com>
 <ZxGZfoH6pMZwANou@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZxGZfoH6pMZwANou@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/10/2024 00:10, Namhyung Kim wrote:
> On Wed, Oct 16, 2024 at 08:01:21AM -0700, Ian Rogers wrote:
>> On Wed, Oct 16, 2024 at 1:29 AM James Clark <james.clark@linaro.org> wrote:
>>>
>>> On 15/10/2024 4:14 pm, Ian Rogers wrote:
>>>> On Tue, Oct 15, 2024 at 7:54 AM James Clark <james.clark@linaro.org> wrote:
>>>>>
>>>>> Since the linked fixes: commit, specifying a CPU on hybrid platforms
>>>>> results in an error because Perf tries to open an extended type event
>>>>> on "any" CPU which isn't valid. Extended type events can only be opened
>>>>> on CPUs that match the type.
>>>>>
>>>>> Before (working):
>>>>>
>>>>>     $ perf record --cpu 1 -- true
>>>>>     [ perf record: Woken up 1 times to write data ]
>>>>>     [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
>>>>>
>>>>> After (not working):
>>>>>
>>>>>     $ perf record -C 1 -- true
>>>>>     WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
>>>>>     Error:
>>>>>     The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
>>>>>     /bin/dmesg | grep -i perf may provide additional information.
>>>>>
>>>>> (Ignore the warning message, that's expected and not particularly
>>>>> relevant to this issue).
>>>>>
>>>>> This is because perf_cpu_map__intersect() of the user specified CPU (1)
>>>>> and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
>>>>> CPU map. However for the purposes of opening an event, libperf converts
>>>>> empty CPU maps into an any CPU (-1) which the kernel rejects.
>>>>
>>>> Ugh. The cpumap API tries its best to confuse NULL == empty but empty
>>>> can give you dummy, dummy is also known as 'any' or -1, 'any' sounds a
>>>> lot like 'all' but sometimes 'all' is only online CPUs. I tried to
>>>> tidy up the naming a while ago, but there is still a mess.
>>>>
>>>
>>> I don't know if you think this is a good opportunity for me to have a go
>>> at finishing separating those? Or is it a dead end?
>>
>> So cpumap (and threadmap) underpin a lot of things, we also used to
>> routinely confuse CPU numbers with cpumap indices that are used to
>> densely index xyarrays with file descriptors, etc. My thought was that
>> we may end up doing a proper Rust libperf that can be under a more
>> permissive license like libbpf - currently libperf is a source of GPL
>> infection. The rewrite would be a good time to clear these things up.
>> I believe someone at RedHat has looked at doing a Rust libperf.
> 
> I really want to rewrite CPU/thread map related code but didn't have
> time to work on it. :(
> 
> It'd be great if we can rewrite it in Rust!  But current libperf API is
> pretty bad and it's not clearly separated from the tools code.  For
> example, accessing internals like evsel->core.xxx should be changed
> first.
> 
>>
>>>>> Fix it by deleting evsels with empty CPU maps in the specific case where
>>>>> user requested CPU maps are evaluated.
>>>>
>>>> If we delete evsels than the indices can be broken for certain things.
>>>> I'm guessing asan testing is clean but the large number of side data
>>>> structures that are indexed by things in another data structure makes
>>>> the whole code base brittle and I am nervous around this change.
>>>>
>>>>> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>
>>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>
>>> Ok if we're not completely opposed to doing it this way I will dig a bit
>>> more and double check everything is working.
>>
>> I think it is okay to do it this way (hence the reviewed-by tag) as
>> propagate maps should happen before the xyarrays are set up, it'd be
>> nice if these things were checked at runtime, or by the compiler...
> 
> Right, evsel index is used some places probably we need to update it
> too.
> 
> Thanks,
> Namhyung
> 

Ok I'll check for that.

James

