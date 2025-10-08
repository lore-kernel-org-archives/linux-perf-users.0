Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBF2E22B4
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912381; cv=none; b=hPD+OlZqRQmEwN1+YLbUW9+44Ri1lOhh3ytLic0UfJtIZAHyTQyGHWGNG3yvghjZwGGRjfkpg9fMQGkP36nSQcqdDa1g4wXnjPeILdeO8AKxw+Fa/+6TtReQUC9Z9TOkOxQUon5yaNZcuCRxS1cNlAPyVnEb+AaGLBD16ZLqxmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912381; c=relaxed/simple;
	bh=Z2taCmRyKyKuwCLIbMubQGGVNYoAoYpSPH6DDuGrcwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsBA7PrQQ/IR3upcQJo/sHjN/cLyoPmWQlhmW0GqYJzaHKc0ITitNstuMGaA+p530xfIIMqMAv6sDyn6hAnL2S+jrQnCV0Ff2pij1Wz0fuOATWDUNeQfP702qPyzrnszitFZSm6jhChnlEVcBheTXAMTwVYWuwj1hS/I4a+rnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qsAv8UL9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsAv8UL9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso85837305e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759912378; x=1760517178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbE88fhQQ47hzLLVaZ4JTryHxWE6dfkyhBkPRbIsZhw=;
        b=qsAv8UL93TUlQd6J40A35OOI2iitBe6F4j16mRAK9AvYJT1epxdizVnK2TL/pdOJvk
         YFSEmXA/e+UUW9Gjh9b0fkejvgnK5zmj4jJOon72gQzqv0f15MsJ0bZOohlWQVpA6vN1
         uif8Az8jUIKNU5vnP4kDs2zTbaOARynfOIORNEONmeNPA1KOBnPaVnAmS3xsdAI5+XYk
         HdAO6X1R8RhpyvoBkCeWiAUFDc9kF2sejL5PeCX6SRsXeM6PMO4Go3JrwQ2ILOVn/w70
         pu5sOkMOH5AssAMNYrOBSK+JaVGkUHtV47FXPlltsjdH/EPAjzPiJkU4XqLNIcOadnZ6
         mxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759912378; x=1760517178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbE88fhQQ47hzLLVaZ4JTryHxWE6dfkyhBkPRbIsZhw=;
        b=ZQlyZW8vjwZTSgmH/XZUFGHi6IN1Sev9x965Bhzea5qIdyEJCth5L/jwXogYPgTB23
         9aRvdlTauPq6irvETO3sUH8wlfUJBERiEYE1U9xVRfEBUM6ouaVP9bJy8MvU4pVqJH0R
         ynQKvipGaoHxg17Hs1P+bpBGYISJQEYeYuL2HNlj/js4C490MI/mZesBa857Hr3f70J2
         bg3Xo9YN6njUgCnMjBJHIGC1BTxt4nfjpnAkMKGvap919HtHlzatoBcWsDNZ4qHYxVkl
         Pds4p2GAn+Hp5Td1IxgLuU8MAELXVEGXg3cnf5LYwL9OY9XybsLWu4qQvLzxHpsBea7b
         wVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMUF9o1TsLea2mheXSaGC0owqByLOkjpcqBNnoic1XqL5fhRpKD7UuddHaZrNi/7q63l6ApXNkocVIGxpXZMQF@vger.kernel.org
X-Gm-Message-State: AOJu0YyIul4BkL+pNE8iweTW1b2VXzOnTdIiu0XIsZc2M2TQA7sOneMC
	qn5VjAlRrI/NtyCu5783ilfvqSTySwGlA35BXRBHScyhYgC+2GP1LweRu//xWlpG9FI=
X-Gm-Gg: ASbGncti4zMbypoQgMzdQ+oBYDWgH83ShFCTDR3BDQsbK99hliDj0NC6xxivAB/Ofv8
	cdy7apiGPFpVSrGHZx9rAg2re2lAk+eMFZ9+fZGlUGoLAWBrH1naOp1duRUszeSRfOwaU05wyCS
	WzoG6HkIkx/rLlrDesBRET7Shl6G7UCA3CWgp5fES/PaHrCOrx2a9GaqvQ0zgKL3vs5Ytu/g6ny
	7lxSjM9Bvkz0/EgzuwVaBSh0jDNQMdRyst3X2Uf+RsKOVXMvn5KO/W0iyyo0r8yiLwOENGECdyt
	IP/eDvrauHUYHKsHZ82+byTx3RPJQB4dWFLkl5asIa9KvGccJuVWM+BI3OszQiPCojaRpfQ5ilc
	wg/3GLQ3uWHnWilEKl1Fgv73mctf6giUQf7PZE3/R+Hzul6O11S2MzD5c
X-Google-Smtp-Source: AGHT+IFOfYvi//mBcrtuwCP1h+fwSvasg3Ln9TK6x1Crl1mgHv6s5OAEmY4Omtge6WqWwjoAe/mxow==
X-Received: by 2002:a05:6000:2c0b:b0:3ff:17ac:a347 with SMTP id ffacd0b85a97d-4266e7e11c4mr1610961f8f.27.1759912378121;
        Wed, 08 Oct 2025 01:32:58 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6e1bsm29193627f8f.8.2025.10.08.01.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:32:57 -0700 (PDT)
Message-ID: <a7698f4f-6541-4d3c-afea-d30baa4776f5@linaro.org>
Date: Wed, 8 Oct 2025 09:32:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
 <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org> <aOVxlEXDMKJyIhME@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aOVxlEXDMKJyIhME@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/10/2025 9:01 pm, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 07, 2025 at 10:10:12AM +0100, James Clark wrote:
>> On 06/10/2025 4:21 pm, Ian Rogers wrote:
>>> On Mon, Oct 6, 2025 at 6:11 AM James Clark <james.clark@linaro.org> wrote:
>>>> +       data = zalloc(sizeof(*data));
>>>> +       if (!data)
>>>> +               return true;
> 
>>>> +       data->addr = addr;
>>>> +       strlcpy(data->path, path, sizeof(data->path));
>   
>>> nit: perhaps strdup rather than having 4kb per tested_section.
> 
>> Oh yeah that would have been better, not sure why I didn't do it that way.
>> Although the max sections I saw was around 50, and it's usually a lot less
>> so it's probably not worth the churn to change it now that Arnaldo's applied
>> it?
> 
> I see you submitted a patch for using strdup() and then there is a need
> for checking the strdup(), etc.
> 
> Since at this point this is an improvement on a test and all is sitting
> in linux-next and the window is closing for v6.18, lets leave this for
> the next window, ok?
> 

Makes sense.

> These would be good things for some tool to catch, before it gets sent,
> but that is another rabbit hole :-)
> 
> Thanks,
> 
> - Arnaldo

Does Smatch work on Perf? I imagine it would catch this if it does. Or 
just plain old cppcheck. I'll take a look.

James

