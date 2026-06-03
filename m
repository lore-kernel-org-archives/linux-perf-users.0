Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5E395DB9
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479478; cv=none; b=TPD3WGiXtUz6UGJFv68dy7UNkI6OySr5YPqaB9j4WyOFs2/2zTxJHdN8C00siD78P9Z5hUKoMJTASTUZ8mXTng1nDOm+SLZRzpm0YgrTCsld+kK7qQnl79/sshyzhcFcE8/f/mL0riaF49iG+vl0tPakmGxRq8EaJsVHv7WoduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479478; c=relaxed/simple;
	bh=Np8CcBZEhxg2O4ydf7MKMA0wb/gJykr9B13bJRf7pck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaniUZh1nzzTZTsZZ8W0Tw89z9misVckCgQNOtvRzvc6ObgPoGwUrtg0IKEyOJQ0QieHygNBPWxfAo0Hmm0ejiYCyp2c03CXafK19YWwx3OW7PYoUPn6NGL7IipjsoMHqKOZMbK4ZAXY5/HkWZC2r9Zw9NdeqVVR1VtVqw5SnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j7J5miMA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7J5miMA"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so93941265e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780479476; x=1781084276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPpoGYNnw0et0ze4rIG/H+2lI0/pnXo68Q/0mJto/k4=;
        b=j7J5miMAuD+FTItruOd5alWPwRwp6YWje97qJT3635lowrA1P+f/npT+t9v9PeZeWA
         2hOfa9OuX8kgpH5xkdUVRGG4Uqh12Rbu629BGOECwmlZWVArnzkSL78w0kXg8c4kl+J3
         LrLxU+AuYAzsG0ibGKGyjjCa7PX6S+yePS7mSthjqXk1p9kin3poQF6HmPVnAGvK2snr
         fkkfb4+P04Bklg/PWFJq32vpS1sqSaFkY7+1Dmd4ueDDKU0UyMZV8RxkyjuSzgvNuBs/
         u43u5CbuQfdhMlh5UfILLgQwSYh5PBT0Wph4Q7tV/VwrNtXQ6LkUx7+MWCI5riz9S9MM
         lKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780479476; x=1781084276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPpoGYNnw0et0ze4rIG/H+2lI0/pnXo68Q/0mJto/k4=;
        b=pxUsNL+sT0Ov16xd0hoxARZYrs84HOdhmNPo8WCg6TY8eDGplQe0nnbzfJHbGFoFUB
         y/tzPm+u+7ldCiDER2IKg7kAtg1l6k1PX1FKVfclo1409PCNblI6kpJxDdElNlYQJeqA
         BnRcU7by+dBF+xDQp9xYBfky1FLeNAsfVJylKqhTkBY5TLoaj3f38jf6H1aJ1VZlipGg
         tan9z1ukXMdUWUPrc2N3ShpgeXmY6s+eKw92bRLqDZOgDXQhVYMFayOXcVPHcxiuoix0
         qFsaerfE620Lk2RYvMBV7PtF41UgacZLd8o5tL1FgS8ZNJomjHkOjHSbVF6fs776xm6w
         c0RA==
X-Gm-Message-State: AOJu0YzwnH7pN+jvBzPDRQhF0Sb1l+52hk3x20Gt33DCFYC3NC1GMvsJ
	tOTaHEdv97Khn2cgC0uNzdQclPMQ/Y1E/ODdJPQod91p3vNEqJjH+QG+CLYE1Zmzj38=
X-Gm-Gg: Acq92OFr2eDU1DI3gghcMtAAHSeTNfmKZyuw9rnZ2CWV/pNGDv9J3bKQr/HKGtYsq4g
	UnecQ9sYBNKCiaHklvjap0Fn8Z0n3IzhosGChl0JCCvw48BgGsBit1NCI+pkrB+vKt8y20Nbesr
	aWnp54xz6yMPV2d7MZ2zU1TNGCste4AP3jKxaurMHFN4YPO84/7ln8fBu72qH98GY4RFsgVqldG
	eTWFSMIWWtY5xUPWRqTkONyIVKMTm8Tb8grWDgsWAg7DM+PEeYPwZjJzCjyJDl3uCpYuwhHrhPF
	qGmRHN/2pxXAf6FK+/sdHpF4C2ZnP9lDoiMafQuvBOAOdwhSwuk+AbYnSipqSrJ6rO76aP1LUUm
	0K+YDDtfKdWMA+/Eoh9srrmIZGATqcEte5aIS+conIpBNnkbnjBxc86NspnLIUuj0Nhp2qEiwNm
	AffIxs91FDdjUUsvBVY/uC6yIdJKZzdYKAJxgm5e8=
X-Received: by 2002:a05:600c:c4b8:b0:490:b189:212d with SMTP id 5b1f17b1804b1-490b60e41dbmr40643465e9.33.1780479475988;
        Wed, 03 Jun 2026 02:37:55 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b6150bfcsm87868605e9.3.2026.06.03.02.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 02:37:55 -0700 (PDT)
Message-ID: <d0f5c130-91a3-4785-8509-81aa54b6ca87@linaro.org>
Date: Wed, 3 Jun 2026 10:37:54 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] perf cs-etm: Queue context packets for frontend
To: Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260602-james-cs-context-tracking-fix-v2-1-85b5ce6f55c6@linaro.org>
 <20260602144329.A5DFA1F00898@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260602144329.A5DFA1F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/06/2026 3:43 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incorrect CPU mode attribution in `cs_etm__synth_instruction_sample()` during flush due to relying on `tidq->packet->el` instead of the exception level belonging to the instructions being sampled.
> --
> 
> commit b9c32b9ed06ee8adb88b0b63943c694b4108e629
> Author: James Clark <james.clark@linaro.org>
> 
> perf cs-etm: Queue context packets for frontend
> 
> This commit adds a CS_ETM_CONTEXT packet to carry thread ID and exception
> level to the frontend. It separates memory access functions between frontend
> and decoder, and removes prev_packet_thread tracking.
> 
> Closes: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-aaupov@meta.com/
> 
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 40c6ddfa8c8d9..524e2a6feba8e 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
> 
> [ ... ]
> 
>> @@ -1588,15 +1632,15 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>>   
>>   	perf_sample__init(&sample, /*all=*/true);
>>   	event->sample.header.type = PERF_RECORD_SAMPLE;
>> -	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->el);
>> +	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->packet->el);
> 
> [Severity: Medium]
> Does this misattribute guest traces to the host when synthesizing samples
> during a flush?
> 
> When cs_etm__flush() or cs_etm__end_block() calls
> cs_etm__synth_instruction_sample(), it generates samples for the execution
> range of tidq->prev_packet. In these scenarios, tidq->packet holds a
> CS_ETM_DISCONTINUITY packet (or a stale packet) where the exception level
> is ocsd_EL_unknown.
> 
> Passing this unknown EL into cs_etm__cpu_mode() causes guest trace execution
> from before the discontinuity to be misattributed to the host machine
> (PERF_RECORD_MISC_KERNEL or PERF_RECORD_MISC_USER) in the profile statistics.
> 

Will add a packet argument to cs_etm__synth_instruction_sample() as it's 
used with both previous and current packets. Similar to the memory 
access callback.

The only strange thing this leaves is flags always uses the previous packet:

   sample.flags = tidq->prev_packet->flags;

This makes sense for cs_etm__synth_branch_sample() but maybe not for 
cs_etm__synth_instruction_sample() but it's a bit hard to tell.
cs_etm__set_sample_flags() seems to assign to both prev and current for 
different reasons and it's impossible to understand.

This isn't a new issue introduced by these changes, so I'll leave it for 
the full re-write to fix or clarify.


>>   	event->sample.header.size = sizeof(struct perf_event_header);
>>   
>>   	/* Set time field based on etm auxtrace config. */
>>   	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
>>   
>>   	sample.ip = addr;
>> -	sample.pid = thread__pid(tidq->thread);
>> -	sample.tid = thread__tid(tidq->thread);
> 
> [ ... ]
> 

