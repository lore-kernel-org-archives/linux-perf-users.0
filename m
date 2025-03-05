Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEED2505DF
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190398; cv=none; b=DWLsIsWb+0PpV2L4ar/xebOMUoFnSriwvAYmBjzhba6dKcnoEvJ2ZgSHylb3JenrR5ba5cuP4C1K4dUpPK010Im0QWbFfHiY23YJuaWP+406gXkZG/JYm2nWvKXkuy9gxR5aqJI9eglmacssuxqO/XtP//lnqUKsMG2Bi0faVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190398; c=relaxed/simple;
	bh=cz3+XxTJM2/BYXYonEq1KyZnXWcGubYg5hz1llP1qHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hf/WKTCds9K8HTSplJjUlmoJH32584/gOFtCGLRZBDlYYg9xvPcUL3fE7QRyADrL4UG3o0pMOLBIosZB0ORCN1UyDIxXn8UeXhL4sujqtJlhQ2kUdfNYVkTb+DbEhfgCP9gKgJeJL3fICQM49ci5u6o5yDFI8k9lGZYt2mLu+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9UwVKc+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9UwVKc+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bcad638efso15370635e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741190394; x=1741795194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UW43fnkCZr/QVnDgsr+/5Aw8cadepol9ZOCnWhJ8+4s=;
        b=E9UwVKc+mWeMQQrRCmF2Epnca63MZtaSlFQq9qnaln8mhQrKlRH9AOzGxPhzeIJVM5
         Q9it8cBgFpUk7Zml9KPAmnO71kqR2mMF5yyqO2nPlzV73wvoRN2VSfkIqMr0ckIMLNsJ
         An4/5OShVxzC3nao/unFBY4AXjFnANM9wZayEXKZOBemkdcO6xHT6DtDdRyQs8rLYdFS
         jIAPa49ffdvfLPuMv8u3gFYTbdyGvL9N0/D/LlItDQY9dmlYwHqLxwqUENLdfGsM5BT/
         RUAMD4jFR5siej8if9vfH6Zu6NH3WnIiBuXuB1TIptdmve/PgbmWpEhEg1hqeQk0UOUQ
         gYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190394; x=1741795194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UW43fnkCZr/QVnDgsr+/5Aw8cadepol9ZOCnWhJ8+4s=;
        b=iqefJ6eE5uiiNArQAtg+zk0JrRsBmkQnFTjHNI1kDSDOmGosVDrTear7p8WtLZNgUH
         tbF3S5TvjrV4YiEGEoguD8MtDf6leUA0f8pU7mdogNzN520V5cGwOgDKjMI85xNBHcKj
         RHBaI765CX+ZdEcvawzaGH2ewrcTLrkGM5oRLfYSYA8IAXs0Ao2O6/8iUIQ41vDNhMs8
         80pTNWb9r5J6dEMLImNJNzaObO1QA021gbYDoMaHZptLTFgq91kjAfjHHXQfavso1Ten
         NkAhH62rUeEpc9fUvZ9pdamj9cSsiIGFs6tsMPieCWo+uz36vDKa1a7rmYpu0ykobz+j
         tv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVe3ZOUSr14ZKofe7/cHCGomVjIm+80Mc4JbOZVICDA1JVT21ndQ5juJ+szBt6iZsx5MMa1YqxIDvgdYnz0F7lz@vger.kernel.org
X-Gm-Message-State: AOJu0YzSsYfLIdrSvhKt9nFCyznYrsnP4K8tnN/L+JkxUgq+tXwUp/6r
	MXV8UZ75lSpPqsnEvcGki0NC36cf/veMWOOShf5B8MHizhIFDagi81/eKsmk3Qg=
X-Gm-Gg: ASbGnct2yJHmVzABXmRmU1JDCbTO9o5cKvacHHrYiQe7eMEoJCGQCXnJyElUNHpk0KS
	e7vJkWSpK8kNLELyHlvhjsmW107cAX8ka3FHMuPKxTD63EE2vz2WmKASASsdgdCBFSuQsrq7EmN
	aWeYMiknnSvvxnyZQ03jD0Jo0yBR+aSvf20HZsrgDIb35z2azLtMkuqwOAqMSxLfywy5evDyLFH
	UI7Y22+O5w1jCpTBZwxjcsKzJFapMeAij7qinC0iVWRjRGWQ635VD5KbnQUUB1LzpACOF51NtVK
	ehrou7Jrl/NdfZo6FWDEJYPi4YChqOYiaCbp2aqh1RJ1LyMi9fSd/s4=
X-Google-Smtp-Source: AGHT+IHAQX1QLcPBiImLmVkMJHbP/s0nNOFVUx5c/xHikuVLp++eIhtXxami9jflK3oLSnWSKvMzDQ==
X-Received: by 2002:a5d:64cb:0:b0:390:df75:ddc4 with SMTP id ffacd0b85a97d-3911f7cba2amr3644307f8f.44.1741190394405;
        Wed, 05 Mar 2025 07:59:54 -0800 (PST)
Received: from [192.168.1.247] ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796084sm21779835f8f.19.2025.03.05.07.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 07:59:54 -0800 (PST)
Message-ID: <3ef6fd45-ee37-4d31-96ba-3df83f350b79@linaro.org>
Date: Wed, 5 Mar 2025 15:59:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf parse-events: Corrections to topdown sorting
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen
 <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>
References: <20250305083735.393333-1-irogers@google.com>
 <20250305083735.393333-2-irogers@google.com>
 <e2ea3776-12d2-41c2-9b7b-836c7c249c45@linaro.org>
 <CAP-5=fW0LESRaZkGv-UCZGU_ttYi6kdF=dxJZP8KmVTiTwBM+Q@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fW0LESRaZkGv-UCZGU_ttYi6kdF=dxJZP8KmVTiTwBM+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/03/2025 2:06 pm, Ian Rogers wrote:
> On Wed, Mar 5, 2025 at 5:44 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 05/03/2025 8:37 am, Ian Rogers wrote:
>>> In the case of '{instructions,slots},faults,topdown-retiring' the
>>> first event that must be grouped, slots, is ignored causing the
>>> topdown-retiring event not to be adjacent to the group it needs to be
>>> inserted into. Don't ignore the group members when computing the
>>> force_grouped_index.
>>>
>>> Make the force_grouped_index be for the leader of the group it is
>>> within and always use it first rather than a group leader index so
>>> that topdown events may be sorted from one group into another.
>>>
>>> Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@linux.intel.com/
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>
>> Testing on Arm seems ok, but presumably this doesn't change anything
>> there because arch_evsel__must_be_in_group() is always false.
>>
>> On x86 I ran into the topdown metrics not opening on cpu_core at all, so
>> I'm not sure if I'm able to test that the original issue is fixed on my
>> machine. From looking at the link the issue is that the ungrouped
>> topdown event is "<not supported>", but I always see that regardless of
>> grouping despite perf list saying it exists:
>>
>>    $ perf list --unit cpu_core | grep -i topdown
>>     topdown-bad-spec OR cpu_core/topdown-bad-spec/     [Kernel PMU event]
>>     topdown-be-bound OR cpu_core/topdown-be-bound/     [Kernel PMU event]
>>     topdown-br-mispredict OR cpu_core/topdown-br-mispredict/[Kernel PMU
>> event]
>>     topdown-fe-bound OR cpu_core/topdown-fe-bound/     [Kernel PMU event]
>>     topdown-fetch-lat OR cpu_core/topdown-fetch-lat/   [Kernel PMU event]
>>     topdown-heavy-ops OR cpu_core/topdown-heavy-ops/   [Kernel PMU event]
>>     topdown-mem-bound OR cpu_core/topdown-mem-bound/   [Kernel PMU event]
>>     topdown-retiring OR cpu_core/topdown-retiring/     [Kernel PMU event]
>>     topdown.backend_bound_slots
>>     topdown.bad_spec_slots
>>     topdown.br_mispredict_slots
>>     topdown.memory_bound_slots
>>          [TOPDOWN.MEMORY_BOUND_SLOTS. Unit: cpu_core]
>>
>>
>>    $ sudo perf stat -e topdown-retiring -- true
>>    Performance counter stats for 'true':
>>        <not counted>   cpu_atom/topdown-retiring/           (0.00%)
>>      <not supported>   cpu_core/topdown-retiring/
>>
>>
>>    $ sudo perf stat -e topdown-retiring -vvv -- true
>> Control descriptor is not initialized
>> Opening: topdown-retiring
>> ------------------------------------------------------------
>> perf_event_attr:
>>     type                             10 (cpu_atom)
>>     size                             136
>>     config                           0xc2 (topdown-retiring)
>>     sample_type                      IDENTIFIER
>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>     disabled                         1
>>     inherit                          1
>>     enable_on_exec                   1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8 = 3
>> Opening: topdown-retiring
>> ------------------------------------------------------------
>> perf_event_attr:
>>     type                             4 (cpu_core)
>>     size                             136
>>     config                           0x8000 (topdown-retiring)
>>     sample_type                      IDENTIFIER
>>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>>     disabled                         1
>>     inherit                          1
>>     enable_on_exec                   1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8
>> sys_perf_event_open failed, error -22
>> switching off exclude_guest for PMU cpu_core
>> Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit,
>> falling back to no-inherit.
>> Warning:
>> topdown-retiring event is not supported by the kernel.
> 
> Yep, unfortunately there is a requirement that a topdown event like
> topdown-retiring is always programmed with slots on performance cores.
> The slots event must be the group leader. You can see in metrics the
> slots event as "+ 0 * slots":
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=perf-tools-next#n754
> ```
>          "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound +
> topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0
> * slots",
> ```
> and making it the group leader is done by the sorting:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/util/evlist.c?h=perf-tools-next#n67
> 
> We could probably add something to
> parse_events__sort_events_and_fix_groups to inject the slots event,
> but this hasn't been done yet.
> 
> My main concern with this change is there is some sensitivity to the
> event ordering when parsing them in scripts. There's some context in:
> https://lore.kernel.org/all/20230719001836.198363-1-irogers@google.com/
> This change makes the topdown events appear first in the group always,
> but as you say you only see that if you use those events, otherwise
> things are unchanged.
> 
> Thanks for testing!
> Ian

Ah ok got it. Yeah it works with slots in the group, and the topdown 
metrics work out of the box. I didn't realize there was that slots 
limitation.

Tested-by: James Clark <james.clark@linaro.org>

