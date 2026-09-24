Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14F3B42F9
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269892; cv=none; b=Uv7DDqH1c39lahpo2Bpoz+3zdBltjjvHLyaVZ4TVCNqeXyaDvUOnm81KhwqWx0jMNeAFvG8Z7xJsFq4QK0vr07ggg+IyCv/jurS7xtlTOB8qayjphR9aqnXXqyxQhy3M9NUCOkC011ry4ifaFwSFQpLf6aEBJlm7pp1N6nESmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269892; c=relaxed/simple;
	bh=bUUJqWBqEfzCNcLqEixKSmtfHN/RZZK9d30Yvf0/TpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GmpfT1QEokrn7MRnW+w8gwEVNBn6lyBlDSfhHTJNZPeOWO5uuz1ssf6xBKm9JBdlAk0V0Z5fytfliaoxMHf3LCkkRDICPrACavHT5xIaMGS3bWchENcTgKvB4QRNVM4MrAstDMy8s36XbuXlrADn2/yH9H+c4rALNMsWGBH2WCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2J5Esbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2J5Esbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148941F000FF;
	Thu, 24 Sep 2026 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269891;
	bh=6qY1QmWlOGkosehQyQwNAZF6eOqeHA/EkrSpJ2r2B68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H2J5Esbt2RhGDtUgH+G2FeKibTO0YFnInpylCMz4TT0aiROKF73f4AFTz7v7LA5rW
	 XREua6NAi/7Yyk+L5dKLrwkTc2cQkSenxMVJrlmiE0uY+H+ecCHxFKcrEKc4Dcnc5N
	 wsYSio+z6eLjL2WckwzBBJvLpU/BusKzo4ye5W0Kqlu9ddjx/qG0URqkhdAzwMoNZd
	 hdLGvl/spSHhkIpG72apHJT1brEVzJ/EXOsmrTlJxTXzehHv9/mXzvtDKYcMLmdWO8
	 FL5tTfQsI41tZm5oQBHPzPQ01HzTPdv5IQ9Di6y3KJufaH7+1YaTKUqlF368j0XeyT
	 ll3yKrKCEAVGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/26] perf vendor events intel: Update ivytown
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-13-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:11:29 +0000
Message-Id: <20260924171131.148941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: missing SMT group constraint in ivytown tma_l3_miss_bound
--

commit 394dbde3b15671d6397d45498145f1f7fbbf5686
Author: Ian Rogers <irogers@google.com>

perf vendor events intel: Update ivytown metrics to TMA 5.2

This commit updates the Intel TMA metrics for Ivytown systems to version
5.2. It removes the older tma_dram_bound metric and introduces
tma_l3_miss_bound in its place.

> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/to=
ols/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> index 1cdd197ac883e..7ceda72b6cafa 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
[ ... ]
> -    {
> -        "BriefDescription": "This metric estimates how often the CPU was=
 stalled on accesses to external memory (DRAM) by loads",
> -        "MetricConstraint": "NO_GROUP_EVENTS_SMT",
> -        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UO=
PS_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.=
STALLS_L2_PENDING / tma_info_thread_clks",
> -        "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_=
memory_bound_group",
> -        "MetricName": "tma_dram_bound",
> -        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0=
.2 & tma_backend_bound > 0.2)",
> -        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_=
RETIRED.L3_MISS_PS",
> -        "ScaleUnit": "100%"
> -    },
[ ... ]
> +    {
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled on accesses to external memory (DRAM) by loads",
> +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UO=
PS_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.=
STALLS_L2_PENDING / tma_info_thread_clks",
> +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
> +        "MetricName": "tma_l3_miss_bound",
> +        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2)",

[Severity: Low]
Is the NO_GROUP_EVENTS_SMT constraint intentionally omitted for the new
tma_l3_miss_bound metric?

This new metric replaces tma_dram_bound and uses the exact same events,
such as MEM_LOAD_UOPS_RETIRED.LLC_HIT and CYCLE_ACTIVITY.STALLS_L2_PENDING.
The original tma_dram_bound metric and the complementary tma_l3_bound both
specified a MetricConstraint of NO_GROUP_EVENTS_SMT to avoid hardware errata
or grouping issues when SMT is enabled on Ivytown systems.

Could the absence of this constraint cause grouping failures or erroneous p=
erf
metric counts when running perf stat with SMT enabled? A review of subseque=
nt
patches confirms this omission was not addressed later in the series.

> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS",
> +        "ScaleUnit": "100%"
> +    },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D12
