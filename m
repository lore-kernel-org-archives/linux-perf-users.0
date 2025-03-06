Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A421D8DE0
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Mar 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254443; cv=none; b=nfkThV4Qw6CIcrADjJYIAwHyGzKGWBtY/xtgr5Qhg39f4RPv5pGcUnvvbSkjELosKask/ROGccML8GSAUbAuT088dOAPLHOuv+vXmsPNlUhVA0YIiRS0A+dHtQOnJxxkV3HuEldKnu8PndXCpHG2GV14f8e3py003Lz3dfBOx08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254443; c=relaxed/simple;
	bh=ocDWJ4p9s7n2aBiEkTNQOAwnVM+Kg49B5GiFnl8AY0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UoBMR89uSvKBmCWpWhwJjV7cfLMkvl39RZUGokUWlX5EzaV0TDRJh+v6feT/cJcD0aG6dqUXh3Eb4EindHqOYCOmJAr94MKrOjDeTwYZvChvxFupHYSK0GTLEQO0B8Oa2iES5AeGPTvLEtQtu73ehthYXqfblaLxsiYs0zkRO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8PaDm2i; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8PaDm2i"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438a39e659cso2189325e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Mar 2025 01:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254440; x=1741859240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yetSAyXhU+AeT+AIBEYa1+lDd3BOD+YukfIQ29NG8n8=;
        b=Z8PaDm2iiCk/iFv9382xCErCghfxV/Qq5xoKC1+HywE/h12cjE/BaBhevSLZ6zzeks
         bR5Vs6bUvuN/n1wcFsGT8TZFgXhBe75z0YIAHdyB6EdgLQ/w5Qj7m2z5zPxKXPj7PL+w
         xjhOSfXKp2aEihWcLgmfmghxG8YDwu6RHr+OpLbRKBM28mgtuCySXgqcbMPlw5x8AHFc
         3D6hghp3JDxw7dbbSApK0526XaWN+cfkOJvNm+ZsPjEDRg7yhTpzw0zRTuDehaSpiW65
         FKu0Kb5pj/geq4BKgOhDK8R0xMzkvr34ljwsfKQ0V0nF6G3GTCaSvcP1CEvFS/RCJdlZ
         XvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254440; x=1741859240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yetSAyXhU+AeT+AIBEYa1+lDd3BOD+YukfIQ29NG8n8=;
        b=ElmP7zq70jhb1Z/qTyglw784BUJ+Ve0nwYuPU8Z6V4ysbkp7VFhRwJ5wzog5aWc0xM
         9PuYEo5RxXPp6RFu5JrvYasg7OZk2MS8u3a6PJio8T9UYSZxfmeoKjAYEEX5tWviwish
         s2gl0iatie0UP9s5vIk3f0zAN2jxfstdRAUEmVjigEcUCEmvs3avgNbOydB1365aTDel
         ePt57Bv7xGTG3odb0uRiyGSbz7VV6OIRRqjdlUbkDOWxLiS40Mr51JnaCCzQErOcHHmM
         jJb7WDi0ac+HogPD/Azy7SeBz62fs4QpXyHWU0v73h+NfiXchX6Kq7BfgdTbbFR/UMx3
         Sybg==
X-Forwarded-Encrypted: i=1; AJvYcCUeOIYJphju7SnsswFBL/xAfMxpY+f2EF5WORdX3IH/z/SWXYCpU4HNR2vNdiKupalR2tmp4szh0R1qS/5ZvrTo@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkudCjdgdu5svLwBQnfQXyUJJNROiNgCa0q0YWqmOL7DOyfSg
	euTLr4aiQtQffEAIxmt8KgE2BqbI97COzhe7VpWgfTZS29Gqc0oGLd16rO0eNfU=
X-Gm-Gg: ASbGncviGLd4pomiA2asZloySzidGbfKDcOixyXXmkl2FqmrBDVwN+1ap472TkVNqAG
	tRliLc1nb5cYfNTun2LFrwSQqGS4vFg4eB+2flKh9ycTgxisSTC2roj0PcvTdD4GI1ZKeFADCYI
	SEBtc2SjClJaYqDfpBeDtKK4aLvnVq74Y+HN+RPrDffMuDtYQjOkTKFbGVZtMXVIyILZejuMB0b
	kGF9T+IN7oaN50Ze2Q+Zbz468Cs55BltzP2qmb2rnCvsNCVp0F20hiZW1/5EnjC8jbkHkHS3NBb
	2sQLcp6cw5IQ2uUppclUjRVrqL0K/tNdGjj+FptaW5ZzOj5cZNkv+w==
X-Google-Smtp-Source: AGHT+IGWRfZvc13aBacUnCiMGOUsDI0ES2OxfOypJSSVIc/MKe01QPLe7C+nLTUVOBpIc42Ba5F7jA==
X-Received: by 2002:a5d:588c:0:b0:390:e889:d1cf with SMTP id ffacd0b85a97d-3911f7b8dbcmr5218367f8f.37.1741254440106;
        Thu, 06 Mar 2025 01:47:20 -0800 (PST)
Received: from [192.168.1.247] ([145.224.67.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79fbsm1520863f8f.13.2025.03.06.01.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:47:19 -0800 (PST)
Message-ID: <83fde43e-b74c-4686-8db1-9d28a60533ad@linaro.org>
Date: Thu, 6 Mar 2025 09:47:18 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test: Fix leak in "Synthesize attr update" test
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250305191931.604764-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250305191931.604764-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 7:19 pm, Ian Rogers wrote:
> The own_cpus map variable may be non-NULL and hold a reference, in
> particular on hybrid machines. Do a put before overwriting the
> variable to avoid a memory leak.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/event_update.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> index d6b4ce3ef4ee..9301fde11366 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -109,6 +109,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
>   	TEST_ASSERT_VAL("failed to synthesize attr update name",
>   			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
>   
> +	perf_cpu_map__put(evsel->core.own_cpus);
>   	evsel->core.own_cpus = perf_cpu_map__new("1,2,3");
>   
>   	TEST_ASSERT_VAL("failed to synthesize attr update cpus",

Reviewed-by: James Clark <james.clark@linaro.org>

