Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B23BE15D
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171630; cv=none; b=Y8V58bF3Qi9dT8S14fAnjl3xmtVO3Z5uces82rHCxo58/GZlD2iVvHyLR0/qa9TOCSm9GoLq6P4AaBUG76Qso4DhfEgDs1redTtxioUc/RZwnW5AGCaboL/TH21v3CJp+FCsGwqZ3pXWbicbMFc69bDEx1JFh2uetwlz9VlEhyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171630; c=relaxed/simple;
	bh=LRum0Ff78FRW/YvBAIwggh+9yF+4yDFHMY112SZ0kwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNd5+jj2j2QZ3im3hYTTvAUnIOwMRcPVCmEZ9x62TPDkgDsuWwluzPdURPJNwvy/iBvOCuSJ7Yz87RvlpOug2Q3KyQvvWHmSnkb0i4x8Wq6vv68HRzeq5QRKQUIaJy3bHypz7B04J5hsa5DCBq5pI3wTG082t1zUWzs5VLR2Ai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6BgV8me; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6BgV8me"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so14637812a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 02:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781171627; x=1781776427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1QAoLwwTxX4/pbrqRqHCbuqIgAJsjGqCkG1Fp52mE8=;
        b=a6BgV8meM0ooJsGQcD+qCPSwwYpz2T3H0WlzgAn5/GZPoSyBLCYpHINStBrktjzvS0
         pPJQDhxUmYEpjBkX9O3jwr5txuP8DSizfgxy4NGYYrS2jypTcTU5YgW+iwRhw0MW5J44
         MGP4prlVSIuHqS45ZTgD1phSS2lto4+KFj8IadqoPXZqDMhIkvbO5RtX5CeSzxbcNYT4
         A249nBk9FIBBflbj0Amrz9HEY1O2RU22rULVj1H7HsQRJ8Wx4W00GoTT8AwV4QRoCAfd
         OyVWqdBf0p5NBJKqyp1NHn/ziGffxE/Byl+nvaTSqwk/HlCF9dxUSS6Jmr6lTnkTuoud
         4JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171627; x=1781776427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1QAoLwwTxX4/pbrqRqHCbuqIgAJsjGqCkG1Fp52mE8=;
        b=bAQs8not3+d413itqzUoqZAnAGMfr2xuKdyzHrTJcX+6SiZtbTjjCanLaLdDMaBYxG
         9jiXPvJVoUVqPuwnzLyoaGILCX6WmToGb3bw1sTmomAG+SIQygLLgk9aGII2lyOrMpDy
         tAO0bKw2mPfjFA4MDFbZaFKk5WArzk0s0Y7b/51EZBYT3AoGfv+ZqJP7wbb20oWrenIi
         bniC0G3Enolu+qdVuN/+XLfxoGe637hLO8MD2ASX+Jhx3RiVJTzm7TuMq92UTDN8fSRW
         6u8hCaBaDPqyDsg8OLhGzDdwMMuhlrzvU41omZjJzZ25NI0wVBG5+fj/BQBEzO3TqAPH
         9W0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/JzC0nsmFSWVkSUWvYNwbXES1VqjH/z7UVRT4reqdUv1pr0vnUH+CDm8NuVBwip6GblkC4Bt2WjVKAb+ru9Qig@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9t02Wnp4SArR7axW+A+u1G6A+YS06LV9L4/T1Xu47gblqOiK
	a7Ig7aLRgBjantgPqTAhhH3yRd9kv9tGHc/MsLOEnEWr5pToKQb9eOecyw6oGllqIVw=
X-Gm-Gg: Acq92OEvlR5Gu/0ktFUv8r3OS2L0fZ/kcH2RFwvRfl6MNVi3P47FZbggm8PSwW5H2yB
	0dItWhrbAsNLg+7JcD5kWACRXb1o71wldoqwY2UYLwD54DwTgs/UH1ia2YgdYlZfJSweebMOnsW
	UKjGI7WGKx4d61gT5MrzwvBkwEJn8RYKthpoMydkxwiYdBQak60UaWrUEUmOLu7RtLnOABydEE0
	zeoP01aIswMZzEOwk6GPqziJ8KMmX3wq2vEDjthqcPgsuVlvGdzQaJfwdhST3xY2J32NxFWawga
	EzyBPHwXvUMtjZuNuzoVs63MFNQALCtqFr30vsq1ALrZ3jTpuqnV5tLdbLooncOPfxy09+ihx7x
	x+fZ1Ttnw60wT59KrrDQppdP9FoDxOoIYU4gohDpBz6S1lDHKKDbZF5R9WqsXhEE75EapqNLudR
	jE0qoSXaEcJ+A/7RoPj0jY0W5Kw5m+hSr+JeG1RYJ8HnAqna5ccg==
X-Received: by 2002:a17:907:3f28:b0:bec:d5e1:5aee with SMTP id a640c23a62f3a-bfc86af7f1dmr98693666b.34.1781171627002;
        Thu, 11 Jun 2026 02:53:47 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb53c3587sm41720466b.34.2026.06.11.02.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 02:53:46 -0700 (PDT)
Message-ID: <852cb751-030d-4b56-853e-db0ea277faec@linaro.org>
Date: Thu, 11 Jun 2026 10:53:45 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf cpumap: Fix buffer overflow in cpu_map__snprint()
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20260611094149.49731-1-dtcccc@linux.alibaba.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260611094149.49731-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/06/2026 10:41 am, Tianchen Ding wrote:
> When SMT is disabled on a large-core-count ARM64 system (e.g., 192
> cores), the online CPU list becomes a long sequence of non-contiguous
> even numbers (0,2,4,...,382) that cannot be range-compressed. This
> string can far exceed the 128-byte stack buffer used by callers like
> evlist__warn_user_requested_cpus().
> 
> The root cause is that snprintf() returns the number of characters that
> *would* have been written if the buffer were large enough, not the
> actual number written. When the cumulative return value 'ret' exceeds
> 'size', the expression 'size - ret' wraps around to a huge value
> (since both are size_t / unsigned), causing subsequent snprintf() calls
> to write far beyond the buffer boundary, corrupting the stack canary
> and resulting in:
> 
> WARNING: A requested CPU in '1' is not supported by PMU 'cpu' (CPUs
> 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,
> 52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,) for event 'cycles'
> *** stack smashing detected ***: terminated
> Aborted (core dumped)
> 
> Fix this by adding a bounds check at the top of the loop: once ret
> reaches or exceeds size, stop appending. This follows the same pattern
> as snprintf() itself - the returned value may exceed size to indicate
> truncation occurred, but no out-of-bounds write will happen.
> 
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>   tools/perf/util/cpumap.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 21fa781b03cc..8328f18b7a84 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -680,6 +680,9 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
>   		struct perf_cpu cpu = { .cpu = INT16_MAX };
>   		bool last = i == (int)perf_cpu_map__nr(map);
>   
> +		if (ret >= size)
> +			break;
> +
>   		if (!last)
>   			cpu = perf_cpu_map__cpu(map, i);
>   

I think this covers up the root cause a little bit. It doesn't fix the 
human readable output by adding truncation marks "...", and it 
definitely doesn't help any scripts that are parsing any of this output.

I checked for usages of it, and it is generally used for output but 
whether read by scripts or human we can't know, so we should probably 
make it always output something sane. However, there is one internal use 
in evsel__tpebs_start_perf_record() which uses a very small buffer so 
this might make a visible problem hidden.

It isn't a huge change to replace this with a version that allocates and 
always works. It's not like there's a reason to not allocate, other than 
convenience of writing the code in the first place. At least there are 
only 15 and not 1000 calls to it.

Thanks
James

