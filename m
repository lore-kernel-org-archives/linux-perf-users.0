Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E1B28C000
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750341222; cv=none; b=vDyyAISiw1zmP5X37vDnw4A+F0c9MwAMUzQsSFNfdrKTJtFosDLPQr6wCwR3vQRclTECBBuB+aBLSPssHBlmaufIm3ihFbEjZGa1Ba9nXxvj76BKS2Obq7l8Coe/cX18eDdBm0VYwD3N99mBLsvg2uDsXVP/UhVtLAUoSHgMqf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750341222; c=relaxed/simple;
	bh=lGEQr7xIozKcToOWBqdVePeA2gA+PYgmVqciFyjHdss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnunGGR5YL7G0J3kCkKYMYw8RHYQsGn0SN79Gkj/x983r2C6JnN9BwMXgtMAEYtVGPwOkczCQU/tYxU2a0BjGFrburbiWcbQTOpBGKNlq9apba4aQ7Fv4yeNe1AVKPBZFHSyQIq/NkMKZPiQVTxVbUgKGTbHrd5308rOGRV/i88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pmkYfziV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmkYfziV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso7342455e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750341219; x=1750946019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUU8zhHO6oGWwG9C0mvXT4R6zlzfuKEc2yTbt3ShlNw=;
        b=pmkYfziVoF5DKKfxTyOKCif088Wri8/+xqsOFv3je4vzQIVVoHrq9jCkoTaIVFfU3j
         pgHSUv+82o7Q9ki4klBalghSkdY6/MnaZdkhC8PA0i5j0KfY85hzcr7DR4ccLeVuric2
         Be1SAX+HPUAGEXWwKC7louRH2OvqgYHUz18jmtCKqKfEB/XmU/66BfRDHSNI5Af/fQCj
         /QINDv+he1E8Jzy6jWc1ySNmYz99pYG9qN4BiZ+oaP9ILr3HyV7rx25zdMU0ifJ/SO/0
         iN5VrmRsjhJ1DIBIE1lUE0EgsOKckGrTXvUaPiOwI3/TRIZq5vm8pDqsqGodQnB6xlco
         YXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750341219; x=1750946019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUU8zhHO6oGWwG9C0mvXT4R6zlzfuKEc2yTbt3ShlNw=;
        b=IiaiIIzTswkYMRz7GDb3lA2/oIFO2cQN4WCVtgFCKcVrxlTWcwosigA00qa1gBRD5w
         KoVAKiWjEk3AEhfD2b4fq9M3C9JAkh8Pg64DdUGn8JmR2PzqreViNH2/qs/RWKh+HwL+
         okIXODwHdMvRRRz7KUA+A7CnMSrGxqx8Y9JvT4o3fBAjFkjGLAd1xPtuRj4nDnsK6YXi
         R7ZZtaxcTbvZg2bb1F3rrlIBG/mrNJnnlian7QZQ9tIIZnBK8Q24qT2U5nuStiWaDdGq
         xuAjaM+Jw27wcd8ZWU/o6RRYELdbKMatYKpvmqMR5rkA4fumSF7sogbQG+h9sQdzd1NB
         651g==
X-Forwarded-Encrypted: i=1; AJvYcCUJzECKJhgWPZUIZXT1b//fIVWE3coF/SjJGIMnIvxLJJHgM3mshaB1Sq6dRZinCunMYYZwZxJhMiu+KpKEDskk@vger.kernel.org
X-Gm-Message-State: AOJu0YzpoQrInqfK36MmNZIc7FbjU1GZoAq1awGdjZeib5RhLXOJV0v2
	CcjH48AFm7jx5Ws5Ac5Cpobqlp4+OcxSrJ0TXGgU6FWOONDOj1mkT6Jv95nJPga065CcJWAVq5g
	YA/KQ
X-Gm-Gg: ASbGncsoqOBml/dhiNV3ctrWLsXCtasV0zNOB1fVoZHoRWXmX7dl3WZx0zQpyp4vo9u
	rg1y3V0HnK36WLxB21J+U9SPelcT2DuIc2erdynyPWgIkrMbpJLqxGcMnXSLXhtZlW6xCAzvftI
	KfMOuwFxJH90jodHgJOucBRrktsNjG3vBb/CyVakQdzxv34moSrXnERVw2vE2BCoVn3ZKKQq5T1
	vvZAXsnzA4l63TLJBD+HUUvQb7uZORHmLmreN8D/XeAV7cK5w1F61nMmt2mMMqwSRgtJa1ZeJnw
	muH4rCw28odu+0wsDdWSN80vN7enuq3GhEXon28Xd4KrAudx5IPKyHQNKUcBDXMcxBU=
X-Google-Smtp-Source: AGHT+IFj4dr7v4Qv8yB+4oBl+szjM3NykRFIgMprDf2uBBkMpXfTY0Dvs/jR/zXiKyHXRq0RFbdEsQ==
X-Received: by 2002:a05:600c:8b25:b0:44a:b7a3:b95f with SMTP id 5b1f17b1804b1-4533cac9674mr184653545e9.25.1750341218748;
        Thu, 19 Jun 2025 06:53:38 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b08a2bsm19906526f8f.62.2025.06.19.06.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 06:53:38 -0700 (PDT)
Message-ID: <5c88ba9f-2627-486c-84d1-2a721ff9ffcc@linaro.org>
Date: Thu, 19 Jun 2025 14:53:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] perf arm_spe: Correct setting remote access
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-3-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-3-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Set the mem_remote field for a remote access to appropriately represent
> the event.
> 
> Fixes: a89dbc9b988f ("perf arm-spe: Set sample's data source field")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index d46e0cccac99a36148b4daa37f2bf2342e6b47ef..fdef6f743cf3c76b1dcdd57f5a2c297642fdd21a 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -839,7 +839,7 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>   	}
>   
>   	if (record->type & ARM_SPE_REMOTE_ACCESS)
> -		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
> +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;

Should this not avoid overwriting mem_remote if it's already set by 
arm_spe__synth_ds()? We do that for mem_lvl above.

We also still set mem_lvl = PERF_MEM_LVL_REM_CCE1 in 
arm_spe__synth_data_source_common(), if it's not right it should 
probably be changed there too.

>   }
>   
>   static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
> 

