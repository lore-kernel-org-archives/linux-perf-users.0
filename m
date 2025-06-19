Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A51EE7D5
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342849; cv=none; b=kEclqVYQbJpB0s1Uy+pSL2bdXA3qo2om10vm8hC021tNHKAJSWN9w9GbwSVemaRNFB3/bI44H7Ayp/H1folouIcQJAq2qGOukFJOS9oiqScr6JQzEZUBrST3wPw9T7nKF115+EjBUCUOXbbHfYc2NNbvvRdqGVMRgWLqwERQqRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342849; c=relaxed/simple;
	bh=wQ0nkS01y7V6/G5r9D4sI49uRC0Zztx0K4NIc0EqaqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6InGt8zaXZJ2h6uyPPv9pY0ubM6l728j8u5OxPYCzDEb2jkquG5GgkZx8XIpH73ZZ29K5pxgSIHDD/ECqxg5GUUSmN2URTtsNfSYekcGKORXpaJ+oRlhoXm5JOF2HxA4NBLYJsaKWP91oppFyD0QHJE3pZi+KFEdqI7PNzYdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Th3nfuhi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Th3nfuhi"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450dd065828so6391205e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750342846; x=1750947646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIOHqP2ZRvjLcVYspsnH+ZoAOue8xmiI6uTXUwuJb8U=;
        b=Th3nfuhip9E0DTUUGeBQQd/xOW7+WrSIPeHt8sKw8gm5eQTQt4iPQiHkA/eMoFZ1q9
         9lBY4lSJg6m2K6F9m9HuNjrYiPxhl98GyQu3ko5nvKnSOJ0Y0ozdeIw3+UqC6CkNdhbu
         dMQ6P/VAW0rF9LMs1v6zH8DNKwHyr4MHAeXLBw5uX1lk/v1qu0hYg/aD8OG2RKRvwLud
         qHmcXS3zavpXXW+4iobVF0NfvaIbikul0dveUcxGdEnP4icxecU8nE6oQVIrT06iCJY1
         chg4nWtTv96uwgVhpK+VcCenPLEplTYK9pOQaf+gpEwZfRY2Ff3bG9FMbPgypzEPiEdj
         KK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750342846; x=1750947646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIOHqP2ZRvjLcVYspsnH+ZoAOue8xmiI6uTXUwuJb8U=;
        b=fUvRgM1gisWCQsaR94vYiw+Y97i+gHBHRMuAYBIT3BCcUaY0w3w86wuGmmHMGRCnEN
         VDij8thbLJvmptfpFQD9ZJP88HSJGpqWgivqfgbNxGvkZIdOX9NMqErJnzZKkR0lUmeM
         hiRhlg7cJE7jAHFpySge9cwnALgeYykEpNKT3AfiAuD/S2tzam24WZtGoexYI7JpfoLv
         /N0bOkvCCG8mLmyapFz78eOpivUJhlJHY1LJsgMKE00QMxipwCodtukSeT0bdsXcUuQ7
         9WIxW8O/QjO9a/5tiXtk3cpndLgH48RK/XflzN4KZDqyzc1IZOZbzQZuLpXKnEA6Ba5h
         PS0A==
X-Forwarded-Encrypted: i=1; AJvYcCVd7a906deV6bB/0kruJ2XMC8vL4pn/eVPZX8Ci2TbiJCI7rahdhSEVQ65Jnuqi/9bLemLHNx6MZbPkaPybkd34@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTdHNgGuorVNSS3a0VHFuaNHiZXsxkvvhThy/9uzd5gFDxz3y
	OLoYfISFDs49upuI+uefnbSfCrRRGs8eGWg8/PrjTcItkp0iBABPAtyfU7+XfK/7ac4=
X-Gm-Gg: ASbGncvQCti0dzBZq6Zo6LzaWA+miGqH9eWTp5rtLBqffqf3aoscmw+2qgJjEiAi85t
	0JiWDAzrgUUodh0akmnRR3n9qyfhUGa4/p28cuoWO6GgW+mQgCBPAIl1SWj8lp4bUmwm/xaBCYa
	jb4T+3Be8ZXJJkgdavPrTMKi20ZpTxcDofau6OEWzAyLcnjv9ZU3dsdivm206VkhsIXIGQIvNAC
	epWROHtmaaeIi1zGU2DzgxB5LMlsXJutj98OWqEUtYcAd0OBN80/hoQ3Du5fyvb+HI7Pu2tg/Nv
	qqievzGDboBxxbktxTbsiIHBfogE3vVO3BO1llzoAehfOhAkBH6GNZ0l0nfmW2SovKc=
X-Google-Smtp-Source: AGHT+IGAv+oF835l8qV/3D6DQ9ObyyYlwvd1+fOMYkZiRNiAkB3TDVZOr2FtaC3pO/7/Ok11YttSBA==
X-Received: by 2002:a05:600c:4f53:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-4535d8ddc69mr52656125e9.30.1750342846067;
        Thu, 19 Jun 2025 07:20:46 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e99eae2sm30317065e9.31.2025.06.19.07.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:20:45 -0700 (PDT)
Message-ID: <6f6bf9c5-375f-404a-8bf6-63b262c72158@linaro.org>
Date: Thu, 19 Jun 2025 15:20:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] perf arm_spe: Decode event types for new features
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-5-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-5-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Decode new event types introduced by FEAT_SPEv1p4, FEAT_SPE_SME and
> FEAT_SPE_SME.
> 
> The printed event names don't strictly follow the naming in the Arm ARM.
> For example, the "Cache data modified" event is shown as "HITM", and the
> "Data snooped" event is printed as "SNOOPED". Shorter names are easier
> to read and review while preserving core meanings.
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 14 ++++++++++++++
>   tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  7 +++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index 13cadb2f1ceac7a90e359c4d6aa1d5fc5169e142..80561630253dd5c46f7e99b24fc13b99f346459f 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -314,6 +314,20 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>   		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-PARTIAL-PRED");
>   	if (payload & BIT(EV_EMPTY_PREDICATE))
>   		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SVE-EMPTY-PRED");
> +	if (payload & BIT(EV_L2D_ACCESS))
> +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-ACCESS");
> +	if (payload & BIT(EV_L2D_MISS))
> +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L2D-MISS");
> +	if (payload & BIT(EV_CACHE_DATA_MODIFIED))
> +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " HITM");
> +	if (payload & BIT(EV_RECENTLY_FETCHED))
> +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " LFB");
> +	if (payload & BIT(EV_DATA_SNOOPED))
> +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SNOOPED");
> +	if (payload & BIT(EV_STREAMING_SVE_MODE))
> +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " STREAMING-SVE");
> +	if (payload & BIT(EV_SMCU))
> +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " SMCU");
>   
>   	return err;
>   }
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> index 2cdf9f6da2681244291445d54c5b13fe8a2e9d9a..d00c2481712dcc457eab2f5e9848ffc3150e6236 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> @@ -108,6 +108,13 @@ enum arm_spe_events {
>   	EV_TRANSACTIONAL	= 16,
>   	EV_PARTIAL_PREDICATE	= 17,
>   	EV_EMPTY_PREDICATE	= 18,
> +	EV_L2D_ACCESS		= 19,
> +	EV_L2D_MISS		= 20,
> +	EV_CACHE_DATA_MODIFIED	= 21,
> +	EV_RECENTLY_FETCHED	= 22,
> +	EV_DATA_SNOOPED		= 23,
> +	EV_STREAMING_SVE_MODE	= 24,
> +	EV_SMCU			= 25,
>   };
>   
>   /* Operation packet header */
> 

