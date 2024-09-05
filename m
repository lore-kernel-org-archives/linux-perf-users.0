Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE6A14F125;
	Thu,  5 Sep 2024 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560461; cv=none; b=gfgNFLmZGF+P2ah6gBlBrTCc0e+ei4IBpyuc0cTACWhvsJrQHjbvnvGQLR410nnZ/TQZQ2a8NquNHPUmf6MNiBYMT4jXm2svz+6mFjJr1WRbmzI/YUHheoRXEBKjen6E/2oMf9iZ/V6aDuEkvFgLnnkG8fg/B1/CdaukKF3OtJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560461; c=relaxed/simple;
	bh=sAaNMpjYEVtaipe7cxOC1fk/2BscWhTf7K/dUab3xZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTisLqSf9qfR+k10Y1SYiGvnawgra9Ez/gwDTdR9OypJaXjUtmtgp+3v3XHBcwqirPy5oWDaR/TB5QkvTVyen2r8tNPEByCTqzTs+qZeWLM7y9hlckfiDqzAof4MHBUamu58w9a0JXPI1aFzVku/SGumwcKOPIK7TPzDOp693ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvRB4Yxq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvRB4Yxq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725560459; x=1757096459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sAaNMpjYEVtaipe7cxOC1fk/2BscWhTf7K/dUab3xZA=;
  b=bvRB4YxqdJLB2gNA16Diw5+6FuYMxhfIzuXb6vIE9wnLwKpQbgrz64Qb
   Uaml7MZKKGaySYLk52lCNMOPmHwIzN8zlFhq7vlatWBjlYryxCTFKYPLh
   T50u6kAWNOjcDgyP8l7qAYWefcCsQlKB1tohCawZWX1JU87OxYDucC0lv
   pqrPswd02XrA6XdswlcbDQfUXPjYRyLJfSj/fct9OTUhV+k6SsOfaD+P0
   6t3t9XeqFM3EowBSDrMCu1MRdAdoI1tVfAOW87E5zB63o1HLrAHN7I7aM
   qlBt5j5A7hkMfVqRCdcm7ZgihblmXvxMp1/XfCv7dfUySnQpHgWDSyquu
   g==;
X-CSE-ConnectionGUID: ogZ8+25tR1+74k9bE40aPA==
X-CSE-MsgGUID: jk2HOrMQRAipaaL8M2RJpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24462457"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24462457"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 11:20:58 -0700
X-CSE-ConnectionGUID: ccz7nhLrTcWKBer3/jrz9Q==
X-CSE-MsgGUID: G3hfyiG+S7S7AVc+XMMWcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70511047"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 11:20:58 -0700
Received: from [10.212.68.73] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1BADA20B5782;
	Thu,  5 Sep 2024 11:20:55 -0700 (PDT)
Message-ID: <8133d432-7674-4d07-bbb5-4131fe5d474e@linux.intel.com>
Date: Thu, 5 Sep 2024 14:20:54 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Event parsing fixes
To: James Clark <james.clark@linaro.org>, irogers@google.com,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, namhyung@kernel.org
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Yang Jihong <yangjihong@bytedance.com>,
 Colin Ian King <colin.i.king@gmail.com>, Howard Chu <howardchu95@gmail.com>,
 Ze Gao <zegao2021@gmail.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Yicong Yang
 <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240903102005.78049-1-james.clark@linaro.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240903102005.78049-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-09-03 6:19 a.m., James Clark wrote:
> I rebased this one and made some other fixes so that I could test it,
> so I thought I'd repost it here in case it's helpful. I also added a
> new test.
> 
> But for the testing it all looks ok.
> 
> There is one small difference where it now hides _all_ default
> <not supported> events, when previously it would only hide some
> selected subset of events like "stalled-cycles-frontend". I think
> this is now more consistent across platforms because, for example,
> Apple M only has cycles and instructions, and the rest of the
> default events would always show as <not supported> there.
> 
> Tested on Raptor Lake, Kaby Lake, Juno, N1, Ampere (with the DSU
> cycles PMU) and I also faked an Apple M on Juno. 
>

The tui mode in perf report is broken on Intel hybrid machine.

$perf record -e cycles,instructions sleep 1
$perf report

Without the patch set, in the tui mode,
Available samples
7 cpu_atom/cycles/
                                     ◆
0 cpu_core/cycles/
                                     ▒
7 cpu_atom/instructions/
                                     ▒
0 cpu_core/instructions/
                                     ▒
0 dummy:u

After applying the patch set,
Available samples
7 /cycles/
                                     ◆
0 /cycles/
                                     ▒
7 /instructions/
                                     ▒
0 /instructions/
                                     ▒
0 dummy:u


It looks something wrong with the uniquify_event_name().

Thanks,
Kan


> Changes since v5:
>   * Test on x86 non hybrid
>   * Assume 1 PMU in the test when no PMUs expose /cpus file
> 
> Changes since v4:
> 
>   * Hide all <not supported> default events when not verbose
>   * Remove previous note about <not supported> behavior from the cover
>     letter and replace it with a new note about the new behavior
>  
> Changes since v3:
> 
>   * Rebase onto perf-tools-next 6236ebe07
>   * Fix Intel TPEBS counting mode test
>   * Fix arm-spe build
>   * Add support for DT devices in stat test
>   * Add a new test for hybrid perf stat default arguments
> 
> Ian Rogers (5):
>   perf evsel: Add alternate_hw_config and use in evsel__match
>   perf stat: Uniquify event name improvements
>   perf stat: Remove evlist__add_default_attrs use strings
>   perf evsel x86: Make evsel__has_perf_metrics work for legacy events
>   perf evsel: Remove pmu_name
> 
> James Clark (2):
>   perf test: Make stat test work on DT devices
>   perf test: Add a test for default perf stat command
> 
>  tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
>  tools/perf/arch/x86/util/evlist.c             |  74 +----
>  tools/perf/arch/x86/util/evsel.c              |  35 ++-
>  tools/perf/builtin-diff.c                     |   6 +-
>  tools/perf/builtin-stat.c                     | 291 +++++++-----------
>  tools/perf/tests/parse-events.c               |   2 +-
>  tools/perf/tests/shell/stat.sh                |  37 ++-
>  .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
>  tools/perf/util/evlist.c                      |  46 +--
>  tools/perf/util/evlist.h                      |  12 -
>  tools/perf/util/evsel.c                       |  28 +-
>  tools/perf/util/evsel.h                       |  22 +-
>  tools/perf/util/metricgroup.c                 |   4 +-
>  tools/perf/util/parse-events.c                |  58 ++--
>  tools/perf/util/parse-events.h                |   8 +-
>  tools/perf/util/parse-events.y                |   2 +-
>  tools/perf/util/pmu.c                         |   6 +-
>  tools/perf/util/pmu.h                         |   2 +-
>  tools/perf/util/stat-display.c                | 109 +++++--
>  tools/perf/util/stat-shadow.c                 |  14 +-
>  tools/perf/util/stat.c                        |   2 +-
>  21 files changed, 360 insertions(+), 413 deletions(-)
> 
