Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600142;
	b=dOusLlQag9+a2o+UCFkMO0thWJwx748JMxpC1n6hb0CvtqMpX6cgYGPFzHmfij1rdyrj
	 u5fMyj4MawiNR3IZkdO/fJ2VyM8RSIWnCpvIFihCXwhU6tpTvbMzlHcD/B+K9RGT1p7Ux
	 4bD3kzWIj6kPp7wA9rUivS+RakstQwPIAYmGSioUM/3ZXFycyMCuZjOI4EMXlxVX2M43F
	 WHbQxbxgQsLGQ8nNvDrSWVRvyHiWjH7vyf6s8QO7XtDZd2JJbDR569EJ6jOK3+Sr38Uzo
	 t7CsMRSHgMkVbRmFQqkyzsvUm/mTacYKAxvxtMFuOEJCQGSENyPjzXZ8a48DJ24ipiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600142;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GN41FqJdNd1hGrFYtOjVpQQqKa/BZmYbiLOxycTFdTg=;
	b=VriIQjSiCdU4QkrMeGaMo4V9dxCVP4xY9mke+DVnf04650jnZN4Q7EUhvxDWN97YLvTa
	 KrWLQ5Hg130ZcDvHIWHjTH+gpUZJTJUx2Dz1GXAEyZgk5tezhR59NkrwRPuFfIh0gvVbQ
	 q8VZN+jI4YPAgNTRpALpokmJYt9iAiV23zs+zx00bNn3NhBgBltuUFPbbWBhRI7Fnovdt
	 DUl9He5aFLaTOtyzl3HnWjzP8/hu3tff6HHGzOm1CCpSSTxtQvlAGL8RRfh53c/u7GJKs
	 UZ/18OoS9ybdHDc037XmgWkSU5qNJ4rCty+3KoHxNPexiJdyEYac+i2Vh3221eaRcCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbapSN+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177C606A885
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbapSN+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A51F000CD;
	Fri, 13 Nov 2026 20:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600142;
	bh=GN41FqJdNd1hGrFYtOjVpQQqKa/BZmYbiLOxycTFdTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HbapSN+4vCDAXNEaQpIAJ5gIV9ivl2FDwFsQiSiksAPrqeBUPiRNbNDQH7xAFkdke
	 yIqUDVnCjAL4U7p7YvekcktlwSZ0H0PerLbfEGevc+YArADNdKiTJ4bhoJGMT2hoIS
	 DTfh+MeZgVqryCRvMUme0kt24FjC62U+LxBo6uqi2+oG/ZzO/ToIn6J9Pf0q+5Xp5t
	 bPpme+9SIVBclrBJkSXSLWj6fxlix//LzD1mirkDn4Hj06hzK77YQA5pa+dTjsWrs8
	 c70Qbn6wwUqPe2VnJZsfpKEUhpJqXA9Sesa+h5W0rF9ySreSrD/7APgBZZDs/TGyJq
	 CppMWjN32kkaw==
Message-ID: <sashiko-outbox-213602@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/30] perf test: Make the CPUID matching test
 architecture independent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-16-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:02:21 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The arm64 CPUID matching test called strcmp_cpuid_str(), whose arm64
> MIDR comparison was only built for arm64. Now that strcmp_cpuid_str()
> is given the ELF machine of the CPUIDs and all of its comparisons are
> in util/header.c, the test can run on every architecture.
>=20
> Move the test from arch/arm64/tests to tests, as a "CPUID matching"
> suite with an "arm64 MIDR" test case.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D15

