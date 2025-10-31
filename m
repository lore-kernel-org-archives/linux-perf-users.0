Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C284332919
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904806; cv=none; b=dLNWqwVBmImzG9Gf7y9XQ0/g6C0dhMaNMP8eIuHj6BCL2/60Di7QmkQmpjKCFt/L7VjnXgM5sa9PDnqc2vXuD3ClxarARe4BhxgI9GOgZCQXUpGsL7xXfbJwhvOk7Wp27cLPQqOUfNrzf7s0Eq/JlXBMMp56nusfjUs0p4rYreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904806; c=relaxed/simple;
	bh=wNnjGniV6pu3D6d0+vHC1OpzEzE1DnHmr+R7k2tu6TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=F7W0NbcTK/QYUWizpLq5bdYMiTzZGvFpiQaA7DMSp+MU5E4KEFkzf9P4Gd5c3smEOsXizfFgdGeauYa5l+YfHggtksYgH80ZrsHrUswLF4WqEMxzLxYMS1yNVYzeQgtMBnTY+Mq/O2KdEH1Y/kUrE8J2RQNx2vfWR29UMMy09cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J4f3W9rX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4f3W9rX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471191ac79dso22691715e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761904803; x=1762509603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XmagYXZGhiRCZo8nGtg5dtjzropHlOVEQuuywu8QoA=;
        b=J4f3W9rXGjMCaWSR6Lxj7YXEWIJgdZSbBIrNsbATnAknXIGFGL1YFerW/2meokdt5+
         DNNXhauX+rEW5pjvlg0uAORbrQs4yxcAWuq8Z5wYU7xIUzBVxdHofS+uG2hE13xxh4sM
         7NSUUgwKy+kKGodo3uFPEEemwhmosAplqPGW809/IH5C9gjZaS826RWPyzAsJAudYPsJ
         JdKckZN33cePnrmmh6QTxN6+vLeFNqanG3DR3oP9nUFP9zBQAr9x2r8lpLFwLgGgfbBC
         pjgDts2J7nB3MFJEkwORLcTJRDUv8M2/u+xT0b+VKGnTYAA5i+LysobG0gpmakWDBIiv
         s5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904803; x=1762509603;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XmagYXZGhiRCZo8nGtg5dtjzropHlOVEQuuywu8QoA=;
        b=DztA8MRMw6fzLUrLwTsSKQpugcCkcFTDZRV3w9xL/w17CID+UgtlQMVSWXnctIDq78
         dVMu7i+zWM0uQelAqFx3rbqW3l6ym/zk2AKsB7s4GNWaE9vFyRJoLCLOIVbFgOhk/XlK
         wFYBWfweajCk/AnK3UnLC6MhpKfUAdmfSUuopuez2MHnnZuCWfhNEo2FCNQS355IlS8Y
         ATfonpMOd+j/ReCqJ9KeDyrbPVff90P5BmVNArylVvejPogTIlLSGbVWKtfo+RG2Qjm6
         +a0niDi+zxjWy1Ng8vQFZUoE6Q0HgQVnXQL/anerJ32bmsAHDKWy3PfCuJ6GsiWBJ1LB
         9tYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDSK7VJ0MfeV53pRBaRP4ZpdydinjlOtMYN3QzSAoCPUAHo7ZJuExii6TERN7uti4eZrc2ffqU7Gd0FpvOgMrY@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtfZluiwlc7dG+BrxHcG2wxr6sa5F4BzkjaRbXn+t6Pa25NkF
	sHTAYc0ajD1YaAjq4YdabHP36MaRv/Nes3KDU8+dwqYpah5kRPVg2yNCYRzbniP6MyQ=
X-Gm-Gg: ASbGncsDL5TBFlh4EAn400r7uNXD/8FJj1OL1W1/ynzaYF7e03M+NzdzkEiRIyIc049
	SmBCLFM7R6Kz59ptsznTE8i33sL6Tl4yK8A/2lRwHyTEefq16z1WhOhK7RjFhSeDDeMhoZQmymj
	b4V0GyeEgUHs50i08vdEwVkMwKCRkCIV95ZQ2cIcCDexj58zpznosgQtALSrCbKOpy/uFLq1dQ8
	ndh1+Fj9ais0KC3kMkFpm2L4+BXGf7aZzDpsN0aNVKND3IIE4GMBBWpoiifHjAo/AgBEtFuXUJL
	/A2VQt+1T7vBnCncZTkiwaYV2vynLV/WVzSVSlVPfLKZzddk6CE3N81kKXEDcjFDAACjt/R6Nwb
	w8VqKAxvnl7Km9kqfgBJF6zkMZ0KThI76/dSrnyVk2dXBTlYg9y925qqt0fWjYT+RxL7qZ80iKw
	GeETXlQVWUNCVJ/f/M
X-Google-Smtp-Source: AGHT+IEv9vBf1gcZcP/1EXFL+TdkTt1q9osVqrYbZXlOtnlKXOqyYbm17I+a0qRcWFjfmA40A3E6SA==
X-Received: by 2002:a05:600c:4e44:b0:45f:2cb5:ecff with SMTP id 5b1f17b1804b1-477308ce7b2mr28429105e9.31.1761904802781;
        Fri, 31 Oct 2025 03:00:02 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728a979b8sm86399575e9.10.2025.10.31.03.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:00:02 -0700 (PDT)
Message-ID: <18df2108-5f09-4806-af0f-3af3fbff3f92@linaro.org>
Date: Fri, 31 Oct 2025 10:00:00 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: Fix typo error in json file
To: Chu Guangqing <chuguangqing@inspur.com>
References: <20251031031729.2304-1-chuguangqing@inspur.com>
Content-Language: en-US
Cc: john.g.garry@oracle.com, will@kernel.org, mike.leach@linaro.org,
 leo.yan@linux.dev, peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251031031729.2304-1-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/10/2025 3:17 am, Chu Guangqing wrote:
> Correct instruction spelling errors.
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>   tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> index 4cc50b7da526..4001cc5753a7 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> @@ -81,7 +81,7 @@
>           "BriefDescription": "L2D TLB access"
>       },
>       {
> -        "PublicDescription": "Level 2 access to instruciton TLB that caused a page table walk. This event counts on any instruciton access which causes L2I_TLB_REFILL to count",
> +        "PublicDescription": "Level 2 access to instruction TLB that caused a page table walk. This event counts on any instruction access which causes L2I_TLB_REFILL to count",
>           "EventCode": "0x35",
>           "EventName": "L2I_TLB_ACCESS",
>           "BriefDescription": "L2I TLB access"

Reviewed-by: James Clark <james.clark@linaro.org>

