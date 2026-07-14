Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960C41B8F3
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062617; cv=none; b=gJtIDJCTXyhFzWw+rehT9/MO/k+KRyMjdtO5bANth2ljrshF584+u7TBvfbWuKIS39/+cEgCoMdX6rlAOrp8+qXFsx6qeRAg/L2Q6igtgQNdQ6050mVYe1GCQ1gpB6tGyL+gd4KLAj1OtOjyBjM0C1eNNnbSpdjWBbBESFIsB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062617; c=relaxed/simple;
	bh=YcBOY7Q07m5kkv9eb2+hKpaLmAg0Sej+ZgFMP+XiLl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zh3WycC6Fd8uSf3XSfll6iCPssmsNaUojFZottkWhsNhdLlKqA5CPtVgEGuUl6j7t/QIjqmyvNzhd+fB42/pHB3urm9tjXdWz/nyneNECGcar0FTrFMz6gy9jERP7V9iHZmVFe7RBmaUM40uU4eTcxvEZZkztHRpypsEMhOJI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHCbgDCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHCbgDCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079F21F000E9;
	Tue, 14 Jul 2026 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784062616;
	bh=p/11jZKg4M18uZA231QXNVg+LgOOn5rvb+fIX678100=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MHCbgDCj/3kcBftmbfuT/PGgLiGaAQQ+A6fhH5TMLpKh86pM3T5Phz3huPrL9l0kf
	 2n/NKXL4LBxu/awWgtGV3A+yAnszlWADs8oyo35kvHM0QxKQAXqIRY2To/R2Wf0SqR
	 TetaLgtHSDTBudU1NEPQ3F2V4Wtg9LkPGhORITazo0YcmsYCe9TfOyLQODGJVaGaE1
	 Pe4nLsxrLHl/QD1o53ci5hM754ZS1Pvw6++MG1I2OaaKo5VlbWPQPf4gJ1meIbDb26
	 4MbQYSKKfnzLvd4t4djfkJUk7HHeI653PuCXrpr0V1AMGltpi4zSsMosLYkZd46yaV
	 sIVxLmguW7Z5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/12] perf vendor events intel: Update meteorlake
 events from 1.21 to 1.22
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260714204044.1952031-9-ctshao@google.com>
References: <20260714204044.1952031-1-ctshao@google.com>
 <20260714204044.1952031-9-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 20:56:55 +0000
Message-Id: <20260714205656.079F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The metric `tma_uc_bound` is referenced as a related metric in mult=
iple `PublicDescription` fields, but it is not defined for the Meteor Lake =
architecture.
--

--- Patch [8]: [PATCH v2 08/12] perf vendor events intel: Update meteorlake=
 events from 1.21 to 1.22 ---
commit cb395fd3e26bd66c71e3cfa53c9dba3acded6104
Author: Chun-Tse Shao <ctshao@google.com>

perf vendor events intel: Update meteorlake events from 1.21 to 1.22
   =20
The updated events were published in:
https://github.com/intel/perfmon/commit/704ef43e4c0738065a0575622cf7d31867b=
8d48b

> diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json b=
/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
> index 948c16a1f95ba..a23691052237e 100644
> --- a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
> @@ -797,16 +797,16 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of external Memory- or =
Cache-Bandwidth related bottlenecks",
> -        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_=
dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound))=
 * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory=
_bound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tm=
a_l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + t=
ma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (=
tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1=
_latency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_bl=
k)))",
> +        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_miss_bound / (t=
ma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l3_miss_bound + tma_store_b=
ound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_=
memory_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_l3_miss_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_acc=
esses + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_=
bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_l=
3_miss_bound + tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_f=
ull + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_=
store_fwd_blk)))",
>          "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
>          "MetricName": "tma_bottleneck_data_cache_memory_bandwidth",
>          "MetricThreshold": "tma_bottleneck_data_cache_memory_bandwidth >=
 20",
> -        "PublicDescription": "Total pipeline cost of external Memory- or=
 Cache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_inf=
o_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
> +        "PublicDescription": "Total pipeline cost of external Memory- or=
 Cache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_inf=
o_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_uc_bound",

[Severity: Low]
This isn't a bug, but this adds a reference to tma_uc_bound which doesn't
appear to be defined in the Meteor Lake JSON files. Will this cause a
dangling documentation reference for users looking up the related metrics?

(Note: This same tma_uc_bound reference is also added to the
PublicDescription fields for tma_fb_full, tma_info_system_dram_bw_use,
tma_mem_bandwidth, and tma_sq_full below).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714204044.1952=
031-1-ctshao@google.com?part=3D8
