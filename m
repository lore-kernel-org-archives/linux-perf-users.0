Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115763;
	b=FFevxteINX8bc9D73iOFKv3+Moqf0LCyqZqvodDYE3NWtyIOlO/+92SIVTpIu9lc34cN
	 7gCm/JEgwSjG8hoYSxWgazB5EBvbdpZNeCFX0vFTBHzdkNR5KFHq+ZHfgqJjso447U+cj
	 Usp0klB6urmAdFzA8UnEZzFp38m5oYA8STwMzXhH2DnFjOEx5+EnhByyHKQ1mHN3rkWHB
	 ZUuN8T0TP5gR+fOhk4wk/xzj09fAsSacBKPjg8UbDc5W8FCKVHJC2Vy/KcX+T5cdUBRaL
	 SDZtPYJPw0lDoJvh80bIchrMfnYGmnECe3ofO3ozG7d6V17kWPrNNd1KOEu9X7Zjydg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115763;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gOP48GUrURTd0keWpKOJJ3D6MGqveudihU20qlRsT1M=;
	b=5QquTW9nKZ8RoQCCqbcL8q6jFZNEU1gerCiaS/O2xhb0EKcB1jr2WCILUGK6M+rgIoH0
	 wKnDiyjoQtf35TWFTcxFOIMr8AjzwnilfcHDkGyZV8WPe2LndcoE60LQuj3v/nlQzHEVT
	 sK1oX7ZFgm5WGJdsAuBc7yhoEEDuvFUQCYfr3D2Sf0lQ1IvVqnAbnM8gowQMrTGfrwRIP
	 5SKyydiUtzJ3/Up38vLK3HyKpv/tVq0F1JjzCLWBACL2a9KjDal7fT7S1Rw4jr49kWjjp
	 Uh/9rdPgRH9JdOJglgsJXK1yhfo+A24XjUP+WxE4sT/VPJyekmiHto3YIfB5gOI7/ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwGJbxXl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC86606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwGJbxXl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE6F1F000C4;
	Thu, 19 Nov 2026 19:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115763;
	bh=gOP48GUrURTd0keWpKOJJ3D6MGqveudihU20qlRsT1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BwGJbxXlffRHlBPFAvS8jKC+Ctj0zgsqDFXIriyEM6MsADNjJYPNQkQRHZ4RIHfSR
	 okcVTOpCfiBq7baFXYsh8HkgcmRFYH58IxzZ684bz6XISgj3QqqUI8wh70bAJaa3He
	 NiZAWgW7OWousQTtS8hmvnWEg4Y/0OXbZNAnUWWfcRlr9ZOy91rUZ3bxrP/aR8v/RE
	 71me43vJpMzHR/+ecyo/VzYMBVHXuqdfUxlWTtE1M4Q3nMU0E22sCvzqb614L1Fkhq
	 pKQjHq7rCfwUvqy51kTfcBavATbc3PnLyXQBr5f6VJCYWqSvfCRTOAW3EYyOg5aVpD
	 HttdnpbormxUw==
Message-ID: <sashiko-outbox-223857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 26/33] KVM: arm64: Multiplex PMCR_EL0.E and
 MDCR_EL2.HPME for sub-partitioned L1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-27-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-27-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:16:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When an L1 hypervisor sub-partitions its counters (vHPMN < N_L1, so
> kvm_pmu_hyp_counter_mask(vcpu) is non-zero), all N_L1 guest counters lie
> below physical MDCR_EL2.HPMN =3D=3D N_L1 and are gated in hardware by
> physical PMCR_EL0.E. Architecturally, however, counters 0..vHPMN-1 and
> PMCCNTR_EL0 are gated by vPMCR_EL0.E while L1's hypervisor counters
> vHPMN..N_L1-1 are gated independently by vMDCR_EL2.HPME.
>=20
> Multiplex both domain enables onto physical PMCNTENSET_EL0 and
> PMCR_EL0.E whenever L1 sub-partitions its counters (leaving
> non-sub-partitioned guests completely untrapped):
> - Keep MDCR_EL2.TPMCR and HDFG{R,W}TR_EL2.PMCNTEN enabled when
>   kvm_pmu_hyp_counter_mask(vcpu) is non-zero.
> - Maintain architectural guest PMCR_EL0 and PMCNTENSET_EL0 values in
>   sys_regs[], set physical PMCR_EL0.E when either vPMCR_EL0.E or
>   vMDCR_EL2.HPME is set, and program physical PMCNTENSET_EL0 with only
>   those guest-enabled counters whose domain enable is active.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D26

