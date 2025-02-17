Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B91494DF
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805610; cv=none; b=l4AZq/eSAvxqeeavu2m+TM/4LPhboKpFhHeHzb9xMsczCxVfdCvrrxAxnr+ndTW5RiRIJ5Hnz9OGC/UqExW4aNsedO9xhbEvDmu5y6v3entKcdZuREqc2LjXYFIxuvuimH771/WoYjWJ9HxeW2CDko5n+LcRvmSZAcrTDg25qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805610; c=relaxed/simple;
	bh=KVWUqsJuILxtmph3ASszD0/T4+ePwGKfxLrmWToHO6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=rlhLT9AhaxIz2VF4wgoR0taPJ9HcwhG1vrKKYqsLmf7ariPCgesn1ewVvp1LwP08biKvp8vc1Uo8OACFlMyrM6JOhXoxFq36pcZ10JzdGksrcCzYOi9SPEzG1DDdqAnYibvw3tL+YqZwlV6u2rfZ+vXpij9V8Q87DIYpuhtIg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/P9ClJ/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/P9ClJ/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4396424d173so43860655e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 07:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739805607; x=1740410407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vvwnifg36tubUoFx4SRXf6bdS1pNp6qPvbrOrszLRWg=;
        b=s/P9ClJ/SCQFOOYRLcGnSdI+xVnnL6+oNC37QdqnSjfOsuJzwu2QxQdJrxKW6U0Lnn
         Vifdft24a97Ewso1NQ3hzMjkHFGFMwOc5pq8wAdWbh78BxpNE8aLSyvY9CX3+yvRYA4e
         FuUAfI4cFv8jEnyrxFZGicH5Ofc5si2i0QyWOs7kKbKinU4CJPeBJmSYP5nMaQKN9g9U
         SADV8xuRV5kvq3R8usNTjeEam9MnO80T1JA4NeWuVU2ih7Tqpj14sDS5KNxDVk6hgby/
         eIwdV78KMlKwhTWRiywaYYGzEnn6ghHDV9TjL7hYD+IoVwpVmiLHxAdX2cwuFekVGqVS
         G7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739805607; x=1740410407;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvwnifg36tubUoFx4SRXf6bdS1pNp6qPvbrOrszLRWg=;
        b=TNF2W7y4Da095WYSe/sj43biPaGIGiWJ4qo2l8I3NE044sswcjg51RnKd03MdtaEKr
         OjTSqp3htCrB5KMXDUcBLJcVLxbx1PYhJs/9VzJcEzMpkLYO1sPBTS93br8p08iYMtBB
         ifQJIcVeFgWuwOWjrjVIZS4PQ/5bPkAmJWGB5p5v6UmiwfhqYFKUAZXtDlR1S/oO9McX
         B60NYhy4R0a0qe7YYsKmqeAUNbbU3fmsVDyYPpkjRi6tRqwhaKpq/uwxfBykfu06WGHB
         Sb3Ldt5Q14X34tqbgMxaIlx4YpgRtOHFpMwnEgeCa9gfhLb88s2iSdoR+KG1KMIfE1J3
         yTIg==
X-Forwarded-Encrypted: i=1; AJvYcCWDds55BTlSXIODX3sCpq2dclTQUhXNyIhsQ4u6xXw+rUF4ltbonyaXHlfFOYnZJqsuRJWwjCEquQSyiOgdJg7M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6hH50JDEd0j/TdN4G3/GzokimPj+I+zyWRrSwYfapLiM1oi8F
	9W7GNsVIm2pp9pYjrxRmtrZ5uste9YmXjmzsmPGHETlNfHvPqu26X03pKV9dBWQ=
X-Gm-Gg: ASbGncv6ceiujbOzp8b6YyO5cLpptP29SuiP99U0dn5XFR9/mEgK1DsPQmk34A0HD+9
	bV9NwiXl2kldaDoecfYIjEDX1/qeTMo2SqYLnMpbjjtDRmWUHqQjLnmMQ/ub7l0AxIErcLzMdJd
	V41yykCUZ13XuP6K/XSdxpnhEralBnIrlu/k0MGPv2n3ptv2x73IFA8jXnYDwB6mqhgP3dS4Eia
	m28VVaoiGgBEJ+jyBfYwfrMRluUS7k4L/bfoeH/Ek8FNecgGtB127Yprj58j5/oVQ2ENCcMRl8i
	+QY878+WQLdPICMKs2MIfyf3Ig==
X-Google-Smtp-Source: AGHT+IGK8c3aqu2Od/1nbLDGaZTn/4WelNNKjwdjiSMpmtbC//LMJpRvc0NRmSNiOFEHKD4MVHye/w==
X-Received: by 2002:a05:600c:350b:b0:439:4871:afea with SMTP id 5b1f17b1804b1-4396e733560mr107174395e9.30.1739805607310;
        Mon, 17 Feb 2025 07:20:07 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982a2f92esm37005145e9.17.2025.02.17.07.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 07:20:06 -0800 (PST)
Message-ID: <ad30f769-97ee-48b0-b3e2-3bce93eaf205@linaro.org>
Date: Mon, 17 Feb 2025 15:20:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf cpumap: Reduce cpu size from int to int16_t
To: Ian Rogers <irogers@google.com>
References: <20250210191231.156294-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Tim Chen
 <tim.c.chen@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Meyer <kyle.meyer@hpe.com>,
 Leo Yan <leo.yan@arm.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250210191231.156294-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/02/2025 7:12 pm, Ian Rogers wrote:
> Fewer than 32k logical CPUs are currently supported by perf. A cpumap
> is indexed by an integer (see perf_cpu_map__cpu) yielding a perf_cpu
> that wraps a 4-byte int for the logical CPU - the wrapping is done
> deliberately to avoid confusing a logical CPU with an index into a
> cpumap. Using a 4-byte int within the perf_cpu is larger than required
> so this patch reduces it to the 2-byte int16_t. For a cpumap
> containing 16 entries this will reduce the array size from 64 to 32
> bytes. For very large servers with lots of logical CPUs the size
> savings will be greater.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v3. Add bounds checks as suggested by Leo Yan <leo.yan@arm.com>.
> v2. Rebase and tweak commit message add Reviewed-by: Tim Chen
>      <tim.c.chen@linux.intel.com>.
> ---
>   tools/lib/perf/cpumap.c              |  8 ++--
>   tools/lib/perf/include/perf/cpumap.h |  3 +-
>   tools/perf/util/cpumap.c             | 68 +++++++++++++++++++---------
>   tools/perf/util/env.c                |  2 +-
>   4 files changed, 54 insertions(+), 27 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

