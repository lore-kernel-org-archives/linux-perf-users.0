Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116065;
	b=s1/mWEVgbLkn3fKU8Vmg4CQgywoGfaDGwFLihpy9YU5WYt+NCpjjXgCx8Gd9qu5RXHgt
	 8qvWFIiGfOUZ+tq82qvaqBdhU9G73SaHPgkAkwdvwEjpFdIWF6M6qRdL/Q+Lk5MYZbhmP
	 fumBIxAH7F1gjo0W8sYxD8wmUBwhi0KczxKlTI9WIWkQTvz1L5bIXu7YtkNQBGU+mMKRF
	 wZA+nxK9rtZic2sqVj02CTjAamwGIz60K+X9NRsGP0sDQkr2Vpi0nf+xAeP3dT5BK9o9H
	 tODnQzC3K68VW/1gCK3hetkNYZOhWE7O2v9nxvgBXmbDq9ldh653Vwwh/xuiF1yh1sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mt6EtJKnkULOU43oTkc2BrXq9egSEIALfnHnBIRB/Bw=;
	b=bAcVUMWamOwSqGoa7iXMApHqJC+UWKPXoPQ8A6Dfli4x3mypKfEB5f4uJUqBPZgRvCrF
	 cw5fy4Tgt2RvRHAYr0SSqHKcdLp9lGd3YPghV43ND6oqJYZtGMIDNTDYTlgGKv7yCnsGl
	 joqjMgi0M5pVKKiYraufnayJe7Pi+q38Kmvioim+bm9ZHdLC/G109wD0/Z1NK+OVsymTC
	 BYukY5vAADLAqQmOd6k16JyXd8Z5tzrBwDoUzlqBHi7dZMRuftEShA5+79VeHTEGOUO5H
	 OqYrem3K+Yw+wfAQG1jMU7V4GmwCxdqEXbviubIAR6pH+ZpxsaP/jdQC1EQG/7f6Atw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrfMEK6A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0A9606A32C
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrfMEK6A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2E71F000C4;
	Thu, 19 Nov 2026 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116065;
	bh=mt6EtJKnkULOU43oTkc2BrXq9egSEIALfnHnBIRB/Bw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UrfMEK6A7PKKMmGMXwqFirjYFT85GgTcNW8sJSdYm1SOjbLHEqDMydg7yXdq9FEys
	 WRjFxv6SkHQ5S83LqgvqhMXWUGANMZfnLzQXHz8XHutHdKlBLB86BNmWivIK1tJjQa
	 kGDPrWjZ5nBwJGHzF1gkk0Ldwk0x5DIQyE0SQrcuKYxQCN3E1OtEWNPUPtrCQT1Ftj
	 kRnOTq8qrIzExVYumGeJDo7pjB60CgO+vN/JqnEfaymbhe+ewiwsNUrFO0dCB4UH4K
	 nq+zTvGBZARYgqmK5ZUiaoOc0Gscrr8TcfMundJGtfhIfXGWtis+jUUJspZkADHxMd
	 dxJqMuUxjYONw==
Message-ID: <sashiko-outbox-223865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 16/33] KVM: arm64: Set up MDCR_EL2 to handle a
 Partitioned PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-17-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-17-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:21:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Configure MDCR_EL2 for a Partitioned PMU in kvm_arm_setup_mdcr_el2():
> set HPME, HPMD, and HCCD (plus HLP on FEAT_PMUv3p5 so host counters
> retain 64-bit overflow width), program HPMN to the guest's general
> purpose counter count, and clear coarse-grained TPM and TPMCR traps when
> FEAT_FGT is available. Protect MDCR_EL2 updates with local_daif_save()
> so GICv3 pseudo-NMI PMU handlers toggling MDCR_EL2.HPME cannot race with
> kvm_arm_setup_mdcr_el2().
>=20
> Update kvm_nested_setup_mdcr_el2() for the two nested execution contexts:
> - Nested guest context (is_nested_ctxt(vcpu), L2 at vEL1/vEL0):
>   NV_MDCR_GUEST_INCLUDE already propagates L1's virtual TPM and TPMCR.
>   When L1 sub-partitions its counters (vHPMN < nr_pmu_counters, so
>   kvm_pmu_hyp_counter_mask(vcpu) is non-zero), physical MDCR_EL2.HPMN
>   still equals nr_pmu_counters, so hardware alone cannot stop L2 from
>   accessing L1's hypervisor counters (vHPMN..nr_pmu_counters-1) or
>   reading nr_pmu_counters from PMCR_EL0.N. Force TPM and TPMCR so L0
>   emulates 0..vHPMN-1 locally and forwards hypervisor counter traps to
>   L1.
> - Nested hypervisor context (else branch, L1): under VHE, both L1 vEL2
>   (physical EL1) and VHE host EL0 (physical EL0) run in this context
>   without exiting to L0 across ERET and SVC. When L1's PMUSERENR_EL0 is
>   0, hardware traps EL0 PMU accesses directly to L1 vEL2, allowing TPM
>   and TPMCR to stay clear for untrapped L1 vEL2 access. When L1 enables
>   EL0 access in PMUSERENR_EL0, propagate L1's virtual TPM/TPMCR (and set
>   TPM/TPMCR if L1 sub-partitions counters) so VHE host EL0 cannot bypass
>   L1's traps or vHPMN boundary.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D16

