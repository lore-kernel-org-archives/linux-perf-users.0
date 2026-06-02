Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB9A2F3C3E
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416331; cv=none; b=aGgTKzGk7MI4nmWgiOASIofrA0ww8NV2HqjalR8tP0p0ETSgXMC2xFJcTSKAsOlkBLucmxx7o0D7ucbwZCepPMjojhzV9oQVu0nWmTtFzqL3TqbWUlwgIqhCzMsXWP9QVaoaGD2gI68nHMzqPv+ovm+DQxMcMgtiu+tiWCfprig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416331; c=relaxed/simple;
	bh=VTMN6DVWT+7awAZ4yKbhzzxcLDPXTvt+4xaPi+clDrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=li7jNFN0LjvdsGc7Jta5avaisVnyboeXrW3S0byRXPLA0FUkEUgzyRGwXUWJCeNW+KtzIxTS1wr8NKMTVQAEmwhPbUuNiyD54LFk+klxCU/JIowHfCuBf9P1SGv+hiW2Kx6tHmyTWjpfbNJNZgvW89hYbkxVWQB9jl+GhOPHmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWxSIBXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWxSIBXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB701F00893;
	Tue,  2 Jun 2026 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780416329;
	bh=CBroVR+Yk7lcwQbOxj7pV0qgwLw9rlt+kUk1J1u5MmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWxSIBXvEeN4LpXHghCIAErBLsDlTQHgdOY3di1GfC5MeJ6c8wJCazpP4OuUYmtJ6
	 4/Q2XEUNKJdLVKpN8gmkMsmASw7NhGI7+HAc+Kgv4u/uzSDjsZnF0CVGhpJzygUYsw
	 c8qY0W7HS2osrnuhMJeCCbiA2Se3rGxaKDWXbWx5J+LSm8rvukzUfIywH9Tm6mnnvb
	 gppM6b2oiZiyqvHKydmsbM3aurEYYn93jJovDx320R/43ObdVLqZUe3fm5iDL6IYsy
	 j1aRtDklb3oMn0ulXZjBlxLl2jxMyiCRwyXNLgzEWQQYr/KshfJ0a3VLwW3VUXNZpB
	 xfRpEX4SFSH5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 4/7] perf/x86/intel/uncore: Defer ADL global PMON
 enable to enable_box()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602144908.263680-5-zide.chen@intel.com>
References: <20260602144908.263680-5-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 16:05:29 +0000
Message-Id: <20260602160529.8EB701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch defers ADL global PMON enablement to `enable_box()` to=
 save power when no events are in use, but fails to realize that `enable_bo=
x()` is unconditionally called by the perf core during event teardown, perm=
anently re-enabling the PMON block after its first use.
--

commit c42f45660bd3d0d4d416922cef01dcc3c1fb5e35
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()

This patch removes adl_uncore_msr_init_box() and defers programming the
global control register to enable_box(). The goal is to reduce power
consumption on Raptor Cove by enabling uncore PMON globally only when a
box is actually used.

Cc: stable@vger.kernel.org
Fixes: 772ed05f3c5c ("perf/x86/intel/uncore: Add Alder Lake support")
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>

> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/u=
ncore_snb.c
> index 3dbc6bacbd9de..edddd4f9ab5fc 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c

[ ... ]

> @@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
>  	skl_uncore_msr_ops.init_box =3D rkl_uncore_msr_init_box;
>  }
> =20
> -static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
> -{
> -	if (box->pmu->pmu_idx =3D=3D 0)
> -		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
> -}
> -
>  static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
>  {
>  	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
>  }

[Severity: Medium]
Will this leave the PMU permanently enabled after its first use?

During event teardown, the perf core brackets the removal with calls to
perf_pmu_disable() and perf_pmu_enable(). perf_pmu_enable() will ultimately
invoke uncore_pmu_enable(), which unconditionally calls enable_box().

Because adl_uncore_msr_enable_box() unconditionally writes the enable bit
without checking if there are any remaining active events (for example,
checking if box->n_active > 0), the global MSR appears to be immediately
re-enabled at the end of the teardown process.

Does this mean the intended power savings are lost the first time the
PMU is used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602144908.2636=
80-1-zide.chen@intel.com?part=3D4
