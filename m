Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FAD396B9A
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392888; cv=none; b=D9Qe7rlj9Q9mvZ0VhpAYt7qA5zuIca+uMktY+kqRM7P8zu2nxBZ1EjZAI9pudM2uc9ikqS2bQeuOtg2smb1SC1mQcS3WYe+o1sho5a/0GxZ30FTc2DT/+qes+h/k5OYaUA1jeK+Lj2Vn8JCDkPrCJUcEGLXE3Qd/4qXTpCPTzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392888; c=relaxed/simple;
	bh=D1t6YCiTDw5u3AEvfc2AzC+8kFoWThiEYxSMebxH3d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERLZbdYxcejFOtDdbsiMJn8mdlb1b4XVtUNbFOixIc0AzP+mnU2+Xua5KfQdvH2QYJ5UxYiNHLdPk4gYOU13JdVi4TWLqkCabX9k+lfE4Tr2nvX8HenhiDDOhpLHMiVLgiyTXRfAX1PL8V3ejjBXAUc4A6NtAhbOVer2vAnFTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ryOulEmX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ryOulEmX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso51956455e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 04:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768392885; x=1768997685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zm5kxemUqHHNC5WZIc5C1Ae0dp7ZQReOnSyfnewqqRY=;
        b=ryOulEmXexohV6a2Ixpaca/hsH7f/++7CJHgpOFonTyipn80ETuv18cQ9A+3JDnTWW
         7BPbuXNEd90aBiWctwfwrkRqO19KB/Fp2XzsOIrn3DyFuyrombOMcI29xByPpf8Px3PO
         6qecL+oWHtvWX9FHVyfU8cRX8/1vJzl4h5q7497gaDc6Q7iQtLp2/ndYcwv1YlU5feT8
         JHMQ4bGG4/lBGlVmVdgfoWmQf6/JOSxuvzHeKn2Fcpt2TysP5TDEs8IwUaSxMiTHCFJL
         Gl9ThTTUySMlqtxWQcxAzLoPo01+G9KMkCEJX4eQNECmEXIcycviKhwYwXXW1NiPLRCs
         n6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768392885; x=1768997685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zm5kxemUqHHNC5WZIc5C1Ae0dp7ZQReOnSyfnewqqRY=;
        b=nt408w3NWnmVYlWVQwRxESrrG0iiJ08Erkj2pDbhM9aXpQ4RQ0CXxarG+llbHRdFHO
         KLn5lkSShpUv9kXfZNlz8WGtc8BXkNun8KRAqTfkYg0VvbamiShCAh9F0V1CJuw8cXNn
         fUiB0PO0lx6YmWwsOQ97jmxcOGOUTmd16W6rGVk4i5lqYn+Kl9arpO8ADdOlPtRQ2xCc
         KSRIh8cBqdrcl4aXj3qMywftKOBgfSVYUgVzSh4SSAXOdcpSrPYIMuFIdG8CQ+TBpDpP
         EHhm5KXL3U83+kCsa8hXOEPDZC7bW37RyB911l0yrgNNEZsa+RvHKKesrP8vSuoM775a
         1hvA==
X-Forwarded-Encrypted: i=1; AJvYcCXidjikX6AmexR5DJKws2JUF3kKuqh7iemadp4BMVZ5JNlUd+m2ZnRuUKWLnP5u2Ueth30RaaH+kC1sfYxZZf4e@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7BiZbFD2mBEvjU58Hvn46PTuFk5RPqO+x9WkybbyQkEQJxkfK
	bSzGCP+gFvHcvw0WdBvgM633TEVvFOmLbeArRjNOToy2+8rKoUmAS8LshkCxTW96Ed4=
X-Gm-Gg: AY/fxX6eiCyFobRClUSzyDYLDxfHIxP8MBgNnXUp9K/NPIOWtps+ZKa816MDgxbDQQG
	WUSARPVTIL1D/SM97oH5ZMrtOvuhakGVuzyPiUVQo1isrANf1V8EQug1b2d2pLmY1i90wDLG4WD
	5ADXTzJOOIdv0o7Qal0rWSIHG3mN2GBySWENoWlTeujfVHr8dZ6TyzlI0Mvymx1dAU1kzLpPg40
	LVbXZS5Wynek+aFAvtX7Oip8feOvc7bX2/88O7wTLPYLFm5REwHlelvT1dJsBXROTByeapR88h8
	w3y3TaByC7zBUNI/sH2yxy4u9wWAao3qOF2BT9VY3Z6oRsoX1fixKOK+x3sbWsVugebezktpQDl
	JSJNkLyYYVSfUl3E0uv44S9FTCCf4msnGyMmGv17dUBibJzZ2vzZRKNRTDKC8NdqlkPN9q/o+e4
	T1gaz0U/SKw80eLm5G
X-Received: by 2002:a05:600c:4688:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-47ee47c9e2emr20866425e9.13.1768392884789;
        Wed, 14 Jan 2026 04:14:44 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe83bsm50179354f8f.38.2026.01.14.04.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 04:14:44 -0800 (PST)
Message-ID: <4eda1bd6-ec36-4d0b-85de-ef0bd190e5e7@linaro.org>
Date: Wed, 14 Jan 2026 12:14:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] perf evsel: Refactor
 evsel__set_config_if_unset() arguments
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
 <aWbDg0kmo-isxkz2@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aWbDg0kmo-isxkz2@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/01/2026 10:13 pm, Arnaldo Carvalho de Melo wrote:
> On Mon, Dec 22, 2025 at 03:14:27PM +0000, James Clark wrote:
>> Make the evsel argument first to match the other evsel__* functions
>> and remove the redundant pmu argument, which can be accessed via evsel.
> 
> I haven't checked if this is the exactly where this takes place but
> should be in this series, 32-bit build is broken:
> 
>     3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
> WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
>      21.72 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC)
>       1378 |         perf_pmu__format_pack(&bits, val, vp, /*zero=*/true);
>            |                               ^~~~~
>            |                               |
>            |                               u64 * {aka long long unsigned int *}
>      In file included from util/evsel.h:14,
>                       from util/evsel.c:38:
>      util/pmu.h:282:43: note: expected ‘long unsigned int *’ but argument is of type ‘u64 *’ {aka ‘long long unsigned int *’}
>        282 | void perf_pmu__format_pack(unsigned long *format, __u64 value, __u64 *v,
>            |                            ~~~~~~~~~~~~~~~^~~~~~
> 
> 
> What I have is in perf-tools-next/tmp.perf-tools-next BTW, I'll try and
> fix this tomorrow if you don't do it first. :-)

Taking a look, but I'm wondering if this is already not working 
properly. There are existing "unsigned long"s in pmu.c that operate on 
the config bits which is what I copied.

On this target an unsigned long is 32bits but struct 
perf_event_attr->configs are __u64. So it looks like it might leave the 
top bits unset sometimes.

I'll look at a fix for that which should fix the compilation error at 
the same time.

Another question is, do we actually care about this platform?

> 
> There are some more build problems in other containers/distros, I'll be
> reporting as replies to the patches that looks related
> 
> - Arnaldo
>   
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/arch/arm/util/cs-etm.c    | 9 +++------
>>   tools/perf/arch/arm64/util/arm-spe.c | 2 +-
>>   tools/perf/arch/x86/util/intel-pt.c  | 3 +--
>>   tools/perf/util/evsel.h              | 4 ++--
>>   tools/perf/util/pmu.c                | 6 +++---
>>   5 files changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>> index ea891d12f8f4..c28208361d91 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -441,10 +441,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>   	 * when a context switch happened.
>>   	 */
>>   	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>> -		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>> -					   "timestamp", 1);
>> -		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>> -					   "contextid", 1);
>> +		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
>> +		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
>>   	}
>>   
>>   	/*
>> @@ -453,8 +451,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>   	 * timestamp tracing.
>>   	 */
>>   	if (opts->sample_time_set)
>> -		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>> -					   "timestamp", 1);
>> +		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
>>   
>>   	/* Add dummy event to keep tracking */
>>   	err = parse_event(evlist, "dummy:u");
>> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
>> index d5ec1408d0ae..51014f8bff97 100644
>> --- a/tools/perf/arch/arm64/util/arm-spe.c
>> +++ b/tools/perf/arch/arm64/util/arm-spe.c
>> @@ -274,7 +274,7 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
>>   	 */
>>   	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>>   		evsel__set_sample_bit(evsel, CPU);
>> -		evsel__set_config_if_unset(evsel->pmu, evsel, "ts_enable", 1);
>> +		evsel__set_config_if_unset(evsel, "ts_enable", 1);
>>   	}
>>   
>>   	/*
>> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
>> index b394ad9cc635..c131a727774f 100644
>> --- a/tools/perf/arch/x86/util/intel-pt.c
>> +++ b/tools/perf/arch/x86/util/intel-pt.c
>> @@ -664,8 +664,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
>>   		return 0;
>>   
>>   	if (opts->auxtrace_sample_mode)
>> -		evsel__set_config_if_unset(intel_pt_pmu, intel_pt_evsel,
>> -					   "psb_period", 0);
>> +		evsel__set_config_if_unset(intel_pt_evsel, "psb_period", 0);
>>   
>>   	err = intel_pt_validate_config(intel_pt_pmu, intel_pt_evsel);
>>   	if (err)
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index a08130ff2e47..2cf87bc67df7 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -575,8 +575,8 @@ void evsel__uniquify_counter(struct evsel *counter);
>>   	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
>>   
>>   u64 evsel__bitfield_swap_branch_flags(u64 value);
>> -void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>> -				const char *config_name, u64 val);
>> +void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
>> +				u64 val);
>>   
>>   bool evsel__is_offcpu_event(struct evsel *evsel);
>>   
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 956ea273c2c7..e87c12946d71 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1382,8 +1382,8 @@ bool evsel__is_aux_event(const struct evsel *evsel)
>>    * something to true, pass 1 for val rather than a pre shifted value.
>>    */
>>   #define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
>> -void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>> -				const char *config_name, u64 val)
>> +void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
>> +				u64 val)
>>   {
>>   	u64 user_bits = 0, bits;
>>   	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
>> @@ -1391,7 +1391,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>>   	if (term)
>>   		user_bits = term->val.cfg_chg;
>>   
>> -	bits = perf_pmu__format_bits(pmu, config_name);
>> +	bits = perf_pmu__format_bits(evsel->pmu, config_name);
>>   
>>   	/* Do nothing if the user changed the value */
>>   	if (bits & user_bits)
>>
>> -- 
>> 2.34.1
>>

