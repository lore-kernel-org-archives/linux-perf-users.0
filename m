Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDD1BDA85
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Sep 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235355; cv=none; b=e3xCrm+1HXulYtQQhSzhpUivTGDMUlJcE9A5Vr5ldIZOtV394dq4MPKRHGy7diO+rE1SNUC3i5hwiRWPk7iWcTqx1iT3q+pI1qIgSNsd/PvPuR0shGrtV2qagvvNVjc7Zj1RlM0CUi+UJnMrMqRcV4u7RnvHVZEFS6yPSOkMX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235355; c=relaxed/simple;
	bh=7JMOY50sAL1FBFBstjag6aZboPGwPJyHsAb4jiAZkZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjfCsICjdGk8prF/bWbIrlbr4H/fLr56XZshsiWbclpwhLg9B1sic2aSXsP1KQegv+GeMRcc4aYmP0SUswXOcYid7ELxE5kVrb2/tfY3J09e073Ydt1MIb+V7XWMwPgw/48Pvh8GdaLOxyhqrodzEdxEuERXVw5nhNWX+mlXVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ulOrN9Cn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulOrN9Cn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso20119465e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Sep 2024 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726235352; x=1726840152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VX8L0wE8NO95OVzJ0ST2l5vUkGHAoSVmZ6/3SaE5kFo=;
        b=ulOrN9CnId2/SnGqWwtMdOZGf6mldfmuHWXSGx++/OmEc/1Vwin1Jvg5FqE9JPCanD
         GAxJ5pGRPjP1JYXRlODsk5SLaYE4afTp9lXpWpYvM3Uhw3m4AXKAbVdygxdMvmuxV0Ab
         w+cGez30nU2li+8eoDHybC2tUYhjnQKwLmIr+RUD5PDnKTxKOGF4tgzawpao3LZRDEM3
         qMYum8IKKvpZlqcF/RqjOitalHSdTs0QVjWM/kFEgWyk204u18hul0IgpfValpTzTkI6
         UfNMC807elzTVbT4+Bghej4LTkjL9yZaLeZS1Sy5xU2fnlbirWWt4Rrp03MRTUnKBDPT
         V3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235352; x=1726840152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VX8L0wE8NO95OVzJ0ST2l5vUkGHAoSVmZ6/3SaE5kFo=;
        b=qwowQbY2g+wGnvTWBvedAKww6u+F2Ng1shhky90u1jNB69nYAgZv6OHq/hQlzj9fIW
         WXaxlAGf24mfLNRTNwoi2ABajFYyejJbhF+G0WhirIrPwrgUwiY2WvlqVge9cag5AOql
         QqYC1cmyEPGxVmWmvTwOqZE8ZwjQJQ0BsFiJ1/42aBJECoahqje1Mp61HLHzdG/R5ve3
         0OF0fw+7WD5IEXVz3Xkq/UFAzCkUZh3OZ0JwEFN8JHuCTWvmwCcIPSg7BAqEA0/O3LwO
         kIP1oIEin/zmOlm6/R/HXPXfowSR7bpkqBxFQQuO6tbAhSr9q2JpnT/C0sUlpnqCHWE0
         b0dQ==
X-Gm-Message-State: AOJu0Yw6EmqrO+yEoJXowIhS1Xu2evUmgiXouIlv2m1nQuXMyMbMhEfv
	o4VwDhvbr/7B3aHT6S/vUMkZF+QrkqKMeoPsyqzcaQUsfSDjNf7KAoqRmr3WRXI=
X-Google-Smtp-Source: AGHT+IGCU3GflcAt3JPkUP8a6qTIV9vzRAlTlW+gej7YT0JQazoHvetjZZccwX3hpCfpCaxguNO2AA==
X-Received: by 2002:a05:600c:4fc3:b0:42c:bcc8:5877 with SMTP id 5b1f17b1804b1-42cdb522f2cmr58941455e9.13.1726235350948;
        Fri, 13 Sep 2024 06:49:10 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b055069sm27633255e9.6.2024.09.13.06.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 06:49:10 -0700 (PDT)
Message-ID: <d6df6edd-688d-403d-8006-491e302fd042@linaro.org>
Date: Fri, 13 Sep 2024 14:49:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] perf stat: Stop repeating when ref_perf_stat()
 returns -1
To: Levi Yun <yeoreum.yun@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 nd@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 asmadeus@codewreck.org
References: <20240913101456.633819-1-yeoreum.yun@arm.com>
 <20240913101456.633819-3-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240913101456.633819-3-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/09/2024 11:14, Levi Yun wrote:
> Exit when run_perf_stat() returns an error to avoid continuously
> repeating the same error message. It's not expected that COUNTER_FATAL
> or internal errors are recoverable so there's no point in retrying.
> 
> This fixes the following flood of error messages for permission issues,
> for example when perf_event_paranoid==3:
>    perf stat -r 1044 -- false
> 
>    Error:
>    Access to performance monitoring and observability operations is limited.
>    ...
>    Error:
>    Access to performance monitoring and observability operations is limited.
>    ...
>    (repeating for 1044 times).
> 
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
>   tools/perf/builtin-stat.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 954eb37ce7b8..d25528ea7e40 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2875,7 +2875,19 @@ int cmd_stat(int argc, const char **argv)
>   			evlist__reset_prev_raw_counts(evsel_list);
>   
>   		status = run_perf_stat(argc, argv, run_idx);
> -		if (forever && status != -1 && !interval) {
> +
> +		/*
> +		 * Returns -1 for fatal errors which signifies to not continue
> +		 * when in repeat mode.
> +		 *
> +		 * Returns < -1 error codes when stat record is used. These
> +		 * result in the stat information being displayed, but writing
> +		 * to the file fails and is non fatal.
> +		 */

I meant this to be a function doc above the run_perf_stat() function. 
Usually what a function returns would be documented there, in case there 
end up being multiple callers.

With that change:

Reviewed-by: James Clark <james.clark@linaro.org>

Also I think something happened with the cover letter as well, it's 
marked as V2.
