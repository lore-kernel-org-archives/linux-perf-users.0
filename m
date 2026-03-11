Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD813C8729
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224170; cv=none; b=me0oOsUekNUQxp2FUw5E4tWvolK0E64MJ/Kfh3OzyXQubMywT27VVybnmyMcH+cO820fThEwpONyKgnH3yzzOY66IpPHb4YKwXGX0K7Kwq2ki8wZSuHJ0+b+eojKzlgseSWxjwtjuMf0pNUi6KmyPMS22cb9LIeLbARk2MiCN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224170; c=relaxed/simple;
	bh=wPOlGJegScfjGXLqN02j6e37cMLeoiGng2UniPA/m/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbVCO8wbkmlFFU82uB7bU2eBU43HKMk6w0KM4cOpBKFD8/SO1BYE2T211CwBfeS+Cy96xDizAiNjvv3RweKAv35mYBVTDZl6FhRrFa5XiOFATG/nRXv5FPbWrWyN2Bt19Jfh9gd2J4mIKW1pL+S25lWZMzFHwojvrXiUiqr65NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=POgbHspI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POgbHspI"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439afc58ac7so11243046f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773224166; x=1773828966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=traLbeCphIWDAPRf8wXsen2JdQ2Go7wYWE6BuOL/0nw=;
        b=POgbHspIGX4XQfy2d2Wdh4cQcjoLeEiTozxq6PIqEagqreaR9ipnXBSw8FM7F5SH6g
         iXwfLC8QdxUVEpfnIIs5TjBVqRfenHQ10KnL0iCmPoRKhaWa8YG1wpAug50Tisv+iHPg
         ltET8pumrh1JZ+EM2NZNWM4RYtYL+Ye5Pc+BoPScUPMLu7rdtZQENa0ZgyH/D6EgWdb+
         cc9syNp0hbrUWPvmpb87HV6WDApJLATjBGbub6PJWKOwgDalTCyxNzzQWJUeqbPWYc68
         DmkGpd0I+rTb48kEtZlxp9s3cmpG84Bdg9SokdB+flQKRKYcz5iOWCALYhAs2R8FGKF1
         /Gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224166; x=1773828966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=traLbeCphIWDAPRf8wXsen2JdQ2Go7wYWE6BuOL/0nw=;
        b=Jr91YWEhxBT8nAxhy965poncg9/TcjLGvjCQQxgFL/7fI3o103naFrEzGrAglCWBq4
         AVhPU4g3gwypUXrrM8ZBgOyWtn95+aiikxGyHTg6NFjFWPDu91XFWDUzSBCYvdw1TuS/
         509S21N+rDJHMa4n5UMLyuK2Bm9gtnbcowOcA2BDbB2gy6bNUII3HZkZo6PLmPyyCD6x
         7yLB8XzLQDMhe2r77nuBTvrrjEn3vZy6IooILnNLAo2e/HC+Xht4sEk7aKl8/+sTNlsQ
         wklp7n8LTtYYXkCyuByAxQEGwurorBEGB8E0KFVVlBi1n0I0Ybote3J7c3V0ctJ0v72S
         oVyw==
X-Forwarded-Encrypted: i=1; AJvYcCXO0K2kfPHGNBmJ26G2FvlJubYnbnDGC3IP3FadLQXGyjyAx2vbXlD0CN82DoAxLf8eVuxvhOXnpxc3PD6tvLBR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+il3q7348qt+M3/yeX2tE+l//4hMjEoiD7W72wnDcTz8tTNTO
	r5/zHZLlZnKDV0cTfJKP7yV7I2tVB+xf5EOnRirIvL/NjePH44l4/5wHHPpshIIvL3c=
X-Gm-Gg: ATEYQzzTqXnyyj2BRUsRTGz7vJAmSXoilxycSuwNQtxrZixbH2T3W3bmFvrJHy9AUP4
	Hg0YhsWN/4UgUha5zdrAYwdJkVAuqB9kkPARWN2Ng+nDSnF+nWfnVuOaWxwEXKQMUBy0v7egze9
	/+2NPdWqi5O+a1l0xs6d/72BD3SpnR4hTMM9+lWHMH85j9hG2lF2OIPG3lEGMK59MdmW8+DWXqt
	QF9X0iTVZ9c9mQ6CNFI+rZoqNLrI0wNXgnkHY4DoRhRipnt5+1quIt5GSGxsW75boXH01wGN8Hb
	v4k3XtleUv3I1C7ZJpO3YS61DyQXdxylRtaKMQXUUctnoLQC7GC2H6aX06YTzczaDkBAH9FO5TB
	QwP8E9VnvRJV29CjJAr+z3zbgp3SdX7k0K7ZBFc4CxKbMvcmZLJBSXdlVZLEz+X9DeJG6svloJk
	0o10HqBu36y0YlOEx4wep3OEEMEmcK
X-Received: by 2002:a05:6000:228a:b0:439:b7c9:2ef1 with SMTP id ffacd0b85a97d-439f81c639bmr3834639f8f.20.1773224165981;
        Wed, 11 Mar 2026 03:16:05 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a0480sm5386398f8f.12.2026.03.11.03.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 03:16:05 -0700 (PDT)
Message-ID: <70621066-d327-4206-9be9-28531ad136b0@linaro.org>
Date: Wed, 11 Mar 2026 10:16:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/core: Fix missing read event generation on task
 exit
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Thaumy Cheng <thaumy.love@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Mike Leach <mike.leach@linaro.org>
References: <20251024170543.11201-1-thaumy.love@gmail.com>
 <1e6337ec-d4a0-420b-bd7b-0fd2b6fee620@linaro.org>
 <20260206152907.GQ1395266@noisy.programming.kicks-ass.net>
 <61e544ab-d9b9-454e-9dd7-65625d9be126@linaro.org>
 <20260303142948.GA3698720@noisy.programming.kicks-ass.net>
 <CAP-5=fX5-fAA8exsxusktUPkvVUfzBqHyAFQMAuc7xg7_ZUJLw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fX5-fAA8exsxusktUPkvVUfzBqHyAFQMAuc7xg7_ZUJLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/03/2026 6:25 pm, Ian Rogers wrote:
> On Tue, Mar 3, 2026 at 6:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> I suppose the easiest fix is this, but urgh...
>>
>> ---
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 03ced7aad309..c38acf1e2f43 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -3664,6 +3664,9 @@ static int context_equiv(struct perf_event_context *ctx1,
>>          if (ctx1->pin_count || ctx2->pin_count)
>>                  return 0;
>>
>> +       if (ctx1->nr_stat || ctx2->nr_stat)
>> +               return 0;
>> +
> 
> So, just for fun, I ran the original patch, James's bug description
> and this proposed fix through an AI using Chris Mason's kernel review
> prompts. I'm sharing the output as the do_exit comments seem
> legitimate given the stack trace in James' report.
> 
> Does this introduce a significant performance regression for multithreaded
> workloads? By forcing a full sched_out and sched_in of the PMU on every
> thread switch instead of just swapping context pointers, it removes the
> performance benefits of context_equiv() for inherited stats.

inherit_stat isn't default though. I suppose if you ask for more stuff 
it costs more, and I assume complete data but slightly slower is better 
than incomplete but faster.

> 
> Furthermore, does this patch actually address the concurrent ring buffer
> corruption reported in the bug?

No, the top patch fixes that issue, not the bottom one.

> 
> The corruption occurs because perf_event_exit_event() (called during do_exit)
> invokes perf_output_begin() on the parent's ring buffer from the exiting child's
> CPU. Because ring buffers use local_t operations which are not SMP-safe,
> concurrent child exits corrupt the rb->nest tracking.
> 
> Since context_equiv() is only used during context switch
> (perf_event_context_sched_out) and not during task exit, modifying it does
> not prevent the concurrent ring buffer writes during do_exit.
> 
> Thanks,
> Ian
> 
>>          /* If ctx1 is the parent of ctx2 */
>>          if (ctx1 == ctx2->parent_ctx && ctx1->generation == ctx2->parent_gen)
>>                  return 1;
>> @@ -3677,76 +3680,13 @@ static int context_equiv(struct perf_event_context *ctx1,
>>           * hierarchy, see perf_event_init_context().
>>           */
>>          if (ctx1->parent_ctx && ctx1->parent_ctx == ctx2->parent_ctx &&
>> -                       ctx1->parent_gen == ctx2->parent_gen)
>> +           ctx1->parent_gen == ctx2->parent_gen)
>>                  return 1;
>>
>>          /* Unmatched */
>>          return 0;
>>   }
>>
>> -static void __perf_event_sync_stat(struct perf_event *event,
>> -                                    struct perf_event *next_event)
>> -{
>> -       u64 value;
>> -
>> -       if (!event->attr.inherit_stat)
>> -               return;
>> -
>> -       /*
>> -        * Update the event value, we cannot use perf_event_read()
>> -        * because we're in the middle of a context switch and have IRQs
>> -        * disabled, which upsets smp_call_function_single(), however
>> -        * we know the event must be on the current CPU, therefore we
>> -        * don't need to use it.
>> -        */
>> -       perf_pmu_read(event);
>> -
>> -       perf_event_update_time(event);
>> -
>> -       /*
>> -        * In order to keep per-task stats reliable we need to flip the event
>> -        * values when we flip the contexts.
>> -        */
>> -       value = local64_read(&next_event->count);
>> -       value = local64_xchg(&event->count, value);
>> -       local64_set(&next_event->count, value);
>> -
>> -       swap(event->total_time_enabled, next_event->total_time_enabled);
>> -       swap(event->total_time_running, next_event->total_time_running);
>> -
>> -       /*
>> -        * Since we swizzled the values, update the user visible data too.
>> -        */
>> -       perf_event_update_userpage(event);
>> -       perf_event_update_userpage(next_event);
>> -}
>> -
>> -static void perf_event_sync_stat(struct perf_event_context *ctx,
>> -                                  struct perf_event_context *next_ctx)
>> -{
>> -       struct perf_event *event, *next_event;
>> -
>> -       if (!ctx->nr_stat)
>> -               return;
>> -
>> -       update_context_time(ctx);
>> -
>> -       event = list_first_entry(&ctx->event_list,
>> -                                  struct perf_event, event_entry);
>> -
>> -       next_event = list_first_entry(&next_ctx->event_list,
>> -                                       struct perf_event, event_entry);
>> -
>> -       while (&event->event_entry != &ctx->event_list &&
>> -              &next_event->event_entry != &next_ctx->event_list) {
>> -
>> -               __perf_event_sync_stat(event, next_event);
>> -
>> -               event = list_next_entry(event, event_entry);
>> -               next_event = list_next_entry(next_event, event_entry);
>> -       }
>> -}
>> -
>>   static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
>>                                     struct task_struct *task, bool sched_in)
>>   {
>> @@ -3835,8 +3775,6 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
>>                          RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
>>
>>                          do_switch = 0;
>> -
>> -                       perf_event_sync_stat(ctx, next_ctx);
>>                  }
>>                  raw_spin_unlock(&next_ctx->lock);
>>                  raw_spin_unlock(&ctx->lock);

