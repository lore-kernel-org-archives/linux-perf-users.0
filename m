Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800E1FDE2B
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349842; cv=none; b=bRW4rXrCld1/DYEFLmI1OsKL3lwujKSQqJnCCE1vybOKw6/lQGgOOEugAzzLzn1YiPlZO7kRuveTxAZJzig2U4v440Kw915EHvgAuK186uCSMlj2a6sJPkcfrjZ7erCw5L5Xz6wCae2LjOT+lUQT3Gk/whEbqqecMcFPvohjFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349842; c=relaxed/simple;
	bh=XA0EjxryTKXl7N+SAuVE5NW6HlEVaOoS0KX9HQbWrBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzrREO5pHKcKfgBo1aD7u/OwIk7AgH5BRJPz3ZG+O/KMfhlBrRRZ8dEx+Hn/l6uqBKDv+nXAJyb8m+9AoYB32xPcKBGPFVFRGAiobGqeveOSl76Bzdpp4ZQIZI81xeouZeycYJ4M8mLLIFP4JPSnzfPquOGTIJMwqC2hqSCdcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tDVIHQ5n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDVIHQ5n"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso6660615e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736349837; x=1736954637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3X/XYZ5Pi2fHpiOxTrp2fQ2ew24AnjpHXDKowqHn3Zc=;
        b=tDVIHQ5nUCqOvvLta8cggZ+FHkdKyh7tlIX5ikj9/POIDM5DNfaqBmxkGGKrtFm9//
         Gn/pvi8pGb+Y6CW931ncoydZam+1cgb70sj9RfwKubBo6OhT175gwmlSwQSaSrQYnCgR
         yIBVAoZd4VqwGLjBR2kGsndteZFnJBle4WyZJv0PK2Wdc9BbcFYoov9e8Scek8AXBOL4
         x9kt9ev/7KQ26l819iyN2//zU/BvvGPnASCPP/MeeLMb+0GAqeEiLkv6cHBQvBXGUQR6
         RFw7VeNx7D/uC21SQgdge/3hZWCZ2h/QKM3f9JQcUwm7SX0gQpeEZacx3owp3DXuH1Fw
         k1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736349837; x=1736954637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3X/XYZ5Pi2fHpiOxTrp2fQ2ew24AnjpHXDKowqHn3Zc=;
        b=Zj2YIsSuBGkK1fiIW6L1lY48DwIHQAMPjj2qHHGrlBvz8RxlRNh3EYG0883gUFOEYF
         Xo7+9qF86AOIb/C/X7D20JLqrMmrjUiMJFgBK3WnkDUb7FgHwXEMmYWdd+stTEqHfAN2
         pTr281OHCxWHlB687sNhmTZHj+QA8xYPkk0dJ2B4aBTHiR9Tv+ablUSVyczRoTJTCTTn
         J9MTS2b62cH+/mdO04BSsR4yjuVns4pEZNHp6Cl2gPanNc//q8pcCeIP1fqC5kQvo0P2
         eKxOSnUytXQcmIEnHI22DZk0yifvN1AaG0pFDILlG0hgdYav/eIgVvQE3w/eSX+oRmyV
         DoFw==
X-Gm-Message-State: AOJu0YxelVg9OMMyp+dAiarb9SAlW468u/Gqx9om5WpN6jn4i5HQI/7Y
	Se2hoFF9nvzLu1SuyBhtyT1NXxoQyU9p3AOEH3iXTZoAuXmonMz9aOhs68m17I0=
X-Gm-Gg: ASbGnctE69wasXBuo9hLnlArL7DFTavmiKiY9aP3fVLZnlDvnffb2D82HoGu9le2sx2
	rpcLDqK6suHWn6+QYY1sGIRJZHH2LWh/teQxjYXgD15tU1sLntSijw9mPiK28aSQuTc902vYz80
	30+tbGDcW5OLHtgC3H+6KeKOuPSCWso9p4+ypNe80k5hT9ybqXO4Wa5edcQ39W2sgEmnAwLEajp
	aQaB9sScJKOTYRI5pQbmrLQYWnHvObBpMdSg3iGJcw1PehzPCLqsTLY8UHO1VfSF2Y=
X-Google-Smtp-Source: AGHT+IGDHENjtghc1Za8Ou8nj2p8AxjnEja7Mbb8NKTZwkJkzmvp6cfs8Pf6rR67ZqWrpOAPwG1QBg==
X-Received: by 2002:a05:600c:54d0:b0:436:199e:8458 with SMTP id 5b1f17b1804b1-436dc28eef4mr65744625e9.14.1736349836998;
        Wed, 08 Jan 2025 07:23:56 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8288b8sm52718492f8f.11.2025.01.08.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 07:23:56 -0800 (PST)
Message-ID: <384d6c4b-d2ce-47f8-9030-6225758b5923@linaro.org>
Date: Wed, 8 Jan 2025 15:23:55 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf report: Fix input reload/switch functionality
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 namhyung@kernel.org, irogers@google.com
References: <20250108063628.215577-1-dvyukov@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250108063628.215577-1-dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/01/2025 6:36 am, Dmitry Vyukov wrote:
> Currently the code checks that there is no "ipc" in the sort order
> and add an ipc string. This will always error out on the second pass
> after input reload/switch, since the sort order already contains "ipc".
> Do the ipc check/fixup only on the first pass.
> 

Hi Dmitry,

A reproducer with before and after behavior might be helpful for the review.

It might be unrelated to your change here, but the input switch thing 
didn't seem to do anything for me. If I record two files, open the first 
one, press S and select the second file nothing seems to change. I 
assumed it would show the other file but nothing changes?

  $ perf record -- true
  $ perf record -o 2.data -- ls
  $ perf report
  S key
  load 2.data

> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Fixes: ec6ae74fe8f0 ("perf report: Display average IPC and IPC coverage per symbol")
 > Cc: Namhyung Kim <namhyung@kernel.org>> Cc: Ian Rogers 
<irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   tools/perf/builtin-report.c | 30 ++++++++++++++++--------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 048c91960ba91..42d7dfdf07d9b 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1721,22 +1721,24 @@ int cmd_report(int argc, const char **argv)
>   		symbol_conf.annotate_data_sample = true;
>   	}
>   
> -	if (sort_order && strstr(sort_order, "ipc")) {
> -		parse_options_usage(report_usage, options, "s", 1);
> -		goto error;
> -	}
> -
> -	if (sort_order && strstr(sort_order, "symbol")) {
> -		if (sort__mode == SORT_MODE__BRANCH) {
> -			snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> -				 sort_order, "ipc_lbr");
> -			report.symbol_ipc = true;
> -		} else {
> -			snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> -				 sort_order, "ipc_null");
> +	if (last_key != K_SWITCH_INPUT_DATA) {
> +		if (sort_order && strstr(sort_order, "ipc")) {
> +			parse_options_usage(report_usage, options, "s", 1);
> +			goto error;
>   		}
>   
> -		sort_order = sort_tmp;
> +		if (sort_order && strstr(sort_order, "symbol")) {
> +			if (sort__mode == SORT_MODE__BRANCH) {
> +				snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> +					 sort_order, "ipc_lbr");
> +				report.symbol_ipc = true;
> +			} else {
> +				snprintf(sort_tmp, sizeof(sort_tmp), "%s,%s",
> +					 sort_order, "ipc_null");
> +			}
> +
> +			sort_order = sort_tmp;
> +		}
>   	}
>   
>   	if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
> 
> base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780

