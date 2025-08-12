Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15AB27FD72;
	Tue, 12 Aug 2025 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006024; cv=none; b=CFMxTpV6KPnvm+w3ATNRZtzSNO6TpKzyPjg3NLhuqJbuzqvg2F0yYZrFGVFx7jZVa4H7FTffNkmfmImrw3CPwqbLhciCdNDU5mF/l9gL5TGWPIe26gH0V1B8hzDta4HfyTZnVcE5K2Tnr/ozleZILWtnesIWVhb4KcevhX6Is8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006024; c=relaxed/simple;
	bh=h+1RXMbw424li1OarsefMJHtM9EXvMmgbeIoNTHRHWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4OMVylhDfiw+ue/cvLbC4wRpbK+itaMFrpKCeEoHcUJdOoS6whSiPljZMtXCN9TP71gTDFMdKGtFpuvMEs0NvK13agfiUzMH/zS2df/vKgQs6ND13yN3pbps4rpGzjvvSfBO24ozl3gB8nPqWPnv3SmV26DkPwsTbl4RMx73qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76c0387f1edso552831b3a.3;
        Tue, 12 Aug 2025 06:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006022; x=1755610822;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8rK2E+jm7j471B3AnObKgT85KTYfe6f4io/jt1DHyM=;
        b=UD31PCIRGrLrpjIoCKqXEMDX0CML/u10/ETGpQ8oM9URVZM/+H8LKAYKxEontF6m5B
         1SyZgKvgMRM4qGtcWU5+Oyct4+ayy+XbtJ5W+uxVbzP0SBuZYhWmzWK6/BvEUxPzCjsY
         u9JHtU37ZWvQOj7Uwz7n/7aOnxUK+x8O5gt6qy3QEiIcbGcAWK6iDEHRpc0UI3br8sKi
         VPOUVtrM4O6addIiDebFiM291LlgwK/jihxn0kEknJi6J/u3p1D6E2i0A9DHrPAiDJKv
         UjBELhYJRLlYO680n4kdQzGDeC2aIu005aE9/IqRab/3mdFhvcr/aM12/x1wfAHxb5pE
         yRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBikXKTU9odulkHY7kW6mi6fYjhxP3tkRCudJZDjLKWiYkcIFA/C/B1O4WQ4+WFOiZDkt8oww76VlZ4Mo=@vger.kernel.org, AJvYcCXPRk55tMLd1q9PWOwyUlhXSvu+v0ekJn/+u7rZntus/Nc64VoGojp0LY6j3mK559TaYcjvTNZJeSEVz4oF2F+S3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXXs288GDJmQMYW9qEV7WqK/5bzZrWO1NxVGsb5Pb2wKjqvV5
	4L9oZFK6sj+DBjRcNdhDOa+N2xpY1oz+gUfQHJ9GYUE278NJgiQHmtAyxjURFA==
X-Gm-Gg: ASbGncv3KmtBaOATxak56kdASpMkWIasv1bIAM/L5Oj3hFqDQu7+9/8S+eNoMY9EC7U
	9YykQ1fXcisDiK5wqIxQ748Au4OI1O8gui1eqB9+/k6fbqC1Ci55hPnflkQQaHctccEc42XzXKS
	mdxj1kpXztXcm7xTaEkMssRWMu42o5w+XEVahKoBq36gxcmYcQyvLBpJFOuqgcyxwWW5WfCOTiy
	QwV5yBjvJizZ4l5rZbLR5de4Isp1itpxJFKKr+TWCnqyhoykJ7xJ31edWr2PyFsXFUUfpqdChsd
	XfECHJyscfxPwQz7wC9kkhz7b82khae6075i5THvnPx4FdVDhotJnIOq0XKrOvTQsLSmrMIA+iB
	+lgKQBuVu9FhZHqyn0VZI1oTYKuMVWG9P
X-Google-Smtp-Source: AGHT+IF6T5PJaLoAOGxUmcqIfeeZRaSySTl2WRNi3/6OpG31KSzDrfitRxWX/mjS2qmW0U+/CIdQsw==
X-Received: by 2002:a05:6a00:1912:b0:76b:f23f:6591 with SMTP id d2e1a72fcca58-76e1844e4c0mr767224b3a.6.1755006021810;
        Tue, 12 Aug 2025 06:40:21 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa92sm29618675b3a.45.2025.08.12.06.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 06:40:21 -0700 (PDT)
Message-ID: <757932d2-50ae-4e7b-93df-121199cda023@kzalloc.com>
Date: Tue, 12 Aug 2025 22:40:15 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf: Avoid undefined behavior from stopping/starting
 inactive events
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Austin Kim <austindh.kim@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
References: <20250812012722.127646-1-ysk@kzalloc.com>
 <20250812075656.GE4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250812075656.GE4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Thank you so much for the code review!

On 8/12/25 4:56 PM, Peter Zijlstra wrote:
> On Tue, Aug 12, 2025 at 01:27:22AM +0000, Yunseong Kim wrote:
>> Calling pmu->start()/stop() on events in PERF_EVENT_STATE_OFF can leave
>> event->hw.idx at -1, which may lead to UBSAN shift-out-of-bounds reports
>> when the PMU code later shifts by a negative exponent.
> 
> Yeah, but how do we get there? I suppose there is a race somewhere?
> Please describe.

It appears to be an issue in how event groups handle throttling when some
members are intentionally disabled, rather than a race condition.

Based on the analysis and the reproducer provided by Mark Rutland
(this issue on both arm64 and x86-64), the scenario unfolds as follows:

 1. A group leader event is configured with a very aggressive sampling
    period(e.g., sample_period = 1). This causes frequent interrupts and
    triggers the throttling mechanism.

 2. A child event in the same group is created in a disabled state
    (.disabled = 1). This event remains in PERF_EVENT_STATE_OFF. Since it
    hasn't been scheduled onto the PMU, its event->hw.idx remains
    initialized at -1.

 3. When throttling occurs, perf_event_throttle_group() and later
    perf_event_unthrottle_group() iterates through all siblings, including
    the disabled child event.

 4. perf_event_throttle()/unthrottle() are called on this inactive child
    event, which then call event->pmu->start()/stop().

 5. The PMU driver receives the event with hw.idx == -1 and attempts to use
    it as a shift exponent, leading to the UBSAN report.

The core issue is that the throttling mechanism attempts to start/stop
events that are not actively scheduled on the hardware.

>> Move the state check into perf_event_throttle()/perf_event_unthrottle() so
>> that inactive events are skipped entirely. This ensures only active events
>> with a valid hw.idx are processed, preventing undefined behavior and
>> silencing UBSAN warnings.
>> The problem can be reproduced with the syzkaller reproducer:
>> Link: https://lore.kernel.org/lkml/714b7ba2-693e-42e4-bce4-feef2a5e7613@kzalloc.com/
>>
>> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
>> ---
>>  kernel/events/core.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 8060c2857bb2..c9322029a8ae 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2665,6 +2665,9 @@ static void perf_log_itrace_start(struct perf_event *event);
>>  
>>  static void perf_event_unthrottle(struct perf_event *event, bool start)
>>  {
>> +	if (event->state <= PERF_EVENT_STATE_OFF)
>> +		return;
> 
> This seems wrong. We should only {,un}throttle ACTIVE events, no?

You are absolutely correct. Throttling should only manage events that are
actively running on the hardware. My proposed check <= PERF_EVENT_STATE_OFF
was too permissive. As you pointed out, we must ensure we only attempt to
throttle or unthrottle events that are currently active.

I'm going to make changes and test it, before sending the next patch.

+	if (event->state != PERF_EVENT_STATE_ACTIVE)
+		return;

>>  	event->hw.interrupts = 0;
>>  	if (start)
>>  		event->pmu->start(event, 0);
>> @@ -2674,6 +2677,9 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
>>  
>>  static void perf_event_throttle(struct perf_event *event)
>>  {
>> +	if (event->state <= PERF_EVENT_STATE_OFF)
>> +		return;
>> +
>>  	event->hw.interrupts = MAX_INTERRUPTS;
>>  	event->pmu->stop(event, 0);
>>  	if (event == event->group_leader)
>> -- 
>> 2.50.0
>>

I will send v3 shortly with this correction and an updated commit message
detailing the root cause analysis above.

Thanks,
Yunseong Kim
