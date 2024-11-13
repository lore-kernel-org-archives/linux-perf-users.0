Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5A41FBC9E
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494530; cv=none; b=OcAc9mtatTrHzYsX6Wx+khaInZUXIPjf52omwbDBWKj5WxhBuOiR4lh/TKRMeBaVk01U9WS4h2/V30u7wT4BD1Za8RQSxth1ILWoVyOW/LXI1eEnI1wjvPevSXiXvfiUtsDIdhGWXDfpXkXjA5OaKkf+8gwD2DnnfhcSN5MMnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494530; c=relaxed/simple;
	bh=AqumPSQGax77GBO9IatO8rErpe6+RT+R0gHdz967x50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftx9sCkgMlwUod6xf6IC2VhaJ37vTcAcuJ8rtgOrF0gmb6f9QGFYjUzSHStfaLdvgIkiH1O5jMUbnxoYnRxMPKnvo0eFeYEupgXj3EUlQXXk6PLeB9yXMvuRUoMS6VgyQ8N3EY3QGnK89CS0I5zTcLqqnpoHIuOS+C6nuFNQlkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yBgvYHlZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBgvYHlZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9ed7d8c86cso1195703766b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 02:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731494527; x=1732099327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpKNnFSJuu8mX4fv2nmuYeZ5VRhQuVqxMggvr0piqwA=;
        b=yBgvYHlZK7BcsecRjQVL4tytSpec52M5qxXtTaU99IMgh8Y9zKgRCoZ1LdT4IpYDUo
         xlLlUqnU+jSxVxprqUEXFcE3mPq3jBKBYX90m8BIVnJL9CrsZR9sxxhjxYrQGbkM4E7q
         3+irDhnmChnQUi85TY9e/hoUTs8SOn0yNOGBuPNSADAKTv255b5y0IznZSphCXNc4oUB
         B8SdMTzwFFTyVRt+yh614rhCVPOzl+akzy6h+FxknM4HbI961zHv+VOYIRs8xV35OlpZ
         PmNqayNaED4J/cl9X4usPflGhrH03yFL6oVZP6wmD0wrWI2wvdpLCr7RIIHF4+zF4I4V
         JnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731494527; x=1732099327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpKNnFSJuu8mX4fv2nmuYeZ5VRhQuVqxMggvr0piqwA=;
        b=d7FR3uW7grdlixc0aMJ98LLrtKBJeceC1WmSVTnS3TyaiMT1dFlh7xoDVAi93wZ3s0
         oQTkZrVM2cl9YY6LI8Duxe4AWP6co6YMD9jUij8z5PNlWY5NlcrVjTcua+fxPs6/XKOE
         hxKtL1YXnmofzDBbjUWANc7w14F1ePolb8Y57mYSfkHOe5Hmu4tKdIPR5jByx6LmP+kn
         /3xLsBULfAgvpZc8eQy7G7Pmaw8DvdqpMM4hplDNDDWha11gYQGS+hby+g63nKGoRE88
         xUW4pNFL4fXjy6NFTGNXIZi30bZE5wg8JyBLbdOoncIm9gqD+dkzzxj5e/u1aHJvSI8c
         U/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCX4xTYL1zGopvjhhGXRWyRoe+NDPQMWEIhcW7q3S7OFrj2JpijlJueMnGF4AM8uHxoUV3qQGfosxLEXqsWGNlKe@vger.kernel.org
X-Gm-Message-State: AOJu0YxMop4548HDhS+Ksp5FLVGPpS4wmb0KwbKEYNOynJTih2+0Ny+E
	zzCFYVkdu4UPqSvOrbCdzGI9ApXp8/FgCie5OlC3hFnckKzQ9DYLwZWEVx6O0BI=
X-Google-Smtp-Source: AGHT+IGkvSzEORJMBip4kLqyw4g2XZQP9hZKEvJR8NJ1wbFa9hcYRPzrgSUKiBVjVht7VAmBjdnAUQ==
X-Received: by 2002:a17:907:5ca:b0:a99:ee1c:f62f with SMTP id a640c23a62f3a-aa1f8075b6amr218093766b.34.1731494525232;
        Wed, 13 Nov 2024 02:42:05 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a452sm845869366b.51.2024.11.13.02.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:42:04 -0800 (PST)
Message-ID: <e81bcabd-11fc-45f7-abfd-05b569b1c18f@linaro.org>
Date: Wed, 13 Nov 2024 10:42:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] [PATCH v4 0/2] perf arm-spe: Add support for SPE
 Data Source packet on AmpereOne
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Graham Woodward <graham.woodward@arm.com>
References: <20241108202946.16835-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241108202946.16835-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/2024 8:29 pm, Ilkka Koskinen wrote:
> v1:
> 	* https://lore.kernel.org/all/20241024233035.7979-1-ilkka@os.amperecomputing.com/
> 
> v2:
> 	* Doesn't use read_cpuid_implementor() anymore as that was broken and
> 	  unnecessary.
> 	* Convert AmpereOne source field to matching common source fields to
> 	  avoid duplicating the code.
> 	* Rebased on top of perf-tools-next/perf-tools-next (ba993e5ada1d)
> 	* https://lore.kernel.org/all/20241031213533.11148-1-ilkka@os.amperecomputing.com/
> 
> v3:
> 	* Changed source mapping to simple switch statement
> 	* Dropped is_xyz() stuff
> 	* Added table to map midr to data source decoding function
> 	* https://lore.kernel.org/all/20241106193740.6159-1-ilkka@os.amperecomputing.com/
> 
> v4:
> 	* Split midr/decoding function table
> 	* Made AmpereOne DS decoding function to ignore unknown sources
> 	* https://lore.kernel.org/all/20241108010911.58412-1-ilkka@os.amperecomputing.com/
> 
> v5:
> 	* Moved data_source_handles[] to fix the build issue
> 
> Ilkka Koskinen (2):
>    perf arm-spe: Prepare for adding data source packet implementations
>      for other cores
>    perf arm-spe: Add support for SPE Data Source packet on AmpereOne
> 
>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 ++
>   tools/perf/util/arm-spe.c                     | 86 ++++++++++++++++---
>   2 files changed, 83 insertions(+), 12 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>


