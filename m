Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB63596F1
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555639; cv=none; b=KpBIncezatcJ1UC5QLHAQ7YNIHBSOFJBS3mc2Gm/DFmt3xGe0wFP5xfQURSZu8BWdhXJZw+wCPwRomgFVW3Bf/2VI6JhVFNLZwTEubn+xwnHQ0Mps9FcFQfm4k+jHe5b0EZGBKSPB9PP7LQ6gNnVKJuPjkS9EN+GjFueNNsKL4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555639; c=relaxed/simple;
	bh=5Squ0Rzfx5aV2e46dwaxedMdIDOCVMCQf+uK+qJlsRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Xe3Trv3b9IY/DKzg5Cbpt3B3cuQapyQi/cKr3IoYjB+T/K+6vkO6pKIou36tbgaKSTCAlPkqrPtvdOrciZ+AjfiZcj2NSUXb0yisQxMGX4WRF0Gb6k/V4MUiVnrneEkpKQKJwsJSv/bQmTxe5blcO10h5s0/KtceL8YmSHVZy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v1plAHtc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1plAHtc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so45644495e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 04:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763555635; x=1764160435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODb3RxhV0k0ztrydxeb6c2yIi0KEyC0QfjpJFdqc3v8=;
        b=v1plAHtchqzUrQd7tQAMbuN1Sdln6GnQoQ1pverJ2JPc83zY6PlHFhiFD3SdWh4u8s
         qN+icxv05G5p7/V15K5+l/xF/Gh07W6yLrqVMLLcrkFhjZqmuNC4KrPFJRGoEeNZGwsV
         dS4VpsvvcMdmf6e5Ey77TQDMBdyDDSyLVWiK3tW3sZ2JBnJ9a8V/F/V+qcdqDkx18bNB
         sJG9ze9q9xPGNB386rfFOHKJ0a9h8DYCWo8Q+IsrNqZ13k2+FhERV5y7lQ55wiY3s1kk
         6y1oiKrhaM2uBio8KGtq7UXrY9J/ydS2DkmaDP0UQ1+Kie2Yv9Vur4GusM+Mur59lY/Z
         X/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555635; x=1764160435;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODb3RxhV0k0ztrydxeb6c2yIi0KEyC0QfjpJFdqc3v8=;
        b=JJvZCAD+mqQRzisWnIy9z6WeeOv2vEzjvjiQiWSV6xeBdyvf9OptVXIR23NCUsvr5h
         PGds19VFHtfLfsVPf2PGxU0ogMsHfHePjGVVYDgl0H9gkyj8Bc3Z4slkSe8ReGaKRDPt
         YwhppNGsScrWaN/PiIBOzDsM72LgXJLuRBEEVxzfe1Qy6TsNxblbep00Bdv01isUfknl
         zpYk9hslcHzSOEMFtL7BeMBTYkxObrGYht+kEQrdSX2hrpxC28J9wLG4Y/augTyYC+VZ
         ObtlpzpQPaGx4506PxiFV1HKLAHpYpS73WJhXAUOOB5QFJz6Qrr0HkJXW9y7ROqE6Izw
         qY0g==
X-Forwarded-Encrypted: i=1; AJvYcCUw4JW0ml2iX2/BVocy9JDRSww1KTfG1hkZ3M4XbAyLvvBRKzKAY2CiOEsAiv2m16e9YG0pPt+KE6RHY1AhMfGl@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfJOhSnudo48oSIgNKZijQDwerqy+JxIWquk86ELPd2ncfIJA
	Vn5qwttPu4QDq8ZFxz5/E2dQ0iuL+d8LkwyVz79AKFNzMnyHVAS43KvwBrLG4l32yCk=
X-Gm-Gg: ASbGnctAx+VVxs4uxZiKPAss7rCYRRC/1eb2sQt9IwsawmyZXvrRlXr34Xt81ijyE0m
	fruPoSMJBoOMgiy1/amxkXv4It6X+N1Ur1mM4rktZg+m4l5v70opMSHJIBaoeFehAqyoPnnG17H
	TjW7F0ntKxzsbMfaLdGqI87k1YX3FSq7N23ZNy3qmbt3fM5CNAqYp5lgnS+izUOuBM3q8FAl7zh
	mdB+5oSgCiskUp2hR2N6KZrN87CFl9Zwl/rmR/wY1G7gsEBiKPJu6KFijWYOOQgHxClzRR+7Bva
	vPVElfBoa38XSB+jSqIGDmm+InFniggJZDoZ75d2OlXuEiuBvLecHCAXU6epwLeiHNQoU5ZlbRP
	TnHJ8gmjJCg1RDeZ9wMK6qHeTLJXrKiwuNTAnkT6jBaA40UAa1bvEHbR3lrOtfpdNvzb66KckUy
	uj3BrASSbHwa3t8BuC
X-Google-Smtp-Source: AGHT+IHbF5Qpu6d4LTcWbYoWoAOOK8CAqb2jBJqJQDDx3xvVWLq2G5b+B5bRg6PO/LcZhYmwnQV06Q==
X-Received: by 2002:a05:6000:1884:b0:42b:3339:c7ff with SMTP id ffacd0b85a97d-42b595ade54mr20516192f8f.43.1763555635462;
        Wed, 19 Nov 2025 04:33:55 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ca01b074csm17291458f8f.34.2025.11.19.04.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 04:33:55 -0800 (PST)
Message-ID: <1d172beb-4436-417c-9cee-e090a76dae5f@linaro.org>
Date: Wed, 19 Nov 2025 12:33:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf test maps: Additional
 maps__fixup_overlap_and_insert tests
To: Ian Rogers <irogers@google.com>
References: <20251119050555.2017758-1-irogers@google.com>
 <20251119050555.2017758-2-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251119050555.2017758-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/11/2025 5:05 am, Ian Rogers wrote:
> Add additional test to the maps covering
> maps__fixup_overlap_and_insert. Change the test suite to be for more
> than just 1 test.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/tests/builtin-test.c |  2 +-
>   tools/perf/tests/maps.c         | 82 ++++++++++++++++++++++++++++++++-
>   tools/perf/tests/tests.h        |  2 +-
>   3 files changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 0d2fb7a4ae5b..9090e8238a44 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -126,7 +126,7 @@ static struct test_suite *generic_tests[] = {
>   	&suite__jit_write_elf,
>   	&suite__pfm,
>   	&suite__api_io,
> -	&suite__maps__merge_in,
> +	&suite__maps,
>   	&suite__demangle_java,
>   	&suite__demangle_ocaml,
>   	&suite__demangle_rust,
> diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
> index 4f1f9385ea9c..2c05d62f40dc 100644
> --- a/tools/perf/tests/maps.c
> +++ b/tools/perf/tests/maps.c
> @@ -162,4 +162,84 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
>   	return TEST_OK;
>   }
>   
> -DEFINE_SUITE("maps__merge_in", maps__merge_in);
> +static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unused,
> +						int subtest __maybe_unused)
> +{
> +	struct map_def initial_maps[] = {
> +		{ "target_map", 1000, 2000 },
> +		{ "next_map",   3000, 4000 },
> +	};
> +	struct map_def insert_split = { "split_map", 1400, 1600 };
> +	struct map_def expected_after_split[] = {
> +		{ "target_map", 1000, 1400 },
> +		{ "split_map",  1400, 1600 },
> +		{ "target_map", 1600, 2000 },
> +		{ "next_map",   3000, 4000 },
> +	};
> +
> +	struct map_def insert_eclipse = { "eclipse_map", 2500, 4500 };
> +	struct map_def expected_final[] = {
> +		{ "target_map",  1000, 1400 },
> +		{ "split_map",   1400, 1600 },
> +		{ "target_map",  1600, 2000 },
> +		{ "eclipse_map", 2500, 4500 },
> +		/* "next_map" (3000-4000) is removed */
> +	};
> +
> +	struct map *map_split, *map_eclipse;
> +	int ret;
> +	unsigned int i;
> +	struct maps *maps = maps__new(NULL);
> +
> +	TEST_ASSERT_VAL("failed to create maps", maps);
> +
> +	for (i = 0; i < ARRAY_SIZE(initial_maps); i++) {
> +		struct map *map = dso__new_map(initial_maps[i].name);
> +
> +		TEST_ASSERT_VAL("failed to create map", map);
> +		map__set_start(map, initial_maps[i].start);
> +		map__set_end(map, initial_maps[i].end);
> +		TEST_ASSERT_VAL("failed to insert map", maps__insert(maps, map) == 0);
> +		map__put(map);
> +	}
> +
> +	// Check splitting.
> +	map_split = dso__new_map(insert_split.name);
> +	TEST_ASSERT_VAL("failed to create split map", map_split);
> +	map__set_start(map_split, insert_split.start);
> +	map__set_end(map_split, insert_split.end);
> +
> +	ret = maps__fixup_overlap_and_insert(maps, map_split);
> +	TEST_ASSERT_VAL("failed to fixup and insert split map", !ret);
> +
> +	map__zput(map_split);
> +	ret = check_maps(expected_after_split, ARRAY_SIZE(expected_after_split), maps);
> +	TEST_ASSERT_VAL("split check failed", !ret);
> +
> +	// Check cover 1 map with another.
> +	map_eclipse = dso__new_map(insert_eclipse.name);
> +	TEST_ASSERT_VAL("failed to create eclipse map", map_eclipse);
> +	map__set_start(map_eclipse, insert_eclipse.start);
> +	map__set_end(map_eclipse, insert_eclipse.end);
> +
> +	ret = maps__fixup_overlap_and_insert(maps, map_eclipse);
> +	TEST_ASSERT_VAL("failed to fixup and insert eclipse map", !ret);
> +
> +	map__zput(map_eclipse);
> +	ret = check_maps(expected_final, ARRAY_SIZE(expected_final), maps);
> +	TEST_ASSERT_VAL("eclipse check failed", !ret);
> +
> +	maps__zput(maps);
> +	return TEST_OK;
> +}
> +
> +static struct test_case tests__maps[] = {
> +	TEST_CASE("Test merge_in interface", maps__merge_in),
> +	TEST_CASE("Test fix up overlap interface", maps__fixup_overlap_and_insert),
> +	{	.name = NULL, }
> +};
> +
> +struct test_suite suite__maps = {
> +	.desc = "Maps - per process mmaps abstraction",
> +	.test_cases = tests__maps,
> +};
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 33de16dde737..f5fba95b6f3f 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -160,7 +160,7 @@ DECLARE_SUITE(bitmap_print);
>   DECLARE_SUITE(perf_hooks);
>   DECLARE_SUITE(unit_number__scnprint);
>   DECLARE_SUITE(mem2node);
> -DECLARE_SUITE(maps__merge_in);
> +DECLARE_SUITE(maps);
>   DECLARE_SUITE(time_utils);
>   DECLARE_SUITE(jit_write_elf);
>   DECLARE_SUITE(api_io);

