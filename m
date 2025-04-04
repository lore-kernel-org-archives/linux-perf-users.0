Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3028E8;
	Fri,  4 Apr 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775772; cv=none; b=VItF61+DSOnLM0AzXo4afGqi62EjOMvbiAYvD1MM6gNvS0prkMjfJzcAUeiYoB239MUfjlvkaXgatTsBp7AJKrbluUSVBPdD+JlrgsYAOkvEMMazuVkEcuOEsIg0jb40TpbutjVW40aWOKNZCqhtNpDCFroQEclzceNyqTrVg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775772; c=relaxed/simple;
	bh=7vkatnzzxhhVFbD4HxLrh/KjbSJzy28SNpvsJYk/8oM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S1iRFfvZa2Uf91lkNj77jVv3hTlZ+bU5n5K1ZsEJGcoNRMgasnK4RUHpR1ztLhT2iF/BbYDq4Ef6S6fow6eKVjaHyJdeO6KjyGkcY/xsi3fXAvUq2Wwh9s85iFQVX82LYicvu0lvNsMExkN1RZoDL154Psvb11nw9rsKJsGwcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6kk7GVy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6kk7GVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743775771; x=1775311771;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=7vkatnzzxhhVFbD4HxLrh/KjbSJzy28SNpvsJYk/8oM=;
  b=m6kk7GVywsxUTuy8/ypS/ZLA3XODO/YPN061DVJySXVgbA+fs+mw0oz/
   kcradNcEB0KxGIrBj80m0ljttrGkEiIbOJ4AFN/TYxTyPK99EHKKsS0UB
   2/vo/Cxg/QipJ/Ib5Th36ixs7tHdmFs4az4p8qmFs+ikT2jYu1oQo2eu0
   HjA3HfS7/clT99hQXFwSsidZqNySTxrk8yKXZtU3XF5AXZgtLbBtwmJlo
   7dorC7ORm2+osMl3mA6jGddVojCw1b5P4LtTgQ3c96wR/8CgbjPxcT2Wj
   TnMtOKMpzgBdyg7BfSHhLkwKN9bzTdfhK4c/krJozgKxr7yKm19MBvhwf
   g==;
X-CSE-ConnectionGUID: lEmXnVm9TLCDG7/xy6O7/A==
X-CSE-MsgGUID: sp6jpCHvTi6rLAtooiFf/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="45389891"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="45389891"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:09:30 -0700
X-CSE-ConnectionGUID: 0qZXDAKJT0y/buDtFmkciQ==
X-CSE-MsgGUID: PO7ncICxSzGAixNyMY1Wxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="158308246"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 07:09:30 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 10E0120B5736;
	Fri,  4 Apr 2025 07:09:27 -0700 (PDT)
Message-ID: <c21d05c6-d71c-47e3-b4a2-e275d9d487f2@linux.intel.com>
Date: Fri, 4 Apr 2025 10:09:27 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Add support for cpu event term
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250403194337.40202-1-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250403194337.40202-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-03 3:43 p.m., Ian Rogers wrote:
> Being able to set the cpu mask per event was discussed in the context
> of a sysfs event.cpus file is discussed here:
> https://lore.kernel.org/lkml/CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com/
> Ultimately Kan preferred to have multiple PMUs with a cpumask each
> rather than an event.cpus file per event. It is still useful to have
> the cpu event term and so the sysfs part of the original patch series
> is dropped.
> 
> v6: Purely a rebase.
> v5: Purely a rebase.
> v4: Add the stat-display output change for zero counters Namhyung
>     requested as part of the series:
>     https://lore.kernel.org/lkml/Zvx9VbJWtmkcuSBs@google.com/
>     This skips zero values for CPUs not in the evsel's cpumask rather
>     than the evsel's PMU's cpumask.
> v3: Drop sysfs event.cpus file support patch from series.  Reference
>     to using cpu to modify uncore events is dropped from the commit
>     message. Reference counting issues on the cpumap are addressed.
> v2: Add support for multiple cpu terms on an event that are
>     merged. For example, an event of "l1d-misses/cpu=4,cpu=5/" will
>     now be opened on both CPU 4 and 5 rather than just CPU 4.
> 
> Ian Rogers (4):
>   libperf cpumap: Add ability to create CPU from a single CPU number
>   perf stat: Use counter cpumask to skip zero values
>   perf parse-events: Set is_pmu_core for legacy hardware events
>   perf parse-events: Add "cpu" term to set the CPU an event is recorded
>     on

Tried on a Hybrid platform. Everything looks good.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan>
>  tools/lib/perf/cpumap.c                |  10 +++
>  tools/lib/perf/include/perf/cpumap.h   |   2 +
>  tools/perf/Documentation/perf-list.txt |   9 ++
>  tools/perf/util/evsel_config.h         |   1 +
>  tools/perf/util/parse-events.c         | 113 ++++++++++++++++++-------
>  tools/perf/util/parse-events.h         |   3 +-
>  tools/perf/util/parse-events.l         |   1 +
>  tools/perf/util/pmu.c                  |   3 +-
>  tools/perf/util/stat-display.c         |  21 +++--
>  9 files changed, 124 insertions(+), 39 deletions(-)
> 

