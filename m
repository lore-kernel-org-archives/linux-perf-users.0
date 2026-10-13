Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6D51DDF4
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922950; cv=none; b=VMKBqH0oXp4JaEM8Tpe256K+iUA5n2W+Hr5B2IbdKVx2rwEAQeHQc3Gq+n2DwlqBlBLjZyeTlScZQBQ2UQySP4TYBhvvHL4RkXPMgvx24cfqToXCzXQGh61YFTKNsTZTJEqR6Hu2U3XhiQcZSIkT3tWpfEhOb/gi40v2zJnYKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922950; c=relaxed/simple;
	bh=zTCJFH4yFg8LxBJlxjvqpjkM3x0kol1R+Zjue+IvEEs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NI1LMVs1k3pIU/q92MW58ZQgaEqMDonMe4ZyoZg9ver40XdrSuQAxtlMnK1457src95CqKF5DpOpS9gU5Vj4zw8+yC5IAO6uM8vx4CQxs5yBuy8pSV/e5TnKzWCLO/qQ+lugbc9tVfAHpgMiBCawmJK2qlqAiiGYQlXlUPzMb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmbuG4wR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmbuG4wR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599A71F000FF;
	Tue, 13 Oct 2026 20:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922949;
	bh=X+57Hv76OsFJPlxJM+0d3WwdGiOk+mrRbl3WfQbks48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YmbuG4wRKU+iLnMfFUovQSqWkpnEEigU83agukg5X95XV1AAIyOOjVHyRwUob6reJ
	 TlLjClAxOdMwOaJJaxBFNsmGG6kuagJeZHdN6g5XUrli4i1AjRaAx3MdILUD55kxg8
	 PI1lPzDKK9fFd3YpUt62guTXIF+OPIguOr6JIo0HPc8s6LZFdvIg/hkA2S+sMSzUV2
	 7a4EDXhPbEOVHgfe4cWV3WpxHj7mfdnByXhUjxUGqcf47Pt0/LIm4nSr7n8bqe2/UO
	 Dsa8AL91YieUzsD6S+14f6nE4RRselcIiSiaH4+pyZk4znP0aR3/eTDlmDvarL9IjB
	 aVnFHoQrRxDVw==
Message-ID: <sashiko-outbox-170451@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/19] perf test attr: Fix legacy event encodings in
 group tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013201415.36428-4-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
 <20261013201415.36428-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 20:22:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Since commit b1c5efbfd92e ("perf parse-events: Remove hard coded legacy
> hardware and cache parsing"), event names are resolved with sysfs/JSON
> priority over the legacy encodings, so bare cache-misses and
> instructions now become the core PMU sysfs/JSON events (on x86 type 4,
> configs 0x412e and 0xc0) rather than the legacy
> PERF_TYPE_HARDWARE/config=3D3 and config=3D1 events the tests expect, e.g=
.:
>=20
>   expected config=3D3, got 0
>   expected disabled=3D0, got 1
>   expected mmap=3D0, got 1
>   expected comm=3D0, got 1
>   expected freq=3D0, got 1
>   expected enable_on_exec=3D0, got 1
> [ ... ]
> return value.
>=20
> Fixes: b1c5efbfd92eb84d ("perf parse-events: Remove hard coded legacy har=
dware and cache parsing")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013201415.3642=
8-1-acme@kernel.org?part=3D3

