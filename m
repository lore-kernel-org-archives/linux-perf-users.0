Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4129346AF6
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899266; cv=none; b=VBUzaWtGTPsRU2SfxzpjcRP5MuQTOoQz0Wl7k/L6tmqOJqPS03mD3RRNtoCG+ORzsKo1A9ESpNXn+8VyEn6+kzj3VeU55OZWs/lgL9L2Y3G2MquMR7/ID0wnSrzOaybzcB6cn9A/fVnFbCye1ghpT4oWHLzJrj0MdDhf7ay/+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899266; c=relaxed/simple;
	bh=BwD7c/B+9PLPk2v9xcagtcKC2j04s6kUgQC0Cea6qJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGGDi5vZ6pK4B4jii1w88yDb9mbbqCL1iaBQAHyXpkMeGjksVbBm4p8Rp+BF98x318iUQ4tmEfu0MhmneytlVWjJ3Tl4tSt9muIxO6SangCB4O4sXTJNhh3abTtuWS6t6i2Nscx8S0mArW5uO0/3uTKZgoNUb0Jflxn9LODjJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KBA6ARh/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBA6ARh/"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79e7112398so946070866b.3
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 07:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765899263; x=1766504063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Z7tlw5t9I5onekdJgpQ0zadrbAsfQMzR4ajquHU3Zg=;
        b=KBA6ARh/i9n8mYzJJmv0td1hRhgG0aZajTIx+uljn65wAcASnS+16HJccui5ajuCK5
         jfr44JiU69LHBUGovVqiCT9jl1xUxWkD735PBOFcIQzkcGFUbm7eLDy+CpEnI3cPiAI2
         eGg5R4UVFuAoRnEF9l+6l1UyeAsqVki7O9uFr3wlWwav82oMjsq8yOuw5vyE4730EMAo
         1NLwMipZY7ND+HhnucRn81YzxPdMnzQAuHaScMLpg0sbQ2CwQyFP6lnokPOQCCaeXCqz
         JMFPhQh8saTcSkCyKwUkWqK0rlvNsnXL8yzhUnD4IqauKB6Np5N83P28KzJV22NcNHaR
         ZkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765899263; x=1766504063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Z7tlw5t9I5onekdJgpQ0zadrbAsfQMzR4ajquHU3Zg=;
        b=eZt4q+Jxn81QYXi1D1sm3izqe/pW2waCq3p3I8YipQoWZblP3tFTSDUycyF7dyth6+
         ea7a+8YipEs/zDHK255ckeOznIVEJedvYvM1l/Q1/mcb1DxAVaFGuabO9NVs94KqzyEp
         nWEw/IKFGI/EpDELQzxSdp4G/R2b9j57JqlEZry+XOZJUe0GSZJZFxyJP8zbNIkF4P8G
         degi20DLK0asvb7XcwCrT76xryiRhV0z5YbmWn/xnFl7L1pdHdEtJE0TCbxzdAhDtr0S
         l7Cs3+hacSoEpz/ptthVtFeKJKWN6U6977UV3zLO2OKhm82WUMFx0EHgYWAbJV0XoIph
         7plA==
X-Forwarded-Encrypted: i=1; AJvYcCUA5/8bTBa52oD7+TkErfK410BFpQIbPIYEcOZ5pgxjgILIE1mwK1u15FA/Teyf21tPsVa5vZBhyyc8BrbchAHD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZRwI6bykfEQHcowofu4Xq73HC781BjXWaF47mhWtkYpa49H6
	dKJYFw17iwHNDSKx8B09yHLeRIvUvcDmzSwiKf77i5k6Ay5tyQVIiJqdenIfr5IkR785QSFuk6k
	TV9U4dFy+Ur4t
X-Gm-Gg: AY/fxX79FIUHvSS8iXWVTYbeFmXC1zj+haRm4i7rPygriTTC1TjPWAVXoqhBGfk9BPP
	AsVKcxhvB08xdGR+AVUlMnVaj+tAYtZDzthMeSfIhKX40yqlWIXE0QqKgczLWpdx6Dv2ZiarYR5
	K/2zMUEevQxI6KzQv4g2hXyhD+rL6aikyT0mmijuimXcVpJ4fBOp+gXqtQbLDQ3nvAS6TrwM6sh
	hvErui1DBobgA8yW6CUFQVW7fqnaG1Ck8oyWRwDx3HczaJRe01+lWtiTq03CjZO39MmIj4H4fVV
	P+ZXDBx2JBfCkJBenpGTkP37c/fDdXoLYPWAn8iGv9/5QpP/68snBCja+XkCNjlBDWpScjZmzpW
	yWPSUvL97cIrRSe9kSbhl9qCFv3Ci6FVXFO1bSA8pdb5308Xu0NKl8AQuAqk5BbyBB62XROs1Wk
	ODNmnx3LisRy8RgDqKMyEu
X-Google-Smtp-Source: AGHT+IF22aaOZPWW0s+RyYbbqasWTKDbfGAAOMHx5UEmfu9aMhShyeRKOYdJclKZV7/QUKufUhVM0A==
X-Received: by 2002:a17:907:608c:b0:b74:352d:6dc1 with SMTP id a640c23a62f3a-b7d236b61b4mr1659301766b.28.1765899263078;
        Tue, 16 Dec 2025 07:34:23 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2ea57csm1713270966b.22.2025.12.16.07.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 07:34:22 -0800 (PST)
Message-ID: <e22497a2-1019-4eec-95b4-b6fd80090a3f@linaro.org>
Date: Tue, 16 Dec 2025 17:34:20 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/19] coresight: trbe: Always check fault action when
 updating buffer
To: Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-10-7da32b076b28@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251201-trbe_buffer_refactor_v1-1-v1-10-7da32b076b28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/12/2025 13:22, Leo Yan wrote:
> The current code checks the fault action only via the IRQ status bit,
> which is unreliable due to possible hardware latency.

This makes it sound like it's fixing a bug, but without a fixes: tag I'm 
assuming it's not a bug. Also I don't get how the change improves the 
latency situation, it still calls trbe_get_fault_act() basically in the 
same place. I think there might be another reason like it makes the code 
cleaner for a later change? Or the commit message needs some elaboration.

> 
> Move the fault action check out of the IRQ status condition.  This also
> causes the buffer size to be calculated for non-WRAP and fault cases,
> which is fine since the write pointer is trusted for the calculation.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index f56ecdeaa6596afb440e4d53732e08a85f9bf89d..e579ea98523c24d23a0cd265dcdd0a46b52b52da 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -806,7 +806,6 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>   	enum trbe_fault_action act;
>   	unsigned long size, status;
>   	unsigned long flags;
> -	bool wrap = false;
>   
>   	WARN_ON(buf->cpudata != cpudata);
>   	WARN_ON(cpudata->cpu != smp_processor_id());
> @@ -858,21 +857,11 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>   		 */
>   		clr_trbe_irq();
>   		isb();
> -
> -		act = trbe_get_fault_act(handle, status);
> -		/*
> -		 * If this was not due to a WRAP event, we have some
> -		 * errors and as such buffer is empty.
> -		 */
> -		if (act != TRBE_FAULT_ACT_WRAP) {
> -			size = 0;
> -			goto done;
> -		}
> -
> -		wrap = true;
>   	}
>   
> -	size = trbe_get_trace_size(handle, buf, wrap);
> +	act = trbe_get_fault_act(handle, status);
> +
> +	size = trbe_get_trace_size(handle, buf, act == TRBE_FAULT_ACT_WRAP);
>   
>   done:
>   	local_irq_restore(flags);
> 

