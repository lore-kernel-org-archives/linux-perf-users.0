Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0842882D6
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764755250; cv=none; b=aEz4a1X3fc1mPVo6GveGwhxX0aL1mQElWkr1LSvGq+frtAH1/v25kEp6OFLPqRcXWFWFd9p2Xdpslw3oLxzaKOM0sUDJIQ+EKY17sComRXnZtvOU4D549tYCx3RSme0at/tIS7M4oKZgjI41i7J+FmGKM/46ddEBylUw1lZVW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764755250; c=relaxed/simple;
	bh=MhBovvlAZITFwmKXXNeFmOagsrtEp46CiGQjyjv8ApI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaID9lAEX7VWvfZ7aZF+VvCjSVh9jicwEakgXN5sMhGDelwfmTtp6XitbBj6qNV5Kct7QUaCpBmrV7JFgDjbcQqZowm68UH/EzPBjV97S7nv91xZcaUU1o2CnqOBzVKif4KFj2C2nQjSG7bhShsxBu1rdeGCMdUqaTROi5APyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xdWzVS6d; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xdWzVS6d"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so67542935e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 01:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764755247; x=1765360047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bm1DdqPiJrlnyLV0zsSg8+TnOYjiHZIND7D76vp+94M=;
        b=xdWzVS6dHcRLigr5Z3AdfR/o/ou1iTU/1hccSt912pvnbzjJ6fJXp9clGxIsu01DAp
         OVUeY0YSeUyayW8h5oE1YjxYpmpIuwkUGW9YVCadnxQrTpDyS4EYLENek5T2e/PaMVBP
         iQ8Wf4uwDV+TXaYcTP4J5RkAOwB6ldiCa2Q2JrlKpdHBa2fLPMJ0r1eosrfrFUS/75fw
         HH+9oSWAaZsG7pyohMZ6/wrqoJGIyMiuxHXkSrMBY8F3Yi2aBiHORoUVQbRmpxsWagAD
         44ca/692cVKCErZCBbb13HmELqjjb4+9BnZpWHTcVCgC4BU5vTDZXYAfQg+IFTAqTYcR
         ozUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764755247; x=1765360047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bm1DdqPiJrlnyLV0zsSg8+TnOYjiHZIND7D76vp+94M=;
        b=jUsH2GkTxoCoU4vfh1ENNxOwPJoamGUtzpiGlO/F9j7q1qNt+cFuWwhaa/T+CM3KIx
         L4udLNp9gE0p2rSURZgx98WrWFvNuYmjaDorjqp1n53/66K9gB/Qn25JXlcDHYPGr26G
         dVZyPshyT5JFq53P5Q00SISNxcPPcpi8PS/zbXgMzyLW7DGxh2THmDKhnSNxYjyd/Non
         IHA/rGuZjAz0y8Co/IlDBWahJDzsWYLHgjmcn5vef04RE70rjiIFb4NgRBzNYjhJxzBV
         YxKAAaYYMHInDWNtHo7VqVdR9zVZgeqlACVEREvvHnu798poTzQdzDqfItZpx8eG4Lo1
         CiIg==
X-Forwarded-Encrypted: i=1; AJvYcCVHRt8rVQ4D94odFd0gT1/oCbx7g3oZf4V+mEFGQNDsTEHzOq9kQHyu5GV+Loa9SfYSQWn81ic7Av1RPJULx0+M@vger.kernel.org
X-Gm-Message-State: AOJu0YyQa3htLTW3qpV2aAPxLbYBM46BlDNblMHmnanXD9P7rnSxKyyh
	ozMBRUj1V1aLo7NQqoCofdx+F31NUlADgKwZBiMwRwL1HA1slcxWbiYG2Dg9MMODR/I=
X-Gm-Gg: ASbGncvBWg3/j17vXQSjE4BivhMXjc8CwZCEwfrVjPqm/ewYMwY9cCHsl4qYdQY3FeK
	rfREirCcSOkvq0wGIryRU9bq3Su9IvuIjurzsBEiRl/lvssTiupsGffhWIlJAceSYgBNq7kIeC9
	keUO+hwEaicW988LOHxYguS3/2uj8/haM03JTzUm98SquDYAqg+NxCE5lg/NQO2nN/qFJLPWeNG
	ubf7uaSzRiUzMEgakF1Qeqe3YNgTCj9I9/vynzEvdOV0IuSiFGqM8/0SBGrN1gwtmlv05diG6zG
	02kaLqytmPevlt9MBB0dlPxsOG2J+Kt9PzYq5yXJG76emBgVtVh3oEWg7OV3maMIom2a07tTljD
	lZfG0GDH7mPRc37ZB0eYT9lxjFTo1XAtYJwTjrenQt1T8TLd/8FH2edyFG9k4gIcLIWSQMK8Xxp
	Lq/FFdKNwlSetUpq2tETKa+IR4s7s=
X-Google-Smtp-Source: AGHT+IGHokwwRMwkFOyEIwQX0M1wcom6I+DlCZbrKL4a2u7FKQZEA11QkaoBCyKwxvl+m15cLdpoGA==
X-Received: by 2002:a05:6000:2dc4:b0:42b:4177:7131 with SMTP id ffacd0b85a97d-42f731bc552mr1398489f8f.44.1764755246537;
        Wed, 03 Dec 2025 01:47:26 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca9aea3sm37587680f8f.35.2025.12.03.01.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 01:47:26 -0800 (PST)
Message-ID: <7473f9ad-18dc-43c2-9754-1dbcf2db8a98@linaro.org>
Date: Wed, 3 Dec 2025 09:47:25 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf arm_spe: Add CPU variants supporting common data
 source packet
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
References: <20251113-perf_arm_spe_update_midr_list-v2-1-d547768f5520@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251113-perf_arm_spe_update_midr_list-v2-1-d547768f5520@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/11/2025 10:57 am, Leo Yan wrote:
> Add the following CPU variants to the list for data source decoding:
> 
>    - Cortex-A715 [1]
>    - Cortex-A78C [2]
>    - Cortex-X1 [3]
>    - Cortex-X4 [4]
>    - Neoverse V3 [5]
> 
> [1] https://developer.arm.com/documentation/101590/0103/Statistical-Profiling-Extension-Support/Statistical-Profiling-Extension-data-source-packet
> [2] https://developer.arm.com/documentation/102226/0002/Debug-descriptions/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
> [3] https://developer.arm.com/documentation/101433/0102/Debug-descriptions/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
> [4] https://developer.arm.com/documentation/102484/0003/Statistical-Profiling-Extension-support/Statistical-Profiling-Extension-data-source-packet
> [5] https://developer.arm.com/documentation/107734/0002/Statistical-Profiling-Extension-support/Statistical-Profiling-Extension-data-source-packet
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v2:
> - Rebased on latest perf-tools-next branch.
> - Link to v1: https://lore.kernel.org/r/20251017-perf_arm_spe_update_midr_list-v1-1-9de407550354@arm.com
> ---
>   tools/perf/util/arm-spe.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 614ce032f87e46d1f3754258f51bb1693ec128b7..f5bcc84eaa271f4dcc70bb585e517657e523de11 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -570,16 +570,21 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
>   }
>   
>   static const struct midr_range common_ds_encoding_cpus[] = {
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
>   	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
>   	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720AE),
>   	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
>   	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
>   	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
>   	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
>   	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
>   	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
>   	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
>   	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
>   	{},
>   };
>   
> 
> ---
> base-commit: da8fcfba0854dbe0b0eca465d35620c9cf4c89c1
> change-id: 20251017-perf_arm_spe_update_midr_list-b654cc2ac0dd
> 
> Best regards,

Reviewed-by: James Clark <james.clark@linaro.org>

