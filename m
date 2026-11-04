Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827967;
	b=eXbUB6W+PKVtTPPknRJaLKDH5PbVW57cM2EnkVjh0frQM57HE/jdoj8NKz+ED/qiul6s
	 RqV1T9iV5fOqep0kk8wLxUv6lM415WjLdBNuEaC4/3IkiCGn/1qxVOdgmH78e8SDW8bKA
	 qt+jYQSkVP+UQkP5RaqZHCUcuc4pwSYHogTl+Oaif6GxpGLwkdUKpqJXyqOU2UmVovmUw
	 WH/JJZ7pAze9NcLj4vR52+YO8cMhPzQSHRiLHhEBXr0A0thBFV5I6dfeEr6HBhiKbfPYZ
	 oLguINguRYfGhD+zrf6EA+pN6K7jx//opesKsDGrOZBjUI0XM/AmHGQZVdzDYr0IHKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gIES0Ajwwxil5KX6GpNL3h5uv/wvv7iEiQyo1PnwBio=;
	b=NQBZUqDu2m2y9PvJqA28f6Ap2KC+7haCYdhbg05mqIVMpLmRRDOIS90Shxtm+PIrYqnX
	 t8MzMjZlNdPFnpEE/2ZkxfcAcSXJq/H5gqrAk/pQc5IUGQevnBly3bLmJUw4xaj4YOB96
	 vqO9dP8uOpBVz1GAXMybfb6cWgCf+d761vdn92/mPT0D1B+FJ16y5kXjB7vfQa6iQdeaU
	 dGT9S923X3BWEcRRhQpVEemQUO2dSvzaIgodHLoMiZEBk0M29dPtHhcWC4cxIxQqiHMEh
	 hSd7HKZQZYdIpoK9jYnkQka4cqdLdKLcYqd5LA/dy0eU2bBQqtWZt7aOcCqhXntAUug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9fk7akW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD5606C599
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9fk7akW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0DD1F00A15;
	Wed,  4 Nov 2026 21:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827967;
	bh=gIES0Ajwwxil5KX6GpNL3h5uv/wvv7iEiQyo1PnwBio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c9fk7akWrFs7OZZd4mgBDPd5dWqMjJfTm3GdtrnVQ1Osa7Iq617mhHky2H+pM7s9Q
	 zNi5PKPBBVSNRl72Dzm6uO3Ev5h/4AwdMa8GdVweZSnFuGlnmgVjMvSdUL0CXhjIHQ
	 awi/rHzh1gULQ8iNopU6NTe++kUphEUIt+HE12V0q/8mPU1cN3wi8gfT9YfYFKklmd
	 SIHJtrZK/WHj+GzIao/NVjzfUIRkrBGBnrFvvmNKCLBsnFlY8Pxytzvxisn8As8izH
	 SVk2j3hhPWIA3w4gWa+iwkCDFJ8GsksC5/tPLi2S7tQkVIkGvZuYGAOlAObAGwWsrD
	 mfBBvI24J9czA==
Message-ID: <sashiko-outbox-198117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 16/19] perf intel-tpebs: Use DEFINE_MUTEX for
 tpebs_mtx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-17-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:32:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Replace tpebs_mtx_get() and its pthread_once() initialization helper
> tpebs_init() with DEFINE_MUTEX(tpebs_mtx) and static initializers for
> control_fd and ack_fd.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D16

