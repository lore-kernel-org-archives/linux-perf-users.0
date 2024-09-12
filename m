Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503DA1AD24B
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154524; cv=none; b=YYXrdDHbPF/yfOm5Z5cTiELqBKTaZHQomFGcEaRAqL7ffBcjXCCTRv5IbguW2SiHn3jhMN0YilXxaJ0SjOCOt4eDTy3q4CtezYwTCK8KDFCn2wMazP6znm5UwrZgErZri98ZX4mPIGlQtTuumOceGuM0jbD1amllA04vWmfp6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154524; c=relaxed/simple;
	bh=iQ1oKsBPPe/zMQcslRbghBsY7GVvs4EzjaXss889pls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m38jfPhpaYKvlAeIbFtvMefckvgIDtLglGUspkVLq7ZVrkfmvME2AhltJD3Dx3k0V/WJ4fdLa7710rEAfppsxpNUviE51QG3GAkkbNziFP32bjbyx7loY1hG4QsdRTqGz5qOoE81N5fzUzrc6PtnBRgwYepNCyKBC0kUgcTmIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tU9D9vtM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tU9D9vtM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cc8782869so10347915e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726154521; x=1726759321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yBlVHQt+vnOgxumPxuDbxHiUodHyZmJ8GTxwWDdfrY=;
        b=tU9D9vtMz60so4ZyI/ZA7FdLTLgAk0Rw0g76zZ7t/5cSwjXQHBcFpH8V1fYzjXznhd
         dp+TZsjS6TRXxtyA5vmkxF/HdHDUmsxtFQ0XeKDuf83qim2ZMJrJo1HpgzEUHoVUSa2u
         ygjw7T6JXlRFe/WvBZUmHu+iwvEa/ih6R2amQp6r0MX9aamEBHgxPOKNdnnk6KHqyLJc
         Gc9v/Vcmq0emsWzOCHlI9hyDcA/WBw2ROvVnKFJ0Bu9k43Kbrs6lj5N6ybjJo4015ZEH
         xpoJaN1s3JkDeGtGRcMU/PkIxHcjLH5JccW5u+f7DfiQQntUpALO1FzM7vUfS+31SPyp
         UsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154521; x=1726759321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yBlVHQt+vnOgxumPxuDbxHiUodHyZmJ8GTxwWDdfrY=;
        b=Cpq2JpRe40rH1ZM7QCEQ5FizOvXkALZSxsK4JV9isJ6dUgEeW0ZOZ8KodNEJvDzej1
         S0nc4wqUedWjoicfL9X50NloQUF2KSC6GxWv6lLeMvKDnin7RhAIv4Pyt21FcIPXNoMn
         lhW+iB3tzI6NZ6G/z4hX0HDmkeBwXUjDzr7ZAS8FKtd5nQPoxU4XLAfAWLSL9Ph/Cfd5
         UxN8BRBzOhgaOSlJ/MKWahDcQQ7nUYfdX+Zt9in+kXDEA6/GSSH+W717h4lpifAd3L/g
         PyU3YdHk9OSmQqOIf0yzlhSyfWjmGIBBqG1FgLZ438Z+htFm1i4BRFt6t8s/ZK+0CMAG
         tJww==
X-Forwarded-Encrypted: i=1; AJvYcCX+lyo8yNrvsat8/92cdxk5e/XeKQODOGsjIb3vx2U6gqmOJcTGmVE/Upai8HUPdP5Cx2N2zV8/Gl2OOVrc5lg8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnpkv84mXfn4DJ64ih+C4eN8SoSX5/LqZFqbccX0IlFCUbGLdG
	Rj7ZNdiphP3ShSXRn9baQHCENuKV6/GcAkZoMR6erQsZt5hwNcAZIXFP3yTQVhY=
X-Google-Smtp-Source: AGHT+IHlcoT3TEFF8U77+rI/EDslAOsz4FVdUzOrLilBFniwMVVrKySqO4ID2KPEa+yO5Y3+4W6cLg==
X-Received: by 2002:a05:600c:1914:b0:42c:b95c:65ba with SMTP id 5b1f17b1804b1-42cdb511f40mr26605925e9.6.1726154520433;
        Thu, 12 Sep 2024 08:22:00 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8a98sm14701188f8f.117.2024.09.12.08.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:21:59 -0700 (PDT)
Message-ID: <c124ad7c-31be-42cb-9eeb-507d99a97891@linaro.org>
Date: Thu, 12 Sep 2024 16:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] perf cs-etm: Don't flush when packet_queue fills up
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
References: <20240905105043.160225-1-james.clark@linaro.org>
 <20240905105043.160225-2-james.clark@linaro.org>
 <5a0d9510-eccb-4074-964e-ae068b4ee31e@arm.com>
 <1e55f148-37d8-4fbe-b863-d604fdfaafaf@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <1e55f148-37d8-4fbe-b863-d604fdfaafaf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 09:14, Leo Yan wrote:
> 
> 
> On 9/10/2024 9:28 PM, Leo Yan wrote:
>> On 9/5/2024 11:50 AM, James Clark wrote:
>>
>> [...]
>>
>>> cs_etm__flush(), like cs_etm__sample() is an operation that generates a
>>> sample and then swaps the current with the previous packet. Calling
>>> flush after processing the queues results in two swaps which corrupts
>>> the next sample. Therefore it wasn't appropriate to call flush here so
>>> remove it.
>>
>> In the cs_etm__sample(), if the period is not overflow, it is not necessarily
>> to generate instruction samples and copy back stack entries. This is why we
>> want to call cs_etm__flush() to make sure the last packet can be recorded
>> properly for instruction sample with back stacks.
>>
>> We also need to take account into the case for the end of the session - in
>> this case we need to generate samples for the last packet for complete info.
>>
>> I am wandering should we remove the cs_etm__packet_swap() from cs_etm__sample()?
> 
> Sorry for typo. I meant to remove the cs_etm__packet_swap() from cs_etm__flush().
> 
> Thanks,
> Leo

Turns out there was already cs_etm__end_block() for the end of the 
session, but it was only called for the timeless modes. I added it for 
timestamped mode too in V2.

I also kept the existing flush() function for discontinuities. I changed 
my mind that the differences to cs_etm__sample() weren't relevant.

So I think we still need to keep the swap in flush() because otherwise 
the next sample won't start from the right place.
