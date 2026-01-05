Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AB3148B8
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Jan 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608589; cv=none; b=taejlK/qhBAp39xDaxYpBvDgjb64KsqTzg9B3nUVZ6BYM/zn/OW+huWCoSUM0T+N7aDd8nLRvy2UprYKRJnaYCzdYZuPTj+WuyoIIDdipMpu7Y4F/m2suuwoYNR24xsTd18dem5wiPA0LLoU9uTncO+mX+LY8h4a7Jv0b5X7UkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608589; c=relaxed/simple;
	bh=ov6f1+rkLxhqWiXXuCLI2QlDS3ZyxbIW2uzfNtxCovs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qC2G69DNkZDJQBOxX+wpasJK7XMgXhQNhHx7BUPwdYrXq5/0QXTNIlOZUaEF9eRhg7bG964Urs8lKeZlQXO0lfIWTkeC6ojau2mdOn5Qx4OWHP5amO77WHXpKYs4LEQPLdvV1jX8YavguJFOmmQm+4l6dmIrIjCgZcOmFm1D9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UyWhZ6fw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyWhZ6fw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso124473085e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jan 2026 02:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767608584; x=1768213384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjPNX53qsmSbQa6/MqIrhJqUn4vzLuo+5d9DC74SH6w=;
        b=UyWhZ6fw9qbWX2X25EmCTu0EbOyQr2yUdHE7t4cZVIoOJ4b4LVzvv8re4Rue6D7J1O
         7B2j3lhHXfxDm62ltFhrBR0khfFr4WEIQuWQtSlI859Pu3UTF+A1a8M4yeplD/9Gf+hg
         LYS+lVFlSiiD+EX/D0wMk2PIjFNHha0g67JCEJFHjh7QuDIftVf29Q6SoZUlz+oUMUeQ
         dNv6N5pteSXrM91GfwOuL4gGeFpE+8RFMX18eBc9fr92QzVeT+0/YPzMBlLjO9N8dgrf
         8SfI+P3NkkXNAP3oZs8UqJOoU1v6DI8a9dxsiymB2xAq/xjyrF2uU9s/ioUlWsVWLjZy
         IT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767608584; x=1768213384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjPNX53qsmSbQa6/MqIrhJqUn4vzLuo+5d9DC74SH6w=;
        b=stLfQ77GewnhGxLcSjI0AmG/AYrR6ZeSzZukrP2945MpbDYAYJijzdUKWt8HMJBtRs
         KYYecVs97WPpcOY+rROGIThuPp+Muxac6/eogn8D+a8j1spwxjtJ1zCygPHsTxmbl8Jn
         Sy6Rqp+PAlWynfSIxfObeycm0zcGraWvDBSpLSMJxXGeKydYOP+uASF8nYemSoAUJfaH
         v6Zkpzls8DP2qOAECu6ctSIw8IFe+Kb7szAVOorkEAbf6BgH/y11x9mh/uxE7W2+eExQ
         G2GiJLtjb9cJbTctI13MFkPrK7VHvwm6cfjFBojBSCrny5Kms+9UDynuf2Jrrh2LkXkg
         oX6g==
X-Forwarded-Encrypted: i=1; AJvYcCVyhjjSzmENVpGXheeJTHQ49zmFHJ5raLMwhYQeMphmEtr3ROILaMla4QR8w0rJELH31VriWib8H4l74NXoEy/M@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/VYudY4jKoXIXQWvITzY0B+lHfimj6A8J7Yr17KEpMP0cYV6
	xs7cwoMoOl/Ss1arc/4bE27NwvuEzkmXdPcJbZUxUiytIfMa2BE0/VtrJc9aAbE6xWI=
X-Gm-Gg: AY/fxX4633TCff/TNAWDuGXlw5nC2z34rr6TLcX8N3GWn+1VEaBmkltSt6Dp9vibMk/
	X4iKV3hlB+3Hwdw2lbwsjuDqarrc2dIMgXn9eTppALv+u6FzeUnCxgWrvzLYnPWbvb2e2b2aMJj
	wpfnmqXfJfQm9jpb4oUmZs/Odd3BT5hnMxANWkCvCalCuDshwtOB2Q7XNLfnyrn1A4U51a34/74
	9Cd3KjmMf+TRJctTV+MwaWJuwRlFTBVPTZC2Iy4i0Wiq3IRge7vg5D0C0w8uiEoZ6OWhIFQBu/w
	MGLJG2VUKajyHsE6QUhB8F/9u6nYR0Jz5gWgx/IleZKkveDd7h13HPx/vt/DzPRbTPxQq/Q0t/3
	qPVE8rMq66eyxLPPJJ/EhwUpPTj/mbHSre2qYfTUQzcWhQquuJiB8Wm2GS/FROpZOkxcsc7lJ+Q
	GjskcGrKQxlaguHxs1
X-Google-Smtp-Source: AGHT+IH9tKuyAlhktoMiOiAQvOA0pymhdCPq5V+2Yc35glT3RWVKqXpIPiYAUmAPxYxpzICFB6Domg==
X-Received: by 2002:a05:600c:8107:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-47d19595f00mr640717415e9.22.1767608583849;
        Mon, 05 Jan 2026 02:23:03 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d452a3bsm142078455e9.11.2026.01.05.02.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 02:23:03 -0800 (PST)
Message-ID: <3513a638-c207-4ce5-b966-b274891beffe@linaro.org>
Date: Mon, 5 Jan 2026 10:23:01 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: Remove uncountable events
To: Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>,
 Yoshihiro Furudera <fj5100bi@fujitsu.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
References: <20251231-james-perf-uncountable-events-v1-1-f2d9932999fd@linaro.org>
 <CAP-5=fUNJLoy25rS=diSXNR9h-h4m6EFPTy8M+KpTKxm6HtDSA@mail.gmail.com>
 <951f10c5-e1ac-45d4-b7ca-56aa32e57cd6@linaro.org>
 <CAP-5=fWQU59Vyb6y+W6ObOTh3nzFSofsn8sc6JzwZp7FiV+n6w@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWQU59Vyb6y+W6ObOTh3nzFSofsn8sc6JzwZp7FiV+n6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/01/2026 1:27 am, Ian Rogers wrote:
> On Sat, Jan 3, 2026 at 8:38 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 02/01/2026 3:29 pm, Ian Rogers wrote:
>>> On Wed, Dec 31, 2025 at 4:13 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> These events are never countable by the PMU and are only intended to
>>>> be used as external inputs to trace. Therefore showing them in 'perf
>>>> list' is misleading so remove them.
>>>
>>> What does "trace" mean in this context?
>>>
>>
>> CPU trace, Either ETE (Embedded Trace Extension) or ETM (Embedded Trace
>> Macrocell). You can select PMU events as inputs to the trace block to
>> make it do things like start and stop tracing.
> 
> Ah ok, trace immediately makes me think of `perf trace` currently.
> Presumably there's no perf integration for ETE and ETM that somehow
> use these event encodings? Looks not and the changes make sense to me.

Not yet, currently you have to create kernel modules to do complex trace 
configs.

> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
>

Thanks!

>>> Thanks,
>>> Ian
>>>
>>>> The generator script doesn't emit these events when used with the new
>>>> telemetry-solution input files [1].
>>>>
>>>> 'perf list' should only show countable events because there are events
>>>> that are sometimes implemented, sometimes countable and sometimes not,
>>>> for example TRB_TRIG. If we always include any implemented events
>>>> whether they are countable or not then it's not possible to tell whether
>>>> they are usable in perf without going to the docs, defeating the point
>>>> of 'perf list'.
>>>>
>>>> It's also not useful yet to display implemented events that are not
>>>> countable (for help in using trace rather than perf stat), because
>>>> PMU_OVFS and PMU_HOVFS are practically always implemented and TRB_TRIG
>>>> is always implemented when there is TRBE.
>>>>
>>>> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/main/data/pmu/cpu
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json  |  8 --------
>>>>    tools/perf/pmu-events/arch/arm64/common-and-microarch.json | 12 ------------
>>>>    tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json   | 10 ----------
>>>>    3 files changed, 30 deletions(-)
>>>>
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
>>>> deleted file mode 100644
>>>> index d8b7b9f9e5fa..000000000000
>>>> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
>>>> +++ /dev/null
>>>> @@ -1,8 +0,0 @@
>>>> -[
>>>> -    {
>>>> -        "ArchStdEvent": "PMU_OVFS"
>>>> -    },
>>>> -    {
>>>> -        "ArchStdEvent": "PMU_HOVFS"
>>>> -    }
>>>> -]
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>>>> index 2416d9f8a83d..468cb085d879 100644
>>>> --- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>>>> +++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
>>>> @@ -432,24 +432,12 @@
>>>>            "EventName": "TRB_WRAP",
>>>>            "BriefDescription": "Trace buffer current write pointer wrapped"
>>>>        },
>>>> -    {
>>>> -        "PublicDescription": "PMU overflow, counters accessible to EL1 and EL0",
>>>> -        "EventCode": "0x400D",
>>>> -        "EventName": "PMU_OVFS",
>>>> -        "BriefDescription": "PMU overflow, counters accessible to EL1 and EL0"
>>>> -    },
>>>>        {
>>>>            "PublicDescription": "Trace buffer Trigger Event",
>>>>            "EventCode": "0x400E",
>>>>            "EventName": "TRB_TRIG",
>>>>            "BriefDescription": "Trace buffer Trigger Event"
>>>>        },
>>>> -    {
>>>> -        "PublicDescription": "PMU overflow, counters reserved for use by EL2",
>>>> -        "EventCode": "0x400F",
>>>> -        "EventName": "PMU_HOVFS",
>>>> -        "BriefDescription": "PMU overflow, counters reserved for use by EL2"
>>>> -    },
>>>>        {
>>>>            "PublicDescription": "PE Trace Unit external output 0",
>>>>            "EventCode": "0x4010",
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
>>>> deleted file mode 100644
>>>> index 65bd6cdd0dd5..000000000000
>>>> --- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
>>>> +++ /dev/null
>>>> @@ -1,10 +0,0 @@
>>>> -[
>>>> -    {
>>>> -        "ArchStdEvent": "PMU_OVFS",
>>>> -        "BriefDescription": "This event counts the event generated each time one of the condition occurs described in Arm Architecture Reference Manual for A-profile architecture. This event is only for output to the trace unit."
>>>> -    },
>>>> -    {
>>>> -        "ArchStdEvent": "PMU_HOVFS",
>>>> -        "BriefDescription": "This event counts the event generated each time an event is counted by an event counter <n> and all of the condition occur described in Arm Architecture Reference Manual for A-profile architecture. This event is only for output to the trace unit."
>>>> -    }
>>>> -]
>>>>
>>>> ---
>>>> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
>>>> change-id: 20251230-james-perf-uncountable-events-28adfb93b73f
>>>>
>>>> Best regards,
>>>> --
>>>> James Clark <james.clark@linaro.org>
>>>>
>>

