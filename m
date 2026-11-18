Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032227;
	b=t1cxPAmqCKftZ8+BY+TBt1omtHMyyomeqVsOLjbuWtyTgU3IUJFFbmWa5GXolbzA40lM
	 E2QitQO686I1h7okzfxIugg2iFFPji8N9vWXsLOceStGmDLd/FMnInq8PSQ4u4h5IGyCV
	 AE6YXxQ0MBJbMBEqyYBz1LJgqrJ/NE4nYQDQz9AUoK+25UeTShN/KNvQ9zZeM2Lpf/TWF
	 r820wVGfPcd/TUgYeExbim+0LJq6RO+d2A4OjXbW6FsMO83BJ+rFnaNrjaAGxtq9AZZbg
	 RfBoZBW/r327dihJnewfzxLMRz09Cl33GUYpdiN62NPu2GmZJW9uoRHvyrrpWo6Wtrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032227;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/kjw+dpfV3VJrccstA6TRu+26HMO0GjnjjHonhTR8qU=;
	b=tc+C2Oxb4e//qH6crAgtkcX1/ddnBLtG/kqWksyK/qe76YBk6s63BbzLZovd/CS33pki
	 WupSGKfMMdVAL38XDhcwJzDAS/nXoYtBgEDoNpNhh+z/z1Vie4OH/dDgicx8Abf5NvSjt
	 vsf+uXIaYNNRHYmfNIgEi3CenJEDAe3mT+YSsx/5hicJKDlnrfp3AR7z7+FNRsAF+4dCB
	 frFqRBjqXlWXffQ7XV0r9EEJkcoWjY4IdVBdgMLydlB167BVvX2udgVtyHY64vKOzK7eX
	 BwEtQYmPdBTc2XAXEDRTqlYCbJIf40zhfK0J795G4kyTzxD+2Qbuyak4TCLlM/eNZ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gceva77F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB776606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gceva77F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536D81F000C4;
	Wed, 18 Nov 2026 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795032227;
	bh=/kjw+dpfV3VJrccstA6TRu+26HMO0GjnjjHonhTR8qU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gceva77Fp2xtFZty2H6/ooDG1JLhDV7ff+TuSsDisyR7B9H/6Pl8PM/9dRM6SnpEi
	 xiPyjVOdB1NE4lv6kxqsflypg7RoCm3k9eHfrXN8ZLQgeB6Y24y/UGvfQezAb4xC43
	 jGP4eRMC9M6qBbsUkykrM9DYa8b1aZVzVHjplJVDCK5PSRI+b6To7qHse1ePIuJVPl
	 m/VNVyvZHj+o9YZDF60PvIrn64FPnLXi6qvMNEkAszK5t+dGJ3II6eFii4+dZou4ht
	 Tli3JDSFUpWLHGLSFMyBpmpls8gutLFYgOn4io5xhfRdJAAWxWVuwYm/IR7NLJwXZu
	 Uz6bXtELnYLPQ==
Message-ID: <sashiko-outbox-221915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] libperf mmap: Arm64: fix transposed reads of
 counters 12 and 13
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261118200057.2134362-1-irogers@google.com>
References: <20261118200057.2134362-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 20:03:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Reported in Sashiko bug linux-3291a858-209c-483a-b4dc-eeb57abdaee6,
> the 2 counter read functions for counters 12 and 13 are transposed.
>=20
> Fixes: 407eb43ae87c ("libperf: Add arm64 support to perf_mmap__read_self(=
)")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118200057.2134=
362-1-irogers@google.com?part=3D1

