Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304431AC448
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080160; cv=none; b=uvo7mb91HPqbxhViewM1H6WEBenH/A1J2iKRLUcfyalFctS1jWxoLXnjcT/PSMaBlakd9uLyTqGeQRY+7v7U+FMLgk1jun7mwadt3rjdq9Wwu2FzjD989Qm6RU0lim7JDYU0qodb9sfri2bB/WzmYeI97J9TYYwRUr/t3gA6V2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080160; c=relaxed/simple;
	bh=zuQ9erM/M7iamaeG1a0jdschC4zFf+4bb6dpc5Ri8MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=OdhXwRG2D1rI3tGc+Da/PgJ6yQgepIUmXs5DjYb1wQy81hig7BKXG2uDhbXIweL194K8U/HJhLbTFrYek5KdYshNY6OvG1vcmX9F4mrwSN6yhMjvdYrCaWPND5AmLY17fTSQTBvQJwKVOjH9bL+EYnjuWNE1hGxUsnbD9xjdeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqMyYdLV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqMyYdLV"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385de9f789cso1125365f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 00:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734080156; x=1734684956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qo5joHpywoWkkY4oHnkKyLPnalkuQ0udmboD3kZeQwc=;
        b=nqMyYdLVXMgIbPrpA1xc3pjWBrof8HojwOB2hmAXesRvW0xkl1NuSANk9NE6JDpS5a
         HqydzOyZI14MpMLZj4uDv5mkPqFhtJNW/Dv7H9PFP2tHsGecJfZGcEnhyRd8mGET1N1Q
         LRJbnm2OFEZ0jC9LMpkDEvxoX7GnPdtklQSHf1JkcfuF/aONeBsIW2VUx5DvEdPl7OcN
         fDjMyIHdDonGBqEtKUlrwjMmt8MmVgvbgO3AvHA8yTNtuRoAO7bRcgWOWh9OS4/L6p7U
         fPEbSQ15r3BNcPvD4yh6Xo5Z3VFcAFobTvz9HVPJSaIkmpgjFmDGD20spMvPLUBp3MkK
         jIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734080156; x=1734684956;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qo5joHpywoWkkY4oHnkKyLPnalkuQ0udmboD3kZeQwc=;
        b=SFEX7HLFKiidbINeVG66yxmJzONSm33CA55A+70ifx0HHIyCbM1qdpLDG6kT9DCMkG
         GoCNSFW19/YozcdLkGZTXS6VgMD19OvHp9xYre+AIb0GtvSxn6Xnw1g38Ca81sUh5PSZ
         qfJMNT0n8KPY1emyOje8+RVriTvlK51yf1OmTOQ7W6tJYmeeXP0sGFL1Wu+3v4869lwA
         fuIGkiU8q/fuh9dFZcNsRhkEQ0l4/cERZ8j3BWbN4zGpFdF7JykAAFdwFGdCHdTe3VLC
         RqGx82OwJN78yTOAO9CpoWU1e0J43x3mr4jN38hV8wdGO12WReX8ivYLSffrdphcMwYS
         G53g==
X-Forwarded-Encrypted: i=1; AJvYcCWEnnD7QXTV6sYvqUoLmPrZJPuFr2PY+SE+w7a5PIHlpASSsSVjXg12vw7C+tmkxzE+QHTU143kaG2Szjxsk0j5@vger.kernel.org
X-Gm-Message-State: AOJu0YxQd1pD3ubRNm5sOtghTKYk4I5kiaYalrXxfUe8m479lw2h2Dr4
	Af+zOT84Uz4tz5shdp1ogJqiipXFEUhkeHDdGdpJs8XpFl6EhwT/upKLZ4ErrI4=
X-Gm-Gg: ASbGncugLoIx2IbiwEYlNsRrotDiEQZ1z40AvT6R/0KCGXgpGeWgWgXiyup/xfBhED4
	+kNURWSdPw8ecgEPMVK7Mr2ooXfYBAug1Gxpy6uQ0L90kSQ7/QmChEtgLacCmfojK22PqlhGn6Q
	sMi/lxNOjP15pWiPXm+dNur+lZ8r6vWqw1zj1qlYc178PMRQNIj3rU9fGPYO2L/hfsUwpUbSdwa
	yM60oZhZKMGvdzZyGOWCNk9ucwy9j8yd09PJfuwoH9rT6nuBb/5CrYbyBWXaVs13BA=
X-Google-Smtp-Source: AGHT+IEBDJYGw1/kWE2/O+7h0kWTVQEwTh7YcX/i2A4j0wGBNbQhCx2OXIG9Bc40eck3ojtIUm7dwg==
X-Received: by 2002:a05:6000:79e:b0:386:407c:40b9 with SMTP id ffacd0b85a97d-3888e0b5f39mr1003378f8f.28.1734080156533;
        Fri, 13 Dec 2024 00:55:56 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b44f4sm42190725e9.30.2024.12.13.00.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 00:55:56 -0800 (PST)
Message-ID: <56bbbfea-ec52-4f2e-a402-57bf59103416@linaro.org>
Date: Fri, 13 Dec 2024 08:55:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test stat: Avoid hybrid assumption when
 virtualized
To: Ian Rogers <irogers@google.com>
References: <20241212173354.9860-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241212173354.9860-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/2024 5:33 pm, Ian Rogers wrote:
> The cycles event will fallback to task-clock in the hybrid test when
> running virtualized. Change the test to not fail for this.
> 
> Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/shell/stat.sh | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 5a2ca2bcf94d..da42427bb077 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -163,7 +163,11 @@ test_hybrid() {
>     # Run default Perf stat
>     cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles  " | wc -l)
>   
> -  if [ "$pmus" -ne "$cycles_events" ]
> +  # The expectation is that default output will have a cycles events on each
> +  # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
> +  # can fall back to task-clock and so the end count may be 0. Fail if neither
> +  # condition holds.
> +  if [ "$pmus" -ne "$cycles_events" ] && [ "0" -ne "$cycles_events" ]
>     then
>       echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
>       err=1

Reviewed-by: James Clark <james.clark@linaro.org>

