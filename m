Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F724A05D
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552817; cv=none; b=GBDlgL41AgwehhjJbR4t23f2YOkjZLWHN3xkhpaHLZ0Oe5DYRZFEUMdWGfkqJ+EnQL4dnZx4xJkpFMr5kGHx2GgVxTOY+7U+eRamo+iN3+uEHZFKKiYsqLNOKWGH9q/SdlmhpsMG75xWzZVvGYhAGHHoK5tFhtlGArWYn3W5tx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552817; c=relaxed/simple;
	bh=Ts0PBj4vN3W1xcvSD2RHkKZFKorcmzgbE1FMjKW75Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4HYIXu7pKtWRBdeTuvkbYC49vaMOQJDMhMwTM8hPiVdFcEqxVSKSihNOdbP5Nouz6cssh5SCDWBqRq6CCL+JsAtxpHzKIXlWs1K01UWH1poKCNTsqEWj3p/1Dzs/+as/N3OWH5ipyfKKAesr+8FM77fUWyqLo+78NShmTMISsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FJOfEliQ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJOfEliQ"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so274707566b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765552814; x=1766157614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+urpy0jHwPQr4pbKKLZ6Gqwgv2IIGRS4o3mszhxT2c=;
        b=FJOfEliQ5EhsABTTWK0r0YfNJ9zPZWGRLvPyvGWwyYJc5YyAxT7vJYaiYkHDHGAo1K
         fiPKomZTYhd/ro/MDgL9qI5HpX0U+DGQWc8WJ/5cPipMEuVw3uI01GZRv+nXa/6Uh+Fo
         /jQjRnJ3dzHLMKQl+ZAn7oGlkxA9ZKdiGYh6a0NYix7My9CifG7zBb8Gmd9GntkIQ20C
         aJPjELdy/mItX4kqlowHtlbLtM6V2Zm0sdN2+KRME3UjazvNfBxSG/wk9JFAsmX5KUsx
         Sjoheo2l2B/GgrS6mjT84ajcfIAT6IwNxOPKEo7IJpE5UfOh+HahwvOJjmx/uttqweGi
         Fmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552814; x=1766157614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+urpy0jHwPQr4pbKKLZ6Gqwgv2IIGRS4o3mszhxT2c=;
        b=NT5FsxrcGlcDqosJyf2ZnMvhDNSgM4lNLs7zjgfxUGe+AOGUt+PYjrT6XHIT76/cd2
         KLW1pnLYz5G2IpokRIXJo7RerbUeIvVNn6aWKekgSTLjflhbCUASSDVqfeqdJeLy6vVO
         k8rHO4kP3unOne0oTcLuihfPYqIpi03adTSKipEUZ7UArEQ6cKB31Bnes7d3foKA0X4H
         361NdJ4UtDJqclAULV/TvcNK+uaYBgSgooTIsELlxUxtee+/I791MaDeLbWtU3wFq/lh
         DC+ZTdWtMRa44/Q9VNnfy60HdqY4Tl3QouwO+lrDxhws4H1X7PLhIXVRmqoAnZ9H7dC5
         DS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjnq4dmvcRdvf6eFkbzkUia68rh+jBYCjGFLliqKfezsPuc9vYKcS77xqUy/zYuwaONBH3riMXqMHGUAzzlNjW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Po5KfsDmCu3QSGnsQfUrLeQLeNrjx9KlTVsRI8nykPdSIwUv
	nWfdx1OnTc9pMAYC4dIYOzQ/VHsxkAJ/sgpT6tRBLpBeRuo5cMoLSR5h/9CbQ58BhVY=
X-Gm-Gg: AY/fxX45OJJ5YJkMiPVomrNXF+VBQxzYZ9nhj1qRsqx7dyGGd8jOmHkHB69Pvh/FnyL
	HRO++oHDRlEch7A4TwpG0URAEFMcBFTTVkEqG5GCuwruqKRPdFGveMz+XNl9ldJrkc9TqpsQ8kE
	kFFk3qnZVdLapMTqcGF5vwQP4/abhOLYK4an3/4tzmoHihLyFmkiSubWN0C10cs+emRSNkk9ebX
	if5d+sbodmwIenYmQ5kUlTms7ZpDRrIjIXNmX3py0L/4Gq3SaaGz/j6qjfGXgIKOHCOKyAid57l
	Zo3kHOWsKWQAVRwyOXmMXKAwCIk9wYLK3aJe13eyaUVMmlYu0NkloZVcEFJ501SBSGZVxLJ0ilO
	gTx9RNDYiJYmcCnC1sXJNEDnthXo5PmQbAidYHyv96CtDtzz8aFKadk53y3I28xZFsL9cSQLDF8
	NSH+PgNhKg+Jzi9GvjPybt
X-Google-Smtp-Source: AGHT+IFj8aQcyuVLP0MLMLGc1zWtUnb9GqVxJFIOkjIdFjf97msY1VByac8tNjxCIR9Q5cScwBIftA==
X-Received: by 2002:a17:907:9494:b0:b71:df18:9fb6 with SMTP id a640c23a62f3a-b7d236eeaf3mr260882066b.26.1765552813759;
        Fri, 12 Dec 2025 07:20:13 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29e060sm603955866b.2.2025.12.12.07.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 07:20:13 -0800 (PST)
Message-ID: <e0410f42-f70d-464e-82aa-7237d779ba6b@linaro.org>
Date: Fri, 12 Dec 2025 17:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf tests kallsyms: Fix missed map__put
To: Ian Rogers <irogers@google.com>
Cc: kernel test robot <oliver.sang@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251210190141.12725-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251210190141.12725-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/2025 21:01, Ian Rogers wrote:
> Issue was caught by leak sanitizer and the test robot.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202512101502.f3819cd3-lkp@intel.com
> Fixes: 34e271ae5538 ("perf test: Add kallsyms split test")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/kallsyms-split.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/kallsyms-split.c b/tools/perf/tests/kallsyms-split.c
> index bbbc66957e5d..117ed3b70f63 100644
> --- a/tools/perf/tests/kallsyms-split.c
> +++ b/tools/perf/tests/kallsyms-split.c
> @@ -148,6 +148,7 @@ static int test__kallsyms_split(struct test_suite *test __maybe_unused,
>   	ret = TEST_OK;
>   
>   out:
> +	map__put(map);
>   	remove_proc_dir(0);
>   	machine__exit(&m);
>   	return ret;

Reviewed-by: James Clark <james.clark@linaro.org>

