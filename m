Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5CEAC7
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Oct 2025 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759490820; cv=none; b=ZPTVLWwM5yxkgMEsExx3tBX2RNNFH0W/jgcQU7zvvdiQgXeIE24VeHzSkncSI9gzABpMvAO3+/vpzQrJ09giHxLTQB8v9Setd89rqqnicDrkcSMiRddqDiHl/d08G1kONdVpGjaGEOi6as89MSnDuRt7cenSvf74gd3wHiWeAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759490820; c=relaxed/simple;
	bh=YtdNjVaGBtjpugUu5JZhhW80yJtKKEGYmhthPhLz4Pk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kwKtca/eds4byIzaVP/tXWFuzpwtZ+KlBnJhH3q43sUnBRezHAhDFBXZKfwGsb1Aypkz/UUGbtnjwcd8TM13xTgPatBv4z9f82KtfVTGBvf2DaeXVGjT3bQ1mG3C8RMoBk2ujjdj6ovP6IGKWcIX3TkYlFYnre54+9BbE5V1/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLX8BlP+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLX8BlP+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so19362615e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Oct 2025 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759490817; x=1760095617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FjjyfVbmRhvSAkr2TJodpaTn31PsZR4ycOzkb5aM6Qs=;
        b=XLX8BlP+W1rEeABWioKiqqUCL0a2PPVzUCqXClwBFhN7rXPi1SJBgApRc1LbcH1wb/
         M26QRsc22zTD0uitH4GUWu9Z7jNgVs5ufOTe2R+RHPSn0EyWbatAsPrY9lBrIphsrXv1
         OtShsRnEPH3ARP5dAk12ZrbLDZ2DmI2XA03gSSqo/ntkznLXFJmfv1jyQGDXaOByiUkW
         xldjE1EF1y/wLo4VwWVtZCO4bSt4CiaVbmr0clWsuwWTZlBrlbTIVBQxIMIyxPa/GnyF
         Xcetn8Oo9OFyfbN3ufgsfyxtGUH7WbkR+QxxU4GT1+lhbGUU6SmRNCEqpGwULaL4BB0h
         wrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759490817; x=1760095617;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjjyfVbmRhvSAkr2TJodpaTn31PsZR4ycOzkb5aM6Qs=;
        b=sg4Y5548ewQSyw4H7VqCQhFQOIMKgaVsHfHcNb6LFETQDbbSXRpbvyTDwtKP5NU/rC
         AnhXzN5Qtn1XHVjCfVa0D5zMIfZoxtCqg9UDUcErMOWquIP1WtjEULICLVzwFfc8KXEt
         3C1CkEzjiAi5KJVtLJOQnYCHz8nAZ87ecc1YVS7V0B3wbegwAsp4UjdYgNvEj/pLo7jf
         A13fkwk9Aw6cKMqaVRgIYqmIKHn7dgw3NDxBN1MzHV1Wm9NeYcnjBzWx6/mVaztCCt0B
         ZrB3iJzuLQWJlqn13/YitbKsNBZZ3tmfojFdYnohmybMA+bnVZb9dHb/KZvzSJ5e/oEf
         tD+g==
X-Forwarded-Encrypted: i=1; AJvYcCWNg150OUD17Z/VDIIHm+77O7VOT45HBN8x172HTBzO2UVj/gP3RFW1vZZLSHoTU/2TEc6fD7S1pDKsZnY5rsoU@vger.kernel.org
X-Gm-Message-State: AOJu0YwkI8SqAT1J8FtEQ5nK+e1VJ4krteoWyFutE1JaIwGVGTIsLhSs
	L73VbqYF6kCuf7tHIRkPVWxX5jw8il2mR5Qgr9kn5ezVDo47aKLyr+6ZVhTg5cxPrnA=
X-Gm-Gg: ASbGnctNALO69hmGKuCwMZaTwp2zBqSAZOd+Ab+LRTxyDwPdA/1Kq3m9ZB+gJJiYZvP
	S0TjAG4j/5ly+pHPM8d+88WfcHqmGlbCRwRAzu4oHp7X8wC1kMHfbSTbsjOiQUWf3LYMZ7nC50t
	y5F850KzbKN220efrHCvq+ev2pd/X8YxDu/V3RJ4dZSP1hw8tZv6qbz0z6Fj7PyP3oAm9RvdLv9
	xqCigeMdoRih3rgmXFuFJupy80oI/OI5eMvCH2v68scu+Y/LzNmZcsvzHBgB7yn6B9NRdFYc682
	FnytPqa1DUnNCJr4f+Lpm8Uz0kduqOb2e+MbsV3yNhctGnBO0V0/6Gi6XfbIp2isg5Ue7bpxbEz
	ys30IDojlCZoGL/x4SJLnN8h4CAykCSln3PmugEQ0k1X/rEiytqxQijSt
X-Google-Smtp-Source: AGHT+IEa6CUW5LAl08YINRqtUMfMTIv6xNaCHjkSZbWtuYs8CeOLeyg9VUpU299wnFEU8PVFTODVOw==
X-Received: by 2002:a05:600c:8b53:b0:46e:4b8b:75f2 with SMTP id 5b1f17b1804b1-46e7110c4d7mr21569915e9.16.1759490816875;
        Fri, 03 Oct 2025 04:26:56 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97fbsm7466058f8f.34.2025.10.03.04.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 04:26:56 -0700 (PDT)
Message-ID: <b11cdd84-47c6-4cc4-b950-514ff6a3a777@linaro.org>
Date: Fri, 3 Oct 2025 12:26:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] Legacy hardware/cache events as json
From: James Clark <james.clark@linaro.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>,
 Leo Yan <leo.yan@arm.com>, Vince Weaver <vincent.weaver@maine.edu>
References: <20250923223312.238185-1-irogers@google.com>
 <ca47d298-331d-420c-8c4f-83cd29bae902@linaro.org>
 <CAP-5=fWUYH2eji2SNp37_2uHu55qEfRxuhhROYsMZeCixjda+g@mail.gmail.com>
 <CAP-5=fWUVycpDss_+MNQ_DM93AYKWED8aYOUBKLziYTOn68QJA@mail.gmail.com>
 <cf050a7f-b341-4e14-bc46-8bd30e366b19@linaro.org>
 <CAP-5=fW_WfAzb=qm+AnA-xSn8MOHjmTMcpEvXB6uVi+0Cr0=fg@mail.gmail.com>
 <CAP-5=fV0Qqi1m72-7us9rw7K3hbh05fAzutVtcazY7iTu3g3+w@mail.gmail.com>
 <CAP-5=fX0bOj2kEJYmRs33RpL0ODaOy2wCvDzwLDmNxurVRpGew@mail.gmail.com>
 <86331395-140b-44ca-8351-8bc5c511e211@linaro.org>
Content-Language: en-US
In-Reply-To: <86331395-140b-44ca-8351-8bc5c511e211@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/10/2025 10:20 am, James Clark wrote:
> 
> 
> On 02/10/2025 9:10 pm, Ian Rogers wrote:
>> On Thu, Oct 2, 2025 at 10:58 AM Ian Rogers <irogers@google.com> wrote:
>>>  From bisecting, this change came from commit 9eac5612da1c ("perf stat:
>>> Don't skip failing group events"):
>>> https://lore.kernel.org/lkml/20250825211204.2784695-3- 
>>> irogers@google.com/
>>> Taking a look.
>>
>> I sent a fix:
>> https://lore.kernel.org/linux-perf-users/20251002200604.1792141-2- 
>> irogers@google.com/
>> that makes it so that only if all events are unsupported that perf
>> stat exits - this is addressing a bunch of latent issues and fixes the
>> perf-tools-next regression. I don't think there is a difference
>> between v3 and v6 wrt this behavior, I think you were probably just
>> cherry-picking the v6 patches onto a newer tree. When those 2 patches
>> land I can rebase this series on them and drop the first patch of this
>> series.
>>
>> Thanks,
>> Ian
> 
> That is true about the cherry picking. I could only apply V3 to perf- 
> tools and V6 to perf-tools-next, that was just a guess without the hash 
> in the cover letter.
> 
> I did test both unpatched perf-tools and perf-tools-next to confirm that 
> the original behavior was the same in those. Once I saw it was the same 
> I assumed the difference was only in the V3 vs V6. But you're right it 
> could be because of the base.
> 
> I'll retest with the fix applied

Yeah the behavior seems good now after testing with that fix applied and 
the first patch of this set dropped.

Will wait for the rebase and then do more testing.


