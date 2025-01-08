Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F91FF61A
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357192; cv=none; b=ajLEElsgXcCxUWqMDL/2ZTaz/UKlhZ9swiIrKacCRDC0e96lvR/6y/AGN9vBwGsN+YrsMKd4760eAeRxmGwP8yO3O6C8TrzH20BDCYS9aNQophup9OkDNTj6KXz3izX6mL80PQGZn0BMBvXGIn9YSIsM+GJmSVvHJekY7GNRQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357192; c=relaxed/simple;
	bh=bdQo+lBW5/qI3emPm7n8IjfAkuv5sIHUHSJjsVeasXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/NMhDJClmHB1no62xUM0t2M0IGvtirnAvPzZDb/qlkLH5e//uqoOPosKwWl/0MdY13VimdvR7e/9uq63uuR0/TFu6ZoZ/6S/9kudkkm5qfZZnp6WU1ZyCmW+k22qEkr+NiQy4moNlKRXgUDbkJnYS9Ke61RVC1bv140WopwR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+kpiKfD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+kpiKfD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43634b570c1so709655e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736357189; x=1736961989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uz7jPsDrUl24NPXVQ/YbNarO4OLO2mfvD9qhmfzb75k=;
        b=d+kpiKfD9l/mcrimPkefmtMHoevBIMNQ/NbCNshT2OPQiOJHNnl8DmLhrdEfJ17FM+
         AZ+zX+Ri2BF4KEFKHKjUTNe7SrqxEk9DYWAARmHUdCQfb9SBkU4PIjJ66nr7XdWKYo5k
         llsNbo268ZhMkq36qxHPLV2UbxeTrsvqV4jLzz3FvAmlm7sAu0NF4O+9roQNhk+tFufr
         pJfkUjHRE60gLKTiY4ss+EAi5oKFLwJZKrDji+7/OTvkxtz6GtWbitGSrzF1KIu0EA74
         OUhvGCLiIA0zbEieVHUHnX3tMTEyCfrs8Qm4WRLn0NoofwGKF8Krcz1jPhXNaZq/SIhH
         lXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357189; x=1736961989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uz7jPsDrUl24NPXVQ/YbNarO4OLO2mfvD9qhmfzb75k=;
        b=ta97km0+iFA0CZ+Oa3EaokGgXd0o0qXM0Ur7qSWnT+VuQC2UXTLE/gYPGttoPrpLX4
         RmnTq6Iafcj0KJ4hgh5ryQX5Pe/6PomrX2SUDTrDNVDsQgyVObbVcYoIAIGelvjAY6F3
         2xXjkMYOfGuduySDRfAN5U+Teb+N6BtOOnYFH8jw/jtTf9cv2Gc9MLNN/Lezw7qzbFBB
         YFrjCFNpOJzYAqBf6CBgI/iDmdFP+Y3LYOUdTAfqZWWodN3BRdXhd8RkQ3FzSal6uVYN
         cNeXdw0pi0yAsf7MTTIAfN9JLldpX2VcDHSJtA5+f9nQFFdv1genII0K7DeRkrbM6xjs
         x71w==
X-Gm-Message-State: AOJu0YwQQS0P4JF8USCzdg3rX64mgcC6FnOiSKLnckNAILJs9zvZSgfw
	3lvFoOygbzYT31SvoW2XegtbLmKleSdlT0H6JD9l4Xa0hfq2y0ssJYDWiNfhL7U=
X-Gm-Gg: ASbGncunwr/uP4QDimtLOZsHI1f31F49b/4F7qF45YJrfXg5yckqsmRebmUsbunxo5I
	O3889tm1KfmjI7Z7uNodCrKPmu4o3f8QrP7Q593HX/ktiq264yMgBxrePiFqu+XtUfyuLi/JNIz
	FMb5nTsd0eJeuO25/011BFzHyh14/lIhpbAsKbJyS06rxUtxa92Uoi33dOvk6YG4CStHTHSNniA
	ALEC6+VwToqUQn50qHRfpLxJmJGCZXKqJLlw63X4kywQ6DBCTn06f/ONv8r2rZgYYE=
X-Google-Smtp-Source: AGHT+IGtyYjvPGhdTDfPKqtLx7s7KIOJjbnDJIOTV29bCeh/WaawmmXnuPgc9kMGFBON/wRJwhJo+Q==
X-Received: by 2002:a05:600c:a41:b0:434:eb86:aeca with SMTP id 5b1f17b1804b1-436e269a9e5mr36877025e9.10.1736357189186;
        Wed, 08 Jan 2025 09:26:29 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92dc4sm27146435e9.39.2025.01.08.09.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 09:26:28 -0800 (PST)
Message-ID: <dc6b9a84-75d7-483d-87e5-3f5d76858d67@linaro.org>
Date: Wed, 8 Jan 2025 17:26:27 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf hist: Fix width calculation in hpp__fmt()
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 namhyung@kernel.org, irogers@google.com
References: <20250108065949.235718-1-dvyukov@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250108065949.235718-1-dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/01/2025 6:59 am, Dmitry Vyukov wrote:
> hpp__width_fn() round up width to length of the field name,
> hpp__fmt() should do it too. Otherwise, the numbers may
> end up unaligned if the field name is long.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   tools/perf/ui/hist.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index e5491995adf08..34fda1d5eccb4 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -121,7 +121,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>   	     const char *fmtstr, hpp_snprint_fn print_fn,
>   	     enum perf_hpp_fmt_type fmtype)
>   {
> -	int len = fmt->user_len ?: fmt->len;
> +	int len = max(fmt->user_len ?: fmt->len, (int)strlen(fmt->name));
>   
>   	if (symbol_conf.field_sep) {
>   		return __hpp__fmt(hpp, he, get_field, fmtstr, 1,
> 
> base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780

This seems to right align the field correctly with a long name. Although 
it's worth noting I had to add a long name to make it obvious.

Reviewed-by: James Clark <james.clark@linaro.org>

I saw some other existing issue with small column-width arguments which 
is changed slightly by this patch. But I don't think it's worse:


$ perf report --fields 
overhead,overhead_sys,overhead_us,overhead_guest_us,dso 
--column-widths=3,3,3,3,3

After:
------
Overhead       sys       usr  guest usr long name  Shared Object
   63.78%     0.00%    63.78%                0.00%  ld-linux-x86-64.so

After, width=3:
--------------
Overhead       sys       usr  guest usr long name  Sha
   63.78%   0.00%     63.78%                 0.00%  ld-

Before:
---------------
Overhead       sys       usr  guest usr long name  Shared Object
   63.78%     0.00%    63.78%      0.00%            ld-linux-x86-64.so

Before, width=3:
---------------
Overhead       sys       usr  guest usr long name  Sha
  63.78%    0.00%     63.78%    0.00%               ld-
