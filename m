Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83ED3E49E4
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Oct 2026 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454616; cv=none; b=AueaqPwQQ2w3Bpt3knOxpvnwChAEoSKObQZPLCck/sxBeDSLFt/6KAJvojbVK3n3LiHYTwITFmwMM28Q7U08IMyYCevpLaMO1NS1gBUm2fkjIh0KOn+/waGzVhYkq9lxqpR2ZoBhj/CppFcrQ4PdCy/hljQi+0H8jLcRsivuvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454616; c=relaxed/simple;
	bh=zr57d1ZsF5kLXjGYob37OWc0jqT5c2OOuPZtQUr/tHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9R7ryLlAcNQiAZfQO9bVIo/Uahprh/Wg909fvJx5BlIme7YIVWJbEpSb37vZ1OWNXnG9o2TEXCyKozAmAoVZbp+AFJiFRrElZ0ebe0E2RGRgHusxd4HNb3jU6qdqDWiPYcoKuXrSVGX36T9hWh/mBjOMSq/AkcZL4nvV9lCzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T9aRWkj7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9aRWkj7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so24064405e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Oct 2026 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791454612; x=1792059412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EnmV+GF5F+3o4WuN9B2P/gYsWL8ntjLMdxMPioE157g=;
        b=T9aRWkj7HzYv/eZ5IrAqIUTUJbJ9XNMldTeHN3zkdAsDd3u6CJ8bch3Kb/SCLFabO6
         YZKdlmq4rTQvwmVhk3jJGXaxNPMmHZpiTnqajCRD3YNV9q50fhHFFwQlYdO1OJ5DVdaI
         qqip85qEjEuTJD8FWsN2gVRzqJ4rbIBkh9uKOHWZ5nHp7oOwpkdC94c8ldRLcweAcEfp
         n60XS534iNS6O4nk65tFI1BY8YJaFR1Fs50UMvNP8BiDTxKucOOng+leH9cKPD0J3JEu
         6Kd5yHmD9HQzKwP766oXH/WmykryCPqO2zbueMFOG9mSdopS+n3TXzVs3tA7wcvPpB3C
         kDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454612; x=1792059412;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EnmV+GF5F+3o4WuN9B2P/gYsWL8ntjLMdxMPioE157g=;
        b=XnXzkNgGI7M8MlBjl9XazIUIe3sGbbHE31s66ODVbEL68UyFLWI4ns1XJzLiYN/5OT
         7KRnpKX17Rixk0Av/YoJazXJWSRv5R63q6p9OihIH+lymxBCiSFRllxSaDXP4QbtQFmk
         HBE+cN1zGY+9Nqtn8cicFDfk6AijgdcRryyA1sjoD4f07r4pO1D1uzFJ0ClbjlZiMJJW
         /eKnDtFI4Zpue1Kyja+IWq9j8aVAWpWK59I/KLSsvGx3VG5mm8CYdh2hHVZA0b4fuWbR
         NJWVouJoMi+qw67xa5qyyHVyid1M9VQY3Y+LfTlS9kuGrrkJD+QDYM3s6FQlzEoEZeFF
         KQpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxs5otA9rav+rAkax12us8+0tavlrVX38iS8g/kaGvgd/4kNQMFwzGh+lR81Y1rnV4pBx2JhyWc+pI3MYDm5cpJ@vger.kernel.org
X-Gm-Message-State: AFuF++kL/BsyI9K3P2oi2ymiDTi09LDNb3rdPd7wO4lFzyv50Wo6XeKQ
	QfO1z9xjdGElAoViAmCtND5qcf71N1bsqFn30BuIJhuQ+VOPMmTuqKqr3oN10k7NTak=
X-Gm-Gg: AYBFou3Lal0+JqIZL0NUPkK5mHZ/myXTHRdbblQjiNGudyH7ePOEXOZtVN2cAzP0wlB
	lf/+BnayYw45LAvacsPS6rKMx61FKLR/E7+DusxxCzIiqJ4TfmRQs71AjdORgHOM84WGiNbBoAI
	NmgzViFSVQKkel1k105OXi1wAZs3/nc/51ExO+hdJxYgVNxbTiLMsQ7zNbK54FqzrQD6AnLZthX
	Ze15HAKiSP9tFFeZGmeH4GWZ2ffQ9ZxuBAyzAuHfnLW13o04StWkNqsOmE8PeYMx4K9XyrKOtyh
	So/emtcgvGFc0sJdigZ7ZI6jNMF7EvClXPqklRp7xqLCXAdKRAEfH6sRsVdLzPm6SZ6EGdG0Xog
	CIs2ZjLgU8IahziwRTvKOufG374iLiq0w8u51+r/WVxolnl0pyaHrh/XQM6ccRXfqJ2oLTR3waR
	PkFAjiQeENONpScorZ9VB6fdDq/0hJ8v2OxhkQk6bkFpiHWjknSwjyEO3EDFLkOVPmqQdGZlZEg
	mw=
X-Received: by 2002:a05:600c:820d:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a180423b6bmr85575205e9.12.1791454611842;
        Thu, 08 Oct 2026 03:16:51 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842abdb9sm57441605e9.6.2026.10.08.03.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 03:16:51 -0700 (PDT)
Message-ID: <a8373961-8ca5-4e8f-9f81-69d099bcaf3c@linaro.org>
Date: Thu, 8 Oct 2026 11:16:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] perf cs-etm: Turn on context packet timestamps
 in per-thread mode
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
 Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-doc@vger.kernel.org
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-3-00c4fd0701b4@linaro.org>
 <20260826153648.GK8904@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260826153648.GK8904@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/08/2026 16:36, Leo Yan wrote:
> On Fri, Aug 21, 2026 at 10:49:01AM +0100, James Clark wrote:
> 
>> @@ -453,13 +453,22 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>>   	 */
>>   	evsel__set_sample_bit(cs_etm_evsel, CPU);
>>   
>> -	/*
>> -	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
>> -	 * when a context switch happened.
>> -	 */
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
> 
>> +		 * timestamps). Even in per-thread mode with a single process we
>> +		 * still need to correlate trace to a specific mmap around
>> +		 * execs, which can be done with just context packet timestamps.
> 
> Could we use terminology that is aligned with the ETM spec?
> 
>    "Disable periodic timestamps but generate timestamps for trace
>     synchronization  ... to a specific mmap around execs, which
>     can be done with just timestamps of trace synchronization."
> 

Done.

>> +		 */
>> +		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", UINT64_MAX);
> 
> It seems this will eventually convert UINT64_MAX to 0xf for the
> timestamp bit field. Why not use 0xf directly to avoid confusion?
> 

Then it wouldn't support the size of the field changing. I thought that 
was the point of the kernel publishing the fields dynamically. Hard 
coding widths and positions in userspace only caused issues in the past.

I don't think "...MAX" is confusing for what the intention is, but maybe 
a comment would be better than hard coding it?

>>   	}
>>   
>>   	/*
>>
>> -- 
>> 2.43.0
>>

