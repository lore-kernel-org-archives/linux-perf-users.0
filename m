Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659FA207677
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294939; cv=none; b=QvhutBvTlqj6Sl0UgboQZfwP6TbLpA4m8oIXp79DjGgQI54hz89YZWCuDQdWTK/I/4T/BwlAwP0vFUu2CAP/narvBpZ08CwLm8nYWxopFWHDO1O2Q4G66fHVqTikgaVmfcuZ+ZRmksD7y+8EgCRnuvZynkwuTQ+f9dPQLEie2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294939; c=relaxed/simple;
	bh=pt+AzFr25YDmPiKxl2+sQZis/uOxw8aRE/8RDGmwdqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nD2NyVkTvYNyI51365QOtYt7P5QWRF+W/vk/GHyRYZJHwwmjLlxPphHZ36Ak8pQfsMtpgyEvS/V/u+zA4bkmmj0tFxu8mZ2uW213igdzEKZf6NTMx9xWchw77L1ACqu+9J/i8IN2ZSw/FJNqfqC+FinDw2JADLN0pXcO7UASn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2kIatyz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2kIatyz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so3518303f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742294933; x=1742899733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57utoSkB2MWjRDZuFyIwHMOM2c+jS/zIgSozsuMhHC8=;
        b=K2kIatyzouKFUmH9jas4J4ehBXZ7p1WNSkX2Wl9rcvVg/jrwL3/oGhtZFk4z3egS3o
         1JvJsv2znQtj5jdkbD4QyOHY4YYBslP+Ha0xphduNf9PtkJTkYQw2ohDfmvoO5PStXiw
         GJB2uxIIlplKxZInZagQKJbIZEXTuXRgd0CJOrNCIFWw165PvYMVgRHA6gT/LQD05qZH
         aObRUj4vwdELBtm3thZpoN5251KIGWndItHDbNH7UvzHZephGW8QRvqnlnWYUKZMPeix
         AE+QeOkQhEYCvwYu54FIOIuE38p9zpNF9rOvbGX4E4lJmvF+A4XnQzhPHHXFMnj3761s
         o6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294933; x=1742899733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57utoSkB2MWjRDZuFyIwHMOM2c+jS/zIgSozsuMhHC8=;
        b=dVd3walGRBzhhaARRrrwpmEGF8dFg4NWHYLny0PPJ3Mjp+BwWeDfEhk94FTbenhmuv
         zLV+pqF2E/Odv1xZSPaUstPrUA8xONjAjZl9bsJoyPLt+pYPuJEprH0e6HZB4VtCx77L
         n0f4E1ycBDCtFXK/6HU5yutOUZ4W0hvteXEm0w0mQl4tNj5wgfd9FqyewHMbSfKqv+Os
         mh9pE8kXbpwX1fIfE6bXimQGN9RnRqtydZhsP4wFk3vrrcYebYeO/P6XJUdD6EohE58X
         QZ7GqM1jedVtAkgNRhZIJgZ7Y3Fd3CRVTdRaUheDdQdRa/62c7jMzfclYPu7KH7jwFvy
         3ntg==
X-Forwarded-Encrypted: i=1; AJvYcCUHpG4gggsGrdwShL+dx6tDyVk+2+AKVYupAm2dhBvbi0Vz07fO4PlbaC5l7t1EPQKb4KqHC44A4wHzozyN5Ybz@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKPUfCa5aeJNLdS70RUbNb5cGkRUZvInRUpj9SOKny6IOy9cr
	x6BLHHFCV5uJv6YXYtiwPus/m3uI5RmYfs219MgB+ptrq32Xz43I5exaGCwTYWU=
X-Gm-Gg: ASbGncvsbApcERXpYR8bQy/x00btaWRA4CwuJWiajhNqt6oS3KB5Kba89BN8qrl3oy2
	3uoDbfoT1XvcjzUyFnFdqeY0oX58Oxe3tN/lBdhHhXYw94e1Ye8quM6yhqHhDo4HJN97Po524y9
	SvTYYSss1ltSeO13ZRxFRUGHoztByzVS4xJhwEvr/t171cPhZZlZbzwEnjnRIx2fAsqxgEjxC4h
	VN0kVlvIn6hzxaje/n4qZGkszEilWIZOxa5qC8fzc4tLq/SHy8Oyyw08zICAze9BOv/OhcJv0PW
	bS0AgVi4GVMJkghQLKfNqS4OpQnmiFISmQIbwyd81fF1oTUobHpdCA==
X-Google-Smtp-Source: AGHT+IHPMxFmuHJUzKTFKL/MF46GBaJJT63dHFiZEkBnPXwgw4S7oW5rMJ47Bbnq0qrrRrKTBwKCKw==
X-Received: by 2002:a5d:64a9:0:b0:390:e7c1:59d3 with SMTP id ffacd0b85a97d-3971d03edbdmr20966967f8f.2.1742294932771;
        Tue, 18 Mar 2025 03:48:52 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d21d67819sm124534785e9.21.2025.03.18.03.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:48:52 -0700 (PDT)
Message-ID: <9fe071f9-27bb-4694-ace5-f23eb0d0e50d@linaro.org>
Date: Tue, 18 Mar 2025 10:48:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf vendor events arm64: AmpereOne/AmpereOneX: Mark
 LD_RETIRED impacted by errata
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
References: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
 <20250313201559.11332-2-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250313201559.11332-2-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2025 8:15 pm, Ilkka Koskinen wrote:
> Atomic instructions are both memory-reading and memory-writing
> instructions and so should be counted by both LD_RETIRED and ST_RETIRED
> performance monitoring events. However LD_RETIRED does not count atomic
> instructions.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json | 4 +++-
>   .../perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json  | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
> index 0711782bfa6b..13382d29b25f 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
> @@ -1,6 +1,8 @@
>   [
>       {
> -        "ArchStdEvent": "LD_RETIRED"
> +        "ArchStdEvent": "LD_RETIRED",
> +        "Errata": "Errata AC03_CPU_52",
> +        "BriefDescription": "Instruction architecturally executed, condition code check pass, load. Impacted by errata -"

I think this could also have a 'Fixes:' tag, either way:

Reviewed-by: James Clark <james.clark@linaro.org>

