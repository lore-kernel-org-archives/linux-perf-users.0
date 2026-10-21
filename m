Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622948;
	b=jJZwokJU49tLl1GI11swl2ggq7qM4OgKPHaRFrYL9SiS/upZ2aV0lOpI8k8JQ51i+d5B
	 THdUjiB7SIU7HgOb8gMLKmGQTz6neqlyvhE63QtHEFYkShpaVCLnrmh6wxTJpJ5VFCn7N
	 MW1sT0IRVuMHzxGprXFFIT9mQwHWpuD9YVRsNU+UGAkr31Yh/Uzb3w2tZcXJwprXS6imI
	 4KHMhwoAtXM5rqfHsv5qmI72MyG0yQa2kCwcYmRZsc7HkCz0n07PuViqWdBwEeT5peFdN
	 z5MmHTL1M3TrKxikuYxi1vjff7jvPtXUL0YZEGZZcSKk+cM2OOx8t/+mh8KOtKJtGHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622948;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n4SFRbIcVi+Tdkzp7yx0VbdGFHhvwjGoPT+KD1G/KzQ=;
	b=DiekGQnxzdDQSUi6jAiaOIkP1cFYVnxUVK9EMknRXkwodJwns456IHWxi/2vO5m0GxEw
	 iFYopOLuKHdbyL3Q35tkxraO5FpEjPCSBknqwYmcLw8SoSetfMWTzpWWlOo3j0JU5/uTe
	 0UqI72uvtOKlydXBeBfMHjfVUqwLNv+9u4w0d8m05ixHm3CxLbPX7miGPmbjN5ksh6nt1
	 /yMVX4zUDhzc3wRBommjT2SoF45oz+BR/V2RQ7Ejx66LKVwfaOR0FWYdB3SKFadNuZK4Z
	 Q0R41VX1qgErceSJNaBwm11OY1r4cKvU+bgKdAbxxJFjN0bpV1Z3P/NI0rYFw045SDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTwF+76g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B018606A31D
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTwF+76g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2D21F000C1;
	Wed, 21 Oct 2026 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622948;
	bh=n4SFRbIcVi+Tdkzp7yx0VbdGFHhvwjGoPT+KD1G/KzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTwF+76gGIZi9qWnxOKSAMnbnsBwAcafqL+3luMj11O/NTmNJHZENvLoKzkrdX+qt
	 70Yfui+vzccKTmxYLUtMLBLmLy3+4r/IWryqnqu4Z42rOufr72f6Psy3egzqeO4cZd
	 yV4SgO3svBmkxu8p0znD3ZOw4JeINZRylIA4DUMkPLsVMIhKUclbHUfWaGEw4FxdM4
	 G2WIhEsLRBzqGMZrLMhDXN6gEwzLD5l0VeoD6QS5OiwhzsI8Ba8bdExjmM3ocdWoxc
	 k235iq+U0qXlpl0gpbl/77DttG25UV6dQQwjbyf1OdnibR7FA7OZMaW82vtJ5vmeQV
	 s12F3luNtGtaw==
Message-ID: <sashiko-outbox-180738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/17] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021223905.715051-5-irogers@google.com>
References: <20261021171044.155240-1-irogers@google.com>
 <20261021223905.715051-1-irogers@google.com>
 <20261021223905.715051-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 22:49:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
> builds in tools/perf/Makefile.config, replace the custom lock safety
> macros in tools/perf with the kernel's compiler-context-analysis.h
> annotations (context_lock_struct, __guarded_by, __acquires,
> __acquires_shared, __releases, __releases_shared, __cond_acquires,
> __must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
> __no_context_analysis, and __context_unsafe), and remove the redundant
> macro definitions from tools/perf/util/mutex.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021223905.7150=
51-1-irogers@google.com?part=3D4

