Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26C1C5F1B
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776655443; cv=none; b=Iq+TsTbX1Np5n0GWbRHPMxrCyvCBKoqx6yIzfVLAa+OMOJKXZ9rVDzV2/OSgVxDg2qaLAGMkxggl+HyM7+rOYf+p5ePXvOIGNINxLqnMzQOoB+nIcyKT9PDrx71lmcWbcWl1mnbAMj0XR8iEbk6Tp0dH5cZGUh3C3htRmMiP6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776655443; c=relaxed/simple;
	bh=jvagkFJKCL4jlEPfq4PmutDuExVB2wu8LSPMJF+4GY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hsitBkaxqRV7TB/Lu6xAG5tUoiZqOpJwyTzDILBpR9Cp2niFtJUNfQTAawfiDyr1+dPvif7+65cO3LGBpjDhsXvDHyKAS39Vhr6fhHZPKB+X/BOObDYlUph6ca3oUdPQihSpc4uTdpWa554upm3I6Zn1oXf3zTlCGsokEe6svCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flzUBU3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flzUBU3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8971C19425;
	Mon, 20 Apr 2026 03:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776655442;
	bh=jvagkFJKCL4jlEPfq4PmutDuExVB2wu8LSPMJF+4GY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=flzUBU3bEJZgosVtPv7+A6ZHrcrAxiK3yrTLc5QWSzEnYS2eTlIa3WMUSkRoxt7xA
	 JSZP3V8erH+2vdgcBRJC19dMqJmgYd916eTQCBPH+zR+Fgw1MlWez8rA1S5HgIFTKE
	 D6tkNnG2tvsT62JTUmTCqzfvWdKIDrJnnBeW/UYC5EtryUvMwv1OALpCfzMK/jDLW6
	 8y5FQAoJ0je1q4zWVxd4pNJio97Vejrwhy+idQmcFWkjGUeGIB8tssreU/1Yq79ZBN
	 v9O3rtPPK1bipLJZ6Qtm2tmccumhW6OU2p7t2arqE4OIgRdhCGWQkbeciqIizh1u3f
	 H3RVeBlOzZZvg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 1/4] perf/x86/intel: Clear stale ACR mask before
 updating new mask
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260420024528.2130065-2-dapeng1.mi@linux.intel.com>
References: <20260420024528.2130065-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 03:24:02 +0000
Message-Id: <20260420032402.A8971C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unvalidated user input in ACR setup leads to cross-user hardware s=
tate corruption and PMU DoS
--

commit 67dc3d7b096879ed6418f54978bf45536496156f
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Clear stale ACR mask before updating new mask

This commit zeroes out the ACR mask (event->hw.config1) for all scheduled
events before applying a new mask. This ensures that bits from a previous
stale ACR mask do not persist and pollute the hardware state during event
rescheduling.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 4768236c054bb..774ae9a4eeaf8 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3334,6 +3334,12 @@ static void intel_pmu_acr_late_setup(struct cpu_hw=
_events *cpuc)
>  	struct perf_event *event, *leader;
>  	int i, j, idx;
> =20
> +	/* Clear stale ACR mask first. */
> +	for (i =3D 0; i < cpuc->n_events; i++) {
> +		event =3D cpuc->event_list[i];
> +		event->hw.config1 =3D 0;
> +	}
> +

Does this new clearing loop inadvertently amplify an existing regression wh=
ere
a single user can disable Auto Counter Reload for all processes on the same=
 CPU?

Looking further down in the same function, the code iterates over
user-controlled bits from event->attr.config2:

arch/x86/events/intel/core.c:intel_pmu_acr_late_setup() {
    ...
    for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_ID=
X_MAX) {
        if (i + idx >=3D cpuc->n_events ||
            !is_acr_event_group(cpuc->event_list[i + idx]))
            return;
        __set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config=
1);
    }
    ...
}

Because idx is derived from the user-controlled event->attr.config2 mask
without being validated against the actual size of the event group, a
user could provide an artificially large idx.

The validation in intel_pmu_hw_config() only checks the weight of the mask
using hweight64(), rather than checking the actual bit indices, leaving this
exposed. Subsequent patches in the series do not fix this.

If the computed index hits a non-ACR event or exceeds cpuc->n_events, the
loop triggers an early return. Since the newly added code zeroes out
event->hw.config1 for all scheduled events before this loop, wouldn't this
early return leave all subsequent valid ACR events with a cleared mask?

Additionally, if the out-of-bounds idx points to another user's valid ACR
group, is_acr_event_group() returns true, and the code proceeds to update
the event->hw.config1 with the victim's hardware counter index.

Could this also result in cross-user state corruption of event->hw.config1
when the event overflows and cross-reloads the victim's counter?

>  	for (i =3D 0; i < cpuc->n_events; i++) {
>  		leader =3D cpuc->event_list[i];
>  		if (!is_acr_event_group(leader))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420024528.2130=
065-1-dapeng1.mi@linux.intel.com?part=3D1
