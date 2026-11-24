Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560116;
	b=kWSM0ZGWkzpuVA+3woWFAjPV8poeLNmoPrAOcDI11l2S4eUsMQKlPYoy1cZPfl4Qn/Mj
	 ADT/jAhZT9Fff65P6V+CDQ36Hr8F4eaaTGbrG9bsjblcwWzNrnRmotExL+jJLauw/L8X6
	 fjBhEjqoRp3fjW5nJpr1KzHTsosF3yCZK3klSfrmi2WYY++Sl8ghqTDFFEG8upAD2MODU
	 tssnRHJZ2XCUUa6YZrEdbU35Dj34fKN9svYY8FtNjAuD4urhDTv40BMe3jAd8gK0fmILB
	 LryoaGIBvdU7AbErK7kLWjwiEELuPO7lJyX+iBkyN1nEu1lAegAvispQv7FCfOSGsXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560116;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mIheEKvESYttu26KKBlEX8l6NBdFtSwFjZL5UG6JGVY=;
	b=lUKj0UYKaQcZoVHVtV1tRLsUdwyHeTu0j0BoHESL3qG5eD0xbmoQxVQN8IpQf3liY5ct
	 mE2LwiIPZAVnSz/d8hkeT210eIovUWIvg7TE6gbSfH7o4bhBWy8AfQpA/eQa5pNBsy3fp
	 0fgP8BFqEpTjE4RtW2yHPjLYo7LDy9AQpQhwAG40TZLFB/E0k3IIEort5ieREkpwCd635
	 9tsuJQcEjVawcUiSm1EViUr9NchqRmdXd5tNJC1A7Et7s6NMPH9OHygGl057s8ohBGZOS
	 RFiZrUpZpEXmToM8PQr08PYmDxO/3xluNdukWFPM5FYuXZ8Vsi9uvJMX9kkxmuSwR0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFSwwtGj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75426606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFSwwtGj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D03C1F000C0;
	Tue, 24 Nov 2026 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560116;
	bh=mIheEKvESYttu26KKBlEX8l6NBdFtSwFjZL5UG6JGVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JFSwwtGjm4bp2zPd08sbE1GVisL367IoiNzZ34RORisxyc912rK/5MwtJ2r9E91v+
	 YLLoLcPxuHgBNRbHKcOjViFbeA3P+vie6bG2qnkvXykZGomzJGuKjdJoS1rlJpsBus
	 yO8Sa4QlsszHa7s7uaQZ5JSeAcugMNSXJbCf7VZ/8z8ggpwJo7zwquH+bjWKMueWa1
	 35zvr8JBzzz5FCkStvGIP3DabjRQoBatAECGamCjz7qQ5JqsFMpzGt51WwYCIwJGjA
	 oU8FJEptDqp4tQTkQB+UBNSdmHS/AwzP0Ixnd71z/Suc6EI6b7xzO9CalLil6qIggw
	 ME3p8Ww+PwWig==
Message-ID: <sashiko-outbox-232151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/12] perf symbol: Fix symbols__fixup_end() for
 equal-start zero-sized aliases
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124223109.820609-2-irogers@google.com>
References: <20261124223109.820609-1-irogers@google.com>
 <20261124223109.820609-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:41:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf symbol: inaccurate Fixes trailer for symbols__fixup_end()
  alias fix
--

commit 68abd9e71787b2b2d18ca97e39f460dd4ecc3f6d
Author: Ian Rogers <irogers@google.com>

> perf symbol: Fix symbols__fixup_end() for equal-start zero-sized aliases
>
> When multiple zero-sized symbols share the same start address (such as
> STB_GLOBAL and STB_WEAK aliases in /proc/kallsyms), symbols__fixup_end()
> previously skipped earlier entries in the equal-start group and only
> updated end on the final entry before the next distinct address.
>
> Because __dso__load_kallsyms() and ELF loaders call symbols__fixup_end()
> before symbols__fixup_duplicate(), inflating only the last entry gave it
> a non-zero length while leaving earlier aliases at the same address with
> zero length. In choose_best_symbol(), the initial "Prefer a symbol with
> non zero length" check then unconditionally selected whichever alias
> happened to appear last, bypassing the STT_NOTYPE, STB_WEAK, STB_GLOBAL,
> underscore-count, and arch__choose_best_symbol() heuristics (for example
> dropping a global symbol when followed by a weak alias at the same
> address).
>
> Track group_start across each equal-start group in symbols__fixup_end():
> when no symbol at that start address already has a non-zero size
> (!addr_has_sized), synthesize end for every symbol in the group so
> subsequent deduplication compares equal-length aliases using binding and
> name heuristics (and so allow_aliases callers do not retain zero-length
> earlier aliases). When any symbol at that address already has an
> explicit non-zero size (addr_has_sized), leave zero-sized aliases at
> zero as before so choose_best_symbol() continues to prefer explicitly
> sized symbols.
>
> Fixes: 694bf407b061 ("perf symbols: Add some heuristics for choosing the =
best duplicate symbol")
> Signed-off-by: Ian Rogers <irogers@google.com>

[Severity: Low]
In 694bf407b061 ("perf symbols: Add some heuristics for choosing the best
duplicate symbol"), dso__load_kallsyms() and dso__load_sym() called
symbols__fixup_duplicate() before symbols__fixup_end(), so equal-start
zero-sized aliases still had zero size when choose_best_symbol() compared
them.

Should the Fixes tag reference 432746f8e0b6 ("perf symbols: Fixup symbol
sizes before picking best ones"), which reordered symbols__fixup_end()
ahead of symbols__fixup_duplicate(), or 73ffb62041a1 ("perf symbol: Switch
backing storage from rbtree to struct symbols array"), which introduced the
addr_has_sized skip in symbols__fixup_end()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124223109.8206=
09-1-irogers@google.com?part=3D1
