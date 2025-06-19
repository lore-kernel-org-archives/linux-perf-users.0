Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093342494FF
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750321449; cv=none; b=tKlfGF5MnZmfEJ4rk+X/v+50ELfoFyJaI2IjbVhB1I1yXagN4zZBKXacjMMzEttjcEzEg7aoQcrCPp5XYg5BP4KQPUcUHnLVgXmr8KMNQcVDUsnEkDS70aKC4UzLLHW09fzSh+fuiQkqgqB0SFK72mTz2ZGhD6ffHwxEQUXNW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750321449; c=relaxed/simple;
	bh=fjuJFMaIgczpX1qC8kqBKhEOVuSRrClkmArcMFGn2Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=CF6FbnIsBhTgvRahhAOm078bXPyFOBH75VAZNHbsZch4LJzvs+81viMlwtfejsQFBuYNVgTIhLyeFT2TdbKYnVUmQdFn4I3wKHR5SRmUoOdIM08pfbUcAbp1soKS52yPJpK6+XoJxR1QCxxaMd4pmcIPfuvxtpawKtdME6tqAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttOXseDz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttOXseDz"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso300931f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750321446; x=1750926246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q22zQ9ihJ48zZasqPlIeu40rg877vsTtc5J9Nn4uWg0=;
        b=ttOXseDzvDx+0HSFdHpjUDGIisAWbsLyzZVw4uQrhg/UualYbcCcoYebzOXDTGu064
         vFaqY5iDYt3DZGojtIcJsyWGrNBauWnuIXaOGewcwpfr1JfybuWRHkgFlR5QnqVBVUSh
         9V6V9T0wk3nvJ0z35Yes8Wi1EIhKkgE6DjYbI6xZXEX45zb/TvcGDimYEXwJl/dG9PQc
         /7lYPZoti7ymBEeZZO6N6U84gLZkhNh1zFR3neQPhURiu2OJ4jaCGw2W7d4NU4btcOOM
         qOQvsTZEh4XQn+HgyqinidPaYv3n062nhihZfRohBVoe04SaVOzvD2TGvrsv2EkjuNyh
         +87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750321446; x=1750926246;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q22zQ9ihJ48zZasqPlIeu40rg877vsTtc5J9Nn4uWg0=;
        b=Kwqochgrno2OmEGy2IpTwgOTWEjSpuh7AAu3lXHFOTD1J30PlHIv7Gz/ldvNv2U68u
         V+/JPuDhAfba/rx3q3DqyOcb/uMeNhoCpbaPz2n5d4nwMZ66E6tFSTCf+kzUIWpWb7us
         zxOGbwkrT1S/z54bA6L22pKA0SRIDb8pf4ERglyFH0Z+maKR9eXkkhjs//1gZpiTIB5y
         R3pcnb6sqA3IZlFY0vZmnbsa9507VnZfqOpNNV0ncvBlBASuxKhXjt81oZgoO7roJ0Cw
         qP3poc/hgAZlG6UttkLYtRTAep2tI3JdT8W49WHZQv2VtB5T4q/+MRyIKVdqc0JwJ+gE
         tRCA==
X-Forwarded-Encrypted: i=1; AJvYcCXTKGnaYm4lsRpmuXWxD5+cWZ1DJ3IdfAftjKgUIEbSIWwIxvujRiL8PbaLHN07SRo77H0ZnmqCdsmbkDTKrZYL@vger.kernel.org
X-Gm-Message-State: AOJu0YygV46STuJWjAFYE9Wsaevky932LGdBBkGO5mDDbSC8j5+65jv8
	c/AcYlAbBWUM/vgzaiuGPKtFzUzYdCThAcH22v5s5rfjrKJ5Bsif/MEnkfNuEPAnjlk=
X-Gm-Gg: ASbGncsREPEO/cfpCqM2QOf0aP9IVsgzBEoRniIVUUkkT1p0uUdjqiSNw/FgvhpwWsX
	EWW4joVwNgWj8qcszY8T/aYct0PrUsWJtH+jFHUF+X/cGlEDxcubvAK0OTmxE/F+M+KFmAtk+GW
	PnB3eCUszpJCNJtzKAIoLZK9nmg7g54FqQj6JGugC49pKM7yr8/WBJEMSHeUEFaVb/lzSaM1VEY
	ZXBSoLdFA6S7yMG/mDRks9UNuw4cHr5AMjp/vcLcoJzrFJJwY9MkqGofWSgDJieNKwITiO3V4wT
	q2M1vq1SgdJtR/c3eMAHot44ozMUSRrlVscbbz2ZoTXsl5VcDD2DOGgqbzMrnUehuDk=
X-Google-Smtp-Source: AGHT+IG3prb0JZdG8yBrJXbPEyJddXNVxU6+WbkUTfokRjiQKzSLM7C0hI5dwVQ+QosuYnaTi5pF6w==
X-Received: by 2002:a05:6000:26c4:b0:3a3:652d:1638 with SMTP id ffacd0b85a97d-3a572e585a1mr16943912f8f.48.1750321446278;
        Thu, 19 Jun 2025 01:24:06 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b3c0d3sm18939648f8f.79.2025.06.19.01.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 01:24:05 -0700 (PDT)
Message-ID: <393e7584-7ca1-407e-bd42-4079e5d8d4e2@linaro.org>
Date: Thu, 19 Jun 2025 09:24:04 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Add basic callgraph test to record testing
To: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
References: <20250619002443.100301-1-irogers@google.com>
Content-Language: en-US
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Chun-Tse Shao
 <ctshao@google.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250619002443.100301-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/06/2025 1:24 am, Ian Rogers wrote:
> Give some basic perf record callgraph coverage.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/record.sh | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 2022a4f739be..603fa6b79b5d 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -12,8 +12,10 @@ shelldir=$(dirname "$0")
>   . "${shelldir}"/lib/perf_has_symbol.sh
>   
>   testsym="test_loop"
> +testsym2="brstack"
>   
>   skip_test_missing_symbol ${testsym}
> +skip_test_missing_symbol ${testsym2}
>   
>   err=0
>   perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> @@ -359,6 +361,23 @@ test_precise_max() {
>     fi
>   }
>   
> +test_callgraph() {
> +  echo "Callgraph test"
> +  if ! perf record -o "${perfdata}" -g perf test -w brstack

Looking at 2dac1f089 ("perf test: Fix 'perf script' tests on s390"), it 
looks like this won't work there. Although I'm not sure why the fix 
wasn't to change the default -g mode to dwarf on s390 if fp doesn't work 
at all. That wouldn't fix -e cpu-clock being required though.

Thanks
James

