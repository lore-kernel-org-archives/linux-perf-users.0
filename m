Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED82749DF
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289981; cv=none; b=VjikOkTTYg74yWWsXSjOZVE1/OWT7vQ3FPVLPZJGM+mT8sRix+1oZwqEwKDEF3/7pufJsL+3y6oc85zLU/+Guz0AhLxwiT4PssHsxVNOJLdXFFBaclilYbQvzOlV39ikx+P7PdwXTp5q6JtJHgz41aU4jLSnJfuJ7YGUjCftRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289981; c=relaxed/simple;
	bh=zAp7B/cd+BfVWsSs8Ec9IsdTrIVawQH9FTL4oc9BjqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuSKrHY1s752GxbzMn35ZNn8g1yxgntrEO5luDCPMWbASV3+qw4Z8QPuGO6cKp6FE4XyOjWkmihmDFJ6Qts8vDhTKh61rh0HLJFEExiEijUZJAcxwwGfGVLCryYViHi6wfMjBh1y7PQjRHtXVcS2Hze8/px9/SQDPLUHs4z0/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IWvLn2gD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWvLn2gD"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so15504455e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751289977; x=1751894777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LR7G+ibD4rgaTIYMC1yKY14KOB6Bt7LBBCN91SJpVU=;
        b=IWvLn2gDWyHkE3D/ROgoxvFRtww1jVHsPHUNJC3XVXBxCwVoQGLUodgWwd4harRMhC
         ab9jaEGxyq0DiI1YChgZxOji1rsn9EgRw0/96LC6SfzicPRMY8i16S0Jfm9c/To+n2vF
         dTe68YvR1m63LMWNgNcLl6qyI6KtUE8mFPBEcFa1VAhiMzlqOJpC0y9lDrllYWfp9FWK
         JzPjVLd/Xnk5ADMntmkyrGTC71oEvPz4aINjXLKcEQj9sGNbtUnnBfu7ZYAQr8HbQtQQ
         BNIdh9R32m4fInETJa6ZUdXkJh+uE726VH3PH+tc1qX2v0hjJT+Ql7HWG6CR6r0oGcCK
         Qb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751289977; x=1751894777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LR7G+ibD4rgaTIYMC1yKY14KOB6Bt7LBBCN91SJpVU=;
        b=R9nyLYG4IVZLmNLK2BzGb+mae6Kg/B97eMBdfgL6Jdl0N1Kt7GE/Ul1LgUjRe4oDro
         7D/HUSb1qMyrIkGkEuWKAHO7CR5YC5EY/tC0ZUklf0g1Ys88gnvV0gTX778v7E0TzMoE
         ZrRHAI/YERE+Yw0g772Ud1o84PZyYcnl0u5N2xDQEKW4f7aLngUaDux2uQZn9ekg+C1t
         H7Dg3i6qvWk0ieGyDgnPnXJ64yh1vCGnQGd+tLJ8Se6aQmsB20A4A9cl5T+MtE3HjsyD
         SWE/XpZeN7M5b9IXp7BSGzErg3a9FvSUL+iny6c7TexfFixQfnylbPXP5aeiSXGp+a4c
         RHRw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHsVnWouPuiG12GixN7TA/8a3LG3S7G59U2WmLeM/h22lwytwYIiCOED/x6GjsFAilM0KpakuAqHgokqIqs57@vger.kernel.org
X-Gm-Message-State: AOJu0YxfScaeSexnB9jUIKO6qrBrH5yTD1dVvwAQSPhKPH/W1uZZrcra
	5n6gX8wtZfeHaM4rsrbUA2u4pocw/8zPLPEjblj0GwJek6LmDdjFCedMA8kBc1xjzH8=
X-Gm-Gg: ASbGncvDMj+p743I1XeWOGhrd1Bv19gHnuLgUrzkFArTVrx+v985+0t1Bh9LZAfr59r
	tdnBPPJqtKtJwlAd1jCyUiNfjWy+tEUZCO3Fl8FzSO9VL8bs2758gnGYE/BD6OPtOD/BXRaiv2d
	BZwqn+xmUkfFPkgKeHLONbAQ8N1pvWvTU9OJEjFE8gmmdkrf85eMvfxMgkiB+fQMpohU4//62cF
	VUqhZm9WzcyHh3DlXqQVWrC/KjIOELmGM995V/Vgqm49jNtBjEF3DfjCV93pwmkwsOZvESlOZFq
	SCG1UPHR22gunUSr4GrqR6oDMSbAK5ob9CWelmjhnbOGUisbVX3qNbvEd2jQU+qNYBQ=
X-Google-Smtp-Source: AGHT+IHXyDPllAQfiCnHOhBWNnf3nw0YYqRMT7LLRAVDyR5oQC0yCAsnt4bSuJQio4g5UH+jS57AqA==
X-Received: by 2002:a05:600c:3ba1:b0:450:d04e:22d6 with SMTP id 5b1f17b1804b1-4538ee565damr129693165e9.7.1751289976911;
        Mon, 30 Jun 2025 06:26:16 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe592sm132598425e9.21.2025.06.30.06.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:26:16 -0700 (PDT)
Message-ID: <5ecf74f6-08a0-474c-b0ff-32075af7ae03@linaro.org>
Date: Mon, 30 Jun 2025 14:26:14 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] perf: arm_spe: Armv8.8 SPE features
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 kvmarm@lists.linux.dev, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/06/2025 11:48 am, James Clark wrote:
> Support 3 new SPE features: FEAT_SPEv1p4 filters, FEAT_SPE_EFT extended
> filtering, and SPE_FEAT_FDS data source filtering. The features are
> independent can be applied separately:
> 
>    * Prerequisite sysreg changes - patches 1 - 2
>    * FEAT_SPEv1p4 - patch 3
>    * FEAT_SPE_EFT - patch 4
>    * FEAT_SPE_FDS - patches 5 - 8
>    * FEAT_SPE_FDS Perf tool changes - patches 9 - 11
> 
> The first two features will work with old Perfs but a Perf change to
> parse the new config4 is required for the last feature.
> 
> To:
> 
> ---
> Changes in v3:
> - Use PMSIDR_EL1_FDS instead of 1 << PMSIDR_EL1_FDS_SHIFT
> - Add VNCR offsets
> - Link to v2: https://lore.kernel.org/r/20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org
> 
> Changes in v2:
> - Fix detection of FEAT_SPE_FDS in el2_setup.h
> - Pickup Marc Z's sysreg change instead which matches the json
> - Restructure and expand docs changes
> - Link to v1: https://lore.kernel.org/r/20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org
> 
> ---
> James Clark (10):
>        arm64: sysreg: Add new PMSFCR_EL1 fields and PMSDSFR_EL1 register
>        perf: arm_spe: Support FEAT_SPEv1p4 filters
>        perf: arm_spe: Add support for FEAT_SPE_EFT extended filtering
>        arm64/boot: Enable EL2 requirements for SPE_FEAT_FDS
>        KVM: arm64: Add trap configs for PMSDSFR_EL1
>        perf: Add perf_event_attr::config4
>        perf: arm_spe: Add support for filtering on data source
>        tools headers UAPI: Sync linux/perf_event.h with the kernel sources
>        perf tools: Add support for perf_event_attr::config4
>        perf docs: arm-spe: Document new SPE filtering features
> 
>   Documentation/arch/arm64/booting.rst      |  11 ++++
>   arch/arm64/include/asm/el2_setup.h        |  14 +++++
>   arch/arm64/include/asm/sysreg.h           |   7 +++
>   arch/arm64/include/asm/vncr_mapping.h     |   2 +
>   arch/arm64/kvm/emulate-nested.c           |   1 +
>   arch/arm64/kvm/sys_regs.c                 |   1 +
>   arch/arm64/tools/sysreg                   |  13 +++-
>   drivers/perf/arm_spe_pmu.c                | 100 +++++++++++++++++++++++++++++-
>   include/uapi/linux/perf_event.h           |   2 +
>   tools/include/uapi/linux/perf_event.h     |   2 +
>   tools/perf/Documentation/perf-arm-spe.txt |  97 ++++++++++++++++++++++++++---
>   tools/perf/tests/parse-events.c           |  14 ++++-
>   tools/perf/util/parse-events.c            |  11 ++++
>   tools/perf/util/parse-events.h            |   1 +
>   tools/perf/util/parse-events.l            |   1 +
>   tools/perf/util/pmu.c                     |   8 +++
>   tools/perf/util/pmu.h                     |   1 +
>   17 files changed, 273 insertions(+), 13 deletions(-)
> ---
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0
> change-id: 20250312-james-perf-feat_spe_eft-66cdf4d8fe99
> 
> Best regards,

Gentle ping, thanks

