Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873320;
	b=LrDq9rI57kdL3WUAuwelqkFxy9EoHDaLPKZd797U0r3sxOY/OpOuQd7o6eKIMro1tnBl
	 9oiSuZ+gSAbUkCRQ0LDy3UF7gcgCUurGCn9OzaOyawH0sDUuoxoq46E2nqpQkfj9157pS
	 jidA+uYTMLIvmo/P1kMCn+fH9SQs64kOOsh771DeoP9TmVowDVZ/adJWulPn8zvZhE+OF
	 zxkCsZiHvL8nq81BjjwW7QxG6eJtFtMjYoidGpCUMwi76RVtTI37rnCPO+GGQefomPA6F
	 JU+XOGlQx7oyYgw3Jlp0q7gpdTVYwCWDtgTsivmne9ySR80DXzfTdFZQS4KEXWwhPwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873320;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PHLpIxFBCT1WuxstcAVXiNgWPPCZbZ9ha7WoiwUWz/Q=;
	b=okO4ZIqen65p80/YcEUW/NIBcnyQK7eXgo0WRH2jzKUACPpl/uqnIMkemNmGphYJnHUS
	 LzSvaIYSi594p5XK2QQJu5PZv8nP0KJethO9wN/2XpMAoVWKBZTU77+XVQyzsm4qAsWpb
	 8mfWyA2mwOP0gn5mS1qIldBao8VKT2OyXkd1bSRVGCRKOAfZu67zj6iibaJsPxWPOxxi7
	 GYO0jG5ebD2UhIJVHaN++QnvUESmhfSIUOWeqLjfjhc3PKCBFj34QvLQUNM39HaUjCgqL
	 tEuOdg6sBJMt5FqDPaiAfkBdhxIs3wJdgTf9hoF7b+ihhxyYfWp6O5ZFnYrUlNmAepA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OT8gtaPZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBA606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OT8gtaPZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943D21F000C5;
	Mon, 16 Nov 2026 23:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873319;
	bh=PHLpIxFBCT1WuxstcAVXiNgWPPCZbZ9ha7WoiwUWz/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OT8gtaPZEkd7gm0LxK727CyNmFrmIC29K5mWZefx5TwEK6lUT/wtsSuQ1bVDUf6bW
	 JyIaE7jTAwagPbpPjsozMpFAqpY3ahoZHPdZ9N3ea3q9NmgKkwjser6WhonmAHFtzj
	 m7TXfO3MKHcJpt9yHNWHhKxbXZmfptlNx5CLRNdL+vy8S/a4WntznidVy5WM4zZToT
	 rwAdDt1pULOvX/Hs4T0Ygu8VFILZoFKCBaMfa3rHJKbCPGBCCW8faaNQmHc67aWIXZ
	 UCm7TKLFM2M3ZYeJLtH0e8BG6WwqZit8hMJJrI+stlMOS7ZRkJ/wDu9A5IVjHAxkHB
	 TFtDY+G+X+T0A==
Message-ID: <sashiko-outbox-217940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/12] perf annotate: Print the stats after the
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116234659.3950531-8-acme@kernel.org>
References: <20261116234659.3950531-1-acme@kernel.org>
 <20261116234659.3950531-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:55:19 +0000
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
> The instruction stats are printed before the loop that accounts them,
> so 'perf annotate --code-with-type --insn-stat' always shows zeros.
> The data type counters are updated in --code-with-type mode too, but
> only --data-type mode accounts their total, so they are incomplete
> there.
>=20
> Print both after the annotation loops, the data type part only with
> --data-type.
>=20
> Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debug=
ging")
> Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debug=
ging")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116234659.3950=
531-1-acme@kernel.org?part=3D7

