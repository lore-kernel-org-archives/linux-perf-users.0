Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826457;
	b=abFTBUxQR9r/B2Vb59M/q9Rd0S2OExgqo8twoO7j0ItD0oWhl+EQQz3ECN0I7JWdJyyI
	 NAjXTg1AR2Cp48gguaXs/IejCClM+Hl1aqbCAifDk4JFM/jNQWQzdiO/xMkc9Uh+wZYYk
	 uFcuDYLxO3cD1yks0xgE2WN9fJvfJXTI1NCJGtCjqYNYcF8sSilQg101NdQNzXviMddYy
	 xyW/uJvFy82TxhoaAzZgiXi0nDj/MpgJCSI/yyzr9mzRTv9wZDli9tjD7tN7xg4mFtHFW
	 FLHC7E4ttrO31DAHekBUG2Y3ZBPh9WWmMgMMw5JYVbMxxQvxcf54CQ0XoRSkJSen99g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826457;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dsc47GCh3H0HP5AunwnaJgCuaSammwApHvmlMe2NhW8=;
	b=qPDQZBGYHoS/1Vs3Deqr52lRj/9OfFA+oRc+vFz6W47PIJYdLB2IEMlkxSWZpg0dtQXt
	 PpKOKWpuRVXza90bYzHTAxHQuFjP25CZPzEovYuOeqnnW/Pt+20Vmr94KkPmrs6Orvyu2
	 zSbhABXylvAncU98jpaGsUA7X6y0CZYL5ixOkMgYcAl6bBz94DL+5KVk1cHRCQ2uZpA4O
	 aKT7ZCCqASqXMXTwmjI0fsOgltWABO28aZyU72cf/yNetCZYXFhhBDdEX8tOMAC4XR1N3
	 Pwz7L+4MmvyiNe1mZ+bdVx2GFz9f7YRS3myRq++bQV3g0Jg4ZyVgzq7m7aolQxsOr5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYWlcERm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D10606D811
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYWlcERm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71AB1F00919;
	Wed,  4 Nov 2026 21:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826457;
	bh=dsc47GCh3H0HP5AunwnaJgCuaSammwApHvmlMe2NhW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYWlcERmlO9p5B3fnrGo4s4Uz752YgqoBOFrcTQtvIcTiCFAF/TF8Cyu+EvtXASvv
	 B7N3gUzbE4t3TCBBWg6pzsw0aJxcpY/0JChHcfN+A9l9xU0g8EV4e+Qlh5b6YiSasQ
	 GTA4ELs2h2E8+LC7IuyllCyhl1HrIEJJMTLatkD/FpEZScHg8j3UGaLw+Juc4AHdCp
	 WbcBbetR0gHl1FtUk7JOkRKl5ewsk7LTIalPFtHr9xrv1lvO3gIrkiCT/yoinBGFgV
	 58NqxWFaVabZSDv0ztfWIdSaiVIpdoI0Nte+ctHgvU+nyFjUZ2eIYnHwVJs9MsRAhu
	 y12NoljEHAdkw==
Message-ID: <sashiko-outbox-198044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/19] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-5-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:07:36 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D4

