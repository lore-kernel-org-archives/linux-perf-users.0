Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797293370EB
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497412; cv=none; b=Jd9buIISAxYPsy8Q9d/0tdhU2ZEU9jCVZ2+25Hny09d722fkZAxOYzetkV1TGHPcW7ZAumnPGyyf29LmJEP/F/kOsA3lYuHbQDdr8Iy0uuQdW9L/K0ihrn813aAwrghE9YEBDya71g/s0MU2s6+ZGRv/glFW4bfc5dVQ/j1/MDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497412; c=relaxed/simple;
	bh=TT0WbzjtX0I2GcL1FmiJV8lbtI55CMXb9tCY3lJ5f0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0EbbrVUnADLkciYpxlAeQ+Qyyer7knYxO7QNwrbtBrtsDPn28g4xCYAvPrWH/m4sBlR9Iqdtwbem4eu4N/8VW8CVBeeaXyniCvvF0gtOffozg1CDxeXx2q5Tg893cKJORT6RXpagBnZXqxOium+mv6XkSWk7hRdRxO4L5Xzebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O1iBPIzP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1iBPIzP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4837634de51so3864265e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 02:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771497410; x=1772102210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=feBatehKiwQ2xpSUpCjcvytOTFWPxD+tJpuPUy2Jkw8=;
        b=O1iBPIzPPicNdyERBDtncaexqUpP+s0GIEP8HpH6E9uIj1w9iHuP8DWknUG7CgVdcJ
         LTKTY2LpfanYqkdyYZ3YiIhhLxmh2LFe31bCrem8R8gj8qWIsvggDgZJTKM17O5Gb0dk
         VXofxsOcOwx3vywbWWrTm41dN7Y5zXxtycijSnTkbYczBQ+3/kNixth2O4BHPOUa/cql
         LMlwbVazY20jDC39c1JLCp88eaB3IoHhTfCdrrJmGRuCLTWtpQmh1LAfo3GVrWU2gJkL
         79SK+l9zzV8ewV7Mwk43rfdzXekyYAc9YP4x1OFBLrBTc1oOWhvweVdEMxypoaC+B38r
         0fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497410; x=1772102210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feBatehKiwQ2xpSUpCjcvytOTFWPxD+tJpuPUy2Jkw8=;
        b=l93incupUmHUB+hPEcTNTwHecSLNTeoAHr9BzQc9fvoakQ2wufoEpw9UCo+Yl+gJ07
         UpZdUJRLO2vafLa3J/BfbzDDNL+kEmC9Ck6I3Vi7WFJmO+4Uid+NR0cnQv6d+Hj896BM
         gEDNNc+h381EyUGwuE3H4Mg7C3m8NZWTuk2dC3heW7jGhm8EoL/XYKp+ws7mKEyljoYh
         1cevWYSL9PD8IEnpsiwobnY8mwPHTTpizE84fWzbgZ7h1+WItDj+p9kSn550wPjryTin
         LgjCbvpnC/ogkKyA/9PYFPxlhO2Pvsd54++Et7VSWZHwsZix4QZn0I7qU7cNhywgJC7+
         d+bA==
X-Forwarded-Encrypted: i=1; AJvYcCWUSf8sSplpyreXmqKOGJbKkz6WyppTDWDtA30sO0AZClxGIoMJRFGe1ziwTOYiIByRtmj0zx3VPQes2T3G0/0n@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmdsys7tRkfbQvHNEnSjUVcU37xtywAvCOOuPmyBjwjxejRbyV
	/k1dAJVNcbyhL3gFbj5ln0Nahn4PwdaqMYLMhzIZpKoIdtIS7y1dJegrCq5SkT6+g4Q=
X-Gm-Gg: AZuq6aIE+07e2JqvgeYO2r+IRJ75kHPQjKlJlUj4asisWUeBo1SJ2VfLGM+yq2bcRvN
	/Al8h2NHyQ6zF7vpm8z4T9eGKAwsbvIgloHbJ4M0DvAjHrRn4ysdsrpOQ9yfKb2URCnrdEJBS6C
	Cv8prA+IVhjuNR7Rbx0hODF5LXXSS2a7VZPcKHybK3psWV3VW24yLXinLqA/M1BUdaOf2yeTE5R
	BYWBGVTZDHhXsKjlvvZVb3HNuPGbkTgafbJxBO78ERMsVMhrHyoDQAgdE5x5pSPlvfhBr8vQKBQ
	9KK9/WpHXubvnp1nRfbQ97ZvIo5fB+jngzAz0pJiaHVueKGIbx8tw+V1rO79SIdH4vDErjpAOoa
	f3VMDBZ4AxFYiLJq/Qe5eyVmId2P8Unqw8kpYuPap2/9UT/VMhYEPrKAUjgV5R7J4tfws8BzLbT
	7HpE2EU29uCHCBOwi3HqTQ8Wi5QuT3
X-Received: by 2002:a05:600c:1da1:b0:480:25ae:9993 with SMTP id 5b1f17b1804b1-48371085c9dmr347598535e9.20.1771497409742;
        Thu, 19 Feb 2026 02:36:49 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a5f0sm46607290f8f.11.2026.02.19.02.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 02:36:49 -0800 (PST)
Message-ID: <a91a44a4-a918-4edd-9fe2-2274d5213dcf@linaro.org>
Date: Thu, 19 Feb 2026 10:36:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf bench: Fix initialization of union
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Leo Yan <leo.yan@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20260219004417.188434-1-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260219004417.188434-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/02/2026 12:44 am, Namhyung Kim wrote:
> Recent compilers don't initialize all members (or the largest member) in
> an union.  Instead it seems to set the first member only.  So some perf
> bench output shows invalid numbers like below on my system with GCC 15.

I couldn't find V1 of this so I wasn't sure if it was discussed already, 
but wasn't the plan to fix this with a compiler option:

https://lore.kernel.org/linux-perf-users/20250319110454.3230687-1-leo.yan@arm.com/

and

https://lore.kernel.org/linux-perf-users/20250320105235.3498106-1-leo.yan@arm.com/


> 
> Before:
>    $ perf bench mem mmap
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>           0.011127 bytes/sec
>    # function 'populate' (Eagerly populated mmap())
>    # Copying 1MB bytes ...
> 
>           0.011127 bytes/sec
> 
> After:
>    $ perf bench mem mmap
>    # Running 'mem/mmap' benchmark:
>    # function 'demand' (Demand loaded mmap())
>    # Copying 1MB bytes ...
> 
>           2.209417 GB/sec
>    # function 'populate' (Eagerly populated mmap())
>    # Copying 1MB bytes ...
> 
>           7.875504 GB/sec
> 
> Because the first member of bench_clock is u64 ('cycles'), the default
> struct timeval wasn't fully initialized.  Let's use memset to reset the
> whole memory.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/bench/mem-functions.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 2908a3a796c932d0..676c8d18f4c2e259 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -193,9 +193,10 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
>   {
>   	const struct function *r = &info->functions[r_idx];
>   	double result_bps = 0.0;
> -	union bench_clock rt = { 0 };
> +	union bench_clock rt;
>   	void *src = NULL, *dst = NULL;
>   
> +	memset(&rt, 0, sizeof(rt));
>   	printf("# function '%s' (%s)\n", r->name, r->desc);
>   
>   	if (r->fn.init && r->fn.init(info, p, &src, &dst))

