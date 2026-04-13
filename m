Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ECC1A681D
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044158; cv=none; b=pPNWK7wtEc7XeUk4KSZ8sCY972LYd6hX7ynM7sZDVB3PJ+CWqfMx5jXoLnuLuCx6Uo+JwiqNvG2gF6yA2nniFE5u3eMYRzQF4MDn7W9tfSNkcDeJueilBdGujPCbBHyiige/QE3G1kdQmn9Sgs7TD3gVJyzk0sN3uiunCLmDzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044158; c=relaxed/simple;
	bh=dS//zMF6LNVXPF6PLEN54n+dL3H6sgERyC2PYzSb/6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NA0GK2AjdmW0APB1lCqpfbnTbCKw5GaoRRF/CLfvjjTQqoqLvJZDrG1Nvg99Fx3zas+6kOw14ZC+Gc4hLc//NNoLI6RQd6G4Zt2sQtNCTPxvBv5Va20039rLX2znnMQPYs5gq3AhbaSkxJ/7lpwgfQAuxgjKBogLR+Ox50iBvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNMiHZ6l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNMiHZ6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFE3C19424;
	Mon, 13 Apr 2026 01:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776044158;
	bh=dS//zMF6LNVXPF6PLEN54n+dL3H6sgERyC2PYzSb/6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JNMiHZ6l5+3hWVSZ7d6gZGJBpnOBOwdKiSD8JODxE58oZSE80DZpkQ0m3bdDCLWzu
	 giyVSklYEyN7GWiox6UY8FgRyTCBgQZgpoAvzhlP/e2zY2wUOJ7J5MU8tkL+J3gdPX
	 84+e/KAQke60cfpCJ5yzC4sgb6TjdCpGNiQOf95/xmS0jUHkI0LW18ucUz/3V7Vh8N
	 y7wNpZW/zwDNhnGEAXARBkJecO6KayJKPJFsZSOTTkcBGmbwJtl7ecR1r2V7k8r6IE
	 2h3uD6fCdAIc3xDcm1acYGLNa41DNr58kxTqkgWjjPQgvEoAVVzZ9dsmlKaTlSABVY
	 NTt1HJcseO1EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf/x86/intel: Clear stale ACR mask before
 updating new mask
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413010157.535990-2-dapeng1.mi@linux.intel.com>
References: <20260413010157.535990-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 01:35:57 +0000
Message-Id: <20260413013558.0EFE3C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Incomplete Fix: Early return bypasses the newly added stale mask c=
leanup for subsequent events.
- [High] Missing bounds check on user-provided mask allows cross-event PMU =
interference (cross-wiring).
--

commit f516548e46c9feac44792cd958b5c0a840d60d43
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Clear stale ACR mask before updating new mask

This commit clears the ACR mask before applying a new one to prevent
stale bits from persisting during event rescheduling. It ensures the
hardware state does not get polluted by previous configurations.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 4768236c054bb..58c236ce47474 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3344,6 +3344,9 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_=
events *cpuc)
>  			event =3D cpuc->event_list[j];
>  			if (event->group_leader !=3D leader->group_leader)
>  				break;
> +
> +			/* Clear stale ACR mask first. */
> +			event->hw.config1 =3D 0;
>  			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_=
IDX_MAX) {
>  				if (i + idx >=3D cpuc->n_events ||
>  				    !is_acr_event_group(cpuc->event_list[i + idx]))

Could this validation check allow unprivileged users to cross-wire the PMU?

Since is_acr_event_group() only verifies that the target event belongs to a=
ny
ACR group, rather than the same group_leader, does this allow a user-provid=
ed
out-of-bounds bit in config2 to point to an independent, system-wide ACR ev=
ent
running on the same CPU?

If so, it seems the hardware counter index of an unrelated privileged event
could be blindly copied into the user's hw.config1.

>  					return;

Does this early return bypass the newly added stale mask cleanup for subseq=
uent
events?

Because attr.config2 is user-controlled, a user could supply a malformed ma=
sk
with an out-of-bounds bit to intentionally trigger this early return.

Since it returns from intel_pmu_acr_late_setup() completely, wouldn't this =
skip
the event->hw.config1 =3D 0 cleanup for all subsequent ACR events scheduled=
 on the
same CPU, leaving them with a polluted hardware state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413010157.5359=
90-1-dapeng1.mi@linux.intel.com?part=3D1
