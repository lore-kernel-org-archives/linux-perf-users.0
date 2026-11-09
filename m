Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255119;
	b=U3FcLH14EXXPwdh5QWZbDxok8VbGXTDN5KMTL2gy+JJDb4zzCZpcJMB5Le171641ZXY1
	 3EIleuv90aN5KwgLkoEJwueUHI48bBL2qN0OGaURpMFDD42DApUrC5AcqWJc/4MvxPi5m
	 bO1Et579UsM21A7JBYINRC50mwfy0vy3xWjqIB7DvTWE+7y4DHbJ+nAyFnyTVP9f361MI
	 WAXlSM2vWVtgxRY+fgS5lj/XB49917Z1vEXbFnQaunZPg8sH1Yb+dQkYGTaJrq1G5HqTM
	 l0UucAf5USwR/Dama+WqBQtm1DSzC28qPYuCf+985/oBTedZlSTpO6lw/w5rVSHXwIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255119;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5vvPGuSZUIF24MA2vo+dUNi4vx37F6mz/N1F7aXPCDs=;
	b=cogoxgISUf5c8SGqUFSsTOYzzjG54NNzYQx9zJQgSz8CNxFoyWBgfjHGcDB4k8MROz0w
	 z+M4nXzKM/9xnwjothggKOOmd8Y76NUdcgbwZuk8fNGH1hUjSO4FvQKJ8+9ikDPZR4DHe
	 7ZBUQBTxFxsjE7DRxzj1+8+DiaBR0cZQWDWFYZmy+lWz3Wg0Uskee1/PhpIHOFR+RhL2B
	 Q3e4cHFpGjC9QxQxwB1SeBCCOdcylDUCsXHQDOF9Y23DqP/aVC/X2LgneRgr68rYMU6d9
	 1+f+jWRJLcv6ScpOl6PsS2DJH1ICqSwVhA3byENZWBONUXgdE4ucKb6aSpZ5w4qnx7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xrp5D6VJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFAF606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xrp5D6VJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B891F0089F;
	Mon,  9 Nov 2026 20:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794255118;
	bh=5vvPGuSZUIF24MA2vo+dUNi4vx37F6mz/N1F7aXPCDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xrp5D6VJ2xSCgLWgA3r/Swiz9dKUj2UohBO8oAct2hwxPwflpqpXkYM7c+7YiZuo0
	 BX3Cet8ks1k3sI51OqtFmyv05TvObxNJzN8OfaAjupOjIh22oQkUR62kaxa71jpSox
	 ItYqKY6znFAbKIZAuwvHJ6dvlXv375siiK0gOYVg0RHR/FlWUDbyqKkbqfEBWU44V2
	 L9D9+VfvwIX99bF2AYzUmZBd5jkTaI4uiNEe5TQ4rIpQibPIyQB5aHvEKnoa5fdN0D
	 xt+8VkD6Om04dunIgYDgxG2n5jl564DciGtoquKzI5Gtu/0jHIBM4rsvFqKZybJRiw
	 oAc3ut9iuthIw==
Message-ID: <sashiko-outbox-205550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/20] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261107044102.1506626-5-irogers@google.com>
References: <20261107044102.1506626-1-irogers@google.com>
 <20261107044102.1506626-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 20:11:57 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107044102.1506=
626-1-irogers@google.com?part=3D4

