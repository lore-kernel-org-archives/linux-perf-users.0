Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074236;
	b=osJy3ZYd8I8/eSGnnXqEV71ivXkUWU5pwZ9rgaxtD0PCTbxjRvY824vt9ab7l+Bk3l/u
	 0yPRy7ti/OZHTITfb/1BfScJpwwOJdmOeHOAWLPh60Oc21iPkFlFeJ5Ba/fjqq9c10z1i
	 7+nGBsjOoFtW+ZSlYctYK2VP8cKN1Ysi2EAiJhac9t690TJZKpsodgBXjyHkm/sR0L8m2
	 /wk0OQNwUz3c/ph7veO9uwnskI2XQOPDlzTXkiQu+XOYNH6AZoSf4us4EDn+fU/REnods
	 DuDRSCNKoCIdfbOlbE9AlpNT1UU93mEVwAryGiPPclj+F3/xSVhdajekDB7YV01c/nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074236;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8FkPMm8rF8ZFx84odGAqDv9IDjhsuzQ/z5I+PB7yuHI=;
	b=t47Rr7nYiQsbuU4P4SJ2UROE0BTH++xkyoonGc4yHH76mo7szAjEwg3IuMVv0gMFhxCI
	 R6JVPh3ybYoSRkuy5bsfuEwyWNfypcWDXkkcVL2ChsIrMvP0qG1XIYX8aF41jQs9kx3wd
	 9Ze3WKVDetQkYWcccUwmbvk57mb3QeQsAi5Ci1WZWIx6VbY1r0/POkGeUVnWijOrLCS7B
	 Bbo6CTAlp+g46Uc9sfPP5uqJ4n8wp0eZmt4C64ttEKusZEaTelG94e6lmhta+Q9kmDBwy
	 YW/o9u541mrOD4qS1H9HyChyNvCbZ4ocYAPXjRh0/WW50eG5VbWBOu6YCNyA73L9PKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JJUqchD1;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5B8606A320;
	Thu, 19 Nov 2026 07:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A5B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JJUqchD1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11B201575;
	Wed, 18 Nov 2026 23:43:50 -0800 (PST)
Received: from [10.163.128.149] (unknown [10.163.128.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A094A3F632;
	Wed, 18 Nov 2026 23:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795074233; bh=X21bhGGZD8X5RAtJHVriRlnyNhSzwZT2US3wIrNogJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JJUqchD1Fd73gIyhfeuIqoUN0vNRYLT6qszuMS3Q2VC2ncRndcjEJDLhpi4arOIbA
	 wsG/d4TixOclhA5lbOomw8wxApGoU6FNUGthZxsGcMXwBc9v7Dh+9QREb2kEXboGW8
	 IxcPSWECCsSGIbxhLH7ESOtA/NYifJw/+e92yeYs=
Message-ID: <5909a504-0534-4f6a-8925-bb18f24eca0e@arm.com>
Date: Thu, 19 Nov 2026 13:13:23 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "perf/aux: Allocate non-contiguous AUX pages by
 default"
To: Leo Yan <leo.yan@arm.com>
Cc: Yabin Cui <yabinc@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Michiel van Tol <michiel.vantol@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
 <57c34e26-3048-474d-8e74-f65799e32ff4@arm.com>
 <CALJ9ZPNWcDtajO+Luhxe1K3af64mPRFQSjvfvNornyFFkam-+g@mail.gmail.com>
 <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
 <307b4d48-00f2-40dc-bf3f-ffa0f2f58d33@arm.com>
 <20261118165702.GX9176@e132581.arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261118165702.GX9176@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/11/26 10:27 pm, Leo Yan wrote:
> On Sun, Nov 15, 2026 at 08:32:16PM +0530, Dev Jain wrote:
> 
> [...]
> 
>>> 1. Make opportunistic high-order AUX allocations no-reclaim:
>>>    When !(event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) and
>>>    order > 0, clear __GFP_RECLAIM (and add __GFP_NOMEMALLOC, matching
>>>    SLUB's allocate_slab() and GFP_TRANSHUGE_LIGHT):
>>>
>>>      gfp_t gfp = PERF_AUX_GFP;
>>>
>>>      if (order && !has_no_sg)
>>>              gfp = (PERF_AUX_GFP | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
>>
>> Thanks for your reply.
>>
>> This looks like the correct solution. Note commit 0e05a469c294
>> ("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY allocations")
>> post which the regression you report should reduce drastically. It only
>> removes GFP_DIRECT_RECLAIM flag, I assume you are seeing latency even
>> due to reclaim/compaction daemon wakeups.
>>
>> So instead of enhancing this commit even more by making a page-allocator
>> change, I would rather make your proposed change on the perf side to
>> keep it simple. This should completely solve the problem.
> 
> Thanks a lot, Dev!
> 
> The revert (526d945ad9c0) and 0e05a469c294 are now in mainline. My tests
> show significantly lower PSI on v7.4-rc3, consistent with the expected
> benefit of 0e05a469c294.
> 
> The following PSI some values are totals in milliseconds across runs
> 2-10 (nine runs), excluding the first run of each case to avoid
> glitches caused by its proximity to lauching the pressure workload:
> 
>   Memory usage    v7.4-rc1    v7.4-rc3    rc3 + perf patch [1]
>   90%                0.000       0.000               0.000
>   95%               21.781       0.000               2.061
>   100%              27.946       0.000               0.000
> 
> My perf patch [1] reduces pageoutrun and compact_daemon_wake, but
> increases pgscan_kswapd at 95%. The following totals compare v7.4-rc3

Exactly what I expected. I would say to not complicate with GFP_RETRY_MAYFAIL
and keep it simple.


> and v7.4-rc + my patch, also across runs 2-10:
> 
>   Usage    pageoutrun    compact_daemon_wake    pgscan_kswapd
>   90%        58 -> 0               57 -> 0       1,932 -> 0
>   95%         3 -> 2                2 -> 1       9,664 -> 148,079
>   100%       40 -> 1               40 -> 0      11,616 -> 1,918
> 
> I would wait for Yabin's testing before deciding whether to proceed
> with the additional perf changes. In my patch, changing order 0 to
> __GFP_RETRY_MAYFAIL needs care: it may reduce allocation failures when
> free memory is scarce, at the cost of longer reclaim stalls and
> higher PSI.
> 
> Yabin, could you test the current mainline (or backport
> 526d945ad9c0/0e05a469c294) and confirm whether it resolves the PSI issue
> on Android? If still see the reclaim pressure or observe AUX allocation
> failures, it may also be worth testing patch [1].
> 
> Thanks,
> Leo
> 
> [1] https://lore.kernel.org/lkml/20261109-perf_aux_alloc_optimize_psi-v1-1-d56ac4bf3ef5@arm.com/

