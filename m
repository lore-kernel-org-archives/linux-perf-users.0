Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5649184559
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047911; cv=none; b=cEfrHVRby0ByzrQUmQMk+RQbyYzu3R5qmTwGl4dYRddIunKlcqzBONT5LDhtjhFnQEXZa3OF5ex1xwFwAPH6mgEENoVT4DoSNbvjJ3J14HwRUumINODOcSHsfwi6O0ls8KNp1WH2cxF7hFx0kVBqFZjI2jkjDcM9r1B/PI3jrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047911; c=relaxed/simple;
	bh=HbvCf2201rlCiYWUGZXa8hrWPWUEdpCqwLCY6YaIimo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=topCwZPxUQNUYwy9RQ12/gLmWdhGSyr3vmR9y3fpiJsu9cND0vywTwAlvQEUpX0OZXFJHfHQh4eerfMnuLFCe9cH9tsw6FBqpLZjBEfZUt7cQ6C570XJYkuMOOua9e23N/5owgWLU9DcPYYqY0g0d6SY0P/AaG3ir0I2J1G5FgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F6/nHtKH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6/nHtKH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so29847735e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Sep 2024 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726047907; x=1726652707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gue4qaTI8QiVGn2E5BdIJ10PDgpNtCS7+q74iHgYmk8=;
        b=F6/nHtKHbga8smQD4UApUi7mjyP1Bqrxed1BMUqjKCK6U1gBQn82rD0OXZWiLd88PE
         j4eDOZcRdLsFXsQBUqHEfihATrbm31zqctyILY2tTyoBsMcyYMM81N7De62zre+pljcX
         EKXnUa0ilzqBu9KTOo9tfx0TsrqV8vud1IZIt7LXe+CceQ4/RoaUhA82zhU8GJ1HN5YZ
         PrXTq9cs75SDj+CohK3gwY+3Ao36nyNcNO0rZyHauvo9EZhYcGOuhTtrruMbtiQbrwje
         Uj+fJguluZ62kBbTFhkzlD3XNTui0lPX0WNUkIRzeQly9alKR5EEcP23UPx6phkt3fcx
         ondA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047907; x=1726652707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gue4qaTI8QiVGn2E5BdIJ10PDgpNtCS7+q74iHgYmk8=;
        b=AMy+TyE21HLMGV5+as8EOFJQolENJ/mxV0IAKvCPHyMcxsghXjQFkg6dnwfGDeMaJq
         Lf48Q2ZXd6X588BwgsX4wJ5n0Y+4XAsH/6ops0lPmKBNScSb8fXOy31LORYr8qHaCwVz
         hPwLfzhAaUTNJ5YqLNHmXdAyoRX3c34zzLbK00AUem0Wo6SC0lrKChnfy7W2IFE9//Oy
         j48awLEQAYJ0jdySNynj1yCO4s/GaYmxwxhBJKaehGusgduY5+yy140CUGsRp8WjFlWc
         5EAMbVgNCazCiRVKKtJbtdbd5zX4Tm4Oeqy1hFzzh47ViVeC+LByMK9j3IsiM3i9nKbJ
         N0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUkMjibV0Pj/xHUoU11MM0wFWtHP+VFT703IuQGkfKDC/4Ulo5eWC6mD3bh1GF0YjsiqufZckZrP71ShlVbPAlD@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDSu/Aajijuwc9mIHxhn3Udg3eNiiKu2N+/SzxgCn8+9HwkXu
	cv95eFB9dYxa8Yt84++rmm7XyVlkWskgTJJ7dSFONLrGk4TwPIq8FxbqEx7vdgE=
X-Google-Smtp-Source: AGHT+IHWW2BOCOUSxSnw3LpxP0BBwi783RZeFXOJkye4XyzKNPrR3uraEVfYW7VpMiN9f3L/uEnOYQ==
X-Received: by 2002:a05:600c:1f90:b0:425:7c95:75d0 with SMTP id 5b1f17b1804b1-42c9f9850d1mr132773265e9.18.1726047906431;
        Wed, 11 Sep 2024 02:45:06 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32b0csm136294375e9.18.2024.09.11.02.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 02:45:06 -0700 (PDT)
Message-ID: <4fa0229e-630b-4b6e-8882-3d8a5793a9dd@linaro.org>
Date: Wed, 11 Sep 2024 10:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf ftrace: Detect whether ftrace is enabled on system
To: Changbin Du <changbin.du@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20240910033625.3569729-1-changbin.du@huawei.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240910033625.3569729-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2024 04:36, Changbin Du wrote:
> To make error messages more accurate, this change detects whether ftrace is
> enabled on system by checking trace file "set_ftrace_pid".
> 
> Before:
> ~ # perf ftrace
> failed to reset ftrace
> 
> After:
> ~ # perf ftrace
> ftrace is not supported on this system
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>   tools/perf/builtin-ftrace.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index eb30c8eca488..e1dc2768bc0f 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1112,6 +1112,24 @@ static int parse_graph_tracer_opts(const struct option *opt,
>   	return 0;
>   }
>   
> +static bool is_ftrace_supported(void)
> +{
> +	char *file;
> +	bool supported = false;
> +
> +	file = get_tracing_file("set_ftrace_pid");
> +	if (!file) {
> +		pr_debug("cannot get tracing file set_ftrace_pid\n");
> +		return false;
> +	}
> +
> +	if (!access(file, F_OK))
> +		supported = true;
> +
> +	put_tracing_file(file);
> +	return supported;
> +}
> +
>   enum perf_ftrace_subcommand {
>   	PERF_FTRACE_NONE,
>   	PERF_FTRACE_TRACE,
> @@ -1254,6 +1272,12 @@ int cmd_ftrace(int argc, const char **argv)
>   		goto out_delete_filters;
>   	}
>   
> +	if (!is_ftrace_supported()) {
> +		pr_err("ftrace is not supported on this system\n");
> +		ret = -ENOTSUP;
> +		goto out_delete_filters;
> +	}
> +

Very minor nit, but you could probably put this earlier next to 
check_ftrace_capable(). It didn't look like it used any of the config or 
parsing results.

Either way:

Reviewed-by: James Clark <james.clark@linaro.org>
