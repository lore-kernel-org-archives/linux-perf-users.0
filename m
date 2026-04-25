Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7FE56A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 03:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777087919; cv=none; b=cjcrE8qSaHGS95A5/Dw4BOkmR7f0Actu7PAc52c/JjH2i1yF6FiSezv8tmLMrMgHgYplXilEMWlt3ILktVeCXEx1o9ZVr1HS5rTZZIJCNFF0sFeow44HZyrSmKLZQU9ubckeE8o7UJN/wkp5p9g9d4hEb9msiaGnK/0GJ3lKqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777087919; c=relaxed/simple;
	bh=qffKfZR1tYiXjPTZPA3qRJYqNVxDNGx4jzD5MUyD6RI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sosagBeo733M2w5DZySXfRf7Hy0HnbfIgJ8V5He95G2RNoqWqRZp56UaRTf7G7RUyinHhoequY89Wkx1CDYIkdDVUaR9ijnQ4LZH07k3pEXHguRnVfbovfvDaN7erLO+rkYnfPBWYFWOnZI8nw4nKEp5kIm+cDnwE61JlgBJTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUMlhJgp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUMlhJgp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A29C19425;
	Sat, 25 Apr 2026 03:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777087919;
	bh=qffKfZR1tYiXjPTZPA3qRJYqNVxDNGx4jzD5MUyD6RI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eUMlhJgpMaWQYIn6uduWvXl7JEvR6A5jPixmoN0I96bsY0SmBZC/6XwDz7vDYr/As
	 UeEUuEMl89MMuDj0Qs+vBvwIcr6TrcRXDVxSaw8GgBuaLtTXM7a9pCYOad6A8IvIsh
	 Xm215Aeq32LE7FkcAQB2+q7CSEiF6H5hgBHRUKSdb5uyNoQSCbPrLC+stt/23E87WM
	 lQyNOrSGRm1l2wflgHzm0RZUiINNc5UoXvTvoWiHvGyQnPonas461rhO1zDM3jVh4c
	 9YTUwiIUQx3XruQlAD2Muj7uN/LPM8XG93SDBHrJ75L+pr12o4Sd9zZLJINVo7w9a8
	 ox2w7PgOoYTlw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 23/24] perf/x86: Activate back-to-back NMI detection
 for arch-PEBS induced NMIs
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260324004118.3772171-24-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-24-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 03:31:58 +0000
Message-Id: <20260425033158.D3A29C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Incorrect bitwise operation in intel_pmu_drain_pebs_nhm() corrupts=
 the processed events count.
- [High] Removing the unconditional `handled` increment causes valid PMIs t=
o be reported as unhandled when `drain_pebs()` returns 0.
--

commit 0317f48597bdef9b4d93c696bde043840ac1fc6b
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Activate back-to-back NMI detection for arch-PEBS induced NMIs

This patch modifies the PEBS handlers to return the count of actually
processed events instead of void. This count is used in the PMI handler
to activate back-to-back NMI detection and avoid "suspicious NMI" warnings.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -3558,9 +3558,8 @@ static int handle_pmi_common(struct pt_regs *regs, =
u64 status)
>  	if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long *=
)&status)) {
>  		u64 pebs_enabled =3D cpuc->pebs_enabled;
> =20
> -		handled++;
>  		x86_pmu_handle_guest_pebs(regs, &data);
> -		static_call(x86_pmu_drain_pebs)(regs, &data);
> +		handled +=3D static_call(x86_pmu_drain_pebs)(regs, &data);

If x86_pmu_drain_pebs() returns 0, will handled fail to increment even thou=
gh
the hardware asserted an NMI and set the MSR status bit?

This might happen if the host PEBS buffer is empty, such as when a guest PE=
BS
event triggers the PMI and is handled by x86_pmu_handle_guest_pebs() right
above it.=20

Could this cause the core NMI framework to treat the interrupt as unhandled
and trigger an unknown NMI warning? Is it necessary to ensure handled
increments by at least 1 when the status bit is explicitly acknowledged?

>  		/*
>  		 * PMI throttle may be triggered, which stops the PEBS event.

[ ... ]

> @@ -3587,8 +3586,7 @@ static int handle_pmi_common(struct pt_regs *regs, =
u64 status)
>  	 */
>  	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
>  				 (unsigned long *)&status)) {
> -		handled++;
> -		static_call(x86_pmu_drain_pebs)(regs, &data);
> +		handled +=3D static_call(x86_pmu_drain_pebs)(regs, &data);

Does this share the same issue as above, where a return value of 0 from
drain_pebs() would result in handled not being incremented for a valid PMI?

[ ... ]

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c

[ ... ]

> @@ -3189,6 +3192,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs=
 *iregs, struct perf_sample_d
>  		if ((counts[bit] =3D=3D 0) && (error[bit] =3D=3D 0))
>  			continue;
> =20
> +		events_bitmap |=3D bit;
>  		event =3D cpuc->events[bit];

Will this perform a bitwise OR with the integer index itself rather than
the expected bitmask?

Because bit is an integer index (e.g., 0 for PMC0, 3 for PMC3), if only PMC3
overflows, events_bitmap |=3D 3 (binary 011) results in hweight64(3) return=
ing
2. If PMC0 overflows, events_bitmap |=3D 0 leaves the bitmap at 0.

Should this be events_bitmap |=3D BIT_ULL(bit) or 1ULL << bit to correctly
record the processed events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324004118.3772=
171-1-dapeng1.mi@linux.intel.com?part=3D23
