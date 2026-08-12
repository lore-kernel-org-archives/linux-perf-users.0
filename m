Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D12D23BC
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544822; cv=none; b=J0E9NmKBeLdRFmActGVJuQRVSRrnJYpdGmnaKDLhies7P7So+5C0A61yPucLPXNfMNAn0pQknjGcwRjBRdv6oEXUL2MsoL+GXchJsfOu2pUmiUu0qBC+tVoaAxPm7j0CjtnOoHP+d7NI+XGYSZlN6QI/OBLBQ2kMzTt8+lYHtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544822; c=relaxed/simple;
	bh=drVW/YKWjJGNkv+D0i+iaG/UTy4qkgQnZn3iLeSJ8C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJLk49L8MX0+BmuYzWNzCr1/e10R/ny23jFycTPcx3nGa3qCv0Oel8Qtap/8R5dT4VmJBuPoLsW0D5ZTJcltpiGnPRu3Dgh0uCYH1B5I0Fo7jorY4IZdltpXYRlZdasDg+RNTfa8M+Etfdc5F3+imGW6Q04xL5RxMHsYF7wB4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d1MzONUV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1MzONUV"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so1758406a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786544819; x=1787149619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASEcelLFoJ/llNSS4zb7EhEiRbhth5Y9y6EoNChT3gY=;
        b=d1MzONUVbkyg2mlFu/eeUZ2+rYH5gZvJP6Z7aW7SaUsGBiYhycQNRzj0IDObu7qFPp
         6f+xJtUqw9mlhyquO/VSSvWag60/obry1Oz7oTw1N6Op0zX+cLP2j3pHq/udigK0SfBB
         08bmd0lEP23nKV/FSXNgOBS5rz+laUhOKBD7Hz3YjLMjl7yOZ8Kea5Z9e/rHuDEZJlQG
         TfouP0U36+aSfw5OyX++KCHVRqC1GZ8HGoajTgRKLHgb16Zj5+emyi/12FNKUcW7UHMu
         Bpp5olhvNFu01ImmDSx2xloz3gMikmrBPn0Ovil7ktjViztvWd/F8+49H0FO4Iug/Zp/
         cgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544819; x=1787149619;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ASEcelLFoJ/llNSS4zb7EhEiRbhth5Y9y6EoNChT3gY=;
        b=nwDf6amqop9Au081rjovkGO7TyfjpuWZpx51u5wFDECMumpCqd0CSdmUYbTeFK2hEh
         JZJxa5oQbfxkf+Q5pGz8NzjI4Oc+OBGbubgX7S12Ps3p/apCx4sQJefhoQos2INM4eab
         EaZFuhIaeWaaznn6pLU9G0y8ci8G0pR4twQ1kzaVJL69EIrSYcJE33QA6NtWgW827bya
         qz5UzsyKA/isWrZrYe6Vbc8saZtSZ3OtzZQJySV7z2lguPYDfe3IOK8XAHg0SVg9GgSG
         xIl982bpSkyGHcnfkUGKwaiwNIvbTnnh0LC5f/JrWmaczD3+AjZok3Q3df6RphnQGCzF
         GK9w==
X-Forwarded-Encrypted: i=1; AHgh+RoRlyAXq+uuvF40Z1MZD53paY6qzl9Z4uTqhPQ5r0K+vk98f2B/zwKJjI7hhE+NnwXKo4pfiJWuPdI7rDWQJFsC@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwswFwkn8PNeNq1iZNzFtGNRkl8hoBwPNnfoP1Z8mfh1Z+OYn
	tfNhMTJ/NTiQNOl+i6BzMe9kLbdPlNLjnye+ekJ/4Gz0NXXkE2Ni+zM7hHY6pBeQnfQ=
X-Gm-Gg: AR+sD12+vOVvfs5cAJHYUfaqVEfKKPgTm7yiUNCfnewMd4cQalFCuL4UvYSfPVhVaD4
	uJs0r3SxQbNYGmxZfCoRvgzJ0STgALtR6ncUC0yNusUGtaxE4ySKUrh0sL0fd/3Xati8oNCCdju
	zsQe5GIHwZZ121+OxNgfHPLpH0dVD06LiXpHj1ngmSUc8f9kGxguNYhFAHQT8wbRuad5a+9hTjn
	mouG31JRgt3EA51fseIiM9Rma9rkL0H1a98o5nmJUd+PeCO591USqHblFj+SldFmpboupYBmZyA
	Pv3vgJH4diwAMMZACTZ0MHc3J8kUMspwZD1JEFbd1kL94+rABsnMWu8dpZXypDtUElWRsrgAe5p
	E1eg55iNMb9ycz8k4+L0eFFGSnS/rircRmqkrY9GFDMfZusepVGiATpeZFURs5PBc43sAzuovka
	1oLHCtX6ULKgNw5Krzd9kHNPQJ1WYvhNULGMgW9IuwtqCBZNlynybbrNLU4Ybjb7GqBWh2p+kOm
	m0h
X-Received: by 2002:a05:6402:5410:b0:6a1:da7a:917b with SMTP id 4fb4d7f45d1cf-6a375f7eff5mr2589534a12.20.1786544818890;
        Wed, 12 Aug 2026 07:26:58 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a376a0fb5csm817831a12.24.2026.08.12.07.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 07:26:58 -0700 (PDT)
Message-ID: <6ddc4d8d-b2f0-4df5-962c-f945e8fbf8f6@linaro.org>
Date: Wed, 12 Aug 2026 15:26:56 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] perf cs-etm: Add branch history to existing samples
To: Amir Ayupov <aaupov@fb.com>
Cc: linux-doc@vger.kernel.org, Mike Leach <mike.leach@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
References: <20260803090202.2324641-1-aaupov@fb.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260803090202.2324641-1-aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/08/2026 10:01, Amir Ayupov wrote:
> This series implements --itrace=L for Arm CoreSight ETM: decoded branch

Hi Amir,

How did you send this? The cover letter seems to be on a different 
thread to the patches.

> history is attached to the PMU samples already present in the recording,
> rather than to synthesised instruction samples.
> 
> The motivating use case is context-sensitive PGO, which wants a callchain
> and a branch stack describing the same point in time. Recording a cycles
> event with call-graph=fp and aux-action=pause supplies the callchain, and
> the ETM trace leading up to that sample supplies the branch stack, without
> having to trace a long-running process continuously.
> 
> Intel PT has had this since commit f0a0251cee80 ("perf intel-pt: Add
> support for synthesizing branch stacks for regular events"), so this
> deliberately follows intel-pt: the same --itrace=L option and the same
> thread_stack__br_sample_late() call.
> 
> Patches 1 to 4 are independent fixes and infrastructure the feature needs:
> 
>    1  makes an inconsistent HEADER_GROUP_DESC non-fatal. AUX recordings
>       using aux-action pause/resume produce a group descriptor the strict
>       reader rejects, which makes an otherwise readable perf.data
>       unreadable, so without this the recipe in patch 9 cannot be decoded
>       at all. Useful on its own.
>    2  reports hw_idx as -1 rather than 0 in reconstructed branch stacks,
>       since they have no hardware index.
>    3  bounds a wrapped memcpy in thread_stack__br_sample(). Latent today,
>       reachable once a caller keeps a ring larger than the requested output
>       depth.
>    4  adds a dlfilter that drops samples with an empty branch stack.
> 
> Patch 5 is a no-functional-change refactor splitting
> cs_etm__process_timestamped_queues() into its three parts. Heap seeding
> moves to cs_etm__update_queues(), gated on queues.new_data and mirroring
> intel_pt_update_queues(); the end-of-session flush moves to
> cs_etm__flush_timestamped_queues(); and the decode loop is left on its own
> so patch 6 can drive it once per sample. Neither seeding nor flushing can
> be repeated, which is why they have to come out first. The moved code is
> unchanged, so both loops appear as context in the diff.
> 
> Patch 6 is the feature and patch 7 adds a shell test.
> 
> Patch 8 is where review attention is most useful. --itrace=L attaches
> whatever the thread stack holds when a sample is processed. With a duty
> cycled trace most samples fire while the trace is off; they have nothing
> newly decoded, but the thread stack still holds the previous window, so
> they were being given branches that ran an arbitrary amount of time
> earlier. On a 12 s capture with pause period 100003 and resume period
> 8350251, of 335291 samples that received branch history only 3371 were
> backed by trace decoded for that sample.
> 
> A trace window belongs to exactly one sample, and with AUX pause and
> resume the sample is what stops the trace, so the pairing is one to one by

What happens when aux-pause isn't used and there isn't a 1:1 pairing? 
There is a lot of description of that which implies that it doesn't work 
if there isn't. But as far as I can tell it works just as well by using 
the timestamps?

> construction. Patch 8 therefore takes the branch history when attaching it
> instead of copying it, and a later sample with nothing newly decoded finds
> an empty branch stack, which the dlfilter removes.
> thread_stack__br_sample() is unchanged, so lowercase --itrace=l keeps the
> overlapping branch stacks it produces today.
> 
> Patch 9 documents the workflow.
> 
> Because the sample is what stops the trace, the history attached to it
> lines up well with the callchain: on a brstack capture the leaf of the
> callchain matched the function containing the newest branch stack entry's
> target for 93.5% of attached samples. The residual comes from the decode
> loop stopping on interpolated timestamps, so a few branches that ran just
> after the sample can still be included. Trimming those with the sample ip
> raises it to 96.8%, but that matters far more for free-running ETM
> strobing than for pause and resume, so I have left it out of this series
> and will send it separately.
> 
> Patch 8 could be squashed into patch 6, since patch 6 on its own produces
> mostly stale history. I kept them apart so the decode mechanism and the
> attachment policy can be reviewed separately, but I am happy to fold them.
> 
> Testing
> -------
> 
> Built with:
> 
>    make -C tools/perf NO_LIBELF=1 NO_LIBTRACEEVENT=1 CORESIGHT=1
> 
> Every patch builds individually. checkpatch reports only "does MAINTAINERS
> need updating?" for the two new files and "quoted string split across
> lines" for the dlfilter description string, which matches how
> dlfilter-show-cycles.c already writes it.
> 
> Tested on Arm Neoverse V2 with CoreSight ETM:
> 
>    - perf test "CoreSight branch history on existing samples": Ok, 3 for 3
>    - captures from 5 MiB to 2.5 GiB decoded with --itrace=L64, no decode
>      errors
>    - the other CoreSight tests are unchanged by this series; four of them
>      fail identically at the base commit on this machine

Can you report or investigate these failures please. None of the tests 
should be failing on TRBE hardware, at least on the latest 
perf-tools-next branch. You can try applying "[PATCH 00/14] perf cs-etm: 
Per-thread mode fixes and snapshot wrap support" to be sure, but I don't 
think that fixes any current failures.

> 
> Amir Ayupov (9):
>    perf header: Tolerate inconsistent HEADER_GROUP_DESC
>    perf thread-stack: Report branch stack hw_idx as not available
>    perf thread-stack: Bound wrapped branch stack copy
>    perf dlfilter: Add non-empty branch stack filter
>    perf cs-etm: Split up cs_etm__process_timestamped_queues()
>    perf cs-etm: Add branch history to existing samples
>    perf test cs-etm: Test branch history on existing samples
>    perf cs-etm: Consume branch history when attaching it to a sample
>    Documentation: coresight: Document context-sensitive PGO workflow
> 
>   .../trace/coresight/coresight-perf.rst        |  62 +++++
>   tools/perf/Makefile.perf                      |   1 +
>   .../dlfilters/dlfilter-nonempty-brstack.c     |  26 ++
>   .../tests/shell/coresight/add_last_branch.sh  | 175 +++++++++++++
>   tools/perf/util/cs-etm.c                      | 242 ++++++++++++++++--
>   tools/perf/util/header.c                      |  42 ++-
>   tools/perf/util/thread-stack.c                |  21 +-
>   tools/perf/util/thread-stack.h                |   1 +
>   8 files changed, 544 insertions(+), 26 deletions(-)
>   create mode 100644 tools/perf/dlfilters/dlfilter-nonempty-brstack.c
>   create mode 100755 tools/perf/tests/shell/coresight/add_last_branch.sh
> 
> 
> base-commit: da85966dfd23a3b03e00ee3bce6ad301f0a2b229

