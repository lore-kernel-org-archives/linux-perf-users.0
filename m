Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115866;
	b=PRMY7APk/O+bnCpQZ+FuKuTq/fVXxf4fxOY32FvtaT20Vg0Bm1aH5V/T8ZIRW4QyEBhv
	 XwFWLI8IMTJwKHenFldioihab8tyzh0oEKw5SF6rVcTv8kFJoNsxZhM3JHru88VeTSMAx
	 Qk8CjgMaVA8MWSgRUT7kCnyWQxlSMy5ijJMyfolk/AFP28UQitSlcDY19Grrhcminw41e
	 mJaCBFWoifVNWXZBI+rk0GDd9D431AD9sRCWssg0n7ANVvX6ZKMIuzBz5w8CR0pcG1bnv
	 9PSybsTTSggHhoQmDb7Q/mDkgV8hebWApdYhGAdxMOeNYGnvqrODl8oIIJIQdtRwuyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2kBlU6u4cnRa0ckri0+d58nSankr6UolyJ+8O2wWMHU=;
	b=qcv8Rig1CVNbBSxdO7Ufjbz8lVm/v2tO8bE7CDDPV4DtgHp2lBGikxyeKbAa/q/AsPr7
	 AMOIlN/WhRfe89/DL5PfQJeOMRpEKetxZBVRqbs2Ypax8NDYGkWB5fwshsGxnIXB10gjl
	 y3rR939VoUZAqJ+9kmzBOtetMCSkxu0ZFYHRHik7hvgaWrZSQW9Y2fOqGQD0NYk6s5qm9
	 KSHsb/z8jw+X9pnVqZMZ1bVpp0SH0CjR088KTQXfG4NbzpW5RGd4jPffgGrGO1fw4VKDF
	 sV3avfCizkzoSwowO+yJiEIMq7vHldRYOX8DsJ/vKAHIpVBRFlyN/dMMQRPz0Y/U5lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Pcr7b6/z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949460A260A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pcr7b6/z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40301F000C4;
	Thu, 19 Nov 2026 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115866;
	bh=2kBlU6u4cnRa0ckri0+d58nSankr6UolyJ+8O2wWMHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pcr7b6/zF9oxMxhHJoNmVAXKpLFNu0vJPXMdLoFvNy4wB9BAz8YtspyPCTJhj0uII
	 wdm1FdcRrbsAeq6Z9TW6SoLTz7bMExK1GussJxG0lkLKXakvR5XG2Q2t4VA1mIO5vW
	 au/T2qzxpS+z2Jkh0mwQA6wvheP20bueOuFTNqRiue7Be6ZfNz/iLI/j+330G4iJaM
	 t53oXjAFJr1QN8g8MXVigmbd0jI++ptynIOTyh/KcZatUjzoYKO04FVnEyeyFI+U7i
	 2U4rhMcbTAYvDa3Qsq3AN3rbUowesGy81pzDlwq+XN3xMGiIJul4AI5kBrkXgvOQQp
	 +qHkKZ/3NTxUQ==
Message-ID: <sashiko-outbox-223861@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 17/33] KVM: arm64: Context swap Partitioned PMU
 guest registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-18-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-18-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:17:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Save and restore the guest PMU registers that are untrapped when the PMU
> is partitioned:
> - PMEVCNTRn_EL0
> - PMCCNTR_EL0
> - PMSELR_EL0 (when MDCR_EL2.TPM is clear)
> - PMUSERENR_EL0 (when MDCR_EL2.TPM is clear)
> - PMCR_EL0
> - PMCNTENSET_EL0 / PMCNTENCLR_EL0
> - PMINTENSET_EL1 / PMINTENCLR_EL1
>=20
> Mask counter bitmaps to guest-reserved counters so host-owned counters
> in HPMN..N-1 are left untouched. Clear hardware guest overflow flags on
> load before enabling PMINTENSET_EL1 to avoid spurious interrupts, flush
> pending hardware guest overflow flags into shadow PMOVSSET_EL0 on put,
> and restore physical PMCR_EL0.E from MDCR_EL2.HPME on put so active host
> perf events continue counting.
>=20
> PMEVTYPER<n>_EL0 and PMCCFILTR_EL0 are loaded in the next patch after
> applying the KVM PMU event filter. A subsequent patch makes these swaps
> lazy until the guest enables the PMU.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D17

