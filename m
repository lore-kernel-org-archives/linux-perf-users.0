Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115618;
	b=oepul2khs0UEeO9HwRLbWy4RI8lIORIbQXiuPgmMu5q3f9R4uE36lsn5m0atBJJvtnfX
	 jWrgr2m+lhziqKydLAj3N5ZNd3B6kmfCOZW5ccAZ2kaD1YPYIAfMO5c2RBESjJYwerJII
	 UtyVd1SVU7a0iL4ot4UzlH4jcUyt6g7O2+pt1sOAllzBk54lfUv/fjxpDcs6QWZ4ZxluN
	 Dl3stZnajXtphcD2sxAlQcaWzTI+1Pj863D+0saDCO7AwyPoZivFN4AnucrK1jd27H0If
	 Qy6WL9gpkdb4hp2VoD181UY15xjFmN6IuihMDULpK1PN/W9uc9tr4vE8+/O/redO2gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115618;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iXJpArfs1ta/Wj2yVg/twU4KDeoYgvY8JL2fTnfy8fc=;
	b=crdaTfzofgqYsjrWomZCOlYBO+FIyb1iycjq63bzybjJbOQj0fmDZmBIgSZuA5E5ESlZ
	 KV/J3M+IfrOR93iC2Si7pwYMaUkJlufzkJe9VDyqTXWbt/CylLVL/X4ude2Rn+sXKmdpT
	 /CQg4Uzjnenwz88QUtArww1+BGq+lEkVY/CMmTBNRtvVVH9NkaEFNA7ygmsmMPoPftEUt
	 it77LJWzjilUvZF1dR6jxDTeNrWkK2uVbMqT5X1wPb4cw0RgIQ6aaeNM1kxmEzC5tH19D
	 F8lfWmH35X08zGax/FS4LkhdTHZrQeqkwTD67BkfTRWuKJ7cbWbNOyT3QB7KSYR2EbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk70EaRT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6708606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk70EaRT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A651F000C4;
	Thu, 19 Nov 2026 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115617;
	bh=iXJpArfs1ta/Wj2yVg/twU4KDeoYgvY8JL2fTnfy8fc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mk70EaRTbugbXv7//RZVInLTg2bUCmo6QLPEJnOXRMyV34VJMFHv2iURqMP9LDB67
	 pCSBNm4sZqfoB/uWUIcmxHxErEAxlRGIKoah5UbTIHs609q4OCrwI0JuNRUgeHYM2o
	 1oiP/bIYewOzQsBTjmwY0MspsvcJxnb1i5jPMByhm6LPyjcDeUC9UqIO/Fkc0sjdqB
	 P55UYAQpY/j3ZsGYKzfhFdYSBnw3ROYQ7NFa31ZJ6qXxf0dvcFrPXE4P+jzQF5Su5t
	 sNyNEBOdXje8ecI9tHBfH9dVTrSNb2qZ+fmA+1MFivG0Ebr2wUCoFSGtp8ikWQX84V
	 8OaOu6EO9MDWQ==
Message-ID: <sashiko-outbox-223846@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 28/33] KVM: arm64: Emulate trapped PMSWINC_EL0
 writes for Partitioned PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-29-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-29-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:13:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Even with a Partitioned PMU, guest writes to PMSWINC_EL0 trap to EL2 in
> four cases:
> 1. Hosts without FEAT_FGT, where MDCR_EL2.TPM remains set.
> 2. Before lazy PMU activation (VCPU_PMU_ACCESS_FREE, MDCR_EL2.TPM =3D=3D =
1).
> 3. Nested L2 execution when L1 sub-partitions counters (vHPMN < N_L1),
>    where MDCR_EL2.TPM is forced to protect L1's hypervisor counters.
> 4. Nested L1 execution when L1 sub-partitions counters (vHPMN < N_L1),
>    where HDFGWTR_EL2.PMSWINC_EL0 must trap software increments so an
>    even counter at vHPMN - 1 cannot chain across the sub-partition
>    boundary into L1 counter vHPMN in hardware, and so ovf32_mask
>    counter biasing is preserved.
>=20
> Trapped PMSWINC_EL0 writes cannot simply execute MSR PMSWINC_EL0 at
> physical EL2 because L0 runs with physical MDCR_EL2.HPMD =3D=3D 1 and cle=
ars
> PMEVTYPER<n>_EL0.NSH on guest counters, causing hardware to ignore the
> software increment (and when not loaded on the CPU, guest counters live
> only in sys_regs[]).
>=20
> Update kvm_pmu_counter_increment() and kvm_pmu_counter_can_chain() in
> arch/arm64/kvm/pmu-emul.c to check per-counter enablement
> (kvm_pmu_counter_is_enabled(), covering both PMCR_EL0.E and
> MDCR_EL2.HPME), current guest EL filtering for SW_INCR, and
> nr_pmu_counters / sub-partition chaining boundaries. Reuse
> kvm_pmu_software_increment() from kvm_pmu_direct_swinc() by flushing
> live hardware state if loaded, applying the software increment to
> sys_regs[], and reloading hardware.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D28

