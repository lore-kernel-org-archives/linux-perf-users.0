Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795E2F0C7E
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859329; cv=none; b=RD6uo4fAf8g87ocRIjcSM3NVKwMxG0xWHSEBy+A8x5RuB3J+HByl9kQxpkTRrYtbDwmdMioqDx4TS6LfVVbDuU27iDC0AKM6luKJL4pn6kVAsGz/C/ymJ7G8yL/cxbKghcQmrmLE7W6UW3EuaiLH9UvkR3WHW4HRXqXomnRXaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859329; c=relaxed/simple;
	bh=qoPcLQm6RddN3pDj1QW0g7pvfKX9DKJANAZC6bSxApE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHLF9Zs0Xc4LJVSNdZZBZgLewZSXADvz/Gjnjs/zkLRkp0DHCm1cr8USdISxm3pY8ahCJyKmTjQPEWpqn0SpmT+wyAoWgF5VmnSvdU7Zi+N7BfBWRP2PqR7yvtq4Lsm8XWNRn17Db799QmLU+aD1bh54uyRJ4XZlDkPZoSXVrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VhwlsHN9; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhwlsHN9"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so991437566b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790859325; x=1791464125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/uF5zNxkaQ4jQ0BkeRTJjWKsCM/+7wEmC5bJ3Bsgmzk=;
        b=VhwlsHN9sY/rlt+6KP8n5JFpblwUiVvOjHu2sDpnsQXtFF+nUccB34LYb7TSr4Z455
         qwqKPs+uJafHuhB/kDpx2NjtjYsFz/auf2l4ZUxqWLFZgnNHbbm0jCd5F2O0g+Phuhoa
         ad/Dh625vyKbePOOmtPitTTCVpHbOYCeLUHYUgAYV+vvJKj9JcSrSiIaLKiV6PGMfEK6
         nqTUbN11Aj8P383EqXn84vUN4usuJumO8vxYw94vLM5aSbXK7KEPQEw4bsLbCIGIaDCM
         STflyYla/l+HuOK0FDKB3vHb5np0Di7MpUJuqOwoX/CO0V+2ESrmXl4yfW0KsMIu4hcT
         5jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859325; x=1791464125;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uF5zNxkaQ4jQ0BkeRTJjWKsCM/+7wEmC5bJ3Bsgmzk=;
        b=ENNEqqJuMdjnH+oPLfi0ZupNQ6jtN9dNxh5tPV3c+IIoYIoOWGcv2f0q/xtomvNxdS
         YiDyxiGDFKt7+VzFPNFIVJQjWZJQIIi38N8/L1+cOqVZjP8bXddUMVdWDE6qA828G8no
         ci2kRkMe3TxBnXbewLg2crBsjB0f9rd6v5cP2IQxHauYi38cn/zl+TIYrR3KA0l4P6d+
         INy6iwL+ec+AYs+b7PdmdYcFaUB9TvD3vFOyLg8XjwEQ+nT7/qHyVdNyI91xcpr7TuOz
         9PzyKRYNoudaia2hzY+ygMQOOaXDJC1p2hwx+zThzilSwX6n//9SlKo88yP9p9kF0Dgu
         HGxg==
X-Forwarded-Encrypted: i=1; AKwUvBymO1OhN+yObqK1S0KxrFhtCJywoPOw8RzgVmAYuC4gi/b8ilffSX/iDhjq+l9wBF7IxKUfItX0TNEnHxmF53Gr@vger.kernel.org
X-Gm-Message-State: AFuF++lrum3M24uw3xxkb8QzAr8Bdeui+cWTztBLWylFhZBkNAoVGM8O
	lEJHh/UyfXovl9sps1+EenxIDXhn2TzZLXDuVFsvX8/jTzreAhhq27KCmGMqozXdOXc=
X-Gm-Gg: AYBFou32GyIf3Pcg5HFSM6W2Q0xB972rIUss0pU1JlyMKzpH9e9drZBLfuuipOK3ze8
	RRfdKDBqMDEnQdF1+/efvVVx4zaVeKI7JtCtTXskY0EE1eg/Y8kM8eAu73AOScx4JE9YyqskKSQ
	auaXh3p9TzC80Y/SS5edoZK/eZR+HQVpFuaf91W6BD/9R3E9Hz014+1dGWlgZeo+AULafZ2Fk8O
	Ac9y/N7NnAzkwzt3sSfQDBhiytpaq37MNNZ6GUtlUJlX66j5PFWjzkNVSHnJ26meMLZnQhCkfRl
	2ypKzXw/WqDzcWGiZXOjiu4ZuJfzybNK97uZn+a+0NMUHrjwTLbwkC5JZb0gJYhyVmuTYJJbJNl
	sanp/2G+mMCfy5nb997Hp2QRx9xQdPkITIh+jaf1Yc58hYTwVj6e/Pq9p9OPZzGHa8uws/r9ECF
	NhThtFKC3CRPDBvvitjMTaPqhMsMAFmTmkcxDaSXUrlew3TzyStV7Rzp9aMHSfZ5mt6F6B6OBBU
	G0=
X-Received: by 2002:a17:907:7b82:b0:c29:f5d8:9c7d with SMTP id a640c23a62f3a-c2e23d403f1mr389127766b.44.1790859325594;
        Thu, 01 Oct 2026 05:55:25 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31ce362esm150229566b.30.2026.10.01.05.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 05:55:25 -0700 (PDT)
Message-ID: <28c735f7-5d1c-4127-b748-99cdb3b48645@linaro.org>
Date: Thu, 1 Oct 2026 13:55:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] perf cs-etm: Synthesize missing HW_ID mappings for
 raw trace
To: Leo Yan <leo.yan@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Suyash Mahar <smahar@meta.com>,
 Amir Ayupov <aaupov@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-3-9d532ddabcc3@linaro.org>
 <20260904172924.GB8904@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260904172924.GB8904@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2026 18:29, Leo Yan wrote:
> On Fri, Aug 21, 2026 at 10:50:31AM +0100, James Clark wrote:
> 
> [...]
> 
>> +static int cs_etm__synth_unformatted_trace_ids(struct cs_etm_auxtrace *etm)
>> +{
>> +	struct auxtrace_queues *queues = &etm->queues;
>> +
>> +	for (unsigned int i = 0; i < queues->nr_queues; i++) {
>> +		struct auxtrace_queue *queue = &queues->queue_array[i];
>> +		struct cs_etm_queue *etmq = queue->priv;
>> +		u64 *cpu_data;
>> +		u8 trace_id;
>> +		int ret;
>> +
>> +		if (list_empty(&queue->head) || !etmq || etmq->format != UNFORMATTED)
>> +			continue;
>> +
>> +		if (!intlist__empty(etmq->traceid_list))
>> +			continue;
>> +
>> +		cpu_data = get_cpu_data(etm, queue->cpu);
>> +		if (!cpu_data)
>> +			return -EINVAL;
>> +
>> +		ret = cs_etm__metadata_get_trace_id(&trace_id, cpu_data);
>> +		if (ret)
>> +			return ret;
> 
> Since this is an unformatted queue, can we simply ignore the trace ID?
> Instead of fetching it from the metadata, we could insert 0 to create
> the trace ID list.
> 

It's printed in the raw output though and it's useful for eyeballing 
which CPU any bit of trace ran on because the AUXTRACE header might be 
off the page, and it makes output consistent with ETM:

   . ... CoreSight ETE Trace data: size 0x10000 bytes
         Idx:0; ID:22;   I_ASYNC : Alignment Synchronisation.


I don't think it costs anything or is complex to do this, but if you 
really want to set them all to 0 we could do it.

> This would also align with future refactoring to remove trace ID
> handling for unformatted queues.

At that point if they're all going to be 0 then we can ignore all 
processing of HW_ID events for UNFORMATTED. Instead of saying 
cs_etm__synth_unformatted_trace_ids() is for 'fixing up missing IDs' it 
just creates them outright.

