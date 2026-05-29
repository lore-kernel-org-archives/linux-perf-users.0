Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38D3A9619
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044810; cv=none; b=rmJMOw/qHMrHgzdkl1G9V3yWUgAgya7fqZt5Oo0NjlzzXS3XGo2oFVYAxHWJz0kDDieK+MC4rWQ4miuCs4kRD4fCwUUtxGyBjGSOWPExL0ZH9OGDD1nDbxLvbYzhYbwquoDOUryTY1yuU5Ze4/AklC+W7kRCNHw9W1RoUYa+vEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044810; c=relaxed/simple;
	bh=hh2O1SdHkcHq09PpJVQn8dC9FeTWTtF1ooGrAYYNzE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qzOeyj97tfbJUWl0pyANRQqycp93xWLnUcYSYuEpIfWfkgAVF/joKEOoBVdVBRpZUYLWElDL7XrCbCsnNOZRej1rohMj3ywORBMUbMnfVooFfEasDoQ+nLMTGR4doWsvRDs2KzbMuWYy1ULjaV4T9H92dQN1dZkukepPvatqqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUdIqmBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUdIqmBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7080E1F00893;
	Fri, 29 May 2026 08:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044807;
	bh=18GHf939whO8DhhbXO4DqGgm9K1/5CyhSmQTrvBvBq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUdIqmBBCD7+tFDWoVA5GyebbXmJjifkkz/P0p9R/3STqYzcdAMQZ7GWADQ9RuFqG
	 4al641uRp4dVDpglF7SMc7be8nkxn80qGHRuyAituNqfjgaVe/SpxHlbL43FK7AzGW
	 SrzzhTdvE6ZeHNXV5xyb1FiZHNCVYPdQMHdptiVBLTjB+cdzCwssC23X3vGHXaT1Nz
	 asE7KlnpD/Up1YGjU6dE4G11/InfmvyM9X0E5ODRABn+RcvfRYOjvQx5puS0bzRG9r
	 k4yk3mQS6EDOLMk+P0PlSanWUpn1PpD2IFleRiQ/XBEvyJfpGEnX/0VGI0Q2rSKkmh
	 CIXnzjjeVLsSA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 01/23] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-2-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:53:27 +0000
Message-Id: <20260529085327.7080E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces new early returns on `intel_pmu_init_hybrid=
()` failure, which leaks previously allocated resources such as the LBR kme=
m_cache.
--

commit a727042ce1ace4502dce4dc723479df37ff50da5
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Validate return value of intel_pmu_init_hybrid()

This commit adds checks for the return value of intel_pmu_init_hybrid()
in intel_pmu_init() to prevent attempts to access an uninitialized
x86_pmu.hybrid_pmu[] array if memory allocation fails.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0217e701aeebb..85c329bd52be3 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
[ ... ]
> @@ -8545,7 +8546,9 @@ __init int intel_pmu_init(void)
>  		 *
>  		 * Initialize the common PerfMon capabilities here.
>  		 */
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret =3D intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			return ret;

[Severity: Medium]
Does returning early here leak the LBR kmem_cache?

Earlier in intel_pmu_init(), if the CPU supports it, the LBR cache is
allocated:

	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
		intel_pmu_arch_lbr_init();

When intel_pmu_init() returns an error, its caller init_hw_perf_events()
will zero out the global x86_pmu struct, but it doesn't appear to call
kmem_cache_destroy() on the newly allocated task_ctx_cache. Could this
leave the cache leaked?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D1
