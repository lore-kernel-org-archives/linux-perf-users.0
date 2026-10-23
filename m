Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792732034;
	b=s8Mj797TZQid/e+NkprArVwxR8oUe9WGHqwx8C2bcRYzm64VTTwF7zjwqSlnEfelaGO4
	 hT0qatNQEkt8WM+sHl40mbC+sbjfQ/GEzrPkUnV2kINz78icc3EIUVshxKBr0kSPJFLiJ
	 9aZtFkL6InZmHCrtutHaNrbTulkQ4qw7voRQ/Iuy65PbMzfgT9/S490RFhzGFeSQZN4xo
	 g1UOjPVVIUYtXQIMde7mRA4SYcITojG0FWBYzCQgwEe7Amik6MgcnqcuJpShetSsSuPM9
	 kZ0XJCs7Qpo1gE3MZNFYENjYV9xxIWn1IzGtxW8m7d6p84F45u7F8pR5pkiSa2eyfWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YTUb23cBoNfDJ8S3+/bZWURWazAXNn7oKFj+LxSe0ww=;
	b=enyXPnoHtlE18FK+p9vtQErDmyGB1SrTeuuXqXylNjbglkON3HC477dhPSsT/nYM9Ydg
	 KuXoeqKiprpPDyIfiPvHgJ5DH592PPAEM/Djf/K6AtIXxvEM92/8S6T9S6fu+o+N5UCW3
	 oqBeMtv8GkUhmBjtvgZv3/UZmrLsd7OP8wjxAIMpJPPdzW+8z4A9R/3eKjkKWxk+B1C71
	 yIqUQqWHdzx8FgTZu24keoT8ARN2xAAlgBJ0FXOsmHKky6VgIngNoHu6HlrStFoJ+luam
	 GgIoadrrKUg2d9OmrodpZJXXW/8UsoSgfJOUT239f5nrDtbMJm3vDA/eqYYZmtjurLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGw2dAKJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783CD606A319
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGw2dAKJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825111F01828;
	Fri, 23 Oct 2026 05:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792732033;
	bh=YTUb23cBoNfDJ8S3+/bZWURWazAXNn7oKFj+LxSe0ww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGw2dAKJikIRhYO0cOVKneBHxmobFdS+7Nc7WXpnq5qaXx0c1C+aXWpXp6VxBVvyS
	 fkuy0Pk43cCa2XFBU17r6Ie5aAT2xGBsIsH/nEe0WA7F+x4IsaouuSXNrOjvtMEprc
	 WqGBHNS/NDZ7sEt2cR54EwgiqLohl8rXNbxUbPNwqnuZPUqmeoTvkq7zgucvsqbC6h
	 ZL8dpXkrzuKFLvfkRB8P1KRmILzWwLrJDjLAANaXMp+dUh4n2zIyXnhn6TXq3TWOp5
	 6Q6kZjwnVbtRxqO3lKgBEuYU6SIuDV7f/R0fQvPC1Oc1V/SXd6RkkixQrHxMlxZAKZ
	 kItrlXIXrM64w==
Message-ID: <sashiko-outbox-182297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] perf test: Test perf timechart --live
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023050207.2449976-3-irogers@google.com>
References: <20261023041819.2361900-1-irogers@google.com>
 <20261023050207.2449976-1-irogers@google.com>
 <20261023050207.2449976-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 05:07:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Extend test_ttimechart_python.sh to cover --live option validation,
> LiveRecorder's perf record subprocess, control pipe and -o output file,
> a synthetic live UI test exercising the rolling window, pruning,
> pause/resume and zoom following, and a live workload recording test when
> scheduler tracepoints are accessible.
>=20
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023050207.2449=
976-1-irogers@google.com?part=3D2

