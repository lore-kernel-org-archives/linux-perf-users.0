Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700887;
	b=yMwjwnsvzAxC8izk4MPQOyBDXfQpt8CS2m6pcyzECbmEMZcxjjeQt9N0BnT6tZujAAPY
	 xSDPQD1RHc/sUJYQs2/nMLWfF9o6+Kdo+Qasyj35U7xSgjbK4/lVxFdK0/DYh+ggvotDd
	 lj3x/jfcN6bl9ak5/4+2dQIR2hpKDIIWWGNCiUbvqMMvk+pxELpk65z9nGDLBDjvG0I+B
	 TPAp0XdLp5/bcOX05hs2+e/kClxChLe4nhIymnxzi3sVadHDZODb+agev8jKO5oHwr/kw
	 46ualL9AX29VMsEvysmviv7IdH+1pnyqUEJRWOLgwYJLsD1GgrxaR7DfYOWu8A5kFfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700887;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yf3hd6WB2rVkBPsg+0oU9/Bl7OBtaqSo7zY2BgFQZZo=;
	b=NZpbX8ndU/21o4HRGXSEt4nJ+fU4uUOlnaTG/yTjw6WtdgOVWPtT4QJNPWvAwTatoYPq
	 Yx+uUKbshxch2wy3feBdsZl+9O9WRwuXHPod0GA+S+Vlpyr6ZnuXQg/WWwxjONon4rUnv
	 ZSCNsYARsPlIDWifKWi211e7qG6ksHaXx6nbDaWxe5dguEtGti9B5JoDT+ugKK+8YxM1z
	 xWXYvhS7kql9a5ofwVB0YU/GqZjMEVKr0QHjqIShPK+pj3lfBjFBTwQGkQucg9X44cJXC
	 anFaZTdxD+jA0RP8L2HWMAhm5vv6SusMFCWY55Bw2ow1sLzRZTon9M/xVwVs61bu6mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E72aQuzi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C1606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E72aQuzi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FA31F01825;
	Thu, 22 Oct 2026 20:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792700886;
	bh=yf3hd6WB2rVkBPsg+0oU9/Bl7OBtaqSo7zY2BgFQZZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E72aQuzidLOxB50GqXjPfQlmXmgXvou3mz9KowdbiGky5BI+GxJ6qnLP9gB+nxS/c
	 7wEgMsygbQaFDwnxrQDKqcZzl7SjxpEYh6IzQONcHFXL2ZsxCkvow7+2EcoqKwpnPo
	 pdeeIl6zf4ucURRr7bA4j4ty7flT0PbEFiebCvVNI3Wl/QOo9o+OYjLA9cMRZmZDzU
	 WxpCXxsZrvtw6FpCF2V77/ASBRJikECO3fbl6Okt+EsRUiEKeZga1+gXeknsXQgOdI
	 mC6aNFn7X/PcVhcQxkhAJ9i6tdRAVpNqluQSBw9feNUPQbbyVb27RGuSQRC8PYl0g1
	 FpgOB45IwRhFw==
Message-ID: <sashiko-outbox-182002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/19] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022201453.1717523-5-irogers@google.com>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
 <20261022201453.1717523-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 20:28:06 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022201453.1717=
523-1-irogers@google.com?part=3D4

