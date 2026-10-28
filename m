Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180070;
	b=ui7wU3xlv8cIC2snlXFApgYscWWj8cGA6mUoUJabqgU8uGIFFK9P/wm0laNkJJSLzcQi
	 jVMLKWTNdrdmT3/zRuX6Gqr9kfsV+STVCWoRd4kvgyQkBP3K13e2ObWxd1gbfbj9p8RhD
	 1hpfxV0svoATZHgWJjNedp6nqMvGPMLeVpJ0X65/CRvDMHLXVYQ9+mWlxRJO+wx0ZHslF
	 GUh3y3ZaBaqB9kdBGLi0srywp1RdDLE6v9aRqJgScsKeTHd2VFnqrQO7FCu00/Qe1MqjI
	 3apHyGcczSEUs2YA2S7z0j6WxowBfOoz5hW1S6Lcg8DyhEJPSgdxrdCYcmqcsbuSDMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=npanRg0QZLRyOg4NvL8u4eE0WVQ+s/uGa11R06EyJJw=;
	b=VE2ZAi2xHKcTn3BV9hXHgfWuY4IIe8p/w/VOegwRAsRtbNKco5Bt+72npxEiE4dk60de
	 LcERA75vejmmE6y6VD322e4UgKHwm686fgn0F7qWnVk0fATxejhXhUXWwWIZ8eStO1uNM
	 5RQZNe6xTe7s3E9M4QhXkpv/QceIbhHFpFb93jCiB38dMWd8A8xk/SsEUkIM4KFFXAWHv
	 4CacW0EbmNeBSAxjYK3F3li5Zt4060LzY4uzJWpAQZRYz1GyO9uWbO4sFV4kdlOai3vWw
	 he6p01p6BfQxT4x+8QJaaFf5TiGJqkikB8+RxKMeuMAFrW1a+KlRP4ZLaCvnJBhrxBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eWC3HaLC;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D1A606A32C
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 09:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66D1A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eWC3HaLC
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so473593f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793180069; x=1793784869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=npanRg0QZLRyOg4NvL8u4eE0WVQ+s/uGa11R06EyJJw=;
        b=eWC3HaLCAgyUvdATmG9+qWEOV/AXT9tAWV8J2eIpXYG3GID6i/nmQ6/cw8IcIDfDik
         7aNG83/Zm+FokfAbKjLzNSc1FXI8ueGIuCfQ9NXkBlMcIFRmn9brL75o56O64Y4KH6m+
         1+WTtZMAp5dFhIDNiu/ZHmOL6YDDPC/o2y1jFoXGkfbhZYUrL9I13EGpYsjg2GnHIdYI
         V/HYIszWagB/jmpYijacA3Bz5zcoMlWVuLZ8rxahee23weSJeHm4Jn3ItsYWQlMFBu72
         Ym1ZzfssseeDMHeHSMLGKk0u+P14I2xoe9/8EzNTyHS0o9a4pVwjakIRuWSkzxO54Mid
         iUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180069; x=1793784869;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=npanRg0QZLRyOg4NvL8u4eE0WVQ+s/uGa11R06EyJJw=;
        b=fChZ7kUnUgr73WFEzAgR+g3kH372l7/ISHOV9mEcCg5BLoepBsU3T/qKWd5lU2LDMm
         K49uSPkOWcXdpyOFkFF1aALD3WYHvYSGpumzQLQOE+6nlak+jK3WBJrUunCvM1cGZqXP
         TMOXucLTB8b4jMAQIDm6TO5TBr2AMk9yUL/DxbqTYsFt4GGDTt+EcaAA7CP7bpsAoHT7
         R5KyvVWeiDAjCnAzrgktZycQWA3GqogBrBArLWzd2h4eoWoUC0Yl8ewArGpQgQcuC/TM
         2bMnh6togdbtZ699o0Do/uhnwb6Mb/fnaZKklIQD1nSv21i0eQ/17gqb0V7u6RntKAaE
         g3IA==
X-Forwarded-Encrypted: i=1; AKwUvBw84e2l8L1yfCpLPUxB0y52ORoCJkTHGRIuEyqEVWNYS4sSFmQDm409pQbRqFoEPbviQAjUPTKo24L2JbPRjMQB@vger.kernel.org
X-Gm-Message-State: AFq9FYLQZL8K4B7+TflFYib1faqxkvhxvMmje/zVpOAB8eX/pqnsphxQ
	0eE5l6gfbfApO8e1OAtH2Ig1inQklb2gxLVw3HkzylIAwIHEsnei7ZN76oSRbRAScmM=
X-Gm-Gg: AYBFou1hP+VVU4cv/0nSgGV7706zFYos+gMKPoD60En+L27HUHCN76IVRiSE7A6PxXX
	GYE5lOUvSWQ0kvZX9K6WOonvGw3Sg6ezdYBN9O0KY6o8OXXFZulRY7v0Zokg0q+QgjMbucxpjt7
	RgKcJWbuUBXZqz7IRgk6Qxgb7wtFn9eJEyqp6g32j5zBp6RSVXuP/to3V5UK1Tg5XQOCvEk9LWi
	t6/nJ7Yi+QeYDjP8//2ivWI5/oLbb5sxjqeyCDphBaXt4Sy7e8JlD+9+Y6r5W0AEHG81K7wXwB5
	hKv0G6qJJqxQwakYmEuTvP9nn8tBHoLEQPPqyzZrh+5/m9iov9HKmJ+lYlvdDfa3X5rXkrWUjm4
	lgFlSdPaboqy9xlLPDfVogYJLgBVlIAExrzKR0shbHvFhJ3LlyL2bh0EiDkmZAxuvTb48HlwPzJ
	GtKOT1zV+flUsd0BirsKqhgrl67ck1nJP0J4o9u4TbbRL3CBaBUokVWiWbIjnfv3v81hbHGR8pK
	18CF+XzTLud+OggK3jFJiJXtvNW1HVWqOOK5RKDEt6L+7lePQT7xZCXf97XRcCINgeuuxtVI9Et
	IzNzly8mosQ4jlmZrqrEXDOVqJMm1/fDUQ==
X-Received: by 2002:a05:6000:4919:b0:48e:127a:c914 with SMTP id ffacd0b85a97d-48e55a36c3fmr11539376f8f.5.1793180068877;
        Wed, 28 Oct 2026 02:34:28 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecde7c3sm29091965f8f.51.2026.10.28.02.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 02:34:28 -0700 (PDT)
Message-ID: <418cf6b3-a56d-45e2-b2f6-0c8496e93ea9@linaro.org>
Date: Wed, 28 Oct 2026 09:34:27 +0000
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
Subject: Re: [PATCH v1 2/4] perf off-cpu: Write the sample ID for
 PERF_SAMPLE_ID
To: Ian Rogers <irogers@google.com>
References: <20261027170415.2815859-1-irogers@google.com>
 <20261027170415.2815859-2-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ankur Arora <ankur.a.arora@oracle.com>, Howard Chu <howardchu95@gmail.com>,
 Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261027170415.2815859-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/10/2026 17:04, Ian Rogers wrote:
> OFFCPU_SAMPLE_TYPES allows PERF_SAMPLE_ID, and the sample ID is
> computed, but off_cpu_write() only wrote it for PERF_SAMPLE_IDENTIFIER.
> When PERF_SAMPLE_ID was set the synthesized samples were one u64 short,
> so the remaining fields were misparsed. Write the ID after the time as
> the sample format requires.
> 
> Fixes: edc41a1099c2 ("perf record: Enable off-cpu analysis with BPF")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/bpf_off_cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index ff8935688b43..16948761cc45 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -373,6 +373,8 @@ int off_cpu_write(struct perf_session *session)
>   			data.array[n++] = 0;
>   		if (sample_type & PERF_SAMPLE_TIME)
>   			data.array[n++] = tstamp;
> +		if (sample_type & PERF_SAMPLE_ID)
> +			data.array[n++] = sid;
>   		if (sample_type & PERF_SAMPLE_CPU)
>   			data.array[n++] = 0;
>   		if (sample_type & PERF_SAMPLE_PERIOD)

Reviewed-by: James Clark <james.clark@linaro.org>

