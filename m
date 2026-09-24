Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BD14AEBE5
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269885; cv=none; b=FnCRrieomqZotZysAR+L72aBXg2ODWwAEV6podzDFlDOx1imSETRK9oLha0EzdnGSs2AKXfRzE6NGdOy22Z3R4Mmbue68Ms0EplZr0Xss4TAjsL4wjVH0jPVw4tASOP3tBlYYoqEwSkl5D4mVxZ8ggVfhCU3835o11lzdvaXA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269885; c=relaxed/simple;
	bh=L6yGWyRHjk25APCqwHjQT4kUq4WEfPsctp0mKKgZJ+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q35lrxBea1bp5R9hmB9vmYigBsgQsX7ZjjI2GlTEHU9KxKNiq5eXCpJQRMYWltuluIzrTnvfrl5GCz2Y/DBOv3N2Y1qh+PvjarJXayi0WH/kqXOG/hqZgR0drLprqCptKv4bcMFX/DOnIiuTmlAiMSDmG1rGUPrnb//o6nvIJBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX/UIH07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX/UIH07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FF21F000FF;
	Thu, 24 Sep 2026 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269884;
	bh=2KymQZ99fwSMi/SoLInXsDIVOlRlJ39dzOXXuo3ALw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IX/UIH07/zMErmff9a9b08JsIFug2fnspWOJ/b/Y545uS05TG3GbOPaTH5qvUwwR+
	 rR4uinyAeTGBrs0RI6mHGqCUguGxEYT/3UGm2571dZKnzaotTrzAxQR1jfihxxITSU
	 VfZQP2YNba+ybTZkBZXFFeG1RGGPvhVoWPl/tDddCqHD4xMCcsf+Hr5TOQtB45E9ud
	 XWXZ8J5X9cYgttfrfpe4foG9MD5e0yjfZjFf10j1zZhFIdTtcO9rgRvwybsWybOzhJ
	 +DBQmLX0BUEj2pu/DtMd7Jovk8EwjqYNkFufRUvvdxLlnWTcdYilLt+fyF2c0b1gJZ
	 2jy2CauYFsQrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/26] perf vendor events intel: Update icelake
 events to 1.25 and TMA metrics to 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-10-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:11:23 +0000
Message-Id: <20260924171123.E8FF21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf/x86/intel: icelake metric descriptions reference nonexistent e=
vents
--

commit 365b302d316a7f4e716eb4b09cb12527b6b956ec
Author: Ian Rogers <irogers@google.com>
Subject: perf vendor events intel: Update icelake events to 1.25 and TMA me=
trics to 5.2

This commit updates the Intel Icelake events and TMA metrics to their latest
versions based on the intel/perfmon repository.

> diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> index cf9ed3edb694c..a757481941132 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
> @@ -335,7 +335,7 @@
>          "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL=
4;tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
>          "MetricName": "tma_contested_accesses",
>          "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_boun=
d > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to contested ac=
cesses. Contested accesses occur when data written by one Logical Processor=
 are read by another Logical Processor on a different Physical Core. Exampl=
es of contested accesses include synchronizations such as locks; true data =
sharing such as modified locked variables; and false sharing. Sample with: =
MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. =
Related metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, t=
ma_false_sharing, tma_machine_clears, tma_remote_cache",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to contested ac=
cesses. Contested accesses occur when data written by one Logical Processor=
 are read by another Logical Processor on a different Physical Core. Exampl=
es of contested accesses include synchronizations such as locks; true data =
sharing such as modified locked variables; and false sharing. Sample with: =
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related=
 metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_fals=
e_sharing, tma_machine_clears, tma_remote_cache",

[Severity: Low]
Does this metric description suggest an event that is missing from Icelake?
The updated string for tma_contested_accesses recommends sampling with
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD, but XSNP_FWD does not appear to exist
in the Icelake event definitions. This might lead to an "event not found"
error if a user attempts to trace it.

>          "ScaleUnit": "100%"
>      },

[ ... ]

> @@ -349,13 +349,13 @@
>          "ScaleUnit": "100%"
>      },
>      {
> -        "BriefDescription": "This metric estimates fraction of cycles wh=
ile the memory subsystem was handling synchronizations due to data-sharing =
accesses",
> +        "BriefDescription": "This metric estimates fraction of cycles wh=
ile the memory subsystem was handling synchronizations due to L3 data-shari=
ng accesses",
>          "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "23.5 * tma_info_system_core_frequency * MEM_LOAD_=
L3_HIT_RETIRED.XSNP_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L=
1_MISS / 2) / tma_info_thread_clks",
>          "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_is=
sueSyncxn;tma_l3_bound_group",
>          "MetricName": "tma_data_sharing",
>          "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.=
05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to data-sharing=
 accesses. Data shared by multiple Logical Processors (even just read share=
d) may cause increased access latency due to cache coherency. Excessive dat=
a sharing can drastically harm multithreaded performance. Sample with: MEM_=
LOAD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_bottleneck_memory_syn=
chronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears=
, tma_remote_cache",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to L3 data-shar=
ing accesses. Data shared by multiple Logical Processors (even just read sh=
ared) may cause increased access latency due to cache coherency. Excessive =
data sharing can drastically harm multithreaded performance. Sample with: M=
EM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_=
synchronization, tma_contested_accesses, tma_false_sharing, tma_machine_cle=
ars, tma_remote_cache",

[Severity: Low]
Is MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD a valid event for Icelake?
The PublicDescription for tma_data_sharing suggests sampling with this
event, but it seems to be missing from the current Icelake definitions.

>          "ScaleUnit": "100%"
>      },

[ ... ]

> @@ -437,7 +427,7 @@
>          "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW=
;tma_issueSL;tma_issueSmSt;tma_l1_bound_group",
>          "MetricName": "tma_fb_full",
>          "MetricThreshold": "tma_fb_full > 0.3",
> -        "PublicDescription": "This metric does a *rough estimation* of h=
ow often L1D Fill Buffer unavailability limited additional L1D miss memory =
access requests to proceed. The higher the metric value; the deeper the mem=
ory hierarchy level the misses are satisfied from (metric values >1 are val=
id). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache =
or external memory). Related metrics: tma_bottleneck_data_cache_memory_band=
width, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_sto=
re_latency, tma_streaming_stores",
> +        "PublicDescription": "This metric does a *rough estimation* of h=
ow often L1D Fill Buffer unavailability limited additional L1D miss memory =
access requests to proceed. The higher the metric value; the deeper the mem=
ory hierarchy level the misses are satisfied from (metric values >1 are val=
id). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache =
or external memory). Related metrics: tma_bottleneck_data_cache_memory_band=
width, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_sto=
re_latency, tma_streaming_stores, tma_uc_bound",

[Severity: Low]
Could the tma_fb_full metric be referencing a non-existent metric on Icelak=
e?
The updated description includes tma_uc_bound in its related metrics list,
but it appears tma_uc_bound is not defined for this architecture.

>          "ScaleUnit": "100%"
>      },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D9
