Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5413A1688
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327773; cv=none; b=Xg+tJh+6GJIjk6o54b4vzhNqtCOfG2+7mWipB7ExRHxOY0gfEE+VwFKOZqTZ3+nRh+cAE+/aMO89dJ1qmcZ6h/0kv6THsI4ZlNfBVz5/MrsbfrOFzz3uDSkST9aJ4Mo+qQWPnCt8pkUBjfD0xQnSyhDkZLe2EpGNio++ru/bWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327773; c=relaxed/simple;
	bh=fxQP7at8WxkruvyaaEHf8o+IuFD4dEVWJm9bJ1AEce0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ge5qANGxV3kXEC4sM/Ev+yV2yQWRp5TbdluPsp+xD9JyD4JJPGQBy0LDMJw/2nCiOt4AraTTveWpvJUnLBKNgV83U5PzTLcxcSk51FMbwZf4abUUM71UOseJL3WAtMaTag1MDzhAppZMVgPuYh0NFXmVpP6nr1Mh4F19S/YczaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul0JQWkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul0JQWkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394B11F0089B;
	Tue,  6 Oct 2026 23:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791327773;
	bh=fxQP7at8WxkruvyaaEHf8o+IuFD4dEVWJm9bJ1AEce0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ul0JQWknhYEZX/ZfWDE1pI8tOsTnjZl66tB6RdIjkmnnskS6+jVzEo+ueb/qddNG4
	 n7MeNvPmHPcCJ9oC6eEl51pCqtctSzOMzAGjqN9aDZZBQ5JSjH7xqNa2fILoJ2For7
	 wS+qEnmcn0pRbYq+rSiOnW+8KxszK7bFBuzyLimPPOeqabzIimGcV6Hhk2MxVVnwNy
	 wlme1x191QHQUZX2i0vfHR0fOR13+TwjTicGYDAFz0mpjRW8DWNqAfw5bcQV8QGjGz
	 1m/0pAUkH4PX01I0N397ECfg01ubvIp+blLJqwk1hEefSaJbirtyoJsazMbCQXJet/
	 BoeAhTIVVm0Ug==
Message-ID: <sashiko-outbox-162501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Check kernel access for text poke and
 ksymbol events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kyle Zeng" <kylebot@openai.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006225248.54708-1-kylebot@openai.com>
References: <20261006225248.54708-1-kylebot@openai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:02:52 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PERF_RECORD_TEXT_POKE contains kernel text addresses and the old and new
> instruction bytes. PERF_RECORD_KSYMBOL similarly exposes kernel symbol
> addresses. Both records are delivered independently of exclude_kernel,
> but perf_event_open() does not check kernel access when their respective
> attributes are requested.
>=20
> With perf_event_paranoid=3D2, an unprivileged task can therefore open a
> user-only software event with text_poke set and observe kernel text
> patches. Opening and closing permitted counting-only tracepoint events
> can produce these records through static-call updates, disclosing
> relocated kernel text and branch targets.
>=20
> Include ksymbol and text_poke in the existing perf_allow_kernel() check.
> This authorizes the source event before allocation, also covering
> inherited events and output redirection, while retaining the existing
> sideband behavior for callers allowed to observe the kernel.
>=20
> Fixes: e17d43b93e54 ("perf: Add perf text poke event")
> Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006225248.5470=
8-1-kylebot@openai.com?part=3D1

