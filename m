Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622467;
	b=et02PS4wQ3ntPcsdnxFBu4AShDrdysBuPGOTuxzyeFMvjlibqKEt3dby3K//lqM0adc5
	 LJzjVro2pOG4dBsBQq1OsiCL598syg/nsDBQLeeYo+TN9GFRKN9T3ssEsRksL38dVxG9t
	 HPuMGsNqwvm8ac4o1XYFBdLQmvoEjwthmAStreDiyvx+XgLXTLZGhyfkh6HNjhPY4hmrn
	 kYjXYux9Oq3glHTexqrt+yf7XQIHBP6rbmTPmxFXALMtDS0388VMqDiudfBxFIDa25Q/I
	 plAxiVILBgLHpAhKr/2HgG//yjglufGqYMbZC05zfIjHUbSFOwhk4tPDxAF8QqHxgzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KlriokFev1LbJ9H9N1+gCzj+Nd5WweKfX1wS9rj//6I=;
	b=KdGGMCC1VSaM3h72z5cNvEmywZQ20v7CBUBvX9uCuehOusY8Xr95OLG7Hu82iwZRkagN
	 CCSmMslOG+zJRnzvv4Bvkt6wP6rK4civW18j9ZarSEc6Cs/J35MdToDFK8YBQntNO6V02
	 222ntBbviSz9xycHstTK+6ee+I1H6y/KH3lltfJCIfejfFvYhkHulrlmkIZFTzbFvxpxB
	 AchiZouniOPXqCOowB2FWTyDH7hNVIimzP4ZdpKrd2fCVmOAFKcvAadwmKkG/d3bsj3cX
	 fEYSuE1eVSHha7jdAaV27fbMX1hIIIeVMI63tJCDK0c2sg9C75L6l+CgwakL3juhT3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHhX1Tla;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B35606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHhX1Tla
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833191F000C2;
	Wed, 21 Oct 2026 22:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622466;
	bh=KlriokFev1LbJ9H9N1+gCzj+Nd5WweKfX1wS9rj//6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHhX1TlaVHtmoi+gtNP2397xxeg++ph0OsS44rVSk2vKvuQQ0Ag+5UdEfCNU5tlF7
	 YIqtbLZIP36A4sJM9PtsGS5MEaEDPONglPGvGFWGBdtGuI4LWEkwmzggIaYKTmyWl+
	 hZ55OFg1kyxrm0KnWxgXTWaKjq6s3BW+nz0oUW+gqtC1GmP59E4R++HlOpK/VMHh46
	 MAzy6vuOF6MN98oWpDg2wfOcec6z1ZcuoqEawj3E0o/TPi9Oys+08UdcpY2wxNTnUb
	 jrSZcSHhPLrsGqeKeGUF5O2Yo0U7r5remHP0yLaP+S26/ekRIrpqe+CJQgCeddA/KI
	 qbR85ZFnzu9bA==
Message-ID: <sashiko-outbox-180730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] tools headers: Sync UAPI linux/mount.h with
 the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223555.28372-11-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
 <20261021223555.28372-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:41:06 +0000
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
>   73b40395c71c ("mount: add OPEN_TREE_DROP_MNTNS_MOUNTS")
>=20
> That don't result in changes to the string tables generated from this hea=
der.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/ua=
pi/linux/mount.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Kir Kolyshkin <kolyshkin@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223555.2837=
2-1-acme@kernel.org?part=3D10

