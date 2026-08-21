Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C03A7849
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307007; cv=none; b=jO1UZyPY45mNIGnDXRilE2go+Sklp3dMjj2gtufpPbT9eT0gnCeFe9f4rtUyUXNecgEfC4z7igVKcgTGAqfpwx1yMwox/T6hDV7JgJi55jk68jKoA/TuayoMyT1BJZ+Zqw74+En7ZemY0fa9lHz3f6MrTCMqxoAYhFQ0LrY+1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307007; c=relaxed/simple;
	bh=/diK7OirqVzGd/G/FEBUZ+qnKXlHVXFm8FPazfE3GjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JULlSVvtltybFrDWbcb/BrwtOMjjW0F/G6H3SY4/MqUNCb3AqSW89rwvcYFy2hNM3WX/O1qHvn03B3nVjqaLeQgTdBChCW7yjeiKo7aRpQ2I2n7CtUXteqhszSjdGOZQUz1iyAq6QFwtHk4hwEr0Gk+aGy9hUMNnoO8Jtwu3mWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AqBkrXjg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AqBkrXjg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so5568405e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787306996; x=1787911796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yGCf17okpHY2PImvuIUXBHwDsbK/U/zUaqOXjffAmN8=;
        b=AqBkrXjgSqC8BUNOLyDvdSdxbQE55U9ipEM3kzKzW44vwMd0LAa8yN/dw1wQivvf5y
         iahqUTxHMOm6UaY/XVI8gT9nB9rerO/7e+DOj8omtQPRTvuINwbdgsckfedLDl5qmKlr
         Hr7wRPzJttDQzHPH7R/goHsNIyZtX0GiKygP6OC8/tdfSBS0+9ljmhhQbOoG6ztPX1VE
         i9IUdjfs+lKJyQ6RmVT0T0I/RcvXoLk0rWHKGWkSqRkIpcVHNGSOIT46Tbp75KG9PqGR
         En6DmSmui3onuCe+7Qrk51AFJUKEIBHSy6IvABUhvExvro6iA7/ROJOQbifrqgRiafj7
         qp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787306996; x=1787911796;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yGCf17okpHY2PImvuIUXBHwDsbK/U/zUaqOXjffAmN8=;
        b=OTeiVsQ5vqd5oU6RCLEennzHrLa4xtrTcfJ3qDD8pgBLtLGR0i23f271xshXSvcmra
         mdkzHLpNllxUVFLf35OzhLoXXeMwHhhS/2cqMQczR3wzRXBMkCVKn9D5mQVPtHgqtTTR
         oY2fZnDMrvGqyAgwHrmWKRqIuf42dUTx8Mykq6yaznRV4NH1kDMhe9ma88y+kS736ZpE
         MGxePwCMUzKwK/PiL95xMRiu2iL2znJgSgcoF0QESHfe4taOIc14scadcr95iRZIW0p+
         1xh9AIvYshw9/Gzgr1pSQECt60OX0Y7SNlja3NvUjb/R/CxLQg36MNbkb/3I6nVaVArI
         UnlA==
X-Gm-Message-State: AOJu0Yw3KbT5CR+n8QwTw4E5HZK9/svhZ9rMAWfsY1qNPtpHOHB/rkYO
	viAm7mhFbma8zBWnRs7GKHqKnNh/0luzytLuoaVkkMmgLirbZI9LYIR29rgCEBjajYA=
X-Gm-Gg: AR+sD10W8fGYm0i7pH+UfKKi1w2jrK2h7sfaeATlvNX13JviRp2Nh2Co4k4XgM69jTq
	iG1O0u+Wpy4LpKqrbtD8Iw+XIzQuY85ZIzyWWR0SNPV1OfQbYofObPRzVmEbzu+94Ax1R4rm8K5
	EPKDgQrRU0oJ4oh09Wc0KkMjM5FWFg6/pVmPN5+WQulB2iCa23oxX77PgAWRpS/m1dTDymeO4T4
	M2mBisKOalerV71QAt7LpeaqfyYTZUw2Glayeb9CKB7HclUmW4gbvVKkVf4PKQuSG0kSdudkm/P
	qbqJ+M4BSh6oubapt+89i3gCroD7i0X5MtnmHGdCjLM+5encSt4OXZLPkyeisZK3PXRv9uZBfXe
	x2BYgiVlgYNCscfIdXM2qXmR7+XOwa6No7hzqn20Ao16rdsqqwnR59kNFnGzECl3Bgy1+KthSqk
	rnl2iJHd/bdrNfwos82ENCtaEdLVPxnABznepJm1/6PRLXOyZa7O2CIsFKCd6sIVBcoTI=
X-Received: by 2002:a05:600c:4f09:b0:496:bffb:fb7b with SMTP id 5b1f17b1804b1-499b8457b10mr73001775e9.10.1787306995641;
        Fri, 21 Aug 2026 03:09:55 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90e7fdbsm22078175e9.6.2026.08.21.03.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:09:55 -0700 (PDT)
Message-ID: <6f2ed85c-cbda-4014-827c-272ea2206830@linaro.org>
Date: Fri, 21 Aug 2026 11:09:54 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] perf cs-etm: Turn on context packet timestamps
 in per-thread mode
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>,
 "coresight@lists.linaro.org" <coresight@lists.linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-3-00c4fd0701b4@linaro.org>
 <20260821100151.6E3241F000E9@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260821100151.6E3241F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/08/2026 11:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unconditionally enabling timestamps in per-thread mode breaks recording out-of-the-box on hardware without timestamp support (e.g., ETMv3 or ETMv4 without TRCIDR0.TSSIZE).
> --
> 
> --- Patch [3]: [PATCH v2 03/14] perf cs-etm: Turn on context packet timestamps in per-thread mode ---
> commit 23dc37429523715cdb26c5647b22b1a9dc0c89ab
> Author: James Clark <james.clark@linaro.org>
> 
> perf cs-etm: Turn on context packet timestamps in per-thread mode
> 
> This enables context packet timestamps in per-thread mode, replacing the
> previous unset default. It helps keep samples in order when supporting
> multiple per-thread mode threads.
> 
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>> index acfdb3f53821e..d0486a164a700 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -453,13 +453,22 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
> [ ... ]
>>   	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
>> +		/*
>> +		 * Timestamps are required to interleave samples from different
>> +		 * CPUs.
>> +		 */
>>   		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
>> +		/* Context IDs are required to associate trace to a process */
>>   		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
>> +	} else {
>> +		/*
>> +		 * Enable context packet timestamps only (no periodic
>> +		 * timestamps). Even in per-thread mode with a single process we
>> +		 * still need to correlate trace to a specific mmap around
>> +		 * execs, which can be done with just context packet timestamps.
>> +		 */
>> +		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", UINT64_MAX);
> 
> [Severity: Medium]
> Will unconditionally setting this timestamp break recording out-of-the-box on
> hardware without timestamp support, like ETMv3?
> 
> Looking at cs_etm_validate_timestamp(), if the timestamp config is set but
> unsupported, it aborts the trace:
> 
> tools/perf/arch/arm/util/cs-etm.c:cs_etm_validate_timestamp() {
>      if (!val)
>          return 0;
> 
>      if (cs_etm_get_version(cs_etm_pmu, cpu) == CS_ETMV3) {
>          pr_err("%s: timestamp not supported in ETMv3...\n");
>          return -EINVAL;
>      }
> }
> 
> Does this mean users running perf record --per-thread on such hardware will
> now get an error by default unless they explicitly pass timestamp=0?
> 

Yes but the behavior is the same in per-CPU mode so this isn't a new 
issue. It's easily worked around and nobody has ever complained.

>>   	}
>>   
>>   	/*
> 

