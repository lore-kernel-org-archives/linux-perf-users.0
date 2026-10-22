Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693730;
	b=uf4k9NQ+ogekJU95PvX04peL66yfqrxgBpMAW62tJPI7smDh0pFGKJZJXsjSWtYysD9o
	 B+fZm08figT+2NkiBKeOJVY/MfOs5DJNG9yckEYFtXOSR7x+FVUXoceOo2W0QsMNXrh4F
	 Mm9vytgqO2DdeKqRx1qE6mEXaRbbtn9k0ykBtjc1KyyaabFSSVWLsWMcry0fvGRqE6yci
	 c7nfF4OjkAA2IH7LmpnRw4QJOHBsqFtKyrv/uDIOtwglWJBDJyu05fqyenJ77KFwFVw80
	 TVGfv10cKNniZtkJw3UkHNwRtlhlzYYlCufUVDh9zmS7wU6hmhyAIG3i/wASG9rZ5dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693730;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zwFMQE4zbzN5HxN4a0CbB0H9tXmhDU3NLDw6OxPLG5k=;
	b=L9XsbylNNaHCx3N+8pC8QwS/Gi0ZHCpGERBb2CusCj/smoT6RNaaXako3eIDVMJf/En/
	 Xj4t+uSvwaTTxMFQAZ5XpFVEwLaffvY3kGpFMELgJdBYiRTWAIW/lEB88atS3lx+AeMaR
	 hpNg/kglb+Z1k+QKIooF4Enl2kLEJKWJCFKdKGNTWmqVwvRyRPTD9we8+M3kWldauN9e6
	 M69pXRRn3M0rZkwaJaX45/g+pj3oD9fGhfysUykrgjfXxBomYiXmVyW7k4s3Roqt0VpfN
	 q1eWsRv90JblYfHt16/6CyzQ8/B7ENawgjr7gTvecsnlSMZHdVrZRUTfXdIuzKD35kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeULbyyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15A606A32F
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeULbyyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350041F031E0;
	Thu, 22 Oct 2026 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693729;
	bh=zwFMQE4zbzN5HxN4a0CbB0H9tXmhDU3NLDw6OxPLG5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EeULbyygRkLDI9kGeySm2qLYHApCJjkxSRWsdOpCKTRCanKtKEgCk0vuHE/APQUHY
	 r862UJAsz27Tw5SJQftx+l7ybSPp/pOPkQ/jO4NlK0vI/peefh84rC4sliscFfC8DH
	 Fnr4YY4o8jfsxcVWyz/lf9hkdT+XJNxzpX34XJFljV3Q+t0TixyLyy83KQZDRgH/lZ
	 9Ze1bB+YrmkLh+72BW81Yc1LwZkxTUXMUTnC96B2wKa7A+L3CI7GikymjLHWFRjEV/
	 7jo+osk7FcyIBSLLjU88IAtWGIXHPDskC7KLZtegF37T08qxYEWqQy9jz9fi1OBE2g
	 eeO1JJPGLPAig==
Message-ID: <sashiko-outbox-181918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] tools headers: Sync KVM headers with the
 kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-11-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:28:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> To pick up the changes in:
>=20
>   ac3e65ddddf3 ("KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up =
ioctl")
>   ad220e275c39 ("KVM: arm64: Add KVM_ARM_VCPU_PMU_V3_STRICT vCPU feature")
>   7bb6284aa7b3 ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/vi=
rt/kvm/kvm")
>   b76fb087efcd ("KVM: PPC: Book3S HV: Implement compat CPU capability ret=
rieval for KVM on PowerVM")
>   453f6ff04b8d ("KVM: arm64: Expose PMMIR_EL1.SLOTS under strict PMUv3 UA=
PI")
>=20
> That don't result in changes to the string tables generated from these he=
aders.
>=20
> This addresses these perf build warnings:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
>     diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/includ=
e/uapi/asm/kvm.h
>     diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/ua=
pi/asm/kvm.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
> Cc: Congkai Tan <congkai@amazon.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D10

