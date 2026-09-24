Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08D4BA9FD
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269893; cv=none; b=AoGkrgu806lgG7hZ2HlY79pYhsnqsJQTtH4gc5lifaEWk3BkaXw7O3jLL0GzXR6iJbd5ZYHYzx5T5aPlDL05bQG42GxWWEeUD2Z7AXruRS1JtiDeiZOxeEtO4KR2M0QfqDMaKTIoSfNIB+82EoNe3IlCIj7wrKfUWekbs1c3ht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269893; c=relaxed/simple;
	bh=ZDDYHYTwFxeYsp0jFkeEFRCE8lTwYfDsHhBC+Rf4Cdo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dsZdVMX7XUDEMQiwj4JXaNojpJ/MSuRIMr1aniVvTk2nL3Q1w63b7v3t1iCVW+sDYspUdlqV0MJxTR0/KeJ5QnuRFMdK7zLYW/rMJvyHeHCQyLLXukrMV1y5bTWR2FvrYXcgZ5wwdJTrwYnF8OORtuZMPoHCQ5/tXCbdgV96Yso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouBc+xFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouBc+xFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8651F00893;
	Thu, 24 Sep 2026 17:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269891;
	bh=D5SQfagwq/PcTK+n301GHtOX0ojVxmNiXKiSDtO1rIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ouBc+xFUZzfIIFeUNITWjfTQsrzZEr1gVk9O5H3j74s9kqVjPDN9BU0r5AXQtV7dM
	 wCpaPasP4kxvqqJVRYlW5+HQHmw3bvER11SHhPZbuuhdxQhyHrRjc72vWBYxc6qam2
	 ejM1g3j1DTLNLtxGpqzUdhZQ3+/6iMcXrnKtiUgQrxT2aoqK/fXfO/1StlKjtZneFn
	 HRZBfx+wVv1tlifXV7QnbhlhIu3pq8wBMmf6DGtUI/ccbn2NBj6IMdjREdiX8yTBCP
	 MvTpVLYbeIoW7cRkmETE1ZjLK6m01DZ39hvQiJi0aDerSXP4IVE50P4puAz3mUILf8
	 hhj0zO3jg/iAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/26] perf vendor events intel: Update sandybridge
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-19-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:11:31 +0000
Message-Id: <20260924171131.BF8651F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: missing NO_GROUP_EVENTS_SMT constraint for tma_l3_miss_bou=
nd metric on Sandybridge
--

commit 2ddca9ec203f3367beb0ec776bd232119da3e230
Author: Ian Rogers <irogers@google.com>

perf vendor events intel: Update sandybridge metrics to TMA 5.2

This commit updates the Sandybridge metrics to Intel's TMA 5.2 by modifying
metricgroups.json and snb-metrics.json. It adjusts several metric thresholds
and groups, notably replacing tma_dram_bound with tma_l3_miss_bound.

> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json =
b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> index d407619034292..48f9ccc0a7275 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> @@ -129,16 +129,6 @@
>          "PublicDescription": "This metric represents fraction of cycles =
where the Divider unit was active. Divide and square root instructions are =
performed by the Divider unit and can take considerably longer latency than=
 integer or Floating Point addition; subtraction; or multiplication. Sample=
 with: ARITH.DIVIDER_ACTIVE",
>          "ScaleUnit": "100%"
>      },
> -    {
> -        "BriefDescription": "This metric estimates how often the CPU was=
 stalled on accesses to external memory (DRAM) by loads",
> -        "MetricConstraint": "NO_GROUP_EVENTS_SMT",
> -        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UO=
PS_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS)) * CYCLE_ACTI=
VITY.STALLS_L2_PENDING / tma_info_thread_clks",
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
PS_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS)) * CYCLE_ACTI=
VITY.STALLS_L2_PENDING / tma_info_thread_clks",
> +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
> +        "MetricName": "tma_l3_miss_bound",

[Severity: Medium]
Will dropping the NO_GROUP_EVENTS_SMT constraint from the newly named
tma_l3_miss_bound metric cause PMU multiplexing errors on SMT systems?

The previous tma_dram_bound metric used the exact same event expression
(MEM_LOAD_UOPS_RETIRED.LLC_HIT, MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS) but
explicitly enforced this constraint to prevent hardware scheduling issues
when SMT is enabled.

By omitting this constraint, it looks like perf will inappropriately attempt
to schedule these events into a single PMU group under SMT.

> +        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2)",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS",
>          "ScaleUnit": "100%"
>      },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D18
