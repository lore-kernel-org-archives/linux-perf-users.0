Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18EC191F92
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976657; cv=none; b=osp11UVY9zS/4YuquVd51fz6GK+zahGAipfzlMRfbk8PDoAvhjfy5dOzwMCZ/ZpF7KhboC+sVlUkC6ysStNtOhK/pIULtXV7D0vcv4OMXmMSle1Ne0qtcu0nBbAstecnGemJDODf7IWliYgFDzysfGy+ZW+d2P8A/OXvcGaYrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976657; c=relaxed/simple;
	bh=atlvMgRm+hS9Ugv97pz3Qaw9ZHe2wJvCA4y4Y/WoWHw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iaY3EwtfZ8IaCb0VmSIJ+NUj2GOoIHW6O1f+Wx1mASfJRXd8SQ1whkvIIcuBMXAV353NxEfIEMVoC/dF231bUHOq6QGwlB1QsSRWh3AGkByA8DDx2RFUvdjQCtiChOXRHiM8egIql+YCNQbyOuBTcgFwFmaL1HGfeN4onXW5IMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqj5Bj/l; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqj5Bj/l"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46b303f7469so35905705e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976654; x=1761581454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xwoZbVRQTt+W1c+EeTF1T/2iGQVGJEAF5xGXmi6G/Rw=;
        b=rqj5Bj/lH6Vv2W7sKXk4m6QAl7LPvOgfSYTjOwTjeJQSpdAccXAQUNFUk8lAR95jWR
         jkn7dpZlqAePkKVsXxRtF2EVeHRVSnCsawIO4LV/FdMqzxuoEqzFZ6P9QpRktz5f6P+g
         A+lePpXkiKp/oVKMeHV+PYam4Ol/oWVLAa9ynnOXwwHGJhoIG1KblIbuO1leM4J9sezd
         4FU/9yViQlb03GAeGMHyQiSduPKagGokxQdF31EFh82fbigLTOwAakEwCwsKvfB+s9Kn
         skAx/P7gTH2UbNm9yEnQSi+BOWCmM3TvDNEEMInFCMVMghjsEtOP6995j0M42IhnsfSZ
         EemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976654; x=1761581454;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwoZbVRQTt+W1c+EeTF1T/2iGQVGJEAF5xGXmi6G/Rw=;
        b=nY9P1ngOyNZpSYvkssdaYMBcFjyzDKXA2Zex9/pVbx62kFJQRfUnug8rcbMYnjho98
         iXL3BLQzcwSdFKJh5NqbJ4XMDJt19WSZJBK8lS4H0UG4yBsxTrtf0vsB5m7Kapptl+Gr
         ho4bft5pvdfqlc4d9A+9rZ7XKbn04Bj/L4iDwJzOnhogaLEIDQkrMKRF+DfifShWqSNs
         F2IRvcQ4NDy8lj8ksTT1FImtIJTUrkG+AcRHkf8LRHBPq1ir/cp59tgTqipSZsTl5QBa
         qAg+L3H8uqtp4sE6Ao0i/CGSzP4NU7b9sMD2qKD1D9aiPcuOAECYua6D0DMLvMTew+rD
         c1tg==
X-Forwarded-Encrypted: i=1; AJvYcCVjDJhD+FWByLnox1q6nwrq3F72BCVeBzaTn+5CyaTrjAgeIWVA0yGlTqFi3tlN/29f+IG8J48wgCwG/IxvOkJA@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2NdURVkuS+oJHVl+dyQqkZIj+dsSatnX5T9zWAnUxSUjugqC
	gb4lYmauWbWSflGne0PFAHaWoIQd0ituJ1yFPb435NGXhELatUs/TvnR0Pz11dWXwUI=
X-Gm-Gg: ASbGncssVqaQvQUuQOGc0ctjsu/suBkDfZ273QaMYVZMVFOK2vxunKlMSl6+YcWphaj
	JQCXVcJh2VFDYgtnGrUQ+2T7lauK+5XxibCoE/eTDfqUtwaUqfy8gqZSoy4b1Ip9FnAXr/XzkXl
	hA7BmQg/MPCo5y4KI3CInFVI6dBvmQMWthNovUnUTtFRZgZ+3dA67eAF+YC7+uTbYfwKsvqWyV5
	YMcHzQ83S+qxkPMuzVIKnlrWndgxxeibGx49aqDW6l0PIK9I6vHMTrs1E4vqjbyqryuGf+mkUZW
	OK7fA8OGyq00w/UFmZaGFVcPMQNJ7ke9ZayzyvCbpz0bEcGg0ovYZgxcI8IqiUfAtMmzim7fVuP
	1CQv+rUiZKk8OZ2GWS8kY1qKdxUXJgU4w0cOv/NRX9g5hrowPi7CGU3SlvXiaNsBNlkM2Fes6q/
	+vhFUinfH1l0dgg9EQ1v0oUu7rJDY=
X-Google-Smtp-Source: AGHT+IEPnIGwsuZY+46A6PpcAFpc8Ia5wCuHzXWDH7VRfIxTAeoRBvtxAHsNgzzUSluVxH++2wSTuA==
X-Received: by 2002:a05:6000:26c8:b0:427:72d1:e3b2 with SMTP id ffacd0b85a97d-42772d1f234mr7266592f8f.35.1760976653835;
        Mon, 20 Oct 2025 09:10:53 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710cda4ecasm113706775e9.4.2025.10.20.09.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 09:10:53 -0700 (PDT)
Message-ID: <cf9aa030-1ac0-4b40-a613-d50a6feb138a@linaro.org>
Date: Mon, 20 Oct 2025 17:10:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
From: James Clark <james.clark@linaro.org>
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
 <b1a461b4-4358-4556-80ef-e7abd686f2e5@linaro.org>
Content-Language: en-US
In-Reply-To: <b1a461b4-4358-4556-80ef-e7abd686f2e5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/10/2025 11:29 am, James Clark wrote:
> 
> 
> On 15/10/2025 10:24 pm, Ian Rogers wrote:
>> On Wed, Oct 15, 2025 at 10:39 AM James Clark <james.clark@linaro.org> 
>> wrote:
>>>
>>>
>>>
>>> On 15/10/2025 4:53 pm, Namhyung Kim wrote:
>>>> On Sun, 05 Oct 2025 11:24:03 -0700, Ian Rogers wrote:
>>>>
>>>>> Mirroring similar work for software events in commit 6e9fa4131abb
>>>>> ("perf parse-events: Remove non-json software events"). These changes
>>>>> migrate the legacy hardware and cache events to json.  With no hard
>>>>> coded legacy hardware or cache events the wild card, case
>>>>> insensitivity, etc. is consistent for events. This does, however, mean
>>>>> events like cycles will wild card against all PMUs. A change doing the
>>>>> same was originally posted and merged from:
>>>>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
>>>>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
>>>>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
>>>>> his dislike for the cycles behavior on ARM with perf record. Earlier
>>>>> patches in this series make perf record event opening failures
>>>>> non-fatal and hide the cycles event's failure to open on ARM in perf
>>>>> record, so it is expected the behavior will now be transparent in perf
>>>>> record on ARM. perf stat with a cycles event will wildcard open the
>>>>> event on all PMUs, however, with default events the cycles event will
>>>>> only be opened on core PMUs.
>>>>>
>>>>> [...]
>>>>
>>>> Applied to perf-tools-next, thanks!
>>>>
>>>> Best regards,
>>>> Namhyung
>>>>
>>>
>>> Hi Namhyung,
>>>
>>> I'm still getting the build failure that I mentioned on patch 5. This
>>> only seems to happen with out of source builds:
>>>
>>>     $ make -C tools/perf O=../build/local/ V=1
>>>
>>>
>>>     static const struct pmu_sys_events pmu_sys_event_tables[] = {
>>>           {
>>> -               .event_table = {
>>> -                       .pmus = pmu_events__test_soc_sys,
>>> -                       .num_pmus = ARRAY_SIZE(pmu_events__test_soc_sys)
>>> -               },
>>> -               .name = "pmu_events__test_soc_sys",
>>> -       },
>>> -       {
>>>                   .event_table = { 0, 0 },
>>>                   .metric_table = { 0, 0 },
>>>           },
>>> make[3]: *** [pmu-events/Build:54:
>>> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log]
>>> Error 1
>>
>> Sorry for the issue. Is this happening when you don't do a clean
>> first? I tried recreating your output path, but I can't reproduce the
>> issue on a clean build. The diff above indicates some issue with the
> 
> The clean issue was separate to the build failure. I meant that the 
> build failure was sticky when I was bisecting. So after commit 5 the 
> build breaks on a clean build but then it stayed broken even on builds 
> before commit 5 unless I cleaned. I think we can ignore this for now.
> 
>> Makefile processing tools/perf/pmu-events/arch/test/test_soc/. This
>> directory should be copied to
>> ../build/local/pmu-events/arch/test/test_soc/ and so I wonder if the
>> copy failed for some reason.
>>
>> The copy rule is:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools- 
>> next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n33
>> ```
>> # Copy checked-in json for generation.
>> $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
>> $(call rule_mkdir)
>> $(Q)$(call echo-cmd,gen)cp $< $@
>> ```
>>
>> The mapping of file names happens in the patsubst in:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools- 
>> next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n42
>> ```
>> GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
>> ```
>>
>> Those files are dependencies for the empty-pmu-events.c test so I'm
>> not sure how this can be failing for you.
>>
>> Thanks,
>> Ian
> 
> If I apply this patchset to commit 2a67955de136 ("perf bpf_counter: Fix 
> opening of "any"(-1) CPU events"), then:
> 
>    $ rm -r ../build/local ; mkdir ../build/local
>    $ git clean -xfd
>    $ make -C tools/perf O=../build/local/ -j1 V=1
> 
> I get no copy of the test jsons:
> 
>    $ ls ../build/local/pmu-events/arch/test/test_soc/
> 
>    ls: cannot access '../build/local/pmu-events/arch/test/test_soc/': No
>    such file or directory
> 
> Looking at the dependencies of the rule for $(PMU_EVENTS_C), it's 
> $(JSON_TEST), but JSON_TEST is the in-source version without the 
> $(OUTPUT) prefix. That's already satisfied so it skips the copy.
> 
> If I modify the generator for JSON_TEST to include the OUTPUT prefix:
> 
> JSON_TEST    =  $(shell [ -d $(JDIR_TEST) ] &   \
>      find $(JDIR_TEST) -name '*.json' | sed -e 's|^|$(OUTPUT)|g')
> 
> Now I get the copy:
> 
>    $ ls ../build/local/pmu-events/arch/test/test_soc/
> 
>    total 0
>    drwxrwxr-x 1 james  56 Oct 16 11:13 ..
>    drwxrwxr-x 1 james 108 Oct 16 11:13 cpu
>    drwxrwxr-x 1 james  12 Oct 16 11:13 .
>    drwxrwxr-x 1 james  22 Oct 16 11:13 sys
> 
> Now the diff check is slightly different/better, but the build still 
> fails. Weirdly I don't see this failure on my Arm machine which is where 
> I tested the whole set, I only see this failure on x86. Maybe some 
> difference in the version of make?
> 

Turned out to be an extra json file I had in the Perf tree for my 
compilation database, so that explains why I was the only person seeing 
it. Sent a fix.


