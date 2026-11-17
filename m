Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946340;
	b=FzS+l5XbrZ9qXrqAl7MlCdb8PcY1ahohD9r/82cQEDthdA0RE6OUl1r5FqgqoX72LGVP
	 ypkHb250uN+/+Qt5qQQ6oRr4uQqaidGkZ2Ldpb5OrFNU0yHiU9rjIAI0nYbqv1pTgSjz0
	 brxfKIfCZpBvEpbtrWemsBHr0MPdP4zg8OfELc7oXGZw8BVo6zlWcz80TprU9XSWZ8zDC
	 tX2M25YOxrcmCshN5fTMs9QWetjtui8Vtx4IveO4nazMD3IkE9rdSrKGPapwPKGLDUb5l
	 Nt7EYLDL7Wu8SIwLaxwSrhXBiUrHuxbu1B9SoEZZ5r51pVBL1MHh1LoJjjfLxhSYI+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lk7QDq0ABvJznX/mp/Dd4glsBEnYl3qZaseiF/1/YEI=;
	b=32nTHZCC71N/wsYSlogAt7XGbFQII+7yzw4RFMOY6t+Y7XKMoQ4fMTwDwAMF+2pVFeCS
	 t9X1lmOV8wlndVpeILGEy35PzxLT4EQhVy+xYQ+1IctCugLcr6qTowIKExUAJK2CT4FW2
	 l+P1SaHQgIgCJcwpm1fiqdLpmr++5laqhCYSZ/lh0TPWSnC8wR7L5JYsZPV+bYOKW/DHW
	 9ciZXNy/awPgDw9pt4g8otN/1pXB3EqglJFIKE1W1MvToGj9zJar14TXZo3e928Fot3cD
	 23lXrIT2i4JuYZaV+35fjbrFvXq5GyCFqCIbY4pSa91MVsPfE4Sftt/2Txh7Ger1qgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHGEVT44;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2EE606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHGEVT44
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697381F000C4;
	Tue, 17 Nov 2026 20:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946340;
	bh=lk7QDq0ABvJznX/mp/Dd4glsBEnYl3qZaseiF/1/YEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QHGEVT44cfiNz7dYO2nRu7MLl9i1akB0m82jVp37oLfvL+CBmlB5+ilRALrs7/R2i
	 9OzZ9Wx6txNBCPEp1q4tQO4pOApGaMj7R/+BsmS38K23u0giOK3aEfIgiz2nkpBGNp
	 TWZV4EkbrRwYPNsZs9PNENvhGPSPcDT3Tri1cUn5WGwMcJ/EyjRYFN63igrXx1/Hjh
	 8Co7wOXt/0VvZBcI5rQeC4FV7aRPkfdpYewZCf1Zy9lEQZbqVWD8LsXjmcN/ImgkwQ
	 4DrvLXixNUpz0c/LRCJh3u/iisLZArpz6qtxgbeTsbpwConH5Stz3uqDZoNB7ErOwt
	 nQgGe3rlOPmZg==
Message-ID: <sashiko-outbox-219575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/13] perf test: Drop samples without an IP in the
 dlfilter test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117200433.45174-13-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
 <20261117200433.45174-13-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:12:20 +0000
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
> Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a userspace-only event
> skids into kernel mode, so that kernel register state is not exposed to
> an unprivileged event (166f10836a653dfa "perf/core: Fix kernel register
> info leak via hardware skid").
>=20
> The test dlfilter keeps those samples, and the check that nothing but
> test_loop survives then trips on their lines: the comm column reads
> "perf".  Drop them, which is what the test wants, everything except
> test_loop must be filtered out.
>=20
> Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test=
")
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117200433.4517=
4-1-acme@kernel.org?part=3D12

