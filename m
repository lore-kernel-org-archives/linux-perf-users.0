Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693703;
	b=QJwOfs7AYQ/yfem6QFKCeZ2H5s+DyRVAwIPwHs03wIGn+mE6MTHc5fgHdVF6WtJUM5yb
	 +Rj3vQk1zoDI6hdp/YvK+R4tUL+Ai0uJWdUuydJgEita1iAX8P1w/wtjnw8rDt7GD7bSo
	 8gEXpwUxIgjzmR/jv2HPCuEqoHYvBNIhAt6eVXePpdm6C0ThiDLsC4I8QgxJUKe++6ZbV
	 K8TJn5Rs7qGEyb8ahsj2FJQXhfkMUpMqCTW39kAZUfUmYM5PUHZHMpExoD31Bt4oa8nba
	 AAhPTIoLocQ6t7/SQvX86z+EmX2QtOgSgMhhErMeBbMvkwOTLAdC9N2Q3BhdR4HrPRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693703;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2YSpTJSI/s7P3mPBxAW3T2mmso+JwW2VDLcIKYa6pg0=;
	b=UVaIWuCf5lCG15sarR46H5xWWYP8qeffkO1QMXS/n5hewPCvODOvUr4Q1y+GGTyxnJ92
	 akS9B6s/JIDkr2W7GSn9t0BUsEXtulAo3s+iZe5YelFJBqP07yh5yQ/EyetSeuy8LUU5/
	 Ld8Tcpdu9FxsSISK+ycDISd71gSFuS6uQNNpTt09j/KMrgUJNyMUKl3xwbx8WSp1zqv4B
	 e1c6ZMbYeQnJB/ywaU5ANaBbRSBpqulRtlXZFnY93UxsDxc76veR389obJ5U8oUY/SG8Z
	 7V8CtBhUBoIfDHh7TjPbffPDAiSFNeW7L9wmub7zFNBy7+28ivDaVXDx+v03aoaYw5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkHgeRIe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A578606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lkHgeRIe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CAC1F01825;
	Thu, 22 Oct 2026 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693703;
	bh=2YSpTJSI/s7P3mPBxAW3T2mmso+JwW2VDLcIKYa6pg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lkHgeRIecf5VZWQr0w86TgHVDYecnfR0OxjVY42r0Tlxn5jsybn9rKgj/Q6T5aOfZ
	 uQWPkJhUvvDgyfnPncMTRIVrr8W5RBrfmBu89vpLrMdHF5VFfSAg0ZEE+KTWIuFMMt
	 mQYKxwjyyd14Z8d1FqsS6mTjhRfjotLp9EB2xVrMcnKa3xUIUS4LqH+k1WsHr3WL/n
	 AnSVH/kAYlxeULwrvA2Pg1diSmvEkdgOGQ7iIGIGGdiKqi+oOrlaoxg/H7cqJC4gcn
	 apsSUtnChG38Wzpm8GZbJ9QUnVrAf1gd0QF2q8JNdysIc4s9af2dCNaK9rxHmeBK91
	 9IIJJcL4UkVNA==
Message-ID: <sashiko-outbox-181916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] tools headers: Sync UAPI linux/fcntl.h with
 the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-7-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:28:22 +0000
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
>   cdf930a00949 ("fs: support FD_FAILFS_ROOT in fchdir()")
>=20
> That don't result in changes to the string tables generated from this hea=
der.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/ua=
pi/linux/fcntl.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D6

