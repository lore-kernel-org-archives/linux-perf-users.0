Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877634;
	b=wzZo7r9m/u+Nvy3wTfqu3vAwPpZV4QgsFV3XDFR4ZX0ByYSqlSiFzW/4HIcxlMIuj+KI
	 W1fHFqQomxT8QwZ8CSCCEnhQverreUx5jk+DVw8ijHQXktDY37RG6olTk02UsDXlskPPW
	 MBhj8WUkbNzMuoNXlYYv7rt3lhTqhFdem6LsKToZTx34PzvpkzdGxyOOE+zrerxBEUIKm
	 wKEpp21uWUBjSatbb9/Gsrj5dtmuJNvUYhv8uXzuDfFBONSq2D4AU4fJB4a6iw5/2d/8n
	 v/Ag8Vidr73we5TVPMi9324L1lAIMTiDkV+kcDMfeYbsHl+n3+UBIPFmxY3sNGM77mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xeoaeSY6hWBdqTF2LfnwHjOJ8fsBWiDjXAxCjgGqqOE=;
	b=Pe/jXQ2YOCqCAWnledZXQLGSGRLhb2uAdk6Q/5bBwWQ5UiiSHY6cDVy90sb3A5yfjocc
	 9nm1j2B2HAWD3ztCTEMo6EnmwBhDOa+dgX1CDujhmbL7mRfRv6WtPUrxiwRu92L0p0KAK
	 Ht2V8gT6KGdkYZQeyYMIuF9ULV2Xood3m9uHTBIqqA0HaZGj6QRUg56hbbcLswNZBrbjf
	 q0ziRuwEM5YrXuAuI3NVoMevY+0HRlQ5jUQIizLjFx1u5i1IhcGEBi/aWT1TU2UKG9XOv
	 T8uyBVGBXtHnAUSDKu4GG4t5tsvJNrCgBI0vKHfaCVe++eMiGPc6p0bUs0DjFSx/4QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A8AZpCnU;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96091606A329
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96091606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A8AZpCnU
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c3fd91337baso6620066b.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793877632; x=1794482432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xeoaeSY6hWBdqTF2LfnwHjOJ8fsBWiDjXAxCjgGqqOE=;
        b=A8AZpCnUoesuasIbLyYOZM5OYo5yxRq6ZWJEae4S18wCa5zyQhl3QWsXcorCKE+ppb
         nJrb3ARaEjIA0KG+RfRUExENmf+n4Y5M8t2p6PamnWPoAdYpgCzHrPoDNBtpvmaW+EiX
         1PHCvGWz/LBgo23AKqaxvQkwcW1XhE78vJPhG0dsn+6NvzszLyD7Lq7uu+A9l2v8lgBL
         hTjIVeSGeD/TARzdsWdtD5GAEUFb0ql8TZcmp3Py1R0qgC1pZ/cQgG7uMtp6jRPQ7JlN
         XDeX5zcDWxeikhCadstgjvANNrdnxklWSTDxzfIdV36jYF9IQITq7eJjP4umQ6KMVEBE
         adYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877632; x=1794482432;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xeoaeSY6hWBdqTF2LfnwHjOJ8fsBWiDjXAxCjgGqqOE=;
        b=QGU48D48eGfBELdNQYZd1+5WiRHjcyCggnNvT8ZEyk5da/R9E3ijx9k1g7ItihK9WM
         +3dg0kitL3eXlvmrHC4rsK6KAZdbHNSaeJi7PmAdZWMjCosLoNxihOTauxUleJcPC4+n
         2kBk1It2rSMybvXgjhOrOl9ZOOTuS52oVuP/+zsmZ6uoimbZmkYAMn8/H/1Dqeu1XELq
         I6CU5FIZb+lMWRImf4ABC169/X5MG5VgCbQspgkOBP5fJ73Q2Dj4UNk1qMBJABPGcIqw
         qptTr1mIn7UBFZfsTjFbt5xSvzw4EL55YYdXE6X4G1maByVJcEd8VUcbPU1AZrBxSuXZ
         e4Tw==
X-Forwarded-Encrypted: i=1; AKwUvBzl03b1nyeQfVB0B9U5HHKiU/9I1bjkNGZEFYHSrcphVAzH8hCkQ5NYpyAOATeiO6wjYZkXUkXTSdyMimL9mC/a@vger.kernel.org
X-Gm-Message-State: APuU4Z8k0/PcK07xueCjLH0dxot7kHoWRyMRRe7LbgZjoSojX1vRdRnD
	MnvyyR+Vx/gOyRhKBS+dN6PNaMl6mkgkDKccy+5WjI14lZLdV0XK7dJl5UEnP6uERW8=
X-Gm-Gg: AYBFou04z7oMDZqCIsUDnLuoXJ42y/g1P/pPbDl7JqepvlNQ2sv7Hhfowh7bHvPLLZL
	7at+npzHDO0dKpmZAy9jVtZfuPPlfJTYECDEtGRTivXQ9z6JRqMH9ahtLBDVPUMf4cS34mhIpBN
	B+ixihceJMbP9l/wmZjhQorEn8n2X+muzkxcamC5oFLPDSxQ8OnBGlFrT9X2wgWo5f9NBIMVNWC
	NI8rvFvRV31U+aQ+W0cGX3vPLpZPfc60P89Av002A5d11UgI7jCVxu25Njb4AnzmGXeP6uZXso4
	XuolqZwlKDl9pESaDKPjLg6Hng8nDd6Mj3JNAvD8LG3dDUUMB3P2737ApnOHkn8i1FGorYiYJQL
	ZsunHzjCjOKR7sfgOpdO4WlI1hEhdHByX9baYTESDFZX5c8lZgY9ppawHMcwwGv2p56RNGkQZMI
	lSSyYdb1RRmIqjnJUZu5SLy+cIgMnUrcDaiEbKhdszl9eGhYFA9Bd4DkU1MaNSZglqGYrG3blp9
	2UNfjB/9hZqeKu4wHxPFCI7eVZl/N5Og0moFrE6lLXbxHc2S2pBv3t8b9YSuk8Q4uu1dc2NaOlD
	PGY+cZTiRyHWjHJdT71kkVMGC/pN6WvJ
X-Received: by 2002:a17:906:ef03:b0:c2e:350b:7220 with SMTP id a640c23a62f3a-c4ca7a4b5dcmr1621487566b.9.1793877632006;
        Thu, 05 Nov 2026 03:20:32 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e140010sm165172366b.4.2026.11.05.03.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 03:20:31 -0800 (PST)
Message-ID: <7114498e-d546-4253-a93f-dd0a42e74a12@linaro.org>
Date: Thu, 5 Nov 2026 11:20:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf: do not call list_for_each_entry_safe() on
 uninitalized list
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 "acme@redhat.com" <acme@redhat.com>
References: <cover.1793867553.git.jirislaby@kernel.org>
 <465e342ac620ec4f784424da897aecb4d0aa58cb.1793867553.git.jirislaby@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <465e342ac620ec4f784424da897aecb4d0aa58cb.1793867553.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/11/2026 08:33, Jiri Slaby (SUSE) wrote:
> In test__pmu_config_helpers(), when evlist__new() fails, the code jumped
> to the err_out label, which calls parse_events_terms__exit(&terms). At
> that point parse_events_terms__init(&terms) has not run yet, so the
> terms list head is uninitialized and list_for_each_entry_safe() walks a
> garbage pointer.
> 
> Fixes this compiler warning:
> In function ‘parse_events_terms__exit’,
>      inlined from ‘test__pmu_config_helpers’ at tests/pmu.c:296:2:
> util/parse-events.c:2849:2: warning: ‘terms.terms.next’ may be used uninitia
> tests/pmu.c: In function ‘test__pmu_config_helpers’:
> tests/pmu.c:209:28: note: ‘terms’ declared here
> 
> Assisted-by: LLM
> Fixes: 8e2ef85c66dc ("perf tests: Test evsel__set_config_if_unset() and config change tracking")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: James Clark <james.clark@linaro.org>
> ---
> [v2] drop terms completely (Sashiko)
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-perf-users@vger.kernel.org
> ---
>   tools/perf/tests/pmu.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index 13e8d7fa80af..b6ad2806659c 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -206,9 +206,7 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
>   {
>   	const char *event = "perf-pmu-test/config=15,config1=4,krava02=170,"
>   			    "krava03=1,krava11=27,krava12=1/";
> -	struct parse_events_terms terms;
>   	struct parse_events_error err;
> -	LIST_HEAD(config_terms);
>   	struct evlist *evlist;
>   	struct perf_pmu *pmu;
>   	struct evsel *evsel;
> @@ -226,7 +224,6 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
>   		goto err_out;
>   	}
>   
> -	parse_events_terms__init(&terms);
>   	ret = parse_events(evlist, event, &err);
>   	if (ret) {
>   		pr_debug("failed to parse event '%s', err %d\n", event, ret);
> @@ -293,7 +290,6 @@ static int test__pmu_config_helpers(struct test_suite *test __maybe_unused,
>   	TEST_ASSERT_EQUAL("krava23 not overwritten", (int) val, 0);
>   	ret = TEST_OK;
>   err_out:
> -	parse_events_terms__exit(&terms);
>   	evlist__put(evlist);
>   	test_pmu_put(dir, pmu);
>   	return ret;

Reviewed-by: James Clark <james.clark@linaro.org>

