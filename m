Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589040;
	b=hV1C2fZoAB6uRA3W/He8UzYc2NAAuz26rLWTnzMqN63iDr0XjoBWEK9jhcrWPlirAavj
	 v0Oxj9CzjVknJxuxRr7QjQkiBfRDbHglJhtVIn8qAVtZFeAbYZIU0m98qss+Top6NB11Q
	 /zbE5FlkO8KE020wJUIf5cWRsknEvnyUzk9Tz7jhj6FUE26yRE0sL+c6ArgnIMY3jD3E5
	 lTtfGFBJH67IH7juGLEJO1j/kY+wrlbznjjBUrf/UNdMntq8U+Po9phkf+AEvdbdMsy7Y
	 gH/lCFUta20+YI2VZOTGEQy359z4Ua2F+RnPtKMOaMTmDw/3nsHfzkQfB6ki8cAY/NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589040;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=97bNZNx31PrAjIAiuh1JgfC5+2hMiEFsgMfNJrx0wYQ=;
	b=x7AlA/lUJ7Ji5qNKJ81fBIqOHiUeE4xE/i6w/I9X1yd7MFOCRBvhb0XUu7H5Q3FN0u5n
	 PpTG/vXt8L3poDYxwwgImnsOezW6U2CG4MprfmUkQXrsgxcjOr6Lp+U4lQ5/rf65XZ//8
	 nsFwmAH8nSaR9XCYaI4LRTgycTrDrvzCJ7vDYYvxq3gXEVVHT2hwDzvKyZuUwulws6Ryh
	 5uvKZ4NQa7fpc479QBmOR7URF9nE4DJ2jHC/bG++GlKjjUH7svTNUB1iJM2352MyqcGEi
	 Bxrb2YaZ0eqljOdAA31/GncXIp39HGm5NuDke12lkZUQMEbkPUNdyuD8rN/cYlpFzTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Wb/XsqVw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3F606A337
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wb/XsqVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9E51F000C4;
	Fri, 13 Nov 2026 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589039;
	bh=97bNZNx31PrAjIAiuh1JgfC5+2hMiEFsgMfNJrx0wYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wb/XsqVwmeBE/lP5sH8oZynYHl899O7gUBBLrS9+ju+RH3VIIB511GIXO0zltj1xl
	 KptwZcPZNFNETHek5r1qiHAmLv9PXxqKnw3U27T3Dq0jnVh6AifryqV77rUNMgkDp7
	 cmLNRSn1W1kBD8/XVCnc73pjee4hnk7JtOLuSPZev8KojXUYU78ZE4U9j5fi269dmA
	 tHL4Gw/3V3ajtDT5r2v9A3O1HvLDhXIGUH8CrfQ1l1fTzwKph8QBJMj2jiOVIwVFaw
	 gBmdxE1LGKv6QYJfqrI6vPitGIeemtD6a7fx3w9kJPVOJ0nWXp0WEmLVZAZnsikBhU
	 r1O2dUBaTLNxA==
Message-ID: <sashiko-outbox-213255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/21] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-5-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:57:18 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D4

