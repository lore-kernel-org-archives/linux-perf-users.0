Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA081DD0EF
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765292064; cv=none; b=c6gHX4r/U9UmjjOBeuidssPT3Z3bC5+midxcQuPI5f5GlrPg4q1yl5+zHJohHVYMmV/ckPOOVY5PwqYh7XFyXnso8sAgC0AKzIyqLqs1lnA9LC9CMQmm2oBW2atO+7PTndh6g3NJ3K/gKZpNB0s59tHxFog61m6FiI3xtzmEGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765292064; c=relaxed/simple;
	bh=eD96g5pjvDYVpYtQr11/TYM85QIVc625ilw8ytDPk+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+SDhQ0y7ecYNVILJVmB/wGiOfIUyY16aJ3zUEBxBfpF22fiwSVzX3GgO/N9NtCPu76srg4kJmy14OqN7hG9b+lSJPKrZB2ICbLTKTx+H4QTOn85mdInqMPP8Lz6u0fy0lo2bfgmzzs5ztf4LbpxC54tR4l5HCmSe5EnF5YkSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KS0AVTRP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KS0AVTRP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so4361465e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765292061; x=1765896861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I77rqlgPE4VEYTyOhE8C9IAUeqfQbxcz2xaE/KeMMmY=;
        b=KS0AVTRP/WlJvMYqa/K0bKr+ALn1lPkv4Hf3QYP6VQIfMc+LTtd0eQ/9IJ2uWzEeVx
         960WInvVI5e/ckaIagJxw6jJfczMIuc7YcfnvYAnitkCh23f4VvPKIOuisJBuxJA0/3F
         JtSIQEO6hluxU4Au16azlUgPrzCgP7wTg6QLrNElzCIAmkdgWYqpg8Wjgz1fSPpID7cE
         gyApcBXMCch8WYjfTCAqbkonpAAe/QacZvw/msSvCjbFYixgALXApUz8ChDW1M0IkfYB
         sErvItk8xFNeGfLEEBy9sYGmbJ//yddbaNmvxggjfSdXKDcMgdDUocPuL0EXEDOu4y9k
         KHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765292061; x=1765896861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I77rqlgPE4VEYTyOhE8C9IAUeqfQbxcz2xaE/KeMMmY=;
        b=QnFP+gL7Z7dmV36vRamrGFsBB/qFQDeDDkCwc6UoY7V5KgqenO1+jF7bcE64vlEjGJ
         NsGOlzm/wUbocyMUusc1XjfjplnkqAcGuAUdDeQ8yUShwCinQ4hj99FUrL9JhDuai0qY
         CrBZd5TtHjtBJnP3cV+pfmibskXmr2GK7/1Ycol26nzmJAroH+LFjkWlfEaKfWQ83HLr
         OggMPg68EmMpeIk3tG6rfaq/CuD4CRsmc7qcZfFr2MnJkhfAFEy2rLmROKgnYsOeaK1i
         AJyHQ9WUFHXPuP9uQ9U/Z24wHkyMCS/dYy8SDHsDLUJuu7ESMw62aq+8X1bGtwA1zoYG
         YgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvdsY4u+X3fYAFC5L1da8kdt7o2xce+iwYm5PCe3DPIDhUwNyCUohqEuQQFemUZqOX7VtFB5yG9f/g6ue5WQDc@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNVo6VM2wu9IBcsBTCuswTe3GhgjWMKrDSIxGR4x7BjEyPW0d
	Nss5cX21D0xK9iVDxBWsAbVLzhBoRocqrG/IOHpdMY54hfCUUFbEroOgajf2CijTmcI=
X-Gm-Gg: AY/fxX4PGP8qeF3Xo9/nCBDAjII10Trh3SPpKf3unj5oU6QkV8iWLFMvJUJgphyJaSb
	oBEs2yut+nZ7sMTKgksIlTNDYYxDgDvNqhqwSHDZTBBopWBtvSBrsYzGeZhHQcjPpzBeb5sXreI
	tK5xdZYxP1cxZbrWlcpNVnktvjpo9e4hHavZVx0NyztY9U4kszOoRFr8/ppnqwdWpCZd3CUNNYT
	VuFsYhWep23DFZr95BZfjcRHFFMyJO+fE0JhS7cUEyGvPZ3GgsOk2/ytrpMfWT0hPmcx6nGjI7q
	AYgcKXkLJKPyp+yllcG1r5eGAZqJObFncgup95Uc/YIBcQxYcCaEbk2Sey1Jrob0DIuGeh51jpp
	37g/ZIdddJn59evBHWaSjF7Pv/6Hs2Gan0E0TlZ8gSRlrckiuniq0FzkZocFSuiFfvM94mmLUH8
	nJR+s7HYRU9ycAakrM
X-Google-Smtp-Source: AGHT+IG4v9UP6u54PQph65mR9oenZhjMF6WsEAAW8pYbnWdPqIyPTf06tVvcbxXr0zMULbQ5hddMqg==
X-Received: by 2002:a05:6000:2284:b0:42b:2e1c:6341 with SMTP id ffacd0b85a97d-42f89f0ab32mr12255937f8f.9.1765292060866;
        Tue, 09 Dec 2025 06:54:20 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbff352sm32569419f8f.17.2025.12.09.06.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 06:54:20 -0800 (PST)
Message-ID: <5ebf1743-b01c-4664-961c-9e1e2aa7ffce@linaro.org>
Date: Tue, 9 Dec 2025 14:54:19 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/19] perf: cs-etm: Set watermark for AUX trace
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-19-7da32b076b28@arm.com>
 <c22b084b-3853-405d-8b43-397786af7be9@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <c22b084b-3853-405d-8b43-397786af7be9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/12/2025 4:48 am, Anshuman Khandual wrote:
> On 01/12/25 4:52 PM, Leo Yan wrote:
>> The default watermark is half of the total buffer size. In many cases,
>> the tool can not be notified with sufficient free space, especially when
>> profiling with small AUX buffer (e.g., 64KiB).
> 
> Could not smaller AUX buffer be prevented for TRBE instead ?
> 

It's not really about the size of the buffer but where the wakeup points 
are. With only two wakeup points (middle and end) once you pass the 
first one you are immediately into the last chance end section.

Now the driver is writing into the end section, but Perf is still 
reading from the first one. Once the end one fills up, you end up with 
no space left without Perf having a chance to say it's finished reading.

To guarantee free space, there needs to be at least one additional 
section as a buffer zone. Ideally we'd set the wakeup point at thirds so 
there were fewer wakeups and still have one free section, but it might 
not always divide by 3, so 4 is also fine.

The commit message could probably explain it a bit better though.

The reason this is different now is because we want to be able to enable 
wrap mode as much as possible. If you imagine the scenario where a half 
way watermark is hit, you can't enable wrap mode without wrapping into 
Perf's part of the buffer (the beginning) as it's all that's left after 
the second half.

>>> Setting watermark to quarter of the buffer to notifies the tool to read
>> data earlier and prevents the data loss.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/arch/arm/util/cs-etm.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>> index ea891d12f8f40beebf8dee1d3db71cad701f5666..649b8b0d0f92b4af45fb97db9da3c5ccf24a978b 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -424,6 +424,13 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>   		pr_debug2("%s snapshot size: %zu\n", CORESIGHT_ETM_PMU_NAME,
>>   			  opts->auxtrace_snapshot_size);
>>   
>> +	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
>> +		size_t aw = opts->auxtrace_mmap_pages * (size_t)page_size / 4;
>> +		u32 aux_watermark = aw > UINT_MAX ? UINT_MAX : aw;
>> +
>> +		cs_etm_evsel->core.attr.aux_watermark = aux_watermark;
>> +	}
>> +
>>   	/*
>>   	 * To obtain the auxtrace buffer file descriptor, the auxtrace
>>   	 * event must come first.
>>
> 

