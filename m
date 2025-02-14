Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2444A33;
	Fri, 14 Feb 2025 01:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495567; cv=none; b=s6i1tyQLZYEZvV4HvdTuvucOdl91yczPINRAwY2ONFd8/ADmJ3hFMrZHmM/iATtDxYXhmT5legMlToNHC7gHdVIqpmHx9L0S5PUXybbGcw/O7+bO96sMA1zofjUDV4Cd/afEvsMhSbkaWunraVp5wLj3UySN1BzLkUcjaEngtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495567; c=relaxed/simple;
	bh=Uf7KzL9WUh6ptAfCWAiZd4xZ1TBn2O4qJ3v/t3unK2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEq73uI+nkFKVSovQXUOxEK1/UVqI4q2Sp3PBO2u6zgvMlP57G/TuVACZc8zcolo6LdObx2+ZmBLSF94P7pH9gqS6cD3yF3UEf60sqaREoa9/59OwbF6iobVTjAEhNhy0PBWDhVLnVI31OksNkLgApLxWBJHinh+s2FEmx/w76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF+90VtC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF+90VtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEEAC4CED1;
	Fri, 14 Feb 2025 01:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739495567;
	bh=Uf7KzL9WUh6ptAfCWAiZd4xZ1TBn2O4qJ3v/t3unK2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QF+90VtCu0Qy9Qs11LfnFFmM+c4AZXwaPi+22mYhA5cpsTMFj5jtbda7Oyvm4hg1w
	 4gzE3zvARRvK6BWpsxVdy9d4ibrbM0h2UYeUi9LZyK6p10uhjqvaT0PuDz0C4snJfY
	 Yeiy0QyMed5OTa1oogyOr3vr/nwrCroNp0jhnfTMGPINL1TvKXt0VL72U0jT32QkUA
	 FNsUgdbJsT95jecGOYRkHm1M17aR86xiVctJZk6aNgdJsdHQSw5i0nEehwCYRd0Ko5
	 MOtoSGT99m/dTlVghcDfFF6F7torCq1ALgTySN52JkHyeYeJgwyo1dOasPEBJDPO79
	 Jdjp12k8LOcBQ==
Date: Thu, 13 Feb 2025 17:12:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520
 events/metrics
Message-ID: <Z66YjGvjD_yzEHUg@google.com>
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>

Hello,

On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
> This patchset adds the perf JSON files for the Cortex-A720 and Cortex-A520
> processors. Some events have been tested on Raxda Orion 6 with Cix P1 SoC
> (8xA720 + 4xA520) running mainline Kernel with ACPI mode.

I'm curious how the name of PMUs look like.  It is cortex_a720 (or a520)?
I remember there's a logic to check the length of hex digits at the end.

Ian, are you ok with this?

Thanks,
Namhyung

> 
> Yangyu Chen (2):
>   perf vendor events arm64: Add Cortex-A720 events/metrics
>   perf vendor events arm64: Add Cortex-A520 events/metrics
> 
>  .../arch/arm64/arm/cortex-a520/bus.json       |  26 ++
>  .../arch/arm64/arm/cortex-a520/exception.json |  18 +
>  .../arm64/arm/cortex-a520/fp_operation.json   |  14 +
>  .../arch/arm64/arm/cortex-a520/general.json   |   6 +
>  .../arch/arm64/arm/cortex-a520/l1d_cache.json |  50 ++
>  .../arch/arm64/arm/cortex-a520/l1i_cache.json |  14 +
>  .../arch/arm64/arm/cortex-a520/l2_cache.json  |  46 ++
>  .../arch/arm64/arm/cortex-a520/l3_cache.json  |  21 +
>  .../arch/arm64/arm/cortex-a520/ll_cache.json  |  10 +
>  .../arch/arm64/arm/cortex-a520/memory.json    |  58 +++
>  .../arch/arm64/arm/cortex-a520/metrics.json   | 373 +++++++++++++++
>  .../arch/arm64/arm/cortex-a520/pmu.json       |   8 +
>  .../arch/arm64/arm/cortex-a520/retired.json   |  90 ++++
>  .../arm64/arm/cortex-a520/spec_operation.json |  70 +++
>  .../arch/arm64/arm/cortex-a520/stall.json     |  82 ++++
>  .../arch/arm64/arm/cortex-a520/sve.json       |  22 +
>  .../arch/arm64/arm/cortex-a520/tlb.json       |  78 ++++
>  .../arch/arm64/arm/cortex-a520/trace.json     |  32 ++
>  .../arch/arm64/arm/cortex-a720/bus.json       |  18 +
>  .../arch/arm64/arm/cortex-a720/exception.json |  62 +++
>  .../arm64/arm/cortex-a720/fp_operation.json   |  22 +
>  .../arch/arm64/arm/cortex-a720/general.json   |  10 +
>  .../arch/arm64/arm/cortex-a720/l1d_cache.json |  50 ++
>  .../arch/arm64/arm/cortex-a720/l1i_cache.json |  14 +
>  .../arch/arm64/arm/cortex-a720/l2_cache.json  |  62 +++
>  .../arch/arm64/arm/cortex-a720/l3_cache.json  |  22 +
>  .../arch/arm64/arm/cortex-a720/ll_cache.json  |  10 +
>  .../arch/arm64/arm/cortex-a720/memory.json    |  54 +++
>  .../arch/arm64/arm/cortex-a720/metrics.json   | 436 ++++++++++++++++++
>  .../arch/arm64/arm/cortex-a720/pmu.json       |   8 +
>  .../arch/arm64/arm/cortex-a720/retired.json   |  90 ++++
>  .../arch/arm64/arm/cortex-a720/spe.json       |  42 ++
>  .../arm64/arm/cortex-a720/spec_operation.json |  90 ++++
>  .../arch/arm64/arm/cortex-a720/stall.json     |  82 ++++
>  .../arch/arm64/arm/cortex-a720/sve.json       |  50 ++
>  .../arch/arm64/arm/cortex-a720/tlb.json       |  74 +++
>  .../arch/arm64/arm/cortex-a720/trace.json     |  32 ++
>  .../arch/arm64/common-and-microarch.json      |  15 +
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
>  39 files changed, 2263 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json
> 
> -- 
> 2.47.2
> 
