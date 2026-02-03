Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A152BF00D
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111002; cv=none; b=ZEQdQbcf1jLw2mxiGPfTeoAxbr8rJEyuTr56pIp6VBESGHTmBcWyEV6WtMyBDoX31IrNBVeOHlBEcR9Jo3R5rLpoh4MBUeB8yxv1ljncEgPA58p0nWxGSIsg1obTM4RYO1if3qrhBvAAt8TH5448fZoyBtOnWWnp+QyYnVWwfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111002; c=relaxed/simple;
	bh=AYfe5XgZSYlMN19Mp5Tjr5Yswc60ikkFR12wsYefJrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwrLGxdDAgOCi4nHaCNb2pW/3UQk/EEaA/Dynl+8z8plkUISZoDSJIg7c3p6x3K12fBJXmozxESAPpKSmc1XpO1k/KkSXhGauFCxp5bqYDMnN04GZTeCIRLUmv8A36GnN57NNWUSYSSsqX7xojGNZ5OOe4D75UkgQA8Lo2167hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AUpwOwlH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUpwOwlH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so53965985e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770110999; x=1770715799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jivzn1TaUgvG4Fo6r5Dps174hoUliqTt6Of7Vkws0qw=;
        b=AUpwOwlHUq6/UZy9Uv2ks9jzDD5m/wSSPKh7hXQyD+qLnX9aBVD5QQ4EqO0Z51vPvc
         719l1v/0W8gKDjKirHd6Ys86g1PSEf0l1QKVJCyv9zCDKbTD9XoL2n6NztODmHV+g4Sq
         fttcNMspyrcvE7BJnrCKk8t6GhKwc991FjMuZJisVFzilo7sNipdWgRR40uaFJrT/A0D
         Og61poyg+ba7E7l3yEodo3RKtr6Guyf9UH9TastlezfoB7NGttzIzewfhCf7ZzITrxLP
         0UnUn2Yk06pVQgHLQnhv8ickQ4X6LDug54WB2VV1/o2EuohBLXyvFs3zW5986yHoY6ty
         UmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770110999; x=1770715799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jivzn1TaUgvG4Fo6r5Dps174hoUliqTt6Of7Vkws0qw=;
        b=sOjBpl8obtsgaNfVIuTxaMYq5qr1pN1byc+3GqtBJ+KOU81khge2ev80pQxXylLw1m
         yf/5dTfe5oTgUIVM/4syrVRblcy0FQ1pjiWmXt9KBaQoPBktWgGPcrlcSoVzlAuvKwpM
         2kiZdZf10zYkCWMA88esl1jSnqxzGCPMsQPJuQsiO/WRJLgHeVWkM8NvQtCDapSBE4qT
         Subh1osxtQLZVo4sw05gdI1A/IQpvLITtp1p7Ou1QVr2IpXGnkHQljdbzMxYqD5d747I
         7PlDBkoJmIa45HHs2ZqMjX5ebfxySvEiQayNry853I+X2xM3d3/upzSo2o/f4SfhxkUf
         NIrw==
X-Forwarded-Encrypted: i=1; AJvYcCWjMX4gYDQRTgRhVyxb0flbPmdgwLm5Qw9ZqfXiN7nwDNWrx+dgcOrVp/hPCjFLXrVH1xu0t8Jqf/sOEEWsMUjd@vger.kernel.org
X-Gm-Message-State: AOJu0YxHao8RMAm0n9cKjQ9+dXEW8kls1Vf8ys0LeJhhADQ07vAu6EkL
	f+CWIsHlvnFub4eSTtPGfjZJfRkSpKFAlb1MrRzV4Nc7ei8J9tlilaRPjajoWllVuk0=
X-Gm-Gg: AZuq6aKZZ23PpmHNboWlssiWNo4hEnxWAOf2LrkoYeVNLD1xVhEu37nsuLFmQH6y9CQ
	IIbopbgAFi1DIjYDo4oVxgj+S5GuMrjlHj4R0igEo7t5ulKFiUBpLgKGlUk3wdCCJMXaQ1YaKwc
	tn5kRGJAMJs3XTUk/xuLMkaud8KxxlGw+kVZZYnvhpkUljJydnjzlweqoJjBfMULlD3IKMthgq5
	LqaP13wiIfOwctzfwnCyETHR7RxMLbXAY1vBcKRuh+AXQvDmrlgGwlzp6Oj6G9ndqw2/1d7GPys
	iHl7KcTjnxw0zsOIEpO/eftIwuRGMHGmFb4LxwE+vefFr8KViZwinHmNGtVuOIuc5YlZSOw5jyA
	rHLdeVUrxnaC6+RqvPjDcdbacaboDKpDRe7nD4Klvwzvd7uzhogPDRu4uSKh2ttx29qTwR7If4q
	qSzAAzREAPCzPwzHhVL3uLhXyNA14=
X-Received: by 2002:a05:600c:6092:b0:477:8985:4036 with SMTP id 5b1f17b1804b1-482db4592cdmr187515455e9.1.1770110998696;
        Tue, 03 Feb 2026 01:29:58 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830511cc93sm58758885e9.2.2026.02.03.01.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 01:29:58 -0800 (PST)
Message-ID: <95e205af-3dec-48c7-8a0d-293629f1551b@linaro.org>
Date: Tue, 3 Feb 2026 09:29:56 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
To: Leo Yan <leo.yan@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Alexandru Elisei <Alexandru.Elisei@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <20260130202437.GB3481290@e132581.arm.com>
 <aYDWpc8Jh4SqMcD5@willie-the-truck>
 <20260202184234.GC3481290@e132581.arm.com>
 <aYDzh1B9Cnr_expJ@willie-the-truck>
 <20260202191402.GD3481290@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260202191402.GD3481290@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/02/2026 7:14 pm, Leo Yan wrote:
> On Mon, Feb 02, 2026 at 06:57:11PM +0000, Will Deacon wrote:
> 
> [...]
> 
> 
>>>> I'm not sure I follow your logic as to why both ISBs are required, but
>>>> I'd have thought that if perf_aux_output_begin() fails when called from
>>>> arm_spe_perf_aux_output_begin() in the irqhandler, we need the ISB
>>>> because we're going to clear pmblimitr_el1 to 0 and that surely has
>>>> to be ordered before clearing pmbsr?
>>>
>>> I think the ISB after arm_spe_perf_aux_output_begin() in the irq
>>> handler is required for both the failure and success cases.
>>>
>>> For a normal maintenance interrupt, an ISB is inserted between writing
>>> PMBLIMITR_EL1 and PMBSR_EL1 to ensure that a valid limit write is
>>> visible before tracing restarts.  This ensures that the following
>>> conditions are safely met:
>>>
>>>    "While the Proﬁling Buﬀer is enabled, proﬁling is not stopped, and
>>>     Discard mode is not enabled, all of the following must be true:
>>>
>>>     The current write pointer must be at least one sample record below
>>>     the write limit pointer.
>>>
>>>     PMBPTR_EL1.PTR[63:56] must equal PMBLIMITR_EL1.LIMIT[63:56],
>>>     regardless of the value of the applicable TBI bit."
>>
>> Hmm, so let's say we've executed the first ISB. At that point, the
>> Profiling Buffer is disabled (PMBLIMITR_EL1.E = 0) and profiling is
>> stopped (PMBSR_EL1.S = 1).
> 
> This is not true.  PMBLIMITR_EL1.E is always 1 during interrupt
> handling.
> 
>> If we *don't* have the second ISB then either
>> PMBLIMITR_EL1 is written first or PMBSR_EL1 is written first. But the
>> text you quoted will only come into effect once they've both happened,
>> right? In which case, why does the order matter for the success case?
> 
> Yes, both PMBLIMITR_EL1.E == 1 and PMBSR_EL1.S == 0 must be true to
> enable tracing.
> 
> However, the tricky part is that PMBLIMITR_EL1.E remains 1 throughout
> the sequence.  Writing PMBLIMITR_EL1 effectively only sets the limit,
> while clearing PMBSR_EL1 is the distinct step that enables tracing.
> 
> Thanks,
> Leo

I think Leo is correct that the old isb() is still needed. I removed it 
under the assumption that PMBLIMITR_EL1.E was unset in the interrupt 
handler. Possibly because the previous version re-arranged the handler 
to do that.

If PMBLIMITR_EL1.E is set, we have to make sure clearing PMBSR_EL1 comes 
last as it's the thing that defines the point where both pointers must 
be correct by.

