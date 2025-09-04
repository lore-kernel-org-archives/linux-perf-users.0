Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18613115AF
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007518; cv=none; b=kEcSiB3Ea9/TLNyDA7WjXm6sg8L+l2q01/2vQ6yyZM3FU7zXZGA06E7wSKD44gPJQeOiZl2urol0KdQ/gbxH7Epnv5ZhKA55ghr5Og+X61j5j18o2jUh++2YugE3Op9Ej1db8f2BgdCVpWj3dER8W+gL4P9dGQEEx7Qdm7cwCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007518; c=relaxed/simple;
	bh=eW65k+VLxlVXZoV17Fj7k9z5JFDPDnN8w2k8mCjd9J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Qx42r0yUPG7A/mWeqnc8IqMsa7GIorQg+cfGCikmb61l5nLCQueJktTWPVDBAS7IYK+pISQhHW4lsEkZ718MaR6lRS9zR4dmgp71SlMWEacicKnJT5wiEh3HJfhPXcSMiuI+HOlNO6c09aVBidTiG+fDNBh3R0KB0sIRajV7YpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AsDhFZB/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsDhFZB/"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3cf991e8c82so1221150f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757007515; x=1757612315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UtXXSwtOMhpB/JfdDza+Bmm2bnj1nuhwUXXf1VpvGF8=;
        b=AsDhFZB/Ftbs7s8t/gWSJcLaK6IG/onxH29pXpok4Z63cqy4dksBz3puAbn+ce+Qm7
         UwqcIX1hen/Ef+NF18pk3h58T6e/PnA93gKIZhWsFzI4yZaOkJJmXIZNYcwHMpHHUsYr
         /e4bCbzzQPoB1yaA/Iykg6odbQpJf0prmd0yWTJTW9LJXsMvayiVej4gWoyD2DRvBqrj
         DF2IgkpiOfts0oL4jW8xJyWPR1HT1f5t8JsKwkodmgGyN0B2ASqCZ6plQ2qdyJl+vGAN
         5DrNUbXhyjGW+jEBjVn0kHSOm6WuaBsNdWsn9aJUq7WY64UGC8BsF2za+REbGDcvEuFy
         jMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007515; x=1757612315;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtXXSwtOMhpB/JfdDza+Bmm2bnj1nuhwUXXf1VpvGF8=;
        b=bpReR/Ejm1j7zelzKOxmHWJr454bZ4vKRDM1LOsWoZx3bjjpXIW7SJVdRZQrzM9mtE
         egG9Jg7cDkNR3R+V3sO5s+bUkGKbwaAKQBSo1oyyl4xCna6qMjmaKUmZuRrhhsCzNncz
         Qb2klB2+G3L2TqwBDU3ePvLM9AbDSllhIJNraz1pl91iv804LjB1T1ZV1+JN0G78P6hQ
         cN+vt/Ofc1vQwbE2dRUv4zP3U+sM1/NtHetMZg8PS1MVKLA/xUwejpTF1Oh9IlEfju06
         h6GUKgjFzBMlyvYfsQCXZhXrTn2Hz+Ntg4jwAfjhy35J+deT22G9u3YPjfnB0TJEAsLZ
         QXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPykRn+woiIRIqkhdEaj6GIGzl7aT9ECP99Io3KnGy2SXlLWVCq5LxmhMED/pqgr1W/Hwx8d+dBTXaAGcwXy5W@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw06iRbdk2jS4MFcSS+I8UUVnmHuNO1Gr0J4jDoptvzySfOU0w
	tWmMOEbSl2/LrEB/aWSzGN5ROom9QleKBRLH1mdYQJoVOp/t/2EDALxndFu3cPPHHu4=
X-Gm-Gg: ASbGnct4pYqIe5GXTBMiTXosb8p+Xi/XJsOrM1kvh/q7+U0hoKZPNNT8+ipxo+Fck/S
	j1PSP6SE6YqmjxKlSi9VZWNJ4aalydncpKxvfxMbw2YVExQCTmJAe51EdhNEAf1mnOwNm7lwTnY
	fmgCKpZLbvrbF82LfT+iyxbB4Bo1apxNf0ymy0X389KQcGwiVaLFaDYK53LKLQklomt0rZ3/uYR
	hEVZGGGLcKQyQ0z5p9GzffPKJ8g0WauK0L49aLghwjtvS7/7v3dmfooxY6xv0n8AKcEZ4Z+QqOg
	pzUXa6MMmejyHHlyvOPv9ZDszZ75hpsHG7tzZkC0mqCGOXoPyRXWd6Jp3j4L+TF7SbMW4tEnGcq
	ztBeute+CBLsLABpmJy9QUZy/vJKr4iBqFFUQMQ==
X-Google-Smtp-Source: AGHT+IHfB59Ivm+mMfjEV6WrGYct7tMLyzEnUysui6rpi3Q4B82Cp6TFvFTQAOMx8IN0h9rl8HXcqw==
X-Received: by 2002:a05:6000:2c06:b0:3e0:a5a2:ecb9 with SMTP id ffacd0b85a97d-3e0a5a2f627mr3616989f8f.13.1757007515110;
        Thu, 04 Sep 2025 10:38:35 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d204asm28651472f8f.24.2025.09.04.10.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 10:38:34 -0700 (PDT)
Message-ID: <2be96cf8-39fe-4499-9e6b-97268c685698@linaro.org>
Date: Thu, 4 Sep 2025 18:38:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf symbol-elf: Add support for the block argument
 for libbfd
To: Ian Rogers <irogers@google.com>
References: <20250904161731.1193729-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Haibo Xu <haibo1.xu@intel.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?R=C3=A9mi_Bernon?= <rbernon@codeweavers.com>,
 Sam James <sam@gentoo.org>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250904161731.1193729-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2025 5:17 pm, Ian Rogers wrote:
> James Clark caught that the BUILD_NONDISTRO=1 build with libbfd was
> broken due to an update to the read_build_id function adding a
> blocking argument. Add support for this argument by first opening the
> file blocking or non-blocking, then switching from bfd_openr to
> bfd_fdopenr and passing the opened fd. bfd_fdopenr closes the fd on
> error and when bfd_close are called.
> 
> Reported-by: James Clark <james.clark@linaro.org>
> Closes: https://lore.kernel.org/lkml/20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org/
> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__read_build_id")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This patch should be applied after:
> https://lore.kernel.org/lkml/20250903-james-perf-read-build-id-fix-v1-1-6a694d0a980f@linaro.org/
> ---
>   tools/perf/util/symbol-elf.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 033c79231a54..1346fd180653 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -873,13 +873,17 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>   
>   #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
>   
> -static int read_build_id(const char *filename, struct build_id *bid)
> +static int read_build_id(const char *filename, struct build_id *bid, bool block)
>   {
>   	size_t size = sizeof(bid->data);
> -	int err = -1;
> +	int err = -1, fd;
>   	bfd *abfd;
>   
> -	abfd = bfd_openr(filename, NULL);
> +	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
> +	if (fd < 0)
> +		return -1;
> +
> +	abfd = bfd_fdopenr(filename, /*target=*/NULL, fd);
>   	if (!abfd)
>   		return -1;
>   

Oh that was less awkward than I thought then. Assuming it doesn't mind 
an fd opened with NONBLOCK?

Reviewed-by: James Clark <james.clark@linaro.org>

