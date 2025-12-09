Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F933030F
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287641; cv=none; b=lKOoW01+cw+aPc2Bi6r+1Mp+M/1RByIqCnSGG5ix5qmbtZe6atBY/MwlZX+jXs8Gn7hPKttXev0MC81/utHKasdxqfPrm8kva5ZmUFKvt1xQupkluC80N9m7ZD+hG4LwYW10EFWCdl2SQUlA0brtQ7rCy0KsWua4fU2Nwn/VI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287641; c=relaxed/simple;
	bh=13DQ13IejpkP1T8Ag5FrJ2McP1izPXBYIfkwQatfVYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVLQHKRU0m4Nh2TNN5sSnhovB3IeFC6SKhSl3bmHlhexFYwBAkQoyMHL0IKq3ycrwdJ/rnTVof3ztGlrdok71RwWcwJAA7RBlf16c4eY9aqwa9MOkaVlSdZPOV2w0U5DemBaosGXSuW1JHLAMxM4/hE3LtwjDevsVXoIEyvuyMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L7gzWmQV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7gzWmQV"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e47be25so2849869f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 05:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765287637; x=1765892437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72QsK2qLtuVkRibbCMc0jfemrzd33YGdmN+Tg9YYMXY=;
        b=L7gzWmQVWJuvGRHcNs6DCNwipwwqKPIqSPOid5rHolbc1h66+1HM1/avqoANYIOpAZ
         EnDCP5CwV9SExXo/1tiHNhN4k7/8aPOZUoxvhD8mYAfuP2qp+/rdjUi200SRbfJiMQbk
         gEwst2sQIoDWCXfwHacWjlcuCY17+h2hVg5vNQDFy+c0PekE7VTBIocTvjWNoEJgtnRl
         WUpx6y5lMruuR6BERv3xh0PwAccRn/enBtIZ51mdyK7x2ldGmCKAsGSwsUmSrdtcw+WD
         B5eLit20GpOdz6UzDdMtgQ9J+RnrFyzIWTwUW1ZJfob6C61ckgqvibYBSWLssmkP7v6/
         9X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765287637; x=1765892437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72QsK2qLtuVkRibbCMc0jfemrzd33YGdmN+Tg9YYMXY=;
        b=mhcfMY9q9ppePY8ZuzIzGRnkicXKWAmKJzq0xeJMADXu7VdVR+LnvQTMM40lCk2l1d
         KTGKa7P+l1sPiRaKERFHI70UvhoDH/3SZuBX6IK6b7DcwhI1T4kB/2g01UEuPZ2d8qGO
         lOV5kDS/35vqaZV+uDMlqqB5Y9pv+cHpKNeX9PQg63ovmaZKIlMk3r7V47bHQRAFcId/
         K9HilV+hMF6y6setreJEghvkWjhV7xG9hPzYfYJyqEEJLelIbMtnKJkMj5TvOEp8xCld
         +TyLcX48Oz7ICKYB++vv4NSI4Hem33gIVf+xHu5rtjRAyUSw/O/Jgjb4y6B8PGiOtRLF
         nzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX4JNzph/Pj63FRSTt6GLdGtgflov9pIw+81/7J92xzxjl+xKpFcTVipf5g5ukaW4G3bnZq8YWqodFqM+jUe2Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0P1hpPXiUOijwO6VJ0pkGw4ZP7UcNP5YrvJuh7TB9p00JcQ7f
	3l2M9jFPtW+waYn4r4GZ62KGsIbYOLDPyLwwkLrhyWzRXXTj0jtv97WO5/jRYe1KwCA=
X-Gm-Gg: AY/fxX4aNHxYSkWgZjtTSdNw6bA4m8tQkhAAbrEy059NJVkme73d26MyfifxaFw74q5
	qwL9w4092uggDR6i2AXqtqX3TrpvyMCet6PFvrXuYnqYMxnY4USxerD0C6aAguXlxjjUnLfzsXH
	xTvnVdIixqutmG8+F8eyaRnfCp5sz2xeZPYKLaOuGR7TY4SAa8nsxYcYABdIDMqB/0jmhN5GnCU
	07H9eg0Z+EbscsDdcpvBlGTxdWQoaNWaWD/9mJj3/exL7/w4nQv0sxo/tLA2WmRLq60EbFhtJts
	69da79gTbmDaYTkH6RFbDyybe34HSo2mC8jeRadJRDqnGMQauXW4gaDT6zRk1ME6a5KGYWxX36n
	3xuPHMUQmlfBAwdbWnI4AXwAMnVVtpwN3i52noFZOz0JVZGHFfVDGxNDfMTxdjGZiJOF+NaeLiJ
	T301PjwlGSflu92+0s
X-Google-Smtp-Source: AGHT+IHW3lTb4bkJPYXQGsF8dafV63QpW/SGM7fqaQRwVN5UO/PBPV8PAIucTl7a1lglMk9ffw/Mpw==
X-Received: by 2002:a05:6000:2912:b0:42b:394a:9e3 with SMTP id ffacd0b85a97d-42f89f3d70dmr11919856f8f.38.1765287637295;
        Tue, 09 Dec 2025 05:40:37 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe8f85sm32683180f8f.5.2025.12.09.05.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 05:40:36 -0800 (PST)
Message-ID: <f1ac7190-bdd9-4725-8955-d82d6f1912fb@linaro.org>
Date: Tue, 9 Dec 2025 13:40:35 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/19] coresight: trbe: Use PERF_AUX_FLAG_PARTIAL instead
 of PERF_AUX_FLAG_COLLISION
To: Anshuman Khandual <anshuman.khandual@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-8-7da32b076b28@arm.com>
 <5f6bcd93-b565-4b10-9a2d-6851141e5dbe@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <5f6bcd93-b565-4b10-9a2d-6851141e5dbe@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/12/2025 4:28 am, Anshuman Khandual wrote:
> On 01/12/25 4:51 PM, Leo Yan wrote:
>> When tracing stops, there is no collision with other samples, so using
>> PERF_AUX_FLAG_COLLISION does not accurately reflect the trace state and
>> may mislead userspace.
>>
>> Use PERF_AUX_FLAG_PARTIAL instead to indicate that tracing stopped and
>> the record may contain gaps.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 19 ++++++-------------
>>   1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index b06885a08e082fd34f68d9588518807b5c47c86e..0caa4a6b437a3aa39fc6bcc72a23711b54f7c598 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -669,21 +669,14 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
>>   	}
>>   
>>   	/*
>> -	 * Mark the buffer to indicate that there was a WRAP event by
>> -	 * setting the COLLISION flag. This indicates to the user that
>> -	 * the TRBE trace collection was stopped without stopping the
>> -	 * ETE and thus there might be some amount of trace that was
>> -	 * lost between the time the WRAP was detected and the IRQ
>> -	 * was consumed by the CPU.
>> -	 *
>> -	 * Setting the TRUNCATED flag would move the event to STOPPED
>> -	 * state unnecessarily, even when there is space left in the
>> -	 * ring buffer. Using the COLLISION flag doesn't have this side
>> -	 * effect. We only set TRUNCATED flag when there is no space
>> -	 * left in the ring buffer.
>> +	 * Mark the buffer to indicate that the trace is stopped by setting
>> +	 * the PARTIAL flag. This indicates to the user that the TRBE trace
>> +	 * collection was stopped without stopping the ETE and thus there
>> +	 * might be some amount of trace that was lost between the time the
>> +	 * TRBE event was detected and the IRQ was consumed by the CPU.
>>   	 */
>>   	if (!is_trbe_running(trbsr))
>> -		perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
>> +		perf_aux_output_flag(handle, PERF_AUX_FLAG_PARTIAL);
> 
> This is interesting. So there is a no possibility for the records to be
> overridden in the perf ring buffer and incomplete record is all that can
> happen when TRBE is stopped, without stopping the ETE first ? Could both
> of these scenarios might be possible as well ?
> 

There's no chance of overwriting because that would be the TRUNCATED 
case and the event would get disabled. PARTIAL seems to be when there 
was an error that's recoverable in the driver only, but as in my other 
comment I don't think the extra complexity is necessary and always using 
TRUNCATED would be enough.

>>   
>>   	if (is_trbe_wrap(trbsr))
>>   		return TRBE_FAULT_ACT_WRAP;
>>

