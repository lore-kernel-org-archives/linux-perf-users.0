Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F03101DB
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835767; cv=none; b=Y6Pk9cUHJ2KoG95l8xfehm7nHtAiL1RRhq05VCJ1KhSDZU6iMS6l6PhtTp8AX3Mjpy3R8762hPTPLa/l1jkaDBJBLJ+E7ZZiWQ6xY/lUmY8QrjQf07FO21OXzAvso4UhgDaDgXk46b56mWPKBW+UwddK3ks7eUTyIe3MWwkujzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835767; c=relaxed/simple;
	bh=RFP5ziETacBHU4nwtUFpWlsU+zU2K5pk97QONqpaA54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3pkEEG21gfkf3Rm+3OjgrQpu2ITzFEzPR99a9GmCgFjWXHgp3PitmdIqPSbhIw0SEmW2/KIhhrkUwZuwUODQGOl3dQB7VzoWyxJaRJ2IX4YKNQOAbGOsvdzEErctUVb3WjX7/C9CFeR4Rtu8zQWAql3bhTHk0CNj+qjD2c6qKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/TTpzDH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/TTpzDH"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2666284f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768835764; x=1769440564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFT4jUUaZz57bS1dfTSRz5ITsUWUla9JgvhGvj2LyF4=;
        b=D/TTpzDH7Z9DSBz2Hyo2DICzAx9Ch6qyWqOlFX8az8bcB0W1ZJVolnYDjOA878VN0R
         uTP++hM2l8oNwRAGgKl39LC3RVTE5C3lszO4h/QGGd0pQSx2UhZ4hi0UG33JOFXQA6A7
         N3EKARxFZ9Ux/wfaD08zw2W/Y82pu1HYRCXfYZeKa8yNabkLkVGBW/XQxOi5dz4jx/Z4
         r7JYoS4KP2KSGrNj0ldH+mrrSIb4WQPtg5jHCjueKO3PyEDNKWGBktNvKuiLj8c3t3WI
         WBfxqsWj5TI3zgLavdpA83cKkBq7Vq1Z3LtYyIghpHDULt0Zov/DKGYyX1YgREfv8ZcB
         MU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768835764; x=1769440564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFT4jUUaZz57bS1dfTSRz5ITsUWUla9JgvhGvj2LyF4=;
        b=f/q1D1BOvsoWs+W/jfVL8dTBAtcJd0u2+nCpsoASZuu7dzeaLyi7FentCrfv5TcIF4
         lFwAOVyxL5U16f7K8Osu2PQCT7AF+hOqzBO7F2cgxmfzE6glpb6ZOW5mzCbr3BMRMkwx
         2PnpXb9PhT6mUMl2XjG0esvL+aSb/Z6cAJ1UuJssBGg6Rpbt1Qn3pmAixSpH4MOnIaer
         M3UolC8+2f+h9pC3SdkgoTT4EddMVtUF+ScBKWxDo0jYc0Ae1NpjRD3dozPpA+PHqNrx
         BNOlcVP6JXy1VMbJSYzHTPYI115kLKv3jfH6OexhrNumNH7ACbbsj4UVxAgz6fz4m/bz
         a5qg==
X-Forwarded-Encrypted: i=1; AJvYcCXhEpb/izLRvQ0qqmPQyiKfnuaTcYsKbIe4Y6/KlOOsJ01s8BKWoNkE4FC60ockRgCxuniy0NDEECoMxhwpkQZf@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKmNPdawvOSvz8rnCXFIkb6uqpspNuhnvUZpryRNEucBwmawm
	FRaLI0bCwdG7noM+ZxkTXNdqhOEKP7o3NsMeyBPCMP9i5rimmC2IukILblWIaTyv+yI=
X-Gm-Gg: AZuq6aKjcIWY1k81R9mh+8HH50o6fGT5NuRKhIpM5c5IFI1Ug9o8jBZmKn+tsa7fj3z
	LMmUJOY1zfjBY0c+zyHvJ96y6VkBq/hn4cTG+KzFwiedXUwxaUJi+GXk3t9WFQLsCkWjRCmn8J6
	6Tk4iNmz+Y5RqQg/xQ5g3Snn3Kh6trzH9OXqlaf2WAN+V3qa2o13ZPaDyuPJzNCOzO42eUq10sT
	1LBXgGvcwfc880GDuubca0efKKlTrccUhExutSCkSR8KGUYY/Ns1ayUSwodr+0m6nGKnSPdG6Xz
	RIjXsNDQ6/SJSFreoKkfOzjDjPo2QGjThcYhPJrLDaWBvZTLfT+veXYoeKNQh5LKAtYXs2kXyod
	8nnF67cZKGLF+d/vkcGssbt3Ea1o46mLdiCkoWSQLLlvLXwdkOwspT576exDRQPuEjYd/G2F8V/
	oU3LumWSALMZ4TijX1
X-Received: by 2002:a5d:64e9:0:b0:432:c37c:d831 with SMTP id ffacd0b85a97d-43569972cd7mr14273632f8f.1.1768835763612;
        Mon, 19 Jan 2026 07:16:03 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569926648sm24570224f8f.10.2026.01.19.07.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 07:16:03 -0800 (PST)
Message-ID: <dd9a3cde-ea9f-4c53-b537-f15767bf4d99@linaro.org>
Date: Mon, 19 Jan 2026 15:16:01 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf cs-etm: Fix decoding for sparse CPU maps
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
 <20260119-james-perf-coresight-cpu-map-segfault-v2-1-56b956a629ee@linaro.org>
 <20260119111509.GD1286628@e132581.arm.com>
 <3b06ea25-2516-406c-8b78-c359d3fb2aa6@linaro.org>
 <20260119145337.GB2732125@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260119145337.GB2732125@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/01/2026 2:53 pm, Leo Yan wrote:
> On Mon, Jan 19, 2026 at 11:55:53AM +0000, James Clark wrote:
> 
> [...]
> 
>>>>     0 0 0x200 [0x90]: PERF_RECORD_ID_INDEX nr: 4
>>>>     ... id: 771  idx: 0  cpu: 2  tid: -1
>>>>     ... id: 772  idx: 1  cpu: 3  tid: -1
>>>>     ... id: 773  idx: 0  cpu: 2  tid: -1
>>>>     ... id: 774  idx: 1  cpu: 3  tid: -1
>>>
>>> Seems to me that this patch works around the issue by using the CPU ID
>>> instead, but event->auxtrace.idx is broken.
>>
>> I don't think it's a workaround, I think it should have been written this
>> way in the first place.
> 
> Agree.  Sorry for confusion in my rely.
> 
> [...]
> 
>>>> @@ -3086,7 +3086,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>>>    	if (aux_offset >= auxtrace_event->offset &&
>>>>    	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
>>>> -		struct cs_etm_queue *etmq = etm->queues.queue_array[auxtrace_event->idx].priv;
>>>> +		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
> 
> During decoding, cs_etm allocates its own AUX queues and needs to
> convert the AUX records into a cs_etm-specific format.
> 
> For example:
> 
>    event_id=405 idx=0 cpu=0 tid=6673
>    event_id=406 idx=1 cpu=1 tid=6673
>    event_id=407 idx=2 cpu=3 tid=6673
>    event_id=408 idx=3 cpu=4 tid=6673
>    event_id=409 idx=4 cpu=5 tid=6673
>    `            `      `> CPU ID
>     `> Event ID  `> Generic buffer IDs
> 
> In this case, I deliberately hotplugged off CPU2.  As a result, the
> buffer IDs are consecutive from 0 to 4, while the CPU ID for CPU2 is
> missing.  When adding AUX records to the cs_etm queues, we need to
> convert from the generic buffer index to the corresponding CPU ID.
> 
> So the above change makes sense to me.
> 
>>>>    		/*
>>>>    		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
>>>> @@ -3095,6 +3095,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>>>    		auxtrace_fragment.auxtrace = *auxtrace_event;
>>>>    		auxtrace_fragment.auxtrace.size = aux_size;
>>>>    		auxtrace_fragment.auxtrace.offset = aux_offset;
>>>> +		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;
> 
> I am still confused about this.  Because above auxtrace will be queued
> on cs_etm queues, should we convert from the generic buffer index to the
> cs_etm specific one?  E.g.,
> 
>    auxtrace_fragment.auxtrace.idx = auxtrace_event->cpu;
> 

This is basically what the change is already doing. etmq->queue_nr == 
CPU because cs_etm__setup_queue() is called for every CPU up to max_cpu, 
not only for ones that were recorded so it has a 1:1 mapping. Using 
etmq->queue_nr also works in per-thread mode where queue 0 is used, 
which your suggestion doesn't handle. Otherwise they would be equivalent.

To be honest the whole decoder has become hacks on top of hacks. I think 
we might want to do a full from scratch re-write when we come to do the 
proper timestamp to MMAP event correlation or the change to not keep 
resetting the decoder for TRBE wrap mode.

> BTW, if my understanding above is valid, it is good to go through the
> cs_etm.c file for the "idx <-> CPU ID" conversion.
> 

Do you mean there are other mistakes? I did check the rest and did some 
testing and didn't see any issues.

> Thanks,
> Leo
> 
>>>>    		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
>>>>    		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>> _______________________________________________
>>>> CoreSight mailing list -- coresight@lists.linaro.org
>>>> To unsubscribe send an email to coresight-leave@lists.linaro.org
>>

