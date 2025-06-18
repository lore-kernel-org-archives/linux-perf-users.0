Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56025CC7B
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750235342; cv=none; b=Ej8aODPhI+4MrAIeZ6Izvj+1qXhE7zF6onPiqORW6bHB406tvBVf+t++CSKgvx4rZKxmnLDaiZSI1gNH/OquHwIC6C3OOztydUkbfFogbfWZHj62QGdE6LLcMuilRipAEbhNymdXbNiDkGnUaYJqQhBxYhJkIsi5d9g7Nam0DT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750235342; c=relaxed/simple;
	bh=aAQahM2nioQ9Gls/T+c0FETRDrE+kZs96QLGJ8lrCzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=AcR/0H+djxN5sRgVwPmfnsk+0QxwpjpleAmusF52A3E2NeRzHa0aztzkJlSxOv/QRIZbF3IQ3CTKZ5nHx5n0XfvFNLA9HjGajIFKjskH5P3SgxkzeFSj4hJHVVSM5RTZe/ZgoNbB2RgdEDisI0cvstAjaWGqOcqtXnbkmG/x+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+EYnoHs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+EYnoHs"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so4954777f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750235339; x=1750840139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7gcJo3/wfaTJZNHwp70Ko9JmEHSNZ37Pbopm46n4G2g=;
        b=r+EYnoHst+B2UGLZ2cyacN5s2z3AoA+Fh4wOzhy83zzlZK8F4ES7mGsMwuzg+ue7bV
         p9W8o/vegpuiG3lGFchZZXVUAHVZT+Pc8Lb8vNolcIZZNIFm6taCPgWVm0huw4RH2DP5
         1wn+ZHKWoxiTYYM8duRP9VRUD7a82PyrftD0aTI9w+VwF/CBPf/iIneIjMiSftAjczSY
         5hEuzACmvficjhyKLKgWbMkPPu6lMZ680z1nd9M8toXQNBPGk8kFqyh54HVD1n2rejzH
         BBE+z/NQNV6kcyp8X/5OaZp9pDqpQHqFz/8lzJudHPftZJLqzAkSwNLG1wFe1HnQrie/
         0uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750235339; x=1750840139;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gcJo3/wfaTJZNHwp70Ko9JmEHSNZ37Pbopm46n4G2g=;
        b=Q/25dWMQ45KAKSEC580yteG4P3atW/vFndHfz66Q4JI5611g9YtNgnmTlQbL5mTtLR
         UJpj4i8IbsMQqIaEiKBZWZOCBqsU+jajELBgcvWdmJb0Udlnn4d0yjeVy9nlu/+cwfRq
         FI2jHfVSthgiGBJaAMkrejK2md1f4vyCt+ZQZSG20dt2nmMYij40rKcMsOP26fZ5m97W
         8RDDW//unSP6A8rVhNccToEX2kLYKqaNvrcY1Lu0HBNhVOofChXrLWTkJaU25QMKBCi4
         zPc65jluBydRaKxjv8mDKc/0Y/SZ5mofMkYT+zQBYS/81/ynrqJqNEsL9jJXoGpkI3eI
         q9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWm5KGyxPIm8LKAILkgn5NZ2jwz7dFGMm1kQqzncHRXSsDzsH5dUJczN9+Pya7p+qlUkHpbildnSKu+aYh9fqEv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0uG9F4fRYtsrWffXwtOB769cYPw6i7QjBtxyE0RW3xfes6F6o
	MSInec4mGf2JaeTb1Uko9E1DRloMLkScDlMIs+qRXR3oEXKnWH9112MrxFDhenSPVcRv6bAUYhv
	z//tG
X-Gm-Gg: ASbGnctg32rNn//dM94GWcTv/MhUGkMtI0XNMFpCUurDCW3RwAMw62Dq20DqQSLHtkS
	CQmvEZbt1Xydz0i8HUaZjOy3xU7aLRXzF1OGK1a2tyXPmySr7KYFMxepea6DtJzbBQnBp36+bid
	P11lDFYgMpDK/SBpWUEtKoUw2j0rS6PWGZP3EWDfboR9MyhdqpfZIcHFuE8FYepbYTHh9cVwVY9
	JA8ylMlG1QOJFeRQmsMphJdSjZg0Rx0JtvuW8Lws7QZhd49VaoTZ/Y7g46bH1vMZpTaDvnF7miA
	crm5wAfgwyjDLQ5GFQ0c7xvXbcL/5+zcaF3+Jz553JJXgjKBVmGdM7MsFgcZ5GFFF8HZsXhq3iz
	avg==
X-Google-Smtp-Source: AGHT+IGpz2E6KVPtFNpmns5QY+sc36eVwHYTe8Cv7AENssFnzG+4sIXaEKXOzytVt6DU/O/AkTkN3A==
X-Received: by 2002:a05:6000:2313:b0:3a5:51a3:3a2 with SMTP id ffacd0b85a97d-3a572e9390bmr13067498f8f.45.1750235338630;
        Wed, 18 Jun 2025 01:28:58 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54d74sm16476380f8f.10.2025.06.18.01.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 01:28:58 -0700 (PDT)
Message-ID: <0060a6d7-ceee-4ecd-b4b7-1c9fc422efc7@linaro.org>
Date: Wed, 18 Jun 2025 09:28:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: Update FUJITSU-MONAKA pmu event
To: "Kotaro, Tokai" <fj0635gf@aa.jp.fujitsu.com>
References: <20250618063618.1244363-1-fj0635gf@aa.jp.fujitsu.com>
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
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250618063618.1244363-1-fj0635gf@aa.jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/06/2025 7:35 am, Kotaro, Tokai wrote:
> Update pmu events for FUJITSU-MONAKA.
> And, also updated common-and-microarch.json.
> 
> FUJITSU-MONAKA PMU Events Specification v1.1 and Errata v1.0 URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Arm Architecture Reference Version L.b URL:
> https://developer.arm.com/documentation/ddi0487/lb/?lang=en
> 
> Signed-off-by: Kotaro, Tokai <fj0635gf@aa.jp.fujitsu.com>
> ---
>   .../arch/arm64/common-and-microarch.json      | 70 +++++++++++++
>   .../arm64/fujitsu/monaka/core-imp-def.json    |  2 +-
>   .../fujitsu/monaka/cycle_accounting.json      |  4 +-
>   .../arch/arm64/fujitsu/monaka/exception.json  |  2 +-
>   .../arm64/fujitsu/monaka/fp_operation.json    | 98 +++++++++++++++----
>   .../arch/arm64/fujitsu/monaka/l1d_cache.json  | 10 +-
>   .../arch/arm64/fujitsu/monaka/l1i_cache.json  |  8 +-
>   .../arch/arm64/fujitsu/monaka/l2_cache.json   | 28 +++---
>   .../arch/arm64/fujitsu/monaka/l3_cache.json   | 63 ++++++------
>   .../arch/arm64/fujitsu/monaka/ll_cache.json   |  2 +-
>   .../arch/arm64/fujitsu/monaka/pipeline.json   |  6 +-
>   .../arm64/fujitsu/monaka/spec_operation.json  | 12 +--
>   .../arch/arm64/fujitsu/monaka/stall.json      |  4 +-
>   .../arch/arm64/fujitsu/monaka/sve.json        | 44 ++++-----
>   .../arch/arm64/fujitsu/monaka/tlb.json        | 56 +++++------
>   15 files changed, 265 insertions(+), 144 deletions(-)
> 
[...]
> diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
> index a3c368959199..2ffdc16530dd 100644
> --- a/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
> +++ b/tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
> @@ -2,7 +2,7 @@
>       {
>           "EventCode": "0x0105",
>           "EventName": "FP_MV_SPEC",
> -        "BriefDescription": "This event counts architecturally executed floating-point move operations."
> +        "BriefDescription": "This event counts architecturally executed floating-point move operation."

The original was more grammatically correct, but the updates are just 
from the pdf so:

Reviewed-by: James Clark <james.clark@linaro.org>


