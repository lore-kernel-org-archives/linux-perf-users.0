Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877248987A
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851211; cv=none; b=YBKs5OW5i/oiv37wBX/z1OGVrg+R3Q2Q8r5HXa7KJkh37PJV9hULTD2esjrzcPfC+Hq7gjt0pJdazyIaetusyjk+goA8OMnYfeAp57cGOAsjN2enyqA8YevlXj5nj8gMHYsY4jG8W9IBkuXManv8AG73PpfQkJpCJQfFOAyQfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851211; c=relaxed/simple;
	bh=t0zJVvurxnCeKDCTry+eL4VK5MXxqUoBdilHO4bV6Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUVmtOp0qodtKK+COqgVOvOwF1nK7G8nvYsbl7qDqlYTGDZkmTnZ8JdFWpvp9y/wqTTZHp/4saEUafxh+FTrN8AN+8s85EgUVuWRn8ht55CAlFErKmeuRk4zmzq++ejGmHBzw5krWVXpZPP8oaJqXU7bNNbh+Ob/4hplIaSXN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HkOfm0tz; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkOfm0tz"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so11908765e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790851202; x=1791456002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhz6ns8td9NvZN6ayBEXDaOQ/jthJX46fvpgHDR7D4g=;
        b=HkOfm0tzJnvK0QSC6Qr4pADkLBzx3YLDLjWQxZ9Bspi+3oHixiLOjK86lygSbXg9iT
         dCW9BZSRP8EQPQ7LFd6EV91mSjJohDAmEND38EKLuhf2eDHx8j3UccScjtUgft9mlQQO
         Vt2IXQ72ZFldyKi/5e+M2uOs5yJFMcMRwswkZtDgAMeD3XtrP3Ljh765ryTPqStMIBkQ
         nT0+0obRO5OB27BWYPdtSzIx381KlN2BhT2VuMb74jloPSBRO1SfGIEytbc+QmzzddCf
         ueRWz1i0Ndrb55oM/zWr/DkHxKzoWfdM5hv4+N9b56QLkxYO0DcuuB7rWqy8xTmOYJxf
         0JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790851202; x=1791456002;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nhz6ns8td9NvZN6ayBEXDaOQ/jthJX46fvpgHDR7D4g=;
        b=KPiB4R6S9hXhfbBmwgOD62HxltraDmw5qc2XKyf2wmjhx0GmvnW/Avh4yhRm3tXBN8
         vsICXgFdUSProL4HsGBl0PB+x7g91/uafIBuRQO+kuXHGB6v8G58a4jr7nfM8+K9l6ac
         A6VWlBaXKC2/1FL6TBnw5cFwePLeT8SW5rS+/AGlaNDgpuSLQSySUthINqocEqnYYgAP
         Kaakqhc5wj2qE15uQmb1jylgXsswZ5Vdr+caKYesMEXLNs92xAC+7ewZgRwdyjzYTLIw
         QxFUsGQ3PJGlessNFA7GVcgZ03NcbimcbRtspq9sDDTkjn9xV6hsARB5MHor9OgRjMRa
         W2jQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7qSCKwgX6uQdtaKJpAKoE2rwcs1xtGlMRVfKLXHbULoQFTci5CuzAkww01lfTDI8/FUb9IpU/2oPnWMweR4nb@vger.kernel.org
X-Gm-Message-State: AFuF++nMGxUBNZcR9P3FpmMrFq4LRsy37UigK8QQHCrKCM/1UGvZHUrT
	su/g1mHd+esDUrA7vb48pEpXitkT0hh4nzeaYFZy7nfYVvAks1jTDg00ojiS7MacOUU=
X-Gm-Gg: AYBFou25CpbulS0MtOnjNuEGTdTX8j87LqK6MR1bc9T2sEUqSsETk32X8L5Ex+kLhf2
	xlhYCmZ9AcYPaAO5gOI8HRDEgAr0m9fC22vBI0fZXNIM+/RaPS8oADPltIY7LoTR5wevC4X0LCq
	sFPIvZJpYZGf3xgWNWXKb68ijRZr5HhVtqzAu0OG/l3fmUAf7o7Ohn2CzHCMMftih5lbxSZMClj
	FKu+SnhL3xr/4glLyLuToUQhaUDU7MOw7QUkhPezk1p2nZQvCKRiH5S7PMKKqCkX+nsi0/IyPUI
	GMi6wO56u8Yg1TAqwekW+oudf7Ji1niebY+kMvBGFS5tAoyMfU5Vzq+t6Rzm3VytURfbJCCDVZj
	ho+pc5yZSFGW0XliRXoK7r3qqHPd+8GDtLB46Ir9R1KLiv2is6p6C3lIgZgAF6spZAQeJRMVmFh
	PekpDXzOuZNuA2cH5EQ5ewO2S61sgnPsgIliVEAhqTSXGdM8iOeQVDAQU5AEumkhdgNYk3LUYhj
	HU=
X-Received: by 2002:a05:600c:c3cb:10b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-4a01eaf5b29mr32874605e9.3.1790851201999;
        Thu, 01 Oct 2026 03:40:01 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f93ad0bsm40417675e9.4.2026.10.01.03.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 03:40:01 -0700 (PDT)
Message-ID: <d3e34f2c-6838-4902-9204-f32b59f12f3d@linaro.org>
Date: Thu, 1 Oct 2026 11:40:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] perf cs-etm: Free partially created queues
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
 <20260821-james-cs-hw_id-output-failure-v1-2-9d532ddabcc3@linaro.org>
 <20260904171214.GA8904@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260904171214.GA8904@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2026 18:12, Leo Yan wrote:
> On Fri, Aug 21, 2026 at 10:50:30AM +0100, James Clark wrote:
>> cs_etm__create_decoders() can fail half way through and the
>> err_free_queues label won't free them. Call the full queue free function
>> here instead. If no decoders were created it's a nop.
> 
> [...]
> 
>> @@ -3520,6 +3527,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
>>   
>>   out_free_decoder:
>>   	cs_etm_decoder__free(etmq->decoder);
>> +	etmq->decoder = NULL;
> 
> cs_etm__free_queue() also calls cs_etm_decoder__free() but does not
> clear etmq->decoder. Should we do the same there, or drop this
> unrelated change?

Yep we should do the same, I'll make cs_etm_decoder__free() call zfree() 
and drop the explicit NULL.

> 
> Otherwise, for the queues free fix:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

