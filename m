Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD633F8A3
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576728; cv=none; b=rlz1+S6P2sCqRaZsnUvPiMBLcmQHa1Ty7SNAiKZhalyS3EmPfOUba5Zc3HMOBkFvbzHrvG/Ovg2zxvT2hzhojFImWnC9ERG6qd1XUXDH7/CZno3goTpHqOYirQvp+eWrSEmIF1s1FrHcbaFjRG8PJW9L+N+JbHh7BsQMkef0v2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576728; c=relaxed/simple;
	bh=zAosgxuNfZfIFYtJ84VDAxrHnKIL33iSnw3OvFwEgYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Da4oAjO4wuh5aziO62cgr2wnDmQOmKPRKjg301KFyC3PWw8fabBsEwrsjNYfJ/SIhXUEkNjpfNlAonm4qUiPX3AmIorK16J6fK5GvgUI6PrsMPLeyJT6abIvqfPOApTVr5tHON5ih/H7vpo4s/PB1hDcWhtXk+iaLJKnNJrkzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WrQtEGRA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrQtEGRA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490a765d410so7431985e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780576725; x=1781181525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHrM3C0VvFqFQ+K+Q06MvUZ9p1FtWes5czOPusCgVRY=;
        b=WrQtEGRAH2a372yVnW5qseDgHk6dUCJ4tYKulNQkGA3Bln5DCshX/AeOEwvk+T362B
         zunX6MDuhlxy0CCV7/9MdDm/QSgTLUj5VXIlkZvmWt0OqBXo735mMNSMzmWzcHDcTV90
         h+Cx8bdP2/RPwjjyJRQRp39wlWh3Oed6rvcN9nD3y9O4HK4BBgEcnla2JnvmSJl59WqZ
         ckWD9FCb7MOe3hxTHr/aYO3cUWRdXKtrhQDI6o4pr0msByDmix4sZ2UUlzDchWboxOb1
         +Idn8/EY5vM/kCaaMqvhs/raRMYrnLAzOlerZT1TXEehAZnkzWqU4tB4Pyp7b9EYHsBj
         d5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780576725; x=1781181525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHrM3C0VvFqFQ+K+Q06MvUZ9p1FtWes5czOPusCgVRY=;
        b=QU+4kjekeSl1DE/AD8ggRcVBlBS1cqccROSOSOIrU11H8AeTByTrlMgJn36LtMmh+V
         BYF+efwtnvCZYxpn4xo5KeEaRheHWdZP1JDjzJwgAxdyPTZx1J/Dre3h2/J2rk25Ldre
         9iswcbv3Cnpx8h71jn6vsreprLbrB3NACMa6GkZfl0sG0hsViDLgA1MtXryYNqK8ohz7
         aQtdF1zXe3fKWa7CwylLztr2cQJhNOWSXOtkkfW8hk82yd2Ho85mLp+NLgOqUwm9Px+f
         ZHWWtRG9hqebUx76s38xi6Y8q5Au9ZIV2SXRL+sYzZ7aSYNDkDdv0LkOUTw5F3KurJEl
         xbxg==
X-Gm-Message-State: AOJu0YwHPfVAqP5ILX2dg9olxKiqpuNBHNE2yMHtdlLBwsekX4l/HNaj
	Od3lw0OzJyZCuIasCfLXamUtSzbJM9tYBEUGXvmKGbhVNv7u+z5Y2+nRR9k4SDbrZ94=
X-Gm-Gg: Acq92OEtyfD3ASBGvvj7HSwKcaa5tvFIpdFr8waBRiIvYHPNpeGb/kR1FwlF823u9Lu
	49qLxNQrZ7+r7quHSqozpHPJp+Mvw4RGX2JbnuBZUuoSNNTQIe35rvysHkkh47gnBeXtRNBlreT
	biQ0bDhRdZGgs8Pe2azBqYHwI5MFTjQR7J/l9p7TMK1EDzNQjq8wGDjnnpc2iJK9Dms/SazNJVq
	rf/TIlJzFs7v3u9xHicaGPgVNSUxBb5WeWFzb2u5mReL2Sfqd7XtourOomxZKvDFi9dJSVwct46
	YU6BBzKXtjFLxTGOFpoprsd+qU7HQoy5WhqXHMxRYBMI5N/MkWtlDPkO22a4sNCKmUXujWZtAbq
	2UgZnD2yaQtMYXC2cpMpD1H0cp1Y4Q96WaqzzSL0nZ+D4CxrzDkxMwTOryRdHghCST/D+JHgowG
	P5PliZwTvWEbpkbE080chrBMDBK3p931zCT9vG4Zk=
X-Received: by 2002:a05:600c:1989:b0:490:b9fe:e64a with SMTP id 5b1f17b1804b1-490b9fee832mr107016065e9.2.1780576725428;
        Thu, 04 Jun 2026 05:38:45 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm70315105e9.15.2026.06.04.05.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 05:38:44 -0700 (PDT)
Message-ID: <99fac2dd-ffa6-4c74-91d3-a075af380b2a@linaro.org>
Date: Thu, 4 Jun 2026 13:38:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/19] perf cs-etm: Queue context packets for frontend
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260603-james-cs-context-tracking-fix-v3-1-c392945d9ed5@linaro.org>
 <20260603103219.633D61F00893@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603103219.633D61F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 11:32 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Removing `prev_packet_thread` breaks branch sample cross-context instruction decoding when transitions cross machine boundaries (e.g., hypervisor to guest).
> - [Medium] `cs_etm__synth_instruction_sample()` ignores its new `packet` argument and hardcodes `tidq->packet`, causing instruction copying to fail during trace flush.
> --
> 
> commit 588f2ae34f926c74679fbf78b98515da3192e351
> Author: James Clark <james.clark@linaro.org>
> 
> perf cs-etm: Queue context packets for frontend
> 
> This commit adds a CS_ETM_CONTEXT packet carrying the TID and exception
> level to the frontend, keeping context changes ordered with the packet stream.
> It separates the memory access functions for the frontend and decoder backend,
> and removes tracking for the previous packet's thread.
> 
> Link: https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-aaupov@meta.com/
> 
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index 40c6ddfa8c8d9..ce570913669c1 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
> 
> [ ... ]
> 
>> @@ -1158,6 +1151,30 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>>   	return ret;
>>   }
>>   
>> +static u32 cs_etm__frontend_mem_access(struct cs_etm_queue *etmq,
>> +				       struct cs_etm_traceid_queue *tidq,
>> +				       struct cs_etm_packet *packet,
>> +				       u64 address, size_t size, u8 *buffer)
>> +{
>> +	return __cs_etm__mem_access(etmq, address, size, buffer, 0, packet->el,
>> +				    tidq->frontend_thread);
>> +}
> 
> [Severity: Medium]
> Will this mix the previous packet's exception level with the newly updated
> frontend thread?
> 
> When tracing virtualized environments, an exception return from a hypervisor
> to a guest causes a machine context change. The decoder emits a context
> packet which updates the frontend thread to the guest thread before
> generating the branch sample for the hypervisor's execution range.
> 
> By passing the newly updated frontend thread to the memory access function
> while using the previous packet's exception level, the map lookup could
> look up the host kernel address in the guest's map group, causing the
> lookup to fail and result in missing instruction bytes.
> 
> [ ... ]
> 

I'm not sure if guest decoding is working at all, or if this even makes 
it worse. Going to ignore this.

>> @@ -1579,6 +1614,7 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
>>   
>>   static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>>   					    struct cs_etm_traceid_queue *tidq,
>> +					    struct cs_etm_packet *packet,
>>   					    u64 addr, u64 period)
>>   {
>>   	int ret = 0;
> 
> [ ... ]
> 
>> @@ -1604,7 +1640,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>>   	sample.cpu = tidq->packet->cpu;
>>   	sample.flags = tidq->prev_packet->flags;
>>   	sample.cpumode = event->sample.header.misc;
>>   
>> -	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
>> +	cs_etm__copy_insn(etmq, tidq, tidq->packet, &sample);
> 
> [Severity: Medium]
> Does this ignore the newly added packet argument?
> 
> The function signature was updated to accept a packet argument so it can
> process the previous packet during a flush. However, the function body
> still hardcodes tidq->packet for sample.cpu and in the call to
> cs_etm__copy_insn().
> 
> When called from a flush, tidq->packet is typically a discontinuity or
> empty packet. This could cause cs_etm__copy_insn() to bail out early and
> silently drop the instruction bytes for the flushed sample.
> 
> [ ... ]
> 

Will fix.

>> @@ -1649,15 +1685,15 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>>   
>>   	event->sample.header.type = PERF_RECORD_SAMPLE;
>>   	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip,
>> -						     tidq->prev_packet_el);
>> +						     tidq->prev_packet->el);
>>   	event->sample.header.size = sizeof(struct perf_event_header);
>>   
>>   	/* Set time field based on etm auxtrace config. */
>>   	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
>>   
>>   	sample.ip = ip;
>> -	sample.pid = thread__pid(tidq->prev_packet_thread);
>> -	sample.tid = thread__tid(tidq->prev_packet_thread);
>> +	sample.pid = thread__pid(tidq->frontend_thread);
>> +	sample.tid = thread__tid(tidq->frontend_thread);
> 
> [Severity: Medium]
> Does the removal of the previous packet thread tracking break cross-context
> branch samples?
> 
> By using the newly updated frontend thread instead of the previous packet
> thread here, it appears a branch sample from the previous context could be
> misattributed to the new thread when transitions cross machine boundaries.
> 

That's not right, you can't branch from one thread to another and the 
frontend only needs to track one thread. The original multiple thread 
tracking was misguided and didn't do anything useful.


