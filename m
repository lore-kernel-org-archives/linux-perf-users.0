Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E31DE2A4
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654753; cv=none; b=Q11CBAGpf0hy5lvw1l0XfTwiwZ1x0DMgoQrlsOHtlKGAy3E3CSai1JE1Md0DtLHXgFxBPdsx5dbBDfSHoG/eE/iOwys9pAtToD3enBuJ7ojTsjUq6J0CUqTMl+yr/k+oIxyDM0WLlKLCuEZyQXAB28CTKkUmoH9GD1g0sv+r2tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654753; c=relaxed/simple;
	bh=CpDpksR03m+W/KR5W/pURdBtrJRZER/h23noEbaiE4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mPKopTdHrVzA/uqbJo+Muvp76XQJwvpvtOBOK6u5B1gb2qi62ocWyCgGyl7Che/vokhnRNL2myvLZcdylo6pWn4g1NOOhCt94oTv8Gvg+Le+Woi2GDyFfavAuTRQPwvsWiuXWm7EGLXJmHJ3zrRVQVdwuPguZcjGTpZdKQaPM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gS0sMT0Z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gS0sMT0Z"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso10442f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749654749; x=1750259549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXzBZQldP73BbRZZS65Vo9wcTrZxZnhNR3p8LsxSWO0=;
        b=gS0sMT0ZqXZxOeBRkwfxJ4B392d8AFTg2TKV2pVh/M6AocAAHGRz80l/5crnEdL3UB
         kBkrbwmI18BdrHhIcmAhW1q8zZnSHh0CIbbq63vEgNoSLqWHjB/HrAROyXDGQ1Z47ZYa
         060rj8k9BVw97V5gWPpez3Mx+ZfOJqEhsqKasC5qz50cXNzhlshh2qmxsnoXS9tmkywU
         si2aJG0pYaOKCcXyboPkmL4H44QrFbwkW1esgJrQCT+YuUDSEIo55JOea9Gv+tAeJjw/
         y26wp9QfTrxwFIluLTpXzCm9/fWMR7OD80R6H76KQ1iZlR47W6veqVi6qSrSvyoWa6xK
         XYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654749; x=1750259549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXzBZQldP73BbRZZS65Vo9wcTrZxZnhNR3p8LsxSWO0=;
        b=HxYRP+tzTHS0OhyU1Dz9v0HAo0207+LF8P57HhiqWG3DtTq02ugERMJfS0bzzAuT8G
         5pshfhjGMubRqOYQSDqo/xC2VQdKSsED/OYj6Fln3Qw3KBtEB89fV3DMePVeBW2ETalQ
         tRFlTf6HSnihkJwNjdgfuixPzbzQZPLMaKiSxNFzbZgg0zmqZ0yBUIVioa8sndCSZpJE
         bt7A90ZTcX6dc53aHtgKY9xwud+SMJ+C2Jb0KV6kpxxjihYYXao377MhVDwz2TNBniyV
         MaR5LXTyobZyi48fYILemOTeSnCJbSs7D7/EOSFFdYrohlMlrznZUo4IjzS+VKDd4Jpc
         dDqg==
X-Forwarded-Encrypted: i=1; AJvYcCVerZ+0cV/pGNjp8M2U3duVNbPAbkj+2OqT7aIq/B7DKEnboEkEBcirJxNiXGA6PcST8F7gTUTqY3/Ygz8bBbpA@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnX83eBfMda52dT+G2tp0dtdlBn9wWtMqyV3Y0t2Y1bZ3ujc8
	K2hD90e9ChR6D2zcbTPFWAQ1nC75BqCk74iwDt2mF4gjreqtWFyZPa2tVKKLvMtW//E=
X-Gm-Gg: ASbGncuXye8OuuVXH2KTT11z16bVxfLIpWBK7J2+EvkC49I/5o8RlvyWa2sZnR+KaKM
	xH7EPON/2gyHoKbnMlOuc4sobLjqxrgpIikak/l63CuYsbVvjdN/XeB1wgjmpoEC7cfvdk7kc0m
	krB9o5owby9njob0403M6PsjzOlLZpW7s5mCpofcecifp49ie8nm0RPsofFJE/JjPODkjUjo06C
	N6BNCWznEb0YKN48vHzxICocADqOuBCRwWREUDpL6j/K15aWIuIHffD0xzWRv1a6HxPbsxoh24T
	eKkAuQ6hnxnJk7d0s7SCr1hSgshz5RffldqMcuHN1ZeA2eFIx+HlNF7+vA6zei/26bE=
X-Google-Smtp-Source: AGHT+IGjRZp6QoSgWwB91XKzm+h5aA4BVHOOkZHH3LrJev657ZvvnKDi3bNUVbObVY3dZRrMSs35iw==
X-Received: by 2002:a05:6000:4305:b0:3a5:1266:3e96 with SMTP id ffacd0b85a97d-3a558695737mr3092005f8f.15.1749654749616;
        Wed, 11 Jun 2025 08:12:29 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5324520e7sm15619819f8f.84.2025.06.11.08.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:12:29 -0700 (PDT)
Message-ID: <bcf75597-0665-49fe-bd85-7613ff508302@linaro.org>
Date: Wed, 11 Jun 2025 16:12:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf: arm_spe: Relax period restriction
To: Leo Yan <leo.yan@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <20250528132501.129586-1-leo.yan@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250528132501.129586-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/05/2025 2:25 pm, Leo Yan wrote:
> The minimum interval specified the PMSIDR_EL1.Interval field is a
> hardware recommendation. However, this value is set by hardware designer
> before the production. It may not accurately reflects actual hardware
> limitations, and tools currently have no way to test shorter periods.
> 
> This change relaxes the limitation by allowing any non-zero periods.
> This gives chance for experimenting smaller periods.
> 
> The downside is that small periods may increase the risk of AUX ring
> buffer overruns. When an overrun occurs, the perf core layer will
> trigger an irq work to disable the event and wake up the tool in user
> space to read the trace data. After the tool finishes reading, it will
> re-enable the AUX event.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> 
> Changes from v1:
> - Shifted bits with FIELD_PREP().
> - Removed warning log which is not quite useful. (James Clark)
> 
>   drivers/perf/arm_spe_pmu.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 3efed8839a4e..e40e5daa838d 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -308,12 +308,16 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>   
>   static void arm_spe_event_sanitise_period(struct perf_event *event)
>   {
> -	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
>   	u64 period = event->hw.sample_period;
>   	u64 max_period = PMSIRR_EL1_INTERVAL_MASK;
>   
> -	if (period < spe_pmu->min_period)
> -		period = spe_pmu->min_period;
> +	/*
> +	 * As per the Arm ARM (DDI 0487 L.a), section D24.7.12 PMSIRR_EL1,
> +	 * Sampling Interval Reload Register, the INTERVAL field (bits [31:8])
> +	 * states: "Software must set this to a nonzero value."
> +	 */
> +	if (period < FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1))
> +		period = FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1);
>   	else if (period > max_period)
>   		period = max_period;
>   	else

Reviewed-by: James Clark <james.clark@linaro.org>

