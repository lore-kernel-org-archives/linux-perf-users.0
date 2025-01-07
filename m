Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5E19067C
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269604; cv=none; b=jtFxN5I6FgBtIr6EUteXfOqluXcgXy3Y+Pbl7+BbSwuPvqizglI/xtP0WuweMbCs1pQrvudjJSpydL8yQ9yQDqr3ywz3O69tO9rLq1qREnKH6doFZXFD3Dlhk6eiuzXf/fbJsNwg+nolpYV9hbj1SugABDuOdtyEvfsqLlLK8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269604; c=relaxed/simple;
	bh=cG85mQSn2tvsOgfgx58hw2GZFPT2TC0S/Gf68kOxGc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJeDPS8c1Hs/hkjjX1GNikEImFnlXQglK9kLXZxV4++g0+KOQ5lG4F7YMtIpvbwQGO7/9oTVBtUvfSUCc4f9yx2sCHv+LyhAdzmAS0A5m4b9XIWWQv6lmd1LsEm23G36hCjvhXhYW7nAZOsbm+2Tpks+X+iiX5LstYVkeyKdgYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJx2u2kJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJx2u2kJ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso164611765e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736269599; x=1736874399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FebZ9P6+12Y1pdGvG8YjCfJnmD9P3Md0S7Wi20YEeow=;
        b=KJx2u2kJaJeB4kY2t5E7qCAR9h436CtOUGzxBZe9KuU1xnjzCGaovtJ63rO1b99fXX
         Om08ZU0T/Z3vEhtLvMlHrx7rMM3BERa8wC4VO02/khg1Hu4S0fX7OtUYBH6rUymYl6NA
         R+i0GHDwRiVStJWWcTiThVQ7nZekWgXq0X6EnQqAFzeTywDh7T124EdT0u3f0DXCraUL
         lOZkHT66uhpRxnAvqxbS1zBraXaA/IPPhhdaUt/LTDuWxtfg8OcN3XqkTiYfryhAUPK/
         dUk9E1fw10e+MIvLIlNPay1kvyHjHFiPpAX89iP5nOvA7aecEHaSURBciz06i2I/YmfR
         NaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269599; x=1736874399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FebZ9P6+12Y1pdGvG8YjCfJnmD9P3Md0S7Wi20YEeow=;
        b=MfZgboyCoTf8vOp9JRmEWJK78uID1c14zvqCjHHZnLtQNNRQE8XtxFgbjQSk7G/0wE
         k9li19IhqUDRxPgjkiVCGNFv7TvwoFzwJFYdPrFgSEhd6bcc8RcS+44/5NPw2nK2fO2i
         6j2mJIcjdgLh9qbTTZbAfnNjUDOMd8Qb0d7gejTFRFVbKeVnG8Kl07fznnThwc5wjW/R
         3wm8KMKIIMTJAWrQhVzVBcRcJTkW0pH3qKhJoG7xqGlyi/qP6x+YNfSoOY7hxLzZOMZY
         sge3zgv6x1WPSIUeuFumCbtAisqvhTr3j4yArxyleKEW+y8a+CS+0EPZMK0gr+Ml5+JK
         MtDg==
X-Forwarded-Encrypted: i=1; AJvYcCWKODW6jqFzgwWu98eIsp5ynzQrgVydq731dETmE64naZLonSaChhATwpwqggzdjf7YcV80QnNTMyRjdGE7imeZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxkV0ESeE5xEdKu3/5P6GJrk4pmRMlbN/wrkaPZvn1nTfs0AOeL
	OhQsI+Qu/MTyFebs9ZjR2xAX+5UMW18zMzXV7qQBNd/IAq1tq541mYmg4algBU4=
X-Gm-Gg: ASbGncvhSJTkGk5DqybHNsVySIasGg+gVDyt2928C77Swe5EsjjcnkGyFS9UDfYIF4I
	GK1Am1Qsf3umBI8j1W1iSDzz/A4B+X9BWqTa+o0IAKDKpxC7nljHN5BsuDjcx9vw4u93sD8kOP0
	rKYdp8YC7+BZLHYofCGA05vCYI+M+vK2h2N+xmWdR/vJPXZR8CmZM+q12eoBFsDER1Vzz6krbuX
	p0lXMgKNk4SrLY26YhtmNp+YbkMWM7+DbFll+wmkt1w/OPgrW/gWC+q/prKo1JcEg8=
X-Google-Smtp-Source: AGHT+IEKnvyCjDyaByMDpYqtrrjEhFnOjlRLb+BDkfL+K8KFlXEghYmBgWXKY8D8DWnwFOa59sp2rg==
X-Received: by 2002:a05:600c:548e:b0:434:f753:600f with SMTP id 5b1f17b1804b1-436686473c2mr537463105e9.19.1736269599620;
        Tue, 07 Jan 2025 09:06:39 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4b0sm604284745e9.35.2025.01.07.09.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 09:06:39 -0800 (PST)
Message-ID: <3ec56c4b-6dbc-474d-8e31-5a019dc8a044@linaro.org>
Date: Tue, 7 Jan 2025 17:06:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tools build: Fix a number of Wconversion warnings
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250106215443.198633-1-irogers@google.com>
 <576a50c8-9ca2-4e2f-9bd8-7d9be4862920@linaro.org>
 <CAP-5=fUZ2QCocFKdLfBoNYC-CQfSAcdbA05OhegKmTt_PLR1WA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUZ2QCocFKdLfBoNYC-CQfSAcdbA05OhegKmTt_PLR1WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/01/2025 4:11 pm, Ian Rogers wrote:
> On Tue, Jan 7, 2025 at 2:33 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 06/01/2025 9:54 pm, Ian Rogers wrote:
>>> There's some expressed interest in having the compiler flag
>>> -Wconversion detect at build time certain kinds of potential problems:
>>> https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/
>>>
>>> As feature detection passes -Wconversion from CFLAGS when set, the
>>> feature detection compile tests need to not fail because of
>>> -Wconversion as the failure will be interpretted as a missing
>>> feature. Switch various types to avoid the -Wconversion issue, the
>>> exact meaning of the code is unimportant as it is typically looking
>>> for header file definitions.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>
>> What's the plan for errors in #includes that we can't modify? I noticed
>> the Perl feature test fails with -Wconversion but can be fixed by
>> disabling the warning:
>>
>>     #pragma GCC diagnostic push
>>     #pragma GCC diagnostic ignored "-Wsign-conversion"
>>     #pragma GCC diagnostic ignored "-Wconversion"
>>     #include <EXTERN.h>
>>     #include <perl.h>
>>     #pragma GCC diagnostic pop
>>
>> Not sure why it needs both those things to be disabled when I only
>> enabled -Wconversion, but it does.
> 
> This change lgtm, I'm not sure how others feel. I don't have a plan, I
> was just following up on Leo's Wconversion comment to see what state
> things were in. The feature tests without these changes pretty much
> break the build (I can live without perl support :-) ) so I thought I
> could move things forward there and then see the state of Wconversion
> with the patch I was working on.
> 
> I'm not sure how others feel about fixing Wconversion in perf, the
> errors are quite noisy imo. The biggest issue imo will be with headers
> shared by tools and the kernel, where kernel people may be vocal on
> the merits of Wconversion.
> 

More warnings are better IMO, but I can't say I have any experience with 
that particular one, whether it's too painful to be useful or not.

And if it's going to require those pragmas all over the place to fully 
enable it maybe it's better to leave it off. Just your change without 
the pragmas makes sense for sporadic manual testing though, and we can 
leave libperl disabled.

>>> ---
>>>    tools/build/feature/test-backtrace.c           | 2 +-
>>>    tools/build/feature/test-bpf.c                 | 2 +-
>>>    tools/build/feature/test-glibc.c               | 2 +-
>>>    tools/build/feature/test-libdebuginfod.c       | 2 +-
>>>    tools/build/feature/test-libdw.c               | 2 +-
>>>    tools/build/feature/test-libelf-gelf_getnote.c | 2 +-
>>>    tools/build/feature/test-libelf.c              | 2 +-
>>>    tools/build/feature/test-lzma.c                | 2 +-
>>>    8 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/tools/build/feature/test-backtrace.c b/tools/build/feature/test-backtrace.c
>>> index e9ddd27c69c3..7962fbad6401 100644
>>> --- a/tools/build/feature/test-backtrace.c
>>> +++ b/tools/build/feature/test-backtrace.c
>>> @@ -5,7 +5,7 @@
>>>    int main(void)
>>>    {
>>>        void *backtrace_fns[10];
>>> -     size_t entries;
>>> +     int entries;
>>>
>>>        entries = backtrace(backtrace_fns, 10);
>>>        backtrace_symbols_fd(backtrace_fns, entries, 1);
>>> diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
>>> index 727d22e34a6e..e7a405f83af6 100644
>>> --- a/tools/build/feature/test-bpf.c
>>> +++ b/tools/build/feature/test-bpf.c
>>> @@ -44,5 +44,5 @@ int main(void)
>>>         * Test existence of __NR_bpf and BPF_PROG_LOAD.
>>>         * This call should fail if we run the testcase.
>>>         */
>>> -     return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
>>> +     return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr)) == 0;
>>
>> Seems a bit weird to invert some of the return values rather than doing
>> != 0, but as you say, the actual values seem to be unimportant.
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Yeah it was arbitrary and I didn't want to add a stdlib.h dependency
> in a bunch of places for the sake of a definition of NULL. I'm happy
> for things to be done differently if people like.
> 
> Thanks,
> Ian

