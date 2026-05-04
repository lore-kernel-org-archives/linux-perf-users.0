Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1437B402
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933899; cv=none; b=coAEFJeSG6qT0kq/gB/+9b0P8tVhC3RwLwTSpnKHKZIvgIfI9f6H+xh8pm13itcM/ew+bpvvHBajDkBF9Uos3PY74LbURRaR0SrM1C0jA8TjgHXZEl9avdGvGn7syFJtolAFjOM7vkvvBxQYVcpX4pbkt4v/g96zXNHpPujNYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933899; c=relaxed/simple;
	bh=vFuZ/xTr6LIpgS+o6RxomPypU7mXbWkNLeOagdQRpv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k1R89p/WiFcMiTGiaY+ihQlhiq+5ebWYFgTN00dDrA4nWLNtQXUG/BuWeMsF3LmkekeZCM9kSUjquX+06twxLzGMT7Zi4k+nsBSHwsGjgoEp2Jg+65+fsotqZxIAz7uaEXF4TWlT8lawNhvLAeKRd6QoXj8Q/Y5IBQTH8zU+oN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrbHhIcN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrbHhIcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD88C2BCB9;
	Mon,  4 May 2026 22:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777933898;
	bh=vFuZ/xTr6LIpgS+o6RxomPypU7mXbWkNLeOagdQRpv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PrbHhIcNgvUrs7hV/OdJen7CalQmsIZX18n4gPVMmsp3UJd3VpvKY8uP1/vDKpn6b
	 dDDro1lkheWQaezh1UF1nLV6XJ289Dw2wkCu/JIG233ubXFdJer0oFKR4Cr2Pfs2SG
	 r59cN0689YgVRXP/z990tX9GYI3mMvmaggKh83BDFSCg2zwF+XOXMb86OHCtnAFlEo
	 4VO+nAet+xGcwgB6GmadpD3i7BVAtUeqn84C2Q1+YB62cwqPE9RUZkqkn17Z/U4pry
	 IACiiSMff1CDsn70RZxErakMR+kRHeRUADV6an8DnVMG+nc1eoAwOcIDqwmeX+ilpb
	 pxslnOKKe2KhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/20] KVM: arm64: Enforce PMU event filter at
 vcpu_load()
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-12-coltonlewis@google.com>
References: <20260504211813.1804997-12-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:31:38 +0000
Message-Id: <20260504223138.AAD88C2BCB9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] kvm_pmu_apply_event_filter() incorrectly writes the cycle counter'=
s event filter configuration to the cycle counter value register (pmccntr_e=
l0) instead of the filter register (pmccfiltr_el0).
- [High] Hardware event filters are only updated on VCPU context switches, =
leaving hardware state stale when the guest dynamically reconfigures events.
- [High] When running a guest in nested EL2 context, kvm_pmu_apply_event_fi=
lter() fails to disable hardware EL1 counting if the guest did not request =
counting in EL2.
--

commit 63c3532220965281cfb17a041907d38b581dd90c
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Enforce PMU event filter at vcpu_load()

The KVM API for event filtering says that counters do not count when
blocked by the event filter. To enforce that, the event filter must be
rechecked on every load since it might have changed since the last
time the guest wrote a value. If the event is filtered, exclude
counting at all exception levels before writing the hardware.

> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 360d022d918d5..2252d3b905db9 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c

[ ... ]

> +		guest_include_el2 =3D (val & ARMV8_PMU_INCLUDE_EL2);
> +		val &=3D ~evtyper_clr;
> +
> +		if (unlikely(is_hyp_ctxt(vcpu)) && guest_include_el2)
> +			val &=3D ~ARMV8_PMU_EXCLUDE_EL1;

When the guest is running in nested EL2 context (which executes in hardware
EL1), what happens if the guest configured the counter to count in guest EL1
but not in guest EL2?

If guest_include_el2 is false, do we need to explicitly set
ARMV8_PMU_EXCLUDE_EL1 in the hardware register here to ensure the counter
pauses when the guest enters EL2?

> +
> +		if (vcpu->kvm->arch.pmu_filter &&
> +		    !test_bit(evsel, vcpu->kvm->arch.pmu_filter))
> +			val |=3D evtyper_set;
> +
> +		if (i =3D=3D ARMV8_PMU_CYCLE_IDX) {
> +			write_sysreg(val, pmccntr_el0);

Does this write the filter configuration into the cycle counter value regis=
ter
instead of the filter register?

If we use pmccfiltr_el0 here instead, will it correctly apply the exclusion
mask?

> +		} else {
> +			write_sysreg(i, pmselr_el0);
> +			write_sysreg(val, pmxevtyper_el0);
> +		}
> +	}
> +}
> +
>  /**
>   * kvm_pmu_load() - Load untrapped PMU registers
>   * @vcpu: Pointer to struct kvm_vcpu
> @@ -165,6 +218,7 @@ void kvm_pmu_load(struct kvm_vcpu *vcpu)
> =20
>  	pmu =3D vcpu->kvm->arch.arm_pmu;
>  	guest_counters =3D kvm_pmu_guest_counter_mask(pmu);
> +	kvm_pmu_apply_event_filter(vcpu);

If the guest dynamically reconfigures events by writing to PMEVTYPERn_EL0 or
PMCCFILTR_EL0, does the physical hardware PMU continue counting the old eve=
nt
until the VCPU happens to be scheduled out and back in?

Is there another place where we push the new value to the physical hardware
during a standard sysreg trap return to avoid leaving the hardware state st=
ale?

> =20
>  	for_each_set_bit(i, &guest_counters, ARMPMU_MAX_HWEVENTS) {
>  		val =3D __vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D11
