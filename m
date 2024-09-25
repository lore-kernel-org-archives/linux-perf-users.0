Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC417E574
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253380; cv=none; b=aYixk+RkSm/sJtWr3eYHhGbAa7OYiufBfKc0d8CAfsYxClZS4smlFJTPyT1U1/GhDDkflwfc+V0PuE3VJNfsLXbR3myN3D5nTif8JscpInN8/PKobY1lYaebgvMHFsIS3MfbObA9K+Xn3nqS6GlRhEc1fDozNosmxyH2b58/7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253380; c=relaxed/simple;
	bh=oitXK+OEA9BE37g2KeTUWl9Ho1Qq0dOTe5le8iXubTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cwp5CQQOMxviNPZtYJ6Zp2aKaqCIOqAwG8JkcaNJQCUEh8qwvDLrs/aWZnFL7392DNN6giLVSTOxuFiCl8jIN/tMgQgyTpMl+Im4CPT8sIiUN+S5ZIVZ9tNZtV+xWqqYW959AwqtZVkndFiqQAF5QRxGIkFQGI6MBfcLsNEt2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j4KiXF85; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4KiXF85"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so9221340a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727253377; x=1727858177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksp6a+vBmT9tTbuHR2BiPBA+vRFwOJtyTtU/9OAbDfY=;
        b=j4KiXF85GTT33DY1Lym5+059Bcvb2bQMDJtqVw9lQiCFrE+aAGNOED1ywPnPNfQrjU
         fV8L8v3To4K48YCnrTjN53BPO6mtjcoqpZe6Ovewr5H2UQ62PTTKXu3SoXuDl2DdDCVH
         xnYFC0NNvvLva0Rm+paY8NxDzXNNimi0f31GaH3QVLf/E6iWXDv/gCARMQurvKeT4I4B
         yF39hvcz2ADQefWE4zMQBYEZTirBYK0+0QixlnqxmEPUjrrNW8LdM7fn9cDVKQkEZpYx
         UXxrB5jrNsVc/y1D+RiCfmFQ+xa7ot1vPdPUybVWIXThdcnRk//XurvRgYAle5QNCgMq
         cuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727253377; x=1727858177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksp6a+vBmT9tTbuHR2BiPBA+vRFwOJtyTtU/9OAbDfY=;
        b=xPiuGtpamJ8hub70HEhm5Ci0KiAu7pOOvHypP2YqHD+3Vc10yoL5TOTzlcOSOOjMS8
         HIW0mBAqVi15cNWtxNq2FHkT0/fcJvIrNmPkkYMSM6l6WfqOTWNI46dWs7z0ww04+6/e
         qVs0GQWbRLqV9QY7kwW1lzwHpM7/ANa0u95o4Vmh1CMrUJFiZB5t4aUXd4k5iZ7NYMti
         jHVpM2sR4NZ11bwDuGpdNCzpS5S7hHFkplpHNwFXKywk/tk7vLIuaYExub9DKSF7Xp23
         W1wQjhuoMBRAyrcbouubtPhidPHPd1lWZo56gPz4qSsu0FzDxFHkWEKLCQuj4whyapjg
         8aIg==
X-Forwarded-Encrypted: i=1; AJvYcCXw8JtKJxFIqX/aWzqHRx0oBY4X/C6HrD+lTsCHILE8Be6I/TdL10T9FvNyAR/05dS16jr8373Z8WN2XEGpRB5X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32dEwfX6JKcRspStB1urR8QNTsnYCk8PzwYFcv/dS/3cmCXPK
	aR5r5eesLPA2+U5FcPYRGoxpGVx0aBj3Lj+iC4cbqsOb2VWjBz5oiJHPo1Ry0k0=
X-Google-Smtp-Source: AGHT+IE7u/39911j1c3sz50SAnSlko3wr3KlRCn4HiDW+ocZgc3Eog0SsprY2n653epsmYu7G78Wbw==
X-Received: by 2002:a05:6402:3207:b0:5bf:2577:32b8 with SMTP id 4fb4d7f45d1cf-5c72061b565mr1672076a12.9.1727253376929;
        Wed, 25 Sep 2024 01:36:16 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf49728asm1632068a12.33.2024.09.25.01.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 01:36:16 -0700 (PDT)
Message-ID: <f436dc23-bcaf-493b-93a9-699b63a18d46@linaro.org>
Date: Wed, 25 Sep 2024 09:36:15 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] perf stat: Add --exclude-guest option
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-5-namhyung@kernel.org>
 <b1002dc7-78bf-40ed-83af-12a50622fb76@linux.intel.com>
 <c26e646d-5ebf-473e-91e2-db28fc01e35d@linaro.org>
 <ZvMfVe1VXwhCIOB9@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZvMfVe1VXwhCIOB9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/09/2024 9:21 pm, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Sep 23, 2024 at 09:47:17AM +0100, James Clark wrote:
>>
>>
>> On 06/09/2024 3:33 pm, Liang, Kan wrote:
>>>
>>>
>>> On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
>>>> This option is to support the old behavior of setting exclude_guest by
>>>> default.  Now it doesn't set the bit so users want the old behavior can
>>>> use this option.
>>>>
>>>>     $ perf stat true
>>>>
>>>>      Performance counter stats for 'true':
>>>>
>>>>                   0.86 msec task-clock:u                     #    0.443 CPUs utilized
>>>>                      0      context-switches:u               #    0.000 /sec
>>>>                      0      cpu-migrations:u                 #    0.000 /sec
>>>>                     49      page-faults:u                    #   56.889 K/sec
>>>>                    ...
>>>>
>>>>     $ perf stat --exclude-guest true
>>>>
>>>>      Performance counter stats for 'true':
>>>>
>>>>                   0.79 msec task-clock:Hu                    #    0.490 CPUs utilized
>>>>                      0      context-switches:Hu              #    0.000 /sec
>>>>                      0      cpu-migrations:Hu                #    0.000 /sec
>>>>                     49      page-faults:Hu                   #   62.078 K/sec
>>>>                    ...
>>>>
>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>> ---
>>>>    tools/perf/Documentation/perf-stat.txt | 7 +++++++
>>>>    tools/perf/builtin-stat.c              | 2 ++
>>>>    2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>>>> index 2bc06367248691dd..d28d8370a856598f 100644
>>>> --- a/tools/perf/Documentation/perf-stat.txt
>>>> +++ b/tools/perf/Documentation/perf-stat.txt
>>>> @@ -382,6 +382,13 @@ color the metric's computed value.
>>>>    Don't print output, warnings or messages. This is useful with perf stat
>>>>    record below to only write data to the perf.data file.
>>>> +--exclude-guest::
>>>> +Don't count event in the guest mode.  It was the old behavior but the
>>>> +default is changed to count guest events also.  Use this option if you
>>>> +want the old behavior (host only).  Note that this option needs to be
>>>> +before other events in case you added -e/--event option in the command
>>>> +line.
>>>
>>> I'm not sure if we really need this option. I think it may bring more
>>> trouble than what we get.
>>>
>>> The name of the "--exclude-guest" sounds like a replacement of the event
>>> modifier "H". But in fact, it's not. It should only affect the default.
>>> It doesn't set the "H" for any events.
> 
> Well I think it's tricky but it'd set "H" modifier events after the
> option.  But I have to agree that it can bring more troubles.
> 
>>>
>>> Except for the perf kvm user, I don't think there are many users which
>>> care the exclude_guest. The behavior of the perf kvm is not changed. So
>>> the option seems not that important. If we really want an option to
>>> restore the old behavior, it's better to choose a better name and update
>>> the description.
> 
> Personally I don't want to this option but just worried if there's a
> case where exclude_guest is preferred.
> 
>>
>> Do we not want to keep exclude_guest for record, but remove it for stat?
> 
> What I really want is to synchronize record and stat behavior in terms
> of the default exclusion mode.  If everyone is fine, I'd like to remove
> exclude_guest from the default and set it only if needed (through the
> fallback) like we do for exclude_kernel.
> 
>>
>> Because in record the addresses of guest samples don't make sense without
>> extra work, but for stat you might want to see an overview of the whole
>> system.
> 
> I think it depends on the use case and (power) users should know about
> their environment and requirement.  The concern is what's the reasonable
> default, but I think it should be the same both in perf record and stat
> at least.
> 
>>
>> For Coresight tracing and SPE we would want to keep exclude_guest, otherwise
>> you generate a load of extra trace that you can't make use of. Say you were
>> doing PGO on your host you wouldn't be recompiling anything the guests were
>> running.
> 
> For the specific use case, I think we can guide users to add "H"
> modifier (I guess it's not the default event for perf record).
> Maybe we can consider per-PMU default attributes.
> 

Yeah I was thinking about adding it as a default when the Coresight and 
SPE events are configured, but I think it's too much to expect for 
people to know all the edge cases about what the per PMU defaults will 
be. Having one default for all PMUs makes more sense to me.

I suppose asking Coresight users to add :H when they need it might be a 
less bad thing than this change to clean up the fragmentation in the 
defaults.

I expect most of the time if :H is not added things continue to work, 
just that more data will be recorded. One real concern is that in some 
configurations there is a limited buffer size and once it's filled you 
don't get any more data. If that buffer is filled by guest trace then 
maybe some Auto FDO flow could break. But it's kind of an edge case of 
an edge case and adding :H isn't really the end of the world.

>>
>> If we do change the defaults isn't ':H' already enough to go back to the old
>> behavior? I'm wondering why we need an argument when all the other exclude
>> rules are done with the letter modifiers?
> 
> I'm not sure I follow this.  But maybe we don't need this option at all.
> We can add ":H" for every event but I'm too lazy to add them to all the
> default events in perf data. :)
> 
> Thanks,
> Namhyung
>   

Oh I see yes, the argument is a shortcut to adding H on all events 
and/or the default ones. I wasn't sure if was added because it couldn't 
be done with :H, but I see it's an alternative instead. So adding it 
makes sense.

>>>> +
>>>>    STAT RECORD
>>>>    -----------
>>>>    Stores stat data into perf data file.
>>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>>> index d8315dae930184ba..4d47675af5cc3094 100644
>>>> --- a/tools/perf/builtin-stat.c
>>>> +++ b/tools/perf/builtin-stat.c
>>>> @@ -2491,6 +2491,8 @@ int cmd_stat(int argc, const char **argv)
>>>>    		OPT_BOOLEAN_FLAG(0, "all-user", &stat_config.all_user,
>>>>    				"Configure all used events to run in user space.",
>>>>    				PARSE_OPT_EXCLUSIVE),
>>>> +		OPT_BOOLEAN(0, "exclude-guest", &exclude_HG_default,
>>>> +			"Don't count events in the guest mode"),

Maybe this would be a good hint if it really is equivalent:

  +	"Don't count events in the guest mode. (Add :H to all events)"),

>>>>    		OPT_BOOLEAN(0, "percore-show-thread", &stat_config.percore_show_thread,
>>>>    			"Use with 'percore' event qualifier to show the event "
>>>>    			"counts of one hardware thread by sum up total hardware "
>>

