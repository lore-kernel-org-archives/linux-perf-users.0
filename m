Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115340;
	b=QzBLGPZC3zJTfSMGhhbMKDn+/hoqn5lMkXTK320/cOqgi3c51etWDe/gw6TRaQHSq5Zj
	 9+iZcuKHx+dVkpDjMB0mtGRDy99j1Rw27bEcz4nS5Lpeq9EXgIFSzMKY+eiy/uMFY3mCO
	 RszR2THJXhEj2mvUjdWC0lQwBlYQ7/jWuXoUW34mHZJU6M/8eou5AbXQLIMKUo0ZcZxWL
	 mh+i0kzU2pS1qmAC8bUxvc4nz+EtAF2a+ABmtHyk+KsJXEhFCj6Yeb8miH6Tpb2sMhU8M
	 GZ1BiXu1VfkjrdSBSu9EOZhFWvLsjyPKBTUKyhAMIKkKotWVuBUuB2g5MZ3YZzkS9Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=knpquf/8zzmsPOhjzh8isOju8O7biTj8QDNApaBaAV8=;
	b=3CVRouhdkQGv8rbpSVr+DBM6yNsYzZbDzq7+qcYYTecGH9m6Sk2EeswmlnI/8NQaamcP
	 8jqALEQA/qnEHRm7XavC4/wMUsdC2KE0oNWTKlNRKOdePB2Gw1XVSdtCfqUX4TH1jN63z
	 HVVIt5QbssUkVh2Dt11pIjDJOATx3uHAwaQl7fCEVrHU4wRgZR/kdAhtruY/Goa1cdENO
	 ff+dl0zGVK2JPbIPvH+/eqtX/YoUZyEJ0rn+qygjtDBO05cjPHGHziHUE9+cCft12MbRL
	 OHGyRjC4MN+GXs0HsYfUic/SyDnQcQ75SgrqXqWnOVvZswaYxKjbQ7N1yKnW0lKKaTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrVakPsV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6E606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrVakPsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F9C1F000C5;
	Thu, 19 Nov 2026 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115339;
	bh=knpquf/8zzmsPOhjzh8isOju8O7biTj8QDNApaBaAV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrVakPsV4uQkF+Zwn0TfYjFRcUM7KewPr1sgYE/UvouSN8lX8LDR2bVU9LHsLaq7j
	 myXWhPs/5TSQsOc3X4e16mVjRYMeuiH5vIus+f/vKkiETv5/i2gwY/yfzf5c0qj/LJ
	 vJWF0/1m3t7PVWp1PD48LvF1sFDzSbl7ILsJlDHM7aGuhDEbcXFaNcOuAaMDHlxuwz
	 yFWYYXHy6sJPhYl3KBcZVKjnKaVo9wglBk5jMAeeTj5FU8Xmii/4vNqAOeghbIokZU
	 M/kjud4WRoG9hiywS5TjscDCgUohcAD1+KayfC884Ho9Ks3Y5RL3oF4hmJAop0ejrc
	 u0uMkdwWiZsfw==
Message-ID: <sashiko-outbox-223833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/33] KVM: arm64: Use nr_pmu_counters in
 kvm_pmu_implemented_counter_mask()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-5-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-5-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:08:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> kvm_pmu_implemented_counter_mask() returns the bitmask of all counters
> implemented by the VM (0..N-1 and PMCCNTR_EL0). Previously it extracted
> N from kvm_vcpu_read_pmcr(vcpu), which commit 600f6fa5c90c ("KVM: arm64:
> Let kvm_vcpu_read_pmcr() return an EL-dependent value for PMCR_EL0.N")
> changed to substitute MDCR_EL2.HPMN for PMCR_EL0.N whenever
> vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu).
>=20
> As a result, when kvm_vcpu_reload_pmu() services KVM_REQ_RELOAD_PMU
> while the vCPU is at vEL1 or vEL0 (for example, when entering a nested
> guest after an L1 MDCR_EL2 update), kvm_pmu_implemented_counter_mask()
> omits HPMN..N-1 and kvm_vcpu_reload_pmu() wipes L1's hypervisor counter
> bits in PMOVSSET_EL0, PMINTENSET_EL1, and PMCNTENSET_EL0.
>=20
> Fix this in three parts:
> - Read vcpu->kvm->arch.nr_pmu_counters directly in
>   kvm_pmu_implemented_counter_mask() so the VM-wide implemented mask is
>   independent of the vCPU's current exception level.
> - Use kvm_pmu_accessible_counter_mask(vcpu) & ~BIT(ARMV8_PMU_CYCLE_IDX)
>   for PMCR_EL0.P event counter resets instead of open-coding the
>   subtraction of kvm_pmu_hyp_counter_mask(vcpu) below EL2.
> - Mask trapped reads in access_pmcnten(), access_pminten(), and
>   access_pmovs() with kvm_pmu_accessible_counter_mask(vcpu) (matching
>   existing write masking) so retained hypervisor counter bits in
>   HPMN..N-1 read as zero at EL1 and EL0.
>=20
> Fixes: 600f6fa5c90c ("KVM: arm64: Let kvm_vcpu_read_pmcr() return an EL-d=
ependent value for PMCR_EL0.N")
> Fixes: 9a1c58cfefb0 ("KVM: arm64: nv: Adjust range of accessible PMCs acc=
ording to HPMN")
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D4

