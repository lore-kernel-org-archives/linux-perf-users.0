Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138818;
	b=KnmTyL9CTRIFAQIqGFAgwvQtwGLd0IQD7jqN45RE7CdLELkAUmpnhpeUh6JWTehZNLsp
	 bpwhT8vdP21cN/HI3tcrvUVDh00s8Ih5FKfqdgYfrxYAJvBeDPy/7DLJ2k4VqrivyGBXM
	 baR2qM5ESGpYsdPv8eFN98jpEFShIraSwLVI+Xnfe+5vkR8F6h7v0qQcxvE2Hr3lgUvb7
	 /XCsRZukiF7E+Vz8Ed0uiny4yxTzgSqNM30ufrEQkbsFwKlzZULHArcgS5pMJQAqhtj2A
	 tFeeQhkkpFJxUfINqvbusrqSRqQvtxhVrS3RsEL8KK9ykTymMKZ1jcHvPT+8Okrg1mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138818;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VK7EGTw+IutSPQYKJJIAxDbnwSyO2OK6NljNOA/BSO0=;
	b=uF5P26ra9degptyIkJC5Kf4ohmqlboEbAJyH/pzq9ZvfBo91S+xJre8rN4uv3JFrrz3v
	 pctJCY/HDz5DqBZ1D4LppuQcJpA3vr0Ran/tofuV1mjC69rwarX5kmvC3l+xDo/jd+TXP
	 AR5JCWPDGU0GooTSx1xHvn0bAWIs+BzKZvHRxXuZeDBl/QBe1Pp36dRD33Zmnod/7r0bl
	 PhAi2K358GydR2L+xRSkdr9ARwSDgMpr/9o6rnXs9aSQMrpcEzR9W6Ps6RVIT+5eo9hgb
	 QE1+WNptgPbCG6JCLb5eVKjWksdosGGkaVCBLnjbsctBCrPJ5Nvv2vluZjdF7BIHZJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bq3kZsUJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C89606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bq3kZsUJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767681F000C4;
	Fri, 20 Nov 2026 01:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138818;
	bh=VK7EGTw+IutSPQYKJJIAxDbnwSyO2OK6NljNOA/BSO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bq3kZsUJ0ESjQAhCSKApkSqrO/mqYk6FD/6C3hlcFN7dx7uwGgJx+Bw6Wn3/pOPM0
	 0LHMmLxV0gqcd1OXmkgKwgq/RB2kvvBNB4dngn1GzqBAGXUOZdhSPbKxzbACXmW4Qk
	 mau4z8vPYBBxQ7WaW5cTyru469hT88IfxnpxzTGRkMEvESTmFsqCaNPl+u4cWoXOZ6
	 y/8PWt2UVwfCym6z2uLxF7vKCJJKJRdjGOXLonXsFjXQtTgXDTYH1SyBZjff/p2lE8
	 CPHf9TZTiwYD/dYXzgmCte0BQ7aM+JdH0mkobeVRkCCkfl1bjT0Zaktro5kTkLhp7H
	 HbdpL72tgPmNQ==
Message-ID: <sashiko-outbox-224333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/13] perf build: Record the features checked
 outside FEATURE_TESTS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-11-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:40:18 +0000
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
> llvm-perf and rust are in FEATURE_DISPLAY but not in FEATURE_TESTS, and
> jvmti and jvmti-cmlr are in neither list: they can't be part of the
> test-all fast path, which sets every FEATURE_TESTS entry to 1 when
> test-all.c builds.  Since FEATURE-DUMP is written from FEATURE_TESTS
> only, a FEATURES_DUMP=3D build, as used by build-test, never sees them and
> silently builds without libLLVM, the rust workloads and the jvmti agent.
>=20
> Record the display features and the jvmti ones that aren't in
> FEATURE_TESTS in the dump after the regular feature checks have run.
>=20
> Fixes: 206dcfca1f5cfac3 ("perf build: Autodetect minimum required llvm-de=
v version")
> Fixes: 3f5dfa472ea6771c ("tools build: Fix rust feature detection")
> Cc: James Clark <james.clark@linaro.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D10

