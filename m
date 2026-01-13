Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFC36C0A6;
	Tue, 13 Jan 2026 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336030; cv=none; b=YM4QAAWVUkFLDOWGGymDTfbvz8JJTbfO/ZYAZf49FUC2KugYfiVeciFMLRxKbSMIX7iinMW/50RF2YqNV2aDh56T9h9+eY0j4lwxYhnG5VCxfRWr460xpOhFnccBRx1L/kHsbxzMvkTcfd+sw63MnM1ToaO0f87jFAnLWhM6acg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336030; c=relaxed/simple;
	bh=Rr8viVgJiZM8PZMwHl307NoWUBa1R2QQMXlkK9wrEhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2TvWk0Ll85BrHK6jiRvAJBNXtb3iArtwoyNisxGI6fFuQQjLIpTg5gKNY56LtYgahVLI7pqCDNB9ylS4As/FkeVINeJPMbdOWb1r5etlaBN7IudXeCD0WUdpJbODWGl4KaSXVr3BC3jWSc9rt1c1t8hdai6sdNRJOLErLRaSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJhA0QMs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJhA0QMs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2653AC116C6;
	Tue, 13 Jan 2026 20:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768336029;
	bh=Rr8viVgJiZM8PZMwHl307NoWUBa1R2QQMXlkK9wrEhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJhA0QMsqsVosTdTQ79NgJjomygEnvlGMgTxB0XVnQBVZXwR48zmljrOTad93zi04
	 4V5So7ctswyYas1yyA2W+n315bQwKekFnT7uH7P0L1ztdFiimw0d+GQWhYMOmkvOl2
	 ua5Ysm1405J4Szbbf/2ISk/3OJddXESoB2PCPp4ksggMLpH/N49tqwI56FjU3I4PJd
	 3LMgRZgNrqtEY/TdpNvaxv+Tx7XMx4nYQyb98uvJZ9vjILsMEyPg4B3A4VLQjiKIRd
	 muds+qqG2WvnSg90NQ7ezGVM/LuXgdi4RZ4F/160Z6bb4MUYZLflclMt+akaVOumh2
	 6elFqygCdblzg==
Date: Tue, 13 Jan 2026 17:27:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Subject: Re: [PATCH 2/4] perf vendor events amd: Add Zen 6 uncore events
Message-ID: <aWaqmlLZ9NGpY6Ys@x1>
References: <cover.1767858676.git.sandipan.das@amd.com>
 <b00e27727d8aea8cf49c5e6e08b29357d04bc2b8.1767858676.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b00e27727d8aea8cf49c5e6e08b29357d04bc2b8.1767858676.git.sandipan.das@amd.com>

On Thu, Jan 08, 2026 at 01:22:15PM +0530, Sandipan Das wrote:
> Add uncore events taken from Section 1.6 "L3 Cache Performance Monitor
> Counters" and Section 2.2 "UMC Performance Monitor Events" of the
> Performance Monitor Counters for AMD Family 1Ah Model 50h-57h Processors
> document available at the link below.
> 
> This constitutes events which capture L3 cache and UMC command activity.

  LD      /tmp/build/perf-tools-next/perf-util-in.o
  AR      /tmp/build/perf-tools-next/libperf-util.a
  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:30902:37: error: ‘pmu_events__amdzen6’ defined but not used [-Werror=unused-const-variable=]
30902 | static const struct pmu_table_entry pmu_events__amdzen6[] = {
      |                                     ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [pmu-events/Build:89: /tmp/build/perf-tools-next/pmu-events/pmu-events.o] Error 1
make[2]: *** [Makefile.perf:772: /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o] Error 2
make[1]: *** [Makefile.perf:288: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$

When building at this patch (2/4) it breaks, lemme see if at the end it
works, but even then this can't stand this way, as we break bisection...

Then, on 3/4 we get:

  CC      /tmp/build/perf-tools-next/pmu-events/pmu-events.o
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:30992:37: error: ‘pmu_metrics__amdzen6’ defined but not used [-Werror=unused-const-variable=]
30992 | static const struct pmu_table_entry pmu_metrics__amdzen6[] = {
      |                                     ^~~~~~~~~~~~~~~~~~~~
/tmp/build/perf-tools-next/pmu-events/pmu-events.c:30908:37: error: ‘pmu_events__amdzen6’ defined but not used [-Werror=unused-const-variable=]
30908 | static const struct pmu_table_entry pmu_events__amdzen6[] = {
      |                                     ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [pmu-events/Build:89: /tmp/build/perf-tools-next/pmu-events/pmu-events.o] Error 1
make[2]: *** [Makefile.perf:772: /tmp/build/perf-tools-next/pmu-events/pmu-events-in.o] Error 2
make[1]: *** [Makefile.perf:288: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbx perf-tools-next]$

Finally, on 4/4 everything builds.

Can you please take a look to check how we can keep all bisection happy?

- Arnaldo
 
> Link: https://bugzilla.kernel.org/attachment.cgi?id=309149
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  .../pmu-events/arch/x86/amdzen6/l3-cache.json | 177 ++++++++++++++++++
>  .../arch/x86/amdzen6/memory-controller.json   | 101 ++++++++++
>  2 files changed, 278 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json
> 
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json b/tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
> new file mode 100644
> index 000000000000..9b9804317da7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
> @@ -0,0 +1,177 @@
> +[
> +  {
> +    "EventName": "l3_lookup_state.l3_miss",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 cache misses.",
> +    "UMask": "0x01",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_lookup_state.l3_hit",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 cache hits.",
> +    "UMask": "0xfe",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_lookup_state.all_coherent_accesses_to_l3",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 cache requests for all coherent accesses.",
> +    "UMask": "0xff",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency.dram_near",
> +    "EventCode": "0xac",
> +    "BriefDescription": "Average sampled latency for L3 requests where data is returned from DRAM in the same NUMA node.",
> +    "UMask": "0x01",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency.dram_far",
> +    "EventCode": "0xac",
> +    "BriefDescription": "Average sampled latency for L3 requests where data is returned from DRAM in a different NUMA node.",
> +    "UMask": "0x02",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency.near_cache",
> +    "EventCode": "0xac",
> +    "BriefDescription": "Average sampled latency for L3 requests where data is returned from cache of another CCX in the same NUMA node.",
> +    "UMask": "0x04",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency.far_cache",
> +    "EventCode": "0xac",
> +    "BriefDescription": "Average sampled latency for L3 requests where data is returned from cache of another CCX in a different NUMA node.",
> +    "UMask": "0x08",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency.ext_near",
> +    "EventCode": "0xac",
> +    "BriefDescription": "Average sampled latency for L3 requests where data is returned from extension memory (CXL) in the same NUMA node.",
> +    "UMask": "0x10",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency.ext_far",
> +    "EventCode": "0xac",
> +    "BriefDescription": "Average sampled latency for L3 requests where data is returned from extension memory (CXL) in a different NUMA node.",
> +    "UMask": "0x20",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency.all",
> +    "EventCode": "0xac",
> +    "BriefDescription": "Average sampled latency for L3 requests where data is returned from all types of sources.",
> +    "UMask": "0x3f",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency_requests.dram_near",
> +    "EventCode": "0xad",
> +    "BriefDescription": "Average sampled L3 requests where data is returned from DRAM in the same NUMA node.",
> +    "UMask": "0x01",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency_requests.dram_far",
> +    "EventCode": "0xad",
> +    "BriefDescription": "Average sampled L3 requests where data is returned from DRAM in a different NUMA node.",
> +    "UMask": "0x02",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency_requests.near_cache",
> +    "EventCode": "0xad",
> +    "BriefDescription": "Average sampled L3 requests where data is returned from cache of another CCX in the same NUMA node.",
> +    "UMask": "0x04",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency_requests.far_cache",
> +    "EventCode": "0xad",
> +    "BriefDescription": "Average sampled L3 requests where data is returned from cache of another CCX in a different NUMA node.",
> +    "UMask": "0x08",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency_requests.ext_near",
> +    "EventCode": "0xad",
> +    "BriefDescription": "Average sampled L3 requests where data is returned from extension memory (CXL) in the same NUMA node.",
> +    "UMask": "0x10",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency_requests.ext_far",
> +    "EventCode": "0xad",
> +    "BriefDescription": "Average sampled L3 requests where data is returned from extension memory (CXL) in a different NUMA node.",
> +    "UMask": "0x20",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_xi_sampled_latency_requests.all",
> +    "EventCode": "0xad",
> +    "BriefDescription": "Average sampled L3 requests where data is returned from all types of sources.",
> +    "UMask": "0x3f",
> +    "EnAllCores": "0x1",
> +    "EnAllSlices": "0x1",
> +    "SliceId": "0x3",
> +    "ThreadMask": "0x3",
> +    "Unit": "L3PMC"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json b/tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json
> new file mode 100644
> index 000000000000..649a60b09e1b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json
> @@ -0,0 +1,101 @@
> +[
> +  {
> +    "EventName": "umc_mem_clk",
> +    "PublicDescription": "Memory clock (MEMCLK) cycles.",
> +    "EventCode": "0x00",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_act_cmd.all",
> +    "PublicDescription": "ACTIVATE commands sent.",
> +    "EventCode": "0x05",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_act_cmd.rd",
> +    "PublicDescription": "ACTIVATE commands sent for reads.",
> +    "EventCode": "0x05",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_act_cmd.wr",
> +    "PublicDescription": "ACTIVATE commands sent for writes.",
> +    "EventCode": "0x05",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_pchg_cmd.all",
> +    "PublicDescription": "PRECHARGE commands sent.",
> +    "EventCode": "0x06",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_pchg_cmd.rd",
> +    "PublicDescription": "PRECHARGE commands sent for reads.",
> +    "EventCode": "0x06",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_pchg_cmd.wr",
> +    "PublicDescription": "PRECHARGE commands sent for writes.",
> +    "EventCode": "0x06",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_cas_cmd.all",
> +    "PublicDescription": "CAS commands sent.",
> +    "EventCode": "0x0a",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_cas_cmd.rd",
> +    "PublicDescription": "CAS commands sent for reads.",
> +    "EventCode": "0x0a",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_cas_cmd.wr",
> +    "PublicDescription": "CAS commands sent for writes.",
> +    "EventCode": "0x0a",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_data_slot_clks.all",
> +    "PublicDescription": "Clock cycles where the data bus is utilized.",
> +    "EventCode": "0x14",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_data_slot_clks.rd",
> +    "PublicDescription": "Clock cycles where the data bus is utilized for reads.",
> +    "EventCode": "0x14",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_data_slot_clks.wr",
> +    "PublicDescription": "Clock cycles where the data bus is utilized for writes.",
> +    "EventCode": "0x14",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  }
> +]
> -- 
> 2.43.0
