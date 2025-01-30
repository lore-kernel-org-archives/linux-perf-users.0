Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E651E9B3D
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249548; cv=none; b=Gzs3gBbomUGM6vxpaH6wj413yS+IRTiYI7A1CbfgtWlgP578GvvOGMAoKuRY/ho1N+OqpYi8YpNyKVkv8kB1+D5bjSa0lh3hfM6ujezb+rSXbXWRi28cCAbtA7BdEhRwO10IQhCGmnRuK2cgeIGXM/i/EjzezxGhMXe2H12xbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249548; c=relaxed/simple;
	bh=DjJZaYBH54lcmefDZb69Ps8DthU6A+K4E/VCjXujuAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBO1AUrqPR+c0ShCUmGIRCoMp3Qolmntf7pxOk97WpfjxJjxeXm66Dxi9Q0LuDjS+KACpAzaqkflmw8L4E+q7UmsBGPLnWlC633w7FDCVQTvAwH32zqT5AdCo+LnIBpqMlaQjhxE0Pkl02okceAVU8SChHYBjKeS1dMNEdXkfAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qw+b7Agw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qw+b7Agw"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43675b1155bso10712815e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 07:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738249545; x=1738854345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAdIIMwuf0LI6GGomoQkpE1H4cM4Q1Gq1YrtNxsRfaE=;
        b=qw+b7AgweOH19UyBf0XrjOdhkX0iyoSI39/m7T/JDMkqsarkKuALMgt3+vWJgfRPlw
         FkRCmOR338VHfOCplykMKIlUX9mwBxqLwyWqj1yTNgsgVUdUt+kv3PuqgoNB/tIbWGoa
         H8T+RppOMO7mCWjCk/MP4qxavbBLO7FK6e+b2Tk+vwYn5/TUV/6h2rVlG/94f61yVk6/
         xR2q6nJ47ZtftAXHqjs/Pqvf7PpNUWhh9gqgqjKPw31nF+MKFK3djjqDT6Gcl2/RCy2t
         7HxYnevZhpieWv8A9PUIwUNjDJ6XJRgbLkOJ2PYmjdBrV69bzRNi8tTYKlxisCg2TvOW
         lGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738249545; x=1738854345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAdIIMwuf0LI6GGomoQkpE1H4cM4Q1Gq1YrtNxsRfaE=;
        b=OPhBDnYeJgQVfA3R301B5N1Tph3xGIZipH0SFe5uAsb2ZeKtiijeJYxGFLuhjOrA85
         K/kTQa8zvo5kqAV64eFd2M8su5LrvffDi/Vfn9Ol6TkLd1Z9SAkXNQpfmKSTikxYB/Cq
         2ONx9EGQSty+2akx7l8xqd6eIGSVwsRZohmbBvMm9/oXDRufGJh9HKzRWdzBqHmLn/XO
         i7UWrAy5UrCrMDm4aPRE3BeIflIgBMe9AWiSX28IZZixmZHgVnDaoJt76MywN80JcgWv
         cmBrvEw+IG2TkYBTtc3bLd7GJY4fQA+fJf1oKSRebS3ct6PnwKaHTegRpV8MjSHe+fMa
         L6vA==
X-Forwarded-Encrypted: i=1; AJvYcCWOYyQsMq9gyyz/4ycpCuBPdf2LMr0woUgKlsAh/+6J9iWpsxYvPUD+WE1fZedpUEi68N7PeWaRSyGRR1oDPQmh@vger.kernel.org
X-Gm-Message-State: AOJu0YydCQjhQHee5pyJ4KhUu3o+HGghMDk+fmqY0Cm4wP3vt/jEJSeZ
	Hau38POqHmHpCt+n50kKM/DQ6nWINtxlWr170AHXWn4sCrrhaQ9OjSURu0z5G88=
X-Gm-Gg: ASbGnct88gtXzxeFGiZWwRd0W2AV2ilDDfC6f6V5HMdeg+SLb0OwcZC/tTcZtoACfeR
	Gx6YL7ErEOl5VJoxyViLDOzDN2FiIRP5tch6gQDTs4qTTCLJL7bBqkyIRh8W2+QSOG5RLoRCuLI
	006SglC8P4lDVKnEH4cTKmuzghWnC4pa+jMBMLSFQj3rjCUMwzUlzJs5DQmp+wMd6iDanCUweZV
	fY8Nig2yd/kdsXkXj0fW8TAbhnhEjd/zWHKLyOlYet3phUS/A2W7GKlvlxL89CwsY5EfAdkD/gD
	PaVzU04hoRfD2oN/SzRW0FjX1A==
X-Google-Smtp-Source: AGHT+IFSEmtjDJsgGNSe43U/QGqwwu3oJj17tbAvWz1VvmGp1+dLACLR1Fe33tkZZ7vdC9W6dkqBxA==
X-Received: by 2002:a05:600c:3488:b0:436:ed38:5c85 with SMTP id 5b1f17b1804b1-438dc3cbc24mr73252385e9.14.1738249544709;
        Thu, 30 Jan 2025 07:05:44 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e236f9bfsm27225505e9.0.2025.01.30.07.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 07:05:44 -0800 (PST)
Message-ID: <6308de05-c5dd-44f3-949e-56e54f7be812@linaro.org>
Date: Thu, 30 Jan 2025 15:05:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf test: Fix perf test 114 perf record test subtest
 precise_max
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
References: <20250130115756.3961722-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250130115756.3961722-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/01/2025 11:57 am, Thomas Richter wrote:
> On s390 the event instructions can not be used for recording.
> This event is only supported by perf stat.
> 
> Test that each event cycles and instructions supports sampling.
> If the event can not be sampled, skip it.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: James Clark <james.clark@linaro.org>
> ---
>   tools/perf/tests/shell/record.sh | 43 +++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 0fc7a909ae9b..b905acde8358 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -273,27 +273,42 @@ test_topdown_leader_sampling() {
>   }
>   
>   test_precise_max() {
> +  local -i skipped=0
> +
>     echo "precise_max attribute test"
> -  if ! perf stat -e "cycles,instructions" true 2> /dev/null
> +  # Just to make sure event cycles is supported for sampling
> +  if perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null

This needs to check -e cycles, not cycles:P. Otherwise the test doesn't 
do anything anymore, because it only tests that cycles:P opens anyway.

So now in failure conditions where it can't be opened the test skips 
instead of fails.

With that change:

Reviewed-by: James Clark <james.clark@linaro.org>

>     then
> -    echo "precise_max attribute [Skipped no hardware events]"
> -    return
> +    if ! perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null
> +    then
> +      echo "precise_max attribute [Failed cycles:P event]"
> +      err=1
> +      return
> +    fi
> +  else
> +    echo "precise_max attribute [Skipped no cycles:P event]"
> +    ((skipped+=1))

