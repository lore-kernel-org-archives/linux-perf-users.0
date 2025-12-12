Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBCE800
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552682; cv=none; b=tlvy2ibT1iwZf8EXtNrZpa2g+xpYhvHjAwMAPKX5JKWfsbDzT5GkPPOktI9F/O4uVuullzaaAMTRPMbhCOiRag80TlVWSV31C2POV7VVEpz4cHEo3fTl519RKBMtifD0jRGaLZwJfd387txmPtp6GdrxLoQX4CGia6xmqu01aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552682; c=relaxed/simple;
	bh=SyPDrWZ+o2riynrXmoQv0FBoRN0PNtv9VFLXwxoNvVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyRtI/FN0+aj44Ta8zfBTb0KcMIJBHfa/rvyuxZijauXO6w812osLyPPWWb9bFhTjaYfykmOXyIZg303USV0zCubPddTBarcXcpHoHyU1lLpkCRUlT7eL5SrJ9+E001mwZTUQROuoR4fB1ZhsUsqzj/Knwwf06UkeJ3cKBMp8Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XuwwPUFE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuwwPUFE"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b713c7096f9so227469866b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765552679; x=1766157479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzRmGTG4hV3KDyAaywOrTlQOkI9HCeXuDyrMklg3lMk=;
        b=XuwwPUFE9By8840DHFmaFP6zHh0HzSKlCEnQJpxyIOkZyKVJTazqK4GkpAJMgvxFOo
         b3Hs2czyEv8GehQOunpdz/svQHN8yPO2WDQQBavDDECjSjV8KNYU6lTbKfB7SwZwfRQe
         u71a1JDXzsiEEKTBM25QiPAFZR+dz4dk8NYQRqjdGj7YQ7oQDAdDBRFIUtv/6fuchROf
         39+sH1Z7SD8PzXtVSGTL4sqZ4LtYvcXXQxv2FGMbAnInJim+raq7/QH9e6WUY+W8EliL
         QAcY9TJ6O8Ajd1NjTGQQlpYn4FTN5I5Cb531JM1fNVOcCJaS+YbPF5cQwg7HHOJAJsAW
         BIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552679; x=1766157479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzRmGTG4hV3KDyAaywOrTlQOkI9HCeXuDyrMklg3lMk=;
        b=Pxn2ZD2eI5d4IcNT4glvZg61fnB621Mb6yOxU7uq5LwWnxB/bu/92e/dLnoKvyiZPJ
         ultT24AleEhojkPzUlopOdnV6fr6jJIGL0zTdfeP2tjkOWUpKPgFo7GYevvdaX6wO9JY
         DDhFdcsXhCkXIKI4vnpXAf+rdby5mPjJB4uCGskFSvhxCxmNxr05/Rp3mu6GTtN5izDL
         Y66O1RuU5MLR+Mep7ZFnD+CV7uYEeB8JaCpHahSoJQYOgb/NxtMMdDaMi9sjk4KX5+7c
         flN6ea/HXIxGtLiBBhR5FoBFM0EwOKT6hTZBIQRkMODWOjIFRUjD9WL4abkkPbLAj1XX
         tf3g==
X-Forwarded-Encrypted: i=1; AJvYcCWujIpEOaCo3hbNlXuNTH70QtzRbP/kTAP6/TLcNk6SQsIu4t4+aUlQSI5ZYUUu4vGK4Vq9yn0xng2HzSPhyn8g@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDawzXPvynbsLtRtJPbptq27FtdrEbiWdq1+aTDC2AgWgn15X
	0Np+WHqsbIq0tuAWWp1bRko5jMMmYq1wMIMNL54mXWYWt5zY7eOrrXbl2JS508Ely6E=
X-Gm-Gg: AY/fxX6TY4lmnnEVWQqHL3Bo0JsuGhCufR6ojIWLLJm8dMgcJpO1m5rlOIRHbfhg+Lj
	r/T2FCKPGn/BKL0ai5BTSBKGUprTlqEGF2Og9GWyv7MSef4DLcQcdM3qhVFuEI77iZJMnwmMNpf
	oq7STHiR9cvvP18LIfY0X315YCjwWDCQVFuwEkkyotP70EQeMYhSuosRRmhBKzOnXDIyRhps2ZD
	YXaTFqaHOtMUB/4dhRCM5BykS5yQ737CFeu9v2rY9kav+4Q2gUvBAIHCeK3tIfcEvK7oQOtA8QP
	2/nUmJSzBGNwg862xTTGvk0NaMaF56hMxK/yK3lk61tdWUAR/bPKAqg3FEH7eL9UKuZysE7dzXd
	3bQV0TtDl4+9+zzEH4BvCNwJftbGluZOvP0Mse0mgN+vgSbLg9wKEbrxGQHoxHVaiWJJPM+F196
	ZhIZTAYDO4YdtVFAh+7twv
X-Google-Smtp-Source: AGHT+IFyH9NQdi8zctX5JPNwdCDSFYgXLMEEf2zE5iVW5H4jeALSU6wAPw7+q+bUPn5o1gI0VfjuwQ==
X-Received: by 2002:a17:906:c155:b0:b6d:6d66:e8e9 with SMTP id a640c23a62f3a-b7d23aa4010mr238075366b.61.1765552679280;
        Fri, 12 Dec 2025 07:17:59 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa51754dsm604311066b.42.2025.12.12.07.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 07:17:58 -0800 (PST)
Message-ID: <6a642215-2834-4c27-b716-477d5444ad9c@linaro.org>
Date: Fri, 12 Dec 2025 17:17:56 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf mem: Simplify Arm SPE event config
To: Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Mike Leach <mike.leach@linaro.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
References: <20251212-perf_c2c_update_event-v1-0-29a26c7a949b@arm.com>
 <20251212-perf_c2c_update_event-v1-1-29a26c7a949b@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251212-perf_c2c_update_event-v1-1-29a26c7a949b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/2025 14:44, Leo Yan wrote:
> Since configuration fields default to zero, the zero assignments are
> redundant, remove them.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/arch/arm64/util/mem-events.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
> index 9f8da7937255cc9b14c3c58a1119b40bd0c76f6b..eaf00e0609c6c1b7d939a02fe3794471d1ed119b 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -6,7 +6,7 @@
>   #define E(t, n, s, l, a) { .tag = t, .name = n, .event_name = s, .ldlat = l, .aux_event = a }
>   
>   struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
> -	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	NULL,	true,	0),
> -	E("spe-store",	"%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			NULL,	false,	0),
> +	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,min_latency=%u/",	NULL,	true,	0),
> +	E("spe-store",	"%s/ts_enable=1,pa_enable=1,store_filter=1/",			NULL,	false,	0),
>   	E("spe-ldst",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	NULL,	true,	0),
>   };
> 

Reviewed-by: James Clark <james.clark@linaro.org>


