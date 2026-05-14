Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD48399CEE
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778737099; cv=none; b=TFnQQ42bagK+YPSp4d3ST4vGpzTQAFxAGDOEioRmdMiAXwyCrhEKeGKAuYQH2HaJuCJrgmnEjwuuAMnp4FRbiUvrQLUE+wsI1GKqHrQZBXlVngfufOoIhGvLuUW7yUK6tl+dg5xzoVlwqsjG1e0rexIKTnV0LHYr8AJRP7Ua+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778737099; c=relaxed/simple;
	bh=nle9qLdiPPUEYMkvTCoLeD6tYQUPEwNXfC4vvyrOHnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eNKo+5ULbfozbvcGiU7hKmT/TFLOsWGgMuWoF9l+94CFwhbcXdBGYOxU/LG54zqvUTP9WAZR1h9PvrYqYOV8b2H0eqS6WzVEoNy4UhHPaNxscG5pD1xcFeR7wv3LpqJ9+YH0CjqtX1orzVE1eTg2GUD/HQaeHNmCkGkgcH9UCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1R8p9/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1R8p9/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E82C2BCB7;
	Thu, 14 May 2026 05:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778737099;
	bh=nle9qLdiPPUEYMkvTCoLeD6tYQUPEwNXfC4vvyrOHnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M1R8p9/23R3iPurm9G7enebMgR9PWQeUICLS4xla4P8At9TtahzBK64G7W6gMadYc
	 IEwaZg0KxvuTvvK315tTClkCOb1sCXIPjRu2U7r0Lrv87zmzt7DF9WiEKa3OkhNP1+
	 81coepBlZeXPIcCW40i725AzrYzE3MLkhTbxkfIpVOvZvTRDfgKBRrYRA+oczHiWSR
	 SQzEViTPDFDCvHiujPThOBd1qslzlijhyR5PjkeLdzejQQcuOnV8g9owTIEcTaGhnX
	 /8fhLsXxR8PXFkQop8POkN+4orC+eFNW5521ib6Cfmh9jXgBCJ41s5tsQPfjBzMcnv
	 ufC33Z2p9ABPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] perf/x86/intel/uncore: Implement lazy setup for
 MSR/MMIO PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512233048.9577-8-zide.chen@intel.com>
References: <20260512233048.9577-8-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 05:38:18 +0000
Message-Id: <20260514053819.14E82C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Local parameter modification in uncore_cpu_mmio_init fails to clea=
r global uncore arrays on error, leading to a guaranteed kernel crash (Use-=
After-Free/NULL dereference) on partial initialization failure.
--

commit 27fb6ccf46a9e646f34ac7d3e4098f98a775ed6f
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Implement lazy setup for MSR/MMIO PMU

This commit updates MSR and MMIO uncore PMUs to use a lazy registration
model. The PMUs are registered when the first box is successfully
initialized and unregistered when the last box exits. Box allocation and
freeing remain at module init/exit time.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index b9b901b789d15..c6fe7864a4977 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c

[ ... ]

> -static int __init uncore_cpu_init(void)
> -{
> -	int ret;
> -
> -	ret =3D uncore_types_init(uncore_msr_uncores);
> -	if (ret)
> -		goto err;
> -
> -	ret =3D uncore_msr_pmus_register();
> -	if (ret)
> -		goto err;
> -	return 0;
> -err:
> -	uncore_types_exit(uncore_msr_uncores);
> -	uncore_msr_uncores =3D empty_uncore;
> -	return ret;
> -}

[ ... ]

> +static int __init uncore_cpu_mmio_init(struct intel_uncore_type **types)
>  {
>  	int ret;
> =20
>  	ret =3D uncore_types_init(types);
> +	if (!ret)
> +		return 0;
> =20
> +	uncore_types_exit(types);
> +	types =3D empty_uncore;

Does this error path effectively clear the global uncore arrays?

Since types is passed by value, assigning types =3D empty_uncore only updat=
es
the local parameter. The global variables like uncore_msr_uncores or
uncore_mmio_uncores are left pointing to structures that were just cleaned
up by uncore_types_exit().

If intel_uncore_init() experiences a partial failure, it can still proceed
to register CPU hotplug callbacks. This synchronously triggers
uncore_event_cpu_online() which iterates over the global arrays:

intel_uncore_init()
  uncore_cpu_mmio_init()
  cpuhp_setup_state()
    uncore_event_cpu_online()
      allocate_boxes()

Could this access freed structures and result in a use-after-free or NULL
pointer dereference since the global array was not cleared?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512233048.9577=
-1-zide.chen@intel.com?part=3D7
