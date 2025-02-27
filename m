Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6F22A7F2
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653639; cv=none; b=jmfxo8QYn7ChoD7kDUPCh5C6BBB0QLACD0HAnCwOWPOZerXlKGVO5QVMkkIJQsl4ZLgBkrzoBQpKYb7nJNpTg20zIxa/MH6pWSl0Yq9BcD1eEltfuQF+8vXYNAcNQs2YqGAYJZMia5ZhsS9YOBuTnVU4UHqHJnInxfuAWwoZNQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653639; c=relaxed/simple;
	bh=bmyJav4h5WrqJRAB+AO8ahOcMlR1rDsern4GDgZLyTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZXGOce7A5uci21ZD8hpTSFCGNK60dwYGn7fVQxwVaqcwS/+zqGdEDQ6GMyXJP3Wk/t9n+Ukpw40t09NTMCfbnLov7vdIcGXrb/YNwWafKehu2ktvt/8/SwWDnClopqMqrwk9ijVpetsNmmQ55HCNI1u2o7KTFyoc6gTnRdUZedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqVmA9EW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqVmA9EW"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43995b907cfso4772745e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 02:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740653635; x=1741258435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SNCv9VF2wwi5tDdk8D6Rf4AjfaKu6G8KXM9TyLJSQ84=;
        b=oqVmA9EW1ZZhiUQDmDR2Yj10E+tdy9b2FMjAXp+NeooOGUPTYrlsFvN3m1Qg2nfXFw
         ap9ijQnQli0KKR7d+pjIhfWXWvmJFjRPyEXgrCFU86V6YaXJfmfHa/Px/ZNtT7hm8dTJ
         ahaQ/B/bykWzWOAAA3qtEpFzzlz/qFVHOqCUz/0VTOO+xm+F3vzTReW9tnzeKyOXrk+g
         2sK5w7D5+CWCVQccOBogZ1CiF7Nki47hMUJ1nBgBciv7wxyQEaBMiY5v+Nk5J3aP4MbQ
         j9TGFgrvY6LKe2MYw5kpi6lapqM5VivUGzQCi8dIvny2ZZic0OE3Iwv19Nh0RULuBd5T
         0s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653635; x=1741258435;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNCv9VF2wwi5tDdk8D6Rf4AjfaKu6G8KXM9TyLJSQ84=;
        b=rr6dj4EDrMSyQbZZ3uMUPu9JHYQMsGv0O8k3l9Mx72B6aK+mv3IhFyZSukGSuF1SO5
         n7uxwL9UadjY7SpI20M6eKJC/ErPHqQ9Pwdej+J0qlz0qMouXog6T/8ZIcNkdtRPU0PL
         Ss1MzB1o3xwaY81ohFygJ6RzCMWKuTtvxz5UoBeltUPhXKrNcQTJHWKpJzYLjJfSzp9x
         6vOrjfGGXwuu7YAKHlQjZPr3zIuPvaw0Vj9AQ6QUCI1MmU/QHBHPp/JWI0xUfmg2ZVd3
         XpFxRXPNM8Hc6xVJG4ns3XUaREqeNfDqXzUem1tiWKcA672pGNo8odY5wDAFubGpyAsc
         1qcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/q3B+U6SWzP/AEvAuWO7ZnWX+L59cH58ybJpMd7JJ8n29Wq7PRWRhW32v9hA9onpH6PXr/XLyuAo/W4ixHL2f@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjJNVfSqS3rk/uilNMEcjjoY9VZ/YvnCgzvEgVRSFHoAN+aO4
	uunv3mjT5qmB3pbNb0voR4HIjvjq1vbBc256qeQRqQe5JGu8iFrGkxiQDCYMaE4=
X-Gm-Gg: ASbGncsDv/dfwhbENr+3li4QjfKkIS++DMllFnkhinNANuY5233c4WJw35lfGlqaE8r
	rTubB57S9sC3X0Pi64dl6kXMbnHXu8EpkG+6mHF670j1KakuF7uhRkVpMQzeKcOs8OueftbVFW3
	bSqfU+sV/A6Ca2M1JVuUcVexpp1HoJvOQkSnO8cchf0PBKDaHDloEk616a7+rmmYfOjj0vnqICN
	vYq8tCGOd/Rfonr/O5bZGxm9hsRvFUoIVX1LR9jEm8pYwmLAlaZr8OvzUCKwrUMeqf+3WoUey5M
	eNTv3wL+Ta66DwINEYx0oiCSfA7o2b/MCw==
X-Google-Smtp-Source: AGHT+IE8DorXVbtCD9exKwh1tn38cojsz1Dpv/Llvugy6PqREcKYEgD8gQ8+TNIqagrt+TUmMtmKxQ==
X-Received: by 2002:a05:600c:198e:b0:439:9e53:49d8 with SMTP id 5b1f17b1804b1-43ab0f979cdmr103876275e9.30.1740653635355;
        Thu, 27 Feb 2025 02:53:55 -0800 (PST)
Received: from [192.168.1.247] ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2ee361dsm51580975e9.0.2025.02.27.02.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:53:54 -0800 (PST)
Message-ID: <96b323eb-15b2-4b60-8522-83bf2f57694b@linaro.org>
Date: Thu, 27 Feb 2025 10:53:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove some PMU events for FUJITSU-MONAKA
To: Yoshihiro Furudera <fj5100bi@fujitsu.com>
References: <20250227054045.1340090-1-fj5100bi@fujitsu.com>
Content-Language: en-US
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250227054045.1340090-1-fj5100bi@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/02/2025 5:40 am, Yoshihiro Furudera wrote:
> The following events are not counted properly:
> 
> 0x0037 LL_CACHE_MISS_RD
> 0x400B L3D_CACHE_LMISS_RD

These two are discoverable so will still appear in 
/sys/bus/event_source/devices/armv8_pmuv3_0/events/ if the hardware says 
they exist. It might be better to change the json strings of these two 
to warn that they don't work if that's the case, otherwise Perf will 
still list them and you'll be worse off.

> 0x0396 L2D_CACHE_REFILL_L3D_MISS
> 0x039A L2D_CACHE_REFILL_L3D_MISS_PRF
> 0x039B L2D_CACHE_REFILL_L3D_MISS_HWPRF
> 0x039C L2D_CACHE_REFILL_L3D_HIT
> 0x03A0 L2D_CACHE_REFILL_L3D_HIT_PRF
> 0x03A1 L2D_CACHE_REFILL_L3D_HIT_HWPRF
> 
> Specifically, these events are always counted as misses,
> regardless of whether the L3 prefetch is a hit or a miss.
> So I remove these events in l3_cache.json, ll_cache.json
> 
> Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
> ---
>   .../arch/arm64/fujitsu/monaka/l3_cache.json   | 34 -------------------
>   .../arch/arm64/fujitsu/monaka/ll_cache.json   |  4 ---
>   2 files changed, 38 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
> index 3f3e0d22ac68..917b9b5bf8bb 100644
> --- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
> @@ -37,11 +37,6 @@
>           "EventName": "L2D_CACHE_REFILL_L3D_CACHE_HWPRF",
>           "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_CACHE caused by hardware prefetch access."
>       },
> -    {
> -        "EventCode": "0x0396",
> -        "EventName": "L2D_CACHE_REFILL_L3D_MISS",
> -        "BriefDescription": "This event counts operations that cause a miss of the L3 cache."
> -    },
>       {
>           "EventCode": "0x0397",
>           "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM",
> @@ -57,21 +52,6 @@
>           "EventName": "L2D_CACHE_REFILL_L3D_MISS_DM_WR",
>           "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by demand write access."
>       },
> -    {
> -        "EventCode": "0x039A",
> -        "EventName": "L2D_CACHE_REFILL_L3D_MISS_PRF",
> -        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by prefetch access."
> -    },
> -    {
> -        "EventCode": "0x039B",
> -        "EventName": "L2D_CACHE_REFILL_L3D_MISS_HWPRF",
> -        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_MISS caused by hardware prefetch access."
> -    },
> -    {
> -        "EventCode": "0x039C",
> -        "EventName": "L2D_CACHE_REFILL_L3D_HIT",
> -        "BriefDescription": "This event counts operations that cause a hit of the L3 cache."
> -    },
>       {
>           "EventCode": "0x039D",
>           "EventName": "L2D_CACHE_REFILL_L3D_HIT_DM",
> @@ -87,16 +67,6 @@
>           "EventName": "L2D_CACHE_REFILL_L3D_HIT_DM_WR",
>           "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by demand write access."
>       },
> -    {
> -        "EventCode": "0x03A0",
> -        "EventName": "L2D_CACHE_REFILL_L3D_HIT_PRF",
> -        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by prefetch access."
> -    },
> -    {
> -        "EventCode": "0x03A1",
> -        "EventName": "L2D_CACHE_REFILL_L3D_HIT_HWPRF",
> -        "BriefDescription": "This event counts L2D_CACHE_REFILL_L3D_HIT caused by hardware prefetch access."
> -    },
>       {
>           "EventCode": "0x03A2",
>           "EventName": "L2D_CACHE_REFILL_L3D_MISS_PFTGT_HIT",
> @@ -151,9 +121,5 @@
>           "EventCode": "0x03AC",
>           "EventName": "L2D_CACHE_REFILL_L3D_MISS_FR_L3",
>           "BriefDescription": "This event counts the number of L3 cache misses where the requests access L3 cache in the different socket from the requests."
> -    },
> -    {
> -        "ArchStdEvent": "L3D_CACHE_LMISS_RD",
> -        "BriefDescription": "This event counts access counted by L3D_CACHE that is not completed by the L3D cache, and  a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_MISS events."
>       }
>   ]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
> index a441b84729ab..c2325855eda3 100644
> --- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
> @@ -2,9 +2,5 @@
>       {
>           "ArchStdEvent": "LL_CACHE_RD",
>           "BriefDescription": "This event counts access counted by L3D_CACHE that is a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_CACHE events."
> -    },
> -    {
> -        "ArchStdEvent": "LL_CACHE_MISS_RD",
> -        "BriefDescription": "This event counts access counted by L3D_CACHE that is not completed by the L3D cache, and a Memory-read operation, as defined by the L2D_CACHE_REFILL_L3D_MISS events."
>       }
>   ]

