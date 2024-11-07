Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6761F12E9;
	Thu,  7 Nov 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990140; cv=none; b=Rl+OmuOU+bAfFMk4EtdR0xWhV5UHymbhHJLcAyjtYvx5zTqKKSn/GHWr2ZAT2Ti9AjD9HA21LTmpT4nkDWPkBwQPYpq7VEuE36x1Ni9l70MFEWhDMtH7g3eNAZa9nMhdb0uRn5OXQGV7M35s4yVfQ3CRS+qFzHygWhzaaiHfcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990140; c=relaxed/simple;
	bh=0bvBWhP3o1it9RosdYcoyvWAiMGDsRPKKiA96goMZbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=joY42wlkQAITQvluFzEIEaaF1MBlRDxRJTl1utYs8P00u2CtK3Ib4Jb1sLW/9O9HdvXLDkWoeJxSC2Fq8bD1gofbtcu0tk2qWFe4hM7bR0uXTtwbS9uKkD4W1wM8zPN1OZi2jHs+s60GQBrXyaHWKZnJCMxcqI0l+vGTKT+yyUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+jzJzpd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+jzJzpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730990138; x=1762526138;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0bvBWhP3o1it9RosdYcoyvWAiMGDsRPKKiA96goMZbo=;
  b=L+jzJzpdLGuYNB23bq9dQztxSVcfBx2jBzmQYvDI5S5/Cyhs5aT53wMU
   IHnIT9a/F+ZHrvf9TPiDoy/VrKnFdPZIWnrxMoCE9fgxe1Kf3U8B0WJ9R
   xBHP7K7lb0o5+JDLTI6ui2G1FRpGL+aAEze8iRXO8EJJhgeqqcLnlek/u
   XEE7yn8+2uz003X5uZCRfXnVRxedVTDfvPgT+HEDDwxBrskZbUHPzSBa1
   fOjoN37dlWnDmKGwJIVshZVzkAODOQbEIo6nOyYxU0FhFBc45ObpWdi2k
   WJir0Z6r0o2fBFE2rzigPnTYbtli+hpHVyxFiStwMHOj9s1L1pKuw6Ugb
   A==;
X-CSE-ConnectionGUID: 4ZBmzRNHT8SdLTmI9OPvIA==
X-CSE-MsgGUID: RE1kjWFSREqRrdNCbDrV+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="56231705"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="56231705"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 06:35:36 -0800
X-CSE-ConnectionGUID: EqCyjF5PRo+FEKGBGlHFcw==
X-CSE-MsgGUID: QHBWuasCTaGhnrz9JWSwuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="108374991"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 06:35:35 -0800
Received: from [10.212.68.83] (kliang2-mobl1.ccr.corp.intel.com [10.212.68.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 79A0C20B5703;
	Thu,  7 Nov 2024 06:35:33 -0800 (PST)
Message-ID: <20a6d424-c3a5-4fa9-b5d4-bcbe684a4a6f@linux.intel.com>
Date: Thu, 7 Nov 2024 09:35:32 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/22] perf jevents: Add br metric group for branch
 statistics on Intel
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Perry Taylor <perry.taylor@intel.com>, Samantha Alt
 <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
References: <20240926175035.408668-1-irogers@google.com>
 <20240926175035.408668-8-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240926175035.408668-8-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-26 1:50 p.m., Ian Rogers wrote:
> The br metric group for branches itself comprises metric groups for
> total, taken, conditional, fused and far metric groups using json
> events. Conditional taken and not taken metrics are specific to
> Icelake and later generations, so the presence of the event is used to
> determine whether the metric should exist.
> > Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index 58e243695f0a..09f7b7159e7c 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -123,6 +123,143 @@ def Tsx() -> Optional[MetricGroup]:
>    ], description="Breakdown of transactional memory statistics")
>  
>  
> +def IntelBr():
> +  ins = Event("instructions")
> +
> +  def Total() -> MetricGroup:
> +    br_all = Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
> +    br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
> +                     "BR_INST_RETIRED.MISPRED",
> +                     "BR_MISP_EXEC.ANY")
> +    br_clr = None
> +    try:
> +      br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
> +    except:
> +      pass

There is no guarantee to the event name. It could be changed later.
The renaming already occurred several times, even for architectural events.

I think we should test all events' presence, not just a few of them.

There could be some effort in the future to sync with the event list for
each new generation and check if there is a renaming.

Thanks,
Kan
> +
> +    br_r = d_ratio(br_all, interval_sec)
> +    ins_r = d_ratio(ins, br_all)
> +    misp_r = d_ratio(br_m_all, br_all)
> +    clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
> +
> +    return MetricGroup("br_total", [
> +        Metric("br_total_retired",
> +               "The number of branch instructions retired per second.", br_r,
> +               "insn/s"),
> +        Metric(
> +            "br_total_mispred",
> +            "The number of branch instructions retired, of any type, that were "
> +            "not correctly predicted as a percentage of all branch instrucions.",
> +            misp_r, "100%"),
> +        Metric("br_total_insn_between_branches",
> +               "The number of instructions divided by the number of branches.",
> +               ins_r, "insn"),
> +        Metric("br_total_insn_fe_resteers",
> +               "The number of resync branches per second.", clr_r, "req/s"
> +               ) if clr_r else None
> +    ])
> +
> +  def Taken() -> MetricGroup:
> +    br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
> +    br_m_tk = None
> +    try:
> +      br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
> +                      "BR_MISP_RETIRED.TAKEN_JCC",
> +                      "BR_INST_RETIRED.MISPRED_TAKEN")
> +    except:
> +      pass
> +    br_r = d_ratio(br_all, interval_sec)
> +    ins_r = d_ratio(ins, br_all)
> +    misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
> +    return MetricGroup("br_taken", [
> +        Metric("br_taken_retired",
> +               "The number of taken branches that were retired per second.",
> +               br_r, "insn/s"),
> +        Metric(
> +            "br_taken_mispred",
> +            "The number of retired taken branch instructions that were "
> +            "mispredicted as a percentage of all taken branches.", misp_r,
> +            "100%") if misp_r else None,
> +        Metric(
> +            "br_taken_insn_between_branches",
> +            "The number of instructions divided by the number of taken branches.",
> +            ins_r, "insn"),
> +    ])
> +
> +  def Conditional() -> Optional[MetricGroup]:
> +    try:
> +      br_cond = Event("BR_INST_RETIRED.COND",
> +                      "BR_INST_RETIRED.CONDITIONAL",
> +                      "BR_INST_RETIRED.TAKEN_JCC")
> +      br_m_cond = Event("BR_MISP_RETIRED.COND",
> +                        "BR_MISP_RETIRED.CONDITIONAL",
> +                        "BR_MISP_RETIRED.TAKEN_JCC")
> +    except:
> +      return None
> +
> +    br_cond_nt = None
> +    br_m_cond_nt = None
> +    try:
> +      br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
> +      br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
> +    except:
> +      pass
> +    br_r = d_ratio(br_cond, interval_sec)
> +    ins_r = d_ratio(ins, br_cond)
> +    misp_r = d_ratio(br_m_cond, br_cond)
> +    taken_metrics = [
> +        Metric("br_cond_retired", "Retired conditional branch instructions.",
> +               br_r, "insn/s"),
> +        Metric("br_cond_insn_between_branches",
> +               "The number of instructions divided by the number of conditional "
> +               "branches.", ins_r, "insn"),
> +        Metric("br_cond_mispred",
> +               "Retired conditional branch instructions mispredicted as a "
> +               "percentage of all conditional branches.", misp_r, "100%"),
> +    ]
> +    if not br_m_cond_nt:
> +      return MetricGroup("br_cond", taken_metrics)
> +
> +    br_r = d_ratio(br_cond_nt, interval_sec)
> +    ins_r = d_ratio(ins, br_cond_nt)
> +    misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
> +
> +    not_taken_metrics = [
> +        Metric("br_cond_retired", "Retired conditional not taken branch instructions.",
> +               br_r, "insn/s"),
> +        Metric("br_cond_insn_between_branches",
> +               "The number of instructions divided by the number of not taken conditional "
> +               "branches.", ins_r, "insn"),
> +        Metric("br_cond_mispred",
> +               "Retired not taken conditional branch instructions mispredicted as a "
> +               "percentage of all not taken conditional branches.", misp_r, "100%"),
> +    ]
> +    return MetricGroup("br_cond", [
> +        MetricGroup("br_cond_nt", not_taken_metrics),
> +        MetricGroup("br_cond_tkn", taken_metrics),
> +    ])
> +
> +  def Far() -> Optional[MetricGroup]:
> +    try:
> +      br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
> +    except:
> +      return None
> +
> +    br_r = d_ratio(br_far, interval_sec)
> +    ins_r = d_ratio(ins, br_far)
> +    return MetricGroup("br_far", [
> +        Metric("br_far_retired", "Retired far control transfers per second.",
> +               br_r, "insn/s"),
> +        Metric(
> +            "br_far_insn_between_branches",
> +            "The number of instructions divided by the number of far branches.",
> +            ins_r, "insn"),
> +    ])
> +
> +  return MetricGroup("br", [Total(), Taken(), Conditional(), Far()],
> +                     description="breakdown of retired branch instructions")
> +
> +
>  def main() -> None:
>    global _args
>  
> @@ -150,6 +287,7 @@ def main() -> None:
>        Rapl(),
>        Smi(),
>        Tsx(),
> +      IntelBr(),
>    ])
>  
>  

