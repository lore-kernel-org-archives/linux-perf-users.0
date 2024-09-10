Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905B199FB3
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981073; cv=none; b=SbfMotcLRW382cl0UK5W4ajEvVQlvjgCAGj8Ays94ooMTTKvfE9d2oJCFFsFe/KPTi0F4NtaABr27IMYkEVRi4Z3H3MKImHvyjMU0NLojHHnreEXUrkYUPS0shGgcRsznoJjnnWO85oJiaJKvNsQPbUSqQo1PMjZRiFzX2bY5Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981073; c=relaxed/simple;
	bh=prLlPjWTsc2LP0znA1j/xItWCYCvZhEOWpqEYX0advg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9+9cKX9Whffxzs47BWtO4HXnDuY6ZjUzy54O4lNXE7CZfqfPKOKoHgqDDQbwvKuLzp2mScs2Za4fCVkU/UTw4AeKLGN8yRRs6yQJi1oFo6NGLXGJ+tpueWnGJdUE717HWTqCEFt/AYjAy1tH5q4Qp3aTSVBZFV6LfpkJ0+cOEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zdwb2gD5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zdwb2gD5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso8495675e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725981070; x=1726585870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4omZGnwLy9o5pCzuwFX+0s6xgGqjQG3r3xzFhc8Ovk=;
        b=Zdwb2gD5jBXFn6F8icRMKB1T+U19nf3klZbOU/WJk3NQ6fuhM9KdUM+aqoNWzMrtlL
         ssvMddhhHrpnF4gaS2d2VZEE8U085fBs1a0FVQPM6W46JSl5YbFb1AoJ1CUnJjhHSXHZ
         EKy1MduqvWPWHrEWUZemMlttZd8zu8ANWnlPY9kF5XLMw+Wc98zwCVSORWcPieMcz3HT
         zYrIxFS0HfyvjG5XhIF4IbG5HRHHslcPNd/DqjT72NDbDEEl79wIxf38PIjbb6NrQoNa
         H0z4MCOeYY7gCvpFdivgKiFilv/T70X+rlbXrZxxysBhRHPmSRPJPx2UDdMpwxgIrIS5
         cKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981070; x=1726585870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4omZGnwLy9o5pCzuwFX+0s6xgGqjQG3r3xzFhc8Ovk=;
        b=EHLZhVflRtGRKDdWD9k8BYE6WDKchhbhHz258q5Nrof5Af8eeolH/3T8EdgsJk8TIj
         q/Wh/Dyi4i1kW3l7/+mh6sdfMxVOfXTpC5Ua6sKHowntWU92bvvdAPFvDpPR6C8BHLmk
         BZT8za0syQ/z17arbzq14s6z6JKsAl3aCOpmgjPZbUoPzdLyUCHXMoReoxdUFbSvo+ab
         fMckYJUKGuyrKKGtlNAtoPXIEukp+g81laOQ97PzNkyffzWEetKskvSecKWbHwURslu1
         4oUAHqlQ5Mv401EZfw764iIA1HAjZK96lCBkGKJLd5fXoICa8hJ2N1gKwbl1CaOJftbl
         TBOg==
X-Forwarded-Encrypted: i=1; AJvYcCVGof3pGJZP2wrvFFhkbKCVhW8oH71Zs5IzX7Um0gh/+ci25lkqhtnIsQ2uV/JzIhjMnTDzW8cunfqpFmE+8D1a@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLdsxS9Gw53JCxFzFwsUsFSY/vUDL391Ww9wfFAzULUZxpFsx
	Y2ShPqC5WaqjCYavhECZWrYTQ3jfZLOMWVeeJ+ZSDaiF9SDaRk7c0feg6jBenNU=
X-Google-Smtp-Source: AGHT+IH84Qhesqc2MQ8kxebwny3AJtf0ZcLT4gkcsxiOZjP6fqWKqRjUPUNK42wE33dQ9hF54eF0WQ==
X-Received: by 2002:adf:a3d5:0:b0:374:baf1:41cb with SMTP id ffacd0b85a97d-378b07966fdmr11699f8f.4.1725981069896;
        Tue, 10 Sep 2024 08:11:09 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378a72367b6sm3494235f8f.52.2024.09.10.08.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 08:11:09 -0700 (PDT)
Message-ID: <307568b9-9b6b-4eaa-973c-8f88538b8545@linaro.org>
Date: Tue, 10 Sep 2024 16:11:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf build: Autodetect minimum required llvm-dev
 version
To: Quentin Monnet <qmo@kernel.org>, linux-perf-users@vger.kernel.org,
 sesse@google.com, acme@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Changbin Du <changbin.du@huawei.com>, Guilherme Amadio <amadio@gentoo.org>,
 Leo Yan <leo.yan@arm.com>, Manu Bretelle <chantr4@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
References: <20240910140405.568791-1-james.clark@linaro.org>
 <b2e813c4-be89-457d-8c38-38849177ec93@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <b2e813c4-be89-457d-8c38-38849177ec93@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/10/24 15:27, Quentin Monnet wrote:
> 2024-09-10 15:04 UTC+0100 ~ James Clark <james.clark@linaro.org>
>> The new LLVM addr2line feature requires a minimum version of 13 to
>> compile. Add a feature check for the version so that NO_LLVM=1 doesn't
>> need to be explicitly added. Leave the existing llvm feature check
>> intact because it's used by tools other than Perf.
>>
>> This fixes the following compilation error when the llvm-dev version
>> doesn't match:
>>
>>    util/llvm-c-helpers.cpp: In function 'char* 
>> llvm_name_for_code(dso*, const char*, u64)':
>>    util/llvm-c-helpers.cpp:178:21: error: 
>> 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct 
>> llvm::DILineInfo'} has no member named 'StartAddress'
>>      178 |   addr, res_or_err->StartAddress ? 
>> *res_or_err->StartAddress : 0);
>>
>> Fixes: c3f8644c21df ("perf report: Support LLVM for addr2line()")
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/build/Makefile.feature           |  2 +-
>>   tools/build/feature/Makefile           |  9 +++++++++
>>   tools/build/feature/test-llvm-perf.cpp | 14 ++++++++++++++
>>   tools/perf/Makefile.config             |  6 +++---
>>   4 files changed, 27 insertions(+), 4 deletions(-)
>>   create mode 100644 tools/build/feature/test-llvm-perf.cpp
>>
>> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
>> index 0717e96d6a0e..427a9389e26c 100644
>> --- a/tools/build/Makefile.feature
>> +++ b/tools/build/Makefile.feature
>> @@ -136,7 +136,7 @@ FEATURE_DISPLAY ?=              \
>>            libunwind              \
>>            libdw-dwarf-unwind     \
>>            libcapstone            \
>> -         llvm                   \
>> +         llvm-perf              \
> 
> Hi! Just a quick question, why remove "llvm" from the list, here?
> 
> Quentin

Just because with respect to the linked fixes: commit, it wasn't 
actually there before. It was added just for addr2line so it should 
probably be llvm-perf rather than the generic one.

But yes we can add llvm output if it's useful, but could probably be a 
separate commit.
