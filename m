Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F45678EB
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062678; cv=none; b=GPpGkvqXzk4ceBXv06oWcHELO31zVG3R9HPwWsbj9eFnoxv0XMzCPCJ7IprCG5Y+UCePsCmaqzZvE44lYOJfBQQdxclHdINRhdSUkvkCRyRHfQdIWHQgobm5+veMrUsNtRcjvWnvwpXNB5j7l6zMsZ4Pbz/nnbaFwiVeZTq+qHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062678; c=relaxed/simple;
	bh=DqAZbknZnCUGt5leN6iWrxSt8bQCnVQIwtQRb6DPbHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SeWOjfEWh85NUss1wsJfyOnac78MFM19jpQN3w9i2P0NX/HAwxyg2dGsRYwk5q4P30MOvFTF/aStmKtK0zcyESVBcwHdqSL/YsXmJ5YGU0bdMsg/E9f8tJ5sXMx6xIvu8M0km4iCycZ12JysRpucWVeiaMqyi6ga+W4EGa/dooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To8frst/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To8frst/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61151F000FF;
	Thu, 10 Sep 2026 17:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789062671;
	bh=DqAZbknZnCUGt5leN6iWrxSt8bQCnVQIwtQRb6DPbHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=To8frst/9SZryfEjEMjUTzVOvIZJfuQzccj+gntQIjRXMNUrSeRloWrxXoT/MMrCa
	 eG1fMhB5EPkacJtxOXqUrrIMJzSqP0JWQFpV4zrLTepEOWk7zsTcc1GpaSK2Xu/PbZ
	 2Q4tzcB0j2dfO87+5zLtV35KukBLFqVRFCrWNyeV8fk2b4m0zQaWAk2XIQU1gU2IcJ
	 yxsfBi055HeAqsmHvYQD+WZNBcUuGn/s+D6rnB3oT0i4xSzzHvS+Bcy82QGpu0hsz0
	 /AWnjZMeXeEo/jnCZJPLC7MCmqoRC0tybPxNWx9KuZeB5/2UA+sdixhtYXZjVf//M2
	 a/PcvAVjWa3UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] perf header: Fix HEADER_COMPRESSED validation
 for comp_mmap_len
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910173715.2996571-1-irogers@google.com>
References: <20260910173715.2996571-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:51:10 +0000
Message-Id: <20260910175110.D61151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> This commit updates process_compressed() to ignore comp_mmap_len =3D=3D 0
> when validating the compressed header. A zero size is valid and may
> occur during testing.
>=20
> Sashiko review flagged string.h was missing (preexisting problem) and
> so I opportunistically fixed this and sorted the header files.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910173715.2996=
571-1-irogers@google.com?part=3D1

