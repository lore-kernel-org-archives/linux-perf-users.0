Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BD38BF9C
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404232; cv=none; b=NIksjwkqcKWrvV3skPIOhtlRyBGBx52rLoVwxWZ2OJLDw4PnRIGqfibbrwUqprgfNcaGLtdaHafrXvEfIQr98oVyf1n7KJT+gY9XiaZQW9HJXXzpQt+XK9hTolc+Uoze4SR3+5YnC6gx35pCB1hF+5utmG8iJxCscZuJhwNIL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404232; c=relaxed/simple;
	bh=qh5rk+EIMqCtqIwxlG1NdOjbia3A1LCtzQ/aADc4MNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PsNJca+FJChtiv98rD3m9gxvryI4DFecQfvVPAc1PJexdn635JnN4V4XEKRZUgOoGotgB6bLDxkvdEQXQNH0GN9KkG48HqYIer3IKDOp/rRt4sh9KycdCLtdtL2x9kC/2KEq0pX37ItQwMwpH2zlraKFZ8egyBQnhBjjk5ojCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/LE/V0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/LE/V0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24481F000FF;
	Sat, 26 Sep 2026 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404231;
	bh=qh5rk+EIMqCtqIwxlG1NdOjbia3A1LCtzQ/aADc4MNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/LE/V0taI6l+ROqVka0fgxYRYb2WWAxLpAZ2XLGtx5DvEvo67QZ/g0awl/t9Sk23
	 iC9sdlI6zLwGgTxSGs0C9FpNeIIq02/tQB/Q1FPfxjGsKQRkAc5STtGgK3Opdrixcq
	 xqSP8FRF0BPzxvN7jAoSow+8FxNsTQYKOseYzymZPrToNUX9vEdn4EST1UH7WtRcVx
	 8V3Bt2o1z5HXhOjRMtnf/oVH0qgL0rU6UCBSdiGcUpN2+cldf5m6LWih/QjfAA4BIj
	 thovwXK1kboRv308BG+oQj5HRL2ren9yWQX2ewB3bEW5GbB/jg8Is9GLvGuwLEywhg
	 fgAb0HWfjlHrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/49] perf python: Update syscall helpers and expose
 arch_strerrno
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-2-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:30:30 +0000
Message-Id: <20260926063030.E24481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update the PyArg_ParseTupleAndKeywords format string for
> pyrf__syscall_name() and pyrf__syscall_id() from "i|$i" to "i|i" (and
> "s|$i" to "s|i"), allowing elf_machine to be passed as an optional
> positional argument as well as a keyword argument. Update syscall_id()
> and syscall_name() in perf.pyi to match, and set the return type of
> syscall_name() to Optional[str] as unknown syscall numbers return None.
>=20
> Also expose perf_env__arch_strerrno() as perf.arch_strerrno(err,
> elf_machine=3DNone) so standalone Python scripts can resolve
> architecture-specific errno names directly from the auto-generated
> trace beauty tables instead of maintaining duplicate errno dictionaries
> in Python. Tighten the macro pattern in arch_errno_names.sh to
> E[A-Z0-9]+ so compiler -D flags containing underscores (such as LLVM's
> -DEXPERIMENTAL_KEY_INSTRUCTIONS=3D1) do not shadow EPERM (1), and add
> EM_SPARC32PLUS alongside EM_SPARC and EM_SPARCV9.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D1

