Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25819B3E1
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556021; cv=none; b=hwMoLhEuOoJ1Wg92vR6S8AcDVSNFJ9wIitlqP12t6/0rn1+1Wh3UHs6R3m1Q0EDBwSHxHYV1WavBkN5nz7UsUg8M49KNUyCRbT1FVtErGQLsM05dJOZv1L4NWdXlcmm85VAainRz0ouYeg516V5Jw6qy90NYxJTeAD9VtoTnTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556021; c=relaxed/simple;
	bh=NUzJM/GvLcGzCn8m+3i1wJUpp8MPTSk9e//+pExkHzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOuUrJYn+fyn2egpzzZI21fV8DW92/ptE78bacPS2UxT5u/riwkuG62fLFKvRl5gxj3NlWZzo13FSuoOdkMLbgiNJd98kWS8ObADKS3bGhS8ePHl3tF59yh8ESCerd1Z7pAsUMW15f6tdy8F2zMddo244RgSCYKUtrNs0vsNTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHIxozYJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHIxozYJ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428119da952so38916985e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723556018; x=1724160818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blnF+SdPapTZEU9MsVd32ouo1/9eYNSeUZmt+Hr0sT8=;
        b=RHIxozYJAdL3QxGQLuYwNERI4bYyqEqoHRVUs43c5ReN2iVjdEYu16gNTJgR2M3IQF
         2WeKQQVXFJJ0srGOLe3W7HzgeaI5c78k175SOQYXYO7BuUZR5JxTy+AMxHjwHwL0wTaJ
         thLqveYhFhmDCunDr6XCqaQJV5GzqeSuQvCrNlYQT1JdCI+3tivZOsA6QmGF+zV5sqvs
         CB19m0euL4+8ruaKRyINyUoajt0Qx8U33JOYIM7RQB2KZqI923mhkw2PJxI6VvJ1iBrA
         jlT2m6/TVMCVbdUfXLkrDe9VGxYC04L23laPSC8JrmvxfbrxSQdS9FzCkhgZAP2oHuRD
         eLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556018; x=1724160818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blnF+SdPapTZEU9MsVd32ouo1/9eYNSeUZmt+Hr0sT8=;
        b=S4Pw/GKee4poAfPuGwPoykLWtl6o0v5m5OHuRPitNGqT+9xSLaXSYAJbUaAYLcVirO
         y3tAc010MB/+IOqsFyzdCKFwZTyjFwAPiq1/5U2fM98H7trDL0XeuXpzUPH9b4Yk36tI
         hY5l3jvdtDap/tELetXxCLJlX1gLmMou/HRs/a6dH/M8Q9143HwIVyvhO8pOYhdflmMs
         uyiolHp/HNJbvmV3ihgjcMQU2IvR46YGNYzZQyDxgfcJA3ZqEKfTS+TSfeqxigb+VOhq
         0mCbQPPRwMBxcNGOV+6cQ5G1KiPYFpdJ6zfbZ+/QlyI3YsxOOf8ehShOdIqpQ8T4wAHL
         g7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVGoYjxOxUInT9DSzoV7mcM8X8VwD/zv0dOjKAlp77C6K+RONHzWbwl8+tgYGa2+a7hVgqx++FpAUwOq9X0KBKAhVLC2O8KNuFXWczEufe5+g==
X-Gm-Message-State: AOJu0Yxd4pCuX209iu+ZT0mQxAVtqWN++WvUWo395xBhy8+FxZk88UJ/
	RYHgPocSqgm3qhuQ0UwshXmKePF2OsXGr02uxyOl/vPE3qDAMyOI6NrL2xFHVl8=
X-Google-Smtp-Source: AGHT+IF0uGrRR7ZTGnQGQ51jKZOJySZ2yoFMxi1e5EZJfGqN/H8HsMXe/0fLFQwn0tC6OvUNOaOt3A==
X-Received: by 2002:a05:600c:1c27:b0:428:1965:450d with SMTP id 5b1f17b1804b1-429d4837e17mr28119195e9.17.1723556018249;
        Tue, 13 Aug 2024 06:33:38 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c777017sm225862565e9.35.2024.08.13.06.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 06:33:37 -0700 (PDT)
Message-ID: <eeefc653-922c-4ca8-b038-82bb6c4bfb6e@linaro.org>
Date: Tue, 13 Aug 2024 14:33:36 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] perf evlist: Use hybrid default attrs whenever
 extended type is supported
To: irogers@google.com, linux-perf-users@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Yang Jihong <yangjihong1@huawei.com>, Ze Gao <zegao2021@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240813132323.98728-1-james.clark@linaro.org>
 <20240813132323.98728-6-james.clark@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240813132323.98728-6-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/08/2024 2:23 pm, James Clark wrote:
> For x86, a hybrid version of ___evlist__add_default_attrs() was added to
> support default perf stat events. This can actually be used whenever
> perf_pmus__supports_extended_type() is true, which now makes default
> perf stat arguments work properly on Arm big.LITTLE:
> 
>    $ perf stat
>    ...
>          3347093940    armv8_cortex_a53/cycles/    #  0.563 GHz  (98.99%)
>          3295523067    armv8_cortex_a57/cycles/    #  0.554 GHz  (67.07%)
>    ...
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   tools/perf/arch/x86/util/evlist.c | 65 -------------------------------
>   tools/perf/util/evlist.c          | 65 +++++++++++++++++++++++++++----
>   tools/perf/util/evlist.h          |  6 +--
>   3 files changed, 59 insertions(+), 77 deletions(-)
> 

[...]

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1417f9a23083..e0c31399beb6 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -5,6 +5,7 @@
>    * Parts came from builtin-{top,stat,record}.c, see those files for further
>    * copyright notes.
>    */
> +#include "pmus.h"

Oops, this include was auto added and isn't required.
