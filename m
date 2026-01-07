Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647303002A5
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Jan 2026 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767784735; cv=none; b=ZnZm5Ucc7sP2m3LU3H9QNwdhTVU3E/BdeHyTjN8eXRLWkN4+FYX9s5Lm4mJqXIXsf3LEjj3SoGqxP0OQmB4mjt7BkkzAmnizKVpZ+G3IIsu6j7foWWdpQnyI22oBCFO7GnX1BFK5N7BQPnY9H3eX29wPSSxsEUnCupaZvjhZZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767784735; c=relaxed/simple;
	bh=UzL/PJ4WX5vvCmozPZQyPzrvr5WcmTXDFYtGpKwmj3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGnWBv2EH2nJKR0b5oWz0SFNPjeV6yZ1aJqiUu+/du5WO4MURrzpY4i9nRp1SvTKvN6608jzO7vtJaL0MLNF9TseGYlA1xwW5wkWKXFtms8UtpeldEs4Ohhly0v6cnQF7deRKxdK2ToE4Fc12B+Hp/b3lL38vW5KySdF0KyDJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YMdcL6Ed; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMdcL6Ed"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso10831405e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jan 2026 03:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767784731; x=1768389531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srbwUVQpkv+2W+Dbx7qe/1cM4x/xUhCeQyLE/KUGFh8=;
        b=YMdcL6EdoDWZGOOLRcya/QGL3hJGE7SMHLN282Q4vEEnwJZL5zQEH0xgVx4UYov39r
         1KhLM4K2AScJhWtpzxdaU3HWWABPSSQOUq13QrI6NBdsnl9FeayfWzwc2u3we977FuaK
         fvmXVxrVRM/L89+c914ZCU4JcCbMYOf/bFg/LoF2Mg4KD53sZu+VuvnzG8pNirlHcZ38
         GDeAiGDwdzK4hG03kvUrOOXW6Ug5LNV2tDMTQ9YZq/Nu49ZklgvkeicszDC32IRjeolo
         0ruSjcWQ3OUfpbErzJcZc0SRyj69M7hiU6AzeLGD73sBhgggp2gMlTwdR6FOFfGv3xR1
         hyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767784731; x=1768389531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srbwUVQpkv+2W+Dbx7qe/1cM4x/xUhCeQyLE/KUGFh8=;
        b=Q1LASIcoiO9L/y24K6VTmEhhwSQvU1NLgyY8uOtpGsyXbKevAQqMNpoyx9aWVRBpZA
         dZFB/txFu06OdB4/zkDlByai7ZhttuKTlBs9Q5GV3DXVySzw0yG0Tz2LpsVG0XrainfR
         HYL02BVBgN6RIIJ+KcfHdi6GT/nCzNVL8asl3YwU/0Sa8kjgC+6fiXSM+zo8QJCq8fxU
         SjjScXRQ/W6zWyHfZzIxObOkqfpK2Ts6iYI4tKt3Mwr65w6L079oV9Jxq72bFHGMk4yJ
         n41S1BUeB2dPcNJD4DXXUMCXChuXefQhSy/YhoP9UBLIAPYnzLMEyHUQn7ANTrIc9Vfk
         cugg==
X-Forwarded-Encrypted: i=1; AJvYcCVKisITsOqqBgFnenHwoEBUZ8P8ylr+vkL0jrSXrQpBKlFKjBlUMbMNmo6rq/m45xMMo9hCbJwiOwD3Fuppm3Bm@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIxexqDlrKJ+QSTGdWl+HkfpEXZQGlBjgpfX/5hg1FIlmSLFt
	vGTQ13rEp3R09Vtuk+6VTSF0fGSobUs77LUYhJUz5l4lSv1/rQox6ztNgYKBQFTd8bc=
X-Gm-Gg: AY/fxX6vUIUwc84wxDHSBZUp0A1e5MUe9IZom1VMI+BOjjDdfKpPbQHgAgltnLXQVIZ
	3EOjHzDAqFpMQS7bNdRyezVtn79URGxqdHL9Fzq84fHV79xmU2/IAaMRbLWgR4MMSuxsz0vEe9/
	KJmF6a9MnPS0W4oTxR7awmSxvON8IBzHwwWKJacsMULEZmSCtOghM3PCjdnPzhe0MkpD2A3HmYN
	J3wbPZYGvKyi3UwVJtO8iCW2NDFkYMUbwJKzQ4c0SU6pY7F/kADHeo9psL1OThz4jtVUABNI/cT
	tjspYWjmeX9HsVF60FnjQEG3miEoJhqSARfyarwkPQMhe3BvAzgvNvslcTrS5cY2CzU+t8AVY4/
	xwrZQr67V4f/uOZ0BoPyFa1f1/OZZsMxGimYs7NMeHfeYTSivP+++3Q49/axLQm2AH1IFb0Innq
	PZyWdgEYaljPkjQjWW
X-Google-Smtp-Source: AGHT+IF7EjuXmJ0ve9H/QLz/oTWRNqAcHjjHlCUVmQM2B9YbMCKHWx1rYN0YOb/SGupVlIzvpJ0L+Q==
X-Received: by 2002:a05:600c:6287:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-47d84b17b7cmr22995235e9.9.1767784730654;
        Wed, 07 Jan 2026 03:18:50 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636cb0dsm12891305e9.0.2026.01.07.03.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 03:18:50 -0800 (PST)
Message-ID: <2e0d7dce-a52f-4825-990e-f4bdaa1175ac@linaro.org>
Date: Wed, 7 Jan 2026 11:18:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix test perf stat tests for virtualized
 machines
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20260107094835.131882-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260107094835.131882-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/01/2026 9:48 am, Thomas Richter wrote:
> On s390 perf test 'perf stat tests', subtest test_hybrid fails
> for z/VM systems.
> The root cause is this statement:
> 
>    $(perf stat -a -- sleep 0.1 2>&1 |\
>                    grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]* -c)
> 
> The perf stat output on a s390 z/VM system is
> 
>   # perf stat -a -- sleep 0.1 2>&1
>   Performance counter stats for 'system wide':
> 
>         56      context-switches  #     46.3 cs/sec  cs_per_second
>   1,210.41 msec cpu-clock         #     11.9 CPUs  CPUs_utilized
>         12      cpu-migrations    #      9.9 migrations/sec ...
>         81      page-faults       #     66.9 faults/sec ...
> 
>         0.100891009 seconds time elapsed
> 
> The grep command does not match any single line and exits with error
> code 1. As the bash script is executed with set -e, it aborts with the
> first error code being non-zero.
> 
> Fix this and use wc -l to count matching lines instead of grep ... -c.
> 
> Output before:
>   # perf test 102
>   102: perf stat tests                      : FAILED!
>   #
> Output after:
>   # perf test 102
>   102: perf stat tests                      : Ok
>   #
> 
> Fixes: 65d11821910bd ("perf test: Add a test for default perf stat command")

I think the change looks ok, but doesn't it fix 65d11821910bd ("perf 
tools: Add fallback for exclude_guest") where the existing wc -l was 
changed to grep -c?

> Cc: James Clark <james.clark@linaro.org>
> Cc: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>   tools/perf/tests/shell/stat.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 0b2f0f88ca16..792a0b79f6b8 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -233,7 +233,7 @@ test_hybrid() {
>     fi
>   
>     # Run default Perf stat
> -  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  " -c)
> +  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  "  | wc -l)
>   
>     # The expectation is that default output will have a cycles events on each
>     # hybrid PMU. In situations with no cycles PMU events, like virtualized, this

