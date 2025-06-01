Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F1214811;
	Sun,  1 Jun 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748804380; cv=none; b=ZCO7BfG0Q5+9ia1LizEy00SGKpJl74XBYegFk20fjPsshlrSZ/gJEpXE21H8AsFCTKDDlGImOw6wxQ/jyDGFWwa5ORfrYD8dUtE2GX7vIrc9oOoFZBrRFtzsmiC1rjo5o3uv+3RApQoZjM/wuEpwYxg44OsrP7jTcoFzMMJS1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748804380; c=relaxed/simple;
	bh=CYLV8wcogXdtY6I8xKrSP6yV3kKGzgHfcr3A9i96Yx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzVPZWdAJgy+mkzzFEU9RdKYhZ6181RiGuuYoHP09Og9dBUSLiAaTNdSiBZyKhftihLYkGEL2rkNKgj63AVMGxFwF0qAiuxfw0QwrTtn4Unf+HOuUe6KiHhYInp9tIaD6AfhfVNRwQUiJmeKtM4phHpj+fHBRCRcuXzeT0KG1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lpnu88Io; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpnu88Io"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso7801325a12.1;
        Sun, 01 Jun 2025 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748804377; x=1749409177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OIzFU3oveHSb3b2sYKrjUAfhi3Wxf+qS7iSQYpFodfw=;
        b=Lpnu88IocyLWUAlXdtXCpePK2YemWqhcbfPJGEOKqNCnfbnrGiQER7kYnAw2erw7uv
         VriGzTueIVwE9BicjFUhpY+kAJLkYEAsSBbcDbkLTyc6lIj1lLZ5AJ0LyBtP1I7NIlSI
         Gw8hGm/Nyoz30EZidkQn+Iz+R4tYobFK5qBR2FPmT2eaPrDbDK837HVYiBD+KUdprIkK
         KZWjN+B3ZSc3NNtolmVCZWIyzTwwSQ2d2gPrKJm1AIvm3RzwJq/C4cfooHDl/C1abQw9
         Yrqcae4Q1pSNnrnDj66uqIsqU4IFgplYCOasvrbNo0gV9BNS2HtnxnUl+peM7O7L/Y3w
         JG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748804377; x=1749409177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIzFU3oveHSb3b2sYKrjUAfhi3Wxf+qS7iSQYpFodfw=;
        b=PvtPm08A6j1AP0qfrkV/gCX6zGMT1DpXEso606QBQjydaLJLl0hrCt3g5R5eXDWW23
         YTRpxrEXwLhvLwTQiKvqMj8Nsr5Qo4kFYW1uZHbYnPYZ66LX7APojOSpTN6qIOWukyMr
         9qimiLuTiFX0jRI4d3LXgJTeLQ83jXBvylmKCdzfcgN4s0qdENbAyot+b3DZtSFKsdrU
         U5DOcbJX0O5ZW7tsNymLlkdDrZuwTWFrZkwXcXSpP8BbE95/kcbRRG3v6//jdskUqgba
         4OALNewa2sWayTD/zVSqTqHmuJgOnzCHslKHBY4Ko7REt9TjQmb38fR3c439x3yi8DKW
         8lcg==
X-Forwarded-Encrypted: i=1; AJvYcCUXKORM8H5wsCscR+ZgxZ5NWYJFDbMmjGwRKkW6GpeLxy45t6D1AWmNy0bTYDiLbjxr40LwmrRwZU51@vger.kernel.org, AJvYcCVUGROQKpyu+uf/TThEdrmzwR3HIntt//LgO9+/GI/ZwAaUEQTYtN3KvnuYdJIGPm61WuCoI4fWNlavXd2t@vger.kernel.org, AJvYcCW/7XcCmNlVU9Xwnfjka8MPnqv+sekQ9hoLD2VVJ+mQ7x30xIxFXexB40JbvXiPmxgikYZaQQhk/m2ZIx/G0WU0QA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhPGlPbDaYnT9N1ZYMIRFqkSXjbzSPo+1VBDKewnZMg0oock47
	dYy0oNPKtbIE3s6FdCVXYqemv4/Mg6mtSzQAE52Vfd82NeJlRBgDqshH
X-Gm-Gg: ASbGncv2NvfedNUCBf6AOCpJQ8rdxdagrLH4lkOGLp3wRSAuCYLMCjJ5WuFNzUhmz4w
	Ij5a1JE0iQNbSun1lLdHb93T/ch4x7gxbAC20zEkW+dzB+T1cs6ya77hY7D4P/Btz6P1c1JTMnr
	uIS6wm0/NPJPzvzNng/hGB2vfPh3hJrHK+TTS3mrl8T5HdhrkMIiB9OQt+oiv2wR4V3hZLrNySI
	iqFCaS0N0koqvxezaBe5mQErVw6MEX56lJVyp284FkvJr5Jc39hA9juiNDsTsG53TziaZtMC0hf
	dnqUGIzbg4LZJ5aMCSW7lntpbtM8A2yrcrqpcKL29DNBH0B9mQRPXRsmECJIUVda9YefWvLkqVC
	LUMrK/qEh4iFatyX/+VsX87jgtrEqhw==
X-Google-Smtp-Source: AGHT+IEP2x5ZAxqIc1gsA4YFDwl3131Qs5D19FYWLp46cTsFeKuOi08zZGcuKt6dA7kp1G6jlmOOpw==
X-Received: by 2002:a05:6402:90e:b0:601:a35e:6dd1 with SMTP id 4fb4d7f45d1cf-6056ef00a9amr8866615a12.21.1748804377131;
        Sun, 01 Jun 2025 11:59:37 -0700 (PDT)
Received: from [192.168.1.105] (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-605ae6eb0e2sm3059856a12.3.2025.06.01.11.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jun 2025 11:59:36 -0700 (PDT)
Message-ID: <8d14bc8d-6a29-4317-9ee6-143a2919d17b@gmail.com>
Date: Sun, 1 Jun 2025 21:59:35 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/21] drivers/perf: apple_m1: Add Apple A10/A10X/T2
 Support
Content-Language: en-US
To: Nick Chan <towinchenmi@gmail.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250510-apple-cpmu-v7-0-bd505cb6c520@gmail.com>
 <20250510-apple-cpmu-v7-11-bd505cb6c520@gmail.com>
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250510-apple-cpmu-v7-11-bd505cb6c520@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/25 18:10, Nick Chan wrote:
> Add support for the CPU PMU found in the Apple A10, A10X, T2 SoCs.
>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>

Tested-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>

> ---
>  drivers/perf/apple_m1_cpu_pmu.c | 127 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
...
>  static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
>  {
>  	cpu_pmu->name = "apple_icestorm_pmu";
> @@ -1155,6 +1281,7 @@ static const struct of_device_id m1_pmu_of_device_ids[] = {
>  	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
>  	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
>  	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
> +	{ .compatible = "apple,fusion-pmu",	.data = a10_pmu_fusion_init, },
>  	{ .compatible = "apple,twister-pmu",	.data = a9_pmu_twister_init, },
>  	{ .compatible = "apple,typhoon-pmu",	.data = a8_pmu_typhoon_init, },
>  	{ .compatible = "apple,cyclone-pmu",	.data = a7_pmu_cyclone_init, },
>

