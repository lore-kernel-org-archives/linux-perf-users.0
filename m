Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B8499F20
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916404; cv=none; b=VYB5euzQLveouio2QHhH3thqrkyo1Tcs+a1kOfrpIbmIUf/vKgHp9HppUIn6VSmNtMz6eIj5IhBWlxXFaXvSvH09LNs1cATjkR6ejTWME2yfiPRe+nDe3F5RficiM1dosIFSt4Q3wpYOT24gekSnAFwesCvKoBb441nd73JOl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916404; c=relaxed/simple;
	bh=5Vc4Q76XHicvlZFK2BoH6N71ZffkxO6m5w71uTGdF6Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ckz8DpVBz0vHeTCiOMNfHyzp4o1fkEjzk76jJW2kldI9bJCDw7sQdkjpS8pyuFAeA7kEQfuxYDdHTI4PaQsx3ez5CYRdpKCwVV1UtndhqLYuZK4bLOIa7Hl74ZZvpWmFb7nrhgGbmuwfZLyRnyaXYjsgZ8R6L9rx5aUYvG/mjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPtDwr60; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPtDwr60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E081F000FF;
	Tue, 13 Oct 2026 18:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916402;
	bh=5Vc4Q76XHicvlZFK2BoH6N71ZffkxO6m5w71uTGdF6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XPtDwr60o1bwXDL+FtCA+finaZwtx4XcIBjQ+/Mh066BUYmAGOlSUqSlltlrpx6XP
	 L1U81NscCWi6XKLTUdelgKKVHenivqf/7EXxwT2YKYad5JwgxHr7I6mkHHLokK1dJr
	 3RC2196pQsGyMEwjcqYxuK0qvkvWiMLDRZTy3vYBQoloEuQ6rLdrn/PAp1D0hClPed
	 8190rKzwXl8SBLE5NzWciuEXrEP8Ly9OWmp+AMCL1xVImCn/gzuV6Pl1LjpCgP/UON
	 QzKBP84Q6S6g65SarmctN6smmpMNSi0meli+keQ1o18MDD2qjLNxB3mmCnm/hm0Cvv
	 5oPMbpYGjZz0A==
Message-ID: <sashiko-outbox-170333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/10] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-3-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:33:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Synchronize the non-__KERNEL__ sections of
> tools/include/linux/compiler_types.h and
> tools/include/linux/compiler-gcc.h with the kernel sources (including
> ___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
> ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
> __signed_scalar_typeof, __native_word, compiletime_assert, and the
> __diag pragma helpers required by compiler-context-analysis.h), and
> remove the duplicated definitions from tools/include/linux/compiler.h.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D2

