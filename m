Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9A3F6C2A
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414950; cv=none; b=XRj+xKvNp7R9rfxk5TbkJE69cnltH5vn6wMuIiU8USxz/e2T3tA4g7Saag6DreX78QJ9yG9UfwZhz+FvxCO+OKh8yRbcRHTEnmGz9jv/64uuGj0y9xi3HARxoqE5f+Hd16tQ/ss/PatNXMxMUQ4ZjOU7CdcZSfnducifxn5cIg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414950; c=relaxed/simple;
	bh=ITGubtGNjSygiFFFgjcYQsMniq1IJVNmaGpLd6Hctno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJyFALz2861RBNST/bwoR8sqXs+jOptYPcmBGkHgsAH9KlCHAtMG+dhmuh0PVc93jAofH7SAwH37fa9i/aQI5Oq5FG08Hzy0A5QWV1iU3IGaQIjRGC0sb8M+XNxzZbNOW/mbckIF3mVytLP9Dca2O/MlICQjXZvm1otKIizsXt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eu2K9O4V; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eu2K9O4V"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c34bff61551so286953266b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792414947; x=1793019747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O9/kdLN3peEHedgTST7BmoC/amAyj0eADKM6T0Uw2sA=;
        b=Eu2K9O4VznZMFk1AXlGIlIYy4+kG7PLuf1qCQsfBF6nFMwvfyxX6J63U09xH4YfG7a
         +xsrPTNgH2rDwGjiJBqYHUIqFsitoidIa03Bw67u8asMl03yueH9uRCqQ9zzkpJZEPyD
         AkyuXgAUSzlvTT2Au3mi9AUmjUw37Qc7xKn6qbHPNA+HopblxbYruKhBiWFWfbnew/FN
         EFAJ5idL0+iK+KDXdmLiS1cYsZSztvY1rc9q9KtTD8LhFT+dDXGu30nwUChuXz5q2Dqs
         xY4Jo2vNyjVpCAlg9bK14Z8jKLxR9F5bktKR9BMqHoPlOHXJEu39+5cGbuCzwYot94av
         liEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414947; x=1793019747;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O9/kdLN3peEHedgTST7BmoC/amAyj0eADKM6T0Uw2sA=;
        b=FDfFUahg3M6/BJW0ho9sqTDUefOvlLAOcz8nFYdVVNhKgoTIrnXfz1xxxeLEyxi3C1
         RYE9A6TEPNim9MWzd3Yu4FQwgJ44lusGArlNbGJG/WP1kva14qIKy6FVnYPJ4n55ykvk
         rDpm81jINJx9kd7/Lrus6ld94+4OWsMmb9cYp8GqI6qDnFKQxUqFJFFjjJe/1lRDdT5f
         g0bF20RWxBhUc7rW159vU5fBg0i9cgo5ZsKUbEuL+OtnZQwUDy6IVgMjHDbabqp6gI10
         MMKKi4kMgw6qkFtuyMOXOUgokw2p2vxHSGt9cNn3oYQK+lPt6MtKNnOB089BE6duKCvM
         Ctcw==
X-Forwarded-Encrypted: i=1; AKwUvBwlBushuMsYSQ3A9tm9o1orcwrqIIm5i2P/5WseIilsA/JNP7zq/CUMVV/WBUvlVCoDzddoVK3+2wRWYKj4UOqg@vger.kernel.org
X-Gm-Message-State: AFq9FYJU6/laNIPjszXZkQgOfmmbaKaoYDujxgTZ3jxURE8beBCsxvXK
	lSD327c417ngZGtn083UVU7q3icK5wqp8NSZNLehF6/A/0XmC16jETCd0uW0tonST8o=
X-Gm-Gg: AYBFou201g3FpYm/7xJK0I6ZwX1v0oDR1S1YVDeOAIUo/yEk0BWxcuB3nLJeJWNmRxT
	sWqZS5tnauicES4ZLguLBnezFZFlhQ/9VscvLNiSRUqTNJKtAXq2grOWQFeHUq/rs+YZZCU8EHH
	qC/RPc1AMIXhzSMWsuHAdFBT1FDjtoo4VgbOjMl4wfVfRCxozgkbu+hOJmiOfoCVY4DV4zmefYO
	tjlKHvjolF2hclBjUlYzFWxBncKnWlZHqHFQEifE+lzrPhg48st/jAb1LqoFi9p8VHi3jDCmagP
	9I1Epj+QXRTmCDS3+ksinsJk8r4YeztWtENqcvdqc5BGRrlVIcZw0U3vOf4Z59zrGNHKq6SjSmZ
	w45axzBnf39y6OCuubGBeukuSM8UdC0WEGV6lM83OWhEU2d/f3Qkgb++J7aJPoyDzrXA4L1Yry6
	2b8VUXd/7vd0U7zy6bhYW9grSHeyQLQx4YiH8t55GzhPaFOqF+2c2ZrvxE1SbG6vJu68OgTwoXD
	Ic=
X-Received: by 2002:a17:907:b046:20b0:c42:102f:15db with SMTP id a640c23a62f3a-c42102f3704mr293529366b.34.1792414946853;
        Mon, 19 Oct 2026 06:02:26 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd510201sm24019139f8f.55.2026.10.19.06.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:02:25 -0700 (PDT)
Message-ID: <5a438ddf-4e6e-4c7e-b6e5-0434f9d9dbe8@linaro.org>
Date: Mon, 19 Oct 2026 14:02:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/25] coresight: perf: Serialize AUX pause and resume
 with event stops
To: Leo Yan <leo.yan@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
 <20260915-arm_cs_support_aux_sample-v1-15-35cf6f297d20@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-15-35cf6f297d20@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/09/2026 16:49, Leo Yan wrote:
> A PMU NMI can throttle a group during an AUX pause or resume, stopping
> its CoreSight event before the callback finishes. The callback can then
> restart tracing or reopen an AUX output handle after teardown.
> 
> Use per-CPU atomic STOP and AUX bits to serialize these callbacks. Reject
> AUX operations while a stop is pending and defer stops until an active
> AUX operation finishes. Complete deferred stops through etm_event_stop()
> and set PERF_HES_STOPPED only after disabling the source and path.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 104 ++++++++++++++++++-----
>   1 file changed, 84 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 8f803914e9abfb18e080ff68371ad8b32042f180..8020a4d8af18bb669441824cfdb687f4fa299eb4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -4,6 +4,7 @@
>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>    */
>   
> +#include <linux/atomic.h>
>   #include <linux/bitfield.h>
>   #include <linux/coresight.h>
>   #include <linux/coresight-pmu.h>
> @@ -26,6 +27,9 @@
>   #include "coresight-syscfg.h"
>   #include "coresight-trace-id.h"
>   
> +#define ETM_PERF_ACT_STOP		BIT(0)
> +#define ETM_PERF_ACT_AUX		BIT(1)

No comments other than naming. But would PAUSE_RESUME be better than 
AUX, or at least add a comment? It's a bit ambiguous what AUX means, and 
etm_event_aux_begin() is very close to perf_aux_output_begin(). Or maybe 
ACTION?

Reviewed-by: James Clark <james.clark@linaro.org>

