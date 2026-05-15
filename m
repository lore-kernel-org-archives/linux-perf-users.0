Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98343377EAB
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827127; cv=none; b=I0wA2oMqC/APP3D96y60/4t/Qv3EYHwxpObsFaDpoBRoyt+Y2rqYOGhL4jI2lduGiyO8W1XZSMYy6cj/XlMgdBDVWPaHxOckYcatRLnFFbndZeJd+Sbgvt+l7/o2KQWTC4+WBdlbw5p+iflcFIamxI2Jukmg/Yit19Xz6IGwjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827127; c=relaxed/simple;
	bh=PJA1H5HVFkIt6iTAeZSPtafKxETNZ4mPrxVMifFtFGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cvm0+fkJly/cKAr5boJ3TCxXfzsY8uygdBxFJ6IAAflel0OXjeiah2OT9gFwcPzDZjraKRnQjFwUbQZDPrkPy098C7KR5WxvgXOm4VpIPRFz2w0JmxJS31q7GkjOc5MtqmiSLwDGOp95m/0c3a++4JakaeVhMAxoPXy/Yh80CLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsBRN7Fk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsBRN7Fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B308C2BCB0;
	Fri, 15 May 2026 06:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778827127;
	bh=PJA1H5HVFkIt6iTAeZSPtafKxETNZ4mPrxVMifFtFGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NsBRN7FkHy3NZd2zmChfxZsmohxwIMi9h8PDvrH1Hbgsd8w18jn9WNcvltnrawSXt
	 ofuYmU3opmn8ws5AQe17p31c50HiDx2sUuykwOUGgbmzvJv/6iIBHp6drhoUWaWgWh
	 D63ObR2NPzocrGKGGmPnK4c4WU/5gSeK0iRAjhakYIuoPBW/dF6FUOYG1Po0h06Gpn
	 fBigKw3AakDuvlIFtVpnsjf4EkZjK1MRKrSlJPO2zRjLHRO9wXezYRBP53u/DwTtEL
	 Egigz/sVwhmJpy4NrBOeiQBw4h12sspwAFfCwSX8XT/vwH+6PLpNhmh6fynrMCLtQh
	 bed/q5zPBjZvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] perf/x86/intel: Update event constraints and
 cache_extra_regs[] for ADL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260515061143.338553-5-dapeng1.mi@linux.intel.com>
References: <20260515061143.338553-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 06:38:46 +0000
Message-Id: <20260515063847.1B308C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit introduces a bisectability regression for MTL and ARL=
-U platforms by temporarily applying incorrect Alderlake-specific cache eve=
nt structures.
- [Low] Unnecessary duplication of the Golden Cove hardware cache event IDs=
 array.
--

commit 58bdcbf21858fcf6337dcba2e5e091a86ddafd3c
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Update event constraints and cache_extra_regs[] for ADL
   =20
This commit updates the hard-coded event constraints and cache_extra_regs[]
for Alderlake according to the latest ADL perfmon events. It introduces
ADL-specific variants of structures and functions to reflect differences
in L3/node related OCR events.

> Please note these changes would temporarily impact other platforms like
> MTL/ARL-U which shares hard-coded event structures, but it would be
> fixed soon in subsequent patches.

Does this introduce a bisectability regression for Meteorlake and Arrowlake=
-U
platforms?

Every commit needs to be self-contained and functionally correct to keep the
tree bisectable. I noticed the fixes are included later in the series.

Could the patch series be reorganized to avoid leaving any platform in a
regressed state during bisection?

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0d0edc2d1b906..7948e3afc2916 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -713,6 +715,80 @@ static __initconst const u64 glc_hw_cache_event_ids
>   },
>  };
> =20
> +/* ADL P-core (Golden cove) specific event code. */
> +static __initconst const u64 adl_glc_hw_cache_event_ids
> +				[PERF_COUNT_HW_CACHE_MAX]
> +				[PERF_COUNT_HW_CACHE_OP_MAX]
> +				[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D
> +{
> + [ C(L1D ) ] =3D {
> +	[ C(OP_READ) ] =3D {
> +		[ C(RESULT_ACCESS) ] =3D 0x81d0,
> +		[ C(RESULT_MISS)   ] =3D 0xe124,
> +	},
> +	[ C(OP_WRITE) ] =3D {
> +		[ C(RESULT_ACCESS) ] =3D 0x82d0,
> +	},
> + },

[ ... ]

> + [ C(BPU ) ] =3D {
> +	[ C(OP_READ) ] =3D {
> +		[ C(RESULT_ACCESS) ] =3D 0x4c4,
> +		[ C(RESULT_MISS)   ] =3D 0x4c5,
> +	},
> +	[ C(OP_WRITE) ] =3D {
> +		[ C(RESULT_ACCESS) ] =3D -1,
> +		[ C(RESULT_MISS)   ] =3D -1,
> +	},
> +	[ C(OP_PREFETCH) ] =3D {
> +		[ C(RESULT_ACCESS) ] =3D -1,
> +		[ C(RESULT_MISS)   ] =3D -1,
> +	},
> + },
> +};

This array appears to be identical to the existing glc_hw_cache_event_ids
array, except that the C(NODE) entries are omitted and default to zero.

Instead of duplicating the entire array and risking silent divergence when
future updates are made, could we dynamically clear the C(NODE) entries for
Alderlake during initialization?

A similar pattern of localized overrides is already utilized in
intel_pmu_init_grt() for the C(ITLB) event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515061143.3385=
53-1-dapeng1.mi@linux.intel.com?part=3D4
