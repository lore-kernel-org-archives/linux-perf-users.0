Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179EC21A95D
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849137; cv=none; b=jxrLVt2YXrFkgL2GrQv1KHk+eEt/h1e5vczmzM3VX6ljjgMeE1lSnkoJapMDHhfj3wutZbXaDl2c028t+XNZnpa7P/5R865++cq6lOhqoPgpDqqjnOs1KMDdvi3XfENI+RhY2rylxO+xzB3fdPkMb7ep1/iLVuwLjKlFNZ8eI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849137; c=relaxed/simple;
	bh=MpQKr6WJ0E14zMB4IHoxD4bOXR4Vx5vL2Tf1Uqw9fZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfetuCAB4fIdFNLokIqoc2oOX6JCbQXd34zvH7kpSE9a/nJGLL3v+NQ9WsbORjibvD6T6HfrTCcu2lWhxfJGZeqQJi8tRdfxpg6zCATuu14gnlsEab0esSIPOHoJ5WrLP7AMRtTjkmXSkjaRgJovjwzFsH9EhdwqUKcqNopYTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NyL66nJi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyL66nJi"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45297094718so7311380f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778849134; x=1779453934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwFlG7n8P0H64egXIGqnDFtI+u0Yj8dyS9lbJHI4qsI=;
        b=NyL66nJiQFLDSdyurFMqOFfoAbj9jrjGaRKG8Q1sbBTNvn/lmbQxCjlVZZ1B7UQ/Ep
         AOXadrEO9mwg0mFcTwbzvNn2NKaTDxNjY2wa65VJpbQXrhhP3NRVCIofw2CN1RLMWjZp
         C6ok79t+TdaWaQT7gT4iBdj1Pa6+6uu1NjIJKz5hZKVmOgB3mgmFLzInZVvgVQX6KuUJ
         WIpIs+5fS5YGV/RMI61oR3dm8w1AYBtaMYu+umPYvZLa67NsqmyicOdDWHv70QmYRWvi
         iEZIXaYFxvGUCTSRQQQLkYuCKSdteHQe2BvDgFBcyJ0t9SDwAJ7YW2CpjaLElx3T2jWN
         LccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849134; x=1779453934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwFlG7n8P0H64egXIGqnDFtI+u0Yj8dyS9lbJHI4qsI=;
        b=EWr3tUxMCii4qd/k+EFFUDgEw1e0LM3qJVGcMWb6ca8BKol/RoonITO90UNEz+6Qrn
         frhBdhoZMu9/D8ZOd7hIGRvtqqn5EyMw1Ge72DkmGVVZ38tNBuisxWlf9HkIqg/nb9kb
         gsnb7sHEFFuAGiSU1LrThVWN2RYdA9MlrcZO/rsBenLst5j4GDZbFYbGmEWIOnlo1GJD
         niiQnKpd9b0Z4wvluuRm3TrPAwcbjDV/3DTpTTXUnNKvp9bitqifbbPmk6jkuhN78mk2
         n3I8gbjmchPYbuMFPZGV2QtHs2JJL39w01pndgfJTFvxWWUtcOsNZWdH4kV85J0Qf+J8
         om9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9z2y+CfjqkWFc/leFCsxpBywTRp1yTjuqYYjw1Zk0QTIRVd7eqPm8RdmUNhm8NFeFjWDkWHViPFGjGO3NGxSOI@vger.kernel.org
X-Gm-Message-State: AOJu0YzQncr/sWYhBu7fpy5jml/f6d+hxysnfgAxwhYDRhN5Wi1ENaOG
	yEn6TPBFu5s9cWt2SBGUkkuQLlgr5I4OjRe59vbJ2GCQHj4mfThH6SJ8Ixy216z51U0=
X-Gm-Gg: Acq92OF9KcskfjKlWi6tSu2jV17V4yj/nUBbhsWmhGfOKjZ0i7q2fIh7exzRdQEgflH
	w1uJMiukSastqnSqih9rftmmX98blUxs1/glJK7zLX16VLD/LTkyDakFqsUTpGtYk1KjUVTSS40
	eLJbWgIcrbfvJ2gAGWrpiPz7w6+xOBFmDnY0zxyBHIZJrQAY6QlniZiK7p9XeFuvTbZHNA4C4Hp
	1Yl7HnuKIif7h8wr9RaQJa/XqR2RKPXlM0oH2EKjCQ3dLpPSi88vfch/pUoYNtn8f7Fz8GTJiyc
	bazrS37BK9DOHzgt/oKIWmD4AuhoSXPdFFJUk0faHnHDWTb0dzzWJjPwDci7echIIuPjXVo2/s3
	JzZ8hiAyjpEPTxluPj58bS4NAxVjQ3nX66LhMcTC0C4PfvGM8Bot56VR6srS+t3rI1CMhyvQdR/
	8EQPT09ywTo2gZKWcX5Mud1NboHJOVF9euFYvRHXk=
X-Received: by 2002:a05:6000:22c1:b0:449:a07a:9676 with SMTP id ffacd0b85a97d-45e5c59ec63mr5077427f8f.29.1778849134441;
        Fri, 15 May 2026 05:45:34 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9adc2209sm12916937f8f.0.2026.05.15.05.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 05:45:33 -0700 (PDT)
Message-ID: <55ae9472-230f-4348-9f12-a25ef33321b4@linaro.org>
Date: Fri, 15 May 2026 13:45:32 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/core: Fix missing read event generation on task
 exit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thaumy Cheng <thaumy.love@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Mike Leach <mike.leach@linaro.org>
References: <20251024170543.11201-1-thaumy.love@gmail.com>
 <1e6337ec-d4a0-420b-bd7b-0fd2b6fee620@linaro.org>
 <20260206152907.GQ1395266@noisy.programming.kicks-ass.net>
 <61e544ab-d9b9-454e-9dd7-65625d9be126@linaro.org>
 <20260303142948.GA3698720@noisy.programming.kicks-ass.net>
 <f0a5192a-7b6a-4c51-87e9-fc1dbf4d37df@linaro.org>
 <20260304152316.GO1395266@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260304152316.GO1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/03/2026 3:23 pm, Peter Zijlstra wrote:
> On Wed, Mar 04, 2026 at 11:26:10AM +0000, James Clark wrote:
> 
>>> @@ -14564,11 +14556,21 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>>>    	 * won't get any samples after PERF_RECORD_EXIT. We can however still
>>>    	 * get a few PERF_RECORD_READ events.
>>>    	 */
>>> -	if (exit)
>>> +	if (exit) {
>>>    		perf_event_task(task, ctx, 0);
>>> -	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
>>> -		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
>>> +		guard(raw_spinlock_irq)(&ctx->lock);
>>> +		list_for_each_entry(event, &ctx->event_list, event_entry) {
>>> +			if (event->attr.inherit_stat) {
>>> +				if (task && task != TASK_TOMBSTONE &&
>>> +				    event_filter_match(event))
>>> +					perf_event_read_event(event, task);
>>
>> Doesn't this only work if you happened to have an event opened on every CPU?
>> Otherwise you could get rescheduled onto a core without an event and the
>> event_filter_match() will fail and you'd drop the sample read for that exit.
> 
> Yes, absolutely. But that is more or less what you get.
> 
> So perf has per-task buffers and per-cpu buffers. For a simple per-task
> profile, the per-task buffer works fine. However, if you want inherited
> tasks, they can't all emit to the same buffer -- this would be a
> scalability nightmake. So in that scenario you have to have
> per-task-per-cpu events and make sure everybody emits to the local
> buffer.
> 
> If you 'forget' to create an event/buffer for a particular CPU the
> task(s) can run on, you loose events the moment they end up there.
> 
> There just isn't much you can do about that.

Hi Peter,

Both of the diffs you posted above work for me. Do we need to do 
anything for revoke? It seems like a bit of an edge case if it's only 
for removing the PMU so could probably be left out. Or do we make a 
similar change to __pmu_detach_event()?

For remove_on_exec, I put the same loop in perf_event_remove_on_exec() 
and I think that covers it:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 87712491f4c7..d152abcafe5a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4683,6 +4683,16 @@ static void perf_event_remove_on_exec(struct 
perf_event_context *ctx)
         if (WARN_ON_ONCE(ctx->task != current))
                 goto unlock;

+       raw_spin_lock_irqsave(&ctx->lock, flags);
+       list_for_each_entry(event, &ctx->event_list, event_entry) {
+               if (event->attr.inherit_stat) {
+                       if (ctx->task != TASK_TOMBSTONE &&
+                           event_filter_match(event))
+                               perf_event_read_event(event, ctx->task);
+               }
+       }
+       raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
         list_for_each_entry_safe(event, next, &ctx->event_list, 
event_entry) {
                 if (!event->attr.remove_on_exec)
                         continue;


Do you want me to send your two diffs as patches with you as an author? 
Or will you take it?

Thanks
James

