Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB1206519
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861695; cv=none; b=Bl8iLTRVYodtpc5DyqE2DkpytpnrF1U42Gls0AQbU1NT/bNGE3HBu5NayYoovaMJG0v8fcrsQolfbNjqcWB2KATrVxXLGygFjsgELaUsAA/JiqNElBflE8vkx/kzFCZdg0JG5M5W1MMKRPTRcMp5O8Qq3W3k8zOjBm0joEH9ayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861695; c=relaxed/simple;
	bh=OBLteaS4HM2lnpRIJrjsfcl72EPB1NXuaAiDGpXkXFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnG74Qq60WiOFUAaE6YWoXj2X+I+nsh20kHuFnBMRJoQoggnRrzS3ZXE0MBBuyesYzy4OtUbOERWhap5ML1ngY4lKTW6arrwdo05XzP/vkJUEgg7CsdjkcIm7teP8IvOx4Y9m0xDzzVOmACtqKlBxOzvLOmYEy0eqqoHRk2rnY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P/g5rBQT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/g5rBQT"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f72c913aso2648760e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729861691; x=1730466491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eM5nkTRxomZGNrAn6Kh9dqC0qKVLwKAVOyxctouNCUI=;
        b=P/g5rBQT0LG9PGWy5RtuIM8KkDLLIKcbZr5MQJi0tOANJvpexbgKg8XGAF9jLViWl/
         gdTDGbD4k7yL2TYB5WujuLZu2HmaA/5Vnm2lBAJbaDl0VG4TLKxwyAKzsU+pLLEB3+MG
         o6fu7dgT2iuNzW7Kj2jz6vnvB5AeHlhWDb6IloxhoRH+BBVpe6ZhQWRi1Tg15I7JyC2Q
         b5NSDFl2NCaOh8TXYHmx9Ef0aBs4x9EuVLNC53/1yiA4LdZoCAmW5EYmaKKBtR7/cmM+
         ZKfQ2xa67J/AbiflSD50LyEnEla7zaelmGY3VovoPWJRI7SnDJ7ZqrLdzPckZqrETiso
         LShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729861691; x=1730466491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eM5nkTRxomZGNrAn6Kh9dqC0qKVLwKAVOyxctouNCUI=;
        b=hy9O11tg888fivlp3GvNytNf4QAjJLP1ILVVM1+IbLlM337WrUca3oYtR29B5ylQTI
         pSsf3ngKMJxkxVNvJGl63qryyeACB10BDLIZ6ouu3IUrh5iHWLFCIPtnN6ZTG5U5fUbj
         Nm4ADogGW40sv2AzMd6XT+NUcRhFtfT8Dc2ngZ1TJ/Qo34booliHnDrja7y+gJ1Br8mS
         getnhEdJrhm08BF6+9GzMUCgXpO8QGn0kq3KrAqT8uF3Zgz93ApHtCEH8ICrngQ/dREx
         nw7iEfqDyJ3i7eTl3anlnd8h5PyQh39MAr7gml56AT6S+STTUsOTh0xQbeVteULwbJ0i
         RhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOp+BYyxD4nW3ca6FfHu+YT/vntMqJDCIfzsJc0ZgY2KH2kliodgouO8IsRLR53DSCL/+Hf50Ac9irYGo5P1bb@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTGusZ6dOowtPjsv3+aVxFRAy/XYACIVXBodlfDufk2YAuu9J
	jaCZBe91pipc1IZj255TgsKjXzBU+kgId4e6CXOSTPyU4lW15R1sCyDIu7XkV3w=
X-Google-Smtp-Source: AGHT+IFCT0tBIW4gocugoLB0PVdeFxoiVJ9M/pABhSRPvl5b0xI66ZUSnk//HMoGyQlwk1X0S/7NtA==
X-Received: by 2002:a05:6512:1286:b0:539:fc42:e5ee with SMTP id 2adb3069b0e04-53b23e0880amr3207615e87.29.1729861690929;
        Fri, 25 Oct 2024 06:08:10 -0700 (PDT)
Received: from [192.168.68.136] ([145.224.65.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b7e8sm48189595e9.48.2024.10.25.06.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 06:08:10 -0700 (PDT)
Message-ID: <1e115332-f68f-479a-8ae9-6b9a3120b21c@linaro.org>
Date: Fri, 25 Oct 2024 14:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] perf arm-spe: Allow synthesizing of branch
 instructions
To: Graham Woodward <graham.woodward@arm.com>
Cc: nd@arm.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 jolsa@kernel.org, irogers@google.com, mike.leach@linaro.org,
 leo.yan@linux.dev, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241025105212.51779-1-graham.woodward@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241025105212.51779-1-graham.woodward@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/10/2024 11:52 am, Graham Woodward wrote:
> Currently the --itrace=b will only show branch-misses but this change
> allows perf to synthesize branches as well.
> 
> The change also incorporates the ability to display the target
> addresses when specifying the addr field if the instruction is a branch.
> 
> Graham Woodward (4):
>    perf arm-spe: Set sample.addr to target address for instruction sample
>    perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
>    perf arm-spe: Correctly set sample flags
>    perf arm-spe: Update --itrace help text
> 
>   tools/perf/Documentation/itrace.txt       |  2 +-
>   tools/perf/Documentation/perf-arm-spe.txt |  2 +-
>   tools/perf/builtin-script.c               |  1 +
>   tools/perf/util/arm-spe.c                 | 31 ++++++++++++++++++-----
>   tools/perf/util/auxtrace.h                |  3 +--
>   tools/perf/util/event.h                   |  1 +
>   6 files changed, 29 insertions(+), 11 deletions(-)
> 

Hi Graham,

I think this is V1? Also it looks like the base doesn't include a few of 
the new SPE changes and it doesn't apply cleanly. Make sure it's based 
of the latest (46610ba41ef1)

With that LGTM:

Reviewed-by: James Clark <james.clark@linaro.org>

