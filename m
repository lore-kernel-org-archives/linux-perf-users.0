Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E61175B1;
	Thu, 26 Sep 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380582; cv=none; b=i50MhGApmeosM15R+o5OfzBYlYGzYUUcI++PUWtkssYYJAFmN6uvPDQA/4jAAP+9XV6aQehowAZQmnT0yY1ImlXikYvTZm6XthBskQWWH2lDYySCkJ8v8+BASKQTvbCTb8TyjLoc0tCMs+jgfoyRKo6fivYT6on5nMwqjT0GDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380582; c=relaxed/simple;
	bh=ldOTXqr/M9oSa72p7pP5Su0pHp2RsTVcdzegZvCdBW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aGYZHJnSJLkyG81zx0baPhKIAKbkgiO/jVWr0tonE+ACyJpHbakyYEoIia+uvaYafYsb0CrUB1UQg+uQN+tVNXLabXjBccSRB1RoUcqV0wVA9ds1+9ADD7dpnCb1fX+WnGrKwnvwZ8dWtYwARbTx+bnlETXFyOSU4x4S4InzZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E56B14BF;
	Thu, 26 Sep 2024 12:56:47 -0700 (PDT)
Received: from [10.57.20.191] (unknown [10.57.20.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE0943F587;
	Thu, 26 Sep 2024 12:56:14 -0700 (PDT)
Message-ID: <8168c713-005c-4fd9-a928-66763dab746a@arm.com>
Date: Thu, 26 Sep 2024 20:56:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] perf jevents: Add collection of topdown like
 metrics for arm64
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Jing Zhang <renyu.zj@linux.alibaba.com>,
 Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@arm.com>,
 Leo Yan <leo.yan@linux.dev>
References: <20240926175709.410022-1-irogers@google.com>
 <20240926175709.410022-2-irogers@google.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240926175709.410022-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/2024 6:57 PM, Ian Rogers wrote:
> 
> 
> Metrics are created using legacy, common and recommended events. As
> events may be missing a TryEvent function will give None if an event
> is missing. To workaround missing JSON events for cortex-a53, sysfs
> encodings are used.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/arm64_metrics.py | 147 ++++++++++++++++++++++++-
>  1 file changed, 143 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
> index c9aa2d827a82..bfac570600d9 100755
> --- a/tools/perf/pmu-events/arm64_metrics.py
> +++ b/tools/perf/pmu-events/arm64_metrics.py
> @@ -1,14 +1,151 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> -from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
> -                    MetricGroup)
> +from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
> +                    LoadEvents, Metric, MetricGroup)
>  import argparse
>  import json
>  import os
> +from typing import Optional
> 
>  # Global command line arguments.
>  _args = None
> 
> +def Arm64Topdown() -> MetricGroup:
> +  """Returns a MetricGroup representing ARM64 topdown like metrics."""
> +  def TryEvent(name: str) -> Optional[Event]:
> +    # Skip an event if not in the json files.
> +    try:
> +      return Event(name)
> +    except:
> +      return None
> +  # ARM models like a53 lack JSON for INST_RETIRED but have the
> +  # architetural standard event in sysfs. Use the PMU name to identify
> +  # the sysfs event.
>
> +  pmu_name = f'armv8_{_args.model.replace("-", "_")}'
> +  ins = Event("instructions")
> +  ins_ret = Event("INST_RETIRED", f"{pmu_name}/inst_retired/")
> +  cycles = Event("cycles")
> +  stall_fe = TryEvent("STALL_FRONTEND")
> +  stall_be = TryEvent("STALL_BACKEND")
> +  br_ret = TryEvent("BR_RETIRED")
> +  br_mp_ret = TryEvent("BR_MIS_PRED_RETIRED")
> +  dtlb_walk = TryEvent("DTLB_WALK")
> +  itlb_walk = TryEvent("ITLB_WALK")
> +  l1d_tlb = TryEvent("L1D_TLB")
> +  l1i_tlb = TryEvent("L1I_TLB")
> +  l1d_refill = Event("L1D_CACHE_REFILL", f"{pmu_name}/l1d_cache_refill/")
> +  l2d_refill = Event("L2D_CACHE_REFILL", f"{pmu_name}/l2d_cache_refill/")
> +  l1i_refill = Event("L1I_CACHE_REFILL", f"{pmu_name}/l1i_cache_refill/")
> +  l1d_access = Event("L1D_CACHE", f"{pmu_name}/l1d_cache/")
> +  l2d_access = Event("L2D_CACHE", f"{pmu_name}/l2d_cache/")
> +  llc_access = TryEvent("LL_CACHE_RD")
> +  l1i_access = Event("L1I_CACHE", f"{pmu_name}/l1i_cache/")
> +  llc_miss_rd = TryEvent("LL_CACHE_MISS_RD")
> +  ase_spec = TryEvent("ASE_SPEC")
> +  ld_spec = TryEvent("LD_SPEC")
> +  st_spec = TryEvent("ST_SPEC")
> +  vfp_spec = TryEvent("VFP_SPEC")
> +  dp_spec = TryEvent("DP_SPEC")
> +  br_immed_spec = TryEvent("BR_IMMED_SPEC")
> +  br_indirect_spec = TryEvent("BR_INDIRECT_SPEC")
> +  br_ret_spec = TryEvent("BR_RETURN_SPEC")
> +  crypto_spec = TryEvent("CRYPTO_SPEC")
> +  inst_spec = TryEvent("INST_SPEC")
> +
> +  return MetricGroup("topdown", [
> +      MetricGroup("topdown_tl", [

Is "tl" short for "top level"?

> +          Metric("topdown_tl_ipc", "Instructions per cycle", d_ratio(
> +              ins, cycles), "insn/cycle"),
> +          Metric("topdown_tl_stall_fe_rate", "Frontend stalls to all cycles",
> +                 d_ratio(stall_fe, cycles), "100%") if stall_fe else None,
> +          Metric("topdown_tl_stall_be_rate", "Backend stalls to all cycles",
> +                 d_ratio(stall_be, cycles), "100%") if stall_be else None,
> +      ]),
> +      MetricGroup("topdown_fe_bound", [
> +          MetricGroup("topdown_fe_br", [
> +              Metric("topdown_fe_br_mp_per_insn",
> +                     "Branch mispredicts per instruction retired",
> +                     d_ratio(br_mp_ret, ins_ret), "br/insn") if br_mp_ret else None,
> +              Metric("topdown_fe_br_ins_rate",
> +                     "Branches per instruction retired", d_ratio(
> +                         br_ret, ins_ret), "100%") if br_ret else None,
> +              Metric("topdown_fe_br_mispredict",
> +                     "Branch mispredicts per branch instruction",
> +                     d_ratio(br_mp_ret, br_ret), "100%") if br_mp_ret else None,

For the condition checking, should not be:

  if (br_mp_ret and br_ret) else None

> +          ]),
> +          MetricGroup("topdown_fe_itlb", [
> +              Metric("topdown_fe_itlb_walks", "Itlb walks per insn",
> +                     d_ratio(itlb_walk, ins_ret), "walk/insn"),
> +              Metric("topdown_fe_itlb_walk_rate", "Itlb walks per l1i access",

s/l1i/L1I TLB

> +                     d_ratio(itlb_walk, l1i_tlb), "100%"),

Add checking for: if l1i_tlb else None ?

> +          ]) if itlb_walk else None,
> +          MetricGroup("topdown_fe_icache", [
> +              Metric("topdown_fe_icache_l1i_per_insn",
> +                     "L1I cache refills per instruction",
> +                     d_ratio(l1i_refill, ins_ret), "l1i/insn"),
> +              Metric("topdown_fe_icache_l1i_miss_rate",
> +                     "L1I cache refills per L1I cache access",
> +                     d_ratio(l1i_refill, l1i_access), "100%"),
> +          ]),
> +      ]),
> +      MetricGroup("topdown_be_bound", [
> +          MetricGroup("topdown_be_dtlb", [
> +              Metric("topdown_be_dtlb_walks", "Dtlb walks per instruction",
> +                     d_ratio(dtlb_walk, ins_ret), "walk/insn"),
> +              Metric("topdown_be_dtlb_walk_rate", "Dtlb walks per l1d access",

s/l1d/L1D TLB ?

> +                     d_ratio(dtlb_walk, l1d_tlb), "100%"),

if l1d_tlb or None,

> +          ]) if dtlb_walk else None,
> +          MetricGroup("topdown_be_mix", [
> +              Metric("topdown_be_mix_ld", "Percentage of load instructions",

Should we expicitly say "... speculatively instructions"?

> +                     d_ratio(ld_spec, inst_spec), "100%") if ld_spec else None,
> +              Metric("topdown_be_mix_st", "Percentage of store instructions",
> +                     d_ratio(st_spec, inst_spec), "100%") if st_spec else None,
> +              Metric("topdown_be_mix_simd", "Percentage of SIMD instructions",
> +                     d_ratio(ase_spec, inst_spec), "100%") if ase_spec else None,
> +              Metric("topdown_be_mix_fp",
> +                     "Percentage of floating point instructions",
> +                     d_ratio(vfp_spec, inst_spec), "100%") if vfp_spec else None,
> +              Metric("topdown_be_mix_dp",
> +                     "Percentage of data processing instructions",
> +                     d_ratio(dp_spec, inst_spec), "100%") if dp_spec else None,
> +              Metric("topdown_be_mix_crypto",
> +                     "Percentage of data processing instructions",
> +                     d_ratio(crypto_spec, inst_spec), "100%") if crypto_spec else None,
> +              Metric(
> +                  "topdown_be_mix_br", "Percentage of branch instructions",
> +                  d_ratio(br_immed_spec + br_indirect_spec + br_ret_spec,
> +                          inst_spec), "100%") if br_immed_spec and br_indirect_spec and br_ret_spec else None,
> +          ]) if inst_spec else None,
> +          MetricGroup("topdown_be_dcache", [
> +              MetricGroup("topdown_be_dcache_l1", [
> +                  Metric("topdown_be_dcache_l1_per_insn",
> +                         "L1D cache refills per instruction",
> +                         d_ratio(l1d_refill, ins_ret), "refills/insn"),
> +                  Metric("topdown_be_dcache_l1_miss_rate",
> +                         "L1D cache refills per L1D cache access",
> +                         d_ratio(l1d_refill, l1d_access), "100%")
> +              ]),
> +              MetricGroup("topdown_be_dcache_l2", [
> +                  Metric("topdown_be_dcache_l2_per_insn",
> +                         "L2D cache refills per instruction",
> +                         d_ratio(l2d_refill, ins_ret), "refills/insn"),
> +                  Metric("topdown_be_dcache_l2_miss_rate",
> +                         "L2D cache refills per L2D cache access",
> +                         d_ratio(l2d_refill, l2d_access), "100%")
> +              ]),
> +              MetricGroup("topdown_be_dcache_llc", [
> +                  Metric("topdown_be_dcache_llc_per_insn",
> +                         "Last level cache misses per instruction",
> +                         d_ratio(llc_miss_rd, ins_ret), "miss/insn"),
> +                  Metric("topdown_be_dcache_llc_miss_rate",
> +                         "Last level cache misses per L2D cache access",

Typo : s/L2D/last level

> +                         d_ratio(llc_miss_rd, llc_access), "100%")
> +              ]) if llc_miss_rd and llc_access else None,
> +          ]),
> +      ]),
> +  ])
> +
> +
>  def main() -> None:
>    global _args
> 
> @@ -29,11 +166,13 @@ def main() -> None:
>    )
>    _args = parser.parse_args()
> 
> -  all_metrics = MetricGroup("",[])
> -
>    directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
>    LoadEvents(directory)
> 
> +  all_metrics = MetricGroup("",[
> +      Arm64Topdown(),
> +  ])
> +
>    if _args.metricgroups:
>      print(JsonEncodeMetricGroupDescriptions(all_metrics))
>    else:
> --
> 2.46.1.824.gd892dcdcdd-goog
> 
> 
