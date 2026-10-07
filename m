Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765324B0C8B
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387608; cv=none; b=jTms6tsONn5e2cONdwKfhVT7Sp4tQgYoQk4VyBzPWtSKYmb8B+4nfqI68G29NKkKWjWEV1L1WN6eZRlvlSa3rezqsCiemnz24RP8GQfBUuxucdTJv4IFRzp46xBVxT6qMtkFGwGX0stKfUTd9a7gEU2p/ZM/30n8AJ6Njw2CWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387608; c=relaxed/simple;
	bh=FAK2DXWlatX+iA7xEjYpXF5lOj7ejmhr2wGsTuT8T4Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=To9s71uFY9q7EBrdy/5353On+AU1fPnpb7n2NPMPK3Upzv5bQ/cEHpFUMgah0Woid9DcWiikmO+0iOsbxUWX63o2NASabQV51jAMu4WwbJ5oe9jEwy3ZXthpeSdy3GboV45bw6FJBtgHtGZcP0HNH1uj9GeLVC4zJORNgBdy8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMUOoeWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMUOoeWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2561F000FF;
	Wed,  7 Oct 2026 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791387602;
	bh=GhB6pb+7Sx9YeCuj9GRSGaC44hOj0+X3P02t8wIsx1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMUOoeWwRNKZL+B4qsgT7QYSV9wc2dHduR3XEr1I+EmKlK0ke+KqwzB2NyHKwtTWN
	 JmFV2IdtS4iHGW+pjCuDQgsedOSXR6DyOZ/NkuvfgHwvM94s0ba4CfV16DYFNDYHMS
	 /eBS4MvD0agjp7sxfOxCLNWpj1u3+SmobhLczM1Yt8fCXsO4fr/v5SXRWlzh3KU9Tk
	 sB1F6JB9VB0Px2MdMcGmLrOGx2th194YjCvCoA4Is7WxfQ6yM7nysz0znn9fZewXZ1
	 PwMDTva6TPcAXvivtOgI+EIRJRifaQI6W4KHbjreBHL3WlYNXYZj0s6SejwxA+YYwz
	 B58c44KxVLmXg==
Message-ID: <sashiko-outbox-163154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: Extend num_umc_pmc to fix UMC
 discovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261007152746.3658877-1-sandipan.das@amd.com>
References: <20261007152746.3658877-1-sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 15:40:02 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/x86/amd: OOB write on active_mask via unvalidated CPUID
--

commit 00612d17a5d2f57d4e77167b7e9d6303f0e776ac
Author: Sandipan Das <sandipan.das@amd.com>

perf/x86/amd/uncore: Extend num_umc_pmc to fix UMC discovery

The commit extends the width of the num_umc_pmc bitfield from six bits
to eight bits to match Zen 5 documentation. This allows discovery of
Unified Memory Controller (UMC) counters up to 64 in fully-populated
Zen 6 configurations.

> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/per=
f_event.h
> index 1eb13673e889f..d419b26086b22 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -293,7 +293,7 @@ union cpuid_0x80000022_ebx {
>  		/* Number of Data Fabric Counters */
>  		unsigned int	num_df_pmc:6;
>  		/* Number of Unified Memory Controller Counters */
> -		unsigned int	num_umc_pmc:6;
> +		unsigned int	num_umc_pmc:8;

[Severity: High]
Does this expansion allow values up to 255 from CPUID to propagate unchecke=
d?

When the field was 6 bits, the natural boundary limited it to 63, which fit
safely inside NUM_COUNTERS_MAX (64). With an 8-bit width, a hypervisor could
supply a value greater than 64 in EBX.NumPerfCtrUmc.

This value gets propagated down during initialization without validation:

arch/x86/events/amd/uncore.c:amd_uncore_umc_ctx_init() {
    ...
    pmu->num_counters =3D group_num_pmcs[gid] / group_num_pmus[gid];
    ...
}

If pmu->num_counters exceeds NUM_COUNTERS_MAX, can it cause an
out-of-bounds write when starting the event?

arch/x86/events/amd/uncore.c:amd_uncore_umc_start() {
    ...
    __set_bit(hwc->idx, ctx->active_mask);
    ...
}

Since ctx->active_mask is sized by BITS_TO_LONGS(NUM_COUNTERS_MAX), writing
a bit greater than 63 might overflow into the adjacent nr_active and
hrtimer fields in struct amd_uncore_ctx.

Should we cap pmu->num_counters against NUM_COUNTERS_MAX during
initialization to prevent this regression?

>  	} split;
>  	unsigned int		full;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007152746.3658=
877-1-sandipan.das@amd.com?part=3D1
