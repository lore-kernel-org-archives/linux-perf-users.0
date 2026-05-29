Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7B2E7379
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048484; cv=none; b=MKboBxjJb0JQhv4wpliNopKacFkQDUpVf+Q3ywfUZXlFnqkrgtyOBRiYRjl7E2ngE1/YJYpzO3Gkre0Ja1TgYuG3anQRodmhh5eLQCDVQCTMqm7+hBNeEuBbEU5d6z5tdUfH96tkzmGx/rn5RPL6vyOS5RKpX8mUV4xTI9cA5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048484; c=relaxed/simple;
	bh=VTFu2wzFf+0/Gb07JsWcSqd8Djty/Vg/wKPCqF6I7c0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gfFdAsbx9L45i4uslBtQlcIxKQkj0y9dJ7CfiVQTS/hDCUm2Byhn0OO04Mcm6/B0IkYOQbawXme09g1tzO8Bd+GmFTyGrCVD2QNaJEFaDvNCHydYVobXgscvR2ertbw9vldJo8U9dGx083AR3iueH23qr/+N1OE0tsA63BowJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+wh15lQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+wh15lQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966DB1F00893;
	Fri, 29 May 2026 09:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780048483;
	bh=eX9lBTHbDSxx2iQJZ87UC7cvL4xUlj/MEmLFY1TEZJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+wh15lQbfq3Rn/ezxsYM5GcdjHpSQ9UBMVtm8Tnk7oaJpO2s78tNpTyAdtD3MbqO
	 +oUuCFVRNOWwt+18qxOcWJWPPpNGkL28abCWF10O7KRW6BFMY86UGSf7S5PnQxFfMB
	 bECAl+sJalc/Hu1Mn3mqxMAiG6cXxbrEtjkMbrRx8YaQJX30Sb0HrpTLKCjEPqcumr
	 VeN1783XqgmNeRoQ1coUYVw9VRpwUf6W6Qheg6WIhQ+aGJMXTfYrZnr2rrXPd/3i9/
	 aR/wnGFWgZbGTieNBZcX57iV6AP61n0BXZ9134TclbjnNzSiLXVF2H+1GcrAE5bITd
	 oG/VG2EgEm2tQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 23/23] perf/x86/intel: Add sanity check for PEBS
 fragment size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-24-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-24-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:54:42 +0000
Message-Id: <20260529095442.966DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Skipping setup_sample on corrupted PEBS records leaves fields in p=
erf_sample_data uninitialized, causing a kernel stack memory leak when the =
dummy sample is emitted.

Pre-existing issues:
- [High] A pre-existing infinite loop vulnerability for corrupted PEBS reco=
rds with a size of 0 was missed in intel_pmu_drain_pebs_icl().
- [High] Incomplete validation of corrupted PEBS fragment sizes allows out-=
of-bounds memory accesses.
--

commit 68a663ba619b4d0d98aedabd45c1aa50b4acbe81
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Add sanity check for PEBS fragment size
   =20
Prevent potential infinite loops by adding a sanity check for the
corrupted PEBS fragment sizes which could happen in theory.

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index e0d3076277026..3e100cb206a84 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2675,6 +2675,9 @@ static void setup_arch_pebs_sample_data(struct perf=
_event *event,
> =20
>  again:
>  	header =3D at;
> +	if (!header->size)
> +		return;
> +

[Severity: High]
This is a pre-existing issue, but does checking only that header->size is
non-zero leave us vulnerable to out-of-bounds memory accesses?

If a corrupted fragment has a small non-zero size (e.g., 2 bytes) but has
multiple capability flags set (like header->basic, header->lbr), wouldn't
setup_arch_pebs_sample_data() blindly increment its next_record pointer
to parse those structures? Could this allow it to read past the declared
fragment size and potentially beyond the mapped bounds of the PEBS buffer
memory page?

[ ... ]

> @@ -2956,13 +2959,21 @@ __intel_pmu_pebs_last_event(struct perf_event *ev=
ent,
>  			    struct pt_regs *iregs,
>  			    struct pt_regs *regs,
>  			    struct perf_sample_data *data,
> -			    void *at,
> -			    int count,
> +			    void *at, int count, bool corrupted,
>  			    setup_fn setup_sample)
>  {
>  	struct hw_perf_event *hwc =3D &event->hw;
> =20
> -	setup_sample(event, iregs, at, data, regs);
> +	/* Skip parsing corrupted PEBS record. */
> +	if (corrupted) {
> +		/* Clear stale register states in previous records. */
> +		memset(regs, 0, sizeof(*regs));
> +		x86_pmu_clear_perf_regs(regs);
> +		perf_sample_data_init(data, 0, event->hw.last_period);
> +	} else {
> +		setup_sample(event, iregs, at, data, regs);
> +	}
> +

[Severity: High]
If setup_sample() is skipped when corrupted is true, perf_sample_data_init()
will initialize generic fields like period and sample_flags, but what
about PMU-specific fields such as data->weight, data->data_src, and
data->txn?

Since the perf_sample_data struct is allocated on the kernel stack and not
zeroed upon initialization, could this leave those fields containing stale
kernel stack data? When perf_event_output() or perf_event_overflow() are
subsequently called, would this result in a kernel stack memory leak to
userspace?

[ ... ]

> @@ -3327,7 +3345,7 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs =
*iregs, struct perf_sample_da
>  	}
> =20
>  	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, la=
st,
> -					    setup_pebs_adaptive_sample_data);
> +					    false, setup_pebs_adaptive_sample_data);
> =20
>  	return hweight64(events_bitmap);
>  }

[Severity: High]
This is a pre-existing issue, but does intel_pmu_drain_pebs_icl() have a
similar infinite loop vulnerability for corrupted records with a size of 0?

Looking at the loop just above this code:

    for (at =3D base; at < top; at +=3D basic->format_size) {
        u64 pebs_status;

        basic =3D at;
        if (basic->format_size !=3D cpuc->pebs_record_size)
            continue;
    }

If a corrupted hardware record has basic->format_size =3D=3D 0, the loop
condition evaluates to true, the continue statement executes, and the loop
attempts to advance at by 0. Wouldn't this result in at remaining
unchanged, creating an infinite loop in NMI context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D23
