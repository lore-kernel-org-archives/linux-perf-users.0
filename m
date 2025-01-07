Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A21E1C3B
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261344; cv=none; b=gLgvuRo+5F3D7jg3+lRYoolVmHYuYIjUtw1rcCAh3t1CYHJlDW8FPdleydPJVWiy7ZhVBCbXsktH/cJc1HSD9/1MK+XVA0Tf9VTeT1QQFcow+GCO4nriTP7KygXAitEWbc88w1gTJHQpUQMTSM47DPtRCObXjPVDhvkkbsoFDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261344; c=relaxed/simple;
	bh=EjiYzwCYUsiOGfwWNrpzVHPjRE3x003vhyNLulMyfKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqsnhfIMO+/jh0D1TiR46AjVc2bPie444GkigcvqhSKsJgJFLCAim8HggqJ/3/QaKNO5D1J6yzXwjPnFz6BhPH7b5Ebi5BrQc/ociUX4Pmq7m4BUo2rq77Ky2HzxQLyHnDCh/+TIG8xZP7W88i5XgJuWAj9ikujdkrdSTcFoUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T7A4szNC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7A4szNC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso94468025e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 06:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736261339; x=1736866139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxa1pkfDOEIXCCO+s7+UGe3S6KIxpA4ZbmC+QKaQqYA=;
        b=T7A4szNCAzNuFBAg8ZwrogsD8oKy5X/qi+qGFz+KVp2Qlo8iQixBiK+7jOgf6OYAmC
         e3HtNW25HEKCnBuhmjINIqgKVf/SbsLZ8/6LiO4uqU2uONIOSMUs7ULbhOjWI8KrCY8r
         ss1LCbpSjmG6wf3mi7P9CqJPoSxSv/pPhGMjyZO/p+sVf24yXtBwN/QpZyg/2ONkAqrp
         B6WTU2IxeBbhd45Tt/6eEivG8lQAcd9ru1bJzhkmI2ctuxzh9JJoWD87b1Wkb1d+WnO/
         hRQunjFKhgdEuTlALSHjlkihs9h3plGhvl0E5TUzq99/ScNUPm9BgvwzHFZ1xgvqLzdI
         OsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261339; x=1736866139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxa1pkfDOEIXCCO+s7+UGe3S6KIxpA4ZbmC+QKaQqYA=;
        b=GdrwLq1cOSGUB/Ile2172gA7rC50wL3fGYpzuFQdbJamRuB0p7J4DVvS4gz0t/hYOw
         N9Nhsm5YyaTwFwF9f+omXoqv4B/30n7j09ouR8mKrwHz1IRKZUDqkf6pyk7Mzh+QV8Kd
         RgyuraRN8kSLdhelB6t+pakSN6a9Z1qtRItuzWmz2f7IV6zVARzzX2G/iFRqouYCosqa
         TBSkvAN8NKmM+/pKshK/gNKr62VtDFrtoE3z1F8k1/QP5CHozqgQpcg985vOcNKvAaOq
         DTGOFT3lB7Os/y0/M9ky3SP1WYjBH+VgKdRQibJMId0+ZUU0inmmXWHDYCH/C79ioksb
         TCjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEvVs8r9hPSMv6soWd3CzV/eB/NTbSy1aP8ObPs/nCVDx365ZBB2c6YSeWnbnCwA+c6zym7i9DWb38xC+Y4yHE@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1Tjj3l0mTz68l1EIdhe2xez0EEFbmDs/SUTmZuGej1W59DX+
	DvitfCUf8q517XlY7HSRYpRQbvoO1NJIzaT/AbQMjXstXnU1GkUEkQ6v9I5Fz6c=
X-Gm-Gg: ASbGncsgKGrHKux6c5+xQRjsS1R4zY+s3iPhm7ZfE9eHkuhHx0/O2IjjDSM42urHVJo
	rr6j0ipDaskyjA9mswO0VwPtRMMwZeSkoTj3C7idJUordp5MsMiyS5jZuuoLxfJcg+zqZkKPlMw
	4CL8hsJNJc0U6syGqQCucxSQFxMWlArBbGhAFDM7/DH4njYIUXNkmBQYK1SnUghB0KT02oKDbna
	b9nl0iN5HHBX9vpGP/hO3+noFsfVZluBOTCRmb8zE4DvjD+QgnAOvMmvXUa8Y2q2nA=
X-Google-Smtp-Source: AGHT+IGxTgtGr0awthP0xG6hue3tpPsHrFGlHGB17oood49NCvoIfY8p2CUZU7ckMGhhD9yqkL+3Sw==
X-Received: by 2002:a05:600c:1d12:b0:436:1b86:f05 with SMTP id 5b1f17b1804b1-436dc20b0c1mr27910445e9.11.1736261339591;
        Tue, 07 Jan 2025 06:48:59 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b2a4sm634498665e9.27.2025.01.07.06.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 06:48:59 -0800 (PST)
Message-ID: <d6cc9e4b-7a38-4673-9c2a-d97301a7fdfa@linaro.org>
Date: Tue, 7 Jan 2025 14:48:58 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf ftrace: Add --graph-opts option to profile
 subcommand
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20250103231630.928815-1-namhyung@kernel.org>
 <20250103231630.928815-2-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250103231630.928815-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/01/2025 11:16 pm, Namhyung Kim wrote:
> Like trace subcommand, it should be able to pass some options to control
> the tracing behavior for the function graph tracer.  But some options
> are limited in order to maintain the internal behavior.
> 
> For example, it can limit the function call depth like below:
> 
>    # perf ftrace profile --graph-opts depth=5 -- myprog
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/Documentation/perf-ftrace.txt | 8 ++++++++
>   tools/perf/builtin-ftrace.c              | 4 ++++
>   2 files changed, 12 insertions(+)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 16b067eb5d84746d..4a69a1135f07341b 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -205,6 +205,14 @@ OPTIONS for 'perf ftrace profile'
>   	Sort the result by the given field.  Available values are:
>   	total, avg, max, count, name.  Default is 'total'.
>   
> +--graph-opts::
> +	List of options allowed to set:
> +
> +	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
> +	  - noirqs       - Ignore functions that happen inside interrupt.
> +	  - thresh=<n>   - Setup trace duration threshold in microseconds.
> +	  - depth=<n>    - Set max depth for function graph tracer to follow.
> +
>   
>   SEE ALSO
>   --------
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 0ac2b20b272bd790..d747cca2403e494e 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1072,6 +1072,7 @@ static int prepare_func_profile(struct perf_ftrace *ftrace)
>   {
>   	ftrace->tracer = "function_graph";
>   	ftrace->graph_tail = 1;
> +	ftrace->graph_verbose = 0;
>   
>   	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
>   	if (ftrace->profile_hash == NULL)
> @@ -1660,6 +1661,9 @@ int cmd_ftrace(int argc, const char **argv)
>   	OPT_CALLBACK('s', "sort", &profile_sort, "key",
>   		     "Sort result by key: total (default), avg, max, count, name.",
>   		     parse_sort_key),
> +	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
> +		     "Graph tracer options, available options: nosleep-time,noirqs,thresh=<n>,depth=<n>",
> +		     parse_graph_tracer_opts),
>   	OPT_PARENT(common_options),
>   	};
>   	const struct option *options = ftrace_options;

