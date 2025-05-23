Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF85229B18
	for <linux-perf-users@vger.kernel.org>; Fri, 23 May 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747996248; cv=none; b=arr7NGZjohMOH/npBoWqiNGjcFGVrFtsSebJT9G3ioPrLuMs9ieXQ+YS0lwhrg4AyvNCCLOg8vj+o2AILwKTzSRzcaz5oeg7fzsJGkwGm4ROIwgV75PWdXiBuRoIA+JdTqXL5/FQ67JpSV5jz+xF5a7bp40Kk/H1Dv2hcGxM4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747996248; c=relaxed/simple;
	bh=uQxd1eLHfjaOj5/ATW0gmniRkoigc06Od2hWFZtdlR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVqLb+MNwggks2zSKhaSNdHwBU3/NAFPceGeTqPljcUDoQJAFUonjZXrJgPTYNK0aG2nAtqWxxU56RrsKzkMjHlfsjR7pG3r19w5FsDEYAlcy7A5YLxYXXjysyjAGB/MkRSoYhyPrn3JmJjmEfVX1TZkd9HVS4TuejC2/OUkjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VpL8eX29; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpL8eX29"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edb40f357so74906735e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 May 2025 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747996243; x=1748601043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xGc072gf7bPSnQp+Zk/9Ye6hdE1HV449ldZxHQ4WGd4=;
        b=VpL8eX29zBL3bEM5XCwfulyPN3Vx3/P3pSHtyoa1WTiwz4HYuG6T+rq9hECKpAWYWf
         PqermofcTJRQuzpbxytkfeiVO90VWdBDjMvMGLH1c64yLC9HKz+g+r5kBCqM82aKYu1v
         s1eZpysaIvGDomPPjney4eHsYKGUNVEJlwKvsWZ1NyLSOaalMXC+cviuVZJcZfiFLI8p
         uuobytPOqYWD58qp2/eNh9T6wYkWD+xc1ozH7M2cglPqQ+ntT95dE0X1DBXCu0JOoqpp
         BUYXwLcrd/mqVxKRUmUqF1WNzOfVypnG3xD2FQ9R9QZVOWTx2aRPa7SjuGdl/iqGJ2Yr
         CCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747996243; x=1748601043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGc072gf7bPSnQp+Zk/9Ye6hdE1HV449ldZxHQ4WGd4=;
        b=NB/X4aL3HUDQpTwU6iiDh83642JgjW701lwrzOpjhsUgQJiV7K0qE1PUJMw5cUmMVc
         wl2oJ2lxKWMPM0KXvSt3ZCc6MOgCbjDU6R8b5By/2yqAo62c0i16raVzfbgRgxklRvAp
         4IdheZluvBvYJL+zmpaX7YpX/pr42F01IIbxtWXUTvVVaEo/TGe0+/xk8j+z+wqpGYtb
         ewcRju8xyDwJftSa3TidxPKY9qwxbc6+6n6NpchiVjB398qSowv5HJWtEQe1rNZZRncD
         xZA/ha39m4O8nRFGKtNvCShUc03QrakVookExAO+q2nGR+i36ooZiim4IxVYi89PKBKl
         c6tw==
X-Forwarded-Encrypted: i=1; AJvYcCUBO9MH0/5vp7yEIvQnOgW5gQQXOfpVLbQmYFZhBM70gbCsU4n0Bhr6PS9goXnhp8w2b1RtIf9cHRE4OtPuK6jj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6THpRZNS/aUNeL426RMCgzTDDES5CgMfYxhA0HPaifI1Xas1
	v8EXb27+VLzAM+3Tk9nr1/6sKJiHwBlcRH5mT9dhnj7lWVAJgYHnaNhEcjUc/N/7NOE=
X-Gm-Gg: ASbGncuQaaa0KXBM1J5H6cyahrFZ9WHpMNdHJ2NCbBd3Xr1Yf5eSHej5EEY1BO95P3a
	wXCaqnw6ToH6sAfhI+r6CDORJlPPvSuRMXodEvF7TgFQPAbCud+r89PLOBL8ic4K9RP7xkTNG6z
	MsGwTJnHTW6Oy6owA7UjU97Q3Rk3PeqqZf6N/xpzrf5uCegKa/khpLyZ5CX8NbU1L1t9QSFv+9P
	bt6deqw/xDYJ2IrTqnbSOuMqUpaKSY27+zA/gA2+jK/EvLHbo/sDpZLmSFLy+qkg27HLWx4HNBf
	99sCZ9bozlqVFQGSEv7Qlrb9kKhSwhPX3Lj9Zcj0B4cWKgd9xqMrtgXd
X-Google-Smtp-Source: AGHT+IFFW4ht9GhSqBTvucu9XUBb928PNMBRUk/fhSs5hhgU9QRwrO+U6oC+bSVQuoohGmB6W/ygxw==
X-Received: by 2002:a05:6000:200f:b0:3a3:6e44:eb5f with SMTP id ffacd0b85a97d-3a36e44ecc7mr17073175f8f.46.1747996243422;
        Fri, 23 May 2025 03:30:43 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4bfdec3cfsm3862513f8f.45.2025.05.23.03.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 03:30:43 -0700 (PDT)
Message-ID: <4bc8f1ae-5392-4b9a-a67a-391f3e93b22c@linaro.org>
Date: Fri, 23 May 2025 11:30:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf test: Move some ARM tests to
 arch/arm64/tests/shell
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20250522171044.1075583-1-namhyung@kernel.org>
 <20250522171044.1075583-2-namhyung@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250522171044.1075583-2-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/05/2025 6:10 pm, Namhyung Kim wrote:
> The test_arm_callgraph_fp.sh checks with aarch64 so it should belong to
> there.  And IIRC ARM SPE is supported on 64-bit platforms so move the
> tests too.  But I'm not sure about coresight so left them.

Coresight is also supported on arm32 which is why 
tools/perf/arch/arm/util/cs-etm.c is built for both platforms. Having 
said that, I'm not sure if the tests pass on arm32 because we're not 
running them, but they should pass and if someone is running them this 
change could break that.

We could symlink "arch/arm64/tests/shell" to "arch/arm/tests/shell" or 
have a condition in the code that forces one folder for both. Or just 
continue with only arm64. Considering I haven't seen a test failure 
report from there and we've only really been adding tests for arm64 
stuff it could be reasonable.

> 
> Also please test it with shellcheck as I couldn't run it actually.
> 

Shellcheck is working on these scripts for me.

Reviewed-by: James Clark <james.clark@linaro.org>

> Cc: Leo Yan <leo.yan@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/arch/arm64/tests/Build                  | 14 ++++++++++++++
>   .../arm64}/tests/shell/test_arm_callgraph_fp.sh    |  4 ++--
>   .../{ => arch/arm64}/tests/shell/test_arm_spe.sh   |  0
>   .../arm64}/tests/shell/test_arm_spe_fork.sh        |  0
>   4 files changed, 16 insertions(+), 2 deletions(-)
>   rename tools/perf/{ => arch/arm64}/tests/shell/test_arm_callgraph_fp.sh (89%)
>   rename tools/perf/{ => arch/arm64}/tests/shell/test_arm_spe.sh (100%)
>   rename tools/perf/{ => arch/arm64}/tests/shell/test_arm_spe_fork.sh (100%)
> 
> diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
> index d44c9de92d425c62..6c73720cb0ffa99d 100644
> --- a/tools/perf/arch/arm64/tests/Build
> +++ b/tools/perf/arch/arm64/tests/Build
> @@ -3,3 +3,17 @@ perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>   
>   perf-test-y += arch-tests.o
>   perf-test-y += cpuid-match.o
> +
> +ifdef SHELLCHECK
> +  SHELL_TESTS := $(shell find shell -executable -type f -name '*.sh')
> +  SHELL_TEST_LOGS := $(SHELL_TESTS:tests/shell/%=shell/%.shellcheck_log)
> +else
> +  SHELL_TESTS :=
> +  SHELL_TEST_LOGS :=
> +endif
> +
> +$(OUTPUT)%.shellcheck_log: %
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> +
> +perf-test-y += $(SHELL_TEST_LOGS)
> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/arch/arm64/tests/shell/test_arm_callgraph_fp.sh
> similarity index 89%
> rename from tools/perf/tests/shell/test_arm_callgraph_fp.sh
> rename to tools/perf/arch/arm64/tests/shell/test_arm_callgraph_fp.sh
> index 9caa36130175964e..f59ab293d67b9f9c 100755
> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
> +++ b/tools/perf/arch/arm64/tests/shell/test_arm_callgraph_fp.sh
> @@ -3,8 +3,8 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   shelldir=$(dirname "$0")
> -# shellcheck source=lib/perf_has_symbol.sh
> -. "${shelldir}"/lib/perf_has_symbol.sh
> +# shellcheck source=../../../../tests/shell/lib/perf_has_symbol.sh
> +. "${shelldir}"/../../../../tests/shell/lib/perf_has_symbol.sh
>   
>   if [ "$(uname -m)" != "aarch64" ]; then
>   	exit 2
> diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/arch/arm64/tests/shell/test_arm_spe.sh
> similarity index 100%
> rename from tools/perf/tests/shell/test_arm_spe.sh
> rename to tools/perf/arch/arm64/tests/shell/test_arm_spe.sh
> diff --git a/tools/perf/tests/shell/test_arm_spe_fork.sh b/tools/perf/arch/arm64/tests/shell/test_arm_spe_fork.sh
> similarity index 100%
> rename from tools/perf/tests/shell/test_arm_spe_fork.sh
> rename to tools/perf/arch/arm64/tests/shell/test_arm_spe_fork.sh

