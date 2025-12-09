Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF731DB125
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273642; cv=none; b=kQhCT7htaQlWDix/amYozONrxkzM7+d8ma6vFGaJ4b6btT7O6strJIjJp1c73w1P9Qw33PjxYoCsf7r+wlZz7HgCAeJGfkKxK3Fzy86LpoA/h4RLMH17XQrttrhRFYh7XKlmS9v6jIX+4GXcUXejZc8rbvNbbMviWcWTVU+42Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273642; c=relaxed/simple;
	bh=9TslD7xCl7tSVm0C8zQsYurDAQ8KmYQic8s8dVXNOLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=AgVzFWtPRMTqIwyWMDfCwXEAi5YPUpQvBkSJdUGDj84ojSrFZh15MjmNOXDkFEzsrLty0XRnsP/21RE6/SOOWL8xQFDqCWZvN4ubYVMnVIgHodpTrnneQDHLu4Lz44b58YugUMlL+27IR4iInUkamEbuZRlGDQWhi+8GYw0MvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gMywNWCZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMywNWCZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47755de027eso37608485e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 01:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765273638; x=1765878438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SAXkEChtFVOZf8CYCobgM6VEiPTyXUpeqrCFGBI1jtA=;
        b=gMywNWCZRV0ed1/fU0g7hPFvnTs9uzgij480b/5GfmJgQ2vo/H/IqW7cJAR7PVZUSV
         C1j/h64+IPmntPi3XqQ5I0YP6Myg4a5ywuFYsU4M+oPTPl6t2PjtWRF7ipd5UbAPqKjI
         3aBAIj6KnLTw8E6Tw0BwylB4sDmG1BxitYzsyNBnLsB68tdeQWyQRUZk1tsFF9awuad+
         C70lNQiX6Aao0iiTKRQQnkCbuEPnkKQTg0j/AyQsEYJdlKaNcfKkaXhDsHvC77lgVsQN
         EnSuFo6WMFZclBIskkNBZ5hxQlvx8KV0EKS/bux7At7BwlMGrcTwiMsvxDOWUVfD8sEb
         zUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765273638; x=1765878438;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SAXkEChtFVOZf8CYCobgM6VEiPTyXUpeqrCFGBI1jtA=;
        b=TZaNjao3A8UScjwy1SAyHjvmj6OPZ5yYpJT0/TRawgsZutj26ZeN3ln4RhSSim4+Ei
         jiTOgND1WKQpOg8cLEIkL11UH5XpRS6SC2NYeQQR8xldDBAERipC0mgG3XTjOcf10npo
         LIFzCo+Td0lLm4Mxzvec++Xd7YEyQanv31BS8pMDrYPPdsiB0TFFQAzr5IhGGfPOjRCz
         Wh4D+ytltUArqQ9qBtGycCie4syb511cq5drWlM9BSl5UoVL/pM1Evv6iv0XgAJPgxj2
         yJ4XPtMPOYJZE6XDSE1O6anhzYjEXSRLtl1JKHnjjVfwXuESlVg8K8WCYh8MkvBIF2Wv
         fSUw==
X-Forwarded-Encrypted: i=1; AJvYcCUOautD0vCDbk0k00z9Td2Rnm98K+k85OVgEiB3f2ftAV6L+V1o5bgJxWUUoMtMlgh0P5XXGyHWh5L/GyhVsiYP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+u0sb+oskFf4jYc2VBXXzuG7srDV7CrVGo8whFBrbUZOaVRHP
	JMWNb4HQKjYoDYJfvAlLZkmk9ZL8JCAw6gzzHpq/sBbMVLiSMIiUcGZiTX2xcGPjp44=
X-Gm-Gg: ASbGncsfjM1SihZuMOSeTtmtodHlX8OioMEjyA3pAGfbYrEL5sHYZoGRsQQqFYR2uIl
	LOwi55zqbgyz3IEn+7IURdd9SCV48oSpc5dmWZh57c43BLy6BRFoFXXATqMQzjr6ihHEK7rqFFg
	OI84wNFWm4CD9tM+is6XZbcQoolc4/Z6HAqeG3fmWwxoBczUEZ49WMfeg0sI1+k6YcHzLeBKQPP
	mwT1KL+E6vrqhsN0zJlSBLs2Ibp5Y/mN2KJUD3D89OOJo9dCfLWsJFXU5qcZJUtwsRXERRXIEe/
	OVYgrq/LjPWwaRTcvMb6srtwVCd3F/DSBxPxuE/oQJDS4bMiEnNEZMTg8Sk/N8xNbIFKGAKsK2o
	oOrieLEJ6Yrshr0ifwzofIP5sjwWPPuXATF1dU6/JL8I4VSCRuER0Pvbh8TwmMWBAPa+uvtY4sS
	6WRRD/1gY0V+gRL+o0ECR2XkZ3/NM=
X-Google-Smtp-Source: AGHT+IEyZ8rEBV81FtwtosZhISPa9lLEsQPr8OGMQ2/sDvokQBEAnlNemVfQjOesVjI8iShir2ykag==
X-Received: by 2002:a05:600c:468a:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47939df1517mr83498755e9.5.1765273638400;
        Tue, 09 Dec 2025 01:47:18 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331a4fsm34229370f8f.33.2025.12.09.01.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 01:47:18 -0800 (PST)
Message-ID: <45aa45d0-3fd6-4073-87b5-80af287ca9ac@linaro.org>
Date: Tue, 9 Dec 2025 09:47:17 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf symbol: Fix ENOENT case for
 filename__read_build_id
To: Ian Rogers <irogers@google.com>
References: <20251207022345.909535-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 Haibo Xu <haibo1.xu@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251207022345.909535-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/12/2025 2:23 am, Ian Rogers wrote:
> Some callers of filename__read_build_id assume the error value must be
> -1, fix by making them handle all < 0 values.
> 
> If is_regular_file fails in filename__read_build_id then it could be
> the file is missing (ENOENT) and it would be wrong to return
> -EWOULDBLOCK in that case. Fix the logic so -EWOULDBLOCK is only
> reported if other errors with stat haven't occurred.
> 
> Fixes: 834ebb5678d7 ("perf tools: Don't read build-ids from non-regular files")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Note, a shorter version of this patch appeared in a series
> cleaning/refactoring the build id reading code:
> https://lore.kernel.org/lkml/20251201205509.195451-11-irogers@google.com/
> It is sent without the refactor for the sake of fixing the bug in an
> earlier release.

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/builtin-buildid-cache.c | 6 ++++--
>   tools/perf/util/libbfd.c           | 4 +++-
>   tools/perf/util/symbol-elf.c       | 4 +++-
>   tools/perf/util/symbol-minimal.c   | 4 +++-
>   4 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index c98104481c8a..539e779e3268 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -276,12 +276,14 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
>   {
>   	char filename[PATH_MAX];
>   	struct build_id bid = { .size = 0, };
> +	int err;
>   
>   	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
>   		return true;
>   
> -	if (filename__read_build_id(filename, &bid) == -1) {
> -		if (errno == ENOENT)
> +	err = filename__read_build_id(filename, &bid);
> +	if (err < 0) {
> +		if (err == -ENOENT)
>   			return false;
>   
>   		pr_warning("Problems with %s file, consider removing it from the cache\n",
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 0099b415decc..edf0829e9635 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -391,8 +391,10 @@ int libbfd__read_build_id(const char *filename, struct build_id *bid)
>   
>   	if (!filename)
>   		return -EFAULT;
> +
> +	errno = 0;
>   	if (!is_regular_file(filename))
> -		return -EWOULDBLOCK;
> +		return errno == 0 ? -EWOULDBLOCK : -errno;
>   
>   	fd = open(filename, O_RDONLY);
>   	if (fd < 0)
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 957143fbf8a0..d1dcafa4b3b8 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -902,8 +902,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>   
>   	if (!filename)
>   		return -EFAULT;
> +
> +	errno = 0;
>   	if (!is_regular_file(filename))
> -		return -EWOULDBLOCK;
> +		return errno == 0 ? -EWOULDBLOCK : -errno;
>   
>   	err = kmod_path__parse(&m, filename);
>   	if (err)
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
> index c6b17c14a2e9..8221dc9868f7 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -104,8 +104,10 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>   
>   	if (!filename)
>   		return -EFAULT;
> +
> +	errno = 0;
>   	if (!is_regular_file(filename))
> -		return -EWOULDBLOCK;
> +		return errno == 0 ? -EWOULDBLOCK : -errno;
>   
>   	fd = open(filename, O_RDONLY);
>   	if (fd < 0)

