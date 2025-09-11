Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B813EFE3
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595636; cv=none; b=usU/EybvF7oDENpVpNHyJNOrXwXFQgpP5KJ9B11aNVIWjmOsPZd3ytHBkFLfLQUQoTc+VKz4gTQu+944ViE1hKFnzGCvT1FRwWWF8A1Li1+IE+8oLv3QnXJpcNvaDvPFza0+KBa1zbDlz4Aba44XIyLe2IuQdCQUgFaPB0DVVpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595636; c=relaxed/simple;
	bh=Uev9tFJf6el4XASN98rZT8IvrdeNF7D26YWzATU6Rxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbtPeYvtAylci18I98PmcQEAAQCWa0v0t1C3QlYeTFZceM1IR6CZ0V3uG/WALzDG6P+iHLJ6xJqNikGe9nACvrDDsJHcoxTHgjTZUEPuFponCMG1A3w/1AMqDD6uTx5hiq6BGrhaj2ALckroKnlgTvoZXu68EKDvRjtgr3FkSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XDPyXsm7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDPyXsm7"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e7428c4cbdso543339f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757595632; x=1758200432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K02gEkp4FY0AuUQUnIeSmVCDV/i1HbGkotmEzOpyz4=;
        b=XDPyXsm7cAxXWfi+rkQcB1nAEIA4S2QxB6WIHZmb5WH1hal4b06kRL7OuDX1wMoidC
         PulYqDv7wmJWm0VUjdMhXrR1/2Hj9LAnRtC8TAfGkX0+j5ipYThPLlRKVR3OUo5fLwNr
         xEJVu/t1hQJuvNSiHCaBiWrt9oNH5WQurgzwHf3v1N+6E7y6w78THwfEnngRaIS46BQf
         OlwO8KFZz57JD8/lVnoM2H1KJizmgwxpOfOoqa+IfHRDz4Sno3TQXBYTCtvQmXNuAR5b
         WzyQFmMQGu2Quv2It2G31E6xETC3mrE7tzKWmOQffYxSl0rZ6WBqP8dL+81Tyy3U50v3
         Efmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595632; x=1758200432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6K02gEkp4FY0AuUQUnIeSmVCDV/i1HbGkotmEzOpyz4=;
        b=sp6+NtAzM+ug0DF82n0agKFELakLDwdE/jEIptjrySXevh7crtn1YgFAyqao5n9lau
         QzAibDmvs91jwXuAeYyL95KAzv2FXUefnh62bUo2e6kIk7Xo/nT23LhSJsxD9uEweIxc
         G/SeF1mHra89k7e2aJd/DBI4Sg4orYkbIRFmmgWLP91n13S+oNis/IkK9BZZB5E+rZMX
         vFIWdqnKkZdz2K7/SuaKOc7tJeWfSgtclv9xHhIHb5+Zy+nFGjDB2p3CAGROHYk/vSVz
         5BM5tURWn5K1sO7dE4VVw5UPmHFgsoVhrYvZTnUzgTcaEUtzkhItFjtvbefaWALhfHEt
         S75w==
X-Forwarded-Encrypted: i=1; AJvYcCXKuNiPQcsYr+Lh4G5tLU9UbzTrJrKSchQTgstIr5oUmORr5DYzkv8AuQomKCygVwelXtd3wdzF/DftdVqtSGcd@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqLcq7FqM1rVjWGl0M/0fJMXJeaJhXpto5/wQIoo6lAMpwX4D
	5lZMjFpPdaSDA1dDtoZEJztyNMq/xGVm9H1IWAfJVcmWqkp6tcVn+nxp7OQLCjAn3hw=
X-Gm-Gg: ASbGncvO3GmvqC7BQPbvhIGw5J08ftyGQHeDhUY6cNRkT0njkzhBdEhL5TFVlK9Yjlk
	W99HSCBKqPO3tVeOi/cvqRh9Qs3gc56A1FCUdIAJjNWKU1KZcMivXYOsAOUaTSSB0ao5s3ehm0s
	/KNypBZqn407DmJCbXcR6sCvTxOLsMb/nGdhj1GLzV7L+eHQCaGYMre8kM/rvMCB8stStPAbB/p
	K4pPUyEuuD/t1ZNU4s8ZlVFXeUct0BFKKcA3yMP7h8VxXckj1aQumAEvXXXBjtrCm1hQd40kZUa
	i3aMxW2L24mCGCz5oiRmDk6xpjnTmp38BrlN2LbkYCgAwfMMf2P4ptrlI/nOhS2j612lcrJK4Mi
	XkudJOdIDwaGLoN81HIG98U11BDs=
X-Google-Smtp-Source: AGHT+IGq8rqA+k3RKGl/sU6BFCggRB85QSN4RZ9bx5hBV1Bj59utOir0PZkfMb+C5GQLZ6LkmpaYlA==
X-Received: by 2002:a05:6000:178d:b0:3dc:1a9c:2e7f with SMTP id ffacd0b85a97d-3e75e0e51damr2584373f8f.8.1757595631818;
        Thu, 11 Sep 2025 06:00:31 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd691sm2468335f8f.32.2025.09.11.06.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:00:30 -0700 (PDT)
Message-ID: <055e677e-2a2f-4c56-abe0-9a437dc14d69@linaro.org>
Date: Thu, 11 Sep 2025 14:00:29 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <20250828205930.4007284-1-irogers@google.com>
 <21d108f2-db8e-457a-bbef-89d18e8d7601@linaro.org>
 <CAP-5=fVbtL=eL5bCFzz06g86Sk3nBsxUmgwZ3c5UY7z5hwmoLA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVbtL=eL5bCFzz06g86Sk3nBsxUmgwZ3c5UY7z5hwmoLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/09/2025 4:00 pm, Ian Rogers wrote:
> On Wed, Sep 10, 2025 at 4:14 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 28/08/2025 9:59 pm, Ian Rogers wrote:
>>> Mirroring similar work for software events in commit 6e9fa4131abb
>>> ("perf parse-events: Remove non-json software events"). These changes
>>> migrate the legacy hardware and cache events to json.  With no hard
>>> coded legacy hardware or cache events the wild card, case
>>> insensitivity, etc. is consistent for events. This does, however, mean
>>> events like cycles will wild card against all PMUs. A change doing the
>>> same was originally posted and merged from:
>>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
>>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
>>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
>>> his dislike for the cycles behavior on ARM with perf record. Earlier
>>> patches in this series make perf record event opening failures
>>> non-fatal and hide the cycles event's failure to open on ARM in perf
>>> record, so it is expected the behavior will now be transparent in perf
>>> record on ARM. perf stat with a cycles event will wildcard open the
>>> event on all PMUs.
>>
>> Hi Ian,
>>
>> Briefly testing perf record and perf stat seem to work now. i.e "perf
>> record -e cycles" doesn't fail and just skips the uncore cycles event.
>> And "perf stat" now includes the uncore cycles event which I think is
>> harmless.
> 
> Thanks for confirming this.
> 
>> But there are a few perf test failures. For example "test event parsing":
>>
>>     evlist after sorting/fixing: 'arm_cmn_0/cycles/,{cycles,cache-
>>       misses,branch-misses}'
>>     FAILED tests/parse-events.c:1589 wrong number of entries
>>     Event test failure: test 57 '{cycles,cache-misses,branch-
>>       misses}:e'running test 58 'cycles/name=name/'
> 
> I suspect the easiest fix for this is to change "cycles" to the
> "cpu-cycles" legacy hardware event for this test. The test has always
> had issues on ARM due to hardcoded expectations of the core PMU being
> "cpu".
> 
>> The tests "Perf time to TSC" and "Use a dummy software event to keep
>> tracking" are using libperf to open the cycles event as a sampling event
>> which now fails. It seems like we've fixed Perf record to ignore this
>> failure, but we didn't think about libperf until now.
> 
> I'm not clear on the connection here. libperf doesn't do event parsing
> and so there are no changes in tools/lib/perf. If a test has an
> expectation that "cycles" is a core event, again we can change it to
> "cpu-cycles" as a workaround for ARM. As "cycles" will wildcard now,
> we don't want that behavior in say API probing as we'll end up never
> lazily processing the PMUs. That code has been altered in these
> changes to specify the core PMU. For tests it is less of an issue and
> so the changes are more limited.
> 
> Thanks,
> Ian

Sure makes sense if there's an easy fix for the tests, we can do that. I 
suppose the main reason I mentioned it was that the tests might be 
highlighting that other genuine non-Perf and non-test users would see 
the same breakage though.



