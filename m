Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB6253F31
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383183; cv=none; b=nsByHyCRMeh0biZUFmRFq+UAEtdXCIffxQOaV0FzUxGWrFGbvzr+XYOj4dG+SRbMneEKTYaypgLK8RkpVT9tMI0rh+PNfieZSlIrT5AZOl+Rlyum/lxTbfY8XiMtXlcNWYasi6GAsE5vnlNverilrFP2sJLtcyACDPP68xDWKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383183; c=relaxed/simple;
	bh=kRYvrjq7DytW/WOiIIlhrJ0KgxILkT5Jk9Kx+3CE9NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RL2cEehNV3DOZ8dgso650rJ0uyN1A6FXx9oycKhDYV5LN1uxDfCnCrjFclmdBKn5xaQwYkg5UkYmC92wDTOfo7yIo6KYurqGMtB/scfPEhft8XGt7NR8L93dIl0Tt/Q7CIvHZIEbeF7wQM5t7yOX8IcwT2nx8+3K/VR2bS84oBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tWnRIgl9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWnRIgl9"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39143200ddaso4241752f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742383180; x=1742987980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6XscEC5H8Sc/fAaekZZ9BeaM5hq/2aJGQbefQgjm1A=;
        b=tWnRIgl9DG591aKNLNdOKs5oZk5YRVV1Xkq3OHqzSWD2Zke6Bqw6KMXA8awQj17AM2
         sw9b+faAvlusblc7VcAAltf61TROE3PqxESIKWhShb9ZzaLvsXIaZ4k9HXx7wnGVWkKe
         PV4KMbMa8TIf/I745HToQFekUTY3wc6PhqCv4DROXxxoldTNabVPHrh6K/drvC1A98Wf
         oYT+hxqaWnX1JDKQhVK9oRvcKI3Ta5c6rhx8NwAbAYb8tbLvMvR3OpbopcWCMvE7cJKU
         0IYF/mfoRYnhPse1i9T0rnlYM+VNTJ5Gm5DVXZD3InADhDNwSdZOQ8xkhLASIn0X6Unl
         5+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383180; x=1742987980;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6XscEC5H8Sc/fAaekZZ9BeaM5hq/2aJGQbefQgjm1A=;
        b=iHhVNoVI9ezWF08cEUpDXkriwlCsnk67KGdYAquff5AlSJPatBFgOieKg8abw8uOwO
         ZXa4tc/IYyA+heAxY8aDHu+gEQFqmoNCnKg1iIeVp57zLDYh/XzkgyoPuzQ3kBcJiSGn
         kB/zbgJvjkvpI3w5E94AtZf710CbO4L+X8zjfCVC4BKv14tdwbhUnUSyA9Qq3CzKHbVg
         JUyhi3CUvmfrvxV2xkMz0K5CKdul9srcu8bn/S6TDGD27t+0/ZLny0JZXLTDD7kg28Yp
         xpiNaAvl6JgVsqHIYxdjZ+mMTD6DJppFepYcK3REfbUkP7XmPKKAPvX87ZNczUnJ1kdV
         Wuzw==
X-Forwarded-Encrypted: i=1; AJvYcCWutrCTW9FjtNQ/zab8mQVdLQuYfvxlUw+RDBRySfdi9+th973kRfDk9AUEirtyOsJ6690vhpjt8B5L8UatxRRe@vger.kernel.org
X-Gm-Message-State: AOJu0YypFdK+DErMu/C9t8apE5Q/rCM9jJee++vp5Qh/IzYEaT1x65f8
	UT8GJ/B7imBTz1E/WC0l5o6wn3cXE3TPETqBX22U5FWG5oUZ2cCvkaNKkeBgrRs=
X-Gm-Gg: ASbGncvjPNhXI7z6zCsiUjirvh3BDryycxV/pIcV32b3yrFG4V//oa2z6jOVeX3ZZdt
	RHsfjVWCALwOV91XafjyRlWLRx8QVQ3vnj8d4J3ZUk/Dv/A1BqU309UNSQWJJytPRPHhF77IhNE
	Oad6i5gyz2/ctZ6eN5xRmkxCT85FCYUECW2X/y0AsBKyjRHxa0LcA9shzB4Lb5L7dsdgeMCNnsE
	Eb+USwjChawpUteUbGnxQt5Fxo6cveqSRKEjq3YJnB16NcDIWCDqzTPdknYsaIHQV8ayI2XANav
	GSMeE9SDDgsKrHdS39dxEo0Uguq8MQk/f3R5c2cykj2jMj0HgHs/cQ==
X-Google-Smtp-Source: AGHT+IEmvRWyNcLC8Ne4gaIzJhWSj0yaZy9nEAmonrYwH0HXdmLqsnjLA6NpepM/AOZ41I/Acw0rNg==
X-Received: by 2002:a05:6000:1563:b0:390:e1c5:fe2 with SMTP id ffacd0b85a97d-39973b028b8mr2582840f8f.38.1742383180328;
        Wed, 19 Mar 2025 04:19:40 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b37sm20954170f8f.37.2025.03.19.04.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 04:19:39 -0700 (PDT)
Message-ID: <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>
Date: Wed, 19 Mar 2025 11:19:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Restore {0} initializer since GCC-15
To: Leo Yan <leo.yan@arm.com>
References: <20250319110454.3230687-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250319110454.3230687-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/03/2025 11:04 am, Leo Yan wrote:
> GCC-15 release claims [1]:
> 
>   {0} initializer in C or C++ for unions no longer guarantees clearing
>   of the whole union (except for static storage duration initialization),
>   it just initializes the first union member to zero. If initialization
>   of the whole union including padding bits is desirable, use {} (valid
>   in C23 or C++) or use -fzero-init-padding-bits=unions option to
>   restore old GCC behavior.
> 
> This new behaviour might cause stale and unexpected data we defined in
> Perf.  Add the -fzero-init-padding-bits=unions option for entirely
> zeroing union structures.
> 

Do we need this? I don't see any unions initialized in that way. In fact 
there is only one struct initialized with {0}, the other handful are 
char*s but I don't think either are affected.

Adding options that allow people to add more non standard code doesn't 
feel very portable or in the spirit of doing it the right way. Maybe 
there's an argument that it guards against future mistakes, but it's not 
mentioned in the commit message.

