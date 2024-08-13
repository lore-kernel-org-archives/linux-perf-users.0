Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB619EEA7
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561860; cv=none; b=tIQhv+Uwxy1hqKVouwdS9Ws2YF3Cpbr1nzdnO/vyawDkjKqFSbS64PCbzdFrHYtLLZznQbcvhJMnRCq/wtroS6/0xG2KkMBx+yCC/bonwHjhuo09gisIIi9Ay5hh8iaYacgMfdR0p0pAIkUVxPQayU3GCPaC5keplCJTk8QL+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561860; c=relaxed/simple;
	bh=LYIWBtskN6sXTvpBnGG3C6nVsnJ6dgWuEna51QeBeQ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jJ88dmgNIQ8MAjm6jqX0/Ekm02LXemscLp6lZ04Db5CaceRcRNpetM2lBUscECj6HSTDDfLaDgfviW1c83NyRkoAWmoBaE/iF2DW85X/2u+Jt+STEWuXid6yVZ8wvYdrie3VzeLSM2ycudFzr474Io2kszzNtzt03nwEly+XkDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SxzWBppV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxzWBppV"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36887ca3da2so2774920f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723561856; x=1724166656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uNaRquM+gUEb0pKk86KM3Zb+qh4ZVa6K8vPWsqTERgs=;
        b=SxzWBppVNP7mJOaH64PP55cpZp8KBgFA7GOAVUEKCxgSFsG4qa5LPWuEMynAq3AnHe
         I850ph4Vizos/37qGt9Gt6PCMxPnPQyF+2/xb1qVJsbwLQBmY542DxS9gzBPlH0Pju3h
         dgSO7DT4PJBpTiH4I+5RNL4L+GkA4FE4Hgkug8sVcr27mKFGhIJjWQeOAbNAsA46ur2n
         +o7JyX2KG9nE1e9as/40k7cxtpzkl2Ak1aqMC8G5Y88R/SeyTetq375tee1A/ux7VRSQ
         WLQFdhPK4UyN/AJBtMhleGWoSBAfwCCyAkpGYkd5mvQTvqwwFv4fwcepoAToeU6KaJLv
         ewZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561856; x=1724166656;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNaRquM+gUEb0pKk86KM3Zb+qh4ZVa6K8vPWsqTERgs=;
        b=Fhv1MhXbuZFp4FHfWLn7PXL6MyDRWfN2i1ZgP6cXuRykPqTmSg01YSQEyqcsHJ9rp9
         6XyPaBLVo8ZK8tlidDH57f98vz7HloX7tgaFBVfnkupzX85qKTD6azTWOQrKvzgJNYGg
         5OMANYpychps9OjKcqcA0zAzqguq/Ck1Gm9rcCRle9H6ZtCFpD1iQNXU2UT8NpUIOzWu
         7NTOiv7znh3L6Tz/WZ7J+QSgxmu0+TOwyX8eiUQ9zUOE+My/qc9AJ4x1iW1vGdr0vNqg
         vElRuAwIx5DWoAEfXXyRiNLq1PCqs1PZWlKhwgude2ytLer+ZAk8Tvf+EEAq81A2Psht
         cboQ==
X-Gm-Message-State: AOJu0YwbKL/yccDkfHwzyiKghgBFldgiQBV/dyAd+Sko/E4h4OHFGQho
	q/VaeyTq6Z/9GyX474juYuY596xm105QMVN/qwFL6hiWoFVlQLIYNFzoTFSh+vU=
X-Google-Smtp-Source: AGHT+IFanGBAh+3UifeFJiJZmUQP8fwxUmBb7RFyv+AjfsrU47xau9UjVEIrnOY5ZlY3yXWI/pOLGQ==
X-Received: by 2002:a05:6000:118e:b0:368:4c54:ae27 with SMTP id ffacd0b85a97d-3716cd07857mr2680656f8f.36.1723561856037;
        Tue, 13 Aug 2024 08:10:56 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeefedsm10639103f8f.58.2024.08.13.08.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 08:10:55 -0700 (PDT)
Message-ID: <dac6ad1d-5aca-48b4-9dcb-ff7e54ca43f6@linaro.org>
Date: Tue, 13 Aug 2024 16:10:54 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] perf stat: Make default perf stat command work on Arm
 big.LITTLE
From: James Clark <james.clark@linaro.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>, Ze Gao <zegao2021@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240813132323.98728-1-james.clark@linaro.org>
 <CAP-5=fUVchraZxYg9LY-CtqYZ5DN05-T3vhJmaUG+24Ka6Bsyg@mail.gmail.com>
 <5ac3fc9d-4ed6-46ed-b537-13d27ba46e3b@linaro.org>
Content-Language: en-US
In-Reply-To: <5ac3fc9d-4ed6-46ed-b537-13d27ba46e3b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/08/2024 3:45 pm, James Clark wrote:
> 
> 
> On 13/08/2024 3:35 pm, Ian Rogers wrote:
>> On Tue, Aug 13, 2024 at 6:24 AM James Clark <james.clark@linaro.org> 
>> wrote:
>>>
>>> The important patches are 3 and 5, the rest are tidyups and tests.
>>>
>>> I don't think there is any interaction with the other open issues
>>> about the uncore DSU cycles event or JSON/legacy hw event priorities
>>> because only hw events on core PMUs are used for the default
>>> stat command. And also just sharing the existing x86 code works so
>>> no big changes are required.
>>>
>>> For patch 3 the weak arch specific symbol has to continue to be used
>>> rather than picking the implementation based on
>>> perf_pmus__supports_extended_type() like in patch 5. This is because
>>> that function ends up calling evsel__hw_name() itself which results
>>> in recursion. But at least one weak arch_* construct has been removed,
>>> so it's better than nothing.
>>
>> Let's not do things this way. The use of strings is architecture
>> neutral, means we don't need to create new arch functions on things
>> like RISC-V, it encapsulates the complexity of things like topdown
> 
> If the new arch function is an issue that could be worked around by 
> calling perf_pmus__supports_extended_type() on patch 3 as well? It just 
> needs a small change to not recurse.
> 
>> events, Apple ARM M CPUs not supporting legacy events, etc.
> 
> If Apple M doesn't support the HW events does _any_ default Perf stat 
> command (hybrid or not) work? I'm not really trying to fix that here, 
> just make whatever already works work on big.LITTLE.
> 
>> Duplicating the existing x86 logic, when that was something trying to
>> be removed, is not the way to go. That logic was a holdover from the
>> hybrid tech debt we've been working to remove with a generic approach.
>>
>> Thanks,
>> Ian
>>
> 
> I think all of that may make sense, but in this case I haven't actually 
> duplicated anything, rather shared the existing code to also be used on 
> Arm.
> 
> This means we can have the default perf stat working on Arm from today, 
> and if any other changes get made it will continue to work as I've also 
> added a test for it.
> 

I would also like to note that (not including the new test) this 
patchset _removes_ more code than it adds, so to say it duplicates code 
is a bit unfair.

Of course this touches some similar areas to your other change, but that 
doesn't mean I think we shouldn't continue with that one. I'm still 
happy to review and test or contribute to that one if you like. I think 
it just helped me to do it in this order and get this thing in a working 
state first before the next bigger step.

>>> James Clark (7):
>>>    perf stat: Initialize instead of overwriting clock event
>>>    perf stat: Remove unused default_null_attrs
>>>    perf evsel: Use the same arch_evsel__hw_name() on arm64 as x86
>>>    perf evsel: Remove duplicated __evsel__hw_name() code
>>>    perf evlist: Use hybrid default attrs whenever extended type is
>>>      supported
>>>    perf test: Make stat test work on DT devices
>>>    perf test: Add a test for default perf stat command
>>>
>>>   tools/perf/arch/arm64/util/Build   |  1 +
>>>   tools/perf/arch/arm64/util/evsel.c |  7 ++++
>>>   tools/perf/arch/x86/util/evlist.c  | 65 ------------------------------
>>>   tools/perf/arch/x86/util/evsel.c   | 17 +-------
>>>   tools/perf/builtin-stat.c          | 12 ++----
>>>   tools/perf/tests/shell/stat.sh     | 33 ++++++++++++---
>>>   tools/perf/util/evlist.c           | 65 ++++++++++++++++++++++++++----
>>>   tools/perf/util/evlist.h           |  6 +--
>>>   tools/perf/util/evsel.c            | 19 +++++++++
>>>   tools/perf/util/evsel.h            |  2 +-
>>>   10 files changed, 119 insertions(+), 108 deletions(-)
>>>   create mode 100644 tools/perf/arch/arm64/util/evsel.c
>>>
>>> -- 
>>> 2.34.1
>>>
