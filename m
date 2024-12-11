Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B8236F98
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912028; cv=none; b=XP3mO6Jprq/Glk6IBLtdoV+e7uTqT2X+ZzzkceccSqj1Q/tGsLYoDHolsi76KLmEfX9XRQ8P1C2Z6xsCnDNYFQSAY2GAnxBimDK4Jekxz4im7iht0OIQ2+JXcarEic9yNEvHfK49KphsUuuvp0rA6fR3D+bJ/kQQ2q7ei0cr9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912028; c=relaxed/simple;
	bh=ug/9fGjGdhPGtiTPa/wOskfE0Nu2limG/THMaAQXSIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R2vVKaUx4aIsZTZ2p0vUT6Eou8mECzInlfeGWDMvOGDqdWaThqfpLLaSDLbvtZ5g4WKXQhYzQ+PkYi67Q7B14E56Tb5mztiY7MluVVGPNxfADjqFas6c4Xt13bqLgWmWsKGVtTUy0cTyvKWeZnmmHveEpn3gz8X5ZzSXqp4+jyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xBXtErsq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBXtErsq"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862df95f92so3300066f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 02:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733912025; x=1734516825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezwloFLbDFqYucUL2s/vC0GiLC7FIA5I4mKffZUJVN0=;
        b=xBXtErsqFWrmZvZfKihXg6dqUpjLjLoauMSB0wV2AAM4BoG5geWXADWY92FdPalmTM
         28iuwNl2Oj7jOOsHpyKm2MZ6HmQ8aSkucpFwaoCbA/+ljGekEKj2sAAifDQOEtPYxuOg
         gAF2PdZUQYFjBO4fBR1bHWPiRVqnnJ6uyBfZDYpRC3DUxJKL4UzdPPosuL00rj6vIyqF
         usePTq5OFAVL2oDgN5TPdV6EGdXSGP/4zBQ2H4/6EI/3r9gW8PfBO5SNDvsYNaVJqQ3N
         GgTfPqPIfrXs0NYDK6+F/dm8Hdjvtj2lZ54vdjnz2J5AwjcI1/MMZd1P03BHXWNvXUcP
         7osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912025; x=1734516825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezwloFLbDFqYucUL2s/vC0GiLC7FIA5I4mKffZUJVN0=;
        b=n5J4s53P3AJa9iTRH8VdLlM/QCV6+hKig4+koezscRx9iuHqUc4FTgeFwAK/2HgDI9
         XIMiL/hCDsESqx4qQyPKRtOAi1x2mEQfstyQWLj4ln3/s5pEuRxXRrtxNY+CiyWirzYv
         0Hjgqz+xDnGzyUgZ20IO1XiGZ2yBPesCsyMmmHzPBt+fCOdlKnshBSlNZnZXCMBR5Eo2
         SLEckIrlDvgYqkOhQ9BkG3F6TVYs5FMsp04K1cFbXZlniT81ma8IklHFMX0Nn2nsNHZn
         QMHQJMyyXN78epmRrz7Yr+hq/noD8RwvHT1Jt0XmmK6s1AYMnR5IOrZED8hmWSoZ/OIL
         Mirw==
X-Forwarded-Encrypted: i=1; AJvYcCWAyBPrvboWOQHCTV6gpkOY5/yEEpQVNDo+qq3/cEKRvch0+0O/WVmgdkgVT7CByN3+FhWzzpZp9BOhOsyOLFdk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxle+afq6jj58w0if8VQ0W7vuYPNDqsJiXygCm4gba4mRT7Uvri
	JB5aQAv+j54D0w3/QHO9RjiyDDNUoYC+wNO9v7R5BTCdbtH0Pp2IFzXW3tdqAf1pvdjEwKGxKU1
	G
X-Gm-Gg: ASbGncuLt2/RtEJf6DVJnjaW1LXLmEdfowvAg9KSpOsAD0PEYqDxvzH/9aNf7PGFUZn
	58hYQpcrppZXKaP1viE5PzKX3MjkZw0WRUBhbWUHqySJShX/iS7t42l58vp/hhHPItBwMNnS1xw
	SH+NGcAksnhPdKl3RStYENUqWTea5DEgEPX8Ec7I4egJ8hhC2m64Z0P1CS2osg9qkDSGHZ1l+/b
	PfgxUPX3P4+GFHljdwT4PLu46QsSN9SSSEykbWGea652/hTKzeADXTQe8MPQyXuRw==
X-Google-Smtp-Source: AGHT+IEnwh8x6c11GhbYsoIZAT6oWXj1pwSvxwkK4+Q6KCYCB5xuwSSlienp55mp9XfbBZhKANAf1A==
X-Received: by 2002:a5d:584b:0:b0:381:f443:21d3 with SMTP id ffacd0b85a97d-3864ceab53cmr1685142f8f.57.1733912024906;
        Wed, 11 Dec 2024 02:13:44 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782521dfesm903782f8f.107.2024.12.11.02.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 02:13:44 -0800 (PST)
Message-ID: <01513f7b-390c-4e2e-a6e8-54c268e8acf2@linaro.org>
Date: Wed, 11 Dec 2024 10:13:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update perf tools topdown documentation
To: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
References: <20241210193554.93013-1-ak@linux.intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241210193554.93013-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/2024 7:35 pm, Andi Kleen wrote:
> - Document and give examples for the Lunar Lake perf metrics reset mode.
> - Fix the error handling for mmap (it returns -1 on error, not 0)
> - Clarify the slots placement documentation. It is not Icelake specific
> and also applies for non sampling.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>   tools/perf/Documentation/topdown.txt | 33 +++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
> index 5c17fff694ee..3e2340f3f78e 100644
> --- a/tools/perf/Documentation/topdown.txt
> +++ b/tools/perf/Documentation/topdown.txt
> @@ -87,7 +87,7 @@ if (slots_fd < 0)
>   
>   /* Memory mapping the fd permits _rdpmc calls from userspace */
>   void *slots_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, slots_fd, 0);
> -if (!slot_p)
> +if (slot_p == (void*)-1L)
>   	.... error ...
>   
>   /*
> @@ -107,7 +107,7 @@ if (metrics_fd < 0)
>   
>   /* Memory mapping the fd permits _rdpmc calls from userspace */
>   void *metrics_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, metrics_fd, 0);
> -if (!metrics_p)
> +if (metrics_p == (void*)-1L)
>   	... error ...
>   
>   Note: the file descriptors returned by the perf_event_open calls must be memory
> @@ -290,15 +290,38 @@ This "opens" a new measurement period.
>   A program using RDPMC for TopDown should schedule such a reset
>   regularly, as in every few seconds.
>   
> -Limits on Intel Ice Lake
> -========================
> +Newer Intel CPUs (Lunar Lake, Arrow Lake+) support resetting the perf
> +metrics automatically RDPMC, which can avoid a system call or needing

Minor nit: "automatically using RDPMC"?

Reviewed-by: James Clark <james.clark@linaro.org>

> +to schedule special resets.
> +
> +This is available if /sys/devices/cpu*/cap/metrics_clear
> +exists, and requires setting an opt-in bit when opening the
> +slots counter:
> +
> +if (access("/sys/devices/cpu/cap/metrics_clear") &&
> +    access("/sys/devices/cpu_core/cap/metrics_clear"))
> +     ... functionality not supported ...
> +
> +#define INTEL_TD_CFG_METRIC_CLEAR 1ULL
> +
> +struct perf_event_attr slots_event = {
> +	... same as slots example above ...
> +	.config1 = INTEL_TD_CFG_METRIC_CLEAR,
> +};
> +
> +... open and map counter same as example above ...
> +
> +Then any metric read will reset the metrics and slots.
> +
> +Using perf metrics with perf stat
> +=================================
>   
>   Four pseudo TopDown metric events are exposed for the end-users,
>   topdown-retiring, topdown-bad-spec, topdown-fe-bound and topdown-be-bound.
>   They can be used to collect the TopDown value under the following
>   rules:
>   - All the TopDown metric events must be in a group with the SLOTS event.
> -- The SLOTS event must be the leader of the group.
> +- The SLOTS event must be the first entry of the group.
>   - The PERF_FORMAT_GROUP flag must be applied for each TopDown metric
>     events
>   

