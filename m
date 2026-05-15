Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182B382F1B
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827221; cv=none; b=CKAUZwHok71GLmt9UJS0wcQ7BZxd0b5hTISmFt40IflN9+KLgwD51KJYuMYYXVWPFiwLj+53t1ZKRpeuaRih9t36t+RxSU4TjA7IMTBUvQzSBg+b9ltmMNNcddT0L8rrDVB7vbStMRi1n/cHn2+IhyrLrOSn8oZMrY5qtFEnFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827221; c=relaxed/simple;
	bh=P5eTd/8iITMLfdq0L7oZ+NAsMEk/Sp1PwcJDWMA9REM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YqVqsCfj9QsaCGu6qE/KbGxl3NFGm+LhW3wuEt9m1pMUwTKQjWfJwpGnUfTJ8fZcW26HrwwGwM4oF0Yo0ckyZllkvkMKFtLHv5cBrOVmuLr7sS6zKWeDNfWwKj/2HheOEudWCEzaFPLX60to4OlU3AkheZ0hysrOQnrOuWJuZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRKJf6ZM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRKJf6ZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF597C2BCC7;
	Fri, 15 May 2026 06:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778827221;
	bh=P5eTd/8iITMLfdq0L7oZ+NAsMEk/Sp1PwcJDWMA9REM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WRKJf6ZM6XfFyLDNFxLHZc+2JctYt9m+MufT5s2uhWar9WNkQc5TuQ8/zEN8hwKBN
	 yBpfQsxGLAecQraQ6pOkvl7LFYtv3BibGXfS+18P8LfFj7NTbPeZLvSmkgRBXbX4Z4
	 bJYRsDYTmgn7hl4F8SD+CgEfmaIq/JneyA7MbZXyQ+tZw+rAeEChLGtdXm9lE6LOrk
	 4i/tWzlHGHHsERc05fxVDio6s7Rvd3GQM80OdDuJ35UZSPb6qMMT/XQt1DE0onMhjL
	 RaUtKmpwe4464Dnj+W/TNqqCDlWl6Hms4Wq/a0VPdT2+Wzsaq6eAtLnuZkv30En2ye
	 5P22CKqKFzTbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] perf/x86/intel: Update event constraints and
 cache_extra_regs[] for ARL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260515061143.338553-8-dapeng1.mi@linux.intel.com>
References: <20260515061143.338553-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 06:40:20 +0000
Message-Id: <20260515064020.AF597C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unhandled memory allocation failure in intel_pmu_init_hybrid() lea=
ds to a NULL pointer dereference.
--

commit e86d9a7a48c7a21c02757243f3a40ac6b6e47297
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Update event constraints and cache_extra_regs[] for ARL

Updates perf hard-coded event constraints and cache_extra_regs[] for
Arrowlake. Introduces ARL-specific arl_lnc_hw_cache_extra_regs and adds
crestmont specific constraints for LPE cores.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -8529,16 +8547,41 @@ __init int intel_pmu_init(void)
>  	case INTEL_WILDCATLAKE_L:
>  		pr_cont("Pantherlake Hybrid events, ");
>  		name =3D "pantherlake_hybrid";
> +
> +		intel_pmu_init_hybrid(hybrid_big_small);
> +
> +		/* Initialize big core specific PerfMon capabilities.*/
> +		pmu =3D &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
> +		intel_pmu_init_lnc(&pmu->pmu);
> +
>  		goto lnl_common;
> =20
> -	case INTEL_LUNARLAKE_M:
>  	case INTEL_ARROWLAKE:
> +		pr_cont("Arrowlake Hybrid events, ");
> +		name =3D "arrowlake_hybrid";
> +
> +		intel_pmu_init_hybrid(hybrid_big_small);
> +
> +		/* Initialize big core specific PerfMon capabilities.*/
> +		pmu =3D &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
> +		intel_pmu_init_lnc(&pmu->pmu);

Does this code risk a NULL pointer dereference if the memory allocation in
intel_pmu_init_hybrid() fails?

Looking at intel_pmu_init_hybrid(), it allocates x86_pmu.hybrid_pmu and
returns -ENOMEM if kzalloc_objs() fails.

If that allocation fails here, the return value is ignored. The code
immediately proceeds to calculate the pmu pointer using x86_pmu.hybrid_pmu
and passes it to intel_pmu_init_lnc(), which would dereference it.

While this pattern existed before this patch, it is being propagated into
the new Pantherlake and Arrowlake initialization blocks. Could we add error
handling here to catch the allocation failure before accessing the array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515061143.3385=
53-1-dapeng1.mi@linux.intel.com?part=3D7
