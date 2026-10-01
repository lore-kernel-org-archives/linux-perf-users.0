Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6725B0AA
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859427; cv=none; b=V2O+hpNCeYSHhQuCkmC4uhAyOTYheU57QA4YOdTAd7/TwQZAVsm1kw+UOSuZe2VHCkQ6X310QPc20uBGr8o7ORxkvqrlr4p99ytVAOEOpFg4VBKoLQB0DXm6cscuCwJbUrgyr0juBRjdzKIV2xs7w7rLnZAfqY0DM6dNZq3GXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859427; c=relaxed/simple;
	bh=bsRlP2nsrfFj/+87vKFLlLT8dcH7hzwkQXH4dS3a3Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6M4WE3zlWa6/xar/oFujRcyfOsIVz0atxcJmim061f2kJitG5fqI1C2One1hUyCiiFGUTvpevNyxR0OnBndCRWAqH7iEB6rY45oUcV9IRxY7nsSIkkMF2q2DEx6c5OAoYaSFkCvjE6j4Kagi/ooo7WOgY25Sl7N5aG539hqC2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfSx1pjX; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfSx1pjX"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaf10bf094so9421897a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790859424; x=1791464224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0WYQcGuErMUo2kj8MYEXUp1hSIeKyP4od7V3q7dorkY=;
        b=hfSx1pjXmboJR3SzkNEhS1ycDDKTLmYFoOKZnk3uL2zTOQBKLFefhZNqU8VO7HodvE
         Fr3L7R9ej61NW2+AZL0SL8+KNIu5znUzfQSl2aD7+n+Zf3AdpwIw+wY0g8iCsfm8ABeF
         3jyS7fIHH519zYPrGHbCtVJCJlEtspWZmLkoFng8C8VxjtpqtJr6YQhFJCnua3CbWTsu
         k08C75Sa2+PohRaY59RsUZNp7JzpBO30acxnu7Yv/8tSqdBWjzvuSZfkWqhUel5jYdve
         wXvlXXZ0ur0L5fPjEbX9LauScvi+UYPAB2bylvMgJ7PghjfI7Od9TnEcYOyYrUiHYp4s
         csVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790859424; x=1791464224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0WYQcGuErMUo2kj8MYEXUp1hSIeKyP4od7V3q7dorkY=;
        b=bLKvpYQRZ/RJOi/cxAwyekML0kxswXJy6YaECZSu/RzSlqYyrsleVJ1pFudo4QAgcB
         558bIGIkzIZMJHC1geOiN340C6njCdnfASz93bG1Nf1Q7zMKSQQaUfTP3UMiir5AbB7m
         QsoaVlzPlwz+dV+DusM6WXVg6gH1G6P2CXGSay2nqjlvCwyiOjQ1AWgGDhLzblP9qLYG
         VvS3vICrXOVPaEJyISFWifYpw1U0vshE1KnM6vm6ZomKIqF0L4UYvBxny1EBQnOOusLx
         HOKvrSJuCbwQ0VCZB8E7txVVq03sh3PZMtCyvZ4yA7lAiKyBpLbGkQS/x1/vuye0wrqs
         KV3w==
X-Forwarded-Encrypted: i=1; AKwUvBzYqgKOxG7B1/+NXLvafWXDM0ToJ6oLUZjxFCZICP5sM94Qto3EQAU84zpfFSGjPAdpEmleA7z3pNH0QGFzfIb5@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/NJpyv4ePvP13UDV6YIn8Sf+2l2S0JNdw8kLhQNg+jRHERWfx
	pLbvbxdfEb6agTu6kTO7RXoERgcQMLEpyUJvtvnO8lrMo44MS+hDiZI+ZyWnYhfNP2s=
X-Gm-Gg: AYBFou3WuNoblynfX7vRxaObLQYfP2BN+/R6I6eMW0qJ1gc8BqWfFC6XJzSZOYje8F2
	ZjsHIKuFD37xT6t0K7AydI5eOoXPdkltog+icMs30npwXv1abljyfNMC62KHDotlbuz85LKfc6y
	kH0nmui2FxMULeth0GoK7rf2qzSiO5It/BpCyOBrl6UEgckZQyjz0SE056pKI5cfPNYS1gMehcn
	6I8aQ6wv8Wk3W440MbNjLe57Jq9x93f7BVJr9DzfhGAVrogjTF1w2U18nCR8wUv8byhSIxI49ea
	0y4t+vdIQS4GwdXdgREKaaHBwL1i7H/NSvP8hvWfsPD77evOFaMnQss3uTsrUwB4f3qwMp+IaU+
	0pneEbbSlSC0iXQnY5TEClR3KmjmCcXg58UcYkADutfZhAL3vMxPVH8+dUJAqvA/pvLh/zM3Lhp
	KUZC+6sK3iXncvHvtEwwStKYfva8TGwfrv+ZFuFTgw6xYG+2jbw8P80NVlTcfZY4jt7zRZ6lcn
X-Received: by 2002:a05:6402:401e:b0:6aa:f809:ef3f with SMTP id 4fb4d7f45d1cf-6ae19895d15mr3847262a12.5.1790859424120;
        Thu, 01 Oct 2026 05:57:04 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae42b0782dsm1136509a12.0.2026.10.01.05.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 05:57:03 -0700 (PDT)
Message-ID: <b8fe413d-c927-4efd-8988-edf4bf1fd905@linaro.org>
Date: Thu, 1 Oct 2026 13:57:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] perf: cs-etm: Respect --no-itrace option
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
 <20260821-james-cs-hw_id-output-failure-v1-4-9d532ddabcc3@linaro.org>
 <20260904174503.GC8904@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260904174503.GC8904@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2026 18:45, Leo Yan wrote:
> On Fri, Aug 21, 2026 at 10:50:32AM +0100, James Clark wrote:
> 
> [...]
> 
>> @@ -3603,27 +3603,49 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>>   	int err = 0;
>>   	int aux_hw_id_found;
>>   	int i;
>> -	u64 *ptr = NULL;
>> +	u64 *ptr = (u64 *) auxtrace_info->priv;
>>   	u64 **metadata = NULL;
>>   
>> -	/* First the global part */
>> -	ptr = (u64 *) auxtrace_info->priv;
>> -	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
>> +	etm = zalloc(sizeof(*etm));
>> +	if (!etm)
>> +		return -ENOMEM;
>> +
>> +	session->auxtrace = &etm->auxtrace;
>> +	etm->auxtrace.free = cs_etm__free;
>> +	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
>> +	etm->auxtrace.process_event = cs_etm__process_event;
>> +	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
>> +	etm->auxtrace.flush_events = cs_etm__flush_events;
>> +	etm->auxtrace.free_events = cs_etm__free_events;
>> +	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
>> +
>> +	/*
>> +	 * Don't go further than the minimum required to identify this event as
>> +	 * auxtrace with cs_etm__evsel_is_auxtrace() so unleader_auxtrace()
>> +	 * works.
>> +	 */
>> +	if (auxtrace__dont_decode(session))
>> +		return 0;
> 
> TBH, I don't look in details, currently auxtrace__dont_decode() only
> exits in the common util/auxtrace.c, why other AUX trace can work well
> the option but cs-etm.c needs particular initialization?
> 
> Seems to me, we even don't need to do any initialization in cs-etm.c
> if the no-itrace flag is set.

Because we have 2 peek() passes over the file which can hit processing 
errors at this point. I assume other users have a fairly trivial 
process_auxtrace_info() callback which can never fail.
