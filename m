Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32E249EB
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514388; cv=none; b=EdLPzY4g/47cQIfKvAI8y/Fpl6zi3oDhEwcSwgx1HJ0zfnsxeoWRdoJ+MTIfklsIgmRuYJk1LW/bgrJsJhAn2JnuRXpmif3SjvrKMrRMwRoNWd7jmNwZrJ/WUXw3Bu4BB7E3Mip9XSkTx8B7wPN4pSDu4cYpgt5o6tDoRN8L+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514388; c=relaxed/simple;
	bh=/70UgeSPQ4hOl+81apBVxeqoPl9OH4tSaQJnk7qPHtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjOxYAfypxaue8hIUVeBic2i6rcw0Zyj5pxi8jlz563P4OSOTTcpAEuul31kCSkaFQPxu8OkOqrcRnanJtKCbyFj8gI//f3AM/aWZzCnjfHLncnlnqORw2exiRY9SXSAD8UVs/wauTNu9fjORYBJHG6DPNfatjRBG9lHp2UVA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jLU0J3P7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLU0J3P7"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a68480164so988316966b.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 08:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731514384; x=1732119184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPCRSYoPSHpwTYrkQfPBw1+Y7qPSaun9UleVAf6DtlE=;
        b=jLU0J3P7WEhai6a6IlExZ8K/QosOAtqVYJ5ft6XqIiq2e27BiqYA5P8RAUKoOtMch8
         fUp1Ch7NlbNPXI7NB1m3iy3tUPMhR64O+vcRWRz0lCnjdw92FDhRns6o7oecA79kv9KA
         7GrAf7EbwN5+rw7OE6AnJfhlqUqcAsT52sSkuGapdNxEjNYzo8z5/nNNyKh+mn82gTIw
         gEqLTHHdoR2+9AfGSo15UPnefoBt8TuZhjd3fF8cWQGo82g3qxj8cKni0AZe2fdcLrGj
         jVzgGrNYtM8wti4sF6u/1lhyX8YG0kibLTg28t9Hv4ivcK6KkGBC9kJWqdrZ3i+dnYeK
         HrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731514384; x=1732119184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPCRSYoPSHpwTYrkQfPBw1+Y7qPSaun9UleVAf6DtlE=;
        b=I1YTFOSbnGw3j7+7AMKhDRs8BPi9nbPcLy6Up7WhtT/O192A1hKqqGUORopZcHtfcf
         M4zOq9ayTwIUPaKw28zMYXpq5h+yc3eRI6rs2bR3Rm9ygW4KOLLgPvLIkMaTxLGOFvSu
         Lib44228azKja+SkH/hWaz5xbQeoRlg/oHZi2UHQ+sk4AZ5LZcl8/qbdOy0mXXE1WRTl
         a6avnRzGC4BlZrITzdN0s25LSnV8L1m0toBIAWTvqF+GSAGbsenzsJ2YmbMIHpsHAFad
         1p9Intf2vzPJZfL534L0yFAcf261jT5rSSniwgeloLFnR425fbQ0mhvq+hZ8wJfY1D6c
         fHAA==
X-Gm-Message-State: AOJu0Yx8F29zhW349l8ucFZEHxKsOMk69uSvbd79PROD7EK1omspfaej
	ErZM/bykiydIN2kti+AxyYlco4ULw8UpSdJiUksnCshSZQ75In5Hr29/ZUUxYcA=
X-Google-Smtp-Source: AGHT+IFjZsCHovOOd6p/6Y6Rm1a3D613g06b2tt4FLhBkNEK/HNzyPsLILrVS2Y3DIliqWTK31ytdQ==
X-Received: by 2002:a17:907:a4b:b0:a99:fc3d:7c76 with SMTP id a640c23a62f3a-a9ef001915amr2144913766b.37.1731514383858;
        Wed, 13 Nov 2024 08:13:03 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2eb28sm877229166b.197.2024.11.13.08.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:13:03 -0800 (PST)
Message-ID: <c03b1604-cc41-4746-be3a-fc326152d556@linaro.org>
Date: Wed, 13 Nov 2024 16:13:01 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf/util: initialize is_test value in
 expr__ctx_new()
To: Levi Yun <yeoreum.yun@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 nd@arm.com, namhyung@kernel.org, mark.rutland@arm.com, irogers@google.com,
 james.clark2@arm.com
References: <20241108143424.819126-1-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241108143424.819126-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/2024 2:34 pm, Levi Yun wrote:
> when expr_parse_ctx is allocated by expr_ctx_new(),
> expr_scanner_ctx->is_test isn't initialize, so it has garbage value.
> this can affects the result of expr__parse() return when it parses
> non-exist event literal according to garbage value.
> 
> use calloc instead of malloc in expr_ctx_new() to fix this.
> 
> Fixes: 3340a08354ac ("perf pmu-events: Fix testing with JEVENTS_ARCH=all")
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
>   tools/perf/util/expr.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 5e3732bc2fa5..bc119501f091 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -285,7 +285,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
>   {
>   	struct expr_parse_ctx *ctx;
> 
> -	ctx = malloc(sizeof(struct expr_parse_ctx));
> +	ctx = calloc(1, sizeof(struct expr_parse_ctx));
>   	if (!ctx)
>   		return NULL;
> 
> @@ -294,9 +294,6 @@ struct expr_parse_ctx *expr__ctx_new(void)
>   		free(ctx);
>   		return NULL;
>   	}
> -	ctx->sctx.user_requested_cpu_list = NULL;
> -	ctx->sctx.runtime = 0;
> -	ctx->sctx.system_wide = false;
> 
>   	return ctx;
>   }
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
> 

Reviewed-by: James Clark <james.clark@linaro.org>


