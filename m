Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029938E5C4
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Jan 2026 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799848; cv=none; b=O9vcZnfkbDK4kLr3fb/dLXOyZ7j8yGcnansb/2juuYJrR4NuZAC+Fb3vow1XZkDeMYywP4LQpwNKzdD6mpjbTNnxw8j3mPrdQk29kg1aSi7EaIMYA2fi+YZYRPzp54gunc11sfO4hejJXYQo42IkvfV8tRqj6v9jpExg43ib9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799848; c=relaxed/simple;
	bh=XcDHx10sX8oLb9R7Rhid8fBEzd+m0NfjUVZMeK1MvGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVIfxYfvA91t118vW+ZHpoioPX6laIjE3DQsR1h6kgGM2dBFBI71G7ekqxMBjhyashF/os/xRzknznsZBKHO8B/j8ZpUpnhWLY+e8TDI+uu1/EvV2y9UmcWZYRVXUgRfEAbB3tY8w8XIZmXXNM5nq67Mcmaq2cjd6k3JODdbaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mOfgn3/N; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOfgn3/N"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so13878465e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jan 2026 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767799845; x=1768404645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHGfPhW0/+pgaqgtqCOg0hK+5TIuHwlL53RiB3ex3NQ=;
        b=mOfgn3/NiDzBlW9uj9eGYJ18rLQdi8wcFXzsQa9yuLxesJWgRPEByYC1P8yQ4ncqCp
         +/+UreKKDCsC3EBgGq/dCxJMCuuDroa2LqJK/GT7uQSmzgi4YFzn/MMmsyyy6TpupK3q
         6GNeCLf2WePrs0PMtIUBu4EB4BwTG6iudv97kY6hZwlLlDmf2vjMyesCFCUUHcRV6DTR
         vpy+0TCsc8+NiN+FV887utmUNSNseVYR6OohR+6YPp37L22+pbOeS14cHN7E0AiRS/vK
         +outSLauiDKpec52itlp76O3ODvefKzUmwY+1GLNqrN2s9A4ccTQD9B1MYmulMwy02un
         IsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799845; x=1768404645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHGfPhW0/+pgaqgtqCOg0hK+5TIuHwlL53RiB3ex3NQ=;
        b=pY9bC5pFrcLAAvrBj2xVTNmfTSNQGDcOSkqoAHzNDjf3S2rn2I/9DMhpW262B1mXuq
         sFMo683q6X3As7+MrtcxQc7DwMAuxZO7RWrEeJpX8TCTxiNzL/TuU79qNnrT/9JdgNYy
         mNqkdh0XpCVssG4nk8gTv+5cynczx4HtLoee3tBdn+slH9qDlgkyss6oyLBxhG/hQ4zb
         eDcxMLSbP36G5EXW2vNxXqUGgSUNoex0b24SM+GOxLfuNHJ10YgSu8wrYeqia4kgvVog
         9uAEjTt1GZo3IQ1LedX2+5VFu/yowOeTzqewCdf/+GO6zsfc1MvaQeb88F2gQvdyA0cF
         xUgw==
X-Forwarded-Encrypted: i=1; AJvYcCXQUTtDFxh9S9u7iqwGMTw5P3O4asK6S5j2NhtGuADfo6mkX++OHRyCJI0hPAwd3IB1h/B2uHJT01TZNd9uj8rc@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIYJHbEQfxCo4gdapIdQ2oGjSlUomieX26KLCyCyGNraRvjxx
	neS8p5cKwfhZAf2x8nInexD79m2nv+xTXHa4KWWygHPMXX6r+5dhqlpJX+9Ww2BHYFo=
X-Gm-Gg: AY/fxX7yc1EGkSAM4Qdc7BCXfVlpjAaB+kI6FbVkBQjYWNhDua/q0t8Bu7Sr/1Udwjx
	UkdVkBGQ+xmehTVcRpLkWS9N01Y02yldd7t5frNCMHoJWuIFwd15d6oX7oOQeZ9nHAzrMKLaJMr
	QI3asgkQLwMhNf63E7+AomsgLEDe9zbenTeLRfbzNuCeePAvwI0kdwm5QODYXj1feujaBeN8TZC
	h5lb2fI2/+lUBQbbmIGmUqcH7V+kK2wAlFm/dfTYUS4eDqpR1E7gJ4ZkkhatLut0vDl8JwpX60H
	pkhogyix8/0+KKcngX9rCb5zl1AXKErMEcRrSavkWs6oAJxL+yGvAwAGE4JmBa3ObVi+ICF4kOQ
	gvQOr44D0wGA3vFd21CrDsEVADE6P3AAaFEoA2R7z65AmiwPVa0JQ/ChdSrWmU82GPR7nX4y6th
	Id7YN+UxueA/VOy+Dw
X-Google-Smtp-Source: AGHT+IFNREUOPuOJOZyLsfeADwYVJTbHJc8lMgS0mXs7Yk8BGy+5L7YhYPpD3oXtahRtB2DbOKUIyA==
X-Received: by 2002:a05:600c:4fc6:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-47d84b54c52mr33697625e9.21.1767799845038;
        Wed, 07 Jan 2026 07:30:45 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm10820971f8f.21.2026.01.07.07.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 07:30:44 -0800 (PST)
Message-ID: <eca46457-0e1a-43b8-b6ac-bd61a7a273f1@linaro.org>
Date: Wed, 7 Jan 2026 15:30:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf test: Fix test perf stat tests for virtualized
 machines
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com
References: <20260107133216.2070400-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260107133216.2070400-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/01/2026 1:32 pm, Thomas Richter wrote:
> V1 --> V2: Add correct Fixes: tag, suggested by James Clark
> 
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
> Fixes: bb6e7cb11d97c ("perf tools: Add fallback for exclude_guest")
> Cc: James Clark <james.clark@linaro.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
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

Reviewed-by: James Clark <james.clark@linaro.org>

