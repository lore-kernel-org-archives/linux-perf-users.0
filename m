Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115747;
	b=rGc/IpNzxPtfw2JbM+BJyiRQqgDdK1jzK20ZH5w1NAMIsszm3uX53kg8McSHgMyTf+T1
	 oGCJsq6RZ/vbMMhBQEEjjQVVphqbPM6feTfgFbX0P46zgsGuygh8izGrTUDLPcoLiv4fg
	 4fQQ17dqQue8evlR7KvTjWRtl3WY75v9ytzcmXGw1TBLCsKoUjI42T/eDd9LzXsrlagpz
	 cTSSTmVnsSPOqcQxMlMNBcKS93TRsPFqWRIAJ69hEXvUXPSlrihEKmsT2EbAPJYfW4eDX
	 de3eEtSkATpPPjDVyFY1q4yr4KtCy8JA/qgFbulox34/SfQut2aZ/gpbNv91r4HqMJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115747;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ezIyzByGOdQHHCe8Y5rK0Al++jgHvaIGBWlLLRunGE=;
	b=VF3b+AGPSNWzZZz3KMbk51YoRv6GCURrhGQOdSp0NhKnWSDR1V2Qp8KLnp8gTi8ZLiOX
	 tDOMxzEv5eEMRd4/iIRYtBSO8bIGYzBu9Bs02TfFOxZO96roUX4ZL+4y5+WOi3BtIvyvf
	 K+ebo6PgTltOSWZcrxn8SiTRj3Y32dQKMhdzuEP093+rqnvAzwlsIm9wXD3VSskKr2vwp
	 bdMNUoH2Jb5A9jNrfhBqU3qedzs0VkkziqPxe2u851qtaet8zGtR319Vftk4y5WX9jvJk
	 +2PK1BobF8R3/eslnUMqaBKeMEOGJCmakA7NKys3js1gbVeFqsKCxeri7pkGmNKam7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hod1gXHp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB41606A32A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hod1gXHp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78751F000C4;
	Thu, 19 Nov 2026 19:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115746;
	bh=3ezIyzByGOdQHHCe8Y5rK0Al++jgHvaIGBWlLLRunGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hod1gXHpzGUU+y2LMOCF3Yd4q3asKF2erqMjotCPwI12OUbkMc9D8oKLdIqda0ejh
	 o9hgS03ygV85dh1o2vawDmm8c0fUObZrRVwFJp4twiG1c6m+EIVjYXuQ3A5SF4hs9n
	 BDd8hmF1GJjV9OIo6K7J6I6+QpM5kpWTqPdTxvTW1HELQ2e+bj0SaYtIJhaPHkBrtU
	 1/6+x81Sp6rxrri8bh3NDhp6AozfL1ggqDMOyuqMCChCBxEJ85ANry1GlAWf0T07Nf
	 p1tQMQde+/4lLWk7AZku7AgT4coX6TNY8wZqJ25QSvYcpvRHz4yTgILImebZaCpvev
	 MBlp5RwC6wIYA==
Message-ID: <sashiko-outbox-223855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 29/33] KVM: arm64: Forward FGT traps for
 PMXEVTYPER_EL0 and PMXEVCNTR_EL0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-30-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-30-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:15:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When an L1 hypervisor runs a nested L2 guest with a Partitioned PMU
> (vMDCR_EL2.TPM =3D=3D 0), L1 relies on fine-grained traps in HDFGRTR_EL2 =
and
> HDFGWTR_EL2 (PMEVTYPERn_EL0, PMCCFILTR_EL0, and PMEVCNTRn_EL0) rather
> than coarse-grained MDCR_EL2.TPM traps.
>=20
> Add SYS_PMXEVTYPER_EL0 and SYS_PMXEVCNTR_EL0 to encoding_to_fgt[] in
> arch/arm64/kvm/emulate-nested.c so L0 forwards fine-grained traps on
> selector-indexed PMU accesses to L1, using PMSELR_SEL to check
> HDFG{R,W}TR_EL2.PMCCFILTR_EL0 when PMSELR_EL0.SEL =3D=3D 31 and
> HDFG{R,W}TR_EL2.PMEVTYPERn_EL0 otherwise.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D29

