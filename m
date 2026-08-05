Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A73EC6A0
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946257; cv=none; b=Hn52PiQqmwlmDp5SqsRofn/YLQWShwiIsyY60d/pjcLcVeoLhUWnuoIi7BF98C2TBr6Px64GkHHbcRZKiw6+ShuRlR8ZkikM1+vUA+h4rgV3HsRjLPI/YyqZ0onwu9ikH1sPg+jvrV10nKVYaN83wbAVe/T0mgH0REEV4AIpskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946257; c=relaxed/simple;
	bh=IXEVwfzsahq6FUkJxYJhmc4SAHegCMiUul051MBbDv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MceMjKPpnf2cM+nWtv0iTREZoqNZ9D5XlDPGfhcJrw2C+ojSk2AW1gFGxWPCnSXwVZO1EMQp5EUPM8MLHXYdyhvXHHp74G9mPOQkBrSvOLjUI1cmokKAQgxoM9kbE1rhx3c7HHP7n+6CKUoVsISefWQCFD8fpJKIxU1QQhyTM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYKqPJ85; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYKqPJ85"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4994c49f588so241905e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785946254; x=1786551054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WRMc9ELRK9N2OjwBZeonQXM7QBgpvnvx9C7k5nluwVQ=;
        b=wYKqPJ85W/yv8L+u7P6GHHLzzssjs8VxqutQJ3RVit9XmCDSdXCCSeiyHv65lwNF/L
         6aaIhiUpZMw7Zwpd5PKxw3vGfOUejkx8r9Uefey02WWgwZYalJqLeYkuk7l1I4+73rKj
         rGK2guqFvPLR9epbFLrl3kgyzHTDU3lW9KyMyW9dMncUZ+USCcppGRSIDskM62qVTH8a
         YYUqjdgFnIBvN4AtT/WVjE9vrk4h+mfxTkV4tdB0A3/acRUqqwKuxfp0R/X2SxeYaVj2
         yooBDz6iHCyRKbGTGt9TdHzsgq4ZDUkr95+Z3rrYIP5Om5qIGuKe3QtoVlAdOuWPizhM
         3K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946254; x=1786551054;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRMc9ELRK9N2OjwBZeonQXM7QBgpvnvx9C7k5nluwVQ=;
        b=T180I0cW5H0Rnuj4LJz9jsXOHlgjOryDOM42chxRPYbpw4IgI/Puvby4POzfXmb16a
         qSU/kII/6lSJGdmogg8wGA59JuetgKO464uxJy8AUGAa914J8t5fQxgdKNNaUQPRmeQm
         9hp4oB6rPoRVtVwAsH3WnLTnNCqZdJ9VcBn4SjeQFWVCWufc5QAqUuwYCXgjtJaIUi0q
         RdarGCfDqM6lghGcBPI3doyz8vm0yHYq4WNPMpr4T9d1dgFw1IOjicTMUNq+OVBMs7mZ
         RPHHJMS2Xa9TUJniT8SkjMRW2B/T1MaAEMKyUPDYWa+inLjr4e80toplDnvIHNpviMl/
         Q8lw==
X-Gm-Message-State: AOJu0YwpAv9FWzzUokEDv3hVf+41TquTuoiEnXPJWtmxO+6MG+sZPFmI
	NZzD+SvvBdizBp6GXC0NaIQNXzI04fkiuYAWl92JmB34m9RAlZl6S9fHlKwaioJAlK90vPDSySo
	h34MkhoGVXA==
X-Gm-Gg: AR+sD12HfsF5exMOcsVViABKjGgS+/kR9IGpYOyK/bKo4uAr8H4z3yYIeetajJAr5UV
	j6Pr9kE9r0LNLHzC49rkTTyW9hctPxQDKiZP1qJhaIMVYyPtKwwNuzLYXhbrpB86sXDbrDrz7nL
	ksPRDz1hYLQ473ZP1JP1EA9X5dlaXOpsQPe2nddiMD8rNSfx16spBFotP0vgE1uMiACc9KuuiSM
	TMVRfdfbsTeZa1jR0/YVtDYdrJyMSy9JNRjKZdRiawBReedtBEodnkOmd0t4owwVmtcrhV5PUNw
	4GWB7o3ortzTclRTtFcXamLV8a0FAqmB/pYQqBj4u7Jvj3KVVZb3+spS4UZYNtNVQ2QJVRTj+Cg
	hLQVYg51Lp/hPnF7CPGkZcqUTWegeJLRLImTSEVvPZBGeJ+P9GbgPDDtnNDtjiHacWENrL2sjYk
	dLNdxIYB7URiZ3gghmZr7uogd2u8nVCLyx7JOo35gWKkL3Q1KbhEDtZCFF16BifDl78A==
X-Received: by 2002:a7b:c399:0:b0:495:58fe:88e5 with SMTP id 5b1f17b1804b1-49952d92cefmr4071305e9.2.1785946254097;
        Wed, 05 Aug 2026 09:10:54 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfe6b26sm10354973f8f.16.2026.08.05.09.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 09:10:53 -0700 (PDT)
Message-ID: <9dbac460-7f94-43ad-b90c-3fadecefd797@linaro.org>
Date: Wed, 5 Aug 2026 17:10:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf: arm_spe: Factor HW discard mode out of
 arm_spe_perf_aux_output_begin()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
 <20260805-james-spe-software-discard-v1-2-0ff0e44c4c92@linaro.org>
 <20260805153750.86FFE1F000E9@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260805153750.86FFE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/08/2026 16:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Unhandled Interrupt Storm / Unreachable Code due to uninitialized perf_output_handle in discard mode
> 
> Pre-existing issues:
> - [High] Missing Context Synchronization Event (ISB) after writing to SYS_PMBLIMITR_EL1
> --
> 
> --- Patch [2]: [PATCH 2/3] perf: arm_spe: Factor HW discard mode out of arm_spe_perf_aux_output_begin() ---
> commit 61201ea6d6b4e69de62f9788efe1db4fd64b4fd9
> Author: James Clark <james.clark@linaro.org>
> 
> perf: arm_spe: Factor HW discard mode out of arm_spe_perf_aux_output_begin()
> 
> Discard mode doesn't call perf_aux_output_begin() or emit aux records,
> and enabling it never fails. We'll add a second discard mode in the
> next commit so it will be cleaner if there is a separate begin function
> just for discard mode.
> 
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
> [ ... ]
>> @@ -609,18 +614,23 @@ static u64 arm_spe_pmu_next_off(struct perf_output_handle *handle)
>>   	return limit;
>>   }
>>   
>> +static void arm_spe_pmu_begin_discard(struct perf_output_handle *handle,
>> +				      struct perf_event *event)
>> +{
>> +	u64 limit;
>> +
>> +	limit = FIELD_PREP(PMBLIMITR_EL1_FM, PMBLIMITR_EL1_FM_DISCARD);
>> +	limit |= PMBLIMITR_EL1_E;
>> +
>> +	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
>> +}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but writing to a control-plane
> system register like SYS_PMBLIMITR_EL1 requires an immediate isb() to avoid
> leaving the CPU pipeline in an architecturally undefined state.
> 
> Looking at the caller in arm_spe_pmu_irq_handler(), the isb() is issued after
> this function returns, which means the CPU executes the function return
> instructions before the barrier. In arm_spe_pmu_start(), execution proceeds to
> even more instructions before an isb() is eventually issued.
> 
> Should the isb() be placed immediately after the write_sysreg_s() directly
> inside arm_spe_pmu_begin_discard() to guarantee architectural compliance?
> 
> [ ... ]
>> @@ -884,7 +900,9 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
>>   	struct perf_output_handle *handle = this_cpu_ptr(spe_pmu->handle);
>>   
>>   	hwc->state = 0;
>> -	if (arm_spe_perf_aux_output_begin(handle, event)) {
>> +	if (arm_spe_discard_mode(event)) {
>> +		arm_spe_pmu_begin_discard(handle, event);
>> +	} else if (arm_spe_perf_aux_output_begin(handle, event)) {
>>   		arm_spe_pmu_stop(event, 0);
>>   		return;
>>   	}
> 
> [Severity: High]
> Because discard mode explicitly bypasses perf_aux_output_begin() here, the
> per-CPU perf_output_handle is never initialized with the ring buffer or event.
> 

If this is an issue then it's an existing one because this patch is just 
a refactor.

> If the PMU hardware asserts an interrupt during this mode, wouldn't
> arm_spe_pmu_irq_handler() see an uninitialized (or previously NULLed) handle?
> 
> It looks like early checks in the IRQ handler, such as checking if the event
> is present or if perf_get_aux(handle) is valid, would evaluate to true and
> return IRQ_NONE immediately without clearing the hardware interrupt syndrome.
> Could this lead to an unhandled interrupt storm that locks up the CPU?
> 

HW discard mode doesn't trigger interrupts. If it does then a separate 
fixes commit is required unrelated to these patches.


