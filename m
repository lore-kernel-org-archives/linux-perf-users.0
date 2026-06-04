Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59648477E2A
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577176; cv=none; b=Wstqcu3Za0IBh8XK0CzUJ0ShOdDKC/R6glAm5DsKZvAgebHo0kIgLYJhxngLnYxbVhp4nQYObZp2NNy/UOtgtKNIwLazhSONCygMP+ty8nMVaXzU/C6X9a4zu1yCxKhM/nr/rRZ3OHJ5GvZclaieI+tupkLLaXoDayvdPoMa49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577176; c=relaxed/simple;
	bh=LRtadUmB8iW5U3+lyUIKXngJGb8N4NhLMSSMPsBj5ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRXCTOhILibG/3SrcuzFQ51wX/mm8KAx4X6M2o6wHS6Ij5untfmwqKpAFvPNTVL8qB5JxB14I0slpzlACdWmi+kRHK9PwWrNgPVu0lINwd84goNk7vveATQKjJil0Zwk5wujzitRZb84lvZjMFlQxSeEjJNy4hHEIeCGLY/MSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=awTsnreL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awTsnreL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b3e03939so5772075e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780577174; x=1781181974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8L6wxZtCAQTGBF5p67+Z/vLXWJAdDinu+/qJ39j5po=;
        b=awTsnreL+XRZoWWa8jScgZWh3c9EjV9fLYm4gSeVj3NV5Ypris8Rh1cfw35S1O4g/w
         WvlFFBLp+Qmm5WVfHMgfRiF1fE6OtgU6OJLN3drlIei3UIBBTGqZUzxmKKCOmO6qr71Q
         k7MslCnSKtHeDZ6/GlkIxOdBWBzv1pwt7R1epfxQVUEHzrf7B0pqBVp857DEgSbw519x
         kEsNyUNZQZY2ISECcevRv1dfYrW5kyN3+az3r6uMAtuh155jvX7U4dSkoyG83HgNxkhZ
         yb1nmCu3+R561ey/HLHeeqcsodROacqdwu3Zqcf6F+B7aXZ2jQgQmynoeOOEzpi2ORKT
         9peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577174; x=1781181974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8L6wxZtCAQTGBF5p67+Z/vLXWJAdDinu+/qJ39j5po=;
        b=YZArt2VJFTyPBIegow0vsmzc8TApiAYd0wVIXAfHCgRUjclQBozfyjwO1EMwFWYuay
         Z8TChEjw7auWaRxoJ9MJFtGS+6EaUlWhp2CLdqWUGPwrl4JueTE5Bps5zyQH1QnvQr+4
         DPWR/MKfVXHfuVJ17mXtAg6xxiaHi/xEZZQd6xUbK6/9BvXVTKLpCAmKax04Usl4ZjPi
         4+p8hvlRtcwGwzshi3KThy5nfNrvmvrnN6NZeGr3XWQBYwCtODki0rbklDspvfA/MI9Q
         1WxXg+6RixEus04T53jlpsftHF3AuJymugR8nJm0I7owQsRItf1NiNi3+M3/EE5FbDDT
         yJTA==
X-Gm-Message-State: AOJu0YyeGAFtp53ZqaAWoH/lexaISsgmlZdRn/MuIfs30GpzsF6Cf1Ha
	nxd7Y0YfQHldTsPlsSV54K2DSLR4xWE4ygKepGYuPiUSipJ6kmOZreSKnyKpoZxqjsJLuCJ5SS2
	6a/fjIB0=
X-Gm-Gg: Acq92OEiG2+OC45VL/16UCwQEzCGcQWpPIiqB58pVDNjU2iXHDoXvq28so/ogXUcUSN
	Sm6JxTHlj9rsoILheR5nrerGEDJeIpTTBshE/yYmP40BRIwHP1XDrgTKKKeXqf1QOCkbZa/33hn
	Qbax+DEyNwGQnVEs/d8QqUkTb7V20KhuPkI+yn3neQ5kELt6rEN+t5xNbEnr25XN8tnGx+Lz1ZX
	A8vg8osloTRxybku6xmX6+qcO1Hi9E7IYhIURiZmLKrWDV6FMh+87ozyugJ3HwWY7DSx6TpSgzm
	f/GytL/2W00MbnNSr1aIoj2ky4ya8ehwwI3ekzPGnJKHsQqLoKq6thgoP8d+BmZ8Tu+qlSeUo2f
	HtREEk6PU0nesSAiNcnHfbZSc5caAPAvyVQ7K+NCSjzFzp6S2+SSUlpGuRhEEw043/zFPwzDtrC
	U5X4bk6cbZEWfdodTREGPKkiWLNq8bbrLoJfOzcPg=
X-Received: by 2002:a05:600c:8b76:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-490bc4b5734mr50395435e9.2.1780577173383;
        Thu, 04 Jun 2026 05:46:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b82sm72731835e9.1.2026.06.04.05.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 05:46:12 -0700 (PDT)
Message-ID: <5889c018-8bbb-40e1-a0b4-5e9f024d27b6@linaro.org>
Date: Thu, 4 Jun 2026 13:46:12 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/19] perf test cs-etm: Remove unused Coresight
 workloads
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260603-james-cs-context-tracking-fix-v3-15-c392945d9ed5@linaro.org>
 <20260603104130.4C65A1F00893@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603104130.4C65A1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 11:41 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The function `cs_etm__synth_instruction_sample` takes a `packet` argument but ignores it in favor of `tidq->packet` for critical fields, leading to incorrect instruction synthesis.
> - [Medium] Incorrect validation of the double pointer `thread` in `cs_etm__etmq_update_thread` breaks the fallback logic and creates a potential segmentation fault hazard.
> --
> 
> commit b1b29e2b51869a73781c3576698bb30e8e7b0cb9
> Author: James Clark <james.clark@linaro.org>
> 
> perf test cs-etm: Remove unused Coresight workloads
> 
> This commit removes unused CoreSight workloads from the perf tests. These
> workloads had issues with out-of-source builds and slow compilation times.
> 
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 40c6ddfa8c8d9..ce570913669c1 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -1490,34 +1508,51 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
> [ ... ]
>> +/*
>> + * Convert a raw thread number to a thread struct and assign it to **thread.
>> + */
>> +static int cs_etm__etmq_update_thread(struct cs_etm_queue *etmq,
>> +				      ocsd_ex_level el, pid_t tid,
>> +				      struct thread **thread)
>>   {
>>   	struct machine *machine = cs_etm__get_machine(etmq, el);
>>   
>> +	if (!machine || !*thread)
>> +		return -EINVAL;
> 
> [Severity: Medium]
> Will this early return prevent the fallback logic from executing?
> 
> If *thread is initially NULL (e.g. from an allocation failure), this check
> returns -EINVAL immediately instead of reaching the fallback assignment
> *thread = machine__idle_thread(machine) at the bottom of the function.
> Additionally, checking !*thread before checking if the pointer thread
> itself is valid could lead to a segmentation fault if thread is NULL. Should
> this verify !thread instead, or should the !*thread check be removed to
> allow the idle thread fallback?
> 

Thread can't ever be NULL. It starts as the idle thread and is only 
swapped to a real threads or the idle thread again.

>> +
>>   	if (tid != -1) {
>> -		thread__zput(tidq->thread);
>> -		tidq->thread = machine__find_thread(machine, -1, tid);
>> +		thread__zput(*thread);
>> +		*thread = machine__find_thread(machine, -1, tid);
>>   	}
>>   
>>   	/* Couldn't find a known thread */
>> -	if (!tidq->thread)
>> -		tidq->thread = machine__idle_thread(machine);
>> +	if (!*thread)
>> +		*thread = machine__idle_thread(machine);
>>   
>> -	tidq->el = el;
>> +	return 0;
>>   }
> [ ... ]
>> @@ -1579,6 +1614,7 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
>>   
>>   static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>>   					    struct cs_etm_traceid_queue *tidq,
>> +					    struct cs_etm_packet *packet,
>>   					    u64 addr, u64 period)
>>   {
>>   	int ret = 0;
> [ ... ]
>>   	sample.flags = tidq->prev_packet->flags;
>>   	sample.cpumode = event->sample.header.misc;
>>   
>> -	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
>> +	cs_etm__copy_insn(etmq, tidq, tidq->packet, &sample);
> 
> [Severity: High]
> Is the correct packet being used for instruction synthesis here?
> 
> The function signature was updated to take a struct cs_etm_packet *packet
> argument, but this line explicitly references tidq->packet instead of the
> passed packet. Since callers like cs_etm__flush() and cs_etm__end_block()
> pass tidq->prev_packet as the argument, referencing tidq->packet here will
> use stale or incorrect packet data, potentially corrupting synthesized trace
> data.
> 

Will fix.

>>   
>>   	if (etm->synth_opts.last_branch)
>>   		sample.branch_stack = tidq->last_branch;
> 

