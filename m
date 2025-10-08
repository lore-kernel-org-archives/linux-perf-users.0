Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2E2ED154
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936463; cv=none; b=nN6L1Y4vrQVhmwWVBEH32GVWzY41UKABmCZSm0lVYLBV7Db/8O5zwQeb4rcbn68EYDtADTCImnveayTEMYRtz9FvNCxPwr8w6u17/lO8e8DELVZN30g4EAEkNmBr8qvS8ps73Tazfv3ZVuZgzl2TA1cXcA5quC/fWx66gk4PVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936463; c=relaxed/simple;
	bh=fKhXwZOH8jdMKSySGkMaw0CnyUlHZspDs+YiaztuI1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7IDWo8lRER4LuCAAGHUZ/3aQE/w/gpWg5XRNdBr4ceMtyIfve1u6cjLPi9aPyG8ZE7RZhNcNEImm6N7ogrk4rfPemwoA3QymW2G1ApVfIUyepn+uuhvTVfwOdwdmGUL4/40/P60lvfrc/A917EQG6bV3tg8TJW8CIRruzCGU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ww8YcHGY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ww8YcHGY"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bca51so23190f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 08:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759936460; x=1760541260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71pgwAeF8ZnAvmZsmtw6crExw14x3YUmdHLkGbBmsIM=;
        b=ww8YcHGYQmcphPZxAWt4uCsSpOxwHAcNgpTrXjghMN1FPsJAogGfyRa5qz31niHsDy
         DGyj8Bk3T9/4axEciNeFv53zG3VWnbNpq0YrRqAYXPClIYuMdVsSw2bXbVcQwQMb7Ln5
         32Jw1yCI5n/XzDdYEfQYT3pLMMs/Uq7JuU0SLI2tR7+7OJ2uBad9pVh7kNUu3zt14ZUH
         MBqqUwBv1SIU2rBPQVcS0I4rdIm84a1u3AmospCsERXbPdTKTvb70vMRzOLruZoLFTqC
         qIN2bQcl6InA1LFmjyypLBgdYDgo9UJQVVMVbvUvVl8mQG8qSWuxsGYfzfJC4GxW5h9K
         L5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936460; x=1760541260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71pgwAeF8ZnAvmZsmtw6crExw14x3YUmdHLkGbBmsIM=;
        b=I589VEMPef9od+DXQkKvxJ3k7/tNGT4MwP7g7AZUdhXMZ89G29e80F2So+9U/sN0hu
         oX9HroE9k+DXHaN7g8EpAmV9rsp/IsmRvOJ3MXUweXi2a8K5PtOAG6ib6Oy2xwwXnXjd
         ZLlLg1G2wTFw7I8uVQ4QNOs4FY79s0kJV69pn2+FAOdaM+EKeubGlWdZ6hpOKCxHNhwV
         cUrmReQhoo4kJioCMw0w1HNLSQ5hgJ7ONUR4LR7/Jxof5fHN5dq/Y2SZr1F+sdKxuSfV
         X3FPAX4tkfwmmBE+ECO9kY4BHuSjo+6ij+R45/CWBDHR9wDpJicXdBTAdS1SXMolHGoG
         Waxg==
X-Forwarded-Encrypted: i=1; AJvYcCXFIXBSRtwGd5jh8Lqx325S7gGFnNtP32cdKtuhLB/1AQyuhNjIJ7ZqiK7nKkoUNyJEszAvdkO9Fezn2EFW5NSU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt2CYzUJwrRYUGHp7DIxkBWzZJM9aa5HPm4P1ymhS4TSnXTwpM
	iEZ3NtRph3te4brQyBBO2yQLkv5+lS/YRQ8IekUWHT+FBdRdXY/VWdfTXEq86lJHh4E=
X-Gm-Gg: ASbGncvVc40iz36Isw8nu8o5MASOom0aFxXeqZdzVMJRwiZAEJlWwSFfliBHWz4T1n1
	d/olODqzJsg7edhZf4Y5jOsUle9DbJ/7wZCXrzDzSqKkc47R9BkjlWl3sub9aF0Vetd+B35iRTu
	OQ72mb341BS71ZKJiS7oDJx8p5pTt2O3APuPmC15uffUW/rUTcduCx/QVDgrYY7cemc4BRcjMyt
	ZQyRgRDs7/BEe1A8YFVo/uhV2O3YAlKMRfOXW/uGO9H1/ksOcmAH6e0wdkk+kJ34ozLuwNQozmJ
	gM8QOxQkiOcR78wF7EgPCPpYuS79XdrEU9S8GNtGKY8dtYWKIwhFKdsknfrXu3G+a+g0QcHWUl4
	NCBA7NSikVdYNSf2Pv+33dMG7nNxiN7lv+++VfiFToXAn7sL/A+5jiOOE
X-Google-Smtp-Source: AGHT+IG6KcNZ0O/tlcjzWgsQA75pdcQp1NlzxQsZEPzaxSGf+G+35PCibY3W6WMwDR276jZjPez+dA==
X-Received: by 2002:a05:6000:186f:b0:3f4:84d0:401a with SMTP id ffacd0b85a97d-42666ab87b8mr2469128f8f.4.1759936459939;
        Wed, 08 Oct 2025 08:14:19 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f02a8sm30819224f8f.39.2025.10.08.08.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 08:14:19 -0700 (PDT)
Message-ID: <947c4e39-ee4e-4798-b783-8dec9a58f75d@linaro.org>
Date: Wed, 8 Oct 2025 16:14:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/27] perf jevents: Support copying the source json
 files to OUTPUT
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <20251005182430.2791371-1-irogers@google.com>
 <20251005182430.2791371-6-irogers@google.com>
 <fcba9459-9a5a-44c9-976a-323a6f4e0429@linaro.org>
 <CAP-5=fVervG=fmG7naTut3ERzwTTp7yQvuwqNkoKxSBSLsbgGA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVervG=fmG7naTut3ERzwTTp7yQvuwqNkoKxSBSLsbgGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/10/2025 3:58 pm, Ian Rogers wrote:
> On Wed, Oct 8, 2025 at 4:10 AM James Clark <james.clark@linaro.org> wrote:
>> On 05/10/2025 7:24 pm, Ian Rogers wrote:
>>> The jevents command expects all json files to be organized under a
>>> single directory. When generating json files from scripts (to reduce
>>> laborious copy and paste in the json) we don't want to generate the
>>> json into the source directory if there is an OUTPUT directory
>>> specified. This change adds a GEN_JSON for this case where the
>>> GEN_JSON copies the JSON files to OUTPUT, only when OUTPUT is
>>> specified. The Makefile.perf clean code is updated to clean up this
>>> directory when present.
>>>
>>> This patch is part of:
>>> https://lore.kernel.org/lkml/20240926173554.404411-12-irogers@google.com/
>>> which was similarly adding support for generating json in scripts for
>>> the consumption of jevents.py.
>>>
>>> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>
>> Hi Ian,
>>
>> This commit breaks the build on x86 for me, but not Arm. I also had to
>> do a clean build when bisecting as it seemed to be sticky in some way.
>>
>> It fails on the empty pmu events file diff check:
>>
>> diff -u pmu-events/empty-pmu-events.c
>> /home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-events.c
>> 2>
>> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log
>> || (cat
>> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log
>> && false)
>> --- pmu-events/empty-pmu-events.c       2025-10-08 11:49:46.341849139 +0100
>> +++
>> /home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-events.c
>>    2025-10-08 11:54:40.619999115 +0100
>> @@ -19,239 +19,8 @@
>>    };
>>
>>    static const char *const big_c_string =
>> -/* offset=0 */ "software\000"
>> ...
>>
>> The output continues with the rest of the diff, but I assume it's not
>> important to reproduce the issue.
> 
> I've similarly had issues with empty-pmu-events.c and the test that as
> you say are resolved by a clean build. When I've investigated in the
> past it is the dependencies on the files are accurate but some are
> added or removed, I think adding the Makefile as a dependency for
> building empty-pmu-events.c was a resolution but in general we've not
> done that so I didn't send out a fix.
> 
> Thanks,
> Ian
> 

Yeah this is the second time I've hit this, but this time it didn't get 
me stuck for too long because I recognized it.

I double checked building the last commit of the series after a clean 
and it still fails, so I think that's an issue in addition to the 
dependency issue. Considering this change touches the Makefile maybe we 
can ignore the dependency issue for now and assume that a clean is required.

>> Thanks
>> James
>>
>>> ---
>>>    tools/perf/Makefile.perf    | 21 ++++++++++++++++-----
>>>    tools/perf/pmu-events/Build | 18 ++++++++++++------
>>>    2 files changed, 28 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>>> index 7d6ac03a7109..278e51e4b5c6 100644
>>> --- a/tools/perf/Makefile.perf
>>> +++ b/tools/perf/Makefile.perf
>>> @@ -1272,9 +1272,24 @@ endif # CONFIG_PERF_BPF_SKEL
>>>    bpf-skel-clean:
>>>        $(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
>>>
>>> +pmu-events-clean:
>>> +ifeq ($(OUTPUT),)
>>> +     $(call QUIET_CLEAN, pmu-events) $(RM) \
>>> +             pmu-events/pmu-events.c \
>>> +             pmu-events/metric_test.log \
>>> +             pmu-events/test-empty-pmu-events.c \
>>> +             pmu-events/empty-pmu-events.log
>>> +else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
>>> +     $(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
>>> +             $(OUTPUT)pmu-events/pmu-events.c \
>>> +             $(OUTPUT)pmu-events/metric_test.log \
>>> +             $(OUTPUT)pmu-events/test-empty-pmu-events.c \
>>> +             $(OUTPUT)pmu-events/empty-pmu-events.log
>>> +endif
>>> +
>>>    clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
>>>                arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
>>> -             tests-coresight-targets-clean
>>> +             tests-coresight-targets-clean pmu-events-clean
>>>        $(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
>>>                $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>>>        $(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
>>> @@ -1287,10 +1302,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
>>>                $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
>>>                $(OUTPUT)util/intel-pt-decoder/inat-tables.c \
>>>                $(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
>>> -             $(OUTPUT)pmu-events/pmu-events.c \
>>> -             $(OUTPUT)pmu-events/test-empty-pmu-events.c \
>>> -             $(OUTPUT)pmu-events/empty-pmu-events.log \
>>> -             $(OUTPUT)pmu-events/metric_test.log \
>>>                $(OUTPUT)$(fadvise_advice_array) \
>>>                $(OUTPUT)$(fsconfig_arrays) \
>>>                $(OUTPUT)$(fsmount_arrays) \
>>> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
>>> index 32f387d48908..1503a16e662a 100644
>>> --- a/tools/perf/pmu-events/Build
>>> +++ b/tools/perf/pmu-events/Build
>>> @@ -1,7 +1,6 @@
>>>    pmu-events-y        += pmu-events.o
>>>    JDIR                =  pmu-events/arch/$(SRCARCH)
>>> -JSON         =  $(shell [ -d $(JDIR) ] &&                            \
>>> -                     find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
>>> +JSON         =  $(shell find pmu-events/arch -name *.json -o -name *.csv)
>>>    JDIR_TEST   =  pmu-events/arch/test
>>>    JSON_TEST   =  $(shell [ -d $(JDIR_TEST) ] &&                       \
>>>                        find $(JDIR_TEST) -name '*.json')
>>> @@ -29,13 +28,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
>>>        $(call rule_mkdir)
>>>        $(Q)$(call echo-cmd,gen)cp $< $@
>>>    else
>>> +# Copy checked-in json for generation.
>>> +$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
>>> +     $(call rule_mkdir)
>>> +     $(Q)$(call echo-cmd,gen)cp $< $@
>>> +
>>> +GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON))
>>> +
>>>    $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
>>>        $(call rule_mkdir)
>>>        $(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
>>>
>>> -$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
>>> +$(TEST_EMPTY_PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
>>>        $(call rule_mkdir)
>>> -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-events/arch $@
>>> +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none $(OUTPUT)pmu-events/arch $@
>>>
>>>    $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
>>>        $(call rule_mkdir)
>>> @@ -63,10 +69,10 @@ $(OUTPUT)%.pylint_log: %
>>>        $(call rule_mkdir)
>>>        $(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
>>>
>>> -$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
>>> +$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
>>>        $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_EVENTS_PYLINT_TEST_LOGS)
>>>        $(call rule_mkdir)
>>> -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
>>> +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
>>>    endif
>>>
>>>    # pmu-events.c file is generated in the OUTPUT directory so it needs a
>>

