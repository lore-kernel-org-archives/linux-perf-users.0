Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D43DC4DD
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502038; cv=none; b=RsPVEvPbnTbg+7YxaYvGl2bwWlkX4ICD5L4axkS0ud3DuPq3jaEVmv75ntjWrK2eufgw/t4HSCYBlGDZ1/gyrFf7F9RkXqTZSPWVGxoa552/gamRiB/MPdcO98yIzvJR5f0IBJ/fqKJme/1BueJknQk52GyA7VvVDX02WUJ0gBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502038; c=relaxed/simple;
	bh=YyHIKl0YFnOrf4b3X6aHRwQh3XkLsdrmrGiOM+ixt8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuOUFdNo0LLsMYFsP+FeqFNJDSQ1r458KmPS4SdQDGIfo4MGyiECxsBzGYF8VM8u+aFW1e2G2ONtT2tbPWrp29VesxD6RpwB9pj9rtS5kB+Iw4HZYGd4vJ+wUDJcDss9w/mXjdM4mnMQV6tMw3ta9xOOMeLlyuTRcYCNoTUPjt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H2gylKza; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2gylKza"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eeea039ebso3087878f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780502035; x=1781106835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WeNxgthX7RDeq1y4GZbJjfxu5vLqCNfeHjKxVMHovlQ=;
        b=H2gylKzanBFzLlh0QwLhFCoTA9kmMu3xckPfj00m/AgWY08AMjxKyC1tbGP6AclfHK
         f6TqEp9VWlEqppmCKNjh1j54ERThV1uT3XwIr1S0UZqxrf8dJJKvNcHMWpTDcomNdDQT
         1ugep2Umk0xBkrTavpX9EezveY2qnMdLmfvob/JzOcWCpNhaVgJnTCClBZYpREYU0J4W
         QP4QxYz0US7umplCbTx/sxwVHNmdJ7SxmFYTzRGf4odh2x/OXtv9GSeKpBUmKODYnMMd
         8tNawXfMv87ZsCsx89KD1c2PnM4fPWp5r+plId3uuSdVa7ykpV3QOT+Ct0pL9Ep2VF+H
         Ttsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780502035; x=1781106835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WeNxgthX7RDeq1y4GZbJjfxu5vLqCNfeHjKxVMHovlQ=;
        b=dj0/WDvnCZHOwUxPlJvlcPTApoLSqaouzPUcmN744ccV5yPKQLnVZav3IZpoEG0LHf
         ARWYb7FkwNNvFFhPE67aBFS6PK3zcp57S1u+RCHXGiuG+RM7FbTqsjbSiEyuyohtGgIo
         V8whVSYwqC6T68DOJn4pTMOln8i4a5utLkFPONspKfmbJtUUXGAktUztBkB2COR7XAGu
         FwuDkATV+8XkacUPWkLVtRpQ6QajDAE6dPMSTufi9nPCM2qklYcnCU10EzKEiU13QA3k
         kpY57xIKHOqGr5tW82T7VoyLAdqpyMESfSoteb7lrW0C+EsLx0/plbr4Gs1Si8UxDXdG
         1sgg==
X-Forwarded-Encrypted: i=1; AFNElJ8RHmSWQElrEpTOUBHlXpeqjTYajs0LV2Z7DJIf72iqCBWkr8zDtkE3WqQFanxqps+kCLDku9AkUq4uYSoV8TxT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16WoAn/iq19xCTgvwPhhP/5aTQF/BWMKaZG8lL8RsspnJ7IIA
	EmOMFSnQG/wFtdGQ69N7R2vR2ykEf2R4l76lNeqakcJL2tEs15joWBJGfLOzxBLSATE=
X-Gm-Gg: Acq92OFLIoIF5l8Qcwk9uHoBb4xhyRTKoqMrfGIRf6Hn4e+zlb0izD7ewYHZVlMIj5e
	hVbBfNg20cNiFVd4obIP79kxzUDjjiF8m8359eXKDqyoY+uBJnXltDX/KFoPAYKLERHT6I0Pq1J
	2PERQHpR5gRXB6pD6v+cRRqeJT3cq9lBietanLdgUGPmWO39aYKhRGuI+pUlBP6xwJDbd0muAxh
	nQpWOHDk4ttiw9ptCIR608sRvSrsE2tlnn9gU/e0fwkd13uN4TdJdPXBKQhi1tR8Q54gJ9xMvIV
	Y9iR+eeHnm5dNAk0TWvYS3yzjEBrBJlHSa3Mi5vh2y9vCaJJOBLVqBbBmEKiDs/tEuP+g6br9Jf
	hqvw3Ql5mx0CcBzajGeXOhH+DFewNPehaFNfB5RrM1qkQTNYhnkQ/6SDz+QL7Jdok0i0DYzK2xm
	8DxGC/rQyUPGDCTOgOxwgoVfnsiH2ZQSMMUWgD8/U=
X-Received: by 2002:a05:6000:2990:20b0:460:25f3:b25a with SMTP id ffacd0b85a97d-46025f3b73emr1462864f8f.34.1780502035457;
        Wed, 03 Jun 2026 08:53:55 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344148sm8692402f8f.19.2026.06.03.08.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:53:54 -0700 (PDT)
Message-ID: <9b149f11-3e05-4871-92a0-d0fe1ec49357@linaro.org>
Date: Wed, 3 Jun 2026 16:53:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] perf test: Add deterministic workload
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-5-85b5ce6f55c6@linaro.org>
 <20260603112742.GT101133@e132581.arm.com>
 <b4836fe9-49cf-44c3-96a9-548e890cee29@linaro.org>
 <20260603134339.GU101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603134339.GU101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 2:43 pm, Leo Yan wrote:
> On Wed, Jun 03, 2026 at 02:10:37PM +0100, James Clark wrote:
>>
>>
>> On 03/06/2026 12:27 pm, Leo Yan wrote:
>>> On Tue, Jun 02, 2026 at 03:26:47PM +0100, James Clark wrote:
>>>
>>> [...]
>>>
>>>> @@ -22,3 +23,4 @@ CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>>>>    CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>>>>    CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>>>>    CFLAGS_inlineloop.o       = -g -O2
>>>> +CFLAGS_deterministic.o    = -g -O0
>>>
>>> I have no strong opinion for using 'noinline' in source or using the
>>> global option '-fno-inline', just thought this is not easy to follow
>>> up if anyone (likely myself) will write a new workload for disabling
>>> inline. Could we have consistent style for this?
>>>
>>> For the patch itself:
>>>
>>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>>
>> Actually it's a fair question why some have -fno-inline and others do it in
>> the code, it could just be copied from when these were built by their shell
>> script tests. From a quick look I would say we can easily drop the
>> -fno-inline and do it in the code, and it's better to only noinline what's
>> needed rather than everything. But that's probably a change for another
>> time.
> 
> Seems to me, `-fno-inline` is more reliable.
> 
> I.e., in this patch deterministic() has no 'noinline' annotation, my
> understanding is the test expects it is not inlined. With `-fno-inline`
> flag, we don't need to worry anything is missed.
> 
> Thanks,
> Leo

Ok I can replace the noinlines with -fno-inline then.

