Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5FA377AA6
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991221; cv=none; b=bl3kzpYZ3LOhHxv3zlXnlpbqGhi0NgvthhokSgqSHNzGfeN3J+a0lyA5Lj19F3lXdjdfB1VH8vUJ5Oke4ViySQVdoRHmSWISOeTRdfiXqBKTdwv4FPv3mC4ba7RLhxX6Ty7bwlTw6GnjmKQjJSoN8yQGx9bjsP6O931XU4d7tz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991221; c=relaxed/simple;
	bh=ApA2VdgjbnWWpLVSxKi0NyxX3bst5UEbU2C3YVVC/AY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pN8SvHY/mCQNMLVqyCozbmTXwkLObDQjNVyjTHNA0dMjQKVUAzp/c/iNrp67219IqeK5yKxsxJt+6Y53EBStZ+A8M7GjFZ7lAJyjaScnl7fIwpXDNNbE+jQNSMvlVFgmr2kwnCIE19HnDtccWR4+o2xJ9/MD2GNJ28lRooVXMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzb532En; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzb532En"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014FD1F00899;
	Sat,  3 Oct 2026 01:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991220;
	bh=gYkMKjvqoELWtVwd3ifkqasuUaHsZclo7atTVcGpGdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bzb532EnlV5LbDWx/uC+QPXhNrCvnOMMJk/3ok1aUH77lJshGbRrr0D454Jm/NtKu
	 pB2uZ7ScpcslOSci0uYCEKX5FPAXWweZhIpaZ7KB79lqnKjMMbmDTsXZsrM15vO0Gj
	 6wprEQn4tfbqz/7PQpmZ/+QlJ/BtOgKNwEn6W/pVKN5esHt2+KNyBG/BgmjpxzCctY
	 2AP+aN7ncIJ0MEowrRB8FLp9HoEJNhnvznPPmag0Z6K0oHSrPcIb6Us3UEnj+CBeC9
	 pZclWM6fiB2++ujJwOSdapawULtBIlK3ZMEbPRQQVB47Y/PQu8IxspGdpkmr38EuJb
	 jjsW4p/LHYGLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] perf test: Test lazy symbol loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-perf-symbol-memory-send-v4-5-0a592bb2539e@uber.com>
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
 <20261002-perf-symbol-memory-send-v4-5-0a592bb2539e@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:39 +0000
Message-Id: <20261003013340.014FD1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> Add a perf script shell test for --lazy-load-symbols.
>=20
> Record a small callchain fixture, require evidence that the controlled
> perf DSO built an on-demand index, and compare only extracted occurrences
> of the controlled test_loop symbol. This avoids coupling the test to
> addresses, diagnostics, or architecture-specific symbols for which the
> eager and lazy loaders have documented differences. When run as root,
> also profile perf in a private mount namespace whose build-id cache
> directory is hidden by a tmpfs, so that names must be read from the
> build-id cache in perf's own namespace.
>=20
> Report unsupported recording, missing controlled output, and unavailable
> libelf as skips without replacing a prior failure, and keep helper
> [ ... ]
>   - on x86_64, a binary with an IRELATIVE PLT slot whose IFUNC loses
>     duplicate selection to an alias that loses to another one in turn,
>     so the PLT symbol name depends on how the IFUNC mark is passed on.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-perf-symbo=
l-memory-send-v4-0-0a592bb2539e@uber.com?part=3D5

