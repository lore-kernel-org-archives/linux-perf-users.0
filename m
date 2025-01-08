Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0141FE468
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jan 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348878; cv=none; b=Zq0iPukMNPVqNm2q/iiWjmxXUrDKwzXLm3L9emiv+St+OLwdgRNex6rCmUqYQql++joJPzAZCvFDyKE3aUXvt+szB8+mqs6FYkYkJkW/oIbZyKZuJb1v4bh0KJg76Ys+xhPV8SWAaB4eewUUGeleIQJ5TLfaq04iVza6XNlv3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348878; c=relaxed/simple;
	bh=s4EFvmigaZ1I1RUfvamfVBDCsV3DT4yoWVj7DOy3dKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZN6TUmcTB1jJl+B9sz2QVBsclrDz1f5LXwb/tWvolVUXOj0nV79YXFJ9VNbKrj8o0gEF/xse8sNDbki48aItdeP0gzz68C/Atr5cmdKXnBUezPRfwjl/1H24xvNoKeReKCh5i6pK8AxUQ78bR1SHbAewp5E2guWSla4U0NO6oUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L/Agd0to; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/Agd0to"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso113224055e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736348875; x=1736953675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7VpBG/KbMCx5xWkKdY1LDcRL9XTJQWjy/R/gffg94UE=;
        b=L/Agd0toAYmGCmCFYgGr8/Nv49sevM9NZwrSEk3PDv8Dz5EFmjYWMVNx8RollIHv31
         oNHCnfSCetmWKHIrr+8aRLcfYFo1qZ6ftWGrMID2uKga2yMiKiJnCejyWjj3jp9uUTpy
         fUn2Rl+GBJkiEgaD7+CcluJisMr29AslCV7i+kMk3rnO6e+se3myQmg+9PgQfhS5YxW5
         Wh19aHFdG+21/M/nBqO32GfhihJyG81XqR7+uoSy206UWnQAexjLhvpnsVtF+wZ+2Ih7
         oocu2YHiNCe5siRYwENdWDUWx+CpZAmaVofYnPHAOM8yord0HMWWSiMkiSnrO13XzEOB
         EXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736348875; x=1736953675;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VpBG/KbMCx5xWkKdY1LDcRL9XTJQWjy/R/gffg94UE=;
        b=ofc48i6W4RkcSrTGJQFyI6HGg47MwChw+wJuZRUGnydtBDN8KlyvIDfuv6+cSaD/um
         It4b9sL+JPMor94erX7inxMq+FQQ54/q6HfSS3rSAV58LHjLC74El4yb3gzDT6WbZlbs
         s0tuot5TYVko022HtKRdkBMChvYntpScnEWTplQGBlBUuEHqOze9skLdPh28waBDw46x
         /Zjw3PJWocpFkfsnfGPj7kOW/lANlCIkDvZ7qTZmAyQyjkvh8ng10qHxjg8AWJ3WcVQq
         3COYRE4X4JfGEIryAPOHQVUQTT+zsbtYN0J0tlLnzN5JoacEYZV3zfDITLXiUNHkJ+ov
         vwQg==
X-Forwarded-Encrypted: i=1; AJvYcCWTHZ3YqOiQWbQ2rBw0BIWDEnKu36YoQb9/sy50pIAHTzsxwNf6iZHszqwHBJ+0QrOf4EDBB6nFQVmYmRRODiAu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6U/FiGknn8Fn3+izGtrAXeIra0yPcorWfOL+zs2cBbi0kzEIk
	tQmIRxEXd0RIvr2LvFSwGP/dNnZ+LoqML3Wuua7PIQsfVx7rpveYEAvPe5cc+wQ=
X-Gm-Gg: ASbGncs64s9yQoGBgVP9vYNw14v9gXTUU2omgLORUCxYPA65iCk44JCoB4CR7xB5Wya
	2bHpvu+wU3/KKzBTMDlqwgNY+bOa8r+SAPkZuT1L89tobW4E2HcrJ2jkv/YObhoAeIc/Hpxw+8Q
	egRoYJ61bm8cuwWMrHtqYWZCXwhFXVGZB5Tg6mWPueYRWxAwnTH2k98kIZdV9obIxFX2giGTiOw
	H4aU+ruWWUP3gzzaUtaNywPPOFg47P204IKkcWsGdXO/WFeUPYBYawapHQBTP9I504=
X-Google-Smtp-Source: AGHT+IH96nc+f4rNc+2B+pIWlE/2a+IZh42CItHbdvY2Xx/w8bBpr7lwI8e17Iuc8aHMAvbCDHteyg==
X-Received: by 2002:a05:600c:468a:b0:434:a968:89a3 with SMTP id 5b1f17b1804b1-436e26a78a4mr27752715e9.9.1736348875205;
        Wed, 08 Jan 2025 07:07:55 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dd11ddfdsm33923525e9.1.2025.01.08.07.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 07:07:54 -0800 (PST)
Message-ID: <ac163e57-1bf8-4662-920c-9dbfecb26c06@linaro.org>
Date: Wed, 8 Jan 2025 15:07:53 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test cpumap: Avoid use-after-free following merge
To: Ian Rogers <irogers@google.com>
References: <20250108051511.1720369-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250108051511.1720369-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/01/2025 5:15 am, Ian Rogers wrote:
> Previously cpu maps in the test weren't modified by calls to the cpu
> map API, however, perf_cpu_map__merge was modified so the left hand
> argument was updated. In the test this meant the maps copy of the
> "two" map was put/deleted in the merge meaning when accessed via maps,
> the pointer was stale and to the put/deleted memory. To fix this add
> an extra layer of indirection to the maps array, so the updated value
> of two is accessed.
> 
> Fixes: a9d2217556f7 ("libperf cpumap: Refactor perf_cpu_map__merge()")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/tests/cpumap.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index 5ed7ff072ea3..2354246afc5a 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -252,16 +252,16 @@ static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subte
>   	struct perf_cpu_map *empty = perf_cpu_map__intersect(one, two);
>   	struct perf_cpu_map *pair = perf_cpu_map__new("1-2");
>   	struct perf_cpu_map *tmp;
> -	struct perf_cpu_map *maps[] = {empty, any, one, two, pair};
> +	struct perf_cpu_map **maps[] = {&empty, &any, &one, &two, &pair};
>   
>   	for (size_t i = 0; i < ARRAY_SIZE(maps); i++) {
>   		/* Maps equal themself. */
> -		TEST_ASSERT_VAL("equal", perf_cpu_map__equal(maps[i], maps[i]));
> +		TEST_ASSERT_VAL("equal", perf_cpu_map__equal(*maps[i], *maps[i]));
>   		for (size_t j = 0; j < ARRAY_SIZE(maps); j++) {
>   			/* Maps dont't equal each other. */
>   			if (i == j)
>   				continue;
> -			TEST_ASSERT_VAL("not equal", !perf_cpu_map__equal(maps[i], maps[j]));
> +			TEST_ASSERT_VAL("not equal", !perf_cpu_map__equal(*maps[i], *maps[j]));
>   		}
>   	}
>   
> @@ -274,7 +274,7 @@ static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subte
>   	perf_cpu_map__put(tmp);
>   
>   	for (size_t i = 0; i < ARRAY_SIZE(maps); i++)
> -		perf_cpu_map__put(maps[i]);
> +		perf_cpu_map__put(*maps[i]);
>   
>   	return TEST_OK;
>   }

