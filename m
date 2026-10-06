Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9293C472F81
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299065; cv=none; b=k2ytf7ConEGjy/sfGsZstf2BfnBXHH9VRZMe5qTsdFbD4sLgjlnT6bwjvfHeG47fAdKJORYk4I18WCny1lbnk557S7/CdsaOPavpwDH38royLH7g29KJAJSOl27dFmz4B8xqSTFszSA+u/a3HERc3adrbU8DY4eNCkWlRNCOH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299065; c=relaxed/simple;
	bh=qC5rM+j1HHkbHtUenG84EN5OARVgA7lSr9Ffl3A5z9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JskbOE7dWKADnHmUl1iL6vL2s6rr2EfZwPEr7c1XLVN9DsQdizW7BovWf3sh9VggutvFBc6igys7owFdqFrD+mfHFRG/WzdU59Ls5c1y2hoTtDsY5yhoDxze0IikOnjdBz0XWAnUMAPxqzzIJRi4D/KpJYosHWukRNtr2luB/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADlCTQo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADlCTQo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DE01F0089B;
	Tue,  6 Oct 2026 15:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791299064;
	bh=qC5rM+j1HHkbHtUenG84EN5OARVgA7lSr9Ffl3A5z9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ADlCTQo1lIO8vp18KVYny5QOUtIie9A4YyFmF0LnsR0Gp1Ymez80J4ztaaT41OKaQ
	 3opLMvs+v9hRpf/QQL6nM36ztVtN0wPXjNFD4nYwCugt2IEkfc25rHvGPDqfX/X/7R
	 uMxBH5eyGYktFnaTYBJPer6/h03SLaRLnFOLtaz+itvH1G7krIEJ3YPleJy1yTko/x
	 +7fjeiZ+kRGNMK77eXL9YiUK4PkR8iKgR1pbNLnNkrkEHM5VdtBwgyYaYVHKcUv4h+
	 pXI0ET7KkbVRGK+i8UvPKtjiu2xdxYlHxhHBHs50h6Kueo8dZADqtPR8xtR3NDaOCe
	 7MXLoNgxrb/5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] perf mutex: Add DO_ONCE() for one-time
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006145729.3028247-5-acme@kernel.org>
References: <20261006145729.3028247-1-acme@kernel.org>
 <20261006145729.3028247-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:04:23 +0000
Message-Id: <20261006150424.14DE01F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> For lazy init that more than one thread can race into, without
> pthread_once() so that it stays within perf's locking primitives and
> clang's -Wthread-safety keeps an eye on the mutexes involved.
>=20
> Mirrors the kernel's include/linux/once.h DO_ONCE(), dropping its
> static key fast path, unnecessary at these cold init paths: a per call
> site static bool plus a statically initialized mutex, double checked.
> As there, code reachable from more than one call site must go through
> a common helper.
>=20
> The lockless fast path reads ___done with an acquire, paired with a
> release store after fn(), so that fn()'s side effects are visible to
> threads taking the fast path, which the dropped static key used to
> guarantee.
>=20
> The __atomic builtins are used rather than smp_load_acquire()/
> smp_store_release() because ThreadSanitizer understands them,
> avoiding reports on ___done and on what fn() initialized.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006145729.3028=
247-1-acme@kernel.org?part=3D4

