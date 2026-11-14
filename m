Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633144;
	b=kD3H8HXzQPEy2h/E9eKKdw1rqCps0MuhvDQyG/qsl+GSUJpd/cbRw/x143CnB8gokU3W
	 V4Z438S0MbGD2cNFyNKsn8ZYfWaG+QLTFkhf4luj3IqPYbyf0c1qK2JO2xRB9Uqy13Qz1
	 RG5IgAXZDxj3N9iw59M3k62st6IuV3k/eAkudAMZaA6FjpTYf4oPtGm0aLhZ1g21HoxC5
	 QeOdRCTNKHGnWoaPVMMQ5Ww+mrPEtFnvJsOb/5Mk/Qtn7GjlJCtHTwFjkmCg2eB2llvoB
	 /RB7+tivkha5cqEYCSyXw9G38vcxIgaJDuzxE156pN8UZIQq3GTVxdB646WCVTaDmHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633144;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FAeB54R1AuC2AGW0+Kk01x/5GtvdHLbw0Od/rfUvLtU=;
	b=Wbyg1xZ5myC5Xmi8j7z+vyS2ynK001zL2I+IISRe263c14Mn1ztRGQOjQn//UicnSczJ
	 FDahGdzUJpbpB7Hz9qTb2ticqjYdvG0nY7kXU++3TAxJCHekiFWeaVd4yquSA316LWspZ
	 Dk4Kw9pJEK8lH6rAxLLfMGbhAUiyYcXaT3j/ssG08k1YWDfP1cIgGCwdyAAwYCTYHkidm
	 zRJ6qxC04DYegeRm9/fCxu8BxClxkCO2KW+mKdtTe/wOLdJWjgNeelTWgbTmrJRpRxvan
	 N6xTmzKywFoj4B1Ss0sLRokF+UfFqFF8FGoTW5wA4xm2ncAR0/qD3Liq7eMbrIscqWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJ7GiD5U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65985606A329
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJ7GiD5U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40C91F000C4;
	Sat, 14 Nov 2026 05:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633144;
	bh=FAeB54R1AuC2AGW0+Kk01x/5GtvdHLbw0Od/rfUvLtU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aJ7GiD5UVHRaiGXptvzwTyyLgGaIzoh1//z/35U5bGVLrpJW6+leJv6gdb2/3RcEJ
	 p+PPwjv2mS3Bf8o5SX1ij9QijV/DLHlFf1w+f7zIJGA1sHLRBhYLxWSR1Fy7MBKcZ4
	 jfTXWQAte1I/36dR3ubLm9LdtNLHGiXa4EmYlUqtEmkLkWcRyeqqwdqidopnO8V0/6
	 x7WW3NIXgIRRgPjys8y9B3ZOFdCpKOSdyrV8Gdy/9gSqkKQyIr1XfHsS4uSw+TattQ
	 giAE6oKBxvVh1W+59xZu56JJs4cXV9nwswFeC+9z//y7F628ZXQEJNQGfbeMofmXRV
	 kXIJxPpowwaKA==
Message-ID: <sashiko-outbox-214156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] perf symbols: Split out name-independent
 duplicate symbol selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113-perf-symbol-memory-send-v7-1-d992eced9f9c@uber.com>
References: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
 <20261113-perf-symbol-memory-send-v7-1-d992eced9f9c@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:12:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> This patch is a refactoring and does not change behavior. It moves the
> size, type and binding checks from choose_best_symbol() to
> choose_best_symbol_by_attrs(), and adds symbol__choice_needs_names() to
> tell whether choosing between two symbols needs their names.
>=20
> symbols__fixup_duplicate() keeps one of the symbols that share a start
> address. It compares size, type and binding first. If those are equal,
> it compares leading underscores, name lengths and the result of
> arch__choose_best_symbol().
>=20
> An unresolved lazy symbol stores a file offset instead of a name
> pointer, so the lazy loader cannot call choose_best_symbol() before it
> has read both names. The new helper lets it leave the names unread when
> the attributes already pick one of the symbols.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-perf-symbo=
l-memory-send-v7-0-d992eced9f9c@uber.com?part=3D1

