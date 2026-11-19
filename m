Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114735;
	b=rkJkbqCHpn09lCs+pKJoyj59NbifIrWf3ctwQf+4ejm9Dx3VzalBe/Gqo4XNjftM3OUt
	 0nktq4uw5Xnu1Zw0ZkpBl0iO7ZVpn9oZ4CXefa/j/JlzwJVROHZywo5EG6r0Bo4NvRbxq
	 XkXDQdNWAeaF8gwHoLoyIlcKsU8wrOEdB2jgordziUZcKzkgmfWTrK9L3MMBbxykGaBG7
	 dG3T/hHX/crm26FwDtfm6IJ6DIHnElaxHILA2ILjj8XOUyt8/bULt25tVEG8DLklawNo5
	 NgS8mSDrdEcV4tc/bIbsaZ/gFfsUwVQsGe4hiynlJcUez3nwaxqLlXz2rv09amDsG3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MVFHfskGiLvQom8v/ZmvM9apoJzLIU+NWv9yaMWX4k8=;
	b=VzxEmdIQuNPsJPlBEpBdSRTypDw9RUw3r8Pzp6iWA+IQz1bwIkDP+twpdKJ7O56sgB88
	 I00eb2RI40VmKKZcopPgVhHcD3lc6lQlPRK6s+m0ItfYkcWm9kwkQYhUApjTT2adY6v5g
	 +zzL+k38vd9ml+e1ku8nkg/A3n5YzFua5CzsmhB/7bXgnX11CCXsfKPkPTNJzM1nPSSeN
	 TFs4cF4CyoRFmKW9jr9XHV4BUHB24N3BDShFynJn8GKkIPLwYAnCh6l0MyudeUXwqf1GP
	 Gk/S7aTQMzBvtR1rYaXbko/CZpYq3J8FmacOy+w3kDRpLAYsBo11GLcxZaOG3BRj3ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amwIHebM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21385606A336
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amwIHebM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959691F000C4;
	Thu, 19 Nov 2026 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114734;
	bh=MVFHfskGiLvQom8v/ZmvM9apoJzLIU+NWv9yaMWX4k8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=amwIHebMoxm9dXNzaYcvmskASUDaophTnJl2gq1VpB8PU8dG5+Z8+EazstsMb4uCc
	 39fSg9WILAuwvAPedF98rtDLpgV7sKonmtaG0I5G+SOzbjB9nqw/TijFPzgOuLantN
	 am//PkxLOi8xg/a+8FpbeqSj95On6egVwP8t0FlNzQ3TEvJeYEUJiDBGtjn54FBJ9K
	 olUbdTMEhJCUFLd/p9N/JTAjLRsaHkbm04xZrmZD9b/jSTXl8Ai7niijqg+7b0+1+4
	 dI6Ag1ScJeUEf9rfvLDh1lflvLPNmL7/hVXSliCYz7vLqyEyOb5OBVVa7hQFvKXj+P
	 QuEqaDErRMPVw==
Message-ID: <sashiko-outbox-223817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/33] KVM: arm64: Ignore HPMN for userspace PMU
 register access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-6-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-6-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:58:54 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Userspace save and restore (KVM_GET_ONE_REG / KVM_SET_ONE_REG) must
> observe and preserve all VM-implemented PMU counters
> ([0..nr_pmu_counters-1] plus PMCCNTR_EL0), independent of the vCPU's
> current exception level or MDCR_EL2.HPMN.
>=20
> Currently, two UAPI callbacks still depend on guest execution context
> when a nested vCPU (KVM_ARM_VCPU_HAS_EL2) is paused below EL2
> (!vcpu_is_el2(vcpu)) with MDCR_EL2.HPMN < nr_pmu_counters:
>=20
> - set_pmreg() and get_pmreg() (backing PMINTEN{SET,CLR}_EL1,
>   PMCNTEN{SET,CLR}_EL0, and PMOVS{SET,CLR}_EL0) mask register values
>   with kvm_pmu_accessible_counter_mask(), which strips L1 hypervisor
>   counter bits [HPMN..N-1]. Saving a vCPU paused in L2 hides those bits,
>   and restoring them while paused in L2 permanently clears them.
> - get_pmcr() calls kvm_vcpu_read_pmcr(), which substitutes
>   MDCR_EL2.HPMN for PMCR_EL0.N below EL2, corrupting the saved
>   PMCR_EL0.N value.
>=20
> Switch set_pmreg() and get_pmreg() back to
> kvm_pmu_implemented_counter_mask(), and have get_pmcr() populate
> PMCR_EL0.N directly from vcpu->kvm->arch.nr_pmu_counters using
> u64_replace_bits(). Keep kvm_vcpu_read_pmcr() and
> kvm_pmu_accessible_counter_mask() for guest trap paths.
>=20
> Fixes: 9a1c58cfefb0 ("KVM: arm64: nv: Adjust range of accessible PMCs acc=
ording to HPMN")
> Fixes: 600f6fa5c90c ("KVM: arm64: Let kvm_vcpu_read_pmcr() return an EL-d=
ependent value for PMCR_EL0.N")
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D5

