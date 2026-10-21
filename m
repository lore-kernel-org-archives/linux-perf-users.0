Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622523;
	b=N83kI2c/yiDSlQoweah9SLNTUDdHOxHG67zpJS87UV74UKO0y+f3UX0a774LCi38DjLr
	 UXSLzGx7uuhcPmCW68T1FQB+RBQjwCD1HZ6pcuQJy9BEIeaWVXYtCjnzO5kzcntOv9Pfd
	 E24EBTLe1AOe/LRsWxTr2qOEhJTk4KL9exhK2fAvi4aJJW1SjPt61wBiJ1aU/E67/qtsl
	 4YiYpmyZ0ildLtgu3II/Q6EEd5kPMtjfG2E2iMLTlmma7ewSPfpxcSnf+blLTiH52ZraS
	 DF5xruonWHRI8XOtzw1fzkFw+XHhmEC2Wrv9KS+UAZkEM6s7KZrNy+JIjXNMbhl9yYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622523;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2rEo8rsIFpPS8qPEI2rjlCACbRWn08nak2YgrPye4m8=;
	b=Mp41Wg4F1ljUDq+d3XUy1N5t2J6Kx/KN0PIT3zzV1Hmd9OPp7CKJ0N3MBlwl44hMxG8n
	 dDNIGJzNZMdY/cU0piTuGan0WtMdh3lbGlHNUVOFAKxfk2bf5t/BM+Um0LZ6kEjVXl3pu
	 KeejtIIgItMXgcJMa35hcHa+pBDl4xuyLvtnzfGFkyZH6piB++a2u53ug4ry83tR/jUYG
	 9D8DrsSvqBQzavu4J3kYA/9pxdd6RBhIStvDhmRxUNKHQA64aDWsqlXm9Qvqkk6/aV4vQ
	 VhiS8HIvANwrjApBnyIPoZMvq+vqM09zwGONcT+MuXsTSBi9OgrRJBv1jZ/QdpeVkKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS+aq1VR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B6606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS+aq1VR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528201F000C1;
	Wed, 21 Oct 2026 22:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622522;
	bh=2rEo8rsIFpPS8qPEI2rjlCACbRWn08nak2YgrPye4m8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bS+aq1VRR+DVFq326fovmiO0JQ3FVahxFYR3FMWzVE0ReGjSMsvBIPcRh5LlYQ/b0
	 C939r8OOkWMJ1atJRCrFiGQA6Vpz3MRXNVQtu2YZvKr/2hZ8u0eu9dX3ma7EErs8Tb
	 PqDdJkpLB1ysf4lAcSXHsHUDoPhZ6fx0P/lVYijk7rKrwn6qf4GDwLeZrYr273ANEk
	 AGN797tPQ31mYarAzD8/U0co6fD4PaUclOgIeR3yUzqz0Y7RkVl57ZbqIMFFSVqFc2
	 KW3nRuUCUh56GlblXU3LwspE++3DvKm8hJAtuk/Kd6O8O9ZHNdw2w+KJZ9esVsLWAC
	 T7XKMWp1AV3Hg==
Message-ID: <sashiko-outbox-180731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/12] tools headers x86 cpufeatures: Sync with the
 kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-6-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:42:01 +0000
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
>   87db7795cbaa ("x86/CPU/AMD: Fix AMD TLBI Erratum #1718")
>   dcfb0f2c067a ("KVM: x86: Expose Zhaoxin RSA CPUID feature")
>   54db9aaacc2a ("KVM: x86: Expose Zhaoxin PHE2 CPUID feature")
>   93134f14106b ("KVM: x86: Expose Zhaoxin RNG2 CPUID feature")
>   3ee865eb696f ("KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature")
>   d99fc2a7c5e2 ("KVM: x86: Expose Zhaoxin SM2 CPUID feature")
>   ac5cc691eb4a ("x86/thermal: Add bit definitions for Intel Directed Pack=
age Thermal Interrupt")
>=20
> That just rebuilds perf, silencing this build warning.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm=
/cpufeatures.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D5

