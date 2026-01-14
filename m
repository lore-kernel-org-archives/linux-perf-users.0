Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657039B493
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768397630; cv=none; b=Gd0dWEGcnXmBNq6ruUHkmlvoGor/xlfk0cdeEnON2OsJ7eXshmYJe7v7z2RNTpJfPUPxUlL7KBzJzMPekN6zPyxF6WDA+GBVcp+qnExBSz54PmkDtY4oh4AlncweTU42URCGT0Jrs04VmtOvu33jeHz9nrh8D28pt6GpnmFMqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768397630; c=relaxed/simple;
	bh=1MUjY8WlUV5MnHXNp8CRDgcURcH5JZrroyN9ts53Sfc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AkW/kfppn0Q1eG/fMVFKI/BZmuNskuPv69ap2URn/S3g0tlrQcbreLOjQGQO5XL97bj/QreERs79F1Xv17cNpkiqKFFXUhU5QY3pGmLGu7xlXenVpybTFLjO3iPfooHeoU41+fwk0yENmBnJW00Qx+30/Zlzk/4pL3UrJv8hg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vnp58aUw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vnp58aUw"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc3056afso5088143f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 05:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768397626; x=1769002426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WhwfNazPWHuLWawIgxRJ1ZBzLc6u01DE788YteykMdA=;
        b=Vnp58aUwtjCyg9j6oln5OuiCD8cWPdkkwjCnMiCt3pil2ylqSG3p1FbaDSjqqaHjaL
         hbf3B1iLH4MroocyF1wPrxt6mlA4F684zmmA4vqlVhCozHQLYCyWSK6MbaCzx4mh7kuT
         8HqgRrdAxeNWX25KYRJPcUBX2Upce+i60BZWVAVRBeGprT1fftH0OzQwFP6Xs5Z8Xm/T
         z+ppHQrZUPeQHDfVU3OAVa6YaqGjQruvbsKG8GHITpp5EUO7mIyy704ETZI5c5wAD36B
         eKxTHC8eUuNnkDE7pa62wtQIIGnq2BZqiDn+OvBc2mjpcQmGxIU4utXilDjFlPZRM1zw
         rNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768397626; x=1769002426;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhwfNazPWHuLWawIgxRJ1ZBzLc6u01DE788YteykMdA=;
        b=pHL6vYwzV6zygpodCkUxDuv7lI3N4oJWJE4mUpGUJE8Y/6tQY08g3SKa932jmAfGrC
         c7fh/BXi/QyoVizXq9HT9y36KHJiDIRuftzCp//p8GawTSTNbTgGVPQgcM4NZMJ0r3GV
         xVAhXeWkspD41R+j1FiymBUTSALlIf8i9Hn3rgd6PDKonTN9unwG7AAqDhdDlyux9kBr
         95hgKrMMpQT8snFI5bmdHlWGNPmmTQIgRv8CFSFKlNEdpKIeMScsFHGyxLZ2UboF4yla
         6mXA+/aSolcqpcpyftvUsbEVoplBFWR8AI8WyQirQo70hrlqqO1P8azo/2Z517/6e4Bi
         lf4w==
X-Forwarded-Encrypted: i=1; AJvYcCU+A7mMxgTPV2MF5sgINpnwxj5dlTowWgiti0eGQP4c7DQHR8xU6v0N09gJLd4r2DPPiygtNcY54j6hkK5kIalZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzng4XIV9hWjk7K3YST8tID+9TjqgCkM4bowOVGpvVX5AU2Mpog
	zv3B9LbUgQzF8EzSCSOyS2Enw8alyg+HUoa7ZB7urUm4KSRvl78OXWSRJ91PxByH5Yw=
X-Gm-Gg: AY/fxX6tQ9DTJNu5g0prAkScuQKWOx/VdizbbJNcaAIdLhuNA/fiozoCmEz+xeKiJDL
	FdIpmYfZXq6hsWjpSj3NxPeSMjJkoHAwMOTA1KjtPz7azL3R+sIGuiZbl9nwIg9D+2Xn16hRuSA
	3gWsQ9j2Wb+xcFwpftp91yn3U8PPhyTGDxlO1bRNRZYrN+VWH/Y0pGvc1xvMalTHZHQXQCpdjuf
	Qpsae+665995zKsNvGV+OPXxvo8HUauZL8ETISY7QZlNjPKUeS2eNEAjmp793Zy8brpNRFwo4e+
	bRD9Euw2YHCHPJhQJjxuMPWmFaVQmEU9fBVRBfjobIIp80yPXJkQhAOo8lUSLKgFgPmr3HGFYAa
	7aGqUGRgGNRbOrSWakm/MXghFhvLeOdQB87drwm9gfLx/w+RQJVAcNDF+3PCkArgOmv2Iv014u3
	AJ+a38E6BDKq2juF3GBBC6ayI876c=
X-Received: by 2002:a05:6000:2c03:b0:430:f7c9:94c3 with SMTP id ffacd0b85a97d-4342c5011f7mr3399526f8f.25.1768397626345;
        Wed, 14 Jan 2026 05:33:46 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacc5sm49990183f8f.5.2026.01.14.05.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 05:33:45 -0800 (PST)
Message-ID: <3905ee5b-79fe-408c-b776-125c51ac7824@linaro.org>
Date: Wed, 14 Jan 2026 13:33:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] perf evsel: Refactor
 evsel__set_config_if_unset() arguments
From: James Clark <james.clark@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
 <20251222-james-perf-config-bits-v4-2-0608438186fc@linaro.org>
 <aWbDg0kmo-isxkz2@x1> <4eda1bd6-ec36-4d0b-85de-ef0bd190e5e7@linaro.org>
Content-Language: en-US
In-Reply-To: <4eda1bd6-ec36-4d0b-85de-ef0bd190e5e7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/01/2026 12:14 pm, James Clark wrote:
> 
> 
> On 13/01/2026 10:13 pm, Arnaldo Carvalho de Melo wrote:
>> On Mon, Dec 22, 2025 at 03:14:27PM +0000, James Clark wrote:
>>> Make the evsel argument first to match the other evsel__* functions
>>> and remove the redundant pmu argument, which can be accessed via evsel.
>>
>> I haven't checked if this is the exactly where this takes place but
>> should be in this series, 32-bit build is broken:
>>
>>     3: almalinux:9-i386WARNING: image platform (linux/386) does not 
>> match the expected platform (linux/amd64)
>> WARNING: image platform (linux/386) does not match the expected 
>> platform (linux/amd64)
>>      21.72 almalinux:9-i386              : FAIL gcc version 11.4.1 
>> 20231218 (Red Hat 11.4.1-3) (GCC)
>>       1378 |         perf_pmu__format_pack(&bits, val, vp, /*zero=*/ 
>> true);
>>            |                               ^~~~~
>>            |                               |
>>            |                               u64 * {aka long long 
>> unsigned int *}
>>      In file included from util/evsel.h:14,
>>                       from util/evsel.c:38:
>>      util/pmu.h:282:43: note: expected ‘long unsigned int *’ but 
>> argument is of type ‘u64 *’ {aka ‘long long unsigned int *’}
>>        282 | void perf_pmu__format_pack(unsigned long *format, __u64 
>> value, __u64 *v,
>>            |                            ~~~~~~~~~~~~~~~^~~~~~
>>
>>
>> What I have is in perf-tools-next/tmp.perf-tools-next BTW, I'll try and
>> fix this tomorrow if you don't do it first. :-)
> 
> Taking a look, but I'm wondering if this is already not working 
> properly. There are existing "unsigned long"s in pmu.c that operate on 
> the config bits which is what I copied.
> 
> On this target an unsigned long is 32bits but struct perf_event_attr- 
>  >configs are __u64. So it looks like it might leave the top bits unset 
> sometimes.
> 
> I'll look at a fix for that which should fix the compilation error at 
> the same time.

False alarm, I was confusing a pointer to a single unsigned long with 
what are actually DECLARE_BITMAP()s. So they're two longs in this case 
for 64 bits.

I'll send a fix for the compilation issue and double check the patches 
to make sure that misunderstanding hasn't caused any issues.

> 
> Another question is, do we actually care about this platform?
> 
>>
>> There are some more build problems in other containers/distros, I'll be
>> reporting as replies to the patches that looks related
>>
>> - Arnaldo
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/perf/arch/arm/util/cs-etm.c    | 9 +++------
>>>   tools/perf/arch/arm64/util/arm-spe.c | 2 +-
>>>   tools/perf/arch/x86/util/intel-pt.c  | 3 +--
>>>   tools/perf/util/evsel.h              | 4 ++--
>>>   tools/perf/util/pmu.c                | 6 +++---
>>>   5 files changed, 10 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/ 
>>> util/cs-etm.c
>>> index ea891d12f8f4..c28208361d91 100644
>>> --- a/tools/perf/arch/arm/util/cs-etm.c
>>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>>> @@ -441,10 +441,8 @@ static int cs_etm_recording_options(struct 
>>> auxtrace_record *itr,
>>>        * when a context switch happened.
>>>        */
>>>       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>>> -        evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>>> -                       "timestamp", 1);
>>> -        evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>>> -                       "contextid", 1);
>>> +        evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
>>> +        evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
>>>       }
>>>       /*
>>> @@ -453,8 +451,7 @@ static int cs_etm_recording_options(struct 
>>> auxtrace_record *itr,
>>>        * timestamp tracing.
>>>        */
>>>       if (opts->sample_time_set)
>>> -        evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>>> -                       "timestamp", 1);
>>> +        evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
>>>       /* Add dummy event to keep tracking */
>>>       err = parse_event(evlist, "dummy:u");
>>> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/ 
>>> arm64/util/arm-spe.c
>>> index d5ec1408d0ae..51014f8bff97 100644
>>> --- a/tools/perf/arch/arm64/util/arm-spe.c
>>> +++ b/tools/perf/arch/arm64/util/arm-spe.c
>>> @@ -274,7 +274,7 @@ static void arm_spe_setup_evsel(struct evsel 
>>> *evsel, struct perf_cpu_map *cpus)
>>>        */
>>>       if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>>>           evsel__set_sample_bit(evsel, CPU);
>>> -        evsel__set_config_if_unset(evsel->pmu, evsel, "ts_enable", 1);
>>> +        evsel__set_config_if_unset(evsel, "ts_enable", 1);
>>>       }
>>>       /*
>>> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/ 
>>> x86/util/intel-pt.c
>>> index b394ad9cc635..c131a727774f 100644
>>> --- a/tools/perf/arch/x86/util/intel-pt.c
>>> +++ b/tools/perf/arch/x86/util/intel-pt.c
>>> @@ -664,8 +664,7 @@ static int intel_pt_recording_options(struct 
>>> auxtrace_record *itr,
>>>           return 0;
>>>       if (opts->auxtrace_sample_mode)
>>> -        evsel__set_config_if_unset(intel_pt_pmu, intel_pt_evsel,
>>> -                       "psb_period", 0);
>>> +        evsel__set_config_if_unset(intel_pt_evsel, "psb_period", 0);
>>>       err = intel_pt_validate_config(intel_pt_pmu, intel_pt_evsel);
>>>       if (err)
>>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>>> index a08130ff2e47..2cf87bc67df7 100644
>>> --- a/tools/perf/util/evsel.h
>>> +++ b/tools/perf/util/evsel.h
>>> @@ -575,8 +575,8 @@ void evsel__uniquify_counter(struct evsel *counter);
>>>       ((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + 
>>> (size) - 1)))
>>>   u64 evsel__bitfield_swap_branch_flags(u64 value);
>>> -void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel 
>>> *evsel,
>>> -                const char *config_name, u64 val);
>>> +void evsel__set_config_if_unset(struct evsel *evsel, const char 
>>> *config_name,
>>> +                u64 val);
>>>   bool evsel__is_offcpu_event(struct evsel *evsel);
>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>> index 956ea273c2c7..e87c12946d71 100644
>>> --- a/tools/perf/util/pmu.c
>>> +++ b/tools/perf/util/pmu.c
>>> @@ -1382,8 +1382,8 @@ bool evsel__is_aux_event(const struct evsel 
>>> *evsel)
>>>    * something to true, pass 1 for val rather than a pre shifted value.
>>>    */
>>>   #define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & 
>>> (_mask))
>>> -void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel 
>>> *evsel,
>>> -                const char *config_name, u64 val)
>>> +void evsel__set_config_if_unset(struct evsel *evsel, const char 
>>> *config_name,
>>> +                u64 val)
>>>   {
>>>       u64 user_bits = 0, bits;
>>>       struct evsel_config_term *term = evsel__get_config_term(evsel, 
>>> CFG_CHG);
>>> @@ -1391,7 +1391,7 @@ void evsel__set_config_if_unset(struct perf_pmu 
>>> *pmu, struct evsel *evsel,
>>>       if (term)
>>>           user_bits = term->val.cfg_chg;
>>> -    bits = perf_pmu__format_bits(pmu, config_name);
>>> +    bits = perf_pmu__format_bits(evsel->pmu, config_name);
>>>       /* Do nothing if the user changed the value */
>>>       if (bits & user_bits)
>>>
>>> -- 
>>> 2.34.1
>>>
> 

