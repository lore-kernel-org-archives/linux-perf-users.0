Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E590352C4F
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967255; cv=none; b=KkIiYo/KsjKCvFvcci5TUhv+nslMpE8bv3n9Onb0qwA8j8wccSGd5lXGQI0jpkvMIshIT+5QaCPCY5bnAW56g82ZI7+nqvC7ze/MCnRb1lK7OAWziZBw4hm+0JKZW5MI+xMYDT3hYpkUgu8E68NimN6sGlKzwgYynb/00c/YekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967255; c=relaxed/simple;
	bh=yXERmX+pSrHzEE86IeqLWSO/jKTVl8Fu80GE7IeYAaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WqwIWmGeW6B7fZvZXuUdO1zwLzys1GkzG/FyInicRGqfylqH0309AbgIlpRqhJ4qaKoH4WobB0GSsajyjYzu050S3MTWfoltseg7Ve5KMeMz1LMeJ5A/YsFpsZWoUGDnyI6lwbZqGkg4IYFyN9gtwGgUo6efnj92ftRgi31f4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnUOm1U8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnUOm1U8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F301D1F000E9;
	Mon, 13 Jul 2026 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783967254;
	bh=VNKWgCuo02a1hd2W7oTQMNT7gkhS1Lw6nAjDcPxxcnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cnUOm1U8Duk47/QCoiyHD7rBjnOnPwWSKQNbYcuGnmsDlirxMkHMfnsKJ5qAHXUY3
	 xTQMBiF7rwuKW0XwN89IXLTxWrneZmzy1VL5GcIrm1gFxkW8XQ07YmRoGA1VFqxIbJ
	 SNkQDyERtYBFvEjww4zAiG6TlbCznxrbYBWUV9oi7RuldQKuKAV6MtN3diWIALZ/DT
	 dc3TiVt1kz60RpfazdzjU7I3WaOFhQAb1jJak1UmSRoRMQG5vwY7nA86403lZ+NzWp
	 XwOrJwfSQp5pTeSjrXGd6WDqggMTix63/r8LV8NpJyjK5AxiHDpzDsxBgZWJxFPwJN
	 8US4ck2S/VEpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/12] perf vendor events intel: Update alderlake
 events from 1.39 to 1.40
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chun-Tse Shao" <ctshao@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260713181757.481164-2-ctshao@google.com>
References: <20260713181757.481164-1-ctshao@google.com>
 <20260713181757.481164-2-ctshao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 18:27:33 +0000
Message-Id: <20260713182733.F301D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The metric `tma_uc_bound` is referenced as a 'Related metric' in th=
e PublicDescription of several metrics, but it is never defined for Alderla=
ke.
--

--- Patch [1]: [PATCH v1 01/12] perf vendor events intel: Update alderlake =
events from 1.39 to 1.40 ---
commit 681de70c22f5f71f00cbba2dad4cf02fb3e6da9d
Author: Chun-Tse Shao <ctshao@google.com>

perf vendor events intel: Update alderlake events from 1.39 to 1.40

This commit updates the Alderlake performance events from version 1.39 to 1=
.40,
incorporating changes published in the intel/perfmon repository.

> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index cae7c0cf02f22..e76d679a784b0 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -800,16 +800,16 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of external Memory- or =
Cache-Bandwidth related bottlenecks",
[ ... ]
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
Does this reference a missing metric? The metric tma_uc_bound is listed as a
related metric here (and in a few other places), but it doesn't appear to be
defined in the Alderlake metric files. Could this cause confusion for users
viewing the metric descriptions?

>          "Unit": "cpu_core"
>      },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713181757.4811=
64-1-ctshao@google.com?part=3D1
