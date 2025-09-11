Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D531E11F
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604326; cv=none; b=NHM/nyTo5KIEiAADQUWgqS4yzl6+W2p7/qG3kpXPPuCnGbWKl0QzY4iUNQ7JEILW+VFX2i36Ebn7RVPzZwwhf321BB3BU01N5SF5jE0Z+E2sbYNAMQmelvdYd4nSbufEOi5QNbJ2ixXXMGSBN4Tx4+76lgiUWZq2Rzc4fvYTSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604326; c=relaxed/simple;
	bh=qOdo+/ho7H2IRWcVtrVObbugzn8ctUYM48asiN4STyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFVB3wixRydnE21JofzhaB0Ym8NPLM+UZzQdN3+30K+4bf4h0UQI0zJQz53/C8ruNHybj70Fx/awiuV0dQ/dVz928CO7yQD8ogEosil9lLJJglrR7PjjnEh566avDOpThNnrw/pXd7xldvm9/BMJBjTMiSUjP2nRF1u4cxrWHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RuExEXs3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuExEXs3"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b045d56e181so134053866b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757604323; x=1758209123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGqDa7na50Tsqkd5b+BW6jy2kx5Qm/puj3/p65teiTc=;
        b=RuExEXs3j3OGRJTr+/wdkaZMC16Q+RExEwbMJjNPzllzIwOVcOA6lS10MBvgW8dCzX
         d8w9oz6fdPVvvZn/qOE+FiKDNtMITxlPTvbwm1TmdNuEXLJB8SVgkYYk410b465LWBKx
         75N2N2SmoEP5/ci57eJ4SUnGIjp2Ds/mVJbVKtWvx8y1JWwWUzX/hxM85E2D5j7PtgwD
         XlfzOq3Ij+BEr72Yz6eI7GiDZD3n4yEQuQLZIBfUd4l/HwEyGQrSs4dcszBmYiIk3tIX
         pjxEfyUtUZLIfsMrSMr0gQ/JL4MtgAo2fT7fAM/b9GP7TL1Zxo5rOMyMB850T6TMNDtu
         NeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604323; x=1758209123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGqDa7na50Tsqkd5b+BW6jy2kx5Qm/puj3/p65teiTc=;
        b=MPKzCZnnCzWCIOWby8aJ5iQzlaaCBfm4cdMGdNyxzbwa+QvStf0Q2PpBR7yKOSRSrR
         DxQ35u+gTbIF1q1Fm+acu9gOP3ktXYuLPwZSs039lWXcXsH6MRuZPZvyRGgUtF9H6pSc
         8VZY1a00y4eg3Wcw4FhiOpSyBroVbf8CAQcFpEbii2bbHBWD2aT31JKEJ4Jb0LK4sCfW
         rQNvl4CMxqBrOjeGmtLrUmPS/OwbObOouOi/MDshouV3VRNSAIamk0cL340vjjEAcV5C
         Sn41AgSJmPt+dDWBopiBDhxmuAiBt4S0TKhlYg4sgV1shiPldBtv778d5jA2wjcKMbRa
         I+vg==
X-Forwarded-Encrypted: i=1; AJvYcCWf+EM9yfwogc+DdoNREmKG2ym9fAM9s0UHVFLWmEag7fGuszHwIfVtsbtb8F/xQF8f9SiYNTymNlB4PyXH7QAg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5d7jK4au1Q3b6HJPfiCHp6pkKzbgbastKel9DpnOm1lTQ956M
	Zz1PbAp2UBO7cuXjt2oNAqq+CUhcptlaPXiC0t8Lg6KISqYhXb0lCn88hu+ZlwyXcQjbgOT/9iF
	9Vg3G3FE=
X-Gm-Gg: ASbGncvDS9wXQ3OlIHzLqirkx8ieLerDZybWjVoSU/6A6WAzfr+1qU3M7pzlaGGSXJ3
	d5Iy8hcIkBnfGgX4mXP1ncLc7sEN3e0a9I0VN33m/nehgB6pC/C1f2V+nQw8R13+fy2RTV9cphL
	OPO4QqRqes1L+yXrbOH3wrF+AkZoix38eqddATWbYbki7VUe6ME8nyAdGDYuBW3kq+ESBd+IoHe
	mLpCikCmHIiOOV1DxLvsLQ3z/dOgSUBWXTu75QCMDtAU5KwYyEOZ4BNXFInhaaaoQz1c4sKCqKA
	HUupzKzYsxmT3n7f7ZBD1REM5ji6aGK1698norBX1j1NZDftXLeHRwoyOUFJFHDFvhi0N70mAdS
	6wRXmDy7pcPRLZ5W9Vxp4NEgNdfR9jDmvqtzsjA==
X-Google-Smtp-Source: AGHT+IHugeAv/E3LaNGHdPUBYX+6ZpCpqbd4db6KXGZqZL8GkcfgxCKJHoCmuX4C/ujMeGbekya4ig==
X-Received: by 2002:a17:906:7d43:b0:b07:6457:13f0 with SMTP id a640c23a62f3a-b0764571477mr938274266b.9.1757604322845;
        Thu, 11 Sep 2025 08:25:22 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ddf93sm153255466b.69.2025.09.11.08.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:25:22 -0700 (PDT)
Message-ID: <7ecb5900-b7cb-4d2d-93a7-cf0dbdc03cf8@linaro.org>
Date: Thu, 11 Sep 2025 16:25:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] perf arm_spe: Correct memory level for remote
 access
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, German Gomez
 <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
References: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
 <20250731-arm_spe_support_hitm_overhead_v1_public-v4-4-58e5677a412b@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-4-58e5677a412b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/07/2025 2:25 pm, Leo Yan wrote:
> For remote accesses, the data source packet does not contain information
> about the memory level. To avoid misinformation, set the memory level to
> NA (Not Available).
> 
> Fixes: 4e6430cbb1a9 ("perf arm-spe: Use SPE data source for neoverse cores")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 8ecf7142dcd8705c13c27e0cbacd69647dc4fd22..3086dad92965af3981b1065f2892a3e67df7b616 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -670,8 +670,8 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
>   	 * socket
>   	 */
>   	case ARM_SPE_COMMON_DS_REMOTE:
> -		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1;
> -		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> +		data_src->mem_lvl = PERF_MEM_LVL_NA;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
>   		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>   		data_src->mem_snoopx = PERF_MEM_SNOOPX_PEER;
>   		break;
> 

Reviewed-by: James Clark <james.clark@linaro.org>

