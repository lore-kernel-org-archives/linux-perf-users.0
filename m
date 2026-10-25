Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792968200;
	b=F6UPyIngPGkYKWtuv1DYZlG9Eyh2mb/xjRyVRo5H3cbV+xEq9bDYZhDv7S0xBtRJRa7+
	 cMi4t+wuNcqf5iSWCjZv4n7agpRGY8xaQ9F5N2C2aHChwGR3BgkJyP+ZX/Gx+IUIAt7NI
	 LBtfsf9S/y0hyjTxmNKQ51KN5ryU64zz+T3J4QS2ENvYf4lCtErBS4waT/uXVmM1BrwXg
	 M71UHoK01K/Qm4CiZWeNPiUbvasFd2E0HO7IYq2MJ8mf5aBf6aql7kyYfkvo/O7gtkwOp
	 XrE08dtE6FCwrjwjgUKb/Ew4ZeWyuJNwzP6QsKbrPMeeA++GlR9TUG9uumZmiTkWE4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968200;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cqpyfWM0GG/oI6lhDtQy5zvLwB9Q+qFhSE6kDk2xBPg=;
	b=PtF16vwmogIZxShUJo2ubAtcOFG1v8vCZMIwYw9sB1OLYmZNHN5h/c/g83J3W6G+fw/j
	 xCF27NiA3/2qRYeX5tEfwijEvwe0LzlvWNf6KYlfsmQfuTjXbumoqQFpkj5YCgEQe9F86
	 AE7AEhD52IsFtsA6uSHsxrQZ/YhHXNCoK/XUXSlyVy15cFbu/b+NE8jPXl2RltOfPqmfa
	 1qeDoPYFtwHogyCFhL3eNJ/EYSKBv5XBmTfFycB5XNXJQtsPLDtQWTx5IWmkdxXuhLttY
	 5RkLP+pMFqCIso9/cw7+gAMk7OLCn/h80q2ypHqemtt/Ho8G6fzt3OBJFXMTbiItVvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6+5iFGa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036C606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z6+5iFGa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C50D1F01825;
	Sun, 25 Oct 2026 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968199;
	bh=cqpyfWM0GG/oI6lhDtQy5zvLwB9Q+qFhSE6kDk2xBPg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z6+5iFGaXFCHB2PS5UHLAvobQCA+PnzkfOiU5S0/tedT2kVisXQA9e3SX9/iNYLlu
	 8YYOTOj/ZO3NK9JKe9gYK3o9Cg+zcRan/m3/1T8OzIPzkibAn1TKV1fIcEbxYnX1ep
	 2fhtIkaCXSRntiXilx/i1l1Mizjx8Ntq2AeB2gIk2HQOmFY3IC8jrP4VwZVMNFJXTw
	 +g1JdWYJ7s4fygB/3A3sIC5+RWwr4ZldxTuZRNeDabVY8CbsKJBqVHEPOgoJ2i/N3S
	 REQC7al9pg9bjgm+KSc5hAsWx+H1p1aNifGPA8el7oIXvK8qVnvpIg9Ku3QSYKjj1c
	 eEOmXwnZHmEfg==
Message-ID: <sashiko-outbox-184498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/7] perf dso: Handle trailing zeros symmetrically in
 dso__build_id_equal()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025220349.1244499-3-irogers@google.com>
References: <20261025220349.1244499-1-irogers@google.com>
 <20261025220349.1244499-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:43:18 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> dso__build_id_equal() allows a 20-byte dso_bid with trailing zeros to
> match a shorter bid (such as an 8-byte or 16-byte build ID), but did not
> handle the symmetric case where the lookup bid is 20 bytes padded with
> trailing zeros (e.g. from BPF/perf kernel build ID extraction) and
> dso_bid has the exact shorter size. Handle both directions symmetrically.
>=20
> Fixes: f4e3381648be ("perf tools: Minimal DEFERRED_CALLCHAIN support")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025220349.1244=
499-1-irogers@google.com?part=3D3

