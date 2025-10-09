Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1376B29BDA4
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002333; cv=none; b=GwiAkx8qOoebM9Uohry9jC4GlAGduDgKHucYULlcWM5nSvqzFAvWnA4+gpzpE2CffTftcVfMof67ZTfb+enUlLtRn/K9HSXt/c1OBywdJ9zyV9pvfvMyUeCvcaSFgbMc7JOnrd2GySK9oImbw+sBT9VBbrw7AzbMVXnzdvTOxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002333; c=relaxed/simple;
	bh=GnqugnDf7AcFMLPV8EylpM7ZeCLUqq8BzlL/MS7+knM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbMm/Be4v+QAlwOSOcSpqYP0ddPHUfShCtjbE8x+6P7/F95MB2G9sE65lXdRjxl3BXChJ7TSotfmpbF7DH22eZ+UnahNdk5MFfph3U2RSKaHKfhPpeuZJRQhYSsxZVFJY8+M2Qm/DFfUZfjHq2lNFSb685QuWuTv6G0bR2DL5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wSnaGaIh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSnaGaIh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e2e363118so6166535e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760002330; x=1760607130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9oMA1rnXKTfDC2S12zbkahIjsfKrKZ4pl0JI52MJN0=;
        b=wSnaGaIhLhxCz6qfQAAU+xOXlObN1fXTHVg3H45DeEgbHhhi5PwmG3hdz1p2L9UHN8
         Ph3imdaYhJhMPvlxOZs4tZ5/SdaIydC4jwC7gGlTfY49fTip6n3bJ9h6blKhK2hx8kDf
         icu3gQwu2GehkjfbyowkRN4cotP5RZCrivLrhjgeeOq/Ymp/CJ4XnhPF611u2EufXHcY
         TlS15N0vg1bSlXdyDw401xjvIpZLG24vAbT6iikY7g6ulGQA22Owbc/Z95ay93XBfKRt
         KPiyr4aQ8dbZPcOv5YawrYbjgo0miZqbKmJ0aKEAIzbYDw5OEhu0XIKORmLXiOnYy1nI
         odog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002330; x=1760607130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9oMA1rnXKTfDC2S12zbkahIjsfKrKZ4pl0JI52MJN0=;
        b=lmtA/urDDN013Ijt4M8+vRCF8EjLU9ZVGLwov7J4RoP24/R08jXIvTPkYdp0P8BvJY
         KWZLMnQwu8K0SLJqUZ0D5Pec5Qtnud12ag8vlQULxOurGsGM9uLk3e6sUx0+gefwfX7Q
         8dAYFWeWU/GUBZkjxXRyvUk0y74BKnIKzOYp+BRkqDfDoS9MDrXrGgcL7Q+jJ2vpFhjE
         s5uqPX1xlL9Huya4l7Vz9Et6er8ZpjEH1N0pp3UDjlUgp/CERmafnz8Uytm/vBuwGRVW
         ay6J3Uiy/0UyCEg+Os2sO29ISKWWvyL4MGsluV6lvPJ3ay5LHDdq4mXVnI8KlgBTfxDW
         NZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCVEDgxL2sktt94ieq0Gi91Cc6mYhe5zZyu5fN5F3gLjCbhkc7IFX8FtZCvtuGnogmDB5uX6Rk2sgVpURVrNdASh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk2FvYO+UZJBSYgPh2p3CPCyjyhX7EoL5P2EQq+6lS+gp6eHUC
	hEHGQKXh8eRRbbEguaHNwrJlELuMW5nRS+F5uOcHLkhkyHBdxMh68TP0qtT0DHHK28s=
X-Gm-Gg: ASbGncvVf+yADU1wCz74+IBqfJH23qOekQt9Dp/PG5BxnoOS9s3uSU/LNcbYvVUi456
	RxAn2dzGLYFXCxKKqVAuB/5QNkn2D18O8eoO8kqN/e5gKlvXKYEgTue3zz1OfTHzgvgI8OI+xGQ
	T0wYk7gP7GJmLymhotk6Yfm6nlbWk/ajV8+rHkJiTmBA9Wnu+3xpPOBkK2PIq7l2d6Rp078WXKc
	tsFel3RrxcRIpWV7OMgKmpqVdlEieksNO45e1L0feQbdt074wlqzLQNQlnRAr6qUClQ7bDEehgO
	UOY0mtp+ws1SQDjhwVD4WEfiMP5j0LOXNGNHm0zzadzhO+pVW8G21k+rt5Ptll4vjXQYml6phpK
	0mr3icbewFpiZSN6T1oZdDGAsU5gV0xG3GrHtK/1jHEUNFJ5XAHqijebL
X-Google-Smtp-Source: AGHT+IF2MfwiIaJMXBGQCee6jYIqXrnGNnGXs/YJ/n6ic6dRtYBMifYnsS+nB3iwEXofM4VsmbdDjg==
X-Received: by 2002:a05:600c:4e94:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-46fa9aef553mr57229245e9.24.1760002330246;
        Thu, 09 Oct 2025 02:32:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab36ed3bsm35204275e9.0.2025.10.09.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:32:09 -0700 (PDT)
Message-ID: <94dcea04-c2ab-4fc0-b61c-ac2c1a8d6a8c@linaro.org>
Date: Thu, 9 Oct 2025 10:32:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/25] perf arm_spe: Report MTE allocation tag in record
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20250929-perf_support_arm_spev1-3-v1-0-1150b3c83857@arm.com>
 <20250929-perf_support_arm_spev1-3-v1-11-1150b3c83857@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250929-perf_support_arm_spev1-3-v1-11-1150b3c83857@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/09/2025 5:37 pm, Leo Yan wrote:
> Save MTE tag info in memory record.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 804dce129121b9d2600be01af7f1f2780a9d0fc9..6696448bdf4f347e2032a1b4da46fcdd4016f9fc 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -209,6 +209,8 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>   					decoder->record.op |= ARM_SPE_OP_UNSPEC_REG;
>   				} else if (SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG(payload)) {
>   					decoder->record.op |= ARM_SPE_OP_NV_SYSREG;
> +				} else if (SPE_OP_PKT_LDST_SUBCLASS_MTE_TAG(payload)) {
> +					decoder->record.op |= ARM_SPE_OP_MTE_TAG;
>   				} else if (SPE_OP_PKT_LDST_SUBCLASS_SVE_SME_REG(payload)) {
>   					decoder->record.op |= ARM_SPE_OP_SVE;
>   				}
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 08ef83cb8bf00be75459c78b9ee8a6cbf1971986..9b7b6c42505f43c32a188b6e9769390f057adce8 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -42,7 +42,8 @@ enum arm_spe_op_type {
>   	ARM_SPE_OP_UNSPEC_REG		= 1 << 9,
>   	ARM_SPE_OP_NV_SYSREG		= 1 << 10,
>   	ARM_SPE_OP_SIMD_FP		= 1 << 11,
> -	ARM_SPE_OP_SVE			= 1 << 12,
> +	ARM_SPE_OP_MTE_TAG		= 1 << 12,
> +	ARM_SPE_OP_SVE			= 1 << 13,

Changing the bit position of ARM_SPE_OP_SVE looks like a mistake. Don't 
we just need to add ARM_SPE_OP_MTE_TAG at bit 13?

>   
>   	/* Assisted information for memory / SIMD */
>   	ARM_SPE_OP_LD			= 1 << 20,
> 

