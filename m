Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E73251791
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765974856; cv=none; b=geRMf3s1qn7EKWiHhzY0I6ZkbVHGy4AfxF7w/0PKQGutWlGaDwN6+GHTYoL6XzbyOn3YOoSErzRhTWUPlzc8p9xdj2mSKL3nejitGwelrYjRI2z0HluIu+aJHgO+WKPs1746frQMlE52gsu75+VUyttbZVbioD8BObitZrrwPBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765974856; c=relaxed/simple;
	bh=+TIekZx3/uvElrdf6KHx/6gUqgw6sR5VUdn/6IuKBbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyEDRHtrd4LkhU96kihkfeDyMuQQvaKuhgkYBp9fN7QTLqP6AvhQ14lW4dftp9KtJrKA0LXYe9RsffsRdaSHSJO9+w92KnZA/oekExpqxm4O+N1XTKEWdXOrIwWTPcysy4mbKLDeFWtpuDeM0CiUBDxOEiftMVZ+P9BtF6KfCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JVWeJDvK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVWeJDvK"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7a6e56193cso1046429366b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Dec 2025 04:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765974853; x=1766579653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqCGOsZ4BZPhdG00MIUomE8awebnSdupDx2Uch0yTuE=;
        b=JVWeJDvKQdYFIkBsQ1lzykASutzi6tEjsZon9FgIwcANBWtv0yAnAaVVnE0gJ7Y3r5
         xHd96v7fH/sp19FEIhgsHGz6aOqzZW+28It0uSYN5itOZCda6V5KwA/IWnvEshXQSqwW
         o5EsKTTfYlnkOGBMdFXzdj3YRNVUFqT/uL7mrh1tmXDdToGNQqwka8+kcTtk1uk//iJ/
         qV3Ry5/m+mAbxWJrzN5w9FWorxUK8sdwcCsPY94uUfyLwrLofikNpTlXbCWK4upjK96w
         xLPf6IYOferAClsmu2/cdYe82YLXiLeTcFQdGSfGgPGIBT/IQEh1hWWZ3oLfX++6RlRW
         iC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765974853; x=1766579653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqCGOsZ4BZPhdG00MIUomE8awebnSdupDx2Uch0yTuE=;
        b=D+7EvLXdLQfTgh0Tg7+ov6OWivlTIThrQpAFH7sW90PQV8NBH9k81RjtczPnaHIA5q
         u9eNtXrEQ9zIFdU4HKa2VVep9n1b80V+39VGTDznKdwR05kiUIRHci/+hhy9eLvkZOP3
         vrawqU+w/Tm0orZRSB9KD9Yl1HNG83tZ3HfSiCLyp7+ISG7SOWZAEUSITsd2Jug8I4ax
         UDmSujgUMDr+8mKxOdKEiqpm/06bGD7FROBi3HaaHCOtFzRrPYWoskz563u8QGsEoKcq
         E2b//CgvyGyVQOFfLI70+EZ9K5HmVRPu+5uFHG3NoGPBKrFlS6pPbL8kKtRhheTLo0yD
         cEyA==
X-Forwarded-Encrypted: i=1; AJvYcCXndds/C4VWxtkmhN2G+7HOY6QtapXxurmH6HsJmLJJemojt69dO43qOnc70PSmmOJ/VzZOAcV0eYItnvSM0Sdq@vger.kernel.org
X-Gm-Message-State: AOJu0YxNC+02j+apXJc8qFDgwDw3zdglcHYgux120GH8uMQu6NWYWgW+
	1D7xCQQ9sp7AqxEiszGqJMWPdUK44Z3oC81HNRJW4DgZt2y2yVO7lQ+3p2G211FzRck=
X-Gm-Gg: AY/fxX6eJfhnYUpm8BX9ljvA2u9jW5XJJCZKrAZw/G8is9njdeA9NWo3rfGPEAbG2mT
	5h2hXP9PVekQLOd53Qf38B2GP3U9qmNDKYLQu6+HK9FLQsCx2/6wDYHunc0F572KgJXEwXVGAqn
	ggTUxmz6PgGstroFy4TzXKsuHFY7e3EidEHu0TilLttbRFA+FUCYw5P7d7mYG8G47ziJ8JyYYNE
	/zVcuI4FcH9WIMwzz0soxF71ZYnjPAJ4EtyTJgzXSAd01rzk1dLSWEC4LA2Jlap2Pwl/cRtjioc
	8SdJ/UNUq2UKIFdwVqc8yGfp3DMx6gaFcQuOQ0vbka08kIzNIdUqmuK6PpyUZ8KHhpI2nUsYxL3
	79D18cgP3hs6ShLGGtXiZxd8UuChYc6bIkM9EnX+xmn4/ZKG+Arz+XuNj3RVimtoYYrLQf3Chrl
	6skAL87xmu8HMthfXKHbvMSJeWq3IzkB8=
X-Google-Smtp-Source: AGHT+IHCJ5p1mqHUmIm0m6/EO8R7tyvPsphE78dwHj6xv45A77sVAcJddUtJ+YkfO08Nbb25famhnQ==
X-Received: by 2002:a17:907:3da4:b0:b73:5f48:6159 with SMTP id a640c23a62f3a-b7d236f7974mr1742785466b.5.1765974852651;
        Wed, 17 Dec 2025 04:34:12 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7fee422729sm512798366b.9.2025.12.17.04.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 04:34:12 -0800 (PST)
Message-ID: <96a09496-f3df-415b-95d1-92ceda06dd03@linaro.org>
Date: Wed, 17 Dec 2025 14:34:10 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/powerpc/perf: Fix perf record -d sample loss on
 non-marked events
To: Anubhav Shelat <ashelat@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 dapeng1.mi@linux.intel.com, mpetlan@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org
References: <20251216211541.111795-2-ashelat@redhat.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251216211541.111795-2-ashelat@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/12/2025 23:15, Anubhav Shelat wrote:
> Previously, when running "perf record -d" on powerpc, perf would drop all
> samples that were not load or store instructions. This is because of an
> overly aggressive check introduced in 2ffb26afa642 ("arch/powerpc/perf:
> Check the instruction type before creating sample with perf_mem_data_src")
> which drops samples when the SIER instruction value is considered
> reserved (0 or 7 in ISA 3.0, and 0 in ISA 3.1).
> 
> This happens because
> 1) "perf record -d" sets PERF_SAMPLE_DATA_SRC for general sampling.
> 2) When sampling non-memory instructions, the SIER instruction type is 0.
> 3) record_and_restart drops anything with SIER instruction type 0.
> 
> "perf mem record" uses marked events by setting MMCRA_SAMPLE_ENABLE
> which samples load/store instructions, so a sample with SIER instruction
> type of 0 would be an anomaly and should be dropped. So fix this issue by
> loosening the check to only include marked events. For non-marked
> events, the sample is kept and isa207_get_mem_data_src initializes
> data_src to 0, preserving the original fix in 2ffb26afa642.
> 
> Fixes: 2ffb26afa642 ("arch/powerpc/perf: Check the instruction type
> before creating sample with perf_mem_data_src")
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>   arch/powerpc/perf/core-book3s.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 8b0081441f85..bd44b83db9ec 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2304,10 +2304,11 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>   	 * In ISA v3.0 and before values "0" and "7" are considered reserved.
>   	 * In ISA v3.1, value "7" has been used to indicate "larx/stcx".
>   	 * Drop the sample if "type" has reserved values for this field with a
> -	 * ISA version check.
> +	 * ISA version check for marked events.
>   	 */
>   	if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
> -			ppmu->get_mem_data_src) {
> +			ppmu->get_mem_data_src &&
> +			(regs->dsisr & MMCRA_SAMPLE_ENABLE)) {
>   		val = (regs->dar & SIER_TYPE_MASK) >> SIER_TYPE_SHIFT;
>   		if (val == 0 || (val == 7 && !cpu_has_feature(CPU_FTR_ARCH_31))) {
>   			record = 0;

Reviewed-by: James Clark <james.clark@linaro.org>

