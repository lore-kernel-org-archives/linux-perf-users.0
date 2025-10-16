Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CD2D0C7D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610594; cv=none; b=YfBZPy5yfAPoUepFftkiLw/pTd9CsnG2/BKxK0tG+C0QL2+jtyOsyH5xzKepR9jb2b04LMb7MoffuUrBreakbVAPBjqE3OhJjDXn851lLCAvszseEsmztfkfQNHskJWiFSopZe+IyTWRuph1yxjQ+PcCQSo2k6WUTOZH1gGs5AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610594; c=relaxed/simple;
	bh=C1Qq0nuM3kmY41SedxaVCFVgNViHbDE+Dg+0PoOWuUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOcVOxc/UAou5wRjp7eqisZbaZvb8+2b5BU/U6zvnk0MlORx5BNUsu8R5yLEXnGXni2A6IrJUnYufXiPriAc+LPx7llmW43ZUfAJwx4urTgNmOBkblXs9QnZY+FPgVbBtBCrXb4lKjGsbXL4/Q4J6LICkUuK/8qHxkwkHdPpqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ho9MA978; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ho9MA978"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso516162f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Oct 2025 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760610591; x=1761215391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aWwXJImAGu1XaOPG7ISHmz9NLDzl7hFLgWZKk+CsrM=;
        b=Ho9MA978lPMM9cXdUK6FOuXLEI7nOdXAvy9taUpT8+BrrL26fAzwaLAxxPUTY5V0BP
         YELOeBl5biQNQabGEfNcZfp3wSxwCL2T/PWLFKhPx0Q5dmp2UiM/s6Jic/3acYkymARH
         xvKnb6bDsGyp3+IgBuLQKEb9HPJPBCZnNoYPO+AxG7a/4iToIFLcL4w0hKjz78/StoE+
         Q55Zvhu8Bh+JDJLNGCJ0CVx3IYw0Xel/+HE6Ay58P89jWOssPSQOluBcV/t/r/u1BJeN
         oqOZTgkXU6dGE4UUkhZvHWhMOFtDeyY7bmaewxb0jt2SPJW9a9RTUZl6wbKshcGKge1v
         jIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760610591; x=1761215391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aWwXJImAGu1XaOPG7ISHmz9NLDzl7hFLgWZKk+CsrM=;
        b=rOfanbOVDr8G5ujHwMhYTFESQeW3CcHxsnbZ0vzJim7mYh4yogihQ40alPp/byPa9+
         9j+xDyMR0MJjMW67nveKC2lZ99sNGU1/bRjZkEKW5wkLhqL9SKxIseXQJuBAb1YD0ymh
         6dqMyw6cffAALhHbqYAUHgKFFFyAa/rpv+/mUd6ShHUvZnOauod0hdf1vqgPoFly9X0b
         +AwFE1SBt54RiTEjv/1cVsN3vPPNh8JQGPPnOCq2PJjcSjgg6vbn8gqVSWIWYLXLe9ca
         oEAWSYphzDrxOpmT29DpQxiL+2y20H1gnJekfXtdLU3+ph4u6duNdhjvtZqu1heNZk5w
         DOVw==
X-Forwarded-Encrypted: i=1; AJvYcCW7fZ4lqNTNkN3bFGQEukVarrdW+vWICfFbdD6rDOWeHG/FCkDfeg6NxoqhwBMa11/Wkgb9AE4fLUb6KcjJHjya@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyXdEunAC5tpbIdpUkhF3ssN6hx5RymSuEZzlz1ymcn0B9y42
	47N6zVpu1TAGi4RL9la7IyPs7IaY69Jbz0QDdaKOig0D30Q6K97RWA0SR/2iGICrqtI=
X-Gm-Gg: ASbGnctRt6mRXMnenSedzYg2AIPoydVIWXaSrKE1W5AMBIr4uq+G2eM/eGYz44zuat/
	QzwZ7UsJ0aVqQPnVWbEsfDwnii9xP2+L4ws9NMeabtw9wt4PIaBGr/ZZlTDXCNHH0EWiJY9vgns
	uK1siQyVSXusdWZ5z7sVVqbyv/F3OC4lcxLqcHFVkQdFLcb6WUmAa6eK9bekM1CfHACrjxJ8gZY
	fLDy+VsUB+x5gR2OZYqvvj7Nul6/jg5Zag/GaANBdM/BtTotWqw3tNH6mDqFJtFgv7ZXRj/v6WU
	k55vaVo2xdfo7QX4+XF12n0WNmimWmV6w0g1BV/yYmsdbNRJ9A6NtfiQffCnla/SrgFEJAkWfBB
	q0/T5O27mEc91RK7BzsoaSR7XXJWthP8iUWknnQtuUfi4w5nkQAkvKsg+70NV8udaW7BQNFc9+Y
	BywyFcrVNfAw==
X-Google-Smtp-Source: AGHT+IHfR7TsQm+oDwSMGTkIL3w54sYZhAOyys7grMjNi/GzoSKnD6Jh1izbG0lLs9rpXLzQrSEitg==
X-Received: by 2002:a5d:5f54:0:b0:3da:37de:a38e with SMTP id ffacd0b85a97d-4266e8e0b8emr22762057f8f.54.1760610590562;
        Thu, 16 Oct 2025 03:29:50 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711443e81asm20056685e9.10.2025.10.16.03.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 03:29:50 -0700 (PDT)
Message-ID: <b1a461b4-4358-4556-80ef-e7abd686f2e5@linaro.org>
Date: Thu, 16 Oct 2025 11:29:49 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <20251005182430.2791371-1-irogers@google.com>
 <176054362630.22559.13423487878652916137.b4-ty@kernel.org>
 <a9f3b996-4fb4-463a-8392-16115862903a@linaro.org>
 <CAP-5=fX8ZV6WTmKcrrfPo0MUFiruJoWhYeUk3JrToEP=9-aPCA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fX8ZV6WTmKcrrfPo0MUFiruJoWhYeUk3JrToEP=9-aPCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/10/2025 10:24 pm, Ian Rogers wrote:
> On Wed, Oct 15, 2025 at 10:39 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 15/10/2025 4:53 pm, Namhyung Kim wrote:
>>> On Sun, 05 Oct 2025 11:24:03 -0700, Ian Rogers wrote:
>>>
>>>> Mirroring similar work for software events in commit 6e9fa4131abb
>>>> ("perf parse-events: Remove non-json software events"). These changes
>>>> migrate the legacy hardware and cache events to json.  With no hard
>>>> coded legacy hardware or cache events the wild card, case
>>>> insensitivity, etc. is consistent for events. This does, however, mean
>>>> events like cycles will wild card against all PMUs. A change doing the
>>>> same was originally posted and merged from:
>>>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
>>>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
>>>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
>>>> his dislike for the cycles behavior on ARM with perf record. Earlier
>>>> patches in this series make perf record event opening failures
>>>> non-fatal and hide the cycles event's failure to open on ARM in perf
>>>> record, so it is expected the behavior will now be transparent in perf
>>>> record on ARM. perf stat with a cycles event will wildcard open the
>>>> event on all PMUs, however, with default events the cycles event will
>>>> only be opened on core PMUs.
>>>>
>>>> [...]
>>>
>>> Applied to perf-tools-next, thanks!
>>>
>>> Best regards,
>>> Namhyung
>>>
>>
>> Hi Namhyung,
>>
>> I'm still getting the build failure that I mentioned on patch 5. This
>> only seems to happen with out of source builds:
>>
>>     $ make -C tools/perf O=../build/local/ V=1
>>
>>
>>     static const struct pmu_sys_events pmu_sys_event_tables[] = {
>>           {
>> -               .event_table = {
>> -                       .pmus = pmu_events__test_soc_sys,
>> -                       .num_pmus = ARRAY_SIZE(pmu_events__test_soc_sys)
>> -               },
>> -               .name = "pmu_events__test_soc_sys",
>> -       },
>> -       {
>>                   .event_table = { 0, 0 },
>>                   .metric_table = { 0, 0 },
>>           },
>> make[3]: *** [pmu-events/Build:54:
>> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log]
>> Error 1
> 
> Sorry for the issue. Is this happening when you don't do a clean
> first? I tried recreating your output path, but I can't reproduce the
> issue on a clean build. The diff above indicates some issue with the

The clean issue was separate to the build failure. I meant that the 
build failure was sticky when I was bisecting. So after commit 5 the 
build breaks on a clean build but then it stayed broken even on builds 
before commit 5 unless I cleaned. I think we can ignore this for now.

> Makefile processing tools/perf/pmu-events/arch/test/test_soc/. This
> directory should be copied to
> ../build/local/pmu-events/arch/test/test_soc/ and so I wonder if the
> copy failed for some reason.
> 
> The copy rule is:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n33
> ```
> # Copy checked-in json for generation.
> $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
> $(call rule_mkdir)
> $(Q)$(call echo-cmd,gen)cp $< $@
> ```
> 
> The mapping of file names happens in the patsubst in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n42
> ```
> GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
> ```
> 
> Those files are dependencies for the empty-pmu-events.c test so I'm
> not sure how this can be failing for you.
> 
> Thanks,
> Ian

If I apply this patchset to commit 2a67955de136 ("perf bpf_counter: Fix 
opening of "any"(-1) CPU events"), then:

   $ rm -r ../build/local ; mkdir ../build/local
   $ git clean -xfd
   $ make -C tools/perf O=../build/local/ -j1 V=1

I get no copy of the test jsons:

   $ ls ../build/local/pmu-events/arch/test/test_soc/

   ls: cannot access '../build/local/pmu-events/arch/test/test_soc/': No
   such file or directory

Looking at the dependencies of the rule for $(PMU_EVENTS_C), it's 
$(JSON_TEST), but JSON_TEST is the in-source version without the 
$(OUTPUT) prefix. That's already satisfied so it skips the copy.

If I modify the generator for JSON_TEST to include the OUTPUT prefix:

JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &   \
	find $(JDIR_TEST) -name '*.json' | sed -e 's|^|$(OUTPUT)|g')

Now I get the copy:

   $ ls ../build/local/pmu-events/arch/test/test_soc/

   total 0
   drwxrwxr-x 1 james  56 Oct 16 11:13 ..
   drwxrwxr-x 1 james 108 Oct 16 11:13 cpu
   drwxrwxr-x 1 james  12 Oct 16 11:13 .
   drwxrwxr-x 1 james  22 Oct 16 11:13 sys

Now the diff check is slightly different/better, but the build still 
fails. Weirdly I don't see this failure on my Arm machine which is where 
I tested the whole set, I only see this failure on x86. Maybe some 
difference in the version of make?

